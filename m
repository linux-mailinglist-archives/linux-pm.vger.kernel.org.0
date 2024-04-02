Return-Path: <linux-pm+bounces-5772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7FD8949ED
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA721C23205
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7BA17548;
	Tue,  2 Apr 2024 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dDGFGB1C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="QclzW6m7"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF3168DD;
	Tue,  2 Apr 2024 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028474; cv=none; b=qvG5+8MayW1E4lHzNhCOX88bzVHwnaJBFJjgkKmWqjIskzbP9FAaZwAnG/EN749+E2mWcDETclYhEiAQFxxEcpOYdSmppfgUV1J8jFNpV2Vmlr8xA1qQjMfqPQMF7eV5w4ewfa2IsIBe/0PBawITD1+EMZeJChrcMxBeazb16HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028474; c=relaxed/simple;
	bh=Xacd7+XnI9OrgFgBfLlGlGfoJqixznjjgneYEnRh1Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjTpg50b2NysuVrryKIblaO/MDT6j33Fug3MK1Sd2uLz+zZ96EJSSFyy8SChOftFiPdD5A+yj4ztIqv9nOipYkJQ+qjDnAwpyS1iLIgepHrwJNAGLXfa7NniVo2hThCiZCxDVZ7dPUGqNKcmiDEbqfH+I5wjH/qIekNjRbBOBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dDGFGB1C; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=QclzW6m7 reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 102DD1EBE18;
	Mon,  1 Apr 2024 23:27:46 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Xacd7+XnI9OrgFgBfLlGlGfoJ
	qixznjjgneYEnRh1Uc=; b=dDGFGB1CfiG0s2v+47nESWRFinAVHGbjo8Z8t4ZPM
	taCe/9xHyoxhwepnBm6XLXAJ256WygChrWQu9GdkH9a2ITU2IsTeYVfUVOpBzs1O
	NoY20zA2KGMAYSME1PHSLjITGBR3+Ukf18yeMTSceZSgdw2cdYA6S7mJF9jAPewf
	gE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 074841EBE16;
	Mon,  1 Apr 2024 23:27:46 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=QgfuLgg+3qCZ3BodQZfrI7b7gjmE0dfhgjr3WRZLXjs=; b=QclzW6m7hjt8E6Fg99+D9D3Dh1wP0sXGudhFpQ0wkIk+Kbekizpj16gDbBWCR9A6RcYHMErAc6TiuPhwxjUqxlaOWp8hZxJyDViaYHcfjlcDciHO043sqv0WYItw3PBpvlC0vnrVzbDzvd5/PE4XJRx3uatgSBYSPyw/wEZ1wbQ=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76A8A1EBE15;
	Mon,  1 Apr 2024 23:27:45 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 720D8C1CEC9;
	Mon,  1 Apr 2024 23:27:44 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 02/15] thermal/drivers/mediatek/lvts_thermal: move comment
Date: Mon,  1 Apr 2024 23:25:36 -0400
Message-ID: <20240402032729.2736685-3-nico@fluxnic.net>
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
 F8D24D2E-F0A0-11EE-8C02-78DCEB2EC81B-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Move efuse data interpretation inside lvts_golden_temp_init() alongside
the actual code retrieving wanted value.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index 8aa6a8675b..73ca2be0f5 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -732,11 +732,15 @@ static int lvts_calibration_read(struct device *dev=
, struct lvts_domain *lvts_td
 	return 0;
 }
=20
-static int lvts_golden_temp_init(struct device *dev, u32 *value, int tem=
p_offset)
+static int lvts_golden_temp_init(struct device *dev, u8 *calib, int temp=
_offset)
 {
 	u32 gt;
=20
-	gt =3D (*value) >> 24;
+	/*
+	 * The golden temp information is contained in the 4th byte (index =3D =
3)
+	 * of efuse data.
+	 */
+	gt =3D calib[3];
=20
 	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
 		golden_temp =3D gt;
@@ -760,11 +764,7 @@ static int lvts_ctrl_init(struct device *dev, struct=
 lvts_domain *lvts_td,
 	if (ret)
 		return ret;
=20
-	/*
-	 * The golden temp information is contained in the first chunk
-	 * of efuse data.
-	 */
-	ret =3D lvts_golden_temp_init(dev, (u32 *)lvts_td->calib, lvts_data->te=
mp_offset);
+	ret =3D lvts_golden_temp_init(dev, lvts_td->calib, lvts_data->temp_offs=
et);
 	if (ret)
 		return ret;
=20
--=20
2.44.0


