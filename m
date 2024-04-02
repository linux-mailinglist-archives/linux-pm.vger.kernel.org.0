Return-Path: <linux-pm+bounces-5776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC88949F6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B501B2084F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E6171B6;
	Tue,  2 Apr 2024 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y8AWlnih";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="io8qi8Fu"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7A1758D;
	Tue,  2 Apr 2024 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028482; cv=none; b=lAooITxsQ72JFBgc7fkqjv8WOzgL8SbcDsV08XhQXBuEmKR2usXM4yKLOTF64iQnMtEpb8xdjeJO+zWNhyN1/rDW7gtoXeKxL+fPxo+jZUNT0B9ZEBtWVqh1CwC52W6By7dGa5m7CQFMk+0SM3R+yNNo9k3A8zFG6EyyIU1v6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028482; c=relaxed/simple;
	bh=LDX0rqkLLVP9V/sDmVl/fCI94iqNeaqPZhDHNWQCN4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukhAFTI3OBsAgREYnxQ44sAL8RW5Xm5jFducaPVEzQJ6ZrovQmPdkNhTeY7KDf41wHQeuZ47Wv9wA3+lRFANhlhMGbXBmKr8w3dFtsp/POv+4Ey+LxwXTHZVKSHOubb1Cenv8+cKIjzQeO7I3cJGxZWq2Tl4gn/ZDHUWyNS2gic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y8AWlnih; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=io8qi8Fu reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 31573219E4;
	Mon,  1 Apr 2024 23:27:55 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=LDX0rqkLLVP9V/sDmVl/fCI94
	iqNeaqPZhDHNWQCN4c=; b=Y8AWlnihw4ASRCyKuVRdAv9kZSFLJ65ROF+WQN9TT
	Pz/g79CavpAU8qYou9+avXAGCkC1L6U4VD/YEz1ac+KKfDURoQfZfPySQvnLOhxj
	3X7W9vq1O0UkDXaYk1BnbEuuECZMBmClTPJPDoQ7WHB0B3A06ts2ggp5APt/9xBp
	3Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 28166219E3;
	Mon,  1 Apr 2024 23:27:55 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=zKfWCe1Z/qKYc7AfNNNNh/gcTI3D9+3V/4Lyp8NTrys=; b=io8qi8FulZV8R04HVJYyHHKYNJcknNakWF3hYphyQpRLIHjsJIqyJe6lLrq6bPwx96y2NWbX/NczVQJ0PSQW9PlUFcg/ixFDilody4lpUydyaoCJc9VtakjOtYrSbfULP82wdSNa/6C2DuybI8y5I4DvEmQ42d6+kx7iI6EAqwA=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F34F6219D5;
	Mon,  1 Apr 2024 23:27:47 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id CF354C1CECD;
	Mon,  1 Apr 2024 23:27:44 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 05/15] thermal/drivers/mediatek/lvts_thermal: guard against efuse data buffer overflow
Date: Mon,  1 Apr 2024 23:25:39 -0400
Message-ID: <20240402032729.2736685-6-nico@fluxnic.net>
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
 FA51920E-F0A0-11EE-A8F0-A19503B9AAD1-78420484!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

We don't want to silently fetch garbage past the actual buffer.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index 6edb858acf..03ef5b627c 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -672,7 +672,8 @@ static int lvts_sensor_init(struct device *dev, struc=
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
@@ -680,6 +681,11 @@ static int lvts_calibration_init(struct device *dev,=
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
@@ -789,7 +795,8 @@ static int lvts_ctrl_init(struct device *dev, struct =
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


