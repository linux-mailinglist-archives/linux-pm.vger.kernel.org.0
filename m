Return-Path: <linux-pm+bounces-32015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F98CB1CAE2
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 19:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C51E4E37F7
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 17:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CC729ACED;
	Wed,  6 Aug 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="tt9i4Luy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8A1E25E8;
	Wed,  6 Aug 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501716; cv=none; b=TdDyG5f0I7nz9J+18l3DKfkeVtiRFBhqhM4HY5Uo9GzySHQBwRMHbFs3hUiPwiHrY+9sw9ZAlQACFnfdEYkbGLFyTkDDX5YNLfBV212YrQ5cwvfzD9u31vMGfmlXNxOHyk4/F0npavGDAzkOlQ0QTlEyaocedGvtFKIzxx5uR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501716; c=relaxed/simple;
	bh=Z1gEMJiFIFjpRGok6tz/RfwwoNl0Rv2K7M7v3c9mDIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jRO4XdQn3XMwYMhHDqZJlBcq68licWOTiYY3qE+IKgbKt/hmJyyyk7W2Ce/FDCx59hHqObhdin6D24slh9Cc8DRGSJAllNxDRaRUlLqoawAeGVYyCdvuTqhxcKRwFUzygNb15S9paVBw1x6FUd2y+MUuxqkOC2Dt1+MmaCWSLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=tt9i4Luy; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=fV6lVtW13D0yu6iCI/jPFRPbDpKGqEPIm6A+8YzQujM=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754501630; v=1; x=1754933630;
 b=tt9i4LuylpZBhSuTuK9fRqLtp9gqEe9lN2eWeJbj22p4QHsOUDtod8ktIIlSwrngs5kXjlE9
 nhSxBJVppkGnhT4bojW9PQIujy0a8Iu35WjrmueQ6ofQvfD1fnEHkUnsj0QhJ+6EcE0/gJGh1lN
 ebmxopqB4UOqe0Xlu95uHfXkDZqrOG1Ng/EsyHVaqAwF/WpDKYwqHIeey0xWOkLZX7tYFsP3sMY
 tKobRVGF4LRNZKMCWVwNjTl2PNwJCqwefOf66XIfI5nqYe386q62NauVhAbwD6bUdao2krTrqxv
 Xxk7w2PjWzQlrIam3J2OzcBJfjU6l7D7QSfP/tqskpchg==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id ee7cda2d; Wed, 06 Aug 2025 19:33:50 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Wed, 06 Aug 2025 19:33:20 +0200
Subject: [PATCH RFC 1/5] dt-bindings: clock: marvell,pxa1908: Add
 simple-mfd, syscon compatible to apmu
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250806-pxa1908-genpd-v1-1-16409309fc72@dujemihanovic.xyz>
References: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
In-Reply-To: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2431;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=Z1gEMJiFIFjpRGok6tz/RfwwoNl0Rv2K7M7v3c9mDIw=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmTJ/5Z0mnWXV+/UbX1oWRn2Pp4jWtV4ZapKw8vnbqc3
 fnxTE31jlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZhI4VKG/z4zlEJKtGumOxVI
 hNg6yD227M76wvc6UTnRUD9xQtv3DoZ/dgEqycen7nV9sNT/wTU5KyWHb98M6758mGz5WlTjQYw
 EAwA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Add required syscon and simple-mfd compatibles to the APMU controller.
This is required for the SoC's power domain controller as the registers
are shared. The simple-mfd compatible allows devices whose registers are
completely contained in the APMU range (such as the power domain
controller and potentially more) to be children of the clock controller
node.

Also add an optional power-controller child node to the APMU controller
to accommodate the new power domain driver.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 .../devicetree/bindings/clock/marvell,pxa1908.yaml | 36 ++++++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
index 4e78933232b6b925811425f853bedf6e9f01a27d..5e924ebd97e6457191ac021addafd22caba48964 100644
--- a/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
+++ b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
@@ -19,11 +19,15 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - marvell,pxa1908-apbc
-      - marvell,pxa1908-apbcp
-      - marvell,pxa1908-mpmu
-      - marvell,pxa1908-apmu
+    oneOf:
+      - enum:
+          - marvell,pxa1908-apbc
+          - marvell,pxa1908-apbcp
+          - marvell,pxa1908-mpmu
+      - items:
+          - const: marvell,pxa1908-apmu
+          - const: simple-mfd
+          - const: syscon
 
   reg:
     maxItems: 1
@@ -31,18 +35,38 @@ properties:
   '#clock-cells':
     const: 1
 
+  power-controller:
+    description: |
+      Optional power domain controller node.
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: marvell,pxa1908-power-controller
+
 required:
   - compatible
   - reg
   - '#clock-cells'
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: marvell,pxa1908-apmu
+    then:
+      properties:
+        power-controller: false
+
 additionalProperties: false
 
 examples:
   # APMU block:
   - |
     clock-controller@d4282800 {
-      compatible = "marvell,pxa1908-apmu";
+      compatible = "marvell,pxa1908-apmu", "simple-mfd", "syscon";
       reg = <0xd4282800 0x400>;
       #clock-cells = <1>;
     };

-- 
2.50.1


