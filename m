Return-Path: <linux-pm+bounces-15181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2939914B9
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 08:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AAB1F238DC
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 06:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D0C4D8CB;
	Sat,  5 Oct 2024 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GnMrDFGE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF43D97A;
	Sat,  5 Oct 2024 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728108318; cv=none; b=UDefCLmehOXr0HBsdX1NfV8rMC+EXWvilEHaUNTgonnMJSNlV92JMPv14JQX45LMC1c1Y7TMrmpUQh+YkEbH0qwd/ZCzQ+ZBGYd45vSiBEaBRhmGVtCtIhK8qQbPon6ySrgnVen/UjSv5mDy4SSRf3f2EJObPfhe87mhpUIJFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728108318; c=relaxed/simple;
	bh=avbkBuu+IeylLDazEvd0vZ3GdpIvrosWqQVh97Iqy/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YX/8RZaa/xoyqf7zjBN8JbNxKXAHv//MZLYd6XvgpBfwYqcyVTjY2I7QXUswthYomZAhrhgDd+uH4TAA0wk9aXzrpxtEzZ3ZkaL+0f8uaJAFND6y4yJhC0WiEMOgeSk1oEyEtWU2Dkx2ZMcIm9nNcIxfXtvyDdqwWbzw8clg74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=GnMrDFGE; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PbKIZr1whktnbITD00APK/aUO0+aJL4weKLvHytG4m4=; b=GnMrDFGENguyGKA+qDpMOM3ERK
	hKnO/xqskqt/0AgRYEs48n2lS/tBM80O8f/duQ1zsCJPDjt9CmKFINyTN/8wBuPtPKUr14NH15cqM
	YePiQTbaojDinciFapEw4akMmAgOvCE1n17Gn8hZmf31Jaybg9ofwJwyv+Rd1yCMN5W1P6UB0BmRU
	B6aiiQ51nCXBPrs0adoVb6A03t09qchPjJLf2xANR7/mh/gekrHb8e8BExQ1mmLZ8IMsFVGB6zDq/
	kIB3vZcTtYVDXveG/9aJ5x1qcGNP35phcmtizCt7kKNf9B89W94t5ih1Z9r0q0EfPfC+5GopP75lJ
	hXZzxg+A==;
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
Subject: [PATCH v3 4/4] ARM: dts: ti/omap: use standard node name for twl4030 charger
Date: Sat,  5 Oct 2024 08:05:11 +0200
Message-Id: <20241005060511.1334049-5-andreas@kemnade.info>
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

Use the established node name for the charger.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/ti/omap/twl4030.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/twl4030.dtsi b/arch/arm/boot/dts/ti/omap/twl4030.dtsi
index a5d9c5738317a..07b9ca942e78d 100644
--- a/arch/arm/boot/dts/ti/omap/twl4030.dtsi
+++ b/arch/arm/boot/dts/ti/omap/twl4030.dtsi
@@ -16,7 +16,7 @@ rtc {
 		interrupts = <11>;
 	};
 
-	charger: bci {
+	charger: charger {
 		compatible = "ti,twl4030-bci";
 		interrupts = <9>, <2>;
 		bci3v1-supply = <&vusb3v1>;
-- 
2.39.2


