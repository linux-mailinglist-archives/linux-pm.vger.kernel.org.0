Return-Path: <linux-pm+bounces-40135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B98CEF1FC
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 19:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A43B303AEB8
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D98F2FE071;
	Fri,  2 Jan 2026 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="q41phBFq";
	dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="TrOOrQJ1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73F272E63;
	Fri,  2 Jan 2026 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376854; cv=pass; b=h0iHNB1n+X57W6/woyPcqmt+8unRewvSoDwJsjW08Mw63W0VAAn9o0PQS0GySVxEIsCoHvmecJOKSlavDf4urZth6ShxX8w0TWl5KgeGmsGIVrXXrsOUj0Sd5D5AsGIsHj25dEDUu8HbzAMVGcz9ywR6TLA7d9XpSB1S7w5LE9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376854; c=relaxed/simple;
	bh=Uch4U0qgEM7cTuIEyy2Jv0JMCMmFm3wQDWCEjA/mhuI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cMvb+1tAkag8PsT4p2Ez1T64OTEYbZ11Nifb2za0BtTBnfBLNW21Z8Y0Ilul7AZv4GJ+QFUATD92oX64HWgTIA0bAQJcwslItkO/vghv2HnXSGxqL5IRioHR/+W8t69CyFWi8KuD5/paucMbGoiA0M/ilLhfflklm94yhDBe4Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu; spf=none smtp.mailfrom=jm0.eu; dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=q41phBFq; dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=TrOOrQJ1; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jm0.eu
ARC-Seal: i=1; a=rsa-sha256; t=1767376836; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=R81mB6Z9VJ4Ii4xrsDL2irsPcgBOsbJz07vtZawbGzA6YZni6Qly1GlhkCk0Oe6aEf
    K1ospmM6VS8uxlNFBabVxNBIN9M2NeSi4kSjE354HTFm/JkM3Dc6UBKD1Z/TGYj8o5ht
    QK8zahcX8yPQglF95glDV/E/8RPWAKlxvxekPmReZI6/OvjLwW9bWITfOZCY3evDMPKL
    8X+wVXKa+NkNhh/9STowuGUx6k/XpwlcFxgieLoguqoM0qlOxGrg+aKNsi8gfsKb4Qjl
    wCFGCgf3gDyFvTQ0TKlCFieqRT8g/Oeh3C4WEqgK5T1qT5ALNO83PV5BdUnbZoP13t5H
    nOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767376836;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=X87cwCCWZjshqk0f71Zpbr2Hwf6QMx80ZDoysBFiT2k=;
    b=hZIQEIWX74OYWYtETkjqHTm3U14u8wCE/lczXeGMQvgT1AhaYxjCCDt68O/PoI59lh
    w5jO2pMrSXkV1VebcxdLy981JHPfKRs1hhxiXUT+sYh1B3VyKnRXBffy1yT2y8JG8Dvp
    MF164vYjzRohkcxymCD/g0lMt13k6lmwusiVz/lWcEcxYbmU+bginDBuJ2mFzYN2Gztu
    3fY+DuOsdv2rlwy6YO2pdP3G8AlSLUmMNMslLIY6J4TVRrQuQoZuS11oLqtCKBJcoThh
    EbFjeGmj8SvlsczuGvSZq5cs4PhkHzmyTzKOyocTTF3IElEjn6jzssgpQLI0EsDXc8t8
    m9vg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767376836;
    s=strato-dkim-0002; d=jm0.eu;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=X87cwCCWZjshqk0f71Zpbr2Hwf6QMx80ZDoysBFiT2k=;
    b=q41phBFqlZBicChEMpeuuin+iegmOKujno6JpI3HfQGexfGx5E4xxOjFQEq8E4U079
    0tM/5dgjosm6SJVXwWrmu98u73PyD5gLYMIyl/y2mvB7pW57wEfoyRm1VlrB0xsL/hvN
    j7vWbC1T8+Cs0esjTEG2LCuP8ScXVB4wzYF2ny3bkHuvrzHOxcsQVGTiKMxwjjE3XQvN
    B8rgq02L+w/qTxFSDv76AWL7IzX/gvd144CbojCGTvBDJ6neSM5ArEsbMkf2jvY3xD7Y
    O91TgGznMvWKhOrkZRAFyy7gTJkIbAdpnuEa1DdbOsnCiV2wvTP/BuP36GPOo1aXuOZj
    rVlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767376836;
    s=strato-dkim-0003; d=jm0.eu;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=X87cwCCWZjshqk0f71Zpbr2Hwf6QMx80ZDoysBFiT2k=;
    b=TrOOrQJ11RmMe3y0TVhn3tkCGDCKMAdN0wS/iRGFHIZ8O1aEuVgLhTY5XgyJJxsZqP
    AzFtV9Q+9bQKZ+42tzDA==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPTeoCaRth8YQivJ4sfKeu9QyRDNI="
Received: from Wablet.localdomain
    by smtp.strato.de (RZmta 54.1.0 DYNA|AUTH)
    with ESMTPSA id z0d4ec202I0YEU8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 2 Jan 2026 19:00:34 +0100 (CET)
From: Josua Mayer <josua.mayer@jm0.eu>
Subject: [PATCH 0/4] power: supply: add battery driver for netronix ec
Date: Fri, 02 Jan 2026 19:00:29 +0100
Message-Id: <20260102-kobo-aura-battery-v1-0-501f2a8fa575@jm0.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL0HWGkC/x3MQQ5AMBBA0avIrE3SVhCuIhYtg4lEZYqQxt01l
 m/xf4RAwhSgzSIIXRzYbwk6z2BY7DYT8pgMRplSG1Pj6p1He4pFZ4+D5MGCKuUGXTajriB1u9D
 E9//s+vf9AFGv+c1jAAAA
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua.mayer@jm0.eu>
X-Mailer: b4 0.13.0

This series adds a new battery driver for the netronix embedded
controller multi-function device.

Bindings are updated supporting a monitored battery, and battery
description is added to kobo aura device-tree.

Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
Changes in v2:
- Fixed identity mixup between from address and SoB.
  (Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
- Changed patch ordering, device-tree first.
- Separated new driver and mfd subdevice changes into separate patches.
  (Reported-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>)
- reworded Kconfig to explicitly mention device-tree
  instead of vague firmware tables expression.
  (Reported-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>)

---
Josua Mayer (4):
      dt-bindings: mfd: netronix,ntxec: add reference to power-supply
      ARM: dts: imx: imx50-kobo-aura: add description for battery
      power: supply: add battery driver for netronix ec
      mfd: ntxec: register battery subdevice.

 .../devicetree/bindings/mfd/netronix,ntxec.yaml    |   9 +-
 arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts      |   9 ++
 drivers/mfd/ntxec.c                                |   1 +
 drivers/power/supply/Kconfig                       |   9 ++
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/ntxec-battery.c               | 101 +++++++++++++++++++++
 6 files changed, 127 insertions(+), 3 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251227-kobo-aura-battery-3e60bc159d16

Best regards,
-- 
Josua Mayer <josua.mayer@jm0.eu>


