Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813E258435A
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiG1PmB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiG1PmA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:42:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D418B68DD8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:59 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUA+LW192UQ1JxhVC1I/H0vA6s0BrleJHJNG5RbPAho=;
        b=PrihWdG6lu+cCvBb1JsR5tkT1oZp7+kOJvcp03f9o2kER/SvMFkR/5c1U1AyiZIxUEN/ZA
        QlGGaZSohzOmC6DpAOSPvGAxdKE3E7I0fXsiFUzJSdd8vWkFmoWj+yva1Z/HlqhVtZWgYR
        z+clS2wD/YR12e3dgy1hltOnd+CvnmMj/fv1CUM2arehkKHO2A88UYVPou47dMeAofjHdj
        DmoTmfjIJ0M8Y36RiWVZORMsXdoRilENpPiXKJxKfQ9MW/NQpOKQ95A1KSPsWWlisDDZ65
        00JTwobJDDQ305kymwaJzZpHRi83exFtCI0Ba+DA0il+3JlcYFWMtgED/spVNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUA+LW192UQ1JxhVC1I/H0vA6s0BrleJHJNG5RbPAho=;
        b=hgNGXu9ak6u4nB0ESRrEH0j0hZmCCi6iQfSocoRBCxr5kxUwBZiQIZyqKPBPwVQAXGMrGo
        y9XIf0h8nfkJ4NDw==
From:   "thermal-bot for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: rcar-gen3-thermal: use
 positive logic
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
References: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <165902291737.15455.15687289685540232539.tip-bot2@tip-bot2>
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

Commit-ID:     3c1fa94cd0baca8d573aead43f33785eca66ed42
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//3c1fa94cd0baca8d573aead43f33785eca66ed42
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Fri, 10 Jun 2022 22:17:00 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:44 +02:00

dt-bindings: thermal: rcar-gen3-thermal: use positive logic

When handling the V3U/r8a779a0 exception, avoid using 'not:' because
then its subschemas are far away in the 'else:' branch. Keep them
together using positive logic.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220610201701.7946-1-wsa+renesas@sang-engine=
ering.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml | 21 ++++++=
++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml=
 b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
index 1368d90..72dc7eb 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
@@ -57,31 +57,30 @@ required:
   - "#thermal-sensor-cells"
=20
 if:
-  not:
-    properties:
-      compatible:
-        contains:
-          enum:
-            - renesas,r8a779a0-thermal
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,r8a779a0-thermal
 then:
   properties:
     reg:
-      minItems: 2
       items:
+        - description: TSC0 registers
         - description: TSC1 registers
         - description: TSC2 registers
         - description: TSC3 registers
-  required:
-    - interrupts
+        - description: TSC4 registers
 else:
   properties:
     reg:
+      minItems: 2
       items:
-        - description: TSC0 registers
         - description: TSC1 registers
         - description: TSC2 registers
         - description: TSC3 registers
-        - description: TSC4 registers
+  required:
+    - interrupts
=20
 additionalProperties: false
=20
