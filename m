Return-Path: <linux-pm+bounces-27576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA2AC2450
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0BB1738B8
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28808296FAE;
	Fri, 23 May 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Na+Ihge0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C991296715
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007669; cv=none; b=gSaUfFl/1orX8QEU9TpU4LmWoerUGOUVtDMLUvV1CuwrL/ttOhB3mYIDpkOJaYsPoIlP1El9/fE4UrCmnSEjM+In/xkNy/E76ic2jidVlkySxI3WrcfGgYTATq6dZQ4xWdCrLootcC91QIf3BufQeFU0WyZe3V1EfMkEp7ZjDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007669; c=relaxed/simple;
	bh=BNU9PuywstX6I+IaQZdoVQWmlolUJAYeaZv61hYLkg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vt6c7Q86Ayir7R+cq5ktS56KARSGfEveBCj9JWuXiqV0gQWJBcS4iTmIiVWI1DOB5DatHA3GFxLzOB1M6MplLaKeoTVJfSZfkR1sdQob2eB+B9N3ns9CYu4yFQ1pfNiII+yEFLa9qoKVERv8UyEruzK9OVzQ6gROXDYV2JbW4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Na+Ihge0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-550e2b9084dso10684657e87.1
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007664; x=1748612464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC7YC2/v/hospjziwcUkovuFHlTjTAcy5Zz+vdo8lIo=;
        b=Na+Ihge0zpyigW7TNffIf+MostbKgczA/7bnqO6OV12TVeDFQvjG6GoFjDQ6lPAL1Y
         3cLG4u6GSLBBbOQl0nEaXR2xVyaqsWDCzV6L/1o1YOSuagzB9FC1gD5cvuraOfYaHCzy
         hIjtN2vibL8XG2Ev0KAuqZ5wkflgKp5yZvpb7624AbVXfWE/PpJh4z/Jz52pA5et8fMN
         G/5X5EEOI/9yUEQNjiGPaVvzGPuzHSOOK3ZY0A7wAt7GTBgOtYKsSdIukGNJKTOGgYWG
         NvKKSStfgLirB4ej7QxTGZjYY0/Xy/UNHg+oYYSq9F8if8xuY+1sk6Ybsro9MyxrZtDh
         KoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007664; x=1748612464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC7YC2/v/hospjziwcUkovuFHlTjTAcy5Zz+vdo8lIo=;
        b=OE+w5XIzH+gxDryXYOTt2BojiCMnQaTJWH77q44/nosu7xSRlpmoeTW4jR7DVXFCZF
         dIsA0LM81lFN0Q8qVU3asklCWQfLcQcK/gM/dBnDmQulXL7a8h6eZmWPUwaC1Llft/BR
         RAPcCiA0ZKIDEklkgdJy16m2Hz0F68nrR0B/WOUr9ilWIErRAhSWZkprXwRG6VR1JIRl
         q8F6HBFwQ2+5ZFvJTJ4do7upPsn7YlZDommQ3+5HWX9WzrPrUeNfwywqvej5G2MA8GuF
         dZdY+yL2ALAqsMAzKN7mBi8VPHIcknYEXsTKvYHjsRi4aUcUQcTWNgNKb7Ef9DVXNnGD
         uXsw==
X-Forwarded-Encrypted: i=1; AJvYcCXKnPZmgaLAZ7axNdB7u5obk6FsUOKN33DPPnR2ukxEJaOBdG5TebDgI7f2Yc4KgQA46CPKIeINQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBu3ZaxLlEEK9tA34qEc1DTOXjk3fid5fO0y1mDs0M4UILXVf
	oilcW0hadfxR2T3zDePIHx/4PhSvbhOaZReImO0S1iNpV0+yroZ0l0x6U6wW6wQB9CA=
X-Gm-Gg: ASbGncuC4Cjbd/G6fryJRvrkWDzPLvpR02rf5mUe7SO8jejz+XqAvcpaVZOrNYl0O8x
	Tq5+fAx1VHLvUBzYpgDiUeVU23IbjPRoiX9oqhZXqeH36KJ1WFNRYUoENOXuP6zyQCoECg6GhAg
	XlHN2ZuDpetvlUXSM/a0cGreNpiwOPC4wyNbPwrgciXepcK1f6OsZSYBtPIWb5EJezxklAT8QRK
	tE2B4q4QJDJjS8JRytJzOl6Pk3t2JtogkRIU3InwEXWP/NZ5C18eYRSgBBy91ap30PkZZdz5W7g
	zBZSvusP3aG6LgKuF0PWigYVtCW3wt7q1phizmS81oSB02klNx9f04f8foD1XgCDn2DXrn09C2/
	FnqCwY9EvRqrM82nkchqX6JyPKw==
X-Google-Smtp-Source: AGHT+IEZ0JF0eQFf2usDsMtCl0D2zCseCjmw2y7+b0hDzAnm98HasW9P5zPUEvp49AX37vCRxzZGZQ==
X-Received: by 2002:a05:6512:630e:b0:54f:c1ae:f1b6 with SMTP id 2adb3069b0e04-550e99648bemr7875417e87.56.1748007664022;
        Fri, 23 May 2025 06:41:04 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:41:03 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
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
Subject: [PATCH v2 15/21] pmdomain: core: Add common ->sync_state() support for genpd providers
Date: Fri, 23 May 2025 15:40:12 +0200
Message-ID: <20250523134025.75130-16-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the genpd provider's fwnode doesn't have an associated struct device
with it, we can make use of the generic genpd->dev and it corresponding
driver internally in genpd to manage ->sync_state().

