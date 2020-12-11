Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6A2D764C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 14:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436586AbgLKNKY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 08:10:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34926 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436592AbgLKNJq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 08:09:46 -0500
Date:   Fri, 11 Dec 2020 13:09:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607692143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjwTtOei504S012xRWLSfHr6RA5taAIdCacZR3sWO1U=;
        b=4qWstBEFq5M5WrZuNZf7aDwXxrgLz9yPwBJ9G96tgcVl+d3auxvEW3H7Xs7pO8hCMpRCKY
        Co7c2V519lMR0hdJLf1LvYfLgczCpWTAs+2Kyeg2nNSoUIK8bN48F65oo7Tlvr3dIBuzU+
        fuqYRb+QiEAQUHjxlHm4KLJSuTwScrdjBDn7Fool5f3Icq6GcgOS+cZwPvyWwcY1iBgoVk
        jAUah/8VsCJ846AAIyTWew6JK8KEt1/xp5eoTJbi0SNr0Jb1tfmhyXJXtsAcZx359VUiI4
        kOI6lvbUaIF7Rs2WXErMCafT4SVtuZnA2Oc/v/Mg6JeNhSLBcDlOrjZxjoh2cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607692143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjwTtOei504S012xRWLSfHr6RA5taAIdCacZR3sWO1U=;
        b=c6JXSGpOad9rlpQquo4ETR3ZD7KILlL12EqIAJZrFYuZ6RgCAJG5HPVhXn9ZrgT9FH9QOl
        g+GdWRV0xWjz20DA==
From:   thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779a0 support
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201126223028.3119044-2-niklas.soderlund+renesas@ragnatech.se>
References: <20201126223028.3119044-2-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <160769214328.3364.9880928927756194391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d7fdfb6541f3be88d7b4d5ad0aeba7c14548eee8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//d7fdfb6541f3be88d7b4d5ad0aeba7c14548eee8
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Thu, 26 Nov 2020 23:30:26 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Dec 2020 21:16:35 +01:00

dt-bindings: thermal: rcar-gen3-thermal: Add r8a779a0 support

Add support for R-Car V3U. The V3U IP differs a bit from its siblings in
such way that it have 4 TSC nodes and the interrupts are not routed to
the INTC-AP but to the ECM.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201126223028.3119044-2-niklas.soderlund+ren=
esas@ragnatech.se
---
 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml | 17 ++++++=
+++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml=
 b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
index f386f2a..b33a76e 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
@@ -26,13 +26,16 @@ properties:
       - renesas,r8a77961-thermal # R-Car M3-W+
       - renesas,r8a77965-thermal # R-Car M3-N
       - renesas,r8a77980-thermal # R-Car V3H
+      - renesas,r8a779a0-thermal # R-Car V3U
+
   reg:
     minItems: 2
-    maxItems: 3
+    maxItems: 4
     items:
       - description: TSC1 registers
       - description: TSC2 registers
       - description: TSC3 registers
+      - description: TSC4 registers
=20
   interrupts:
     items:
@@ -55,12 +58,22 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
   - power-domains
   - resets
   - "#thermal-sensor-cells"
=20
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - renesas,r8a779a0-thermal
+then:
+  required:
+    - interrupts
+
 additionalProperties: false
=20
 examples:
