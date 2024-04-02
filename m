Return-Path: <linux-pm+bounces-5780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4966894A12
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0820FB2459A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA417BAA;
	Tue,  2 Apr 2024 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R7P1YvFj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="cObrKU8a"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8AC15E86;
	Tue,  2 Apr 2024 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028869; cv=none; b=FyVWtz8RPubL/+UdJPC2rFXR5RZIlHXamRVQSd9Qm/zxJS4dBkzggYhjg+QDubrD+KSWjvXPLbXwTM9HEOLfAzfpQydbP+02S7HHTz69YRrW8nwiAoAyfCHvyuAukaLT5B6KcKl0NO87YOgRlT9M5nv6AfxabLfalUutBmbmM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028869; c=relaxed/simple;
	bh=IqJiLrulYlpNtCg8mChAf2NBOYoJ0RGtcmUyL8xOrHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go/7NKoFGPLdRlsGB+B/vjJjsaJ864mIyrJYNZRryKgA+huakMxetIbNjt6Q46sAgtfCBaFvpa4I75E9D4py6NoBry7ppGIjpDHRYPjvice7loJTFDOqg7xb7SJ9ONZBPK8AwwO9mqcpHdiEtItBdOZemvRdwXUHVks8Z3G0bUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R7P1YvFj; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=cObrKU8a reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 77BB321C15;
	Mon,  1 Apr 2024 23:34:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=IqJiLrulYlpNtCg8mChAf2NBO
	YoJ0RGtcmUyL8xOrHQ=; b=R7P1YvFjFx3660XkbQ/L7d2xjyIML0k1CmumDrYqk
	clktTH2Dp4mUk4a1DaVLNMzbjdCEa1BGgQO4C8YMRAVPDHCDtz9JuQfvPwBo/mJa
	2F3NVEeZJbEZHj+3W6cf7AA8D9rHe6SJNAsrjN4k/MOgGzeDYw9MX+K22lU6YV5N
	vc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 70F8421C14;
	Mon,  1 Apr 2024 23:34:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=Zm343rmGZF/3SJuRC/MyQdESFF3eyLbHCgLzOuQXjJg=; b=cObrKU8aVRwKhInivyVQYp3Wvzial3limUTYXD+Xa31JXwyTLcXV2FOk9LvHH6Rt3STPXn9a1/70itYIUymdtcgajrP3y5x0N19Ici/HnTG9Au7yrcOYDWWGcfc14Z7Ch5+L+lwLt2fFzXwd6Ld5wXNHOYRBPTuijtmz9crPAOM=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7230221C12;
	Mon,  1 Apr 2024 23:34:23 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 2F711C1CED1;
	Mon,  1 Apr 2024 23:27:45 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 08/15] thermal/drivers/mediatek/lvts_thermal: add MT8186 support
Date: Mon,  1 Apr 2024 23:25:42 -0400
Message-ID: <20240402032729.2736685-9-nico@fluxnic.net>
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
 E6096D98-F0A1-11EE-95BD-A19503B9AAD1-78420484!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Various values extracted from the vendor's kernel driver.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index 03ef5b627c..506d52d6ef 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1373,6 +1373,59 @@ static int lvts_resume(struct device *dev)
 	return 0;
 }
=20
+/*
+ * The MT8186 calibration data is stored as packed 3-byte little-endian
+ * values using a weird layout that makes sense only when viewed as a 32=
-bit
+ * hexadecimal word dump. Let's suppose SxBy where x =3D sensor number a=
nd
+ * y =3D byte number where the LSB is y=3D0. We then have:
+ *
+ *   [S0B2-S0B1-S0B0-S1B2] [S1B1-S1B0-S2B2-S2B1] [S2B0-S3B2-S3B1-S3B0]
+ *
+ * However, when considering a byte stream, those appear as follows:
+ *
+ *   [S1B2] [S0B0[ [S0B1] [S0B2] [S2B1] [S2B2] [S1B0] [S1B1] [S3B0] [S3B=
1] [S3B2] [S2B0]
+ *
+ * Hence the rather confusing offsets provided below.
+ */
+static const struct lvts_ctrl_data mt8186_lvts_data_ctrl[] =3D {
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8186_LITTLE_CPU0,
+			  .cal_offsets =3D { 5, 6, 7 } },
+			{ .dt_id =3D MT8186_LITTLE_CPU1,
+			  .cal_offsets =3D { 10, 11, 4 } },
+			{ .dt_id =3D MT8186_LITTLE_CPU2,
+			  .cal_offsets =3D { 15, 8, 9 } },
+			{ .dt_id =3D MT8186_CAM,
+			  .cal_offsets =3D { 12, 13, 14 } }
+		},
+		.num_lvts_sensor =3D 4,
+		.offset =3D 0x0,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8186_BIG_CPU0,
+			  .cal_offsets =3D { 22, 23, 16 } },
+			{ .dt_id =3D MT8186_BIG_CPU1,
+			  .cal_offsets =3D { 27, 20, 21 } }
+		},
+		.num_lvts_sensor =3D 2,
+		.offset =3D 0x100,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8186_NNA,
+			  .cal_offsets =3D { 29, 30, 31 } },
+			{ .dt_id =3D MT8186_ADSP,
+			  .cal_offsets =3D { 34, 35, 28 } },
+			{ .dt_id =3D MT8186_MFG,
+			  .cal_offsets =3D { 39, 32, 33 } }
+		},
+		.num_lvts_sensor =3D 3,
+		.offset =3D 0x200,
+	}
+};
+
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] =3D {
 	{
 		.lvts_sensor =3D {
@@ -1547,6 +1600,13 @@ static const struct lvts_data mt7988_lvts_ap_data =
=3D {
 	.temp_offset	=3D LVTS_COEFF_B_MT7988,
 };
=20
+static const struct lvts_data mt8186_lvts_data =3D {
+	.lvts_ctrl	=3D mt8186_lvts_data_ctrl,
+	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8186_lvts_data_ctrl),
+	.temp_factor	=3D LVTS_COEFF_A_MT7988,
+	.temp_offset	=3D LVTS_COEFF_B_MT7988,
+};
+
 static const struct lvts_data mt8192_lvts_mcu_data =3D {
 	.lvts_ctrl	=3D mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
@@ -1573,6 +1633,7 @@ static const struct lvts_data mt8195_lvts_ap_data =3D=
 {
=20
 static const struct of_device_id lvts_of_match[] =3D {
 	{ .compatible =3D "mediatek,mt7988-lvts-ap", .data =3D &mt7988_lvts_ap_=
data },
+	{ .compatible =3D "mediatek,mt8186-lvts", .data =3D &mt8186_lvts_data }=
,
 	{ .compatible =3D "mediatek,mt8192-lvts-mcu", .data =3D &mt8192_lvts_mc=
u_data },
 	{ .compatible =3D "mediatek,mt8192-lvts-ap", .data =3D &mt8192_lvts_ap_=
data },
 	{ .compatible =3D "mediatek,mt8195-lvts-mcu", .data =3D &mt8195_lvts_mc=
u_data },
--=20
2.44.0


