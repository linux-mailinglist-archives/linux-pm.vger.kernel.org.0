Return-Path: <linux-pm+bounces-33078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBADB353F5
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 08:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69F91B635DE
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 06:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AAF2F619C;
	Tue, 26 Aug 2025 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlFLSu90"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E22F60DD;
	Tue, 26 Aug 2025 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188709; cv=none; b=J3wxc0xfCLtRmrKfl93TFH8D5CzENFdjWbE8cvPL3FiyEkMk4QPX2CKS3uYEC05CJNxoi/soup00gVGqyRyWypAr2RDheAhMKPY2ucDufBiXmIZMUn/2la5a8rU3kWKrq1GvHdYEDTjrCnBeDJ5N/bIXkxqjyQzAOhmKSlDgW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188709; c=relaxed/simple;
	bh=d4ynypXkh046/SxbDpw/eePoh937viG0jPQ5aS67T4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGfz2qbVdEk21EgWeYfYHML6+rK+4/0T5AKog4nJwp4gJgIbnWqcr5ZQZqGzxFgFXyrZyy8GndMBqR+1Iox7PR+tr75eewBDhrQ30cfy9k2dZp+cn7AV0NAfkGrcg9AMGxiCZuZhjxRoKggBxtMoEg0kHFPEFEIVAMW3Rc9oLiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlFLSu90; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb78fb04cso716002766b.1;
        Mon, 25 Aug 2025 23:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756188706; x=1756793506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSSbVBx32nx7XwUzK1dRM1mB0T5Zuh+9epMVFQQWvFU=;
        b=DlFLSu902DQIHtabnf49Cjm8osqd3TnmwiSepSkq1kJXM6xnE3ErNdmTl/pUw4Gso8
         766rFjMOmM+w2SlkKVB/69+cQYkOqS4AY/4xQxXHt2nG0FYBB7JC8UIV1dK9zBbtThso
         /LvTrabJPcgmGkHGNnQTXF6rM6KnqZ4bBniocU6DrUGGKGPk4xE81/Okgrj9z10zI/da
         VQCo6wJvNs/eqwwnHtSxqTLXTfO2j/LfU6ZvFA5qkOgwCLeM0XwUAsgkiBZgeLp+r6ne
         C2aJ2S9FlePDb66aRBBbRdCFNq6YUYQptZTc1VV9lgviIiM1TBPcE8HrxKeVwlRuUIvM
         l2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188706; x=1756793506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSSbVBx32nx7XwUzK1dRM1mB0T5Zuh+9epMVFQQWvFU=;
        b=XLQYoANpovBnFtXlB05uOGYdAmlT0yjuWN6iYUWQ3KUxWtF34R6uOsZaEOz/EtGY2f
         yjvL9TMBHzVvhcpQz9VUhxE5fZdIsZHJmX3wLAu9QfSsxw5yavCEajThcu9KRx3ucWth
         6pCU5J9V9HIGkS3um3l8+tvFCZixsjyeWBQzpV6OJdT5YHG2XkerQOPUI4N6LtNluMbb
         xNfGhfHygeR0sxZaiqxH3H11MXAM0rlhYhj9f5ZHPH0SdjA1I5T5Lwh2kejvcMiyiy3F
         KL6OLb94/frLFWVzRUDkmOfSkQqT67Xq6SLxu3EoCJNfGKykVsOL3w4w2vyinXMvR8pg
         IKyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZof9bnecuAUyPuRuRbXsJIlyLMLAz5YynFobWGhy9R8CNKVN50zH69nlXtfDs0kKCDmSJWfe9dZyROiLr@vger.kernel.org, AJvYcCVfLKR5WtzNK4XHr/y/id4RYTtlYUrpk6xpI2JwWbfDFsCEGhjl309C2n3Cvvg6RTGKpaXsMZeL/4g=@vger.kernel.org, AJvYcCWMdEOEFqxQktCVwzezM1fsfGfP6baT7STEOMbjZAoTJIxmZbef3tuKi3XtsoR+0yLM+xbvi2Fkihg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLweptUJG0pYEpI9PgVxb9hXBMLT8SgkAxVabn1ZpidWcjk7aR
	rxkXwOrnVO3xq30ahoFznyaTLASjeJaN6m9ju0i26o8dCSlzaZkKEBWI
