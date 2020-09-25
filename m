Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517EB277E14
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 04:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgIYCmH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 22:42:07 -0400
Received: from z5.mailgun.us ([104.130.96.5]:20060 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYCmH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 22:42:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601001727; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=y7fI+APl+kknuQGXkIJNbI8EDAA7HBgAfsFwX6pZaKA=; b=i02sZQ5MCRgX6CVq7/relfybThLokMfuq3dzRAHo/MhmC1zIc15Vw71+mCLv+DcNgQ0X1m6a
 T80E2pd4x0zDUp195UZ5nbaRnGdiPOa+CzJEgBP0kYynNxe9C6MqUOJuKsCB5rYPUgeC22Oc
 kC+mBTMk7i2Z5I/OhtZYUWfHSKk=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f6d58feebb17452ba56ada1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Sep 2020 02:42:06
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EAC77C433C8; Fri, 25 Sep 2020 02:42:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8AD34C433CB;
        Fri, 25 Sep 2020 02:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AD34C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC] PM / Domains: enable domain idle state accounting
Date:   Thu, 24 Sep 2020 20:42:00 -0600
Message-Id: <20200925024200.6429-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To enable better debug of PM domains, let's keep a track of the success
and failures in entering each domain idle state.

This statistics is exported in debugfs when reading the idle_states
node, associated with each PM domain.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>

---
This patch depends-on: https://lkml.org/lkml/2020/9/24/465
---
 drivers/base/power/domain.c | 7 +++++--
 include/linux/pm_domain.h   | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f001ac6326fb..ba3355f935da 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -564,6 +564,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 
 	genpd->status = GENPD_STATE_OFF;
 	genpd_update_accounting(genpd);
+	genpd->states[genpd->state_idx].usage++;
 
 	list_for_each_entry(link, &genpd->child_links, child_node) {
 		genpd_sd_counter_dec(link->parent);
@@ -574,6 +575,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 
 	return 0;
 busy:
+	genpd->states[genpd->state_idx].failed++;
 	if (nr_calls)
 		__raw_notifier_call_chain(&genpd->power_notifiers,
 					  GENPD_STATE_ON, NULL,
@@ -3053,7 +3055,7 @@ static int idle_states_show(struct seq_file *s, void *data)
 	if (ret)
 		return -ERESTARTSYS;
 
-	seq_puts(s, "State          Time Spent(ms)\n");
+	seq_puts(s, "State          Time Spent(ms) Usage          Failed\n");
 
 	for (i = 0; i < genpd->state_count; i++) {
 		ktime_t delta = 0;
@@ -3065,7 +3067,8 @@ static int idle_states_show(struct seq_file *s, void *data)
 
 		msecs = ktime_to_ms(
 			ktime_add(genpd->states[i].idle_time, delta));
-		seq_printf(s, "S%-13i %lld\n", i, msecs);
+		seq_printf(s, "S%-13i %-14lld %-14llu %llu\n", i, msecs,
+			      genpd->states[i].usage, genpd->states[i].failed);
 	}
 
 	genpd_unlock(genpd);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 3b2b561ce846..c30994ec0cec 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -82,6 +82,8 @@ struct genpd_power_state {
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
 	s64 residency_ns;
+	u64 usage;
+	u64 failed;
 	struct fwnode_handle *fwnode;
 	ktime_t idle_time;
 	void *data;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

