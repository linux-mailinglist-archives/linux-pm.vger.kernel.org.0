Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2042AE58C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbgKKBPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732816AbgKKBPr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:47 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F266BC0613D1;
        Tue, 10 Nov 2020 17:15:44 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so534588wmb.5;
        Tue, 10 Nov 2020 17:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dchum/w5tW6S8qZoSmLsyitcs7JqpsShTrIAD3uRjUU=;
        b=m9NDdA8OOZIq2hLYDAs/C4kbBePsA4I65uhZCDFtyB53kehuGAgUVHckVWCXcSWLDx
         6ybiptEWUIdAQhAz1rL9Mvfcn3MeGB9XrxG88rPWRExt47SCxhmv/wA5KZAMhGO7ogj7
         E31/v4uR12KothdxIyjF6AFd6LmwTZgnGdU83ChmYVxDmA14RoPdpw8nXyCczabnrWxp
         YeirpxKSEoMXN/tbuUn2JQWv8jxGY1hCVwAGHQ/IdpGd5CFJ1hQLnwFUqMDIqRB8Uutm
         Vvxr8u7djXicfQ2meM/WoNhnUuQVHO/G9CmbyWmlIOoZg8mmvP/Ap7JSb4XV6trUFLhn
         XFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dchum/w5tW6S8qZoSmLsyitcs7JqpsShTrIAD3uRjUU=;
        b=PhmugDoJqbnKT10407aJvajY7+PE1+CXjPOlJZjLxNJfW2OuvYn6nVDKKTHp4R+Xsd
         u2yQ5lignJCQlqGzMescndIrpK8g++84I1MLKhDcQ2XZe2yQT6kJDiGF1BjbVJOAHZ1v
         gaXAMYfdsyffZMHqw7DM7z+2KxmsCYDnqotmoqKvsTb5fsrjYDabMuFZ0flgyry5AcDG
         cFs41xYaqy4Csw/u0VJcuKM3kMZs08DbcV407m7iQN0wNqXWVWwG9FkCBKgr/l0qfQ5t
         tw7wPwWmG2ePzeTiqo9NaxErUKGHQehbS64uU1rJ8U0gLLONu3HgFoDudM9z6K7t+40M
         +S8g==
X-Gm-Message-State: AOAM530i6bU7VEWoKN/wY6X8DNnV+WqQt8YpRa0GNq4qnJ8v2SMP9C26
        y6SeRFyU9jBi5cW/xfOF290=
X-Google-Smtp-Source: ABdhPJzs0bRwr/NryVGDcaMMn0Cs3kjM8URNT94BureqqJTHZIkhv/pU3SvX1KEK+orredPlZTL97g==
X-Received: by 2002:a1c:2d93:: with SMTP id t141mr950325wmt.104.1605057343686;
        Tue, 10 Nov 2020 17:15:43 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:43 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v8 20/26] ARM: tegra: Add interconnect properties to Tegra20 device-tree
Date:   Wed, 11 Nov 2020 04:14:50 +0300
Message-Id: <20201111011456.7875-21-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
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
2.29.2

