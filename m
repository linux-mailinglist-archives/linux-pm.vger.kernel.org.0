Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C0C1F0E8F
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgFGS7T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgFGS5l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:41 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AE2C08C5C3;
        Sun,  7 Jun 2020 11:57:40 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r125so8829592lff.13;
        Sun, 07 Jun 2020 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+CEcWwsfQJNuC0/u/b9qfD53y89kTF8Pb7X2lFn9BM=;
        b=s8/ZRady/oRoczVgqOH0nV22Yf2p7P/eW+c41mCuIx1onsLooYgbOGn9OxcxdFVELZ
         ga6AcWWtD7jDHC6TqnzzgQUDevfOhDVfv9O1UTdjxHon7eFWr3EKvQkvvj2XwmIr4VUW
         AI8TBScCywKlUOf9wW9ngWM0IVmCCOUHQkc3L4q/u/iWdqFX4/DUV4FVy7HpyXBGqBue
         cDKgxxmdtM1L1CEYwC3npK7ImbvG6wTk5/0oueCtQ7tv7lZCMzlMIX7MMM+MvUygNW4y
         s7IV0Fjr0RKfkaPH3r4BE8Ox5lcW1FRID0ExIXII1D57bxMLyZvXrXJyAxCaZWGUQEtP
         iUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+CEcWwsfQJNuC0/u/b9qfD53y89kTF8Pb7X2lFn9BM=;
        b=OFW45GfwSzCEBGweO9U0WUdJ2n9/lNyKTAsrKPR6PF5wFpKLqWg8XeZvMUnuHD6QSe
         6EP3Iqi0x9K2shMlVzQjjZuVs51J2P0Hl1WKt3gEfE8KJDSgJlNPLN0qC4cEMWOurY+p
         95BleIQy+Ebo/CMBwpNR4gcPk9bcm9VaoKFhKFJIDqG5spLRSwt5JMJdt4FMG0z59FyC
         f0w1mjR1GwfaSgEhbgvAP4Y3tEz6eay8egD+kgomWCFh1oE2X//TG22gQbUmafruQ1E5
         9BsZ/IjT+dpmH7fejh9X6B39wvJyT9knQwlkdQGoAL/FchuUTOtY0WKtY0KncwSMRxuW
         6tRw==
X-Gm-Message-State: AOAM530I3L3T4bKFSQN6u7QSvaAywKLbD5GNPARKDM+2BkvDBUu5DH4a
        lByEF5GIk9l2cmJ+mXW+/7A=
X-Google-Smtp-Source: ABdhPJxlQF+6iwxcnNY6hMFfSnwfFz8I64aW5E8IBj224MboabHNtwLz+4rN3BSIyQNWtELIFDPG3g==
X-Received: by 2002:ac2:5df2:: with SMTP id z18mr10691408lfq.151.1591556259004;
        Sun, 07 Jun 2020 11:57:39 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:38 -0700 (PDT)
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
Subject: [PATCH v3 22/39] dt-bindings: host1x: Document new interconnect properties
Date:   Sun,  7 Jun 2020 21:55:13 +0300
Message-Id: <20200607185530.18113-23-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
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

