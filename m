Return-Path: <linux-pm+bounces-25643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECC8A91F95
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EADC4639ED
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79F725393E;
	Thu, 17 Apr 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yVy5L502"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EFA253350
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899948; cv=none; b=lDFkQqkuSOsEp1j8HO/eeihB8w4UomIdxE6lZIYZC2y2sXfgIu6VocoHHaniK8udeS3PnxVicXOG79+0kQUx602GkWeWGClUJQXcVosvP2e2sWziExnmiS5CbWPl52mzgTSlEakUB7G0Mbac98sZItmjXBZUOTQFsh7XoU0yc1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899948; c=relaxed/simple;
	bh=aN8FEk2gTwraQmA2Okw28VZvXnn4IpMUEhiRqft6pRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmmHqxaNVe2B6Ap5qorxAiMrjUQUZqdNp4bM2WWzgjXkjuhe6STCJ+AFu/4/j97Glmp0hlLHEcHXI67pANyn0CxEUTgj1t8G2epxMlBSJ06TGXekbGR+9NyLjcyTxU4+h+h28DrBV++7LF9bL2XOTFJn7v09ufJRLXEiJnxERks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yVy5L502; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54298ec925bso434275e87.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744899945; x=1745504745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DgFXHRgSnMuDIPCx1JNgWD3fMJlP6odjvf+kJnYpPA=;
        b=yVy5L5027EaTAPgylmnLEUY4rL1ClD7aXMlPabQGjdrOWE3+rJHrvCarDc1m1xPcUM
         yOciC6OW8iEeQ04/nYzhTtDI+SK8I9yOdIX3JR2WRnQY00VNz8NnJw6z83j81GGa4YKG
         0kcpmfruS7MiTPIUNjKoo+oPgfDXyDk4Q1A2mKGSY3Q9VEyza/ES5bmgcdCRrL9qzkuc
         gPAt5DO1fRLK+bD3TXEnD8aFD6CFFVBeagf2Bdvujg8x6YhUd1K/q08u6jRPHsy+dHVP
         1bAbsT/buFntkLuF0M4AAgSeyeeilCBtLjlwuEp9ZVXt3GliXvHO7kce5tE272FmXUq6
         sD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744899945; x=1745504745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DgFXHRgSnMuDIPCx1JNgWD3fMJlP6odjvf+kJnYpPA=;
        b=Ye413BgNHNcuKIuVFlw2r1r48jLXvhJtpyQh7rJnj8TwImAe2AkdwVWCjrzOs2kOWW
         AP4rfCBwo77HZ4JZoryhfYEXpwdzb/gMiN8UYUF90XRaYZlynHajYTkfSZ4AsChj47Gj
         tFMMzVs9ZKgFh+fttCx4XhBfJIltGcqs3aLcQqLVTJTdvhf6/JLXNCKNgBRbCf6ItWo3
         fcs9m5SobsViC1QOf5a86Gqx0i46+ZSpWth5SthzDZ7fE9LcJvUsxosPDw/BvpmPmwpC
         w0iaDEBRJttBsg7ILoFoxzt7/WRjX6cWOfy29/i9Zad2YLSP6ZGTfNEnjzDRwus4XOSQ
         912A==
X-Forwarded-Encrypted: i=1; AJvYcCUWwjd7T0WMPLW5syVJ2vEULlIDqCuuCK19jJYvs09tVf93sVoWwOlRufseT7WfYa/Fp+dIxaoB3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5isSTFFrBuDprxBUhab0qbR7V/7tGQHD7zGNlwRpAyY30y64
	1BEyupjQBBD4U9mmf/n4ncSnXHPRgT5xPscx0Rpksvs2BxYBYDP4jT8vLPgxlgY=
