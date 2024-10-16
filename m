Return-Path: <linux-pm+bounces-15740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17AD9A038F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 10:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F67281C8A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 08:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A69D1D26F5;
	Wed, 16 Oct 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="2yj2s5eS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB151D1F5A;
	Wed, 16 Oct 2024 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065807; cv=none; b=aYATSTSBtpYTqks2sjW5WBBa9FXjycGRdIZBKYatG5Bvi2aSWgNiOg4941+PAT397puC0fpWi1/tMNcmz+yWoRjcwpoTC15yxT5A6N60/9b6tAn+2BmLY6JG2kJpNpL/doSvQKzF6ZEvFqk/qclSak4EybVx5wXK554JMU654Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065807; c=relaxed/simple;
	bh=avbkBuu+IeylLDazEvd0vZ3GdpIvrosWqQVh97Iqy/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5adLHmBKSgTVdBPd1CtKsiPyc2ZgmSr1QnrgMYyHpCTxr+THU5wstN8u2Lc9sP8qgXDO+1RE80iwcVddiR+4rAWx8g0uMkSgqNvhV4PS+jg+bJLy/LlZgIUeVCmT5n5d/X8oJjeAxmpdklTYwWzt2LZkrPT1Q6hdrCr5EtddN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=2yj2s5eS; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PbKIZr1whktnbITD00APK/aUO0+aJL4weKLvHytG4m4=; b=2yj2s5eSe5s1p/PZqGvHq1Rkk7
	/Dy8fN3tJYAWv1zf6CnLyxnO4z2R1uAXVzHNYZx8dbjDb9sYmNhtX245YkF4rCH50T66zA184dHjV
	td2uUAkxQOecXydEwAnY9DaaW/mVSllKU5THjfAUngiE8cyTa1gLDsWYe5GCBI9r0z9eMUwx5nH8p
	Z2db0WKncI448S8gfRYioNAoQxU3Hrdhp+gB+da/WH6ZuFAUQi/wMOK4G9qzJzCtsf3sOkDjr4RtS
	so4MjSBauFFdbGr/dxTNMb6cZok+AoGQ/rSuwDkBx8eFaS7HsML8Rt5rk9/uSnATSPRf5HHCxSmIQ
	i4Sa3fNQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: khilman@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	tony@atomide.com,
	linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v5 3/3] ARM: dts: ti/omap: use standard node name for twl4030 charger
Date: Wed, 16 Oct 2024 10:03:14 +0200
Message-Id: <20241016080314.222674-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241016080314.222674-1-andreas@kemnade.info>
References: <20241016080314.222674-1-andreas@kemnade.info>
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


