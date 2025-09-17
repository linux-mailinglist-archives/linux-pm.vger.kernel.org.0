Return-Path: <linux-pm+bounces-34861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D4EB7D7FA
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C17E467895
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9E2328979;
	Wed, 17 Sep 2025 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="WyKfIQWi"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5070328973;
	Wed, 17 Sep 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111870; cv=pass; b=iu4y/4N2docUAPa9m/z9Ff1Ez1/U7aAOz25kX8ySZ2yXCpz8vXAsJoY5AjDY2AVJXAMS/HNfNYPVNDef8q4Nby30AVJRGPYkTCWWAilwSFdu/J4dseMpitn3UO4vD9y/3hNUm3AYgIjCAppOAmPQiCFZoVZEmZJ9aCN/NQOyNrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111870; c=relaxed/simple;
	bh=Fi7xK2B/PsMKycfhfCwLfDRRJtOjR83BXebcYHZO0ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5PiBHpC4Xgq/98rwsNTUn0QwhJvuIyq1Zxx6slbRLtXYLFI5FjZVLT03A2pQ6r4oCx6AyIYL3nmXR5Ir/IwXvNFph2ByGjqCjd1MvnvM7b8h3BrIGIvytt4pFLNFd1BUJRAtWytR9LC5rLTw3SGL++tjtLfAjKM4XjyOi3N1xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=WyKfIQWi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758111842; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q68E3Z19CmGATN2uXRmC/UWrwhm3IQhTTkcYcFlWhU3jeeY+MXiI1/D6MCOGNIQJOMe59TmfLyH5obGGMXtOOgRaeGz79SBAiHu5joWYvB1d4h/9Abr/HTrQA2Zv75/IfE/PN4BQgvUoZ7XAtk8s6NvpaN7FwBamnfoBYRCicXU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758111842; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=B3fU+OW1aHvFOhKqWGc4QBtk4YHBAS6m3X0BGR7nsbs=; 
	b=cBCmp/5y3FwpTboHp4WHkTa10Jlrh9Wr8xRPR9MYmdbyEND779kTlW8KIvam+x4hDnOIyieuzofaMydG/5lS2hItnKb0RmPfaU8Oq07qoAExgvy7BRexJSHHeiqsTq+P6qf5J8Bq6vwLd1EGRuwEJHU/zXs8Yj5bgbz8USdRmAc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758111842;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=B3fU+OW1aHvFOhKqWGc4QBtk4YHBAS6m3X0BGR7nsbs=;
	b=WyKfIQWiUq9iiu9lK+TVXojrP2088W+GOrFWjeKvC+UlQ5u5uvKUcXP5yHm5E1ph
	8WfokkFKjgTFX3MhBYYjhyr4ulg3UlJ8grlmcqB60X1lakXt+fsySKpHA5O1fgqrtv5
	gW5QUByC/uvyi0TvN7B17Nzh6YTLM1TMX5P3ST5A=
Received: by mx.zohomail.com with SMTPS id 1758111840208937.3337263629903;
	Wed, 17 Sep 2025 05:24:00 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 17 Sep 2025 14:22:40 +0200
Subject: [PATCH v3 09/10] drm/panthor: add no_clocks soc_data member for
 MT8196
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-mt8196-gpufreq-v3-9-c4ede4b4399e@collabora.com>
References: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
In-Reply-To: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

While panthor does not try to do anything untoward with the core clock
outside of increasing its enable/disable count, the spirit of using DT
to describe hardware, not what drivers need, informs us that on the
MT8196, panthor should work without one, as the true owner of the clocks
in this case is the performance-domain.

Add a boolean to the soc_data struct that tells panthor whether on any
given SoC, it can leave even the core clock NULL. Set it to true for the
MT8196 soc_data instance.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 3 +++
 drivers/gpu/drm/panthor/panthor_device.h | 3 +++
 drivers/gpu/drm/panthor/panthor_drv.c    | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index c7033d82cef55c940adc8434231cac6c5a20c288..581901a8e64fdb0946f20af593489fefde1cc05f 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -43,6 +43,9 @@ static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 
 static int panthor_clk_init(struct panthor_device *ptdev)
 {
+	if (ptdev->soc_data && ptdev->soc_data->no_clocks)
+		return 0;
+
 	ptdev->clks.core = devm_clk_get(ptdev->base.dev, NULL);
 	if (IS_ERR(ptdev->clks.core))
 		return dev_err_probe(ptdev->base.dev,
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index f32c1868bf6d782d99df9dbd0babcea049c917e0..cc8485afdaf865edc89a36823ba75c588a040e0b 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -40,6 +40,9 @@ struct panthor_soc_data {
 
 	/** @asn_hash: ASN_HASH values when asn_hash_enable is true. */
 	u32 asn_hash[3];
+
+	/** @no_clocks: True if clock control is external, not by panthor. */
+	bool no_clocks;
 };
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 4d59d94c353c3ca76f4b98a411c8f8284efafd08..3583ec955a85fe6e383839ec2bde017e1c6a995c 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1687,6 +1687,7 @@ ATTRIBUTE_GROUPS(panthor);
 static const struct panthor_soc_data soc_data_mediatek_mt8196 = {
 	.asn_hash_enable = true,
 	.asn_hash = { 0xb, 0xe, 0x0, },
+	.no_clocks = true,
 };
 
 static const struct of_device_id dt_match[] = {

-- 
2.51.0


