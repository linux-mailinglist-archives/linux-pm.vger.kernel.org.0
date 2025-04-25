Return-Path: <linux-pm+bounces-26242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F3A9D1D4
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4AE4E46E2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 19:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D9222068B;
	Fri, 25 Apr 2025 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="MwpFIZRj"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D921D3D9;
	Fri, 25 Apr 2025 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609739; cv=pass; b=S2Mr/HP/mqhYjsouRUs3GyVm+k84C3zrl2DgmbXDhmD3VSpWotBzoFvdPCVaP6ySXIInXk0yjrf/oMo9v9T4GNL8RGk63/QBRmJHGZCS7cfWoIw4+OSsrzLwWscoj6/D1WRfuQbhk55eFWSlvbSb/R/6zUeIltvWLzgIpC/jWkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609739; c=relaxed/simple;
	bh=eO2+e+Z6SVkDsCMkTxaUjbggom3QyHMw23h4D7QNraI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pr/4OHHwkYwsHPwxQw18MmMa3sbtQHhwhjE4ecdQkx6rmwjr2ahrnG7AQnTMhgpFhjbO6u/kB7VkCBbqNt4OSkl/npwpEcsqnBHn2HqulAqM2WH3ylsnQ+CGpaMmaEelJfKOwnlPaA+66/QeVRK/HEx6/BSe9KGNtDmMf2AW7Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=MwpFIZRj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745609710; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DXG0p0QU5t+Sh92jdVOwE1+qjuEE2kUcOSLlMgiftRHnIjhN3NUy++g2ACNOChcJlfHgMATrWsyYO7ofu2MHUy7D0jM1zYQ7wAfGUD/3wng9Mb1Nag3gfxmzED91tzi4Sh02Bmhbd+RS2VpAY9ElYd9XYzlJpNwLxsC6czyAo1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745609710; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Tnp7bdW/um/Nf3Hkgt/EOyvTtoi0plo3EB+bh3F7o3o=; 
	b=i73chpceXevFteW3DVM1HrLD+8lp0i6wBdYvR5hbKmu/Gi1Q8/Fqgo1gEOTTTzGNuyKa8cMASUF0U/YGGZzwi0cDU19MzGINteZRLXLOxhuFFyioWO7Dp9YVwJdv6sbbFO5VZ4jTX0mojN/82s4hUDoq42OWfkeIXhlIYzhFKdU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745609710;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Tnp7bdW/um/Nf3Hkgt/EOyvTtoi0plo3EB+bh3F7o3o=;
	b=MwpFIZRjh+a8kdDXWIu8Etf8SfQpotxeIg7gwxli6hxiismcDnA8vZoN4riBVHla
	jGF6v5tTH0HIfY1Wjoz9XBZfD6SaL/AoBO5/YETJyqnWGtuIVpvfXnC/M2TXiSyOLrQ
	IP5IXE//EFK6Fhkwfs3aUh9hFVXVxPT3rAqhjHSs=
Received: by mx.zohomail.com with SMTPS id 1745609708981535.9773786605982;
	Fri, 25 Apr 2025 12:35:08 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 25 Apr 2025 21:34:35 +0200
Subject: [PATCH v5 1/7] thermal: rockchip: rename rk_tsadcv3_tshut_mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-rk3576-tsadc-upstream-v5-1-0c840b99c30e@collabora.com>
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

The "v" version specifier here refers to the hardware IP revision.
Mainline deviated from downstream here by calling the v4 revision v3 as
it didn't support the v3 hardware revision at all.

This creates needless confusion, so rename it to rk_tsadcv4_tshut_mode
to be consistent with what the hardware wants to be called.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index a8ad85feb68fbb7ec8d79602b16c47838ecb3c00..40c7d234c3ef99f69dd8db4d8c47f9d493c0583d 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1045,7 +1045,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	writel_relaxed(val, regs + TSADCV2_INT_EN);
 }
 
-static void rk_tsadcv3_tshut_mode(int chn, void __iomem *regs,
+static void rk_tsadcv4_tshut_mode(int chn, void __iomem *regs,
 				  enum tshut_mode mode)
 {
 	u32 val_gpio, val_cru;
@@ -1297,7 +1297,7 @@ static const struct rockchip_tsadc_chip rk3588_tsadc_data = {
 	.get_temp = rk_tsadcv4_get_temp,
 	.set_alarm_temp = rk_tsadcv3_alarm_temp,
 	.set_tshut_temp = rk_tsadcv3_tshut_temp,
-	.set_tshut_mode = rk_tsadcv3_tshut_mode,
+	.set_tshut_mode = rk_tsadcv4_tshut_mode,
 	.table = {
 		.id = rk3588_code_table,
 		.length = ARRAY_SIZE(rk3588_code_table),

-- 
2.49.0