X-Gm-Gg: ASbGncueSuTlo6/RTPyTU7T/CsIGOHjAPrUNFRRZX68X0jn9RTJUq7cGQ3p7EFvddWi
	hDonyYmaXbXvYnZms6HreWLrDijdxo0ar0qD8WLLscRL0rtVocKawZ0TfLHWT7k0RYGBfCoUkgW
	0VMgjugKJ6nUdzz2oRNQAnS515U7xKpbqfyoXgya/O8q+3HcqBBOJ5f95c006NtI0yrOYQescKb
	OrXGLUzkIugpjQD1q5kWcW552lriaTykvsOQeg+rTDolVobTloZufUr9Mv7evw/xOTyzHxZWS2u
	4FHZ5DBZs+CuKc1qNDcJVhzrKcKim9K5RQedkg8/bdzEppo/Nz5M7f9tvMhTLA41lYwqj1LJbyb
	l84vaSQSWap4VV8c=
X-Google-Smtp-Source: AGHT+IHdJaQxomsfYSS+f0K9itIKdmZijhFhwWEW6ghpA5npqy5MAC8rCQkmORhb5jt3ng77hEg7hw==
X-Received: by 2002:a05:6512:3055:b0:54b:117c:a070 with SMTP id 2adb3069b0e04-54d64af157dmr2157090e87.57.1744899944885;
        Thu, 17 Apr 2025 07:25:44 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d65e43647sm370096e87.58.2025.04.17.07.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:25:44 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] pmdomain: core: Add internal ->sync_state() support for genpd providers
Date: Thu, 17 Apr 2025 16:25:06 +0200
Message-ID: <20250417142513.312939-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417142513.312939-1-ulf.hansson@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
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

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h |  7 +++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 512f89e6d302..9c5a77bf59d2 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2374,6 +2374,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
+	genpd->sync_state = GENPD_SYNC_STATE_OFF;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
 	genpd->device_id = -ENXIO;
@@ -2656,6 +2657,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 				 struct generic_pm_domain *genpd)
 {
 	struct fwnode_handle *fwnode;
+	struct device *dev;
 	int ret;
 
 	if (!np || !genpd)
@@ -2665,6 +2667,10 @@ int of_genpd_add_provider_simple(struct device_node *np,
 		return -EINVAL;
 
 	fwnode = &np->fwnode;
+	dev = fwnode->dev;
+
+	if (!dev)
+		genpd->sync_state = GENPD_SYNC_STATE_SIMPLE;
 
 	device_set_node(&genpd->dev, fwnode);
 
@@ -2718,8 +2724,10 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 {
 	struct generic_pm_domain *genpd;
 	struct fwnode_handle *fwnode;
+	struct device *dev;
 	unsigned int i;
 	int ret = -EINVAL;
+	bool sync_state = false;
 
 	if (!np || !data)
 		return -EINVAL;
@@ -2728,6 +2736,10 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		data->xlate = genpd_xlate_onecell;
 
 	fwnode = &np->fwnode;
+	dev = fwnode->dev;
+
+	if (!dev)
+		sync_state = true;
 
 	for (i = 0; i < data->num_domains; i++) {
 		genpd = data->domains[i];
@@ -2737,6 +2749,11 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		if (!genpd_present(genpd))
 			goto error;
 
+		if (sync_state) {
+			genpd->sync_state = GENPD_SYNC_STATE_ONECELL;
+			sync_state = false;
+		}
+
 		device_set_node(&genpd->dev, fwnode);
 
 		ret = device_add(&genpd->dev);
@@ -3453,6 +3470,25 @@ static void genpd_provider_remove(struct device *dev)
 
 static void genpd_provider_sync_state(struct device *dev)
 {
+	struct generic_pm_domain *genpd = container_of(dev, struct generic_pm_domain, dev);
+
+	switch (genpd->sync_state) {
+	case GENPD_SYNC_STATE_OFF:
+		break;
+
+	case GENPD_SYNC_STATE_ONECELL:
+		of_genpd_sync_state(dev);
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
index e9a1f8975c4f..2185ee9e4f7c 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -127,6 +127,12 @@ enum genpd_notication {
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
@@ -187,6 +193,7 @@ struct generic_pm_domain {
 	unsigned int performance_state;	/* Aggregated max performance state */
 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	bool synced_poweroff;		/* A consumer needs a synced poweroff */
+	enum genpd_sync_state sync_state; /* How sync_state is managed. */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
-- 
2.43.0


