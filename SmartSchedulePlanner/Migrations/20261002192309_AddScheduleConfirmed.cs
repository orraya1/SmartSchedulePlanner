using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SmartSchedulePlanner.Migrations
{
    /// <inheritdoc />
    public partial class AddScheduleConfirmed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsScheduleConfirmed",
                table: "Activities",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.CreateIndex(
                name: "IX_Schedules_StudyActivityId",
                table: "Schedules",
                column: "StudyActivityId");

            migrationBuilder.AddForeignKey(
                name: "FK_Schedules_Activities_StudyActivityId",
                table: "Schedules",
                column: "StudyActivityId",
                principalTable: "Activities",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Schedules_Activities_StudyActivityId",
                table: "Schedules");

            migrationBuilder.DropIndex(
                name: "IX_Schedules_StudyActivityId",
                table: "Schedules");

            migrationBuilder.DropColumn(
                name: "IsScheduleConfirmed",
                table: "Activities");
        }
    }
}
