Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E934317B6
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhJRLsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhJRLsH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5530C06161C
        for <linux-pm@vger.kernel.org>; Mon, 18 Oct 2021 04:45:56 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:45:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VElWnDep+EIyzLiGJXV8CtITvQ4Pi92KY84D1f6IWzk=;
        b=RhRh1n6WgA4KFMs+VsmQHBlH6KQoaS6LPrK8BIptwf82fPi+BXn4PpyOf+alZwauTnatWp
        0eF6mCAFz4ZT/NLRQxDawyLRvSBraLyVy68gds81Xo01DKFp1jMHXhrsU6UolNCrtWSdtR
        xJ8AuAwQLpfKcc1ouT0Mu85XtSlaHKOe1NmhTg8f6sZQmYjBGi7Xe3xqu61kFqKfO4MZ/9
        zrp+v5TPemkbpE/v5Kh6I8T49hKheMOoOLOSBi5dDhMHPbtdy8csWUmOE91JGJK2TX/a6w
        OqztLLGHTWtE0RQJzg/bF7pSqegyxWLNJ6KIulj0c2XLnRtfTPZKeoUF80Z9XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VElWnDep+EIyzLiGJXV8CtITvQ4Pi92KY84D1f6IWzk=;
        b=cFdyoQW6+ovrgU99wczJg/b6S/ehmJGh2SfWG9F9FJtAGKSzhl/2se9Q3viX/uaThfnEqf
        dXniVjtL4E2eVCAw==
From:   "thermal-bot for Johan Jonker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: allow more resets for
 tsadc node in rockchip-thermal.yaml
Cc:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210930110517.14323-1-jbx6244@gmail.com>
References: <20210930110517.14323-1-jbx6244@gmail.com>
MIME-Version: 1.0
Message-ID: <163455755449.25758.12284355665959535282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     07c54d9a409f1fd54df328ec742f156547594347
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//07c54d9a409f1fd54df328ec742f156547594347
Author:        Johan Jonker <jbx6244@gmail.com>
AuthorDate:    Thu, 30 Sep 2021 13:05:14 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 00:14:55 +02:00

dt-bindings: thermal: allow more resets for tsadc node in rockchip-thermal.yaml

The tsadc node in rk356x.dtsi has more resets defined then currently
allowed by rockchip-thermal.yaml, so fix that in the documentation.
The driver now uses the devm_reset_control_array_get() function,
so reset-names is no longer required, but keep it for legacy reasons.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210930110517.14323-1-jbx6244@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index b96ea27..3c07470 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -37,11 +37,15 @@ properties:
       - const: apb_pclk
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
+    minItems: 1
     items:
       - const: tsadc-apb
+      - const: tsadc
+      - const: tsadc-phy
 
   "#thermal-sensor-cells":
     const: 1
@@ -71,7 +75,6 @@ required:
   - clocks
   - clock-names
   - resets
-  - reset-names
   - "#thermal-sensor-cells"
 
 additionalProperties: false
