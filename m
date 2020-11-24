Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAAD2C2193
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgKXJgp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731350AbgKXJgj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:39 -0500
Date:   Tue, 24 Nov 2020 09:36:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fdm3FGAlcMLEBkNnWrjERcPIEQjJU8BWFQs9EJVa77E=;
        b=TotWxl8fBvL0pa8W+LQr/yrTl8cyf5gOVC+23Tzy82UepgCR96RQKF/OnJeHqObzLhvBVp
        DJP4Cw/2HwntFTHpGTERITKFrykkWbJWeiHwRZuVSA9IvgojWjCDL9ZXV9agInoRDXD2HW
        HQ5vC48VXCYfaNJBcxoKkUpV9OXBgUp85vfcvOrRC3UzDHfQaLjCequls63YrDXSFTck5/
        cW2p1+SQEtB4E/2j0XPC/myMZZ9WKSUpZfGxE+0EVif9GMLPf8Cv33k5KaHMpZLHgRWHRD
        uq/AhqAhLk6F4aEc/Xn0m0ItqaaskNBxDkmf4pZbBiVNWaLYZsEwytvAFBGMwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fdm3FGAlcMLEBkNnWrjERcPIEQjJU8BWFQs9EJVa77E=;
        b=k6QErOcHw9wtlBBTOvP1BUa2/VmSC8xTgzdamkOj2gpiXSYnsHg94kqRHZnEQj8OEDns/q
        nU83n0NWWFeYhOCQ==
From:   "thermal-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: rcar-thermal: Improve
 schema validation
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        niklas.soderlund@ragnatech.se,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201028153541.1736279-1-geert+renesas@glider.be>
References: <20201028153541.1736279-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <160621059613.11115.1192711283298552396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     7cfa9770f485c03c877db4a66bbfda96df367b98
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//7cfa9770f485c03c877db4a66bbfda96df367b98
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 28 Oct 2020 16:35:41 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 12 Nov 2020 12:32:30 +01:00

dt-bindings: thermal: rcar-thermal: Improve schema validation

- Factor out common required properties,
  - "interrupts", "clocks", and "power-domains" are required on R-Mobile
    APE6, too,
  - Invert logic to simplify descriptions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund@ragnatech.se>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201028153541.1736279-1-geert+renesas@glider=
.be
---
 Documentation/devicetree/bindings/thermal/rcar-thermal.yaml | 48 ++++---
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/Do=
cumentation/devicetree/bindings/thermal/rcar-thermal.yaml
index 7e9557a..927de79 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
@@ -62,25 +62,35 @@ properties:
   "#thermal-sensor-cells":
     const: 0
=20
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,thermal-r8a73a4 # R-Mobile APE6
-          - renesas,thermal-r8a7779 # R-Car H1
-then:
-  required:
-    - compatible
-    - reg
-else:
-  required:
-    - compatible
-    - reg
-    - interrupts
-    - clocks
-    - power-domains
-    - resets
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - renesas,thermal-r8a73a4 # R-Mobile APE6
+                - renesas,thermal-r8a7779 # R-Car H1
+    then:
+      required:
+        - resets
+        - '#thermal-sensor-cells'
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: renesas,thermal-r8a7779 # R-Car H1
+    then:
+      required:
+        - interrupts
+        - clocks
+        - power-domains
=20
 additionalProperties: false
=20
