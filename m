Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA01100C87
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfKRUFk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:40 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38845 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKRUFj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id v8so20453406ljh.5;
        Mon, 18 Nov 2019 12:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bqBrfnW6oyEXwKIsbHDBGjswWgQFyUFjpg74MBWJm98=;
        b=Z6Kd/3tqBvD0M7O+PYu7Ii8RlXO0+YawGtX5h9TllVokV9Qzmc+mmaZJjKwaOqN20S
         vciRZM10CNRGSAjggOApBG/aktZ1egddBzZLK1Cw5zVSHj9sY6wnwyqW5LhTDMgVnPO0
         kPyiJ1cDdIflcboywIBKSfX4ePvjrzwa7nG11rEtpQ5D6KgvVtOoEz6VJlcVfVKNeSlI
         BIb+CyR7SSmV/FgJEm+y6wDNdlASp9ZOb45u3YD6ox8labjdDyVAwSbgp/tDlgQqZbvC
         bdvpkMWX6vR8WxszZg37yPD/36pBzeVdUMd5TohZlebNd0V9EJJsTU0dYC/4aGI3RELa
         kAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bqBrfnW6oyEXwKIsbHDBGjswWgQFyUFjpg74MBWJm98=;
        b=Wb/preWecyW2Ms4RBvv1s3+EJCbLAY0oD9ed9513azqYiryMidiC2sPoiNuiSETsnn
         uPYrgkM6scfje2RG6Za66/mgXDYrjzbY2A5UC6bU/syaFi6tKshCYOrGaYqFLJgs87A4
         cvoNtRfaoinXcv34sEHH3y2G7Fjy+eIhzCDePZXb9zrB0XnKB9vJljUySee9gy5LzV9M
         axUsfFFMfY3xcgGn3+dPcFjruoWq2aWuLS2RUXEEucmrZRXnnHchsIWdrM/NO07KZR2e
         8xQOMQhI/hv0xPH2JNbrUV4AxQL4pC/ba8Q4VwdHlV2+NEa3xG3bcfKL4OOLYVlghJ+a
         9GcA==
X-Gm-Message-State: APjAAAV2ck42l1flCW2BKLbdhniHU3MG816t9Qanf5pz+rx/ZmN53IGn
        A65J882xOhOgwe/UrS4RAO8=
X-Google-Smtp-Source: APXvYqzGjnmG736kFSi3pxotXWznYFJa6hehgaqv7npk23af++Lg1tmT5bTj457i7qTnfQhOMfeSlA==
X-Received: by 2002:a2e:93d7:: with SMTP id p23mr939424ljh.102.1574107536965;
        Mon, 18 Nov 2019 12:05:36 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:36 -0800 (PST)
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
Subject: [PATCH v1 07/29] dt-bindings: host1x: Document new interconnect properties
Date:   Mon, 18 Nov 2019 23:02:25 +0300
Message-Id: <20191118200247.3567-8-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Host1x clients are interconnected with memory controller through Graphics
HOST bus, these clients will issue memory bandwidth requests to the memory
controller that will adapt arbitration configuration in order to satisfy
clients and then propagate the aggregated bandwidth request to external
memory controller. The new interconnect properties are optional, thus
backwards compatibility is preserved with older device-trees.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../display/tegra/nvidia,tegra20-host1x.txt   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index 9999255ac5b6..2a1fc1a194d2 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -20,6 +20,11 @@ Required properties:
 - reset-names: Must include the following entries:
   - host1x
 
+Each host1x client module having to perform DMA through the Memory Controller
+should have the interconnect endpoints set to the Memory Client and External
+Memory respectively, interconnect name must be set to "dma-mem".
+The interconnect property is optional.
+
 The host1x top-level node defines a number of children, each representing one
 of the following host1x client modules:
 
@@ -36,6 +41,11 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - mpe
 
+  Optional properties:
+  - interconnects: Must contain entry for the memory interconnect.
+  - interconnect-names: Must include the following entries:
+    - dma-mem
+
 - vi: video input
 
   Required properties:
