Return-Path: <linux-pm+bounces-28368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31A3AD366A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 14:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5048A177B6E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B0C29614A;
	Tue, 10 Jun 2025 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ipXVos4F"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F629553A;
	Tue, 10 Jun 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558811; cv=pass; b=C8cQqMOh0sLq3n+fAbglrlqcrI1RC2ffs0pRJwPwsxtiimJxB1N9f7QhWYzYX2lhbpHyif4TztM6ei71A/bHejGQ55aaP6dO6PnH1XqQbOywqNZ3pjig0RQpsNvXaJ5ExhS0q3zZ1cF/Qca8xmIf+ULx2OXSK2DoNK5vqE4Nx/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558811; c=relaxed/simple;
	bh=XQ0dSp3Flpla5xIAgUPRx6pHdPhqCsf7vpoehMz7BJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRy0uwgoRTlP8UyL/U/oW182yWS4lehi7e07QLXAmjfBWauJvJKdfT05u54tsmyNzpwiccFLEGVpMb52qCYmxv1CsUGyYzxkNYj2Xe8XAEHG7n+/hcBamYKNMnW82tMejINvfVGxVGikHmfpvwiIdYdAFmQyajYG5F+l2oaGvJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ipXVos4F; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749558775; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PWrFAe12c+Ts2tfLA2JswJvpCYBMSNzS5AyoFv50ZXlr8FjCWBqcOmSFhpCBdOlRAOaG/+85mB9UF4/AB6PAeymWd6FKePahKd9kHlMFT24NMIncZc4QGZaNjceCcrQwqCG7PFobmUaDRs3RLvIQtaooCaDlhZNNnsHBRxyAcOg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749558775; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r/yCBdXULN/7dimob9RM70hBvraS8nfz9TzFTVD+37g=; 
	b=YJHxPvED16rQ8AaSg54DrvzKYbKM0xp7anEcYkRxAL+mGh+m8CprAT3iyLNgjnESta4ovgWOS02Q306hldkwQl824wAta/R/o9gIkzpI5ObsZtEsnkA2F2phppIMESKFUY3bDBXXY9D2ua3Tk02NbFWrh9x8gcuxv+f2WfoZVOQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749558775;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=r/yCBdXULN/7dimob9RM70hBvraS8nfz9TzFTVD+37g=;
	b=ipXVos4F1ag70tE7+CYrhMEtEYcBoEwficzD+uvDH57MnVWq65ts5BvLE/nQ0HyN
	Qk5znHRSBksD/RNwcxOnC281HcGQTCGHiPMG1XOJho7mnwwD2bac4NwtmXhOluUTNnk
	gwtciSxEfTLUYBVqKGaMn+eydf1w3h/4TQ0wRvw0=
Received: by mx.zohomail.com with SMTPS id 1749558774709569.5144844612655;
	Tue, 10 Jun 2025 05:32:54 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 10 Jun 2025 14:32:38 +0200
Subject: [PATCH v6 2/7] dt-bindings: rockchip-thermal: Add RK3576
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rk3576-tsadc-upstream-v6-2-b6e9efbf1015@collabora.com>
References: <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
In-Reply-To: <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
To: Alexey Charkov <alchark@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 kernel@collabora.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Add a new compatible for the thermal sensor device on the RK3576 SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index b717ea8261ca24ebaf709f410ec6372de1366b8a..49ceed68c92ce5a32ed8d4f39bd88fd052de0e80 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -21,6 +21,7 @@ properties:
       - rockchip,rk3368-tsadc
       - rockchip,rk3399-tsadc
       - rockchip,rk3568-tsadc
+      - rockchip,rk3576-tsadc
       - rockchip,rk3588-tsadc
       - rockchip,rv1108-tsadc
 

-- 
2.49.0


