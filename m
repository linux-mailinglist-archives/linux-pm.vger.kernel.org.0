Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E548033F09C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCQMjq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhCQMjO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:14 -0400
Date:   Wed, 17 Mar 2021 12:39:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5jN3gswKJZ5NTwsareii2AlkI7mp7ojhkSaMMonOyFU=;
        b=gk9d8G9aKcIKBuoZZca31e7Gt4qY7fEKbQK77/6LQKxEbfrNpy4oJaafs2pWN5ZqJguWQH
        P5AqEWsSiLIAclVrumuc8wuq65c0WwKvkdg6DY59W3uBFyz7uOfOtHbyuADw4inn9FOeeV
        nrVGvF5fUz7hH0k7b/M3chbXZ6fLAKtfGwSTHI8eOXnQ0mo/n7b7v/+q07zex/7b9qU9FD
        bA4AA56a1D8+pkTygjKTEaKFCqu6l7hgUWfiBeuRKTvSrf6BVmNnFW7VjfB9SNeuAyOct/
        1QSVktKxn0G1PvW12UowTnp++DI4y9kEvDGjl3+MRCCVIemT9IR7lYGfDMzKqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5jN3gswKJZ5NTwsareii2AlkI7mp7ojhkSaMMonOyFU=;
        b=RKCi/CKfSwqXRUahBILnnF12jbDKgMGBmulfLL0sCYtczhC1AtSfWNbERx6UH2uVDNURr6
        6g4bTPUc7rbFFnAA==
From:   thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: rcar-gen3-thermal:
 Support five TSC nodes on r8a779a0
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210310110716.3297544-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210310110716.3297544-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <161598475208.398.18080295412577442171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     9468e7b031876935230182628f8d5f216c071784
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//9468e7b031876935230182628f8d5f216c071784
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Wed, 10 Mar 2021 12:07:16 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 10 Mar 2021 14:19:04 +01:00

dt-bindings: thermal: rcar-gen3-thermal: Support five TSC nodes on r8a779a0

When adding support for V3U (r8a779a0) it was incorrectly recorded it
supports four nodes, while in fact it supports five. The fifth node is
named TSC0 and breaks the existing naming schema starting at 1. Work
around this by separately defining the reg property for V3U and others.

Restore the maximum number of nodes to three for other compatibles as
it was before erroneously increasing it for V3U.

Fixes: d7fdfb6541f3be88 ("dt-bindings: thermal: rcar-gen3-thermal: Add r8a779=
a0 support")
Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210310110716.3297544-1-niklas.soderlund+ren=
esas@ragnatech.se
---
 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml | 43 ++++++=
+++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml=
 b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
index b33a76e..f963204 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
@@ -28,14 +28,7 @@ properties:
       - renesas,r8a77980-thermal # R-Car V3H
       - renesas,r8a779a0-thermal # R-Car V3U
=20
-  reg:
-    minItems: 2
-    maxItems: 4
-    items:
-      - description: TSC1 registers
-      - description: TSC2 registers
-      - description: TSC3 registers
-      - description: TSC4 registers
+  reg: true
=20
   interrupts:
     items:
@@ -71,8 +64,25 @@ if:
           enum:
             - renesas,r8a779a0-thermal
 then:
+  properties:
+    reg:
+      minItems: 2
+      maxItems: 3
+      items:
+        - description: TSC1 registers
+        - description: TSC2 registers
+        - description: TSC3 registers
   required:
     - interrupts
+else:
+  properties:
+    reg:
+      items:
+        - description: TSC0 registers
+        - description: TSC1 registers
+        - description: TSC2 registers
+        - description: TSC3 registers
+        - description: TSC4 registers
=20
 additionalProperties: false
=20
@@ -111,3 +121,20 @@ examples:
                     };
             };
     };
+  - |
+    #include <dt-bindings/clock/r8a779a0-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a779a0-sysc.h>
+
+    tsc_r8a779a0: thermal@e6190000 {
+            compatible =3D "renesas,r8a779a0-thermal";
+            reg =3D <0xe6190000 0x200>,
+                  <0xe6198000 0x200>,
+                  <0xe61a0000 0x200>,
+                  <0xe61a8000 0x200>,
+                  <0xe61b0000 0x200>;
+            clocks =3D <&cpg CPG_MOD 919>;
+            power-domains =3D <&sysc R8A779A0_PD_ALWAYS_ON>;
+            resets =3D <&cpg 919>;
+            #thermal-sensor-cells =3D <1>;
+    };
