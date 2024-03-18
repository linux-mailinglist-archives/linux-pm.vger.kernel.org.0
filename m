Return-Path: <linux-pm+bounces-5079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AE987F20C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6AF1B21D81
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802D59B68;
	Mon, 18 Mar 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KIQFWwgw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Cbw6msFe"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56A58237;
	Mon, 18 Mar 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797098; cv=none; b=mbQvtx3eCTGUo3HpG6CUtBu3lOp6WVwrHAVCWV7Ia5zr+okTlYVzyZBdf+Voqdr1sUjVBpFlIdZc1jlUWeO4PK3Dp0twpmka/muqOYxwsyHs+wSgX3g+aqwDNVwFvrigA78GlGj4p24+/6JH24DBVmQGoBrx5u5nbHsbZr2tDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797098; c=relaxed/simple;
	bh=wTzEj69iJ8UoY4X2yX7ncL39yAKgdIL2Ul1L8AhX++A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xe6/sSZHaIXriyxm4FHKjDAku5iX9AMoU8hEuaFy/uu5O6L+oungGcBWVow7PROaimAvSR/B4FC0XfkzpN3velJbtAhyrK0X7FV3Zbe2TH1oWNa2015BBFgsMhDnSusOKLzFEzbLkDohzcXLeWDp4HCW0LuPFL5/T+HLJ9XGRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KIQFWwgw; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=Cbw6msFe reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EDDD309B3;
	Mon, 18 Mar 2024 17:24:56 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=wTzEj69iJ8UoY4X2yX7ncL39y
	AKgdIL2Ul1L8AhX++A=; b=KIQFWwgwlhzRhuFMd2wEjEXyQSFB7kZ3n52m6HjQf
	mbrK4Gr5Q4jKOCETR08IdYRoKhcAX5V2wWWK/7junuO3JJkb0JANnYU8gffNsk+g
	6BpqDewUr3FhcbKRpfIqvTB4yrxcDMudxb5kCnhoYM96BeWspuH6Y7dAta1slnYp
	ik=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 16F5E309B2;
	Mon, 18 Mar 2024 17:24:56 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=8mS5L7XcBU/PWbB5RoWRI1Hd7hvWa++aPqY1Xp/FvFM=; b=Cbw6msFewsSEyNQa8DVIomsU9Bqhx0BZ/FcYkVXdJJu9ATm4jKHiIBK4ZFk4j6Emayv1WdkDKH00IRHTkV/Ha/XI/CYS6t0BLxro9A22SXbKEdiHcI5HrWTSvGbOLIofh1P0OAXdPHRUUHGcRQZ+aUppuvgltN6F/Cw50YywRhA=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA7AF309B0;
	Mon, 18 Mar 2024 17:24:51 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id BE244BE2B9F;
	Mon, 18 Mar 2024 17:24:49 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 01/13] thermal/drivers/mediatek/lvts_thermal: retrieve all calibration bytes
Date: Mon, 18 Mar 2024 17:22:03 -0400
Message-ID: <20240318212428.3843952-2-nico@fluxnic.net>
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
 F501701E-E56D-11EE-94B0-A19503B9AAD1-78420484!pb-smtp21.pobox.com
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
2.44.0


