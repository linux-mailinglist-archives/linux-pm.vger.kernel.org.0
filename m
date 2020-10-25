Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBEC298487
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417651AbgJYWVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419284AbgJYWSP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171F5C0613CE;
        Sun, 25 Oct 2020 15:18:15 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j30so9423240lfp.4;
        Sun, 25 Oct 2020 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMjVAb/o+piDt6czNf33ZOuiJhcOMgOALVgnOUvCv+Q=;
        b=akPOnPZUgCnA7WgGrwZzYa0pPbJ50b5saChlSacGkyMgPl81Tj7oDS86nsQIEPUtsn
         63vpfhSeceRUZWx2gYdskkKIT0O+PK4E8/iNN/Raopu5CDdltp43KHPQSzMakDcY/ft7
         FGnGYK8eBLUZ/7Nve3OBWyCfCm6j9a0vU8F6Hm6Ad4Pp+wpZNv4L0WZJPr6XhVdqUpAo
         YNo+x4KO9EZ27nLqzOPNxWe4AhmFt/n1uJbg+WLfUobV6yiTf3D80jpRz+XLUxJFc3JF
         jeW6fICzLCYQVWmo6RbRftjhMJGIWg0Z97xLNckzflFxxDngg9P/CAUBy/3hvVVv7A0d
         DiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMjVAb/o+piDt6czNf33ZOuiJhcOMgOALVgnOUvCv+Q=;
        b=Q7ryHEbZJdN52hTU3LPlBHCOLQj3oQ9Pckd9AP4WeH/r+HHP0Xu8zN5Zk/gq6chCW6
         HTbMVWHJbUHyg7kKfE4vt12SD4eRFXY/pQ9aFIBnX0dzfVBlQsQufbNojlQOswpTNitg
         /6sVQIhPu5b/u3QWu8JrKtDcUfRaDcsAefsSaHiLR4ZxM5JG0kiwRinsQrnEed+wJe/R
         JC/uXr4zmQTgW9QBg3GMe4z4xxSgV/MT9uOHWmMys9g1ogejbSZIy8FjCPDCDcMZn+4q
         aXuvhZolpXJpQLfRNu0D1ONxpn2R7Lc96yHj6YBLA1rEDXBvrLqw/0jGvWeZpswswq89
         N2FQ==
X-Gm-Message-State: AOAM531qwufk+GoYwWcIgItWYjK379rw4KWWDflJ0WvgifHZx8fXPsfm
        fhpSvTjdPPetrAOlRHw8Tog=
X-Google-Smtp-Source: ABdhPJzH5nJXk7LVha9r+hCH/LhYgtkRW40Rsp7NnrDNLJuP4PeaVAq9qJpuel3mqU/iWqWAtR1tmQ==
X-Received: by 2002:a19:8488:: with SMTP id g130mr4084378lfd.424.1603664293635;
        Sun, 25 Oct 2020 15:18:13 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:13 -0700 (PDT)
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
Subject: [PATCH v6 22/52] ARM: tegra: Add interconnect properties to Tegra30 device-tree
Date:   Mon, 26 Oct 2020 01:17:05 +0300
Message-Id: <20201025221735.3062-23-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
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