More precisely, while adding a genpd OF provider let's check if the fwnode
has a device and if not, make the preparation to handle ->sync_state()
internally through the genpd_provider_driver and the genpd_provider_bus.

Note that, genpd providers may opt out from this behaviour by setting the
GENPD_FLAG_NO_SYNC_STATE config options for the genpds in question.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 52 +++++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h |  7 ++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4047af5a275d..c094ccbba151 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -189,6 +189,7 @@ static const struct genpd_lock_ops genpd_raw_spin_ops = {
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
 #define genpd_is_opp_table_fw(genpd)	(genpd->flags & GENPD_FLAG_OPP_TABLE_FW)
 #define genpd_is_dev_name_fw(genpd)	(genpd->flags & GENPD_FLAG_DEV_NAME_FW)
+#define genpd_is_no_sync_state(genpd)	(genpd->flags & GENPD_FLAG_NO_SYNC_STATE)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -2374,6 +2375,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
+	genpd->sync_state = GENPD_SYNC_STATE_OFF;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
 	genpd->device_id = -ENXIO;
@@ -2627,6 +2629,8 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
 int of_genpd_add_provider_simple(struct device_node *np,
 				 struct generic_pm_domain *genpd)
 {
+	struct fwnode_handle *fwnode;
+	struct device *dev;
 	int ret;
 
 	if (!np || !genpd)
@@ -2637,6 +2641,15 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	genpd->dev.of_node = np;
 
+	fwnode = of_fwnode_handle(np);
+	dev = get_dev_from_fwnode(fwnode);
+	if (!dev && !genpd_is_no_sync_state(genpd)) {
+		genpd->sync_state = GENPD_SYNC_STATE_SIMPLE;
+		device_set_node(&genpd->dev, fwnode);
+	}
+
+	put_device(dev);
+
 	ret = device_add(&genpd->dev);
 	if (ret)
 		return ret;
@@ -2661,7 +2674,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	if (ret)
 		goto err_opp;
 
-	genpd->provider = &np->fwnode;
+	genpd->provider = fwnode;
 	genpd->has_provider = true;
 
 	return 0;
@@ -2686,8 +2699,11 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 				  struct genpd_onecell_data *data)
 {
 	struct generic_pm_domain *genpd;
+	struct fwnode_handle *fwnode;
+	struct device *dev;
 	unsigned int i;
 	int ret = -EINVAL;
+	bool sync_state = false;
 
 	if (!np || !data)
 		return -EINVAL;
@@ -2695,6 +2711,13 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 	if (!data->xlate)
 		data->xlate = genpd_xlate_onecell;
 
+	fwnode = of_fwnode_handle(np);
+	dev = get_dev_from_fwnode(fwnode);
+	if (!dev)
+		sync_state = true;
+
+	put_device(dev);
+
 	for (i = 0; i < data->num_domains; i++) {
 		genpd = data->domains[i];
 
@@ -2705,6 +2728,12 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 		genpd->dev.of_node = np;
 
+		if (sync_state && !genpd_is_no_sync_state(genpd)) {
+			genpd->sync_state = GENPD_SYNC_STATE_ONECELL;
+			device_set_node(&genpd->dev, fwnode);
+			sync_state = false;
+		}
+
 		ret = device_add(&genpd->dev);
 		if (ret)
 			goto error;
@@ -2727,7 +2756,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 			WARN_ON(IS_ERR(genpd->opp_table));
 		}
 
-		genpd->provider = &np->fwnode;
+		genpd->provider = fwnode;
 		genpd->has_provider = true;
 	}
 
@@ -3446,6 +3475,25 @@ static void genpd_provider_remove(struct device *dev)
 
 static void genpd_provider_sync_state(struct device *dev)
 {
+	struct generic_pm_domain *genpd = container_of(dev, struct generic_pm_domain, dev);
+
+	switch (genpd->sync_state) {
+	case GENPD_SYNC_STATE_OFF:
+		break;
+
+	case GENPD_SYNC_STATE_ONECELL:
+		of_genpd_sync_state(dev->of_node);
+		break;
+
+	case GENPD_SYNC_STATE_SIMPLE:
+		genpd_lock(genpd);
+		genpd_power_off(genpd, false, 0);
+		genpd_unlock(genpd);
+		break;
+
+	default:
+		break;
+	}
 }
 
 static struct genpd_provider_drv genpd_provider_drv = {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9329554b9c4a..d68e07dadc99 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -133,6 +133,12 @@ enum genpd_notication {
 	GENPD_NOTIFY_ON,
 };
 
+enum genpd_sync_state {
+	GENPD_SYNC_STATE_OFF = 0,
+	GENPD_SYNC_STATE_SIMPLE,
+	GENPD_SYNC_STATE_ONECELL,
+};
+
 struct dev_power_governor {
 	bool (*power_down_ok)(struct dev_pm_domain *domain);
 	bool (*suspend_ok)(struct device *dev);
@@ -193,6 +199,7 @@ struct generic_pm_domain {
 	unsigned int performance_state;	/* Aggregated max performance state */
 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	bool synced_poweroff;		/* A consumer needs a synced poweroff */
+	enum genpd_sync_state sync_state; /* How sync_state is managed. */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
-- 
2.43.0


