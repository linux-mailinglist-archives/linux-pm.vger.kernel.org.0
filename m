Return-Path: <linux-pm+bounces-2131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6815D82B71D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 23:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE40A2866E7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E25F4FC;
	Thu, 11 Jan 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TeUOVTnD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="lopxBRVm"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7DD63B2
	for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 532EF1D3A54;
	Thu, 11 Jan 2024 17:30:32 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Q05mMW2366FWiApOzRpQFoqUJ
	NQCfVqxCj8vPykZ5sY=; b=TeUOVTnDOqwze2/v9SVX+qaEtpSiOAvoREOc09UqD
	cD1HwCN+/MesJL+gXemcDsibc3LNAKDNCYBHkhXb4XMZPHZaDdQgrW/o4QQPGmEC
	jn5zlsXKrZKTaPLfvr6ivmu7NBAKei28dR3Pcbxd8FpiQA3NibE7fPH+fkOQdVOs
	FY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B7251D3A53;
	Thu, 11 Jan 2024 17:30:32 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=TrcXjOyZpxeObh+oRjkXmlWDsYnGZTnf2D4tx/OXzoY=; b=lopxBRVmK7ES6UgwdZc8KDb2Lxj+CGOEg2TDpL6lo7Jt88eQXuvl4mfj5BAcHMWNfZNhSF8ueUjQc185t/TN4HLAvLfYK/P8qyI1Zw1842dkpwlwuwQ6RsZ7UnpVVwy8KCFo8DQNXT1H57THgkQctngGqM9Z3ZvOn2m8FD2aDGg=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C114F1D3A50;
	Thu, 11 Jan 2024 17:30:31 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id B44B9AD5A64;
	Thu, 11 Jan 2024 17:30:30 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH 4/9] thermal/drivers/mediatek/lvts_thermal: guard against efuse data buffer overflow
Date: Thu, 11 Jan 2024 17:30:01 -0500
Message-ID: <20240111223020.3593558-5-nico@fluxnic.net>
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
 07A62E34-B0D1-11EE-AB9D-78DCEB2EC81B-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

We don't want to silently fetch garbage past the actual buffer.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index 2c346ea7c6..ed1888fb24 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -674,7 +674,8 @@ static int lvts_sensor_init(struct device *dev, struc=
t lvts_ctrl *lvts_ctrl,
  */
 static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *l=
vts_ctrl,
 					const struct lvts_ctrl_data *lvts_ctrl_data,
-					u8 *efuse_calibration)
+					u8 *efuse_calibration,
+					size_t calib_len)
 {
 	int i;
=20
@@ -682,6 +683,11 @@ static int lvts_calibration_init(struct device *dev,=
 struct lvts_ctrl *lvts_ctrl
 		const struct lvts_sensor_data *sensor =3D
 					&lvts_ctrl_data->lvts_sensor[i];
=20
+		if (sensor->cal_offsets[0] >=3D calib_len ||
+		    sensor->cal_offsets[1] >=3D calib_len ||
+		    sensor->cal_offsets[2] >=3D calib_len)
+			return -EINVAL;
+
 		lvts_ctrl->calibration[i] =3D
 			(efuse_calibration[sensor->cal_offsets[0]] << 0) +
 			(efuse_calibration[sensor->cal_offsets[1]] << 8) +
@@ -791,7 +797,8 @@ static int lvts_ctrl_init(struct device *dev, struct =
lvts_domain *lvts_td,
=20
 		ret =3D lvts_calibration_init(dev, &lvts_ctrl[i],
 					    &lvts_data->lvts_ctrl[i],
-					    lvts_td->calib);
+					    lvts_td->calib,
+					    lvts_td->calib_len);
 		if (ret)
 			return ret;
=20
--=20
2.42.0


