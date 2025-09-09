Return-Path: <linux-pm+bounces-34234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59125B4AB6B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD9836805E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4B832255A;
	Tue,  9 Sep 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9mDHRyc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129A5320CC0
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416299; cv=none; b=q0po1Fim+8uS53fAOE48XdTHp2AaJDXiTr06bp0LLVxE9Rct4m/jR7vnJeiO8tbHgS17xIdSaoh+naC2JfEAoOgEcMphFYps12o/9X9pWyH4B759FV9F5d2yc+EWij7k3ZMnQu5hmBgDY9v+883OjA/Eyb4ROztntpg73AJze5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416299; c=relaxed/simple;
	bh=xvvwoB7YyOGKeYMjn+/FWTHBkrkkqNKMwyxu5VcBFHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MC067aUNan1JjbyVlbj2xI6DwsJRTzmKNfAlwrNyXW4/lDslPy+ABDypdat7PXtNstBPUQQLRU4yMdbQ/HSBEiwYTbu+GKvTCz1Y6r+ItJiK3tMenjXiILuEXt35m125Cu4755S6THiFp9gGe5kOO41xfeSrqTjyaHJHzihoRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9mDHRyc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso6235478e87.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757416295; x=1758021095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylvE7Edllpe4hKT/WEebW1EKotcR3e4yYuI/L6NTjw8=;
        b=C9mDHRycjJVqi1DWJEmoi3KIB4swdabs5vzxdwiTNByx++J27Sa60bXgFn+QJYILpP
         Gdm11++YbPIGl1J75no0uLqI1j/kjThzI0oJQBnPSvu/IQe2FWWMIv5HfX0nuz3GCCV0
         OVaboZLx1SOuL+EgiVWRPBezu0Cp/T4nYf2Ci003qeeaB2QOr0nBh35ktQAAH3VzAZ54
         sIHLAr3l2OO4s/Yv3HSDjT9Ud6tt3tm+GXbEvlhTx/4hsoDRVApHYGP0NCgmXdY4y6cx
         3CeQI69HCbffxyP3f+q51h/wElWPQ/xjEtEjdowdzHF0Rj01yBslMnoHpyt4MQ2sS7v3
         lc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416295; x=1758021095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylvE7Edllpe4hKT/WEebW1EKotcR3e4yYuI/L6NTjw8=;
        b=FFcox9/doxzLFrF27UB8WT7YQ+qFlMgRBVSHQiPM3FMiRqwur/2/oBtrufviZp+F7Q
         7Fjb/9N/Q1S2xhSQA3B4zAs4Yl+7MPb87N+kmeGJ7g8m/5YX/M+T4ZUlJYQKvzchcnOe
         NiBBJXdBo4NrX20PyWoH1id+YAc6FdNqIdDNx0iAd8S0t1JxB82TfKzFkqvXz0PhvX1L
         VOOwAwGY4Xr69a6Yq8jB9aQfPvEIPxjv59vDO8LOQJRG0e/T/at3iipkFC46XedKRE4D
         oQinS5NGH97oOkF0TotVhjzsxdbehQfXnKxDDmweLqnMYbZW38ArA2xBzfyryZIycl9E
         hirg==
X-Forwarded-Encrypted: i=1; AJvYcCWiRB/4RWIdHpYbOKscZ7r5HJVWbI3Jydz8eIq04LgaFnXjffrY4Ug1hDG5v+0j0DeyHsPlIPdtbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJyuB5Dlcege7et4yGPpc+s/gsr/JwzNg0DFv81WZr6qLwoxD
	tEsErArnjvZU0kQGqsFVWQAnCpL9lggtG9wyGxEXFdrBjcgMFAUGsIlffH4AA7f2X+8=
X-Gm-Gg: ASbGncswGECjTa8+btP32AWJPfmOi9wkIHZUwgG5ZCpvroGOAEEhFccSp4t++Bbfia1
	GAN3WEg5hlgTT8h77jC1P91dJ2WcVLaIDVYjbFCvG9lK1B965LhFX6W/4nZ9Qh9K2GdspJglXtK
	GnnMya5V/aXEPHWTARymiedtrkt9fWAW/H4OnDxVTi0/hCZjLcmqUcjgN4EctUJ1iaCqE4I7Fwl
	3uCPV9UoEdrWp8V+qLDV60eoMrCMgr4rqIu3AlA687I9z86uN+otgBmco3NZ7UlCAw/IhoBwzTg
	/24beGF54/nOTMQQc6I92VzsDCV8zlFOt33ymDTgHSPSvxdRdkae129XVWUOMSKTli1BUyi1f3F
	fG3DTJASMNchDSfq+mofTEWLWPGzc1qyQnj75IVHtR4vsLRwoYzmWZGqqmP26h0aewLxqnA1w
