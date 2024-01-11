Return-Path: <linux-pm+bounces-2138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE95982B726
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 23:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE03B24F51
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F34FBEA;
	Thu, 11 Jan 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jygcr88l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="tP2ixP3Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE6FBEF
	for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C51321A2A2;
	Thu, 11 Jan 2024 17:30:38 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=jpH9+fshFrqu7tKnviUAmdQyT
	tSW1R4PhHjUM52TaCo=; b=jygcr88l0tKJXKhnHl5378EG7uZH+u4ZSHHy8PUN0
	wh2nvOS+v0dtvlRA71As9mGGHUcvjqwyjDK4I1vahtBewhtk6a9xwrcfzvROj1V2
	i2Bw549/yT1E2KFAUMwQ55IzUWLpYs1Ut+spbuvdCNILh/9c3zrZNhZeE3UgmeIV
	xk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BD85B1A2A1;
	Thu, 11 Jan 2024 17:30:38 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=/jeO0GQfGCSAB3tUT5+FJzUI5KuCKQDMsVEPJtMQ9nA=; b=tP2ixP3ZISqzC9QzVN2z4UEqG+CCEj5Q5GYOMn/2rzPe6HMV95dYiygJ7FQZxtOr95B8LMh82RNxoOUWYab5bDQEt/nN9ItdNaOgaXWNcoNiuHhKiAoXb6mk60QkULU+ybKexQ8pyHePum2qZ3FNehB1dvOqEHK9mkAUk7vldao=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 321EF1A2A0;
	Thu, 11 Jan 2024 17:30:34 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 63EFCAD5A6A;
	Thu, 11 Jan 2024 17:30:31 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH 8/9] thermal/drivers/mediatek/lvts_thermal: allow early empty sensor slots
Date: Thu, 11 Jan 2024 17:30:05 -0500
Message-ID: <20240111223020.3593558-9-nico@fluxnic.net>
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
 0916D142-B0D1-11EE-8DAF-A19503B9AAD1-78420484!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Some systems don't always populate sensor controller slots starting
at slot 0.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index b20b70fd36..473ef91ea3 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -112,6 +112,7 @@ struct lvts_ctrl_data {
 	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
 	int hw_tshut_temp;
 	int num_lvts_sensor;
+	int skipped_sensors;
 	int offset;
 	int mode;
 };
@@ -555,6 +556,7 @@ static int lvts_sensor_init(struct device *dev, struc=
t lvts_ctrl *lvts_ctrl,
 					const struct lvts_ctrl_data *lvts_ctrl_data)
 {
 	struct lvts_sensor *lvts_sensor =3D lvts_ctrl->sensors;
+
 	void __iomem *msr_regs[] =3D {
 		LVTS_MSR0(lvts_ctrl->base),
 		LVTS_MSR1(lvts_ctrl->base),
@@ -569,7 +571,7 @@ static int lvts_sensor_init(struct device *dev, struc=
t lvts_ctrl *lvts_ctrl,
 		LVTS_IMMD3(lvts_ctrl->base)
 	};
=20
-	int i;
+	int i, skip;
=20
 	for (i =3D 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
=20
@@ -604,8 +606,9 @@ static int lvts_sensor_init(struct device *dev, struc=
t lvts_ctrl *lvts_ctrl,
 		/*
 		 * Each sensor has its own register address to read from.
 		 */
+		skip =3D lvts_ctrl_data->skipped_sensors;
 		lvts_sensor[i].msr =3D lvts_ctrl_data->mode =3D=3D LVTS_MSR_IMMEDIATE_=
MODE ?
-			imm_regs[i] : msr_regs[i];
+			imm_regs[i + skip] : msr_regs[i + skip];
=20
 		lvts_sensor[i].low_thresh =3D INT_MIN;
 		lvts_sensor[i].high_thresh =3D INT_MIN;
--=20
2.42.0


