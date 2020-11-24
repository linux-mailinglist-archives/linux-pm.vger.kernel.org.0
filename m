Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD652C232C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 11:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbgKXKoJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 05:44:09 -0500
Received: from foss.arm.com ([217.140.110.172]:53214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731695AbgKXKoI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 05:44:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CCAD1396;
        Tue, 24 Nov 2020 02:44:08 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.29.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94D163F71F;
        Tue, 24 Nov 2020 02:44:05 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, Dietmar.Eggemann@arm.com,
        cristian.marussi@arm.com, morten.rasmussen@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org
Subject: [PATCH 1/2] firmware: arm_scmi: Add power_scale_mw_get() interface
Date:   Tue, 24 Nov 2020 10:43:45 +0000
Message-Id: <20201124104346.27167-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124104346.27167-1-lukasz.luba@arm.com>
References: <20201124104346.27167-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a new interface to the existing perf_ops and export the information
about the power values scale.

This would be used by the cpufreq driver and Energy Model framework to
set the performance domains scale: milli-Watts or abstract scale.

Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 8 ++++++++
 include/linux/scmi_protocol.h    | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 82fb3babff72..e374b1125fca 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -750,6 +750,13 @@ static bool scmi_fast_switch_possible(const struct scmi_handle *handle,
 	return dom->fc_info && dom->fc_info->level_set_addr;
 }
 
+static bool scmi_power_scale_mw_get(const struct scmi_handle *handle)
+{
+	struct scmi_perf_info *pi = handle->perf_priv;
+
+	return pi->power_scale_mw;
+}
+
 static const struct scmi_perf_ops perf_ops = {
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
@@ -762,6 +769,7 @@ static const struct scmi_perf_ops perf_ops = {
 	.freq_get = scmi_dvfs_freq_get,
 	.est_power_get = scmi_dvfs_est_power_get,
 	.fast_switch_possible = scmi_fast_switch_possible,
+	.power_scale_mw_get = scmi_power_scale_mw_get,
 };
 
 static int scmi_perf_set_notify_enabled(const struct scmi_handle *handle,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index dd9e94849fc1..ecb3aad1a964 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -122,6 +122,7 @@ struct scmi_perf_ops {
 			     unsigned long *rate, unsigned long *power);
 	bool (*fast_switch_possible)(const struct scmi_handle *handle,
 				     struct device *dev);
+	bool (*power_scale_mw_get)(const struct scmi_handle *handle);
 };
 
 /**
-- 
2.17.1

