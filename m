Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C0A2A6ACB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgKDQt6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731533AbgKDQt5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:57 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA4CC0613D3;
        Wed,  4 Nov 2020 08:49:56 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l28so27978649lfp.10;
        Wed, 04 Nov 2020 08:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qXc6alv2GyhB3hhhLZedHDIUdftmQRoQ6V9Gv1leNe8=;
        b=Af0j9cQyYfqwGbLNFMo8DQIbaHxPcvuBSdMbyhlOHUzt5ONJ9XckN8qb/gJe8W0Kax
         8dqF6rNmTRvckvxhSt5vUrX9Fz5POWuCbXtXka2MhNt4wm0+lj2gJk7ZaFPlxGEVw2jh
         t/2wgt+iBONe4r/ISY4f2E4A6CvXXg7FotjG8H8XZI6DrKz7iiIte2dowE9Y2KEyZA7a
         8e4kFZjJRTS2mANq/Grexnd1PzuveBBsFv8E35PY/EmpiNLwIXUrMPX05yVBLYFCEN/J
         9VUUGVugNuyC7Z8tKrS4DtpEWHjTiwHX5DxHTVSrVrgBGoTzscatoKUltYZRN3M60QSc
         s+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qXc6alv2GyhB3hhhLZedHDIUdftmQRoQ6V9Gv1leNe8=;
        b=CpTIGKPDE/eUWpfvyT4JuEy0RtmAyoI59fNs5sf2VVJd4ckSNiENH8o6XFSeFeFZpL
         wK5/VH2cSrjat3Ym4zjDr5FMnXHXCITeVYsCXFgEt9uGot7uD4DdUwQE5OXvvY4BejFW
         WzrdNkwV1rE6agvEneekvE4wWRdNFQz5wsgsNEr4KF69x7J1/XXdz5h9PFbLW5l2YWdl
         eLciXfL7MunE8YtA7TctwR+7wwhGFhCecIM786mpeetYdjPwIFaCwYGGtcHDMB5oxBvd
         rXI8/6T58cUBmozB9dzwlcrb4r0ZZwTeSnObIAv7M6a7iaX0E4/BfoZODWZbw9lrksOe
         Vm9g==
X-Gm-Message-State: AOAM531fnkibHlb0Y4RmcvWw9F0CS7cO7fTPno4jE7PW06j7sJHUTj3v
        DZ+vniT0mxz7EQuO3WwKJs8=
X-Google-Smtp-Source: ABdhPJzbvyLORoXyQj3/KlGwtfFDf00kuQbn6UHu0zwxqEPLW3MMMC/l9l2xEy8HWSLg8WtRXbvnjA==
X-Received: by 2002:a19:441:: with SMTP id 62mr9370540lfe.304.1604508595182;
        Wed, 04 Nov 2020 08:49:55 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:54 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 21/47] ARM: tegra: Add interconnect properties to Tegra20 device-tree
Date:   Wed,  4 Nov 2020 19:48:57 +0300
Message-Id: <20201104164923.21238-22-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect properties to the Memory Controller, External Memory
Controller and the Display Controller nodes in order to describe hardware
interconnection.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9347f7789245..2e1304493f7d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -111,6 +111,17 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
+					<&mc TEGRA20_MC_DISPLAY0B &emc>,
+					<&mc TEGRA20_MC_DISPLAY1B &emc>,
+					<&mc TEGRA20_MC_DISPLAY0C &emc>,
+					<&mc TEGRA20_MC_DISPLAYHC &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -128,6 +139,17 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA20_MC_DISPLAY1BB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA20_MC_DISPLAYHCB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -630,15 +652,17 @@ mc: memory-controller@7000f000 {
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#reset-cells = <1>;
 		#iommu-cells = <0>;
+		#interconnect-cells = <1>;
 	};
 
-	memory-controller@7000f400 {
+	emc: memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x400>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#interconnect-cells = <0>;
 	};
 
 	fuse@7000f800 {
-- 
2.27.0

