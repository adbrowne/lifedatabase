package net.lifedatabase.dbserver

import cats.Applicative
import cats.implicits.catsSyntaxApplicativeId
import io.circe.{Encoder, Json}
import org.http4s.EntityEncoder
import org.http4s.circe.jsonEncoderOf

trait EventStore[F[_]]{
  def add(n: EventStore.EventToAdd): F[EventStore.AddEventResult]
}

object EventStore {
  final case class EventToAdd(stream: String, index: Int)
  final case class AddEventResult(message: String) extends AnyVal

  object AddEventResult {
    implicit val addEventResultEncoder: Encoder[AddEventResult] = new Encoder[AddEventResult] {
      final def apply(a: AddEventResult): Json = Json.obj(
        ("message", Json.fromString(a.message)),
      )
    }
    implicit def addEventResultEntityEncoder[F[_]]: EntityEncoder[F, AddEventResult] =
      jsonEncoderOf[F, AddEventResult]
  }

  import software.amazon.awssdk.regions.Region
  import software.amazon.awssdk.services.dynamodb.DynamoDbClient

  val region: Region = Region.AP_SOUTHEAST_2
  val ddb: DynamoDbClient = DynamoDbClient.builder.region(region).build

  def impl[F[_]: Applicative]: EventStore[F] = new EventStore[F]{

    val tableName: String = "event_store_1"

    def add(n: EventStore.EventToAdd): F[EventStore.AddEventResult] =
      {
        import java.util

        import software.amazon.awssdk.services.dynamodb.model.{AttributeValue, DynamoDbException, PutItemRequest, ResourceNotFoundException}
        val itemValues = new util.HashMap[String, AttributeValue]

        // Add all content to the table
        itemValues.put("stream", AttributeValue.builder.s("foo").build)
        itemValues.put("index", AttributeValue.builder.n("0").build)

        val request = PutItemRequest.builder.tableName(tableName).item(itemValues).build

        try {
          ddb.putItem(request)
          AddEventResult("Ok").pure[F]
        } catch {
          case _: ResourceNotFoundException =>
            AddEventResult("Bad").pure[F]
          case _: DynamoDbException =>
            AddEventResult("Bad").pure[F]
        }
      }

  }
}


