Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB312A6AEF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgKDQxe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731499AbgKDQtv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:51 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10E3C0613D3;
        Wed,  4 Nov 2020 08:49:50 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id m16so23700926ljo.6;
        Wed, 04 Nov 2020 08:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yPDmeu5e5ToghK0duVDvFkp1U4ngU09Ju/XQwtIMeY=;
        b=enN8jDq8jBd6fkH4PiC27RXLIXn3qK7uKouNsLLSOSRPMkrrIEQFqEXmutnrjTlJjB
         QX0jZcCGv061mEPZa8SUj3FUuIIgvBvrlPlBx1fAok2OnmRFY6IRRgoJNtoQgeCucynl
         JmEXDhY7ZJ4y89G6vuSQoqbLqG/LhrKiewffEEYiamW4jDnx4u5eF+Cr2qH3yMWiYika
         dYsxBdJA3LKK8IV8OVslG0F0wDGojk1bhxZnShwP8HODZnrCAsdQGRkAAZvbejDKDAgp
         usd9/OYsVDXYm7+Q7ctogbbZH4l/N1oOqbv+Y9a/npcUtN23x2yJb5mwPYD4NPHP3qCL
         NQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yPDmeu5e5ToghK0duVDvFkp1U4ngU09Ju/XQwtIMeY=;
        b=XiBkeYxgnGTf2TPIeodFAPiu/ugY87HM+cdf8E64pkFvAho0Ln1Ou/GhwQZorJPi6K
         u+x1jis2hs028FOjYnGswEoV0u9ZswiYS7BF7Cf+qEoDEKJRvAiuipHRzdj/3160lYef
         K8IXrChDYYI6QNmVmKmR1Z/4/bba9BWtBHqtaIvpUFWLELslUGUup51+lWPRSjzX4tq2
         jL8LYMIQBwF05tFkM7CzEoue6i+xStbWztadrWCNOOCunELF2UZPLkALZ403wvZjGqyw
         UWEfpyKEJ19UR8cPu4WyGtywfKkaJCBX2xG5BazKj6TKwfHMnLxJsfKgGLFB4PHm3UC6
         +ROA==
X-Gm-Message-State: AOAM533eoExTXXb8UXLNfyHwsSoLMEwRUjt3lh0NPmfmGsohQNOJzyOv
        E2XT3zxs8/ZGQDSsNnQOQ1w=
X-Google-Smtp-Source: ABdhPJy2n1TuGk8VoaVwlcgQg3a7ONJ69NlQ05J8n2Ue7t3iZ+CPLkc2LCpFZlaxo01uel9gi93DoQ==
X-Received: by 2002:a2e:9114:: with SMTP id m20mr10573279ljg.203.1604508589404;
        Wed, 04 Nov 2020 08:49:49 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:48 -0800 (PST)
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
Subject: [PATCH v7 16/47] dt-bindings: host1x: Document new interconnect properties
Date:   Wed,  4 Nov 2020 19:48:52 +0300
Message-Id: <20201104164923.21238-17-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Most of Host1x devices have at least one memory client. These clients
are directly connected to the memory controller. The new interconnect
properties represent the memory client's connection to the memory
controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../display/tegra/nvidia,tegra20-host1x.txt   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index ac63ae4a3861..34d993338453 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -20,6 +20,10 @@ Required properties:
 - reset-names: Must include the following entries:
   - host1x
 
+Each host1x client module having to perform DMA through the Memory Controller
+should have the interconnect endpoints set to the Memory Client and External
+Memory respectively.
+
 The host1x top-level node defines a number of children, each representing one
 of the following host1x client modules:
 
@@ -36,6 +40,12 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - mpe
 
+  Optional properties:
+  - interconnects: Must contain entry for the MPE memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients, see MEMORY CONTROLLER section.
+
 - vi: video input
 
   Required properties:
@@ -113,6 +123,12 @@ of the following host1x client modules:
 	  Required properties:
 	  - remote-endpoint: phandle to vi port 'endpoint' node.
 
+  Optional properties:
+  - interconnects: Must contain entry for the VI memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients, see MEMORY CONTROLLER section.
+
 - epp: encoder pre-processor
 
   Required properties:
@@ -126,6 +142,12 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - epp
 
+  Optional properties:
+  - interconnects: Must contain entry for the EPP memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients, see MEMORY CONTROLLER section.
+
 - isp: image signal processor
 
   Required properties:
@@ -139,6 +161,12 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - isp
 
+  Optional properties:
+  - interconnects: Must contain entry for the ISP memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients, see MEMORY CONTROLLER section.
+
 - gr2d: 2D graphics engine
 
   Required properties:
@@ -152,6 +180,12 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - 2d
 
+  Optional properties:
+  - interconnects: Must contain entry for the GR2D memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients, see MEMORY CONTROLLER section.
+
 - gr3d: 3D graphics engine
 
   Required properties:
@@ -170,6 +204,12 @@ of the following host1x client modules:
     - 3d
     - 3d2 (Only required on SoCs with two 3D clocks)
 
+  Optional properties:
+  - interconnects: Must contain entry for the GR3D memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients, see MEMORY CONTROLLER section.
+
 - dc: display controller
 
   Required properties:
@@ -197,6 +237,10 @@ of the following host1x client modules:
   - nvidia,hpd-gpio: specifies a GPIO used for hotplug detection
   - nvidia,edid: supplies a binary EDID blob
   - nvidia,panel: phandle of a display panel
+  - interconnects: Must contain entry for the DC memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients, see MEMORY CONTROLLER section.
 
 - hdmi: High Definition Multimedia Interface
 
@@ -345,6 +389,12 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - vic
 
+  Optional properties:
+  - interconnects: Must contain entry for the VIC memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients, see MEMORY CONTROLLER section.
+
 Example:
 
 / {
@@ -498,6 +548,15 @@ Example:
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
+					<&mc TEGRA20_MC_DISPLAY0B &emc>,
+					<&mc TEGRA20_MC_DISPLAY0C &emc>,
+					<&mc TEGRA20_MC_DISPLAYHC &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -513,6 +572,15 @@ Example:
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA20_MC_DISPLAYHCB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
-- 
2.27.0

