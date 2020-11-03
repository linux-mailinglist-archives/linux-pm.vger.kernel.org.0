Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AAF2A48FE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgKCPHo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgKCPGm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 10:06:42 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD4FC0613D1
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 07:06:41 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l28so22571603lfp.10
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ueiVlvCkRERA4jFBXY1LOeFsJ+G2JGqDIygbStmt2x4=;
        b=bhgffm5oQBW+6fiSHYCs6cMG+QkEaPHFd8ayqp4qY5zdtYkfBN2A+kFDYhKWnmfXzC
         j31r1S3NxiL6kuZsmKzUYk3FcmMlgywkkt8fF5kDxv0SV8wOTLMywc9VNNorK9LWJbdY
         c0jaEBrXboRtNdLTy2dEGzEl5e95vlr7fOWCbiREMddju+X5bn7IIePh1uxU2R01scl5
         Vtqvr6G3wMJPKZWQG4Vm6V5zPfQXKqWrs2bMn3vqRN6Xbh6KEfiZXqyBxcpJ08QUjLYt
         BQhwZ1okgi1J9Cn3QOOVooDMLTvpRiX52jRnjz2T3hlha2XPCUFAsKXH1QyhVIfpEn3o
         keMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ueiVlvCkRERA4jFBXY1LOeFsJ+G2JGqDIygbStmt2x4=;
        b=iX06mYNVZFsTRBlHG8W8jfU2EgHBoTSpvLPd3kqico+sKJo3ScD2Cj8lHMHpDvw4a/
         sh3X6/8jnTJM+ZKb46ts2eyJLw4xJeedZIBtERQgzF37AeFghRkJPAG5lgjPPwDFYQ45
         A3puAyYfq4zJ3s/GaUn+RWCJBwLBxRyzKQdSm//YJ6Hq6VcDy+87Vmyuax0tmN9lK44S
         AVvV5ctSiulygQIvVUR+1nOf5vRqXk9+BMGofMG0z5Kj1vcnVpIpLXntbLah97tmWdnZ
         2eYZRbngWga79ownFyL2Lzi7GT200DCr/zzclaq5Jgf4effb0zYX5fHkBrAwF9USU5Z/
         rokQ==
X-Gm-Message-State: AOAM531sLiXBQsb4MZr/k+1Spz1PNLjpnxhCmHugxiQGnXAnCBBNfL6w
        YBOkP+4Vb9PNlIQAHBU/apDLDQ==
X-Google-Smtp-Source: ABdhPJzvL548jIVHWEK3wkLNGd36Uico9ujbUgT1crbH/MUPdlT1HtTLICOjJpYtlqeLXhhVMoqNnQ==
X-Received: by 2002:a19:7e85:: with SMTP id z127mr4717457lfc.493.1604415998774;
        Tue, 03 Nov 2020 07:06:38 -0800 (PST)
Received: from localhost.localdomain (h-155-4-131-134.NA.cust.bahnhof.se. [155.4.131.134])
        by smtp.gmail.com with ESMTPSA id a25sm3522169lfo.141.2020.11.03.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:06:36 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 1/3] PM: domains: Rename pm_genpd_syscore_poweroff|poweron()
Date:   Tue,  3 Nov 2020 16:06:25 +0100
Message-Id: <20201103150627.233438-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103150627.233438-1-ulf.hansson@linaro.org>
References: <20201103150627.233438-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To better describe what the pm_genpd_syscore_poweroff|poweron() functions
actually do, let's rename them to dev_pm_genpd_suspend|resume() and update
the rather few callers of them accordingly (a couple of clocksource
drivers).

Moreover, let's take the opportunity to add some documentation of these
exported functions, as that is currently missing.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- New patch.

---
 drivers/base/power/domain.c   | 35 +++++++++++++++++++++--------------
 drivers/clocksource/sh_cmt.c  |  8 ++++----
 drivers/clocksource/sh_mtu2.c |  4 ++--
 drivers/clocksource/sh_tmu.c  |  8 ++++----
 include/linux/pm_domain.h     |  8 ++++----
 5 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 743268996336..9b4881b67683 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1363,14 +1363,7 @@ static void genpd_complete(struct device *dev)
 	genpd_unlock(genpd);
 }
 
-/**
- * genpd_syscore_switch - Switch power during system core suspend or resume.
- * @dev: Device that normally is marked as "always on" to switch power for.
- *
- * This routine may only be called during the system core (syscore) suspend or
- * resume phase for devices whose "always on" flags are set.
- */
-static void genpd_syscore_switch(struct device *dev, bool suspend)
+static void genpd_switch_state(struct device *dev, bool suspend)
 {
 	struct generic_pm_domain *genpd;
 
@@ -1387,17 +1380,31 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
 	}
 }
 
-void pm_genpd_syscore_poweroff(struct device *dev)
+/**
+ * dev_pm_genpd_suspend - Synchronously try to suspend the genpd for @dev
+ * @dev: The device that is attached to the genpd, that can be suspended.
+ *
+ * This routine should typically be called for a device that needs to be
+ * suspended during the syscore suspend phase.
+ */
+void dev_pm_genpd_suspend(struct device *dev)
 {
-	genpd_syscore_switch(dev, true);
+	genpd_switch_state(dev, true);
 }
-EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweroff);
+EXPORT_SYMBOL_GPL(dev_pm_genpd_suspend);
 
