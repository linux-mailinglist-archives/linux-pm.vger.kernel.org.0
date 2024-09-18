Return-Path: <linux-pm+bounces-14394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1282097B97F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3031F26D52
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 08:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C30176248;
	Wed, 18 Sep 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="vpdd6oMO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942C148828;
	Wed, 18 Sep 2024 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648905; cv=none; b=DeL7I0tpSN5t4wzcSXB1a8OeLACqEByICKjGdPLaiBlU7vWUJyArKyWiq1Jl4ch2IFcmsbSzqdX5Hs93ZQ1sEvYdBkk0frOycWa8F77rCse0io0Zt2SV/eJ9AS4KQbKUGSgWguxx2Hf4hVgFE7Iu49AdugFPQQqyLS2UybBUZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648905; c=relaxed/simple;
	bh=qjuNdlksR9yGfHpkynV+DFXIkyKj53BhLgH5VWtugd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0avkzCcJM45wA4iPWirEqTpSc2ZXt3gJeOel1IXJLj2X88nFjlDOG56ppJ2fFyXC4IreMj1ERA/VgZ7zWWTO5N/qcJEgISiTRh6le/ClzMTCSO1BFqcmyQFbpRQHOBcwZiTaNAGXp96ze0kdVXWZQcZ8EjD0gZicWUOBOqcPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=vpdd6oMO; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6MMpqe8RdWNqEnjtuGlscoUN+tlWO56cfIwDFZqVaow=; b=vpdd6oMOYY8y1hgXRhTjVlNvyr
	alDdKiCj8jIqqDNPF4wrbqk+XkBkaN7ckk3GbhhYOQyKp0C8zh26HfDkFOk7chyJJpEYjubnH4b/h
	nxctjxv26CD2yx92OXbfPX1tD2W+jxfN0tbPbINDpXmbK7Uq/amY5XXnbLyhkgzEQY01XArP/JtDk
	EnanUCprlqBPiMzERl/0mnZpgHblkMCuo4OB/26bDNPQXaJcbORMsA2H2ZiyexTbUQCClKaPGD20T
	yV4yYUttRzzFW9NvaX+i+5Reeie3lomlNT8dwT1/CCZQkeXw/yIe/6/hmqF8tW9uWdLU7dgy0TnBP
	PBVOToyg==;
From: Andreas Kemnade <andreas@kemnade.info>
To: tony@atomide.com,
	Sebastian Reichel <sre@kernel.org>,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/3] dt-bindings: mfd: twl: add charger node also for TWL603x
Date: Wed, 18 Sep 2024 10:41:31 +0200
Message-Id: <20240918084132.928295-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240918084132.928295-1-andreas@kemnade.info>
References: <20240918084132.928295-1-andreas@kemnade.info>
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
 .../devicetree/bindings/mfd/ti,twl.yaml        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index e94b0fd7af0f8..4064a228cb0fc 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -105,6 +105,11 @@ allOf:
             regulator-initial-mode: false
 
       properties:
+        bci:
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
+        bci:
+          type: object
+          properties:
+            compatible:
+              items:
+                - const: ti,twl6032-charger
+                - const: ti,twl6030-charger
         gpadc:
           type: object
           properties:
@@ -222,6 +234,12 @@ examples:
         interrupt-controller;
         #interrupt-cells = <1>;
 
+        bci {
+          compatible = "ti,twl6030-charger";
+          interrupts = <2>, <5>;
+          monitored-battery = <&bat>;
+        };
+
         gpadc {
           compatible = "ti,twl6030-gpadc";
           interrupts = <6>;
-- 
2.39.2


