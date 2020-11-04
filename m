Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB34F2A6ACE
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgKDQw6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbgKDQt6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:58 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2360FC0613D3;
        Wed,  4 Nov 2020 08:49:58 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id v19so18769127lji.5;
        Wed, 04 Nov 2020 08:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMjVAb/o+piDt6czNf33ZOuiJhcOMgOALVgnOUvCv+Q=;
        b=J5T6DekOX2/mStRW2kN+A42EuaML774sXiKphiTQpyCZB1Q3Z1tK4AuJa7JZJggCLP
         18BrszdwXTp7Xl+6S8EcJAO2jHjHh3OpTjVPeizFtXT1zuF0N0xHfGMATTxdM+hC7CLk
         9NZFOJ/kSMJYvsO2csoCvgZQJ60jCU65GVRtqn68Z25XSyZkIXdOojKqdSJiw+JCT6ZN
         1uJyN5ztkmMEs+zsajEeYKjuXs0ezL2Y5/k5oj7I3RMdkXjWSlGcI6mvzSDddjqj6olh
         gVwvdfnuQCFNEZ3RIu0QStI2kH/4Y99S5yOCgCnpYgWChGrncAAdR4MZggy02TgTsERE
         /D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMjVAb/o+piDt6czNf33ZOuiJhcOMgOALVgnOUvCv+Q=;
        b=bz55iilDmCfcPUXXfe28YCER44sMKFe7wmhYEE294RM3mGd5t2M4StgBpjtP1iPz7K
         lE/EzJEK3mDhGHM/QNVAE9Igqh5NYcH1y2Z0ZzsTOEvMZL0Nd7WjNRheMsQjwlUN/uCZ
         0DaWRD/Sb2Rj15pMSd/EvETNeVDP8KQ/XKJcCfyuZ+MkqzNbPOriRm7nWFfA0G4Lnt2Z
         GW3zCcoje65QseFEKZKhuQW0nRgwdbjWn/yZgNqzewVNAqVZxjYnBaUgc33XDzd2gx44
         a7eK1mOLuI5h/bC48BVQIQvBdb7nD5/bSAn9JqpTspi6yDWhynQIrt4v690ah7HGE5LE
         8rlA==
X-Gm-Message-State: AOAM5339OgBuyKc9hrxm0VXKIuf90KKkg//yxebuUJ2wWKwIUD1XBW1n
        Lo4c9VA12YoBwSy9qEdnHnY=
X-Google-Smtp-Source: ABdhPJz2HGD4TXgSItk7Rtigv8YIrUYlQARDbDYB5TdVTsgs37ssyr908bh9eWipG2f7efdAPz6+/g==
X-Received: by 2002:a05:651c:234:: with SMTP id z20mr11824370ljn.337.1604508596400;
        Wed, 04 Nov 2020 08:49:56 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:55 -0800 (PST)
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
Subject: [PATCH v7 22/47] ARM: tegra: Add interconnect properties to Tegra30 device-tree
Date:   Wed,  4 Nov 2020 19:48:58 +0300
Message-Id: <20201104164923.21238-23-digetx@gmail.com>
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
2.27.0

