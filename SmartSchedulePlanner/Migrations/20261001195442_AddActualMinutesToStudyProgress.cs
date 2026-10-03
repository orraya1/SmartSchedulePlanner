using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SmartSchedulePlanner.Migrations
{
    /// <inheritdoc />
    public partial class AddActualMinutesToStudyProgress : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ActualMinutes",
                table: "StudyProgresses",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ActualMinutes",
                table: "StudyProgresses");
        }
    }
}
