Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11CDF1971DC
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgC3BKz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:10:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33156 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgC3BJm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id f20so16335771ljm.0;
        Sun, 29 Mar 2020 18:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0J6DRAOAyaTpCiYOkunPcKmZ48BaOfYFgW2usyzuKP8=;
        b=br2TMenOYQKMU0MQqe5hNERWMDXSym6KywsvVY9MbiXbFgwB15/mNeYK9ffd+tuYgX
         I9cwr0aUwbzVYEVHJUQmRq2gih6WeT7J+zk6ei65m0q80UFYOk9zbygJPZfjcfHinQi3
         S5VSjv+rQxVaycNdEOzS7xZy0rNH2hLvwgfesGzqh+tnroOisljSZpIT+XFlLOW0rDoZ
         KkUjKUTT8cnlJpS+FNjwCS4vAX6SvcPnjMB1ikRwA4nUVr+M2DPPXLqUdYguUihw5GEO
         RBj1yvBEiG2ozqqPn1wn2OHrBSxfy4Ilq4AAPpxcMWxbRfaSqw90MTm/8a+umdjTEBQ5
         lBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0J6DRAOAyaTpCiYOkunPcKmZ48BaOfYFgW2usyzuKP8=;
        b=j2t1rQ1ln/b3D9Ql/Q7iEZ3xxsrT3BkuZ3wQ4nekjlS6whmbzyom7vnWn3rFsm7qJD
         0xpxL/aoUNNPzJGZa2aeV1ail3P/4sIoAqb25K2wPRKhhzp2mnPiwaNifFIkudtmwIxs
         wQQOOL3g6My7y0LeHfCsG7l0LpxQ6iJGIs5HroZLJCHAI+ONNt2kOv0u3/vu/ob9DwQU
         DXRYaRMMG3tn8hj9ZKRnSBsPXJ8j1yk7ug3IsJ0GJXWUD2wJuLq3HJ3SsKY7MMt+yaKP
         w3WmPzBNdoCb6phrZ7trqRItHbgjzCLPsbwugNbvzD/gPmQW3r3E8NOGFNfIjQz4zWlp
         1TjA==
X-Gm-Message-State: AGi0PuajbYX58Ej94WTa+7CX1/94d0gD/hZ29v1ITP3or240X7bKSyUp
        FwtbnGwmxtS9vX4T6Eib5IM=
X-Google-Smtp-Source: APiQypJxz4N3lr7iOdRVaNWJ1a7Kt/SBCUYZhP3n8W449ZXJ7fMfJK3kvtdPi2dOpFJR6QpwemcihA==
X-Received: by 2002:a2e:904b:: with SMTP id n11mr5525552ljg.171.1585530579284;
        Sun, 29 Mar 2020 18:09:39 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 05/22] dt-bindings: host1x: Document new interconnect properties
Date:   Mon, 30 Mar 2020 04:08:47 +0300
Message-Id: <20200330010904.27643-6-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
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
index 9999255ac5b6..d92d4e814d77 100644
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
+    available memory clients.
+
 - vi: video input
 
   Required properties:
@@ -49,6 +59,12 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - vi
 
+  Optional properties:
+  - interconnects: Must contain entry for the VI memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients.
+
 - epp: encoder pre-processor
 
   Required properties:
@@ -62,6 +78,12 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - epp
 
+  Optional properties:
+  - interconnects: Must contain entry for the EPP memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients.
+
 - isp: image signal processor
 
   Required properties:
@@ -75,6 +97,12 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - isp
 
+  Optional properties:
+  - interconnects: Must contain entry for the ISP memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients.
+
 - gr2d: 2D graphics engine
 
   Required properties:
@@ -88,6 +116,12 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - 2d
 
+  Optional properties:
+  - interconnects: Must contain entry for the GR2D memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients.
+
 - gr3d: 3D graphics engine
 
   Required properties:
@@ -106,6 +140,12 @@ of the following host1x client modules:
     - 3d
     - 3d2 (Only required on SoCs with two 3D clocks)
 
+  Optional properties:
+  - interconnects: Must contain entry for the GR3D memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients.
+
 - dc: display controller
 
   Required properties:
@@ -133,6 +173,10 @@ of the following host1x client modules:
   - nvidia,hpd-gpio: specifies a GPIO used for hotplug detection
   - nvidia,edid: supplies a binary EDID blob
   - nvidia,panel: phandle of a display panel
+  - interconnects: Must contain entry for the DC memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients.
 
 - hdmi: High Definition Multimedia Interface
 
@@ -281,6 +325,12 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - vic
 
+  Optional properties:
+  - interconnects: Must contain entry for the VIC memory clients.
+  - interconnect-names: Must include name of the interconnect path for each
+    interconnect entry. Consult TRM documentation for information about
+    available memory clients.
+
 Example:
 
 / {
@@ -363,6 +413,15 @@ Example:
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
@@ -378,6 +437,15 @@ Example:
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
2.25.1

