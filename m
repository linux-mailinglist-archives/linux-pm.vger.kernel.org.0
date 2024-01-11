Return-Path: <linux-pm+bounces-2130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6521282B71C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 23:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F288D1F239A7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A5EAEA;
	Thu, 11 Jan 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QtCYofxp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="SHQjjGYk"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B961C2D
	for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E86BE1D3A52;
	Thu, 11 Jan 2024 17:30:31 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=hkTGZr0oUZ+TSkNkO9ROijrGu
	KlR3lmE5vddsIDP9f8=; b=QtCYofxpPxMLZ4aST8wSFhSEE0sne7sbjlPZlcXN7
	avnkq2WYJII/RFX6pb8XMMyfHviLqgzaKV+7iB1g0+0dcLWdKvyHQfnO+Gnm5fu/
	UV8nUhTHjZeffIvVjAly20sKB8iRxyO+2NKFvbTy7Pw0af4f41ncUWmSFYnmtKeK
	yk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E003B1D3A51;
	Thu, 11 Jan 2024 17:30:31 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=ZBPyzkXdxEzT3ofgqN7dBTpCfXhcN2e7z86BUzF5PW0=; b=SHQjjGYkQuoNVuAtNlvZc4s+xdkFaHR/fHeLy9g/SrKn5dA//A+EO9gCZOW0yiMF/xwjkRMW7I1JT8x5Q2pJtWZrJJ84f/hDKgu87k4uKVnWRVD80kPymn4k6PsEW9AWgTjDe7E1Rdov6L4IQ1ocQr2hNop4KnyzbwUIp81K4K8=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 654FC1D3A4F;
	Thu, 11 Jan 2024 17:30:31 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 682C5AD5A60;
	Thu, 11 Jan 2024 17:30:30 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH 1/9] thermal/drivers/mediatek/lvts_thermal: retrieve all calibration bytes
Date: Thu, 11 Jan 2024 17:29:58 -0500
Message-ID: <20240111223020.3593558-2-nico@fluxnic.net>
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
 076CC54A-B0D1-11EE-954F-78DCEB2EC81B-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Calibration values are 24-bit wide. Those values so far appear to span
only 16 bits but let's not push our luck.

Found while looking at the original Mediatek driver code.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index 98d9c80bd4..8aa6a8675b 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -679,7 +679,7 @@ static int lvts_calibration_init(struct device *dev, =
struct lvts_ctrl *lvts_ctrl
=20
 	for (i =3D 0; i < lvts_ctrl_data->num_lvts_sensor; i++)
 		memcpy(&lvts_ctrl->calibration[i],
-		       efuse_calibration + lvts_ctrl_data->cal_offset[i], 2);
+		       efuse_calibration + lvts_ctrl_data->cal_offset[i], 3);
=20
 	return 0;
 }
--=20
2.42.0


