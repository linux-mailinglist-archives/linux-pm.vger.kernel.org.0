Return-Path: <linux-pm+bounces-14963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58C298A92C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196CA1F21B0F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151B193067;
	Mon, 30 Sep 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mqeUWXTj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D96190482;
	Mon, 30 Sep 2024 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711655; cv=none; b=IgWOptH+zTWn5Thfxs9/NmqMa/HxVJP/zoNrLckFyBE3d6MmXBnsAJ6LKrKxfbTm31OAIr3duWUVUtwIy65LStjLFHnLGEA21EkpPD9j7q9BLEJU13dj4e4coCVvCuoWGxoJd6CYmqonbISsDfQfvdCs6nwhKHzR8NklmVjZQUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711655; c=relaxed/simple;
	bh=m/7IdEkKhEPMkReOnZZ6V/CwrSu7O1tSM3NvBp9Z6y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLWekKTvcbpd7TI29zlHqLbBKS66v122YNTCVacFig/DeSoZmXrcaN1jOd9xR3/xplli//AZ+1EDp83D38RzYPd8ReKJ7M5l1NY3hclODiiVRo1GFmStevbFXS6eHVtpZQEIABuLLxBBVh4beQi/ymAhleMWtB0Rywzu3r/8PrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=mqeUWXTj; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qME5dKJqS8ynkYI2n9iKU3mNmrn4EubnbBdaMwhZ954=; b=mqeUWXTj2z1FscmydKfbHCES6A
	gh9hE1lZrfSvK9VmNYs0CLxSqVtIwvnq0bmUlqhcv1FDDFS3xNRHVFE4AXhEc0HenVhrp2AxxvUQj
	OPS61UQYIWZaX2t9IwkFMweeusiggxQx41MUsVLpp7ytzdfOh21kQTaqOFoy2dr0T+HhYziGrwxKy
	pL8XqGR8vm/CLyWFXEu2sFbCMK6TTNPJVGaenNSKWUJFtGlnnZtKVma9+minzUPQguMJjQP+AKMgM
	x6lvF/GSdUVh5rcrwVv/csXSJJS+kSTXOP2F6jWI+D/+LNDhdgchVuy+aFYz5uGvRddyTgMIJW+Qo
	N+ycGKTQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	tony@atomide.com,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 2/3] dt-bindings: mfd: twl: add charger node also for TWL603x
Date: Mon, 30 Sep 2024 17:54:03 +0200
Message-Id: <20240930155404.1275702-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240930155404.1275702-1-andreas@kemnade.info>
References: <20240930155404.1275702-1-andreas@kemnade.info>
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
 .../devicetree/bindings/mfd/ti,twl.yaml       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index e94b0fd7af0f8..488d419b211d1 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -105,6 +105,12 @@ allOf:
             regulator-initial-mode: false
 
       properties:
+        charger:
+          type: object
+          additionalProperties: true
+          properties:
+            compatible:
+              const: ti,twl6030-charger
         gpadc:
           type: object
           properties:
@@ -136,6 +142,14 @@ allOf:
             regulator-initial-mode: false
 
       properties:
+        charger:
+          type: object
+          additionalProperties: true
+          properties:
+            compatible:
+              items:
+                - const: ti,twl6032-charger
+                - const: ti,twl6030-charger
         gpadc:
           type: object
           properties:
@@ -222,6 +236,14 @@ examples:
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
-- 
2.39.2


