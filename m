Return-Path: <linux-pm+bounces-26241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6B6A9D1D6
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05231C0208A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 19:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20E321D5B2;
	Fri, 25 Apr 2025 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="kdn0Si4L"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5C21C17D;
	Fri, 25 Apr 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609738; cv=pass; b=OYM3y4atDub5AJAuU6wFrYk5Izmdzzxx+dznb/O7ydeSMmAMSsakvELaQycI7d+JKPbqLOXQG/zEUT+ZdL5eEACiB3Ub0ihaU26vdzAYGD6gIQyJcuT0vvjjpYCFtIrxPRgA/5Z7F0JrlYM2Djryhqvmru9coH23SoOVloF+R8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609738; c=relaxed/simple;
	bh=XQ0dSp3Flpla5xIAgUPRx6pHdPhqCsf7vpoehMz7BJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nyv6r7pIGED77afe6JjQkZYnkgCGcL0SsNhtdY1CQ8uEcQyWywrVKE5AAiLdVBTP5Pa+hb/2QodD9VDF7uNjhs7JPMMZNYgCE9L2SNm8F9hpgwESmslUCddT3P5gIq93MPXna/rTMiWQea8YCO8qTNbA0MHvzyZjnFQZJJvFx+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=kdn0Si4L; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745609714; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Dd5PbieyEc/C+5e1O1b11wZALoNtvt6yM+/kg08ARgdyUhpmzP/NhBN1CKmNf8AaLntYnmgLTChakcyeMaVN8WRfyUWDNENQtDeLYqmzk6Zt6l9IIWJfSo+R5j+9jpJIBlDKuLSmAebBDQFqHka3O0+y5zoIZpfa8yC0JqaZquE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745609714; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r/yCBdXULN/7dimob9RM70hBvraS8nfz9TzFTVD+37g=; 
	b=Y0+ebmMQPjK2p3ZeqgQ4Rhj+IigsGl4R1yNgcS6Rl/gnxuF/9Nke5pfIc10hpopuCJluT+mBr9L0bkiSwsubz9hYoapoYsJlDL0fOWacUhjdiHkbrh1ojoBnWkkGHwGQIiYgwyl9BKHw8hkwMH4JNAcbTnGlLBJ9h6KmPJUz1Xc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745609714;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=r/yCBdXULN/7dimob9RM70hBvraS8nfz9TzFTVD+37g=;
	b=kdn0Si4LxDoOzrxLzkKFSkVrcD993k4FD4Kje2SS/5wabMI22WWPRplacrKMDifc
	vjDz/S11+9xs1hOmz6+e1BDNeE4xQUwvGkBo4/kSlMNrOFRtLw0AMZCjo4DuUpQZKFs
	cSgHEv5ws01yAWARhnoNeTQGpZHhJlIpy4HBoKw4=
Received: by mx.zohomail.com with SMTPS id 1745609712399137.5838901988809;
	Fri, 25 Apr 2025 12:35:12 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 25 Apr 2025 21:34:36 +0200
Subject: [PATCH v5 2/7] dt-bindings: rockchip-thermal: Add RK3576
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-rk3576-tsadc-upstream-v5-2-0c840b99c30e@collabora.com>
References: <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com>
In-Reply-To: <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com>
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
2.49.0


