Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E98F1F0E80
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgFGS5q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgFGS5p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:45 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B38C08C5C3;
        Sun,  7 Jun 2020 11:57:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r125so8829650lff.13;
        Sun, 07 Jun 2020 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THFCg3hKPmLC0meEu1tU7N3iWwUxXusX7wxKM7keO5E=;
        b=NND7CpEGn20ervIHoTdlyo6+Op+rxFkv0PTdj3otZabrL/ZgPfNXZeeO9+bJ//nNIk
         UZGGY4o9hdUzDBhZ98FOdoqE5sWo7vOtdzKnJOCRyEN3o6AotXOY9hFC0EtZ12G3E1nY
         Gbj83WvexpFRqVFoyX2qLsVG1fRRtijfmMTLwEebjlVfZ36eTXMtylzEgyRYeT9bB4Ki
         q6JdaV+l91GOk3kkVV/Rs6mHTTmCpPv/qt0RX6DoxowgQ+xajfZG4ucERlNtKvO4lpC2
         u3fHtJYCQ8shpghn7IpP+ev37QZaTX2uTxAgDBGlAH3TQVc0mtmH78kG0le5jVeNngD8
         TGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THFCg3hKPmLC0meEu1tU7N3iWwUxXusX7wxKM7keO5E=;
        b=mVd5mjoJs4zrH29A+etIaFVfh0hK7EXQOfHdW+go55wJgI1Xbq9KZP3F0RwcAE5cs+
         hOOxQx+0ZJ22ccmq9p2Worz6xRqMNhk94zcxWIf+s7guw+5AgWor/wZXdoNhACqIqjRF
         /OdSQR6rlYiaAMbraaJhQAmEfhNvqaoCTY+MOPDUNElkJVdSfpVZScYxDG/zwKNIRcAe
         rQdVYRbLPpL8UMTTbDdvMcRFD6sEkOZ5SEQNLvPhMZP86INUshEXFMapqUJu9+izZSGB
         GxmY53nYpXgN6uLfHge2d+giHNq3yUjlwnwKrcJSIqvFlpvTYcNy5MsSPUJ6qcCapbVI
         3x6g==
X-Gm-Message-State: AOAM533t7yNY1kzn2zGPst1NGrvdOPgqiN5ZiZzMId74xRsLTlsgwwkp
        4MSzJLkfVCKfEP6j0elIN9Y=
X-Google-Smtp-Source: ABdhPJxAtHo5jbvdut7LI2tbRskKxWJ0DGnB4bT2RT3mZaYwsIsN0IKDDQQpcmrKy90iwLiA8f+E+w==
X-Received: by 2002:a19:c3c5:: with SMTP id t188mr10802411lff.149.1591556263342;
        Sun, 07 Jun 2020 11:57:43 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:42 -0700 (PDT)
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
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 25/39] ARM: tegra: Add interconnect properties to Tegra20 device-tree
Date:   Sun,  7 Jun 2020 21:55:16 +0300
Message-Id: <20200607185530.18113-26-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
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
2.26.0

