Return-Path: <linux-pm+bounces-28366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B9EAD364C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 14:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132653A59AD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1E92949E3;
	Tue, 10 Jun 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="cB0jGed+"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC522D9E0;
	Tue, 10 Jun 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558800; cv=pass; b=WL/5tY32qoo0VLpPAvBEz1OLInwtaHQ/0K6lL9TYjsWWAzAt/6FL6xftm1x4HTUjPQEJ9hHjU5CjHnC3AsaMeN2Axz2C/wMPokCUs+3yLWwXeqghu1x5JiSAOeJaK0P+WiovqW8QJGZHVQr1euhrtI71PpnPfLaMvGGuBvGJLMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558800; c=relaxed/simple;
	bh=eO2+e+Z6SVkDsCMkTxaUjbggom3QyHMw23h4D7QNraI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qkvyeb9w4FVpHuBLtxOQ96r+U+5oo9fFtA0QOd3FCL6SSuh/uTV+5IqBLk4nlHxVdMCE4lKwNEWohNWpnT1zTQ2R5VIUWRB7nAJqwY2HTOPhKwF2wGVatKluDmhXPqfnt5+rWpkV0IceGLOz+C42Z2o+g6Or1TetZzeyvqViWLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=cB0jGed+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749558771; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y/HWAl+BrVvwcj3QIGlOh+eH8RGYVyzKfX1d0+Tk1LKJ2zfwnXZKj+S6/GH2WWq4zNFFgBl/oPYGc4DzgsBqoKnNEES+pH+KoqXAgvJRv0YaCzEfZhoDQ8ANR1+ArGy2f3tPDbJ/R98v4f9xuEI8U2jBThJmCQ1iJkTA9FpEU5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749558771; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Tnp7bdW/um/Nf3Hkgt/EOyvTtoi0plo3EB+bh3F7o3o=; 
	b=NGD2fXCk7pG4diymGtx2OYJQzF5bZl7zpEPKSP8+25n8fncHp+g7UQTJf///oIAUDD7quPWqiCVEDg4qAJTco3BQwqv4PbZ92HS94d3fJI9d+cZGIVtiVZr9ViKI1N4YsmmQN1vGYpf4ue+hwpsSCYuuwNIYnIm8BvaTw78sPGs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749558771;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Tnp7bdW/um/Nf3Hkgt/EOyvTtoi0plo3EB+bh3F7o3o=;
	b=cB0jGed+HtxmlOcbiif09rpri7CVAT2t0+RhgfBMafdP8nxkDlGei+FEvTXK88iB
	xZ1iFy++EpOT6N+ZyiYTiHDW8LYzLxfv5pkClMP0jRo0DuWgv7muV/E3+rb2Zriw/zN
	bcgTF7p3bARCKb5czFkAnz+9k4e/laDT8542rA7k=
Received: by mx.zohomail.com with SMTPS id 1749558770257746.9148597054228;
	Tue, 10 Jun 2025 05:32:50 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 10 Jun 2025 14:32:37 +0200
Subject: [PATCH v6 1/7] thermal: rockchip: rename rk_tsadcv3_tshut_mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rk3576-tsadc-upstream-v6-1-b6e9efbf1015@collabora.com>
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


