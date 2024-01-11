Return-Path: <linux-pm+bounces-2137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5182B722
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 23:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6F428673A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B7FFBEC;
	Thu, 11 Jan 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EkCb9EmG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="LEMUVgNB"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58CEFBE8
	for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 49D3020C49;
	Thu, 11 Jan 2024 17:30:37 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=JZ5BgK2JLSGk76VVuRL/OjYJD
	2kkyIpgN3ChEjL0A8o=; b=EkCb9EmG08bEi+lmdz/9beLc/4YfG1PO66k1z2OqU
	EPAeiB+x4P+ABwYeGaPrY2TWh21wc/LktwL34q79b+OgdBVZ53n0OQwQYVhwibCO
	+a9SuPTuL0oulxNs2b8kWe/ozKDdmMt+zaaL9RQpLNJNOXhRf5gJlPNXbjqW+mUV
	pM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4290F20C48;
	Thu, 11 Jan 2024 17:30:37 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=k4kESBp+xD1U4bJE+I3PsSMi+E07tGQRkJ3s238fRZY=; b=LEMUVgNBTbk7FHDOgnUGjIMi/JuSq6f1DiUo43fAcvcwlT0vWBKTTX+eDhVfZM0bD830/kRnRkP3draFgHNt6tseyrRk8NiKOA0c9OKE6zhqBt0jEqtH2Xub2ePJOJlPhdFck3/g1juj/c4xRsd1hy0Ve4zb5bHYR28cl5RY9o4=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D3FF720C45;
	Thu, 11 Jan 2024 17:30:32 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 792B7AD5A61;
	Thu, 11 Jan 2024 17:30:30 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH 2/9] thermal/drivers/mediatek/lvts_thermal: move comment
Date: Thu, 11 Jan 2024 17:29:59 -0500
Message-ID: <20240111223020.3593558-3-nico@fluxnic.net>
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
 084A9410-B0D1-11EE-823D-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
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
2.42.0


