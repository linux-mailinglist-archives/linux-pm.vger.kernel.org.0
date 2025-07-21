Return-Path: <linux-pm+bounces-31178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C47EB0BE8B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B277A9F7C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56879289364;
	Mon, 21 Jul 2025 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b58vOpxC"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F230288C0C;
	Mon, 21 Jul 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085786; cv=none; b=JvUaNrJEI4zlkJGKNMdJfzFzDD30cTaJI13XVrtrr6f5aLlUAbGH490wbYOSVrdriRFTV8mjXDtC9C2PqMrxnPVe7QHZh9nFSNs4mtQFSSXuZn2QrUS3FpRiwXLqn++yOybZMh3Cm4bnJgmI+huTCHa1taFO0soW9w2rWUBCfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085786; c=relaxed/simple;
	bh=q8mKnBTCCePugtAir380orNmiIcDnGjP5CYqxoIUl+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IKVwIz3VYEBlvnP7hf4WmTh3gdwXAWjeeWPkFiNk736w0VdH/OQx/euneJrEFeMAvjuopvBICuuL7si2RBc0/g3In0c/34t8tLlb4A+734HrK8vRvTcq3lVKkm5EfejqfboauKIdJn419yXZWjbqze5zZrCayGSRQN2PauZgzIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=b58vOpxC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753085782;
	bh=q8mKnBTCCePugtAir380orNmiIcDnGjP5CYqxoIUl+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b58vOpxCJr8+i+lge8xanHGfFxvfWn4CgwCTNPoFz2ZquIosJugqnFZkjK5dbn9ey
	 EomNAso/pDJFEd01yZd9i4RBGlnidvRcCevfhR1kPd3l8au6MxZz5cT25BKSg3sVza
	 jergPtzp+gr4p3QLHKi2AyC80UlSUfBHpt2EidnNRnLGAMyH9CcGZNzlGgRvmumRSx
	 nM44hh1FyeB1vqAQiueF88rep6ph1GO2fYqm1MvJbhNIjOy6WH0c6hSyz8lkCxd/os
	 HlbyaO5cqpBYl6Lip7VH2eAuhKENOQ3q3IHnelsm7tPUpCwkBCHB5Tmte174L94Qqk
	 993Tl4krQ7hnw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4487:69c6:40a:81be])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 827AE17E0F66;
	Mon, 21 Jul 2025 10:16:21 +0200 (CEST)
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
Cc: nfraprado@collabora.com,
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
Subject: [PATCH 5/9] thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant for positive temp_factor
Date: Mon, 21 Jul 2025 10:14:55 +0200
Message-Id: <20250721081459.16278-6-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721081459.16278-1-laura.nao@collabora.com>
References: <20250721081459.16278-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current lvts_temp_to_raw() implementation assumes a negative
temperature-to-raw slope (temp_factor), which holds for the SoCs
currently supported by the driver. However, this assumption breaks on
MT8196/MT6991, where the slope is positive.

Add a variant of the function that inverts the calculation logic
accordingly. This ensures accurate raw value generation for temperature
thresholds,avoiding spurious thermal interrupts or unintended hardware
resets on MT8196/MT6991.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index db83137c7537..3c34956e37c1 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -296,6 +296,18 @@ static u32 lvts_temp_to_raw(int temperature, int temp_factor)
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


