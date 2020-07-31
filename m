Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9513234CC6
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 23:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgGaVOa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 17:14:30 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55446 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbgGaVO3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 17:14:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596230068; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=dvwBrEbVERFUgM2LMCV1G2AljSQNPyFfudWmCq32qKw=; b=m//sYZu0ncJ2fumGoxlU5nZp54gRxc5yLummt+tsBu3ECYV5kPDs2/IEQyx3WPcz377cLnh7
 mdBy2Chq2Lam32AK7UPGTQ9hmvHenQEOA+Euotbf3fvIg6Fot0kQY28JRb6OgcM/dssfrvsi
 GGmqBQcUVpk7HQYNOElgTs57EDQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f2489b32c24b37bbe61f178 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 31 Jul 2020 21:14:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E31BDC43391; Fri, 31 Jul 2020 21:14:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52773C43391;
        Fri, 31 Jul 2020 21:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52773C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH 1/4] dt-bindings: power: reset: Convert reboot-mode to YAML
Date:   Fri, 31 Jul 2020 14:14:17 -0700
Message-Id: <1596230060-6065-2-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596230060-6065-1-git-send-email-eberman@codeaurora.org>
References: <1596230060-6065-1-git-send-email-eberman@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert reboot-mode bindings to YAML.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 .../bindings/power/reset/reboot-mode.txt           | 25 ------------
 .../bindings/power/reset/reboot-mode.yaml          | 47 ++++++++++++++++++++++
 2 files changed, 47 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
deleted file mode 100644
index de34f27..0000000
--- a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Generic reboot mode core map driver
-
-This driver get reboot mode arguments and call the write
-interface to store the magic value in special register
-or ram. Then the bootloader can read it and take different
-action according to the argument stored.
-
-All mode properties are vendor specific, it is a indication to tell
-the bootloader what to do when the system reboots, and should be named
-as mode-xxx = <magic> (xxx is mode name, magic should be a none-zero value).
-
-For example modes common on Android platform:
-- mode-normal: Normal reboot mode, system reboot with command "reboot".
-- mode-recovery: Android Recovery mode, it is a mode to format the device or update a new image.
-- mode-bootloader: Android fastboot mode, it's a mode to re-flash partitions on the Android based device.
-- mode-loader: A bootloader mode, it's a mode used to download image on Rockchip platform,
-	       usually used in development.
-
-Example:
-	reboot-mode {
-		mode-normal = <BOOT_NORMAL>;
-		mode-recovery = <BOOT_RECOVERY>;
-		mode-bootloader = <BOOT_FASTBOOT>;
-		mode-loader = <BOOT_BL_DOWNLOAD>;
-	}
diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
new file mode 100644
index 0000000..a6c9102
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/reboot-mode.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic reboot mode core map
+
+maintainers:
+  - Andy Yan <andy.yan@rock-chips.com>
+
+description: |
+  This driver get reboot mode arguments and call the write
+  interface to store the magic value in special register
+  or ram. Then the bootloader can read it and take different
+  action according to the argument stored.
+
+  All mode properties are vendor specific, it is a indication to tell
+  the bootloader what to do when the system reboots, and should be named
+  as mode-xxx = <magic> (xxx is mode name, magic should be a non-zero value).
+
+  For example, modes common Android platform are:
+    - normal: Normal reboot mode, system reboot with command "reboot".
+    - recovery: Android Recovery mode, it is a mode to format the device or update a new image.
+    - bootloader: Android fastboot mode, it's a mode to re-flash partitions on the Android based device.
+    - loader: A bootloader mode, it's a mode used to download image on Rockchip platform,
+              usually used in development.
+
+properties:
+  mode-normal:
+      $ref: /schemas/types.yaml#/definitions/uint32
+      description: |
+        Default value to set on a reboot if no command was provided.
+
+patternProperties:
+  "^mode-.*$":
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+examples:
+  - |
+    reboot-mode {
+      mode-normal = <0>;
+      mode-recovery = <1>;
+      mode-bootloader = <2>;
+      mode-loader = <3>;
+    };
+...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

