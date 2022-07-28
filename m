Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0A584359
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiG1PmB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiG1Pl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E098F675B7
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:58 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VU1TMdm3RQm/U5aCSsWpcfDedIcLmC4qMBeL7fZuWrE=;
        b=2idFwuYgTOhVzVlpMMMQsn/oa6T8GIXYvAlh/RVizcByIXUqquVxCwoRZhMkDKBQJZp9HT
        pGYY+fsYoeuhUxgJUV5cFpusvRjsDkRT1whJiyaROPZsM/0J1n85RQzceY+XTk2Ar1Jkqc
        WgQAQD49zcd4mnULP0wrhXv7Or9nFgNk1PR8ZJJQdXJBBNfFLr2ugfY1Y7WrCcNg+PFNxS
        6rXQEj9MF9eJiOP4k27ZZ8huN5u4Qz10MhoACF4ryBHQAU3LEw9NBgDE/mXBFmhREi5FVb
        wncKOspwCGlgqxsYxViiNoW5p8GGJ5hKkX3UU17U3YzIfztu8cGCSM/B7zSYuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VU1TMdm3RQm/U5aCSsWpcfDedIcLmC4qMBeL7fZuWrE=;
        b=S/H42tWjcfuVAZ7T/VyEaSU6QZsp/gDyz9lMHuLJRqytVMaNzei+xJ84aHrZp6vjJhV3E+
        23YUjX/S/AVL5NDg==
From:   "thermal-bot for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779f0 support
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220610201701.7946-2-wsa+renesas@sang-engineering.com>
References: <20220610201701.7946-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <165902291643.15455.17573948852421006443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     83b4466b3f1b00da0cbc754e055e89a7b02b2034
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//83b4466b3f1b00da0cbc754e055e89a7b02b2034
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Fri, 10 Jun 2022 22:17:01 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:45 +02:00

dt-bindings: thermal: rcar-gen3-thermal: Add r8a779f0 support

Add support for R-Car S4. The S4 IP differs a bit from its siblings in
such way that it has 3 out of 4 TSC nodes for Linux and the interrupts
are not routed to the INTC-AP but to the ECM.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220610201701.7946-2-wsa+renesas@sang-engine=
ering.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml | 19 ++++++=
++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml=
 b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
index 72dc7eb..0f05f5c 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
@@ -8,9 +8,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Renesas R-Car Gen3 Thermal Sensor
=20
 description:
-  On R-Car Gen3 SoCs, the thermal sensor controllers (TSC) control the therm=
al
-  sensors (THS) which are the analog circuits for measuring temperature (Tj)
-  inside the LSI.
+  On most R-Car Gen3 and later SoCs, the thermal sensor controllers (TSC)
+  control the thermal sensors (THS) which are the analog circuits for
+  measuring temperature (Tj) inside the LSI.
=20
 maintainers:
   - Niklas S=C3=B6derlund <niklas.soderlund@ragnatech.se>
@@ -27,6 +27,7 @@ properties:
       - renesas,r8a77965-thermal # R-Car M3-N
       - renesas,r8a77980-thermal # R-Car V3H
       - renesas,r8a779a0-thermal # R-Car V3U
+      - renesas,r8a779f0-thermal # R-Car S4-8
=20
   reg: true
=20
@@ -79,8 +80,16 @@ else:
         - description: TSC1 registers
         - description: TSC2 registers
         - description: TSC3 registers
-  required:
-    - interrupts
+  if:
+    not:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r8a779f0-thermal
+  then:
+    required:
+      - interrupts
=20
 additionalProperties: false
=20
