Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393E324200F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 21:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHKTD0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 15:03:26 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52059 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgHKTDY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 15:03:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597172604; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=HljQQp33frmN6u0YNBwroLG0IWIVB8zjZKCZzfIJiAM=; b=JtAs6GLil84z4ItNdtSk5AbZjckAWa3+Tc8+XvYAQdj0gbqsA3e9k+vtN4LNUYFKpW52CVp3
 AlNfs+LWOMix/8ZVx554SiQWHrAg9e82/ammsThunsGUB3jhou6I7cpwU3+tkTeJ+FH4ew9y
 vggR19TGqK5+CuaU+RwltG0gw6k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f32eb75440a07969ac3ce68 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Aug 2020 19:03:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E616BC4339C; Tue, 11 Aug 2020 19:03:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F7DCC433C6;
        Tue, 11 Aug 2020 19:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F7DCC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, pavel@ucw.cz, len.brown@intel.com,
        rnayak@codeaurora.org, dianders@chromium.org, khilman@kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/2] PM / Domains: Add GENPD_FLAG_SUSPEND_ON flag
Date:   Wed, 12 Aug 2020 00:32:51 +0530
Message-Id: <20200811190252.10559-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is for power domains which needs to stay powered on for suspend
but can be powered on/off as part of runtime PM. This flag is aimed at
power domains coupled to remote processors which enter suspend states
independent to that of the application processor. Such power domains
are turned off only on remote processor crash/shutdown.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/base/power/domain.c | 3 ++-
 include/linux/pm_domain.h   | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2cb5e04cf86cd..ba78ac4a450d4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -129,6 +129,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
+#define genpd_is_suspend_on(genpd)	(genpd->flags & GENPD_FLAG_SUSPEND_ON)
 
 static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -949,7 +950,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 {
 	struct gpd_link *link;
 
-	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
+	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd) || genpd_is_suspend_on(genpd))
 		return;
 
 	if (genpd->suspended_count != genpd->device_count
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ee11502a575b0..3002a2d68936a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -55,6 +55,10 @@
  *
  * GENPD_FLAG_RPM_ALWAYS_ON:	Instructs genpd to always keep the PM domain
  *				powered on except for system suspend.
+ *
+ * GENPD_FLAG_SUSPEND_ON:	Instructs genpd to keep the PM domain powered
+ *				on during suspend and runtime PM controlled
+ *				otherwise.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -62,6 +66,7 @@
 #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
 #define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
+#define GENPD_FLAG_SUSPEND_ON	 (1U << 6)
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

