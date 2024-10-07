Return-Path: <linux-pm+bounces-15271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAC499305C
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8AB1C20D83
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369B11D90A3;
	Mon,  7 Oct 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="0hPaywGJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8D1D88A1;
	Mon,  7 Oct 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313287; cv=none; b=RJpfwgYrIbj213t/neGFLgHtaQwW/3TrwPZ3z2nystkhOAhsgbPzzso6C1UXLs7wy8LqyydKwd17ktnHAgn01PcV/+gs//3l5jov16CqVwxz7lQTxlmIz3eHyT/lYFQnMIXQcI93al0YvWqwU+53i9eP618YcyXAxDL1ID9bjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313287; c=relaxed/simple;
	bh=XRTyy+tPAdS0rlyo7PshymE6DrNwoxuSwblawqWg3Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=coDChT8o64bsjOBk1S/DRsqheLrngnNfEG1tc6F/hdkjkK4ljC43+QjyD9gCG2pJFRFdBAjgmqX46DcQ2orsXMEfweOEAqA9kh4YD4t0BsQe9pYI0/9/y2GMjdJDtDpgr2GhKaIwLgS5e0YO3b9yjLVC5YWiXqyZ1bHm+nF+5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=0hPaywGJ; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZkJJci2T+7+Q5Ziytd2IgxB/Sn5W+2mfU6Lqfqfi2uE=; b=0hPaywGJYGF3HRfQJw/itIsi7V
	097RT3mzzR4I3dQw4TlFFWKagQEHS2qPW6TEbHguqo3OFSRULZdjQfMx1ft/OiZw0tDA+cQFtBCQG
	mNJf9DyxZweTOhfNsd/UgSneVHVwwejDBFxIk1pkNs/ENNIp8BoiZoShl0GjhvVRV0XZaxudXDu09
	kOSxlAL6kmR/rzbi1imDHpMNq9evk+X9AzFiEAxDKQtBNP1m1CQZ8dA2ltSMJExoxsOdgSZOZn0FZ
	/ollpUeQw+/qV1hZHi/QhUpUrtUrLrf+HeSqXoON8WP+G4/NEqi/sYiCekdWdQWp2C1PAf1yqctSD
	ukoVB0YQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	tony@atomide.com,
	Rob Herring <robh@kernel.org>,
	linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	khilman@baylibre.com,
	linux-omap@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 2/4] dt-bindings: mfd: twl: add charger node also for TWL603x
Date: Mon,  7 Oct 2024 17:01:18 +0200
Message-Id: <20241007150120.1416698-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241007150120.1416698-1-andreas@kemnade.info>
References: <20241007150120.1416698-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also the TWL603X devices have a charger, so allow to specify it here.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mfd/ti,twl.yaml       | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index e94b0fd7af0f8..f162ab60c09b5 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -54,7 +54,7 @@ allOf:
           $ref: /schemas/iio/adc/ti,twl4030-madc.yaml
           unevaluatedProperties: false
 
-        bci:
+        charger:
           type: object
           $ref: /schemas/power/supply/twl4030-charger.yaml
           unevaluatedProperties: false
@@ -105,6 +105,11 @@ allOf:
             regulator-initial-mode: false
 
       properties:
+        charger:
+          type: object
+          properties:
+            compatible:
+              const: ti,twl6030-charger
         gpadc:
           type: object
           properties:
@@ -136,6 +141,13 @@ allOf:
             regulator-initial-mode: false
 
       properties:
+        charger:
+          type: object
+          properties:
+            compatible:
+              items:
+                - const: ti,twl6032-charger
+                - const: ti,twl6030-charger
         gpadc:
           type: object
           properties:
@@ -169,6 +181,14 @@ properties:
   "#clock-cells":
     const: 1
 
+  charger:
+    type: object
+    additionalProperties: true
+    properties:
+      compatible: true
+    required:
+      - compatible
+
   rtc:
     type: object
     additionalProperties: false
@@ -222,6 +242,14 @@ examples:
         interrupt-controller;
         #interrupt-cells = <1>;
 
+        charger {
+          compatible = "ti,twl6030-charger";
+          interrupts = <2>, <5>;
+          io-channels = <&gpadc 10>;
+          io-channel-names = "vusb";
+          monitored-battery = <&bat>;
+        };
+
         gpadc {
           compatible = "ti,twl6030-gpadc";
           interrupts = <6>;
@@ -259,7 +287,7 @@ examples:
         interrupt-controller;
         #interrupt-cells = <1>;
 
-        bci {
+        charger {
           compatible = "ti,twl4030-bci";
           interrupts = <9>, <2>;
           bci3v1-supply = <&vusb3v1>;
-- 
2.39.2


