Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99851971D2
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgC3BJs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33685 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgC3BJr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id x200so5559007lff.0;
        Sun, 29 Mar 2020 18:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FuqLVA2Ch1ge473EwwpJtLsZnteKNfYMkl72ih8U+c=;
        b=a1imk7xg6DJO18zhcZxKy5O1NJyW/KUhelh4pAugtSE8hQfVKLgMtRH877wdq/fWgk
         h7lIoG+UfMqesjXLOwCRcodeuhmCpiIjUNFKyaKqzARwS4HyQGNiSS83b6prJu7BCFTc
         S+h5vOv5N0Ny8mOLu8PPEqggvSHLD6m9LRQ544CdouBZkqSEsqUC27ZYWS86kpCWFIVS
         1J9xqFkDRSseaL5bvPt3fsr0x6bbOaaSnqdysNQv50AHhIwklrKWaZWKGTrTelBT7Ah0
         qZfuJdVs4Vl7U0EUjDkzylRd44bC4WgaqACYw/jN9627/gWPcuBEqu9iSF99YALsgVoO
         b82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FuqLVA2Ch1ge473EwwpJtLsZnteKNfYMkl72ih8U+c=;
        b=twvzv8xT5gJUJLZMOyGpjS7t0OZlfh7/9gL1PnoZYZYdRZ+B1SPDeKjQ/RusQv7Pue
         g9ObTL+xTE+7evliTN9883VMbGVepm1bm97+pkujDB/vXhVAX8N7/p8LaVgnEzKZlDG8
         9cyBfyig+Eo6CX8LjKP8i+9+WvSvygGkd4Qo3noUHZt8Djd5PjPagb23x2S9Z78ATiE3
         kMFxuA7WX7+9MMTWCsWu9szPQVrhUJopJu1w9KsEcMjOZwZlAEXpGP97B1qK3IJgqvpz
         BzUoK61GQ+JgWxxjSEuRT2YklvJ1aZlGkR6q3VI0X++BCglRaMln9uDEGWQkLjJ8NiO0
         yRCA==
X-Gm-Message-State: AGi0PuYhzB7WnQX9jraLP24cBtNIcAaYQ4EdDhpnfk0aFhw4LnBxMyhP
        QtdicEpwliroisN6eR2KaxQ=
X-Google-Smtp-Source: APiQypJ4ftA1ZlPdYQYD3PBQIBDGgxEHZTdSa7Dhm9yq5g30pRKLnMIFfBPHXLOVdy0wOQnSfxJX9A==
X-Received: by 2002:ac2:41d3:: with SMTP id d19mr6601388lfi.57.1585530583834;
        Sun, 29 Mar 2020 18:09:43 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 09/22] ARM: tegra: Add interconnect properties to Tegra30 device-tree
Date:   Mon, 30 Mar 2020 04:08:51 +0300
Message-Id: <20200330010904.27643-10-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra30.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index d2d05f1da274..2b183025629f 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -208,6 +208,15 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA30_MC_DISPLAY0A &emc>,
+					<&mc TEGRA30_MC_DISPLAY0B &emc>,
+					<&mc TEGRA30_MC_DISPLAY0C &emc>,
+					<&mc TEGRA30_MC_DISPLAY1B &emc>;
+			interconnect-names = "display0a",
+					     "display0b",
+					     "display0c",
+					     "display1b";
+
 			rgb {
 				status = "disabled";
 			};
@@ -227,6 +236,15 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA30_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA30_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA30_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA30_MC_DISPLAY1BB &emc>;
+			interconnect-names = "display0a",
+					     "display0b",
+					     "display0c",
+					     "display1b";
+
 			rgb {
 				status = "disabled";
 			};
@@ -733,15 +751,18 @@ mc: memory-controller@7000f000 {
 
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
2.25.1

