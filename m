Return-Path: <linux-pm+bounces-5075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC11D87F202
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF531F21E32
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96865915B;
	Mon, 18 Mar 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OL4BpX+i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="XFTfbDTs"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E5A5821B;
	Mon, 18 Mar 2024 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797095; cv=none; b=aDewBJ8wRwsir8bjO333Kno6qbfQ0eUIKkJ9lcmEHyDo0BiA/3wnxMHeUDHvurq6pO2HMF2kef7A8GQSHbBhldKvu/rliSCfjfHNGLy9NhY8VIMpOys3mi/80L0n4NNocX3y+P2xtcZAVDvPWQ84rY+CfBXjzMVjMZ16f6Wd8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797095; c=relaxed/simple;
	bh=PF4F+WZxQguweGUDyJuo+DxyLq1Bma2dXu/r9mtnJzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiB3aYZDBkpN5fGWHTb3gGsPFntmJqP+HNcXrCjTUt9cEwoBs/XKsSs7EafnlTXSEwuSIo+PskXCOOXGzw7rQulh1/vq76pHzrpsm4SXoM4R4Nnn3JENFx7RetkjARb7N3A1pIJRE+QgC7BziNwW13+JVmXkXtMLvh2c/AEe4Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OL4BpX+i; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=XFTfbDTs reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DF5841EA51B;
	Mon, 18 Mar 2024 17:24:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=PF4F+WZxQguweGUDyJuo+DxyL
	q1Bma2dXu/r9mtnJzc=; b=OL4BpX+ipXpbuJzuMqmyK9CKWLbkvUMBKkKKEV4R7
	jD6kYE7jXH5D2wyvSIDTNgOobYjxnBvGnQUOIReOBZ2MBFgqd3fyJAPbclhq72Kp
	ZcmqYL5lAB3CLqiUZ6fiUJkKY9ipnYOHPnMpEbGBj0LT6NrrKHSjZy1RwmlLagtO
	bQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D78461EA51A;
	Mon, 18 Mar 2024 17:24:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=GqLLEauH127/GbjEIjqH3xblMmqoKZilokx5Leofrqo=; b=XFTfbDTsjue6uqlmAcdtJfKWefvoDI3Q0CxB8wUbA0K+20w6YtJM5H7XpyVdQET5kX1EhTdVpUabOdUj2uF/3oJv3g0x84vix1ps1MqpD2nyTLSm6t3L99pYUc271DONR/6AEZ7b+AEwUry/EYmafj5nqZRNBjvaXkjPU0Y0qsI=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 489361EA517;
	Mon, 18 Mar 2024 17:24:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 645F2BE2BA8;
	Mon, 18 Mar 2024 17:24:50 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 07/13] thermal/drivers/mediatek/lvts_thermal: add MT8186 support
Date: Mon, 18 Mar 2024 17:22:09 -0400
Message-ID: <20240318212428.3843952-8-nico@fluxnic.net>
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
 F5357760-E56D-11EE-B362-25B3960A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Various values extracted from the vendor's kernel driver.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 67 +++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index ed1888fb24..e923d22c17 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -80,6 +80,8 @@
 #define LVTS_SENSOR_MAX				4
 #define LVTS_GOLDEN_TEMP_MAX		62
 #define LVTS_GOLDEN_TEMP_DEFAULT	50
+#define LVTS_COEFF_A_MT8186			-204650
+#define LVTS_COEFF_B_MT8186			204650
 #define LVTS_COEFF_A_MT8195			-250460
 #define LVTS_COEFF_B_MT8195			250460
 #define LVTS_COEFF_A_MT7988			-204650
@@ -92,6 +94,7 @@
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
=20
 #define LVTS_HW_SHUTDOWN_MT7988		105000
+#define LVTS_HW_SHUTDOWN_MT8186		105000
 #define LVTS_HW_SHUTDOWN_MT8192		105000
 #define LVTS_HW_SHUTDOWN_MT8195		105000
=20
@@ -1377,6 +1380,62 @@ static int lvts_resume(struct device *dev)
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
+			{ .dt_id =3D MT8186_TS1_0,
+			  .cal_offsets =3D { 5, 6, 7 } },
+			{ .dt_id =3D MT8186_TS1_1,
+			  .cal_offsets =3D { 10, 11, 4 } },
+			{ .dt_id =3D MT8186_TS1_2,
+			  .cal_offsets =3D { 15, 8, 9 } },
+			{ .dt_id =3D MT8186_TS1_3,
+			  .cal_offsets =3D { 12, 13, 14 } }
+		},
+		.num_lvts_sensor =3D 4,
+		.offset =3D 0x0,
+		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8186,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8186_TS2_0,
+			  .cal_offsets =3D { 22, 23, 16 } },
+			{ .dt_id =3D MT8186_TS2_1,
+			  .cal_offsets =3D { 27, 20, 21 } }
+		},
+		.num_lvts_sensor =3D 2,
+		.offset =3D 0x100,
+		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8186,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8186_TS3_0,
+			  .cal_offsets =3D { 29, 30, 31 } },
+			{ .dt_id =3D MT8186_TS3_1,
+			  .cal_offsets =3D { 34, 35, 28 } },
+			{ .dt_id =3D MT8186_TS3_2,
+			  .cal_offsets =3D { 39, 32, 33 } }
+		},
+		.num_lvts_sensor =3D 3,
+		.offset =3D 0x200,
+		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8186,
+	}
+};
+
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] =3D {
 	{
 		.lvts_sensor =3D {
@@ -1565,6 +1624,13 @@ static const struct lvts_data mt7988_lvts_ap_data =
=3D {
 	.temp_offset	=3D LVTS_COEFF_B_MT7988,
 };
=20
+static const struct lvts_data mt8186_lvts_data =3D {
+	.lvts_ctrl	=3D mt8186_lvts_data_ctrl,
+	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8186_lvts_data_ctrl),
+	.temp_factor	=3D LVTS_COEFF_A_MT8186,
+	.temp_offset	=3D LVTS_COEFF_B_MT8186,
+};
+
 static const struct lvts_data mt8192_lvts_mcu_data =3D {
 	.lvts_ctrl	=3D mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
@@ -1591,6 +1657,7 @@ static const struct lvts_data mt8195_lvts_ap_data =3D=
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


