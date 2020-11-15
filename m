Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B435B2B39A2
	for <lists+linux-pm@lfdr.de>; Sun, 15 Nov 2020 22:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgKOVdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 16:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgKOVdb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 16:33:31 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ECCC0613CF;
        Sun, 15 Nov 2020 13:33:30 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id r17so17831323ljg.5;
        Sun, 15 Nov 2020 13:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ut4rNgrrQw383P8FZa2N0ozXLVcx9JLLFGbYsH5MMcE=;
        b=GRtqvc2q8dO93a60kdUhp5K3pOxuG68UyAX4VACO/4y99AktJpF5l3dpSpOTVI7Rb8
         eh+nOtCAxu1mcySJr+fPmU0QMWdCtngc9RyIzyrALuaxu0mFhh15GAWVjdLJCRrruL8U
         VO0WK6TcWKacjeBcMw280Ixi6qLMDRD5+0YObSy6ItyBDhawLXSn+Zu+6cOiGI2nf+3v
         JQ2W+nS+ExuRw73flIaAW9/7F1nNmj5B+z9CqZng09JOnAWVrYhXRSz6vVDeF3wsW6m/
         1GL2c7UMzR6nHzoVDQ44bNOLBvW0IuludV/25pPp4ekU9knyMlAdhfLfalzsLRGMjVUu
         Dgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ut4rNgrrQw383P8FZa2N0ozXLVcx9JLLFGbYsH5MMcE=;
        b=EW2S/5EH9S21bHClYBgGzLze8oQuXkcPlIlVzP1bvakNJaSbmcQzzd7hC6h+hoRzEp
         6CdOiDxP1pga8YNYgOgF/v9nnBR3vFHNQW0Gj7YCOhoTBQLtQz5+Hu8E85bWRhtYX2NN
         u4OL3QCsP5dWSdhp1/WuhHK+fzM/KfZDk2OLQ7Y245ZyOdR5yzj1asZqOO2IW8TOyiub
         Gi8AE17O7rBJiMMAvE8MFpIkBWIzRg3xwpHLFLgRhKVxSCugFCicluVOYh1NA/2ggCO2
         cYhlA2oXQl7ltJVshc79F9pACTVBuZTAYqBugCR/oPnKohx87s4vAIBs9eXrMlloX2q5
         NWAQ==
X-Gm-Message-State: AOAM530Mvny4GuC7FxIy/2M694Ke3LPvJFVyi0F0rgeiTzK7/bxn1rOS
        FXkHgsRRyOaZQ/4UzUtc/3s=
X-Google-Smtp-Source: ABdhPJxybgnqOCG6DnARd9geNRpBLynab2T192Aru8hxG1In2GacOtt8Ok9PGemMQGZ8YWVH9Z3yyw==
X-Received: by 2002:a2e:908c:: with SMTP id l12mr4733883ljg.60.1605476009369;
        Sun, 15 Nov 2020 13:33:29 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id o3sm2462055lfo.217.2020.11.15.13.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 13:33:28 -0800 (PST)
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
Subject: [PATCH v9 12/17] ARM: tegra: Add interconnect properties to Tegra30 device-tree
Date:   Mon, 16 Nov 2020 00:29:17 +0300
Message-Id: <20201115212922.4390-13-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115212922.4390-1-digetx@gmail.com>
References: <20201115212922.4390-1-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra30.dtsi | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index aeae8c092d41..2caf6cc6f4b1 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -210,6 +210,17 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA30_MC_DISPLAY0A &emc>,
+					<&mc TEGRA30_MC_DISPLAY0B &emc>,
+					<&mc TEGRA30_MC_DISPLAY1B &emc>,
+					<&mc TEGRA30_MC_DISPLAY0C &emc>,
+					<&mc TEGRA30_MC_DISPLAYHC &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -229,6 +240,17 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA30_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA30_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA30_MC_DISPLAY1BB &emc>,
+					<&mc TEGRA30_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA30_MC_DISPLAYHCB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -748,15 +770,18 @@ mc: memory-controller@7000f000 {
 
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
2.29.2

