Return-Path: <linux-pm+bounces-34637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB81BB57266
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE357A1164
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9412E9ED1;
	Mon, 15 Sep 2025 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw/eqHKQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721792ED15F
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923359; cv=none; b=VNMoXK9jU/T00cVRFfr0i4oXZgT2kXAxLZmK1HBymsgv0bcNpz48itosD+8uocyuQMyleWbEYr/DLjNbLAhprCXBg0+pEt2vtGjBsfLJyT5nMOZeaRoP90WfnA5zU4rFehw7wN0V06uJGCmpmKoDvWFpZ7/GMIkI1KI3rqZ9tQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923359; c=relaxed/simple;
	bh=puO7Z2ig7bVHyLqZNo9tVY79xCx9TFwpjX8RCxEGwRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpCuAELVk0MqaEsO9aSfCnm+Ocp0pELnupU3a8EfAmvMFv45TzYCr/5Gby5Utk9U14A75F8UefFc+hZo8LyF4yWP4DBawKzXEvHlv7JxCWv7QPkGP69QeGXdp4ja99dXutAZ+xms7Ec7Do+nLeBDGkCmNDNR9jenWfNq9+YTlX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw/eqHKQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f753ec672so4280045e87.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757923355; x=1758528155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEtH9m2WWLRtkmEZlpTibWNlPxTQz5oYIW0vldsEJ1I=;
        b=Uw/eqHKQH759QVtfpA56Cz+TcpmP6eLClZRMF3hb4TBVw1jrw0FcnSblh2shS9YL1J
         zpKenvTp46iIwVwfUYUsHVdLNTWRF8sdj8HKvX5e5S1kj1zZdDcaOqAUXm9eWxjy1MxV
         d7oBT0823rQA0Gqrk5uLe2FUngjduBTtJRPVL507ORhrtLNiJdKE/xUgbhc4BChMtYGK
         FAuwKjURVsmJQ9BjewAMmZMeVoyrmL7EcfpLmZ9wKaLuRJCnGFIkmIHkGYNkW6r7v+QV
         dl8N0yiVwLtIYU9RwafU0u2VX52wJOCAxZJoo1DcVUR8Li+Jl80dQDq89NPllcd5o5k9
         UidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923355; x=1758528155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEtH9m2WWLRtkmEZlpTibWNlPxTQz5oYIW0vldsEJ1I=;
        b=nQJKk6tDHhy9H2A5BIqzkUUt/gI15/re0PZkuiTKHLXUqThOKyRsSdD3cgcFXkvU3m
         LfoGYP+K2X1g1dS+v4vkiHdrsWwbF2L0i3D1pHjpL5ci7E/G0a23117hNMV/aN3vwVGt
         sLIHhNE/wUhlfgL+tn4nc9jS3S7op/4PzWDnTHBviYx7m2zfUEcr4tRQeaEsPSlgq6tC
         Ad81F5DbzicKX75+KTbGsYZvNddCJ+MQqA/Lfcul/lNQPmAeRceolHZPAR75WL9xRDzz
         jr8vrW4d5ycqWOTrZEggUxPNtILNdnbJ8ZbaP6lhWHwsM3jcKGmWOoYq9ScZaK+8Q9wo
         BM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7+oQdomPM0BbF+msEKl6xxRJ8khkRvxjfAls0E4Y8Qoa66gDBL6ooV3JpMZmgwSdMTvt6EMq1DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySjMwdVCAyj52Ae1vaxWPtgmGCVDBkC764lzes7zilfbehr/lu
	Rv7e1PsgYXQJUTDNJZljoy/SN8bm766/u4xJImJWf5NWB9cbfUMeAJFT
X-Gm-Gg: ASbGnctubyNoNlTHEbdFmfBlgsK6dw8fZWYrjCmUvas654x/klMluKLSPvCVuHOcpkp
	9tY1fpARt6nHiKVZjcQzlCATCT6CoAT0ZShuBpHmpBFC0eBCWuvPoFMBLYAefKYCTFCDAYiXtRx
	9Qr33qGGErat5w20N41YuO5yWF4fukMZdOiJBUIRiu/hcnrHst7OPK/2lv0exSYA8M6TI8qdXS7
	DhvGI1EKugctgv8s7hZRNLRD9wgZ4ImLFf+5+L/gcdzV+sjwMlJlL7k7Z4CPsW6nNCQyOJAZD1z
	vkCadOYXkssBmDBdssmDyWapkikUrc5tRKH0llxw3MGlH99hTY9ZOpWB+vT11/YWCJveGg0P5C/
	pUHSdrh9YkliXpsF95KgyL9f3
