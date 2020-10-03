Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2483428253C
	for <lists+linux-pm@lfdr.de>; Sat,  3 Oct 2020 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJCP42 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Oct 2020 11:56:28 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:51625 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgJCP41 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 3 Oct 2020 11:56:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601740587; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=sOzZ7QQveQy/hthcA+sfTSNINPiRH3EjweaG2282X3w=; b=BSTiR8bdUaK3X3erPsbEhJz3r9ocK2hkOH1niSUr+mw95iMbtyPHfHCDDRG43Z8fCf9XF/tK
 PE0fx4M1WDSCLPI25k+ZE+S3+iysqUI4svp6oeNc23RW6CKi+94qaL34gPpEnmOMoE8r/UHz
 VbwVm1DqdSX9bJ9i8CaEe4i5bt0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f789f2a3711fec7b147f167 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 03 Oct 2020 15:56:26
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31ACFC433FE; Sat,  3 Oct 2020 15:56:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D87DDC433F1;
        Sat,  3 Oct 2020 15:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D87DDC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2] PM / Domains: enable domain idle state accounting
Date:   Sat,  3 Oct 2020 09:56:18 -0600
Message-Id: <20201003155618.11997-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To enable better debug of PM domains, let's keep a track of the success
and rejections in entering each domain idle state.

This statistics is exported in debugfs when reading the idle_states
node, associated with each PM domain.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v2:
	- Renamed 'failed' to 'rejected'

This patch depends-on: https://lkml.org/lkml/2020/9/24/465
---
 drivers/base/power/domain.c | 7 +++++--
 include/linux/pm_domain.h   | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f001ac6326fb..dbe89454f594 100644
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
+	genpd->states[genpd->state_idx].rejected++;
 	if (nr_calls)
 		__raw_notifier_call_chain(&genpd->power_notifiers,
 					  GENPD_STATE_ON, NULL,
@@ -3053,7 +3055,7 @@ static int idle_states_show(struct seq_file *s, void *data)
 	if (ret)
 		return -ERESTARTSYS;
 
-	seq_puts(s, "State          Time Spent(ms)\n");
+	seq_puts(s, "State          Time Spent(ms) Usage          Rejected\n");
 
 	for (i = 0; i < genpd->state_count; i++) {
 		ktime_t delta = 0;
@@ -3065,7 +3067,8 @@ static int idle_states_show(struct seq_file *s, void *data)
 
 		msecs = ktime_to_ms(
 			ktime_add(genpd->states[i].idle_time, delta));
-		seq_printf(s, "S%-13i %lld\n", i, msecs);
+		seq_printf(s, "S%-13i %-14lld %-14llu %llu\n", i, msecs,
+			      genpd->states[i].usage, genpd->states[i].rejected);
 	}
 
 	genpd_unlock(genpd);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 3b2b561ce846..239647f2d27f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -82,6 +82,8 @@ struct genpd_power_state {
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
 	s64 residency_ns;
+	u64 usage;
+	u64 rejected;
 	struct fwnode_handle *fwnode;
 	ktime_t idle_time;
 	void *data;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

