Return-Path: <linux-pm+bounces-38578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1465FC84E59
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 988E5350F97
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3ED320CB2;
	Tue, 25 Nov 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmGoHuOW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C6031ED87
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072390; cv=none; b=TB1cS1jmeOCsh9ksNHaBhCrP7T1yC5k8/EU/uaCcy0/k1Op/8bTF6MYohYxGu9z3T/1Jmkc4nAutsaUgiAiuvC7VqwfXo4Wt2AJhYQyYG74G4pnRhkfEGV4GKalkhVcUU+B2xz7fDxusWcOs012KAa96iQul5jSFdJ9KtYSTwC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072390; c=relaxed/simple;
	bh=xUFvUb8oKPEbKpAh29NhrNZ2bfXoPM/j19JqA5bbRxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFKdxeyiDy8fVmja/PaqxYKnnXhBGTZ2PrX46PuedrA5F9KgYjMGVUi2MAAscr+2wB7eKNUq3LwRfwlFCcmAMBmjDGBUptWtcojpIjlmBPbiTjI9nSlsAfkm/dmV313vHEZK+PyYwXNX5x/Vbt8wiamWewm/EWCaow1YhPC/r0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmGoHuOW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59584301f0cso5911239e87.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764072386; x=1764677186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN+F0Xnd3WljGjWpLVxmMpsaxzHe/mQ0Vkjj3hwJW+M=;
        b=GmGoHuOWaR995Lcc79GWMbCFK4Oss6BPSvGUKGkjTD/fy0s4ot8bE+Nlm7J/Yr5LF7
         8F39Gcu6sECcvo64cJ8eaI5q06VXZ12D8uk6kRyRggF69MOM/jUQIVFAUffcE79K7h3j
         YJDbVtvlQ1JyXmfO3S0OxA3BvoOTKl0ZkCMOJ7c1KYOVB5iW42ckgzIUyVe5vJtVuOa9
         Iu+TEwCepv3v5v8syqVEtfyNimIy6XEbFDV/e6aVKLCmHuCqyQ2j26951K4O6m7tho08
         lL1Dwhgs1g0zA93IXwtba0Mrfc2iMxu1YrxeOfxiXNRbcyZjSKVLSi35jdPidD+IXl6i
         SVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072386; x=1764677186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uN+F0Xnd3WljGjWpLVxmMpsaxzHe/mQ0Vkjj3hwJW+M=;
        b=jULQny/mBLyx/tLquVtSlJccTfL7AvCOoVqWXjOlREhXgQsWJjJT10JKSrIN5PM6Ze
         Lk5JxALxZzq4DTrxAMRUOu+Fg2wdlbt+rGALbiNma4JZtQfgj8H2uG5uNxuYMOIziBRw
         gjmjVKpJib88BHY2NuQlE2prAqyEF+ezXV1419t1yJ2xnato1s6dEm0BGFEldfhjWx0n
         JsUc+GQS9mgfO9JCPitGLoui36eN7mrAznuleWTTMeeKl15zNuiFHkBwQdu2XrX/wBPt
         E1BXj6MCWjuvEew4mjIm0w6MUtmmdNP9okn/P8BAXU8lk3kyJcFcHhUqdVktahxPT6jI
         Ja5w==
X-Forwarded-Encrypted: i=1; AJvYcCU3hDq1rg5U3ilnFRH16N97/bbbyus21/lKlbSecNrzDSQn2VqO7Y+YDS1MhUgYy3SntrbVu7q2KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO7ISLAXrgBixZ4bdx1D7wEisdrnMN+zbb7BwJ09UeVlyFe/1D
	rEws1ZZ2Dlk1kOTKGZLVrG1vhxqAKyljiaMSJVdmjqDTEhGXCz9UliO6
X-Gm-Gg: ASbGncs8iYziamfBwdBzn9Erpd8fUC7sW8czAjYGfVpLDcuWJbL9HJI8FAP1RNusFRb
	4r7RQPfLg1NXXZihbjw2U9cW0XywpfKK9lfDFQ//5Y6pmVdUML3qgIn84SV3SB9K80EIFWhNZfL
	xDI0+l7GQPTFZ2W1xEUAD6dIIV2PKLs5Q7hbPf1h7UrXJ2zPG5tQw8i5MiKWUDFVTw/zqDp6mrb
	Ht5yESHLIKBt+4YQIQQsShyZNllXuoKaUWVzRKKfs8cRw8MXjl9QKzQClvfKG6cK+HMh7mZal2e
	e5eND5V5ujn7rUyMWDG0ZguCrtrmifktEJh2tteHAsF4ZfvqCZEe+rykGWkjHYnkCgCxCkOaE7/
	QeNA8Ra5N17e5/rKsRmqQIMIMMnlzlD3BquuobxgoTCv+s/eqFn0OUv60Y9gHitt//FnDRQcYoN
	I=
