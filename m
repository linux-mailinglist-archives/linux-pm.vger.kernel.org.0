Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865F82AE591
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbgKKBQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732835AbgKKBPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:48 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B1C0613D3;
        Tue, 10 Nov 2020 17:15:46 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so528128wmd.4;
        Tue, 10 Nov 2020 17:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ut4rNgrrQw383P8FZa2N0ozXLVcx9JLLFGbYsH5MMcE=;
        b=FIvymeTa4qhjvdozHUJ7j/NUkCXDPK7UYL9sYlPhqYsLXEfKZr/ny/NDjFjUWA/9fi
         RJffe06XJr2Gf1ew+QdNiZ8gg8BYhmMb0Vc2zlgW9sUOd1uU/Rjkrfu+0GLxuZ2CiLM0
         UmH9IEJ5NOK6RuU3UG+Wlm475OfyC/lWzvJ+8+61tMdNMKxb88NhzIUoQEopkKX8atHs
         LOTYnSIPcS8yPz4hHyQUGdzd8GbmwCkEr6+QA8mVQAq5Soo7EayvjFvSdTfZWnr7QcP/
         FdUx/DxujAEcjL5p32ixFOn87pLjH3EgY+WoOnv/qvPX/XTK+dC24b/Rras2AKmqzYQ5
         vkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ut4rNgrrQw383P8FZa2N0ozXLVcx9JLLFGbYsH5MMcE=;
        b=pdUinbrU16mZVvFCWcA4/iekks+7P70DT0mJZbW0TlxSfjT1bpIpq6eoed70qPmvfc
         /irmMtY/feifKHJFMsXbWkvq2RGdNnvfPiReN9l9kJzTO6CY/DKOUlSjN6Fu4DgWiD3f
         b26SpXQcroxsGlELAX5s/mez5PBi5kVMxaGSXvobVI2qxBGq3qleu5rcPz84o/+vAo4E
         eZtWpG6Sh5N5L1uDhYZnn+O86o79nP4HwNN2o7Lxh6kBARyQuiznkrtF33uF+o5krqVd
         O6haWoqiTjYV+usqvUKgO0nqLQDYo1BbjwjGBJ+DDwetq3ac2/xoOVYKrU8QT8LlmlAh
         hRZw==
X-Gm-Message-State: AOAM533RwWOgWnchlKqc0QlusQWvHUgytOH9cEBfdxqBZZOEwkiW87BO
        u/1dXD23KNgHxKRqQZqmdX0=
X-Google-Smtp-Source: ABdhPJwxGzQ5xUaGGFFdJPTpKZVJkhuXD9dTpwkAPPI4XiYDQTocJkzHBD0UglDuJgZc3y2INCS05g==
X-Received: by 2002:a05:600c:21cc:: with SMTP id x12mr939579wmj.8.1605057345444;
        Tue, 10 Nov 2020 17:15:45 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:44 -0800 (PST)
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
Subject: [PATCH v8 21/26] ARM: tegra: Add interconnect properties to Tegra30 device-tree
Date:   Wed, 11 Nov 2020 04:14:51 +0300
Message-Id: <20201111011456.7875-22-digetx@gmail.com>
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

