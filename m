Return-Path: <linux-pm+bounces-5773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B91DF8949F0
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6101C22F12
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE05156CF;
	Tue,  2 Apr 2024 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fd0iWhvy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="lodCUTZq"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555A14F64;
	Tue,  2 Apr 2024 03:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028477; cv=none; b=kN6gnVparBF3S4gYz7neN7Z/VKW0sletLkMY83PUrveuWPyfdo1Pzq2QIupPInDYzJOrXLXs4PdezzUkinjpfvrdBRdVVWu8d2hB121KfBcsBmhvmwp18/Y+V28eQW9B1hJ5I2k27YP1s3SS+QOrwl5gtn9rioOE9Ep5Xcpd6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028477; c=relaxed/simple;
	bh=wTzEj69iJ8UoY4X2yX7ncL39yAKgdIL2Ul1L8AhX++A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRNUcDKG9ZCeZx0oFpkMUaI3Z0gZWkVDz+7p9PPSr7e9+dIKcLi4utbiZyZo8gDKRa1/zLGz2OxSwY4QhV2mtCgYnHM7uCJbn8qnNouREehSFVtcw63FsHaJrBqdSXzrOpTUIpNNbZ+HN/HKNqxlpVeLyjn1TFXZB8HWQLiuBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fd0iWhvy; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=lodCUTZq reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D9C8219D9;
	Mon,  1 Apr 2024 23:27:50 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=wTzEj69iJ8UoY4X2yX7ncL39y
	AKgdIL2Ul1L8AhX++A=; b=fd0iWhvyntza8TapvhppInXFDp22mCSrVIgm1458c
	p3rHiOcjLW/76tBSLHQSwzwzyZIBsnceBqBcrEvvb8L4UjfxRBa9/jE1UBjQ2bws
	QuPuMHO7pmPAVRiDl3Je652M2Pn7Hu+KDuVb8/PZa8aNKBRw5SWioYkgtK0RK7Lq
	XU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 86018219D8;
	Mon,  1 Apr 2024 23:27:50 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=8mS5L7XcBU/PWbB5RoWRI1Hd7hvWa++aPqY1Xp/FvFM=; b=lodCUTZqTeLxV9bFpo8dQkPwCV7hx0oO7MSNhGyP16hG+6uxc3i+Mn+AIgEPJdmgGqmQZWxIet7+tp53rg/OpaTX/5cuIv5VQBoLX4dfqiJ/pMSDslPzQD5Dz6qu+oAjmyHJr3uA9b1OjecMGuXpjaP7YfCNbjUKLp4XrXRiRps=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85C76219D1;
	Mon,  1 Apr 2024 23:27:46 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 58CF1C1CEC7;
	Mon,  1 Apr 2024 23:27:44 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 01/15] thermal/drivers/mediatek/lvts_thermal: retrieve all calibration bytes
Date: Mon,  1 Apr 2024 23:25:35 -0400
Message-ID: <20240402032729.2736685-2-nico@fluxnic.net>
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
 F9744980-F0A0-11EE-AAD3-A19503B9AAD1-78420484!pb-smtp21.pobox.com
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


