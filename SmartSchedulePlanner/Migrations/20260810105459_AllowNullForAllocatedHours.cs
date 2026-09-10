using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SmartSchedulePlanner.Migrations
{
    /// <inheritdoc />
    public partial class AllowNullForAllocatedHours : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Difficulty",
                table: "ActivitySubjects");

            migrationBuilder.DropColumn(
                name: "IsRequired",
                table: "ActivitySubjects");

            migrationBuilder.DropColumn(
                name: "Priority",
                table: "ActivitySubjects");

            migrationBuilder.AlterColumn<int>(
                name: "AllocatedHours",
                table: "ActivitySubjects",
                type: "int",
                nullable: true,
                oldClrType: typeof(double),
                oldType: "float");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<double>(
                name: "AllocatedHours",
                table: "ActivitySubjects",
                type: "float",
                nullable: false,
                defaultValue: 0.0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Difficulty",
                table: "ActivitySubjects",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<bool>(
                name: "IsRequired",
                table: "ActivitySubjects",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<int>(
                name: "Priority",
                table: "ActivitySubjects",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}
