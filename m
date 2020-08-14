Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568F0244235
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgHNAIr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgHNAHb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF28C061383;
        Thu, 13 Aug 2020 17:07:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i10so8122500ljn.2;
        Thu, 13 Aug 2020 17:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+P5lHjTDW+fpgZUM8BgJNYEzbDCPkB4hSqWnbuezGc=;
        b=EySEbHRj8lAX/ziH2r7hioBLUDLTOiq1l4nhjtxA6x4iAYbmlGz6BjPEMsVsqH26uS
         SryjeKSCLu2WEg60aUl9/RPthN1aAbIbAWR3OXsBMy5mQACkFvZVtbMM4WHops+1mz3C
         61Y0W+BmFZr0Apgj6lV7qCTCZP4xCqpWdpuNqWxQjFf65iHvPpjCEbpnut71M/n1ODs9
         ZmmYXuMKrQT9FVfSqC/fH/9ipaO8j4ZjZt97YYGMJ9iDuTLuuRdIKuH9evKbRS8fuMR3
         XbEhzzcdLwQ9GKXfwnxwRGK1/xIi2ckb7oJSc6vud4R+6jpZuf1hwBpavMVLNHRclWbb
         bX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+P5lHjTDW+fpgZUM8BgJNYEzbDCPkB4hSqWnbuezGc=;
        b=DXO11xuutk7+5aFzxrgRlCy4EFzXb1euHhCrsOO1ekFdssu5hRoLE2FfXX77MjCYzw
         4YiCsczW/cS/dcKT1ipFHoT3oi1x2lxuYn6m5wrx/LFcQkohLTx7PYda6nJvLu44vOHj
         TDFJaD2GZRjB3CjZ16dP7wzAONLCprych1dV6xjQGktlcjzkOet/I4nVQNU28ddQeQSy
         YMxOft4Xo840BFipQiBcQ21/4hK+kyrvwN1sEzR4+RRGbraHUf/BdQqWQ/yTeAHrnnfL
         mScXfKfUIE2kwXagI28wwLjhtLrjhyh4sCjt7rV98LL3KN22AeLh2Fdkq5tOjshvwMAp
         TShg==
X-Gm-Message-State: AOAM533OpuZmgqYcagwIANO3xNV6Cb/W6teMls2wdeAN4ZWAS5aQv7GN
        ENUZePfaUPWwEmTHBUdxk85zf58M
X-Google-Smtp-Source: ABdhPJxN2MUM9Mw5JSHMWrAhsyOHEh6piHoXBwWqQRZ7a0KEkuP3vubYu1Eb8DMZZs8aWTIwlcECNA==
X-Received: by 2002:a05:651c:284:: with SMTP id b4mr110032ljo.278.1597363649040;
        Thu, 13 Aug 2020 17:07:29 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:28 -0700 (PDT)
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
Subject: [PATCH v5 25/36] ARM: tegra: Add interconnect properties to Tegra20 device-tree
Date:   Fri, 14 Aug 2020 03:06:10 +0300
Message-Id: <20200814000621.8415-26-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra20.dtsi | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 72a4211a618f..629ad101c43b 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -111,6 +111,15 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
+					<&mc TEGRA20_MC_DISPLAY0B &emc>,
+					<&mc TEGRA20_MC_DISPLAY0C &emc>,
+					<&mc TEGRA20_MC_DISPLAY1B &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -128,6 +137,15 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA20_MC_DISPLAY1BB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -630,15 +648,17 @@ mc: memory-controller@7000f000 {
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#reset-cells = <1>;
 		#iommu-cells = <0>;
+		#interconnect-cells = <1>;
 	};
 
-	memory-controller@7000f400 {
+	emc: memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#interconnect-cells = <0>;
 	};
 
 	fuse@7000f800 {
-- 
2.27.0

