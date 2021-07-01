Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E531C3B98FB
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhGAXbE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbhGAXbD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:03 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7D9C061764;
        Thu,  1 Jul 2021 16:28:31 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id p24so10842549ljj.1;
        Thu, 01 Jul 2021 16:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OX29y7QQ7Mpf+PBDJlXkxuoCHaCIXugN7sjacL9ohx4=;
        b=W3aw2K5uUi83bSK76RU19yZ4APtEbja5Wj/gKuHOyOLtFPSbCF7wVJ6hey+gDXp1xp
         lNMPUhAW9OMTsTX7vh7a1CIasap7Jvr8cjp1pueKjMFDjzc93aFmDYJuxRrAcWi8oPYJ
         TtJpbhYBiaP0zhao5KalpvMJJaeReCK0EkHSxEBi+yiriqOo2jRPiX6d4bmNiSJ6CH7A
         wNNTSQckVKS50atbKET1icpnCn+ZzFv2+XcHsKBpb867FxAONK8k8FMbykAA0IbzH3BN
         l+wfB/DHdi7UL4Lc07WnNuUWWD/Ta/r4P+OBXCGQoe1cKxWzgKeX6Eaj5EvlsUt9e50a
         eBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OX29y7QQ7Mpf+PBDJlXkxuoCHaCIXugN7sjacL9ohx4=;
        b=frIKD8IvX8EB40bCbLlYJG7lGmlEJxn33iFylCAJwQ6T0BJpli56AzK0DOBv8TvBWP
         eXSgs/AYUEXv+4Al60ddCq1RC6VeutCgTMptwpPxvMDckw/aDB+aR1nZo9ffKBvmO4qg
         gkC8PovoWQfL5c6/wB79NnvN0vc/Xo6PJVquUtX4+g23tiUuYBVU995AfCGFJ9L85zkE
         eD6JFvlcDvw5jn3o9R2cMjey748jArlRpAAQRPqKliSe/muiHTAiCULy2WEcP3ZFU+rM
         4t+hJZyzN6ZNzq3WYQIzIuZzCC51jttEzTlYfhvcwT7eTo0fIe49JwFhAiK26S3Tg5rv
         BjfQ==
X-Gm-Message-State: AOAM533Y9D7ijnSM4jHgMNwW5zlG2U905C1fMNxCqprbOv1hWVauaaHx
        6C8YTdWgwUqZysLCB5MOqdo=
X-Google-Smtp-Source: ABdhPJz6r9krQxn9YY7oafE8jMiHvdXfmq67wPGxmRDPJtZYepWcn6HAf7u3IvzrGOoVbnYAfKLz2Q==
X-Received: by 2002:a2e:9bcc:: with SMTP id w12mr1516481ljj.123.1625182109836;
        Thu, 01 Jul 2021 16:28:29 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 01/37] soc/tegra: pmc: Temporarily disable PMC state syncing
Date:   Fri,  2 Jul 2021 02:26:52 +0300
Message-Id: <20210701232728.23591-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Disable PMC state syncing in order to ensure that we won't break older
kernels once device-trees will be updated with the addition of the power
domains. Previously this was unnecessary because the plan was to make clk
device that will attach to the domain for each clock, but the plan changed
and now we're going make a better GENPD implementation that will require
to update each device driver with the runtime PM and OPP support before
we could safely enable the state syncing.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ea62f84d1c8b..f63dfb2ca3f9 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -360,6 +360,7 @@ struct tegra_pmc_soc {
 	unsigned int num_pmc_clks;
 	bool has_blink_output;
 	bool has_usb_sleepwalk;
+	bool supports_core_domain;
 };
 
 /**
@@ -3029,6 +3030,7 @@ static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 }
 
 static const struct tegra_pmc_soc tegra20_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = ARRAY_SIZE(tegra20_powergates),
 	.powergates = tegra20_powergates,
 	.num_cpu_powergates = 0,
@@ -3089,6 +3091,7 @@ static const char * const tegra30_reset_sources[] = {
 };
 
 static const struct tegra_pmc_soc tegra30_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = ARRAY_SIZE(tegra30_powergates),
 	.powergates = tegra30_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
@@ -3145,6 +3148,7 @@ static const u8 tegra114_cpu_powergates[] = {
 };
 
 static const struct tegra_pmc_soc tegra114_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = ARRAY_SIZE(tegra114_powergates),
 	.powergates = tegra114_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra114_cpu_powergates),
@@ -3261,6 +3265,7 @@ static const struct pinctrl_pin_desc tegra124_pin_descs[] = {
 };
 
 static const struct tegra_pmc_soc tegra124_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = ARRAY_SIZE(tegra124_powergates),
 	.powergates = tegra124_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra124_cpu_powergates),
@@ -3386,6 +3391,7 @@ static const struct tegra_wake_event tegra210_wake_events[] = {
 };
 
 static const struct tegra_pmc_soc tegra210_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = ARRAY_SIZE(tegra210_powergates),
 	.powergates = tegra210_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra210_cpu_powergates),
@@ -3543,6 +3549,7 @@ static const struct tegra_wake_event tegra186_wake_events[] = {
 };
 
 static const struct tegra_pmc_soc tegra186_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = 0,
 	.powergates = NULL,
 	.num_cpu_powergates = 0,
@@ -3677,6 +3684,7 @@ static const struct tegra_wake_event tegra194_wake_events[] = {
 };
 
 static const struct tegra_pmc_soc tegra194_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = 0,
 	.powergates = NULL,
 	.num_cpu_powergates = 0,
@@ -3745,6 +3753,7 @@ static const char * const tegra234_reset_sources[] = {
 };
 
 static const struct tegra_pmc_soc tegra234_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = 0,
 	.powergates = NULL,
 	.num_cpu_powergates = 0,
@@ -3791,6 +3800,14 @@ static void tegra_pmc_sync_state(struct device *dev)
 {
 	int err;
 
+	/*
+	 * Newer device-trees have power domains, but we need to prepare all
+	 * device drivers with runtime PM and OPP support first, otherwise
+	 * state syncing is unsafe.
+	 */
+	if (!pmc->soc->supports_core_domain)
+		return;
+
 	/*
 	 * Older device-trees don't have core PD, and thus, there are
 	 * no dependencies that will block the state syncing. We shouldn't
-- 
2.30.2

