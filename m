Return-Path: <linux-pm+bounces-15269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62455993056
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150E428CB9F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0591D8DED;
	Mon,  7 Oct 2024 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="C3jR8ClV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420D1D86FB;
	Mon,  7 Oct 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313286; cv=none; b=PaMQXfUbu0GVcIR0fpAaJU0gq4roGVcDOS3p/gqY+OanHMAJZgmgtk7hO77EdNx0tdjgtF5JcbzFo9gYTl+p7xi9OAMShGA3LHMaBv7eK2q+9Xdvhvkp1VRfLnOzj+DBeS+NYX92jwsq5LBLKMAz8CPyxmecTaYw94SPT6BizWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313286; c=relaxed/simple;
	bh=avbkBuu+IeylLDazEvd0vZ3GdpIvrosWqQVh97Iqy/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O9VwlCTFD+nGBB4sJDi9hZslxUwxx5tbvtGnXx6RJZd4MjNIA9n11MofZK8oYii7Zj+pyF1H2J72ML2lxCWSkzeMgC4UD2BvGc/YnIGbVNuP9piJ8KDoBqiPsec5tvpHJ7OJ3OLtWG87yillxzu0CfF8QS+UC8Yr7qY+OoJCu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=C3jR8ClV; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PbKIZr1whktnbITD00APK/aUO0+aJL4weKLvHytG4m4=; b=C3jR8ClViDioxjAcrq1vPh4VfJ
	+zSbxcQFf67GutFF1H4SRmvWbkN+HeMdWqk1yQSj6UcW3ufc+ZP0YIOTnI87iepjxkpfz+XLlNlbQ
	wxFuWR6BkQjVOZhgOTRDomsOslmQPSdb0Qks2C3sjN0bg+nCc16Xok1DnZLuuoRmkzkWpRtO43iSZ
	399OvgXEmVNQWhBzU0qjGmC2R9dLTz92HhFPDAjImRPcvq20HmyAH+QoZr/b6EH3dCQIeDttqcSLH
	HNV1mK891h/TqC7Iojbw7Sz2Y2j1pO9XWJMEGFKTTRVVLrMxkuinOcWC9pQu0b0UfS3wDArICYu7I
	Azk4JHMg==;
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
Subject: [PATCH v4 4/4] ARM: dts: ti/omap: use standard node name for twl4030 charger
Date: Mon,  7 Oct 2024 17:01:20 +0200
Message-Id: <20241007150120.1416698-5-andreas@kemnade.info>
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


