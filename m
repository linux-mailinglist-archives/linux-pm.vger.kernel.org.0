Return-Path: <linux-pm+bounces-33420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D75B3C093
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 18:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCD65851B2
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D97A32A3CC;
	Fri, 29 Aug 2025 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="KXifpgkO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F284322DAB;
	Fri, 29 Aug 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484607; cv=none; b=T1RXzmkW6hzZslhkePcYwnVBatV669CvpmEtuoDGCvGxAvJK4/4/vECTycvGvP2ekqv0motJBME/YMP9ina1+lhVg2J9YSuDNAwGVY06jnsJXg/H/fjzoN9oNf3GFH0P2Wo26i1FYEHj5UhOcajPneV61QEURCZaMeXc/W32TtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484607; c=relaxed/simple;
	bh=+LiKf5xAdZ3VQjErBPnxDlU3GQ3YyQ0Gx7TmBGM/obc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9G/IogwaDJtwXxc6jHwvsszk37OolxdRbvYWLYgm0OhKxfoUWfzFqxfkL/J9cu1Kw47bPzAuGKloO0K/gV22VqoOnIXonYuLDPmjPwHht89Ttt4Yf3w3590lDT/2CGyiyS1JYn445kAdGuSsObozk0lMXIn4wsfgR3cJpOgtAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=KXifpgkO; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=XnB+ESRllSz8BZr/E0MZpYZ1CmW/iUgdsQJ9Zb4PjfE=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756484472; v=1; x=1756916472;
 b=KXifpgkO+dTYMTxEmNexcTCbCBq4VqKRTbEyle7d25fhjy5t1qskATsqWEbx11Ujq2rhm34m
 iYznJLphaZADDLS9lq3JtWeQfHmfTynDe44fhs6JY8486QlS6RqjT1aPb1tlrcvlOR0KUX0F+bc
 B3fCMtv6ebWN+QUEHhGGU/mMZ/cIumNGQQvyVPLqDjRaHbzh7lcIDz4K2Ywyg3CiCt4L/Fx6Buv
 kUVpgrv0tIDv269Ejr73J7K7C//AHpWFiQ8SqI8LVGOIZojY5ioI3eYQS37F8/gh/QGcHkXXmdt
 4BzcRK1fqf94NQrE4BLLH5xOP661qTrN8wqKL5x0v0ZTw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 529e469f; Fri, 29 Aug 2025 18:21:12 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Fri, 29 Aug 2025 18:21:07 +0200
Subject: [PATCH v3 4/4] arm64: dts: marvell: pxa1908: Add power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250829-pxa1908-genpd-v3-4-2aacaaaca271@dujemihanovic.xyz>
References: <20250829-pxa1908-genpd-v3-0-2aacaaaca271@dujemihanovic.xyz>
In-Reply-To: <20250829-pxa1908-genpd-v3-0-2aacaaaca271@dujemihanovic.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=+LiKf5xAdZ3VQjErBPnxDlU3GQ3YyQ0Gx7TmBGM/obc=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBkbLxd7zLsy47VSwKc/9pcnyMjnK9vNVg7pFliw+P7z/
 JkRngf3d5SyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBEopoY/unWCxhsWfs6mzGo
 K/fx45e868okuZm45vpsFxP8/ll5kxXDX5makoAdSZrKUl4Ct4s+9BnKsadOOc5f3+N50zDhSzI
 bCwA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Update the APMU clock controller's compatible to allow the new power
domain driver to probe. Also add the first two power domain consumers:
IOMMU (fixes probing) and framebuffer.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v2:
- Drop power controller node
- &pd -> &apmu
---
 arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 1 +
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi                       | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index 47a4f01a7077bfafe2cc50d0e59c37685ec9c2e9..d61922f326a4654a45ab4312ea512ac1b8b01c50 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -23,6 +23,7 @@ chosen {
 		fb0: framebuffer@17177000 {
 			compatible = "simple-framebuffer";
 			reg = <0 0x17177000 0 (480 * 800 * 4)>;
+			power-domains = <&apmu PXA1908_POWER_DOMAIN_DSI>;
 			width = <480>;
 			height = <800>;
 			stride = <(480 * 4)>;
diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi b/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
index cf2b9109688ce560eec8a1397251ead68d78a239..ae85b90eeb408a8f4014ec7b60048ae1fd3d4044 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/marvell,pxa1908.h>
+#include <dt-bindings/power/marvell,pxa1908-power.h>
 
 / {
 	model = "Marvell Armada PXA1908";
@@ -79,6 +80,7 @@ smmu: iommu@c0010000 {
 			#iommu-cells = <1>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&apmu PXA1908_POWER_DOMAIN_VPU>;
 			status = "disabled";
 		};
 
@@ -291,9 +293,10 @@ sdh2: mmc@81000 {
 			};
 
 			apmu: clock-controller@82800 {
-				compatible = "marvell,pxa1908-apmu";
+				compatible = "marvell,pxa1908-apmu", "syscon";
 				reg = <0x82800 0x400>;
 				#clock-cells = <1>;
+				#power-domain-cells = <1>;
 			};
 		};
 	};

-- 
2.51.0


