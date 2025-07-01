Return-Path: <linux-pm+bounces-29899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF018AEF71B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C44179E39
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0B3274FC6;
	Tue,  1 Jul 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7PAmCKy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D502749FF
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370480; cv=none; b=tfG/A2sjtyWdbYB2J/pJJUvFXvEXrfTgFc0zO27Eh9tkeORK5du73hGfIsMywiWdBq9sD9Fdr8Hko2P3yCsVE6slYPMP07hcW/VJMb11IWQ9IugJBVNfSoxZETK3vSn6cGsM8HSrbFJourlps52km5gezFQSTU4QPXKSzfksa/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370480; c=relaxed/simple;
	bh=LHxZDkyo502rMyxdajeshiUDkvLObery09pkUl63guQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiGdbslS1sDzFNOcb1nQUyblAed4vj4ZynMwKryuRGX6El39ycw3AL9+Gb6rIwJlQ03Hag/KUZOcCqjEht3svaSKDwAAPR7hyutsc10oO2kJic1HrVVIrGZq5msYfgOZqI03asKfWX9INJ5Lhf0SvoI6xATForinUO/Oj7OAq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e7PAmCKy; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b7cf56cacso53582271fa.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370476; x=1751975276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYtOzZmGnMBH7yNv+nKiRPqWoWqO5OBErjnboqxVlX8=;
        b=e7PAmCKybusLt0X5GvqWNqzAKlDGWNGd4MNPEedzrZIwl2NyhjPtznAi0Ga0YWO8GF
         pO/i18GNe6QaeatTe17vjrnz0G4tNw3XswRgb+qOLO3P1QF6XPMClMoIoVX8fiW9ESBY
         U0QcTEWuw0NA8mGQextT9v0j/ogOqsAxN2PapEl27s0nw7P4saNofucRz0ev1B/774PP
         Pb5CKag1JiIO8+tX8gR2BDEmgX/2RnD2l/ZuB1kUUHToXwnecF3f2MTOAGGk9y/Rmq3I
         9VsRXRmC4LCqOYfaNwjPEFSm5Sb3XAc3Kyy/u5fz61Fu7OIBdZX3N3LQnCJmKXVpheYO
         21UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370476; x=1751975276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYtOzZmGnMBH7yNv+nKiRPqWoWqO5OBErjnboqxVlX8=;
        b=BFPLJoJz3q4l2G4V7Mc2mZNjI7VK/ud538fQaWfDSbiln+MMRSGqXZ1tDMupSvEGT0
         SjKdPXdzQrbCX2I1oV2P7cjtp00jE2VQmE9K+x9qK3BEUKroPZWgRW6BzVvcc39hnnlE
         3Yxv9Lc9YoPxIiP+q03epqBoM84qWTwOkzCxBgM95Tcj1bL4zoVPS9hX3NuORsRwDlAL
         E/NrWxYi2iR3optsSJi1s+AgIKc9rKRayejhGzh5RM3sgVn4+NOKwRrBX/uW3dYsCjGY
         ycrYDewIYgYPNT/KGSoX1AEf3iNV3Goa2fxR9ptpR+lZiJCzHD1K0cd28gmNPvIgqCrN
         QtmA==
X-Forwarded-Encrypted: i=1; AJvYcCU9WiuwURTjv/5fS9HqfpSWHFlBYf1KtLzADatZyCTHYO84bUVTInrFch+twurQqS92hNhc9dAZ6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFLN6dxXDL4Azmm/hREpRn8RC7nk5Tjfwn8nbbEc4TcG2XVLF
	rEX3ERmRoI4YFiTmWxgcnRDuBd/vPkCwhb1wdG02XjDsGt5hSbn/3fpa5Snq6WrQork=
X-Gm-Gg: ASbGnctKn3gI+ap7lOuFJC+Bq8m786vIqcaBI5cq7udVyfy/Ql+iQw8MCuO2zAcVcXM
	iV0ykzSpNCMI6wK2rY7+n9JoWS0rzwzcSgv7QH98K73A06XaU15VF5P9YQfTYnKoEG5sZq0d4oU
	3oD1TaaK8+wbfKReXLgTZ79u0UxZlwQeUcVpux97IFTy9lWO+cQ0a30LPdMWp6O7gaLc8aemFXO
	AyOBEOYW2axocmzOJWzF9QBO72CpP9VjKI3S2LGBgb+kw1IwTmwD0WfeRu8cb61iQ5MMp8V5YiB
	7WwSVREsXvnyJo4HvevckMXplylqIj+eT3yTMBOyUbvx2JJd2rXawJwvCdoiEpE7ZeU7ogyV5Ax
	kIt5tlbxhVir7aG51vs7pXTVi8fEVSRl8GwN7
