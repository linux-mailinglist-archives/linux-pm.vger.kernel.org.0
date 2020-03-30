Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C71971D8
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgC3BJp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42897 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgC3BJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so16239153ljp.9;
        Sun, 29 Mar 2020 18:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hd6rY6XTqp00CNa6dRzJudRDwQrl4AYIk50UiFFMOiQ=;
        b=APeNjfm7l77Zij7S+5FueNHKVS7f2iUB46xAdhcZE1TgYucXVKDInptpz5mcRWP+4c
         P6ItvSGF//5mW9a//AX2vD5+k1djL7TjRbLNga7kESt+EbKoLKInY+V+uUZPm4u3ongI
         bNwVtPlQSzc18JgegPV+CIpul5pRwrT+Luw7iHMMXhVwRvG60EcxA8urVcy8wOmsDiaN
         xo1fFSiZg+iIqY/LoJ66KZ4rjSfT0hTiVrpCV/JCqrQsivSnHvLp65dgOKAs0CU8x4lD
         FTKgxaldEVuGtxBPYZ3CjzA2o4wXvygf1X1YhM/0VSfGeEHyplV9+oZT5/xsLYAAvzpN
         slFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hd6rY6XTqp00CNa6dRzJudRDwQrl4AYIk50UiFFMOiQ=;
        b=AfHnB1a1L1lvA89gtN25O5uoMTkG8V/R/6PxcUh4NgcYyQzn7/7YXsuf5DAb6Ik3I8
         Sgqrs+sVfj8+dvN6D+J2BLqsZZ536bBP+0UEgJem73mM3g8RifwwalHSbD9lcNzRicie
         ixbdU9r5KMCfvdGtfvEqramJUI3mLdWh0okkqdmBJwAXpveisuBGG+GbT2+MdA/HDF4+
         7GvE/URhOldBtPv5pVVk7yDO07685gKwRzGD8qEe4SxsdEbnIJJpF/clTfAc6qLagqlH
         QARZ7u8roXUwwfk44hTg+4Dy+kRIDW32WOqWXFURXMXfegkv2/xnqJKOlhRabwOF/CZr
         Tj9Q==
X-Gm-Message-State: AGi0PuboVzrjDU6Y4rBPERloMHTcHyUS5LsH8c4jq4gzjVd07W6ONSYe
        yrAd46iuQhmrIM8CCFPpfjw=
X-Google-Smtp-Source: APiQypJVjEp/caA9rjCoC4KqhKyXf5H1uzdrzEPfAmJeYTzn1FBkOErcY7T4srL/XaqigUAaNGShyA==
X-Received: by 2002:a2e:b6c2:: with SMTP id m2mr5646503ljo.72.1585530582785;
        Sun, 29 Mar 2020 18:09:42 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 08/22] ARM: tegra: Add interconnect properties to Tegra20 device-tree
Date:   Mon, 30 Mar 2020 04:08:50 +0300
Message-Id: <20200330010904.27643-9-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
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
index c3b8ad53b967..974048e83541 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -109,6 +109,15 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
+					<&mc TEGRA20_MC_DISPLAY0B &emc>,
+					<&mc TEGRA20_MC_DISPLAY0C &emc>,
+					<&mc TEGRA20_MC_DISPLAY1B &emc>;
+			interconnect-names = "display0a",
+					     "display0b",
+					     "display0c",
+					     "display1b";
+
 			rgb {
 				status = "disabled";
 			};
@@ -126,6 +135,15 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA20_MC_DISPLAY1BB &emc>;
+			interconnect-names = "display0a",
+					     "display0b",
+					     "display0c",
+					     "display1b";
+
 			rgb {
 				status = "disabled";
 			};
@@ -626,15 +644,17 @@ mc: memory-controller@7000f000 {
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
2.25.1

