Return-Path: <linux-pm+bounces-30730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720AAB02CCD
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 21:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E0D1AA103E
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 19:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3397D28E61E;
	Sat, 12 Jul 2025 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="XrG2t3kM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76E28DEF0
	for <linux-pm@vger.kernel.org>; Sat, 12 Jul 2025 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752350353; cv=none; b=Bl/cEJd2j4xfnkvoVNjxQonLMFDfELt5ZC9TNszhflkNPuSIzbJuN6zfwOtgemk+IkaDecQZ+D5+nRgbZQ1S8gJHbkJgdHmuqpFpVZ9d4xOMM/Ebh+d+rCnir+OS2LWN4DmQfCiO9sA5Fe2ulWgoxWR4pSMAfNQdusg3UcE6bNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752350353; c=relaxed/simple;
	bh=Cf2vIgp85K1Bugn/4he33j98AsTuMOxEkZgbyWQo7j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiqLaAAQv2qm8FNEI4juVKWVztvx3sFUpuShlp4eUbsagSl9EJ+0/CegznLYV07xp35dxDaTpZ5bElr/b/8Ya6wV69Wc6dGg8YVz4xWOFkuZpV7bCla+81evUaIdd/8OdWmBEyLU5eleiDQt/ri2aKmpuJVlxKgALojgAkRnVUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=XrG2t3kM; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 40337 invoked from network); 12 Jul 2025 21:59:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1752350348; bh=WYawKN+5MYGds6VxRs2d7qo+CH5vM5SkgS7CBcdvPVY=;
          h=From:To:Cc:Subject;
          b=XrG2t3kMckVauQKz0F+m6Zb+dMXvYQV7LrPFcSqNirJWLDdMvRgzjHpnE48hDBKMJ
           OFQUt0kEY381fB8H/3A8H100bqZIDoxFxochvoOFeG122uL8nn3yLR2iTmktUSKrCr
           UR+XA1k0ti22puq0T9zQ7oBV+pYWzD41y2BDid/91hgB7ne501HurBlhzszQRO7Uaa
           eMpPDkB3jOoHOli2Ow1GD5Vcw1AC0Tg26OIDhLzjf/PXTL2rLFfWjJ5Lx3lWZK/sxb
           9yngqyPEKhEvHjBjd5f/rKA8sl/jR81oSjV4DAzwRUyAB3NWpC7/Km80Ktt5qAqOdl
           MnLYcDa4X3Oug==
Received: from 83.24.150.40.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.150.40])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rafael@kernel.org>; 12 Jul 2025 21:59:08 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	s.hauer@pengutronix.de,
	rafal@milecki.pl,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: thermal: mediatek: add falback compatible string for MT7981 and MT8516
Date: Sat, 12 Jul 2025 21:59:03 +0200
Message-Id: <20250712195904.6988-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712195904.6988-1-olek2@wp.pl>
References: <20250712195904.6988-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: b3b18c2aee2b4ebbd80a5f6acede9098
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0100003 [8XAz]                               

The ‘mediatek,mt7981-thermal’ and ‘mediatek,mt8516-thermal’ strings
aren't definied in the driver. Both should have fallback compatible
strings. This commit fixes this issue.

Fixes: 788494ba0999 ("dt-bindings: thermal: convert Mediatek Thermal to the json-schema")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/thermal/mediatek,thermal.yaml    | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
index d96a2e32bd8f..7bd0955e6d04 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
@@ -20,16 +20,23 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt2701-thermal
-      - mediatek,mt2712-thermal
-      - mediatek,mt7622-thermal
-      - mediatek,mt7981-thermal
-      - mediatek,mt7986-thermal
-      - mediatek,mt8173-thermal
-      - mediatek,mt8183-thermal
-      - mediatek,mt8365-thermal
-      - mediatek,mt8516-thermal
+    oneOf:
+      - enum:
+          - mediatek,mt2701-thermal
+          - mediatek,mt2712-thermal
+          - mediatek,mt7622-thermal
+          - mediatek,mt7986-thermal
+          - mediatek,mt8173-thermal
+          - mediatek,mt8183-thermal
+          - mediatek,mt8365-thermal
+      - items:
+          - enum:
+              - mediatek,mt8516-thermal
+          - const: mediatek,mt2701-thermal
+      - items:
+          - enum:
+              - mediatek,mt7981-thermal
+          - const: mediatek,mt7986-thermal
 
   reg:
     maxItems: 1
-- 
2.39.5


