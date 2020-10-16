Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4971F29097F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 18:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409837AbgJPQQU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 12:16:20 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:41852 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409913AbgJPQQU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Oct 2020 12:16:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602864979; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=cNo/m9caBnx/dcHtIvvDESgSyJ2dDDvT47/EEbF5F0I=; b=nSIZrVIEMuArWZdfoeGR+TjKmhDMfvWadDYghY/dRt2MA+wovw52UEoVAY6717BJFZpD53Vr
 baksYOwqyhKz2gQn9cvsawMvqzqN0zciqjGykFCT/HASeY4GN+YK15cZMI3xXZ9UdH7o8IA2
 zZ8fUM1LiIulH0u5oGhpwab7A8k=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f89c752856d9308b5e7cb87 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 16:16:18
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63BAEC433FF; Fri, 16 Oct 2020 16:16:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 290B5C433FF;
        Fri, 16 Oct 2020 16:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 290B5C433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v4] PM / Domains: enable domain idle state accounting
Date:   Fri, 16 Oct 2020 10:16:00 -0600
Message-Id: <20201016161600.26196-1-ilina@codeaurora.org>
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
Changes in v4:
	- Rebase on top of bleeding-edge
---
 drivers/base/power/domain.c | 10 +++++++---
 include/linux/pm_domain.h   |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 05bb4d4401b2..9c9a1d5fb07a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -550,11 +550,14 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 		return -EBUSY;
 
 	ret = _genpd_power_off(genpd, true);
-	if (ret)
+	if (ret) {
+		genpd->states[genpd->state_idx].rejected++;
 		return ret;
+	}
 
 	genpd->status = GENPD_STATE_OFF;
 	genpd_update_accounting(genpd);
+	genpd->states[genpd->state_idx].usage++;
 
 	list_for_each_entry(link, &genpd->child_links, child_node) {
 		genpd_sd_counter_dec(link->parent);
@@ -2923,7 +2926,7 @@ static int idle_states_show(struct seq_file *s, void *data)
 	if (ret)
 		return -ERESTARTSYS;
 
-	seq_puts(s, "State          Time Spent(ms)\n");
+	seq_puts(s, "State          Time Spent(ms) Usage          Rejected\n");
 
 	for (i = 0; i < genpd->state_count; i++) {
 		ktime_t delta = 0;
@@ -2935,7 +2938,8 @@ static int idle_states_show(struct seq_file *s, void *data)
 
 		msecs = ktime_to_ms(
 			ktime_add(genpd->states[i].idle_time, delta));
-		seq_printf(s, "S%-13i %lld\n", i, msecs);
+		seq_printf(s, "S%-13i %-14lld %-14llu %llu\n", i, msecs,
+			      genpd->states[i].usage, genpd->states[i].rejected);
 	}
 
 	genpd_unlock(genpd);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 66f3c5d64d81..fb28320b1def 100644
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

