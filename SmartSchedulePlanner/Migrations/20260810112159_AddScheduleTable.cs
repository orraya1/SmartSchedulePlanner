using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SmartSchedulePlanner.Migrations
{
    /// <inheritdoc />
    public partial class AddScheduleTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "SubjectId",
                table: "Schedules",
                newName: "StudyActivityId");

            migrationBuilder.RenameColumn(
                name: "Status",
                table: "Schedules",
                newName: "SubjectName");

            migrationBuilder.RenameColumn(
                name: "Date",
                table: "Schedules",
                newName: "StudyDate");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "SubjectName",
                table: "Schedules",
                newName: "Status");

            migrationBuilder.RenameColumn(
                name: "StudyDate",
                table: "Schedules",
                newName: "Date");

            migrationBuilder.RenameColumn(
                name: "StudyActivityId",
                table: "Schedules",
                newName: "SubjectId");
        }
    }
}
