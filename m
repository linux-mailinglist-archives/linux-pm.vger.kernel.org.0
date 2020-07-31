Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5370D234CC2
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 23:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGaVO2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 17:14:28 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33756 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728204AbgGaVO2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 17:14:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596230067; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=pURV5QFpmLy38X5gYC0uGHz0Zw0P/0cot7hAuBA4Ty0=; b=D5ZEN2hK/CFfSMcF96tixzA7zt+lr/qMUQqpa1tZ4WWwR6x/DpmgGrUAb8z4KUTbcpeMBwgQ
 AbBQBISVCxHPVsdkzCVHWGUxhTX/5/b7/N8v4BN2xlY4wm0W8Ue0kV4IaQ8mMp5Wp7cVLLJZ
 DcGFLvRRG1hO6rLm3yT7G++waz0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f2489b390893260ddfaaaec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 31 Jul 2020 21:14:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DBD5C433B6; Fri, 31 Jul 2020 21:14:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4C03C433C9;
        Fri, 31 Jul 2020 21:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4C03C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH 2/4] dt-bindings: power: reset: Add alternate reboot mode format
Date:   Fri, 31 Jul 2020 14:14:18 -0700
Message-Id: <1596230060-6065-3-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596230060-6065-1-git-send-email-eberman@codeaurora.org>
References: <1596230060-6065-1-git-send-email-eberman@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Current reboot-mode device tree schema does not support reboot commands
with spaces in them [1]. Add an optional new node "reboot-mode-names"
and "reboot-mode-magic" which add an array of strings and u32s,
respectively which would permit any string in this framework.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/md/dm-verity-target.c?h=v5.5#n255

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 .../devicetree/bindings/power/reset/reboot-mode.yaml    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
index a6c9102..4ea6b33 100644
--- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
@@ -19,6 +19,9 @@ description: |
   the bootloader what to do when the system reboots, and should be named
   as mode-xxx = <magic> (xxx is mode name, magic should be a non-zero value).
 
+  reboot-mode-magic and reboot-mode-names may be used in addition/instead of
+  mode-xxx style.
+
   For example, modes common Android platform are:
     - normal: Normal reboot mode, system reboot with command "reboot".
     - recovery: Android Recovery mode, it is a mode to format the device or update a new image.
@@ -32,6 +35,14 @@ properties:
       description: |
         Default value to set on a reboot if no command was provided.
 
+  reboot-mode-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: List of reboot commands, paired with reboot-mode-magic by index
+
+  reboot-mode-magic:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: List of reboot magic, paired with reboot-mode-names by index
+
 patternProperties:
   "^mode-.*$":
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -44,4 +55,10 @@ examples:
       mode-bootloader = <2>;
       mode-loader = <3>;
     };
+
+  - |
+    reboot-mode {
+      reboot-mode-names = "normal", "bootloader", "dm-verity device corrupted";
+      reboot-mode-magic = <0x0>, <0x1>, <0xf>;
+    };
 ...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

