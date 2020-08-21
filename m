Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D2624E245
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 22:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHUUtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 16:49:50 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:55184 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbgHUUto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 16:49:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598042983; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=ALqZgq9ZtnQonj8cTUH/j06ZhhOBH6qr1BwztPuJkc4=; b=uUPFDmFNOXtQW5DAyxeq7eVnaTwJ7DSybxqe/GrAApy+4UYgMcjApQfRA1wjpZQlbKIxSiUe
 IX8GKwmT3VBFqEE7IHeHoC6O6O77/6QoGU+5otQwTLdtd8FMEfrHYmjvFz2OwNB+PqDiMeFb
 6utHoKWWWkDz+fDoC1IsFy9qQxk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f40336291f122588b1f5770 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 Aug 2020 20:49:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C85EC433AF; Fri, 21 Aug 2020 20:49:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1AF42C433CA;
        Fri, 21 Aug 2020 20:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AF42C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        khilman@kernel.org, swboyd@chromium.org
Cc:     rjw@rjwysocki.net, agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, pavel@ucw.cz, len.brown@intel.com,
        rnayak@codeaurora.org, dianders@chromium.org, mka@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME flags
Date:   Sat, 22 Aug 2020 02:19:20 +0530
Message-Id: <20200821204921.32536-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add GENPD_FLAG_NO_SUSPEND/RESUME flags to instruct genpd to keep the
status of the PM domain unaltered during suspend/resume respectively.
The flags are aimed at power domains coupled to co-processors which
enter low-power modes independent to that of the application processor.

Specifically the flags are to be used by the power domains exposed
by the AOSS QMP driver linked to modem, adsp, cdsp remoteprocs. These
power domains are used to notify the Always on Subsystem (AOSS) that
a particular co-processor is up. AOSS uses this information to wait
for the co-processors to suspend before starting its sleep sequence.
The application processor powers off these power domains only if the
co-processor has crashed or powered off and remains unaltered during
system suspend/resume.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

V2:
 * Add more info in commit msg and description [Uffe/Kevin/Stephen]
 * Rename and split functionality into two flags [Uffe]
 * Drop R-b/T-b

 drivers/base/power/domain.c |  6 ++++--
 include/linux/pm_domain.h   | 10 ++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2cb5e04cf86cd..a5df5916f30f8 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -129,6 +129,8 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
+#define genpd_is_no_suspend(genpd)	(genpd->flags & GENPD_FLAG_NO_SUSPEND)
+#define genpd_is_no_resume(genpd)	(genpd->flags & GENPD_FLAG_NO_RESUME)
 
 static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -949,7 +951,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 {
 	struct gpd_link *link;
 
-	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
+	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd) || genpd_is_no_suspend(genpd))
 		return;
 
 	if (genpd->suspended_count != genpd->device_count
@@ -991,7 +993,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 {
 	struct gpd_link *link;
 
-	if (genpd_status_on(genpd))
+	if (genpd_status_on(genpd) || genpd_is_no_resume(genpd))
 		return;
 
 	list_for_each_entry(link, &genpd->child_links, child_node) {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ee11502a575b0..568abdf2e89cf 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -55,6 +55,14 @@
  *
  * GENPD_FLAG_RPM_ALWAYS_ON:	Instructs genpd to always keep the PM domain
  *				powered on except for system suspend.
+ *
+ * GENPD_FLAG_NO_SUSPEND:	Instructs genpd to keep the PM domain powered
+ *				on during suspend (if it's already powered on)
+ *				and runtime PM controlled otherwise.
+ *
+ * GENPD_FLAG_NO_RESUME:	Instructs genpd to keep the PM domain powered
+ *				off during resume (if it's already powered off)
+ *				and runtime PM controlled otherwise.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -62,6 +70,8 @@
 #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
 #define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
+#define GENPD_FLAG_NO_SUSPEND	 (1U << 6)
+#define GENPD_FLAG_NO_RESUME	 (1U << 7)
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

