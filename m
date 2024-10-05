Return-Path: <linux-pm+bounces-15184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B609914C4
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 08:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43272836C3
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 06:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA2612FB34;
	Sat,  5 Oct 2024 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="4ybJeQwy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA125761;
	Sat,  5 Oct 2024 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728108319; cv=none; b=EZW8oxjySXhlCoGmmx3uAvoY5TeQ/NBd9UpUquQl6nSw4bIww9fgI5UvuS8a1sJoNE9yCcL4qKoa+fELOeTT4rEFR8iJCLFtGna5IRdSX8KaGz9x8Tkn+OD2d5t888ejuUloQX0nH58onCJ49n9+2hiCZZrpZD0C8pQ/7W+upxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728108319; c=relaxed/simple;
	bh=yiQQZDD6QSNVxY4ACyJ8QcOaJxXST5yvWz5JfGWP6wY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WOLTJgIurPp/cxQECITulx1vSvElLY3gkT3XWgQ1Hq3hrOERsWcSApeykOWfOfC7FKhO514WU+AJzn+b/XiLHHCt12KCTcdSpLLNli4CwKUU+WAYA7KVJb30Vp4UxWUkU6v4H93v7OrWdwRVoQy13PyPkbJ54OAhatdeWG/WtTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=4ybJeQwy; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wbOntimuwMRlj4Bv93aA0g0ubjkJNOwEkjhEMUXeecE=; b=4ybJeQwytnm4/H5amtXUCnlpct
	gCJJMddaccdBzxSInylwkMK5aqsK+V51NiOW8TSM1BZ27atSuvUCjlM6VgojHIQtdF7wWwSbNpe7C
	jZ71VsQixImX9dTawcliWgT6qcQOK+azLkzFawinBwA/uguzJCHUQhhM/jXnsSYz4nTbrai5R7zy9
	Zly4KPGoatfiCowhab+6dbnWVs7jLr6y6C+5+7gXw7UO8zLEhYsAxCtUthw6MA0Fe5enrDN67iaye
	1ex5TxZJKQy8hASj2OeLpr2dCKDn8UPc1sulwG5UIRAOfsczK/tG+Aqvx80w/qRxT1em3qR89AzDV
	ygSd2Y7Q==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	tony@atomide.com,
	linux-kernel@vger.kernel.org,
	khilman@baylibre.com,
	linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 2/4] dt-bindings: mfd: twl: add charger node also for TWL603x
Date: Sat,  5 Oct 2024 08:05:09 +0200
Message-Id: <20241005060511.1334049-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241005060511.1334049-1-andreas@kemnade.info>
References: <20241005060511.1334049-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also the TWL603X devices have a charger, so allow to specify it here.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../devicetree/bindings/mfd/ti,twl.yaml       | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index e94b0fd7af0f8..e772d13adbfdc 100644
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
@@ -169,6 +181,12 @@ properties:
   "#clock-cells":
     const: 1
 
+  charger:
+    type: object
+    additionalProperties: true
+    properties:
+      compatible: true
+
   rtc:
     type: object
     additionalProperties: false
@@ -222,6 +240,14 @@ examples:
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
@@ -259,7 +285,7 @@ examples:
         interrupt-controller;
         #interrupt-cells = <1>;
 
-        bci {
+        charger {
           compatible = "ti,twl4030-bci";
           interrupts = <9>, <2>;
           bci3v1-supply = <&vusb3v1>;
-- 
2.39.2


