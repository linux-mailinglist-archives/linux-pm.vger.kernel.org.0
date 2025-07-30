Return-Path: <linux-pm+bounces-31628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C48B1639B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 17:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD301AA40BA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9F82DFA2E;
	Wed, 30 Jul 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bVk3+Irw"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E472DECBD;
	Wed, 30 Jul 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888957; cv=none; b=tyW8bjOj1oNs+G8ypaDkmge0mgr3zlvxKEKKoK9ZwnGigl70zemWaDRRyr/JwRYgIvMEEkI2XcQKEsgOGHJjiUUYvi3INVTVypTRVfvn+EgbFmsfD9SM9uTwAHrd5nOmbzdyYpW4epjhsYdwnqWCE5UGvL4jx8jE2ZH70HEAM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888957; c=relaxed/simple;
	bh=nP1axPdaA35vSvt1B38Z0AIa64RQJzj9NXJaUphLIvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmTA3pTvqXf4xgHGgVEck3YygNG+K+iu9od2yoagfqf+UlPxtmiOGjBHQQfvFiLhzhf3aR6VmPuwSN16YAYr9+TxHws/XJeFB2wJkHi9hxeHW6EBDydAX5aySYlxgPVA2ES44D/46wPEWEvo1SQ8n0RS6RHeQJTFdB9M6venATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bVk3+Irw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753888954;
	bh=nP1axPdaA35vSvt1B38Z0AIa64RQJzj9NXJaUphLIvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVk3+IrwCjpypp/ItF8K/65hnCBurtXPGXIEfNlEVRoGrzR/OOWNQWMbvw16W0VJF
	 H5B6zG0J6np7C4u8X/Rex2mOL3DpS04e9Rns79GsnH0nSCM8i4YtMXPavjl7tsoXA+
	 TdQ0/6odoHFsrBkCZWCiyT2gcduaZ2gT0AVK0W6p5ybgyReGtNBsAvf3r5DKEDbLTB
	 2sFfRgAjVqdK5No4Olk5+SAxUwUPNZNcaWHVFESeA5VZ6Cp5XUlC40oV3njVDhs0YD
	 qXWepfb/JH+607wZFvDNBi65Tim/oSLQUctp/O68KB3c5zqX1/qxBKmfsta2aP4JEB
	 Vm3VhscvFJyGw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:41d5:bfd6:7c6f:85ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EE5A417E130E;
	Wed, 30 Jul 2025 17:22:32 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: srini@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: wenst@chromium.org,
	nfraprado@collabora.com,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	u.kleine-koenig@baylibre.com,
	andrew-ct.chen@mediatek.com,
	lala.lin@mediatek.com,
	bchihi@baylibre.com,
	frank-w@public-files.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v2 5/9] thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant
Date: Wed, 30 Jul 2025 17:21:24 +0200
Message-Id: <20250730152128.311109-6-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730152128.311109-1-laura.nao@collabora.com>
References: <20250730152128.311109-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT8196/MT6991 require a different version of lvts_temp_to_raw(),
specifically the multiplicative inverse of the existing implementation.
Introduce a variant of the function with inverted calculation logic to
match this requirement.

This ensures accurate raw value generation for temperature
thresholds, avoiding spurious thermal interrupts or unintended hardware
resets on MT8196/MT6991.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 6e4a35ecaf34..750345465f00 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -300,6 +300,18 @@ static u32 lvts_temp_to_raw(int temperature, int temp_factor)
 	return div_s64(raw_temp, -temp_factor);
 }
 
+static u32 lvts_temp_to_raw_v2(int temperature, int temp_factor)
+{
+	u32 raw_temp;
+
+	if (temp_factor == 0)
+		return temperature;
+
+	raw_temp = temperature - golden_temp_offset;
+
+	return div_s64((s64)temp_factor << 14, raw_temp);
+}
+
 static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
-- 
2.39.5


