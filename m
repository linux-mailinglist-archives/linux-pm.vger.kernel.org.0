Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E862BFD92
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 01:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgKWAb5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 19:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgKWAba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 19:31:30 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3751C0613CF;
        Sun, 22 Nov 2020 16:31:29 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y7so1246026lji.8;
        Sun, 22 Nov 2020 16:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dchum/w5tW6S8qZoSmLsyitcs7JqpsShTrIAD3uRjUU=;
        b=J9nvRBz6Js/3sgpIHkpAp2rDUTMw5pKAFbwUpoYVu0lfan8DJ+kjCH8AtXBeEEvXSU
         PJ7PWqIxA2GsCBg3XGIoiZebGSXQScYYX73Na/+STvQQ9iBlA9JVvINCDc+YWda7NsHu
         3hXqPpZQesgXDmVZI0DWF50yaJe0d7xjlBhTQM0PhgZw57NvhE2y2bIrCbJ2dwyNYDPp
         jtKUIEcKoBoQYF0aReziDUA1ni67nQDgmk8Bz4ADBABGh9wr9wPXMeQgqs1lJbmnjlty
         SBA6IfK601FUd+TmZafFA+BUiTfSaG9evjHWinTXr7EDqIylq3McyrREZ5w1CMBxCtaW
         erSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dchum/w5tW6S8qZoSmLsyitcs7JqpsShTrIAD3uRjUU=;
        b=PaNddvvYaVPTRLgeZ7nwoUYBkYlrrddv3IC9nUHz244IVx/d1dx2RxR06sv+9nRg5L
         Gm1B7f1QefHQyPVbbK1lGA8wkE5qNnha2aVDQSHlCdGHTPTVQAYpr5INTWgY21Co94kd
         NNjNHm/gC+dqcgpEISytaxuy0UFSicDF9H8XyGf3FRtyGSOptXy6G56wkAq60cn4W3wR
         N9cdaQR57UdksRLdMx+qN6srUQQ3V5ErxW0XPc2fm0aEV3/C0FW0hdz8kKSp/B5HqPFL
         7Z8reTccI27r62nPupr1G3hIOQWpKks6PT9zkmazLruQrNLv5ea7hi+MYgnRaPgxV4+g
         GW7Q==
X-Gm-Message-State: AOAM530vz5ASF1UdowjQJCOYvCLrFcRKzVKuR38scu9cs1hzWzkvM59A
        nDDPTwCVQho92hcJxRzoe8k=
X-Google-Smtp-Source: ABdhPJxEJhSidQzxn6kqr5+uZqLMCHycJHz+Y9DBjIFbucmabSO5Jsye5L0YZOEMU5Jnnk1z0cyk3Q==
X-Received: by 2002:a05:651c:119b:: with SMTP id w27mr11546092ljo.189.1606091488478;
        Sun, 22 Nov 2020 16:31:28 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id r27sm1225823lfn.290.2020.11.22.16.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 16:31:28 -0800 (PST)
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
Subject: [PATCH v10 13/19] ARM: tegra: Add interconnect properties to Tegra20 device-tree
Date:   Mon, 23 Nov 2020 03:27:17 +0300
Message-Id: <20201123002723.28463-14-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123002723.28463-1-digetx@gmail.com>
References: <20201123002723.28463-1-digetx@gmail.com>
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

