Return-Path: <linux-pm+bounces-5072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D795287F1FD
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1396E1C21007
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D72958230;
	Mon, 18 Mar 2024 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TkY7QM1l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="aMalsHye"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABAD50269;
	Mon, 18 Mar 2024 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797094; cv=none; b=CNE9SZxL9+K8szqHm7MDLW+BxoYUfIKAln8SHCKf0Bglo8sG9FlnjiuF6JyR1lblPCDWYTlzcOXXm9OfAC5+hQdqAsuw4dMKbSUMRUQb0MLC8cOaP6VIcPWDULNWCvvI2WRczk1TjWb8eN4wZk12ahBEBs7lQVcHF3AMZ1sUmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797094; c=relaxed/simple;
	bh=Xacd7+XnI9OrgFgBfLlGlGfoJqixznjjgneYEnRh1Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/nw6Qs8V7iZ2kMtpIAKP8NnY6+fV3hqce4eJowZ/IYXcjTCvIaglAweMz6BeI9Uz61CKEypvli+KiBNSypHdKjwSmlxDPV5GJNPaC9W6Vf4bRMuItQPcKy4Wp05X4mUuhB+yZxbI2ZKA6emBnshPieE0T1gI5DA+uihvmyWjtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TkY7QM1l; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=aMalsHye reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C3291D0E3F;
	Mon, 18 Mar 2024 17:24:51 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Xacd7+XnI9OrgFgBfLlGlGfoJ
	qixznjjgneYEnRh1Uc=; b=TkY7QM1lDYIW8xZk0X368BEV0j6nu6Vu1rQ8Q1YiO
	vWHN+aHjVDs2Dl9I6Wke3DjUo8QYp5S5BrMKGJHy9AEELZyPcVkgE7esrQIpV8kt
	tmhulSIRUnDf5Z+cFGlB+NP4j2Do4tKX7J1Bvtr2uKwZXVF4QZdY098wtFNTh7Hz
	4o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 645F41D0E3E;
	Mon, 18 Mar 2024 17:24:51 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=QgfuLgg+3qCZ3BodQZfrI7b7gjmE0dfhgjr3WRZLXjs=; b=aMalsHyeCIo2UC9UviC+XFMGk4FAxWfLIMNs6m34FqzDTAEAYPTeuKfHVOk3RC1l+A5h4qqQpGYSxQWecs7fHNwwvX19Gn0baPjkjWhHV6QWg0Hgyi1Qi5qBNSU1PdVzXNxt8uo6QjhmXY2OxnqWIVG26adgDm4WEf3OmWHaiEw=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4CE11D0E3D;
	Mon, 18 Mar 2024 17:24:50 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id D404ABE2BA1;
	Mon, 18 Mar 2024 17:24:49 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 02/13] thermal/drivers/mediatek/lvts_thermal: move comment
Date: Mon, 18 Mar 2024 17:22:04 -0400
Message-ID: <20240318212428.3843952-3-nico@fluxnic.net>
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
 F45B0AB2-E56D-11EE-93E5-78DCEB2EC81B-78420484!pb-smtp1.pobox.com
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


