Return-Path: <linux-pm+bounces-5080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1017C87F20D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEED628271E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9295A0E7;
	Mon, 18 Mar 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dgPA6KcQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="gkonbgLe"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E805917C;
	Mon, 18 Mar 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797098; cv=none; b=QdTpA76Ak0Yl3aGEBN0NeGkJBfJRK2L4x+3YZAGoEfEy94jKI9zUCRQWURL9mEICPTejVfHXdDkqtmCywt4Z4ECwb5S9d0QkbKdW2BQWq8qolA1zEdVuVTs0+bgKW6OYh60hF92Kj4UUuYGlijwf3kfP3cM9Acw2dAkYwQRLOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797098; c=relaxed/simple;
	bh=Bjv2P+61XQPEqT6lVf4eRxVx79OzsAj5yTNR+sS4hrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6aek4+USuYDnDEfYnM5s00NjAfsK0WfIn7RpZpjTHxoLEdJ7amqnmT6WRuICbkOz3XoCAYG5/GVVDro7E/q0t/Nc6CeF8q14BU2qMvSBdv7mSqRcJhX/ulwjAmPYuxLCbqlaN8dI/ovFhg++am5zpNXbG5ZiJ/Wsxz0hL3RYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dgPA6KcQ; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=gkonbgLe reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 61DB8234E0;
	Mon, 18 Mar 2024 17:24:56 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Bjv2P+61XQPEqT6lVf4eRxVx7
	9OzsAj5yTNR+sS4hrg=; b=dgPA6KcQXoR+ae7VlKlSIHTpdy93mXhXFgFm6CNCj
	DXxAcOwCZUOVnb/N+2OM2DXEfnKvg2t06s3aCCk3778lFRze4FcNZQvn6fuvywil
	IgaE3LxN/BIG9I/i4WkNF6zEcVmEdP+tMVgPy7MzCM+QF3bXpiuMst71tMCUpUuM
	kI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5AFE3234DF;
	Mon, 18 Mar 2024 17:24:56 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=/RrO7s7tsRXTPBWfOSB1biNj4HF7T7Aw2q9sB1QcWE4=; b=gkonbgLeLhi0NeChhoSdIEm2clxyW8Pb17td+M/wZDp2T5W/K6pqXo7esx4AQpfjYURHr01kNzLBjM7/WRoK9kxCIj5uGvqBdU/zQXdduf2cVU76VhBKSeWjcAEuAFaLO+rasezwaEMgimRWLRDu/njGRuZLAImx67H27fpCBXM=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 52E21234DA;
	Mon, 18 Mar 2024 17:24:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 24601BE2BA4;
	Mon, 18 Mar 2024 17:24:50 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 04/13] thermal/drivers/mediatek/lvts_thermal: guard against efuse data buffer overflow
Date: Mon, 18 Mar 2024 17:22:06 -0400
Message-ID: <20240318212428.3843952-5-nico@fluxnic.net>
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
 F53B131E-E56D-11EE-B64A-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
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
2.44.0


