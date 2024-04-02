Return-Path: <linux-pm+bounces-5781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C61894A11
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2871F21FBB
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC817BB7;
	Tue,  2 Apr 2024 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CUfEyYnB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="p6HDfxCW"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228217721;
	Tue,  2 Apr 2024 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028869; cv=none; b=D6UkUJgQbPkXDufJ0O9fIv4XxeuGDyDrSWfZRadXNeGOS35HxvsCGCJVBXNHlShNPskg4EiHUqwyWz9bYZNEemUBjmIgbhsIsg2PoVAj4K+eijAKCm1PeiD32PZEtP/yXiPvYHM9mbjow+uN9YJqlfthgc7VLAL9H2mPXxzaTBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028869; c=relaxed/simple;
	bh=TMvJLmaQdAXchP52T16QOZkVe093s0cyskBiSWdZPys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGpmsg12XYl54p3GZMIM9wW+rDs8p+dzOSX7rcHMEq9M7GbqjKl2GnFjOHZ6y/yNoGtekTIrBU3gzlGfU4U9zAjRrCCeJ7BTVF48gtISsRW71TRiwzPqQinYFBEg/KlGv5ti9/BMVrkDK1JMe162JMtfhbl2EtazceT+GDjny/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CUfEyYnB; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=p6HDfxCW reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EE5321C17;
	Mon,  1 Apr 2024 23:34:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=TMvJLmaQdAXchP52T16QOZkVe
	093s0cyskBiSWdZPys=; b=CUfEyYnBIR1xD0+AKi7wF3HzOfzGWgDvu5smKJAW0
	YzvEgej4zHT/RDVeQCAtGgI97V3kO9AT+kYdksuOS97psBeAvFWBQLxWP3fg/rwi
	EI7ijPfpkILZWaZ0KkP0BID4lT9JwKcdr8LUNTtJWFV4UNWwSGF9emUPt8n/RCW/
	ZE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 985A721C16;
	Mon,  1 Apr 2024 23:34:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=Uw4s4xwpnw8fBDGMxKEdVacnfouyDQvb2i7AHCBaQls=; b=p6HDfxCWK+RJYFvlTg+yTa6K/e6EEGCK29aDEK7RGPIRXwx9VFotIdA+eULcKpQDps9vYrHgJuYaDIfVGzd1RJcelZPUFjC+GIUZgUFJ5ub5UdjUfhcfCq7+kwn6o+hLbrcoHu13YLTP4vYL1T+rAxKqgizQlI1ylYvhOp4AmMc=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D73F21C13;
	Mon,  1 Apr 2024 23:34:23 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 57D92C1CED3;
	Mon,  1 Apr 2024 23:27:45 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 10/15] thermal/drivers/mediatek/lvts_thermal: provision for gt variable location
Date: Mon,  1 Apr 2024 23:25:44 -0400
Message-ID: <20240402032729.2736685-11-nico@fluxnic.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402032729.2736685-1-nico@fluxnic.net>
References: <20240402032729.2736685-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 E61A8452-F0A1-11EE-887D-A19503B9AAD1-78420484!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

The golden temperature calibration value in nvram is not always the
3rd byte. A future commit will prove this assumption wrong.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index 506d52d6ef..00649483bb 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -116,6 +116,7 @@ struct lvts_data {
 	int num_lvts_ctrl;
 	int temp_factor;
 	int temp_offset;
+	int gt_calib_bit_offset;
 };
=20
 struct lvts_sensor {
@@ -743,20 +744,21 @@ static int lvts_calibration_read(struct device *dev=
, struct lvts_domain *lvts_td
 	return 0;
 }
=20
-static int lvts_golden_temp_init(struct device *dev, u8 *calib, int temp=
_offset)
+static int lvts_golden_temp_init(struct device *dev, u8 *calib,
+				 const struct lvts_data *lvts_data)
 {
 	u32 gt;
=20
 	/*
-	 * The golden temp information is contained in the 4th byte (index =3D =
3)
-	 * of efuse data.
+	 * The golden temp information is contained in the first 32-bit
+	 * word  of efuse data at a specific bit offset.
 	 */
-	gt =3D calib[3];
+	gt =3D (((u32 *)calib)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
=20
 	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
 		golden_temp =3D gt;
=20
-	golden_temp_offset =3D golden_temp * 500 + temp_offset;
+	golden_temp_offset =3D golden_temp * 500 + lvts_data->temp_offset;
=20
 	return 0;
 }
@@ -775,7 +777,7 @@ static int lvts_ctrl_init(struct device *dev, struct =
lvts_domain *lvts_td,
 	if (ret)
 		return ret;
=20
-	ret =3D lvts_golden_temp_init(dev, lvts_td->calib, lvts_data->temp_offs=
et);
+	ret =3D lvts_golden_temp_init(dev, lvts_td->calib, lvts_data);
 	if (ret)
 		return ret;
=20
@@ -1598,6 +1600,7 @@ static const struct lvts_data mt7988_lvts_ap_data =3D=
 {
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt7988_lvts_ap_data_ctrl),
 	.temp_factor	=3D LVTS_COEFF_A_MT7988,
 	.temp_offset	=3D LVTS_COEFF_B_MT7988,
+	.gt_calib_bit_offset =3D 24,
 };
=20
 static const struct lvts_data mt8186_lvts_data =3D {
@@ -1605,16 +1608,19 @@ static const struct lvts_data mt8186_lvts_data =3D=
 {
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8186_lvts_data_ctrl),
 	.temp_factor	=3D LVTS_COEFF_A_MT7988,
 	.temp_offset	=3D LVTS_COEFF_B_MT7988,
+	.gt_calib_bit_offset =3D 24,
 };
=20
 static const struct lvts_data mt8192_lvts_mcu_data =3D {
 	.lvts_ctrl	=3D mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+	.gt_calib_bit_offset =3D 24,
 };
=20
 static const struct lvts_data mt8192_lvts_ap_data =3D {
 	.lvts_ctrl	=3D mt8192_lvts_ap_data_ctrl,
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+	.gt_calib_bit_offset =3D 24,
 };
=20
 static const struct lvts_data mt8195_lvts_mcu_data =3D {
@@ -1622,6 +1628,7 @@ static const struct lvts_data mt8195_lvts_mcu_data =
=3D {
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
 	.temp_factor	=3D LVTS_COEFF_A_MT8195,
 	.temp_offset	=3D LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset =3D 24,
 };
=20
 static const struct lvts_data mt8195_lvts_ap_data =3D {
@@ -1629,6 +1636,7 @@ static const struct lvts_data mt8195_lvts_ap_data =3D=
 {
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8195_lvts_ap_data_ctrl),
 	.temp_factor	=3D LVTS_COEFF_A_MT8195,
 	.temp_offset	=3D LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset =3D 24,
 };
=20
 static const struct of_device_id lvts_of_match[] =3D {
--=20
2.44.0


