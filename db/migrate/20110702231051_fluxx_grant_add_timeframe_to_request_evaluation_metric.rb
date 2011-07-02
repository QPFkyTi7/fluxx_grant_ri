class FluxxGrantAddTimeframeToRequestEvaluationMetric < ActiveRecord::Migration
  def self.up
    add_column :request_evaluation_metrics, :timeframe, :string
  end

  def self.down
    remove_column :request_evaluation_metrics, :timeframe
  end
end