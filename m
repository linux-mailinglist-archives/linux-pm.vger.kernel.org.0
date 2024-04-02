Return-Path: <linux-pm+bounces-5774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D848C8949F1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075691C2318F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4711757D;
	Tue,  2 Apr 2024 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cecnFhUm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="CaDW82L9"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C514F65;
	Tue,  2 Apr 2024 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028479; cv=none; b=Js/C1VgZPdqjfKWsF+b50jXpBNMTBkjc9j0AAFEpdlIELJbBesXZuJE8Il5peYfzFNHbrfEBB0NDmARh2NpALUcFJacR11Z+ors9f2jj415q2/ypU6WHUh9oP0a3tOPlPA4TpXGG82H6CiSeiC98Op1VqfkMJ2nWAN9fYIqDrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028479; c=relaxed/simple;
	bh=MnWIUGFLElfh/0DqfhLKQ+Wp0EphelpfePBgt6Txsn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4J4hcwNww2yWxEtxx/c6rQfGVcsAeHFKpjzRcubzOSND3djEMWN6AbMFUCWb6aK+BNZHQlBvjvCqs2zUicMSB8znfK0WqTSOuZSCncIB4kPY55G5ZyuY7QzB4P/igOC1YGSs7qX6SezRKr4nUfF2I0uuMJ0FD+/1e755ax+m/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cecnFhUm; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=CaDW82L9 reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 004D5219DB;
	Mon,  1 Apr 2024 23:27:51 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=MnWIUGFLElfh/0DqfhLKQ+Wp0
	EphelpfePBgt6Txsn8=; b=cecnFhUm0QPo7E0XmW/t7d5PmUzzwZ5CfIIWP2RDJ
	QR6NhUBc+OEQ6oZgQBOydMHM7kAfAY2RTIZ0hvvxQpCgkwzuTrimlFMLUXfrtkGx
	Jivgfzw0h1goY0UxxpPE/du6cXEzJcdYn28OadJ8sWPB57xxbQleNK0M0AxbqFgF
	JU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ECB79219DA;
	Mon,  1 Apr 2024 23:27:50 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=01KXgZ6JofXtMSi8J9s6tsWAfdo4ihPid/JlkpDWKr4=; b=CaDW82L9Oj3NJGK66/aCYf8plGOfzjLK4B8Cvx+lEcKjbeeqaR7LJ0FEm0iwsNZVzmgkw9z2uWi6ne879Gyb+GPexg717//clKO86HekNa5UICY0a205Hd8IGuHZ6cuRQlimXsunb/j3oDTXE8uVILn866tSVEIJMAj6CEOiVHA=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B4DEF219D2;
	Mon,  1 Apr 2024 23:27:46 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8D486C1CECA;
	Mon,  1 Apr 2024 23:27:44 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 03/15] thermal/drivers/mediatek/lvts_thermal: remove .hw_tshut_temp
Date: Mon,  1 Apr 2024 23:25:37 -0400
Message-ID: <20240402032729.2736685-4-nico@fluxnic.net>
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
 F9916F1A-F0A0-11EE-A3D6-A19503B9AAD1-78420484!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

All the .hw_tshut_temp instances are initialized with the same value.
Let's remove those and use a common definition instead. If ever a
different value must be used in the future then an override parameter
could be added back.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index 73ca2be0f5..00994a442b 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -91,9 +91,7 @@
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
=20
-#define LVTS_HW_SHUTDOWN_MT7988		105000
-#define LVTS_HW_SHUTDOWN_MT8192		105000
-#define LVTS_HW_SHUTDOWN_MT8195		105000
+#define LVTS_HW_TSHUT_TEMP		105000
=20
 #define LVTS_MINIMUM_THRESHOLD		20000
=20
@@ -107,7 +105,6 @@ struct lvts_sensor_data {
 struct lvts_ctrl_data {
 	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
 	int cal_offset[LVTS_SENSOR_MAX];
-	int hw_tshut_temp;
 	int num_lvts_sensor;
 	int offset;
 	int mode;
@@ -799,7 +796,7 @@ static int lvts_ctrl_init(struct device *dev, struct =
lvts_domain *lvts_td,
 		 * after initializing the calibration.
 		 */
 		lvts_ctrl[i].hw_tshut_raw_temp =3D
-			lvts_temp_to_raw(lvts_data->lvts_ctrl[i].hw_tshut_temp,
+			lvts_temp_to_raw(LVTS_HW_TSHUT_TEMP,
 					 lvts_data->temp_factor);
=20
 		lvts_ctrl[i].low_thresh =3D INT_MIN;
@@ -1309,7 +1306,6 @@ static const struct lvts_ctrl_data mt7988_lvts_ap_d=
ata_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 4,
 		.offset =3D 0x0,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT7988,
 	},
 	{
 		.cal_offset =3D { 0x14, 0x18, 0x1c, 0x20 },
@@ -1321,7 +1317,6 @@ static const struct lvts_ctrl_data mt7988_lvts_ap_d=
ata_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 4,
 		.offset =3D 0x100,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT7988,
 	}
 };
=20
@@ -1366,7 +1361,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x0,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
 		.mode =3D LVTS_MSR_FILTERED_MODE,
 	},
 	{
@@ -1377,7 +1371,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x100,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
 		.mode =3D LVTS_MSR_FILTERED_MODE,
 	},
 	{
@@ -1390,7 +1383,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 4,
 		.offset =3D 0x200,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
 		.mode =3D LVTS_MSR_FILTERED_MODE,
 	}
 };
@@ -1404,7 +1396,6 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_d=
ata_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x0,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
 		.cal_offset =3D { 0x2c, 0x30 },
@@ -1414,7 +1405,6 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_d=
ata_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x100,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
 		.cal_offset =3D { 0x34, 0x38 },
@@ -1424,7 +1414,6 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_d=
ata_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x200,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
 		.cal_offset =3D { 0x3c, 0x40, 0x44 },
@@ -1435,7 +1424,6 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_d=
ata_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 3,
 		.offset =3D 0x300,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
 	}
 };
=20
@@ -1448,7 +1436,6 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_=
data_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x0,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
 		.cal_offset =3D { 0x0d, 0x10 },
@@ -1458,7 +1445,6 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_=
data_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x100,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
 		.cal_offset =3D { 0x16, 0x19, 0x1c, 0x1f },
@@ -1470,7 +1456,6 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_=
data_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 4,
 		.offset =3D 0x200,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	}
 };
=20
@@ -1483,7 +1468,6 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_d=
ata_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x0,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
 		.cal_offset =3D { 0x2e, 0x31 },
@@ -1493,7 +1477,6 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_d=
ata_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x100,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
 		.cal_offset =3D { 0x37, 0x3a, 0x3d },
@@ -1504,7 +1487,6 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_d=
ata_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 3,
 		.offset =3D 0x200,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
 		.cal_offset =3D { 0x43, 0x46 },
@@ -1514,7 +1496,6 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_d=
ata_ctrl[] =3D {
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x300,
-		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	}
 };
=20
--=20
2.44.0


