Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA15140598F
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244780AbhIIOry (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbhIIOrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32EAC06122F
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:36 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4I+63PVzAnTJo3Z3/uXn62y4/ZaZiQauFvwxTpIoGY0=;
        b=NEjTqJGpI4Vxnh0L/eMBw+ja81kxaCDACLj6oknA6ZGABr6lzWLBHMUQWjl1kF8dLIEdLm
        gofFUzmXKm9XzyLI4PI4uhLyHUBF8se3nuqMUEtmCfFpcTsZhp6+nn7HdGh73pyzUMkSUk
        9Wm/XX211vSi1PUZHuvHeT73sluOu/vq4eTKvB/aWNdYrV8diIjHhFxj+0NMyNQ8LgBmBw
        9Vo+2eo1ejU0DS9M6avEQj0xEvj5apOJrhqpPssYot3kCOXMl3IkTmSHDKqVyK8dUt1orK
        L0MLa2DhhUB46mSyQRBqaGuCk4C27dLXKrX2ybLbKaRvE7KVJcPe+u2DPmZY9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4I+63PVzAnTJo3Z3/uXn62y4/ZaZiQauFvwxTpIoGY0=;
        b=xXsbqCetf5WVygeonFF1cXcpVMYtWM5w/rBugGNt4MKyDZz+bZ4/cVcDItm1glf0elrUBz
        BHuW8vYMy64iQMAg==
From:   "thermal-bot for Thara Gopinath" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: Add dt binding for QCOM LMh
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210809191605.3742979-8-thara.gopinath@linaro.org>
References: <20210809191605.3742979-8-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <163119831481.25758.15294576140462455549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     0284b52e85341e3cd4b70c8b2423fd23b8a003a8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//0284b52e85341e3cd4b70c8b2423fd23b8a003a8
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Mon, 09 Aug 2021 15:16:05 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 18 Aug 2021 17:53:37 +02:00

dt-bindings: thermal: Add dt binding for QCOM LMh

Add dt binding documentation to describe Qualcomm
Limits Management Hardware node.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210809191605.3742979-8-thara.gopinath@linaro.org
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 82 ++++++++-
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
new file mode 100644
index 0000000..289e9a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2021 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-lmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Limits Management Hardware(LMh)
+
+maintainers:
+  - Thara Gopinath <thara.gopinath@linaro.org>
+
+description:
+  Limits Management Hardware(LMh) is a hardware infrastructure on some
+  Qualcomm SoCs that can enforce temperature and current limits as
+  programmed by software for certain IPs like CPU.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-lmh
+
+  reg:
+    items:
+      - description: core registers
+
+  interrupts:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-controller: true
+
+  cpus:
+    description:
+      phandle of the first cpu in the LMh cluster
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  qcom,lmh-temp-arm-millicelsius:
+    description:
+      An integer expressing temperature threshold at which the LMh thermal
+      FSM is engaged.
+
+  qcom,lmh-temp-low-millicelsius:
+    description:
+      An integer expressing temperature threshold at which the state machine
+      will attempt to remove frequency throttling.
+
+  qcom,lmh-temp-high-millicelsius:
+    description:
+      An integer expressing temperature threshold at which the state machine
+      will attempt to throttle the frequency.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#interrupt-cells'
+  - interrupt-controller
+  - cpus
+  - qcom,lmh-temp-arm-millicelsius
+  - qcom,lmh-temp-low-millicelsius
+  - qcom,lmh-temp-high-millicelsius
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    lmh@17d70800 {
+      compatible = "qcom,sdm845-lmh";
+      reg = <0x17d70800 0x400>;
+      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+      cpus = <&CPU4>;
+      qcom,lmh-temp-arm-millicelsius = <65000>;
+      qcom,lmh-temp-low-millicelsius = <94500>;
+      qcom,lmh-temp-high-millicelsius = <95000>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+    };