@@ -49,6 +59,11 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - vi
 
+  Optional properties:
+  - interconnects: Must contain entry for the memory interconnect.
+  - interconnect-names: Must include the following entries:
+    - dma-mem
+
 - epp: encoder pre-processor
 
   Required properties:
@@ -62,6 +77,11 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - epp
 
+  Optional properties:
+  - interconnects: Must contain entry for the memory interconnect.
+  - interconnect-names: Must include the following entries:
+    - dma-mem
+
 - isp: image signal processor
 
   Required properties:
@@ -75,6 +95,11 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - isp
 
+  Optional properties:
+  - interconnects: Must contain entry for the memory interconnect.
+  - interconnect-names: Must include the following entries:
+    - dma-mem
+
 - gr2d: 2D graphics engine
 
   Required properties:
@@ -88,6 +113,11 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - 2d
 
+  Optional properties:
+  - interconnects: Must contain entry for the memory interconnect.
+  - interconnect-names: Must include the following entries:
+    - dma-mem
+
 - gr3d: 3D graphics engine
 
   Required properties:
@@ -106,6 +136,11 @@ of the following host1x client modules:
     - 3d
     - 3d2 (Only required on SoCs with two 3D clocks)
 
+  Optional properties:
+  - interconnects: Must contain entry for the memory interconnect.
+  - interconnect-names: Must include the following entries:
+    - dma-mem
+
 - dc: display controller
 
   Required properties:
@@ -133,6 +168,9 @@ of the following host1x client modules:
   - nvidia,hpd-gpio: specifies a GPIO used for hotplug detection
   - nvidia,edid: supplies a binary EDID blob
   - nvidia,panel: phandle of a display panel
+  - interconnects: Must contain entry for the memory interconnect.
+  - interconnect-names: Must include the following entries:
+    - dma-mem
 
 - hdmi: High Definition Multimedia Interface
 
@@ -281,6 +319,11 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - vic
 
+  Optional properties:
+  - interconnects: Must contain entry for the memory interconnect.
+  - interconnect-names: Must include the following entries:
+    - dma-mem
+
 Example:
 
 / {
@@ -307,6 +350,9 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_MPE>;
 			resets = <&tegra_car 60>;
 			reset-names = "mpe";
+
+			interconnects = <&mc TEGRA_ICC_MC_MPE &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
 		};
 
 		vi {
@@ -316,6 +362,9 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_VI>;
 			resets = <&tegra_car 100>;
 			reset-names = "vi";
+
+			interconnects = <&mc TEGRA_ICC_MC_VI &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
 		};
 
 		epp {
@@ -325,6 +374,9 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_EPP>;
 			resets = <&tegra_car 19>;
 			reset-names = "epp";
+
+			interconnects = <&mc TEGRA_ICC_MC_EPP &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
 		};
 
 		isp {
@@ -334,6 +386,9 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_ISP>;
 			resets = <&tegra_car 23>;
 			reset-names = "isp";
+
+			interconnects = <&mc TEGRA_ICC_MC_ISP &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
 		};
 
 		gr2d {
@@ -343,6 +398,9 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
 			resets = <&tegra_car 21>;
 			reset-names = "2d";
+
+			interconnects = <&mc TEGRA_ICC_MC_2D &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
 		};
 
 		gr3d {
@@ -351,6 +409,9 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
 			resets = <&tegra_car 24>;
 			reset-names = "3d";
+
+			interconnects = <&mc TEGRA_ICC_MC_3D &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
 		};
 
 		dc@54200000 {
@@ -363,6 +424,9 @@ Example:
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
 
+			interconnects = <&mc TEGRA_ICC_MC_DC &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
+
 			rgb {
 				status = "disabled";
 			};
@@ -378,6 +442,9 @@ Example:
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
 
+			interconnects = <&mc TEGRA_ICC_MC_DCB &emc TEGRA_ICC_EMEM>;
+			interconnect-names = "dma-mem";
+
 			rgb {
 				status = "disabled";
 			};
-- 
2.23.0