-void pm_genpd_syscore_poweron(struct device *dev)
+/**
+ * dev_pm_genpd_resume - Synchronously try to resume the genpd for @dev
+ * @dev: The device that is attached to the genpd, which needs to be resumed.
+ *
+ * This routine should typically be called for a device that needs to be resumed
+ * during the syscore resume phase.
+ */
+void dev_pm_genpd_resume(struct device *dev)
 {
-	genpd_syscore_switch(dev, false);
+	genpd_switch_state(dev, false);
 }
-EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
+EXPORT_SYMBOL_GPL(dev_pm_genpd_resume);
 
 #else /* !CONFIG_PM_SLEEP */
 
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 760777458a90..7275d95de435 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -658,7 +658,7 @@ static void sh_cmt_clocksource_suspend(struct clocksource *cs)
 		return;
 
 	sh_cmt_stop(ch, FLAG_CLOCKSOURCE);
-	pm_genpd_syscore_poweroff(&ch->cmt->pdev->dev);
+	dev_pm_genpd_suspend(&ch->cmt->pdev->dev);
 }
 
 static void sh_cmt_clocksource_resume(struct clocksource *cs)
@@ -668,7 +668,7 @@ static void sh_cmt_clocksource_resume(struct clocksource *cs)
 	if (!ch->cs_enabled)
 		return;
 
-	pm_genpd_syscore_poweron(&ch->cmt->pdev->dev);
+	dev_pm_genpd_resume(&ch->cmt->pdev->dev);
 	sh_cmt_start(ch, FLAG_CLOCKSOURCE);
 }
 
@@ -760,7 +760,7 @@ static void sh_cmt_clock_event_suspend(struct clock_event_device *ced)
 {
 	struct sh_cmt_channel *ch = ced_to_sh_cmt(ced);
 
-	pm_genpd_syscore_poweroff(&ch->cmt->pdev->dev);
+	dev_pm_genpd_suspend(&ch->cmt->pdev->dev);
 	clk_unprepare(ch->cmt->clk);
 }
 
@@ -769,7 +769,7 @@ static void sh_cmt_clock_event_resume(struct clock_event_device *ced)
 	struct sh_cmt_channel *ch = ced_to_sh_cmt(ced);
 
 	clk_prepare(ch->cmt->clk);
-	pm_genpd_syscore_poweron(&ch->cmt->pdev->dev);
+	dev_pm_genpd_resume(&ch->cmt->pdev->dev);
 }
 
 static int sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index bfccb31e94ad..169a1fccc497 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -297,12 +297,12 @@ static int sh_mtu2_clock_event_set_periodic(struct clock_event_device *ced)
 
 static void sh_mtu2_clock_event_suspend(struct clock_event_device *ced)
 {
-	pm_genpd_syscore_poweroff(&ced_to_sh_mtu2(ced)->mtu->pdev->dev);
+	dev_pm_genpd_suspend(&ced_to_sh_mtu2(ced)->mtu->pdev->dev);
 }
 
 static void sh_mtu2_clock_event_resume(struct clock_event_device *ced)
 {
-	pm_genpd_syscore_poweron(&ced_to_sh_mtu2(ced)->mtu->pdev->dev);
+	dev_pm_genpd_resume(&ced_to_sh_mtu2(ced)->mtu->pdev->dev);
 }
 
 static void sh_mtu2_register_clockevent(struct sh_mtu2_channel *ch,
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index d41df9ba3725..b00dec0655cb 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -292,7 +292,7 @@ static void sh_tmu_clocksource_suspend(struct clocksource *cs)
 
 	if (--ch->enable_count == 0) {
 		__sh_tmu_disable(ch);
-		pm_genpd_syscore_poweroff(&ch->tmu->pdev->dev);
+		dev_pm_genpd_suspend(&ch->tmu->pdev->dev);
 	}
 }
 
@@ -304,7 +304,7 @@ static void sh_tmu_clocksource_resume(struct clocksource *cs)
 		return;
 
 	if (ch->enable_count++ == 0) {
-		pm_genpd_syscore_poweron(&ch->tmu->pdev->dev);
+		dev_pm_genpd_resume(&ch->tmu->pdev->dev);
 		__sh_tmu_enable(ch);
 	}
 }
@@ -394,12 +394,12 @@ static int sh_tmu_clock_event_next(unsigned long delta,
 
 static void sh_tmu_clock_event_suspend(struct clock_event_device *ced)
 {
-	pm_genpd_syscore_poweroff(&ced_to_sh_tmu(ced)->tmu->pdev->dev);
+	dev_pm_genpd_suspend(&ced_to_sh_tmu(ced)->tmu->pdev->dev);
 }
 
 static void sh_tmu_clock_event_resume(struct clock_event_device *ced)
 {
-	pm_genpd_syscore_poweron(&ced_to_sh_tmu(ced)->tmu->pdev->dev);
+	dev_pm_genpd_resume(&ced_to_sh_tmu(ced)->tmu->pdev->dev);
 }
 
 static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 1ad0ec481416..a8f93328daec 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -280,11 +280,11 @@ static inline int dev_pm_genpd_remove_notifier(struct device *dev)
 #endif
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
-void pm_genpd_syscore_poweroff(struct device *dev);
-void pm_genpd_syscore_poweron(struct device *dev);
+void dev_pm_genpd_suspend(struct device *dev);
+void dev_pm_genpd_resume(struct device *dev);
 #else
-static inline void pm_genpd_syscore_poweroff(struct device *dev) {}
-static inline void pm_genpd_syscore_poweron(struct device *dev) {}
+static inline void dev_pm_genpd_suspend(struct device *dev) {}
+static inline void dev_pm_genpd_resume(struct device *dev) {}
 #endif
 
 /* OF PM domain providers */
-- 
2.25.1

