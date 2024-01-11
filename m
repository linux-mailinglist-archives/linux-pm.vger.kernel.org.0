Return-Path: <linux-pm+bounces-2139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0FA82B725
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 23:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEED1F23563
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 22:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA3CFBF8;
	Thu, 11 Jan 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BAijCw4A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="frRuE+/+"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF9FBF5
	for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F377A1A2A4;
	Thu, 11 Jan 2024 17:30:38 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=YIO+NNGpbOcWCmjE53f1rHUW1
	8VTLldxliUTcDhP7ys=; b=BAijCw4ARCPYTHBREgi6BN7WV84/kDh2GZ60JDH/a
	sM2ZM0UOlgdSyakgV2OmzQenp7Rebb2bGsIyWFNGbuWBp77LHE36EddoFh0wxdfu
	AsHSTcVAwQrpUtWFIs0IsOK5gpx0A3F7oMME/ZRBz5cKLFiJaqilGV5zxuqkjgAW
	ss=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EC8361A2A3;
	Thu, 11 Jan 2024 17:30:38 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=cHmXOGat/9c1PBWLEMTltQj5jyyZw2+qHjopr8HFGro=; b=frRuE+/+j+DLFJbqmD5iWGrI7yn/1NiBMZtuQtIr9OP3eRJcq8k13RkhDhLeJKC7E+tRO9CnOXTC27aeoCzPI7+9rDOU7NRvL5kJ6ljbOYLgtad14JvxljJo4yIe92OGNGXNdi2Gn+Jz68l2U1wdJjB2C4V0CkcjA1kkvGSVahU=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3107B1A29F;
	Thu, 11 Jan 2024 17:30:34 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 402A1AD5A69;
	Thu, 11 Jan 2024 17:30:31 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH 7/9] thermal/drivers/mediatek/lvts_thermal: provision for gt variable location
Date: Thu, 11 Jan 2024 17:30:04 -0500
Message-ID: <20240111223020.3593558-8-nico@fluxnic.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240111223020.3593558-1-nico@fluxnic.net>
References: <20240111223020.3593558-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 09164394-B0D1-11EE-8F59-A19503B9AAD1-78420484!pb-smtp21.pobox.com
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
index e923d22c17..b20b70fd36 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -121,6 +121,7 @@ struct lvts_data {
 	int num_lvts_ctrl;
 	int temp_factor;
 	int temp_offset;
+	int gt_calib_bit_offset;
 };
=20
 struct lvts_sensor {
@@ -748,20 +749,21 @@ static int lvts_calibration_read(struct device *dev=
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
@@ -780,7 +782,7 @@ static int lvts_ctrl_init(struct device *dev, struct =
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
@@ -1622,6 +1624,7 @@ static const struct lvts_data mt7988_lvts_ap_data =3D=
 {
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt7988_lvts_ap_data_ctrl),
 	.temp_factor	=3D LVTS_COEFF_A_MT7988,
 	.temp_offset	=3D LVTS_COEFF_B_MT7988,
+	.gt_calib_bit_offset =3D 24,
 };
=20
 static const struct lvts_data mt8186_lvts_data =3D {
@@ -1629,16 +1632,19 @@ static const struct lvts_data mt8186_lvts_data =3D=
 {
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8186_lvts_data_ctrl),
 	.temp_factor	=3D LVTS_COEFF_A_MT8186,
 	.temp_offset	=3D LVTS_COEFF_B_MT8186,
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
@@ -1646,6 +1652,7 @@ static const struct lvts_data mt8195_lvts_mcu_data =
=3D {
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
 	.temp_factor	=3D LVTS_COEFF_A_MT8195,
 	.temp_offset	=3D LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset =3D 24,
 };
=20
 static const struct lvts_data mt8195_lvts_ap_data =3D {
@@ -1653,6 +1660,7 @@ static const struct lvts_data mt8195_lvts_ap_data =3D=
 {
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8195_lvts_ap_data_ctrl),
 	.temp_factor	=3D LVTS_COEFF_A_MT8195,
 	.temp_offset	=3D LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset =3D 24,
 };
=20
 static const struct of_device_id lvts_of_match[] =3D {
--=20
2.42.0


