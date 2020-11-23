Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8972BFD79
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 01:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgKWAbe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 19:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgKWAbb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 19:31:31 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073D7C0613CF;
        Sun, 22 Nov 2020 16:31:31 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id r18so1385708ljc.2;
        Sun, 22 Nov 2020 16:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ut4rNgrrQw383P8FZa2N0ozXLVcx9JLLFGbYsH5MMcE=;
        b=dP2zdOqLZ5ODOB59aKMkhKnWZwJIazjJkUCM5tQ3BdVNTNXTYOg+A8sca9ezdn89eq
         Lt9ZJnnNyfq5oaGiZHQC370BBP221G+FG1Rt/6lVSAgYNoSAGxvbT7QVi2ckpDggn7jM
         aDMqYZogQsQKjb+dr0Z92n6ATWenoLLffY17I3lwPRXZSNuxM8ZaN0qdVwH0yb6a69CM
         xcJavtuywY/VAyRhhOm6/xhElAxGtuGsBtaQ1SBv8GQrhf9yJVuyzpBj4BEgLd9nYWt8
         SfUZq5R0AjWecXz64CerXqPrvtrXyoZwQJCTorjHsYtafJOrjxgTYl3VUYVakWTGGtXQ
         R0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ut4rNgrrQw383P8FZa2N0ozXLVcx9JLLFGbYsH5MMcE=;
        b=egeoesJVqTmyZ1uwcNRUHoPYVqL4fvGQKbcs0gYIlZVinzKD80gMz0GcXf8XIrNUwK
         b0abVy6Ez/KkTndvPacDC06Px3vJC5nw0PAfoxHbXmxLNsUvo+dvyF0ijPz/cekW0N4v
         fDh0RMBpeWM/FzRbkUcy1uua4bdRuJtKjWMcMPz9oMlwVVMo1XvyBdwCQimF2wKhIfaj
         nHyKDqPqm6HrYgoalkE7D+YEhb7JrkbKWYlPBUy6tlBO1ZwhsV22NhJxFrp/17I3y9Sn
         vNkm2RbF8RNC7HpErXgJXsVXyEc6RNA/fHsPSW4e4jNzIe0cL1sVnc/9LftdWLKXiAMt
         uCjg==
X-Gm-Message-State: AOAM532qWWUHUIIzH3v6p1RJVYPxAlRh6Evyo+RWhU1ERW1vrJbQVFp4
        iN7vz/iLDjnksvd4uZo249I=
X-Google-Smtp-Source: ABdhPJwUZiamqmpZxftcyYNOMIhgBNC9thd7Va9wuv8RX8AkEDvD6KUQzkpZ98BpbOe/iOVBLqLlCg==
X-Received: by 2002:a2e:9b58:: with SMTP id o24mr13247351ljj.84.1606091489567;
        Sun, 22 Nov 2020 16:31:29 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id r27sm1225823lfn.290.2020.11.22.16.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 16:31:29 -0800 (PST)
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
Subject: [PATCH v10 14/19] ARM: tegra: Add interconnect properties to Tegra30 device-tree
Date:   Mon, 23 Nov 2020 03:27:18 +0300
Message-Id: <20201123002723.28463-15-digetx@gmail.com>
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

