Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A7D100CD8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfKRUHJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:07:09 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42256 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfKRUFo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id z12so14867481lfj.9;
        Mon, 18 Nov 2019 12:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMxRk5+wnUUg0iU/ONgQRtpatlCjk39x02NkmMcM4Ic=;
        b=nRsVcOLkGpoI+usSPfWzjgGrZRyGz9Uw6yP5tIZ3+LTQWwYscK1o8N0cIZ4QkjUxpe
         zXSliUsXnlexkVtiS8WWBVBtlsqa4Eo3q0CdEipr5fPHJnUx92Fms2aQ4yJboTCaU8NR
         g7nf3baq7mFKbPAx+g+zAYL4QaQizn02Fg/63P59KCM8+BhAW+WVI9HWUWKXk5qoJTPe
         cWn9XoH2aF3TFjzlWKpJT7ZDxG1Pyl+aR7z7KBHGvlgIiqMo1G1MKfdNtEpnU2A/XWPg
         /kp9ymh20a8EKwQtzJawJ7gSCRswOkBxRnwtS8N3K1LJctrePj4FHXv8V6rxPK84R4np
         /b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMxRk5+wnUUg0iU/ONgQRtpatlCjk39x02NkmMcM4Ic=;
        b=QyVTThvCcVrljxN4mRV0R3RQOafzevdy6LhmpO92tHzvPqL3inUxbLqZg36X4kZbCd
         xm10nTtqyvZ6IXjPUTG4hsf9DJe+Biv+T5bCY+TDq7XVNtYWdcBrBdYZ0QliB9UD5WtC
         x2YZYBQkkw/6kV3DbTyaUQsnMdMNAOwMpCoWuS0zxgSwN+WlO4GwBm7OJ6YDYEYnKyxM
         yYYB0ThOCIBez24bMXT7CW51D1JetPwaORgLIA1xuejISXncKV7d4GI4nX5KR3FObAuh
         OgWtfIxbWziK53D/EyWQniCGmkSsvlvXvlwhecivCMuZ168gi9CuTtmHnnkrK7tRZDsi
         exIw==
X-Gm-Message-State: APjAAAUIOEkXCmOdQomqzkH1cbcBG1mrg0qzkk0MgCgSez1r3fCDJH2X
        ZJcRRJA12/rMqkvoLzKM0J0=
X-Google-Smtp-Source: APXvYqxI6wtsMLrnPYDhgtHFQ96AQeDXAE5xVarMIEaB4V3z7umv4UaozwQFe4A1nX3jMF6rUUD+hg==
X-Received: by 2002:ac2:5305:: with SMTP id c5mr836180lfh.55.1574107541746;
        Mon, 18 Nov 2019 12:05:41 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:41 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 11/29] ARM: tegra: Add interconnect properties to Tegra124 device-tree
Date:   Mon, 18 Nov 2019 23:02:29 +0300
Message-Id: <20191118200247.3567-12-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect properties to the memory controller, external memory
controller and the display controller nodes to describe interconnection
of these nodes.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 413bfb981de8..5069af3011cc 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/gpio/tegra-gpio.h>
 #include <dt-bindings/memory/tegra124-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
+#include <dt-bindings/interconnect/tegra-icc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/tegra124-car.h>
 #include <dt-bindings/thermal/tegra124-soctherm.h>
@@ -111,6 +112,9 @@
 			iommus = <&mc TEGRA_SWGROUP_DC>;
 
 			nvidia,head = <0>;
+
+			interconnects = <&mc TEGRA_ICC_MC_DC &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
 		};
 
 		dc@54240000 {
@@ -126,6 +130,9 @@
 			iommus = <&mc TEGRA_SWGROUP_DCB>;
 
 			nvidia,head = <1>;
+
+			interconnects = <&mc TEGRA_ICC_MC_DCB &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
 		};
 
 		hdmi: hdmi@54280000 {
@@ -620,6 +627,7 @@
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 
 		#iommu-cells = <1>;
+		#interconnect-cells = <1>;
 	};
 
 	emc: emc@7001b000 {
@@ -627,6 +635,8 @@
 		reg = <0x0 0x7001b000 0x0 0x1000>;
 
 		nvidia,memory-controller = <&mc>;
+
+		#interconnect-cells = <1>;
 	};
 
 	sata@70020000 {
-- 
2.23.0

