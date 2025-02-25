Return-Path: <linux-pm+bounces-22883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CDBA43FCC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFD519C0B93
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED8C268C63;
	Tue, 25 Feb 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="GTNrD93e"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751D25487C;
	Tue, 25 Feb 2025 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488271; cv=pass; b=eYMzqKVnRM8FtHCIdwJoGatuocxuHO32Ls+qQ1nHF373w8pc3YfzRxNdo5jkCedxCjkkLJBrMpWZLBXlQUTiXSGYllQaoyDBg8M1N9+OP8H0eWGSoS5ThhRJ4hhOa17dm0rHgfUsca2CIINmgEuJ3ZGK1cLJ0SaNK6A0fdPmOWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488271; c=relaxed/simple;
	bh=qD0ohSixxyfcyZNwZTY+EVVmsFxDCEnbu5RvtJbYW6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBUoCd4v/gHutLQjS9Kp2icMvVWrTMndbsIAfnZ18/SGSJ29UidQtLh54viYLRLtaL7wYsvGDdsdAT3dg9GpvmHRwPMpQxF+do/mogdIq0nAz5s3/PXOkew7iuou2PDb0KfW72Kbb7oiD3gi+NRqsvu7Wi83/ivT2UPZDlSUWpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=GTNrD93e; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740488248; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lmcXg71Tfat+hgjWvLhShXas9QGFsvlWYt6HKtso735A8hdFlY7syJ2e0onyCR4aGj1YfjHOC8SucKM0+mOwIUJ97KRkHeypbiGl8kCgogRl5AhPXiiB7Cx1i0zU26BOeChFfNI+QOhWLUCBoIqwq7H5H0RXt6F4Dt2tesQq/p0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740488248; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cWGtW43TgLnA9XLRjmVYZyHmW1immnR6brlslYhRp80=; 
	b=mfohuTo97wtGhA6gUQ1s94iiCJzuNmrWxs5mbI13B8q59JmL36ihXBJFQKFA1tJFmBX9QEkpYd+DV29yr4fMM3Le80U8hGxXVhoaoePRH5GTwaYJs2aQT9i4foK1FA5hpXJhI0ai38N3UhVmoeDXRpIPRgD0a8kCO1emP3tkqq8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740488248;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=cWGtW43TgLnA9XLRjmVYZyHmW1immnR6brlslYhRp80=;
	b=GTNrD93eBrF+xM9lAwCtYSod3XyhAMdx8D0mEBbrXSXRDEgy5QnGk0eIpXX1xh6S
	WkhGiLaeK+m+VuJrp9glWvadYUOMdeEswTiH7Kn07gxPl63c9NnybeCduhz1sh3yR1P
	KfaZ2ofWjVzkOunW+M7BApYr3UT00J+FRTEJ+6NU=
Received: by mx.zohomail.com with SMTPS id 174048824766496.17668398054809;
	Tue, 25 Feb 2025 04:57:27 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 25 Feb 2025 13:56:44 +0100
Subject: [PATCH v2 1/6] dt-bindings: rockchip-thermal: Add RK3576
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-rk3576-tsadc-upstream-v2-1-6eb7b00de89c@collabora.com>
References: <20250225-rk3576-tsadc-upstream-v2-0-6eb7b00de89c@collabora.com>
In-Reply-To: <20250225-rk3576-tsadc-upstream-v2-0-6eb7b00de89c@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
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


