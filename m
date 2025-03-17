Return-Path: <linux-pm+bounces-24164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0C9A651BA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596623AB1E1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31323F422;
	Mon, 17 Mar 2025 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="UjzBxYjQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29223C8BB;
	Mon, 17 Mar 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219447; cv=pass; b=pJHX4CJvtgVh7yupADZwn5bqyipkxQadM+cAn0FIT3/dGY4HMLQxtYmKxhBY5sLxQrkGdHngOXetMxKJ1sM10ByeOqauuTagJgbOiXz3dzjC5v9wq/mpAyCdmMDILEANqecudDEFJDrsbV7ye5mXlsIapdVGVQ3bACbqADEkgL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219447; c=relaxed/simple;
	bh=qD0ohSixxyfcyZNwZTY+EVVmsFxDCEnbu5RvtJbYW6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LT5NR1NQ5zpFrrYn1PEzqDZUpg0iUVMTFJD5K/IkX1el/tupAkPag9rZlLJY1/x6eGg6a/vvnmjuledSd1yKuU6DF0EIzIXoRFbePIehUm9XVwxtVNsGp9Rb0hacdByKIX3sJjveaExbJIAP3tYamIFDf/zqcVqJYjPr1Ts/GCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=UjzBxYjQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742219427; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H1/BIELGrcSV2RkcjqcFWnyCJynKfr2bfz3LVadEFFE6GN52IQNRH5Rd1BfjwtSx8qhdqdo34FKMN8dOINWKOQvJXd85Sv8AbIjvr+KVWbscoKpFjM4sIiPjz0JX8jH/80h9zwn7OZSpkzB4jy6KGCCR0Tj6oRa4x83c2RYK7c0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742219427; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cWGtW43TgLnA9XLRjmVYZyHmW1immnR6brlslYhRp80=; 
	b=dA7bukRLyuHRswe7QSIqVsrLQbKeMxvuOKrrlI09gn8fBan6iFcBbbH00T3AwP5dGwneRyogt3ThcWStGTAohPyvit/BCOy3ajS1foceBszAQXuvds7l5fq6QhpP7RA/e8oVC3AyOSrb0bYcZKS5nwyf4s5JHlbpaDcucXAw71M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742219427;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=cWGtW43TgLnA9XLRjmVYZyHmW1immnR6brlslYhRp80=;
	b=UjzBxYjQ+WxkrbzyzgoOyUADq5vbSDAMRzCgcoCOVJeeD3cyFvh8UjgB25kqnHZe
	jzte+0ajnSg16286ZAsl4vZlYGOvAB3g7sQEYB5311r97ybRgUfSZvu3mccfM7Zfh4A
	5OlDNHkDmEFIVoQaTYHwgyhs+uF2EyyYL5C/stBo=
Received: by mx.zohomail.com with SMTPS id 1742219425926664.8954147028828;
	Mon, 17 Mar 2025 06:50:25 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 17 Mar 2025 14:49:27 +0100
Subject: [PATCH v4 2/7] dt-bindings: rockchip-thermal: Add RK3576
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rk3576-tsadc-upstream-v4-2-c5029ce55d74@collabora.com>
References: <20250317-rk3576-tsadc-upstream-v4-0-c5029ce55d74@collabora.com>
In-Reply-To: <20250317-rk3576-tsadc-upstream-v4-0-c5029ce55d74@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
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
2.48.1


