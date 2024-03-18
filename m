Return-Path: <linux-pm+bounces-5084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ECD87F23F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B81AB217CB
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806E5A0F2;
	Mon, 18 Mar 2024 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R8Sbbb1u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="uxkAyT4+"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D15915F;
	Mon, 18 Mar 2024 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797684; cv=none; b=rhUQLSd8ze0td3QXBqK5h4W7PqAA8ol2/qm952OSn49GmLVbKjbh8NW8H727+mH/ONr20ThFEyhH7JMxGiR1bCTFhsYYI19qvaLBzMKaqFPhegK8NU+1sT6WuarFnSSKLjAzifHBs9V07b7E/JvVEssMMycVUigl4ocLloUGL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797684; c=relaxed/simple;
	bh=iVetd4QaTeVWhbEmsz6QH6YEPeBoCj4jLAv4YKz7Ku8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcY5EzyM5NcsGJizYtRvJZZp1+HQXro0YQ/CgwsJwxKoh+VGPD4vCOPiMhuK9is9BV+wt0C5geUPJXPIxbNx0YRk14b5FM0fnibLGfEtC59M2cEtzNCuKhaPQKjoeOwIB33hS5e++mfwFqey+e+inwoDgppdVbFGPS3RYcSt/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R8Sbbb1u; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=uxkAyT4+ reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A3D7235EB;
	Mon, 18 Mar 2024 17:34:42 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=iVetd4QaTeVWhbEmsz6QH6YEP
	eBoCj4jLAv4YKz7Ku8=; b=R8Sbbb1uCgsS1QIT2MNtRh4lZt/1BqCJLQgZUAHC6
	dSHGa1ceOBnM96fGO1uJUIO5x3plwRfhOG07tUiQnJbghzzlAr699mJLo0cFulde
	mp8vkQSTR4cFQxrGbq9LCqzyru1wYXiY8HhCx1FSolHZ7OLuCSUOeZ1BT5TQYLYA
	VA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 63F7B235EA;
	Mon, 18 Mar 2024 17:34:42 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=xh2OqoLqWizvws0Zy/kRLwBr0T0rbZQUXIZw6AuyNVk=; b=uxkAyT4+2+0lG3fjpsIpc96ENHkdi1PhCTsV9nNmKU/smZQ21ZWSesd9zbd5HCSM99avq9dMKL/P7Qu1jEjUmtmeeFSjBdR903UPCXQDM4kvN0+bNsjHSmqbdMZvMGr2obR/ojGqNHF8rnNP5twxUQU0wcsPqfXsvc5Cb6DNzwc=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 74E27235E9;
	Mon, 18 Mar 2024 17:34:38 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 9B7A5BE2BAA;
	Mon, 18 Mar 2024 17:24:50 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 09/13] thermal/drivers/mediatek/lvts_thermal: provision for gt variable location
Date: Mon, 18 Mar 2024 17:22:11 -0400
Message-ID: <20240318212428.3843952-10-nico@fluxnic.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318212428.3843952-1-nico@fluxnic.net>
References: <20240318212428.3843952-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 52980192-E56F-11EE-AB46-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
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
2.44.0