X-Google-Smtp-Source: AGHT+IFSPaZorQ+Qh+OkD3aotM2d9NhdvbOFk3i1QZMiUSjQgU+7klRfn1pjmSzZTdcbR7VQIAkesw==
X-Received: by 2002:a05:6512:b1e:b0:553:d910:9344 with SMTP id 2adb3069b0e04-5550ba2b25dmr5366069e87.45.1751370476453;
        Tue, 01 Jul 2025 04:47:56 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:47:55 -0700 (PDT)
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/24] soc/tegra: pmc: Opt-out from genpd's common ->sync_state() support
Date: Tue,  1 Jul 2025 13:47:11 +0200
Message-ID: <20250701114733.636510-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tegra implements its own specific ->sync_state() callback for the genpd
providers. Let's set the GENPD_FLAG_NO_SYNC_STATE to inform genpd about it.

Moreover, let's call of_genpd_sync_state() to make sure genpd tries to
power off unused PM domains.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/soc/tegra/pmc.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index e0d67bfe955c..d209e3435878 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -418,7 +418,6 @@ struct tegra_pmc_soc {
  * @irq: chip implementation for the IRQ domain
  * @clk_nb: pclk clock changes handler
  * @core_domain_state_synced: flag marking the core domain's state as synced
- * @core_domain_registered: flag marking the core domain as registered
  * @wake_type_level_map: Bitmap indicating level type for non-dual edge wakes
  * @wake_type_dual_edge_map: Bitmap indicating if a wake is dual-edge or not
  * @wake_sw_status_map: Bitmap to hold raw status of wakes without mask
@@ -462,7 +461,6 @@ struct tegra_pmc {
 	struct notifier_block clk_nb;
 
 	bool core_domain_state_synced;
-	bool core_domain_registered;
 
 	unsigned long *wake_type_level_map;
 	unsigned long *wake_type_dual_edge_map;
@@ -1297,6 +1295,7 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	pg->id = id;
 	pg->genpd.name = np->name;
+	pg->genpd.flags = GENPD_FLAG_NO_SYNC_STATE;
 	pg->genpd.power_off = tegra_genpd_power_off;
 	pg->genpd.power_on = tegra_genpd_power_on;
 	pg->pmc = pmc;
@@ -1406,6 +1405,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 		return -ENOMEM;
 
 	genpd->name = "core";
+	genpd->flags = GENPD_FLAG_NO_SYNC_STATE;
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
 
 	err = devm_pm_opp_set_regulators(pmc->dev, rname);
@@ -1425,8 +1425,6 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 		goto remove_genpd;
 	}
 
-	pmc->core_domain_registered = true;
-
 	return 0;
 
 remove_genpd:
@@ -4263,8 +4261,25 @@ static const struct of_device_id tegra_pmc_match[] = {
 
 static void tegra_pmc_sync_state(struct device *dev)
 {
+	struct device_node *np, *child;
 	int err;
 
+	np = of_get_child_by_name(dev->of_node, "powergates");
+	if (!np)
+		return;
+
+	for_each_child_of_node(np, child)
+		of_genpd_sync_state(child);
+
+	of_node_put(np);
+
+	np = of_get_child_by_name(dev->of_node, "core-domain");
+	if (!np)
+		return;
+
+	of_genpd_sync_state(np);
+	of_node_put(np);
+
 	/*
 	 * Newer device-trees have power domains, but we need to prepare all
 	 * device drivers with runtime PM and OPP support first, otherwise
@@ -4278,9 +4293,6 @@ static void tegra_pmc_sync_state(struct device *dev)
 	 * no dependencies that will block the state syncing. We shouldn't
 	 * mark the domain as synced in this case.
 	 */
-	if (!pmc->core_domain_registered)
-		return;
-
 	pmc->core_domain_state_synced = true;
 
 	/* this is a no-op if core regulator isn't used */
-- 
2.43.0