X-Google-Smtp-Source: AGHT+IEKN/WBSja25bX0EJtV7wdUVhCYQ1e2EXZOxTpthrA0BYE4lFGyAd4m24x3Q7K2qjVYX0+ALA==
X-Received: by 2002:a05:6512:712:b0:55f:6fb4:e084 with SMTP id 2adb3069b0e04-57050fe4cbemr2642059e87.50.1757923355280;
        Mon, 15 Sep 2025 01:02:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm3392381e87.103.2025.09.15.01.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:02:34 -0700 (PDT)
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
Subject: [PATCH v3 10/11] ARM: tegra: Add EMC OPP and ICC properties to Tegra114 EMC and ACTMON device-tree nodes
Date: Mon, 15 Sep 2025 11:01:56 +0300
Message-ID: <20250915080157.28195-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915080157.28195-1-clamor95@gmail.com>
References: <20250915080157.28195-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EMC OPP tables and interconnect paths that will be used for
dynamic memory bandwidth scaling based on memory utilization statistics.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../dts/nvidia/tegra114-peripherals-opp.dtsi  | 151 ++++++++++++++++++
 arch/arm/boot/dts/nvidia/tegra114.dtsi        |   9 ++
 2 files changed, 160 insertions(+)
 create mode 100644 arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi

diff --git a/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi b/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi
new file mode 100644
index 000000000000..1a0e68f22039
--- /dev/null
+++ b/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	emc_icc_dvfs_opp_table: opp-table-emc {
+		compatible = "operating-points-v2";
+
+		opp-12750000-900 {
+			opp-microvolt = <900000 900000 1390000>;
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp-20400000-900 {
+			opp-microvolt = <900000 900000 1390000>;
+			opp-hz = /bits/ 64 <20400000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp-40800000-900 {
+			opp-microvolt = <900000 900000 1390000>;
+			opp-hz = /bits/ 64 <40800000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp-68000000-900 {
+			opp-microvolt = <900000 900000 1390000>;
+			opp-hz = /bits/ 64 <68000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp-102000000-900 {
+			opp-microvolt = <900000 900000 1390000>;
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp-204000000-900 {
+			opp-microvolt = <900000 900000 1390000>;
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x000F>;
+			opp-suspend;
+		};
+
+		opp-312000000-1000 {
+			opp-microvolt = <1000000 1000000 1390000>;
+			opp-hz = /bits/ 64 <312000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp-408000000-1000 {
+			opp-microvolt = <1000000 1000000 1390000>;
+			opp-hz = /bits/ 64 <408000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp-528000000-1050 {
+			opp-microvolt = <1050000 1050000 1390000>;
+			opp-hz = /bits/ 64 <528000000>;
+			opp-supported-hw = <0x000E>;
+		};
+
+		opp-528000000-1100 {
+			opp-microvolt = <1100000 1100000 1390000>;
+			opp-hz = /bits/ 64 <528000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp-624000000-1100 {
+			opp-microvolt = <1100000 1100000 1390000>;
+			opp-hz = /bits/ 64 <624000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp-792000000-1100 {
+			opp-microvolt = <1100000 1100000 1390000>;
+			opp-hz = /bits/ 64 <792000000>;
+			opp-supported-hw = <0x000F>;
+		};
+	};
+
+	emc_bw_dfs_opp_table: opp-table-actmon {
+		compatible = "operating-points-v2";
+
+		opp-12750000 {
+			opp-hz = /bits/ 64 <12750000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <204000>;
+		};
+
+		opp-20400000 {
+			opp-hz = /bits/ 64 <20400000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <326400>;
+		};
+
+		opp-40800000 {
+			opp-hz = /bits/ 64 <40800000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <652800>;
+		};
+
+		opp-68000000 {
+			opp-hz = /bits/ 64 <68000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <1088000>;
+		};
+
+		opp-102000000 {
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		opp-204000000 {
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <3264000>;
+			opp-suspend;
+		};
+
+		opp-312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <4992000>;
+		};
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <6528000>;
+		};
+
+		opp-528000000 {
+			opp-hz = /bits/ 64 <528000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <8448000>;
+		};
+
+		opp-624000000 {
+			opp-hz = /bits/ 64 <624000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <9984000>;
+		};
+
+		opp-792000000 {
+			opp-hz = /bits/ 64 <792000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <12672000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index e386425c3fdf..e2bc8c2cc73c 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/soc/tegra-pmc.h>
 #include <dt-bindings/thermal/tegra114-soctherm.h>
 
+#include "tegra114-peripherals-opp.dtsi"
+
 / {
 	compatible = "nvidia,tegra114";
 	interrupt-parent = <&lic>;
@@ -259,6 +261,9 @@ actmon: actmon@6000c800 {
 		clock-names = "actmon", "emc";
 		resets = <&tegra_car TEGRA114_CLK_ACTMON>;
 		reset-names = "actmon";
+		operating-points-v2 = <&emc_bw_dfs_opp_table>;
+		interconnects = <&mc TEGRA114_MC_MPCORER &emc>;
+		interconnect-names = "cpu-read";
 		#cooling-cells = <2>;
 	};
 
@@ -591,6 +596,7 @@ mc: memory-controller@70019000 {
 
 		#reset-cells = <1>;
 		#iommu-cells = <1>;
+		#interconnect-cells = <1>;
 	};
 
 	emc: external-memory-controller@7001b000 {
@@ -601,6 +607,9 @@ emc: external-memory-controller@7001b000 {
 		clock-names = "emc";
 
 		nvidia,memory-controller = <&mc>;
+		operating-points-v2 = <&emc_icc_dvfs_opp_table>;
+
+		#interconnect-cells = <0>;
 	};
 
 	hda@70030000 {
-- 
2.48.1


