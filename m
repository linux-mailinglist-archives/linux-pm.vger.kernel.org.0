Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBAD2B39A4
	for <lists+linux-pm@lfdr.de>; Sun, 15 Nov 2020 22:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgKOVdp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 16:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgKOVdc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 16:33:32 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3008C0613CF;
        Sun, 15 Nov 2020 13:33:31 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so22329501lfd.9;
        Sun, 15 Nov 2020 13:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLbRWZodAWHryje7XdgngwZooRzE7B+sWeFpLwWIFLg=;
        b=pIMCQd7qMNyonqrksRdbw6jHLtLHnh4ZYFYfaRCLXZI1RhCMfs8lt+sDYGG0JeVPm4
         ezA0oZOlSBizlhGKwAEDDg5lk85d3VpYqLdUqYSX1vXEdh/8G4p5CSzTYvUEDyQ3xWmV
         Uly/onikTP61hEc36VZ0jRGs9UCnQaifWFpN01HdaEVBjh//Xy0evuYJqvVTvUrN1Jg7
         kiwDbBDJxoF4X5v99rKgYVuczOH2S1RA+eAliCmqk1MDvDEU0r0Rc8m1iraLpyqf9yz8
         5McbVmw9OmThl5gk/FFh8vrwaJ3wnEC4SQg7qtyLrbUxknsasYm46lMwoQaCDKRO/gNu
         4g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLbRWZodAWHryje7XdgngwZooRzE7B+sWeFpLwWIFLg=;
        b=c6o1x3sazKYUiQYSVTQqv0Xg+ANbSy8F6PWgHDBLa6Elr1Fl9urP9/OIMePGbIt7CS
         5Li+K63r0P748akGT3XLYUy+5Rv7KDmz1CczKQxZXNVrmD7D4LTYNtzCVbX7vJXk+cp7
         U67n1j3J4nWhh7VPRdVAgPJlVkUJIhiwCOkl+VlStfRPDmKFYo5qM92gFOIu3qlF2OFE
         ch79P2vTkhyRL4ZqE9YRp8LeUycOuPCfqIzzr4k8dt/jUP36Ucwt8HJj4sE0bSV9KxsX
         IrOPTGe/Wi+5A1s9UjQeaRonLdvbA0CiSvh73fDDlmKkCo5CgXAIBGBn7ga//SdQ+ej/
         fn7w==
X-Gm-Message-State: AOAM533PtnlxBj0ViuwoxwnN2TS1YcE3lNtAWEbfcaYtEnIM2aYSDsKr
        cYfuVEDWeqbb7c3VZ1MJZz8=
X-Google-Smtp-Source: ABdhPJydP12/dyMxuqwLIXwTLjBF6dCHGsmDaUNIMSCg0CAsgOTqSmwvSBwH8LTLeM95FEis+xeNgg==
X-Received: by 2002:a19:8686:: with SMTP id i128mr4118536lfd.333.1605476010454;
        Sun, 15 Nov 2020 13:33:30 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id o3sm2462055lfo.217.2020.11.15.13.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 13:33:30 -0800 (PST)
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
Subject: [PATCH v9 13/17] ARM: tegra: Add interconnect properties to Tegra124 device-tree
Date:   Mon, 16 Nov 2020 00:29:18 +0300
Message-Id: <20201115212922.4390-14-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra124.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 64f488ba1e72..1801e30b1d3a 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -113,6 +113,19 @@ dc@54200000 {
 			iommus = <&mc TEGRA_SWGROUP_DC>;
 
 			nvidia,head = <0>;
+
+			interconnects = <&mc TEGRA124_MC_DISPLAY0A &emc>,
+					<&mc TEGRA124_MC_DISPLAY0B &emc>,
+					<&mc TEGRA124_MC_DISPLAY0C &emc>,
+					<&mc TEGRA124_MC_DISPLAYHC &emc>,
+					<&mc TEGRA124_MC_DISPLAYD &emc>,
+					<&mc TEGRA124_MC_DISPLAYT &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor",
+					     "wind",
+					     "wint";
 		};
 
 		dc@54240000 {
@@ -127,6 +140,15 @@ dc@54240000 {
 			iommus = <&mc TEGRA_SWGROUP_DCB>;
 
 			nvidia,head = <1>;
+
+			interconnects = <&mc TEGRA124_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA124_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA124_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA124_MC_DISPLAYHCB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor";
 		};
 
 		hdmi: hdmi@54280000 {
@@ -628,6 +650,7 @@ mc: memory-controller@70019000 {
 
 		#iommu-cells = <1>;
 		#reset-cells = <1>;
+		#interconnect-cells = <1>;
 	};
 
 	emc: external-memory-controller@7001b000 {
@@ -637,6 +660,8 @@ emc: external-memory-controller@7001b000 {
 		clock-names = "emc";
 
 		nvidia,memory-controller = <&mc>;
+
+		#interconnect-cells = <0>;
 	};
 
 	sata@70020000 {
-- 
2.29.2

