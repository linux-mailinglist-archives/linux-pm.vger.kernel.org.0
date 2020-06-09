Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62A11F3BE2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgFINRG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbgFINOz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D568C08C5C7;
        Tue,  9 Jun 2020 06:14:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c17so24952339lji.11;
        Tue, 09 Jun 2020 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+CEcWwsfQJNuC0/u/b9qfD53y89kTF8Pb7X2lFn9BM=;
        b=LKp4tdwGsR3FiUNB6BgaVmCV6Cy8LQgjnbq7STmdal3oUokVDFY/hqQrUmWciME6lN
         r4gUsHurH99ZHXN32RIPu7AR3n0eenmEAfu7Mzo3UuZB8SFvUrPOkgRb8h+1KJQrrey0
         BXPTet2poLMhPhgS00babZFGdM/W3JesFl/yvHakrIn5eDEsQ9orh7+Z7an4kMRiqVbs
         8DtuV8iZy6Mkdrwvi4MZEC8VvULTChmKsieDvC+MDARobLLxigeNbsfbZjstm2pTaKxG
         hsWgyAb/bjwsfVyOdQ+2GCvhMdJfIXgP4Wudy/dsBMPWl06LqnLuVYY5ytrkf969GAR9
         Q+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+CEcWwsfQJNuC0/u/b9qfD53y89kTF8Pb7X2lFn9BM=;
        b=Oc4E62DXZrwbuiTD9qllBSg/uK38a+4nx4iS/Rkxk/es0rFmJedy1EoKP5n8TWqC2f
         hD2QBFLlL9CP+RVUPxheXEJfFa5o6GSeWNVxhfgLhtozxRXRFmcnln2eHnaT22gB8+op
         UH67f1wazWxTpr6PAYSILwFu0ArTQSBN6+0Jo/H2BjO4/DzT2Y+7AB8A+bhCOfVo4gdh
         jbrOCwUnvupyolrV37L7shy5HX4AsSKsLmtz3SmnBkHF6KFMZcDtSrfIftou7wxAfbvz
         7Dm8QX9COgc5DkNmZSIYogY3m/+b7CVRp5nEpdAazAn1OIdHGEOKblQ5bfm7eJf0LPEj
         SgGw==
X-Gm-Message-State: AOAM533j3EAg7C1Q2Xkw/snwM2kE1TeNf0mJnksl1zwy3B2nPLY6f5Qj
        vxKRPcTQutewzd9RyHlKW7g=
X-Google-Smtp-Source: ABdhPJzit8WqdXQ6xrQy8Et39EPUvr32KVTVb/4JF0a71QX3PN1qQHt0BT7Za7Wf/mUjWwXl/KVupg==
X-Received: by 2002:a05:651c:2050:: with SMTP id t16mr1142548ljo.178.1591708491960;
        Tue, 09 Jun 2020 06:14:51 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:51 -0700 (PDT)
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
Subject: [PATCH v4 22/37] dt-bindings: host1x: Document new interconnect properties
Date:   Tue,  9 Jun 2020 16:13:49 +0300
Message-Id: <20200609131404.17523-23-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Most of Host1x devices have at least one memory client. These clients
are directly connected to the memory controller. The new interconnect
properties represent the memory client's connection to the memory
controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../display/tegra/nvidia,tegra20-host1x.txt   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index 47319214b5f6..ab4fbee7bccf 100644
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
@@ -65,6 +75,12 @@ of the following host1x client modules:
       - power-domains: Must include sor powergate node as csicil is in
         SOR partition.
 
+  Optional properties:
+  - interconnects: Must contain entry for the VI memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients, see MEMORY CONTROLLER section.
+
 - epp: encoder pre-processor
 
   Required properties:
@@ -78,6 +94,12 @@ of the following host1x client modules:
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
@@ -91,6 +113,12 @@ of the following host1x client modules:
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
@@ -104,6 +132,12 @@ of the following host1x client modules:
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
@@ -122,6 +156,12 @@ of the following host1x client modules:
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
@@ -149,6 +189,10 @@ of the following host1x client modules:
   - nvidia,hpd-gpio: specifies a GPIO used for hotplug detection
   - nvidia,edid: supplies a binary EDID blob
   - nvidia,panel: phandle of a display panel
+  - interconnects: Must contain entry for the DC memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients, see MEMORY CONTROLLER section.
 
 - hdmi: High Definition Multimedia Interface
 
@@ -297,6 +341,12 @@ of the following host1x client modules:
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
@@ -410,6 +460,15 @@ Example:
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
 
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
@@ -425,6 +484,15 @@ Example:
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
 
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
-- 
2.26.0

