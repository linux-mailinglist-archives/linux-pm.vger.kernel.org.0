Return-Path: <linux-pm+bounces-27567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF086AC243C
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E044E33F7
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C6F295510;
	Fri, 23 May 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rt5Mf0Eg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799C2951B8
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007652; cv=none; b=uX2KxEiSAjOahmlDoIUvI6EbqnAyuYXi6BO+7YBawCUWStTUCNQOwhrKgheh1HqCFcBJAwg99rfeSgj6Zua87WZo71E8/mAcfpCjR8/pyHvYXPNYm2trdqQD33jxLOyXVz7AfePT4saVyzVST51K8eyhv4pR9UgyVvfaDVpFVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007652; c=relaxed/simple;
	bh=WcF75pnqXotEsYTaAIFVCeSXbuTwse28sKqnHWInBJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDkztZhCmHrVgqqhrSi8r936AL8meLqR15mWgtrpmhK7/LJRGwGlpm5aybykzd4V7Zo9MPW6J9BWWgmEl4sL79HLWP0FTIyxFBBk3eklaoq4c6oxA3fb60EOxLNbUzbHet88h/PyrSVCrrf+oE85mnYMicRQrGtqa+imrM7UCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rt5Mf0Eg; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54b0d638e86so13766875e87.1
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007649; x=1748612449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMZdXJF8HQ4HBbVGnSNAyGkt9IprenNJaiH/9V7ofuE=;
        b=rt5Mf0Eg5tZEJJ+mdYv8QUxFbcJqhdsHxnKfo+vJ27/cBMgMs6Bj8ad7h2blhm+/GX
         1tmGKMz+f1Ifz83EjfHEYiFlyfP4WANbOYAnSJ7QV0m5dicc7UxebJOC6hR9xZMJ1K4K
         Vc+AIfAANog00rhxQ9RhOH5NWqcPw3rP1XKQ7LuuScUjtVg5VtkXuHvSioG4IYHuzuHy
         rGcrmFxNfgX4SzQ0IJHUkrsvSB4FZr+VnxrWXbgWf0kFi7MfhcBdJn1OcgNKb5Ug28cn
         2PKOFyGmEvrzWDVWr4TnRyfPxxTX8ElYoriE+rI0nsD+/9iMmYqdeucyp0M5f9KPFX4S
         HF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007649; x=1748612449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMZdXJF8HQ4HBbVGnSNAyGkt9IprenNJaiH/9V7ofuE=;
        b=Q2nbR4TcpVFu8GTbC8PAofXY3v5ygWsd6GRTIFb+stEdFauA1BJJ1wTNEIQSWAc6I3
         ynE6o+k5jpFy1WZN2DJ+61+RSb25cg94l42yIg69QnNA2+8QKzTPoMRy0CPJWMX+vvqg
         9PQWAUPa42Z+rS8DGYjXJsd0s0Lqu4p+fkJ8xyTonYjU30D7b50/udITn1UWFHno0j3X
         GhPvJtp1C+oAjlO/3iQIirrO5vtmsI92VO3VoCfHtGKmccxrElvUX9I9OCNM3x6xfsLN
         qxWirPVJKNqgUoRO6YNP5/rrlenMhsRNYPUP1+7OJ6QfDzcz4l3k0zfVG5PpTPAPbm1q
         FM2A==
X-Forwarded-Encrypted: i=1; AJvYcCU/fTUpyYc4KIw4EDSBIAYynPMtHCXGZ4cDLJXU6Clx7vFT5LNWq8Z/bjNIgPY3vi29cL6Zj+PVRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SCMZ0nvGUjKapwU5IfkEr7HGGeweOe6BQxyLidlPvz9VrHVP
	tJM50iUJXp8qW4ENr6GTVjVHn79iDUgqm7DV/NTLY4+3MdilZoOcf1EoXV7EJwl0gAI=
X-Gm-Gg: ASbGnctqzi7j24fZSJwiyMrh6rTz6sUz63SPzmHFEH3A+c7wvZ1tUvBt1UsdlspWSLA
	3dRF7qA+f2kH9dBUoxK2YzhVMJFcTQjNfZRIwB8gIKA7twxM2lNt6xfZsMk3p0Ng9VpmYpn//w4
	wpd9V7o0EiO7FupWYh0fuB0lC3o3xIIDrvawuuw/BrsQG47VWSyScLBgGManL/tKFeDlp6140xm
	N7OdOrrXXzwDA3hSh4vyAZT4cxkFfUEHZHhsgUHvxqcLMvzB8QQvEfH0wydH1hp/6RsnVtE4aJ8
	KsX94HPhePqvJf8q7KTs2xffy32lc+A4SZuo1qz+pd6biZWsg5bDNGj6cDf5yOoE4pQzJ7ZIcDG
	aScXR8hIcpdTQrzjcFLl/73NjkA==
X-Google-Smtp-Source: AGHT+IGvEYgNGoCkD4rXMPLf1i5EyasJT4rgUzgZY4MikEpEuIPRUFRo0vKJ3KsJupVkoZwFT+4GMg==
X-Received: by 2002:a05:6512:10cc:b0:54e:86f3:5e65 with SMTP id 2adb3069b0e04-550e9966d43mr9793624e87.56.1748007648818;
        Fri, 23 May 2025 06:40:48 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:48 -0700 (PDT)
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
Subject: [PATCH v2 06/21] soc/tegra: pmc: Opt-out from genpd's common ->sync_state() support
Date: Fri, 23 May 2025 15:40:03 +0200
Message-ID: <20250523134025.75130-7-ulf.hansson@linaro.org>
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

Tegra implements its own specific ->sync_state() callback for the genpd
providers. Let's set the GENPD_FLAG_NO_SYNC_STATE to inform genpd about it.

Moreover, let's call of_genpd_sync_state() to make sure genpd tries to
power off unused PM domains.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/soc/tegra/pmc.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 51b9d852bb6a..ef486387ccd9 100644
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
@@ -4262,8 +4260,25 @@ static const struct of_device_id tegra_pmc_match[] = {
 
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
@@ -4277,9 +4292,6 @@ static void tegra_pmc_sync_state(struct device *dev)
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


