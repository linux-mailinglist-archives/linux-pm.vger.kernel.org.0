Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632DB244232
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgHNAIr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgHNAHc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D64C061384;
        Thu, 13 Aug 2020 17:07:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so8090769ljj.7;
        Thu, 13 Aug 2020 17:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Ppkj+RIlaEU3Zu2q0tCXAcFcQlT6qlxYEcEES4iGaE=;
        b=BB3KPQU7JeQ0tqGoKIPs4Y6zvE8d5MGvvct73+HhLFFXmP1t37pSydMO9RqQ1ZmrAg
         /rJ+g25PAN9s76EfX/wLWfA6S+y54Djp3AKdTlmlwPBalx3jFgb07ROTmTGBxR4g7JCh
         NZhoicVBwsir3e13/oEhJE5w9Wqje2f+ps0ePbNQyyZWe3E4uQQLoVO59OSobzJb6F00
         uVm9QJk9J/kJvKYWYaN507EGhynvnjL0TMHBbrN1w357RgjiJe/rx26DhebG0kjsjccu
         a+8n/FUznFJKr/ercQ/d2erwNy8KcXGAhouco7p1sZQ3AllvhGUilbFSwSO4mNPZdyJQ
         7H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Ppkj+RIlaEU3Zu2q0tCXAcFcQlT6qlxYEcEES4iGaE=;
        b=OQIzn3b6V5rvyBuLZ4XGAaARXcFVnwifcNnCWWUxFTWy4zeGc2FP3/K+goxg9GOtSp
         IjCWZBrveB1UJgCPIoPQ9OMU2cpBkRP2pSlotoPp8M6KvhMBbXt/3HlFAqkuV0b19vTg
         juoXD5mLJr11LP7RCtu2REmDuGEyj0RWVnTFC/2VxbVEN2xi148cIFfhRaeYNLm8PhyP
         Gfxed9vGFGXZxFzhdWHND/OIOlJzJTnefCk5RRj3pk1YQiC+5dPCdrW522u/bqPFHkL8
         H0IJqNopmKDL04FuQ7v9yjWYH2HtOGEgFAGSb3JZ+p5ybpJlRhqFoKWk25tmKO97XV71
         2bGw==
X-Gm-Message-State: AOAM532sub/OcZKHpjLldnhhqp+8dpj//rHpL193engmx/jFD3iNVNoN
        5asGvfiLHYkwQuIiPthv0bM=
X-Google-Smtp-Source: ABdhPJwKJRI45dHuv3qf37mXXTOArzIZ2jEK6i1mUDWkeZJB2xD0qRl+5lpZW3otxUBpW9yJG4VQ8g==
X-Received: by 2002:a2e:9792:: with SMTP id y18mr105828lji.187.1597363650081;
        Thu, 13 Aug 2020 17:07:30 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:29 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 26/36] ARM: tegra: Add interconnect properties to Tegra30 device-tree
Date:   Fri, 14 Aug 2020 03:06:11 +0300
Message-Id: <20200814000621.8415-27-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect properties to the memory controller, external memory
controller and the display controller nodes in order to describe hardware
interconnection.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index aeae8c092d41..b28360d3c039 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -210,6 +210,15 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA30_MC_DISPLAY0A &emc>,
+					<&mc TEGRA30_MC_DISPLAY0B &emc>,
+					<&mc TEGRA30_MC_DISPLAY0C &emc>,
+					<&mc TEGRA30_MC_DISPLAY1B &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -229,6 +238,15 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA30_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA30_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA30_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA30_MC_DISPLAY1BB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -748,15 +766,18 @@ mc: memory-controller@7000f000 {
 
 		#iommu-cells = <1>;
 		#reset-cells = <1>;
+		#interconnect-cells = <1>;
 	};
 
-	memory-controller@7000f400 {
+	emc: memory-controller@7000f400 {
 		compatible = "nvidia,tegra30-emc";
 		reg = <0x7000f400 0x400>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_EMC>;
 
 		nvidia,memory-controller = <&mc>;
+
+		#interconnect-cells = <0>;
 	};
 
 	fuse@7000f800 {
-- 
2.27.0

