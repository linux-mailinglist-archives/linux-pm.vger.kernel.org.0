Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE291FCA0B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 11:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgFQJoG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 05:44:06 -0400
Received: from foss.arm.com ([217.140.110.172]:54442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgFQJoF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jun 2020 05:44:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6956431B;
        Wed, 17 Jun 2020 02:44:04 -0700 (PDT)
Received: from ubuntu.arm.com (unknown [10.57.54.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CE393F6CF;
        Wed, 17 Jun 2020 02:44:02 -0700 (PDT)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com
Subject: [PATCH 1/2] firmware: arm_scmi: Add fast_switch_possible() api
Date:   Wed, 17 Jun 2020 10:43:31 +0100
Message-Id: <20200617094332.8391-1-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a new fast_switch_possible interface to the existing
perf_ops api to export the information of whether or not
fast_switch is possible in this driver.

This can be used by the CPUFreq driver and framework to
choose proper mechanism for frequency change.

Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 12 ++++++++++++
 include/linux/scmi_protocol.h    |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index eadc171e254b..ef747a9bb948 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -697,6 +697,17 @@ static int scmi_dvfs_est_power_get(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
+static bool scmi_fast_switch_possible(const struct scmi_handle *handle,
+				   struct device *dev)
+{
+	struct perf_dom_info *dom;
+	struct scmi_perf_info *pi = handle->perf_priv;
+
+	dom = pi->dom_info + scmi_dev_domain_id(dev);
+
+	return (dom->fc_info && dom->fc_info->level_set_addr);
+}
+
 static struct scmi_perf_ops perf_ops = {
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
@@ -708,6 +719,7 @@ static struct scmi_perf_ops perf_ops = {
 	.freq_set = scmi_dvfs_freq_set,
 	.freq_get = scmi_dvfs_freq_get,
 	.est_power_get = scmi_dvfs_est_power_get,
+	.fast_switch_possible = scmi_fast_switch_possible,
 };
 
 static int scmi_perf_protocol_init(struct scmi_handle *handle)
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index ce2f5c28b2df..19e50b89117e 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -118,6 +118,8 @@ struct scmi_perf_ops {
 			unsigned long *rate, bool poll);
 	int (*est_power_get)(const struct scmi_handle *handle, u32 domain,
 			     unsigned long *rate, unsigned long *power);
+	bool (*fast_switch_possible)(const struct scmi_handle *handle,
+			struct device *dev);
 };
 
 /**
-- 
2.27.0