X-Google-Smtp-Source: AGHT+IGkQddv0h4W/kIYw24XVr8lRF2/F0YngAnHGV9hmScDktzlX2Yt8Q6XtITCokbogoFFbpJn9Q==
X-Received: by 2002:a05:6512:159c:b0:595:9152:b932 with SMTP id 2adb3069b0e04-596b526c87bmr786045e87.47.1764072385864;
        Tue, 25 Nov 2025 04:06:25 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbbecb9sm5150993e87.58.2025.11.25.04.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:06:25 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 06/12] clk: tegra: set up proper EMC clock implementation for Tegra114
Date: Tue, 25 Nov 2025 14:05:53 +0200
Message-ID: <20251125120559.158860-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125120559.158860-1-clamor95@gmail.com>
References: <20251125120559.158860-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove current emc and emc_mux clocks and replace them with the proper EMC
clock implementation for correct EMC driver support.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/clk/tegra/clk-tegra114.c | 39 ++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 8bde72aa5e68..853ef707654a 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -622,10 +622,6 @@ static const char *mux_plld_out0_plld2_out0[] = {
 };
 #define mux_plld_out0_plld2_out0_idx NULL
 
-static const char *mux_pllmcp_clkm[] = {
-	"pll_m_out0", "pll_c_out0", "pll_p_out0", "clk_m", "pll_m_ud",
-};
-
 static const struct clk_div_table pll_re_div_table[] = {
 	{ .val = 0, .div = 1 },
 	{ .val = 1, .div = 2 },
@@ -672,7 +668,6 @@ static struct tegra_clk tegra114_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_csi] = { .dt_id = TEGRA114_CLK_CSI, .present = true },
 	[tegra_clk_i2c2] = { .dt_id = TEGRA114_CLK_I2C2, .present = true },
 	[tegra_clk_uartc] = { .dt_id = TEGRA114_CLK_UARTC, .present = true },
-	[tegra_clk_emc] = { .dt_id = TEGRA114_CLK_EMC, .present = true },
 	[tegra_clk_usb2] = { .dt_id = TEGRA114_CLK_USB2, .present = true },
 	[tegra_clk_usb3] = { .dt_id = TEGRA114_CLK_USB3, .present = true },
 	[tegra_clk_vde_8] = { .dt_id = TEGRA114_CLK_VDE, .present = true },
@@ -1048,14 +1043,7 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base,
 					     0, 82, periph_clk_enb_refcnt);
 	clks[TEGRA114_CLK_DSIB] = clk;
 
-	/* emc mux */
-	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
-			       ARRAY_SIZE(mux_pllmcp_clkm),
-			       CLK_SET_RATE_NO_REPARENT,
-			       clk_base + CLK_SOURCE_EMC,
-			       29, 3, 0, &emc_lock);
-
-	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
+	clk = tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC,
 				    &emc_lock);
 	clks[TEGRA114_CLK_MC] = clk;
 
@@ -1321,6 +1309,26 @@ static int tegra114_reset_deassert(unsigned long id)
 	return 0;
 }
 
+static struct clk *tegra114_clk_src_onecell_get(struct of_phandle_args *clkspec,
+						void *data)
+{
+	struct clk_hw *hw;
+	struct clk *clk;
+
+	clk = of_clk_src_onecell_get(clkspec, data);
+	if (IS_ERR(clk))
+		return clk;
+
+	hw = __clk_get_hw(clk);
+
+	if (clkspec->args[0] == TEGRA114_CLK_EMC) {
+		if (!tegra124_clk_emc_driver_available(hw))
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	return clk;
+}
+
 static void __init tegra114_clock_init(struct device_node *np)
 {
 	struct device_node *node;
@@ -1368,7 +1376,10 @@ static void __init tegra114_clock_init(struct device_node *np)
 	tegra_init_special_resets(1, tegra114_reset_assert,
 				  tegra114_reset_deassert);
 
-	tegra_add_of_provider(np, of_clk_src_onecell_get);
+	tegra_add_of_provider(np, tegra114_clk_src_onecell_get);
+	clks[TEGRA114_CLK_EMC] = tegra124_clk_register_emc(clk_base, np,
+							   &emc_lock);
+
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
 	tegra_clk_apply_init_table = tegra114_clock_apply_init_table;
-- 
2.51.0


