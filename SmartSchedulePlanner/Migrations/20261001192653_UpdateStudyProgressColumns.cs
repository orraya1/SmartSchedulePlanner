using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SmartSchedulePlanner.Migrations
{
    /// <inheritdoc />
    public partial class UpdateStudyProgressColumns : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CompletedAt",
                table: "StudyProgresses");

            migrationBuilder.DropColumn(
                name: "Status",
                table: "StudyProgresses");

            migrationBuilder.DropColumn(
                name: "ActualMinutes",
                table: "StudyProgresses");

            migrationBuilder.AlterColumn<string>(
                name: "Note",
                table: "StudyProgresses",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsCompleted",
                table: "StudyProgresses",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<int>(
                name: "ProgressPercent",
                table: "StudyProgresses",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<DateTime>(
                name: "UpdatedAt",
                table: "StudyProgresses",
                type: "datetime2",
                nullable: false,
                defaultValueSql: "GETDATE()");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsCompleted",
                table: "StudyProgresses");

            migrationBuilder.DropColumn(
                name: "UpdatedAt",
                table: "StudyProgresses");

            migrationBuilder.RenameColumn(
                name: "ProgressPercent",
                table: "StudyProgresses",
                newName: "ActualMinutes");

            migrationBuilder.AlterColumn<string>(
                name: "Note",
                table: "StudyProgresses",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(500)",
                oldMaxLength: 500,
                oldNullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "CompletedAt",
                table: "StudyProgresses",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Status",
                table: "StudyProgresses",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }
    }
}