X-Gm-Gg: ASbGncuRluInrQZFonIigmisRaqOOVoW2SBslUZzO/GocJemJ85l3p2tv/GBOER7QGm
	Kx69i77uLCGYivPlWg/AtLkbRDzHRcMlQfpc1CsvkPe13Caw7s2sowm4iCYmvag2pJQlXbfGuPp
	gd2aRx728kBZM+arcRJfmFL31DMWswEZDamivBk92mJARF2iIXUGQWsV96JpVsDB+YtlVFW08OP
	LonZ4OkHiGeBa10O+/oE1otk4dvLBBI1O9oJf4jxsS1sHPq+wMiXtRyWOblKWyK9B3SBl/+iP7y
	Iy3OA1QBtxgwRxV+5woXttgdy4LCtT0WKzOqTNsbUCP7E6NHL5bAEc79bgM0RL5EF0kcyFcrFbA
	RQqOt+3vjeC4gTFyRjpYp8vGK
X-Google-Smtp-Source: AGHT+IH8JQdJfy8puCT3+blDPER8VT1BAM5UiC30k0R8SZJeszPDVtxqiGOaOymvAdfDzTswaekPRA==
X-Received: by 2002:a17:907:fd15:b0:af9:68d5:118d with SMTP id a640c23a62f3a-afe296ec584mr1354460366b.58.1756188706227;
        Mon, 25 Aug 2025 23:11:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe492da4b9sm711067966b.63.2025.08.25.23.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:11:45 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: tegra: Add DFLL clock support for Tegra114
Date: Tue, 26 Aug 2025 09:11:17 +0300
Message-ID: <20250826061117.63643-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250826061117.63643-1-clamor95@gmail.com>
References: <20250826061117.63643-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DFLL clock node to common Tegra114 device tree along with clocks
property to cpu node.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 4caf2073c556..c429478eb122 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/memory/tegra114-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/tegra114-car.h>
 #include <dt-bindings/soc/tegra-pmc.h>
 
 / {
@@ -693,6 +694,29 @@ mipi: mipi@700e3000 {
 		#nvidia,mipi-calibrate-cells = <1>;
 	};
 
+	dfll: clock@70110000 {
+		compatible = "nvidia,tegra114-dfll";
+		reg = <0x70110000 0x100>, /* DFLL control */
+		      <0x70110000 0x100>, /* I2C output control */
+		      <0x70110100 0x100>, /* Integrated I2C controller */
+		      <0x70110200 0x100>; /* Look-up table RAM */
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA114_CLK_DFLL_SOC>,
+			 <&tegra_car TEGRA114_CLK_DFLL_REF>,
+			 <&tegra_car TEGRA114_CLK_I2C5>;
+		clock-names = "soc", "ref", "i2c";
+		resets = <&tegra_car TEGRA114_RST_DFLL_DVCO>;
+		reset-names = "dvco";
+		#clock-cells = <0>;
+		clock-output-names = "dfllCPU_out";
+		nvidia,droop-ctrl = <0x00000f00>;
+		nvidia,force-mode = <1>;
+		nvidia,cf = <10>;
+		nvidia,ci = <0>;
+		nvidia,cg = <2>;
+		status = "disabled";
+	};
+
 	mmc@78000000 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000000 0x200>;
@@ -824,6 +848,15 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
+
+			clocks = <&tegra_car TEGRA114_CLK_CCLK_G>,
+				 <&tegra_car TEGRA114_CLK_CCLK_LP>,
+				 <&tegra_car TEGRA114_CLK_PLL_X>,
+				 <&tegra_car TEGRA114_CLK_PLL_P>,
+				 <&dfll>;
+			clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
+			/* FIXME: what's the actual transition time? */
+			clock-latency = <300000>;
 		};
 
 		cpu1: cpu@1 {
-- 
2.48.1