X-Google-Smtp-Source: AGHT+IF4O1xigAj0FDirxpcdFMfAw0PezfxnC2jHlhfrcwTgbFgAxA7QwQSCR2UAHH35xR2kprU3qA==
X-Received: by 2002:a05:6512:3c98:b0:560:84bf:7bc with SMTP id 2adb3069b0e04-56263c9897fmr3225878e87.56.1757416295035;
        Tue, 09 Sep 2025 04:11:35 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568190f8040sm445440e87.148.2025.09.09.04.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:11:34 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Saravana Kannan <saravanak@google.com>,
	linux-pm@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] pmdomain: core: Restore behaviour for disabling unused PM domains
Date: Tue,  9 Sep 2025 13:11:20 +0200
Message-ID: <20250909111130.132976-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909111130.132976-1-ulf.hansson@linaro.org>
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent changes to genpd prevents those PM domains being powered-on during
initialization from being powered-off during the boot sequence. Based upon
whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd relies
on the sync_state mechanism or the genpd_power_off_unused() (which is a
late_initcall_sync), to understand when it's okay to allow these PM domains
to be powered-off.

This new behaviour in genpd has lead to problems on different platforms.
Let's therefore restore the behavior of genpd_power_off_unused().
Moreover, let's introduce GENPD_FLAG_NO_STAY_ON, to allow genpd OF
providers to opt-out from the new behaviour.

Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com/
Reported-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 20 ++++++++++++++------
 include/linux/pm_domain.h |  7 +++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 0006ab3d0789..61c2277c9ce3 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -187,6 +187,7 @@ static const struct genpd_lock_ops genpd_raw_spin_ops = {
 #define genpd_is_opp_table_fw(genpd)	(genpd->flags & GENPD_FLAG_OPP_TABLE_FW)
 #define genpd_is_dev_name_fw(genpd)	(genpd->flags & GENPD_FLAG_DEV_NAME_FW)
 #define genpd_is_no_sync_state(genpd)	(genpd->flags & GENPD_FLAG_NO_SYNC_STATE)
+#define genpd_is_no_stay_on(genpd)	(genpd->flags & GENPD_FLAG_NO_STAY_ON)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -1357,7 +1358,6 @@ static int genpd_runtime_resume(struct device *dev)
 	return ret;
 }
 
-#ifndef CONFIG_PM_GENERIC_DOMAINS_OF
 static bool pd_ignore_unused;
 static int __init pd_ignore_unused_setup(char *__unused)
 {
@@ -1382,9 +1382,6 @@ static int __init genpd_power_off_unused(void)
 	mutex_lock(&gpd_list_lock);
 
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
-		genpd_lock(genpd);
-		genpd->stay_on = false;
-		genpd_unlock(genpd);
 		genpd_queue_power_off_work(genpd);
 	}
 
@@ -1393,7 +1390,6 @@ static int __init genpd_power_off_unused(void)
 	return 0;
 }
 late_initcall_sync(genpd_power_off_unused);
-#endif
 
 #ifdef CONFIG_PM_SLEEP
 
@@ -2367,6 +2363,18 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 	}
 }
 
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
+{
+	genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
+}
+#else
+static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
+{
+	genpd->stay_on = false;
+}
+#endif
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -2392,7 +2400,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
-	genpd->stay_on = !is_off;
+	genpd_set_stay_on(genpd, is_off);
 	genpd->sync_state = GENPD_SYNC_STATE_OFF;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index c84edf217819..f67a2cb7d781 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -115,6 +115,12 @@ struct dev_pm_domain_list {
  *				genpd provider specific way, likely through a
  *				parent device node. This flag makes genpd to
  *				skip its internal support for this.
+ *
+ * GENPD_FLAG_NO_STAY_ON:	For genpd OF providers a powered-on PM domain at
+ *				initialization is prevented from being
+ *				powered-off until the ->sync_state() callback is
+ *				invoked. This flag informs genpd to allow a
+ *				power-off without waiting for ->sync_state().
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -126,6 +132,7 @@ struct dev_pm_domain_list {
 #define GENPD_FLAG_OPP_TABLE_FW	 (1U << 7)
 #define GENPD_FLAG_DEV_NAME_FW	 (1U << 8)
 #define GENPD_FLAG_NO_SYNC_STATE (1U << 9)
+#define GENPD_FLAG_NO_STAY_ON	 (1U << 10)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.43.0


