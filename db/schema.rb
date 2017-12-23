# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171223015343) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "accountable_type"
    t.bigint "accountable_id"
    t.index ["accountable_type", "accountable_id"], name: "index_accounts_on_accountable_type_and_accountable_id"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["invitation_token"], name: "index_accounts_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_accounts_on_invitations_count"
    t.index ["invited_by_id"], name: "index_accounts_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_accounts_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "exam_questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "exam_id", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grades", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "high_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "game"
    t.integer "score"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "subject_id", null: false
    t.string "title", null: false
    t.text "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_questions_on_subject_id"
  end

  create_table "student_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "student_id", null: false
    t.integer "exam_question_id"
    t.float "uni_gram_weight", limit: 24
    t.float "bi_gram_weight", limit: 24
    t.float "tri_gram_weight", limit: 24
    t.string "score"
    t.float "quality", limit: 24
    t.text "response", null: false
    t.float "teacher_score", limit: 24, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_student_answers_on_student_id"
  end

  create_table "student_exam_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "student_id", null: false
    t.integer "exam_id", null: false
    t.string "score"
    t.float "quality", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "account_id"
    t.integer "grade_id", null: false
    t.string "name", null: false
    t.string "gender", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_id"], name: "index_students_on_grade_id"
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "teacher_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_subjects_on_teacher_id"
  end

  create_table "teachers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "account_id"
    t.string "name", null: false
    t.string "gender", null: false
    t.string "email", null: false
    t.string "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
