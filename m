Return-Path: <linux-pm+bounces-38357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CFDC78BB8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 12:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 681B82D9F6
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7D234A773;
	Fri, 21 Nov 2025 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nQP53C4a"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23064346FC3;
	Fri, 21 Nov 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723838; cv=none; b=Z6zM6EarDxXf1Nf4WFDyzkIzKCN//HuKTv5m7aDKKOqRJolziO2m93KSoNnZFAlrXTfud9+JyvzCavumKrBeunKxL1bczUwQrtP4X+JMt69I+tWucAlCMU7XbCK9VPWHLjoZHJbu3Yt5mACNnHFkwP+46OJ7IkecnGjmVATGiyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723838; c=relaxed/simple;
	bh=6YJLPO2KEF9QyWxLaPwxFzoKrk88Q8+O4pyGSdBlLAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnXOkABNvOPBcBVfnz8+L4HAP3hr+bhdygMCeEIso4dyjcasDzjbXX2eRsHv2M5ldYgdf5WNbCrnONDwTjf1vIQGNhFBQQmcYgVthY9PkziVrON8e+7t0XTcMz5qGUmoYo9TFlwT/XMhVxCv1TCc3TnknSP8W5WXPD7cksxYsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nQP53C4a; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763723829;
	bh=6YJLPO2KEF9QyWxLaPwxFzoKrk88Q8+O4pyGSdBlLAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQP53C4aNcllaqDO3XfJj8E58ySqopLc2lmPgBcGShIjCc21m1Fu12LRDzy3GH8NZ
	 josECmRaXYjnYbHyPkukHtE7o3SdB7s/UUyS6soW6NTz7HRtvZytCx6rYPF00x/xv/
	 Mc+4LPNYo0vD1tYYw5WEHAW3PBCbuxxm6Qk17LM3Rg3QhYeRG71XPC9VAVqlKMq7x6
	 fH1atf8vkkxJUsxPwVZHU/dkfiL8uFyqfjqZlHiy2ER0C02UqyH70gncO564dyG0AQ
	 57zA88Ui9vqusQDk1nyfQYb0JF9XfDbWnP3UeU9JSC6jQSyMNOT11s3QorH4hd4b0D
	 Ntnw6WWkKMgKg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:c4bf:9969:6e1c:dc69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B287E17E156E;
	Fri, 21 Nov 2025 12:17:08 +0100 (CET)
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
	wenst@chromium.org,
	fshao@chromium.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v4 5/9] thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant
Date: Fri, 21 Nov 2025 12:16:38 +0100
Message-Id: <20251121-mt8196-lvts-v4-v4-5-357f955a3176@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
References: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

MT8196/MT6991 require a different version of lvts_temp_to_raw(),
specifically the multiplicative inverse of the existing implementation.
Introduce a variant of the function with inverted calculation logic to
match this requirement.

This ensures accurate raw value generation for temperature
thresholds, avoiding spurious thermal interrupts or unintended hardware
resets on MT8196/MT6991.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index d713c46c21fc..3e05b29f7b05 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -307,6 +307,15 @@ static u32 lvts_temp_to_raw_mt7988(int temperature, int temp_factor)
 	return raw_temp;
 }
 
+static u32 lvts_temp_to_raw_mt8196(int temperature, int temp_factor)
+{
+	u32 raw_temp;
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

