Return-Path: <linux-pm+bounces-38993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543AAC98717
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 18:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35D63A42AB
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15793335BBE;
	Mon,  1 Dec 2025 17:12:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740FF335556
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609133; cv=none; b=BmCfLBwG0XfkxgLavjX0Lm7X7ks87QOjgGUd4gR6wjOmSdT/GMm+Z/1fZ6Q4ibWGohZo7mLSU2Z5yE6K58OMYSteujJFanicvs7qgSprmmPxJqcsrnEgwybPjcZ/Ah+1hpn8QRDhcFoA1TzlMnX7n+OkAG3uoegU3FAFOE6We60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609133; c=relaxed/simple;
	bh=e8qpdiCrIoL30n3IAsDaOKDW8BKByqih+SzRyU9v5kw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EmoiaOJjQ7pEnxGJY6JATbb6lBx8Rimz1kZ2AExZfgOwvXC282tF7DAQaBCoUR606GDiSOGx1j6VtyApvpFRz64PGTJq2VShGlIlfyj2R3jbo+Sop3DfUIquQ0Mp7ytWL6tLH9zS21T40aFSzEpY8WkTHLThlpRaHTTwJcguYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1vQ7RX-0002dz-AR; Mon, 01 Dec 2025 18:12:07 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH 0/3] i.MX91/93 BLK-CTRL improvements
Date: Mon, 01 Dec 2025 18:12:04 +0100
Message-Id: <20251201-v6-18-topic-imx93-blkctrl-v1-0-b57a72e60105@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTMLWkC/x3MQQqDMBBA0avIrB3IjLa1XkVcaDK2Q62GREQI3
 t3g8i3+TxAlqERoiwRBdo26LhlUFmC/w/IRVJcNbPhBbAj3J1KD2+rVov6Pd4Xj/LNbmLGqidl
 ML9PUDnLvg0x63O+uP88LNDKcwWsAAAA=
X-Change-ID: 20251201-v6-18-topic-imx93-blkctrl-341220f7084d
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi,

there were several approaches to bring the sub-devices population
mainline [1,2] but non of them made it upstream. Both approaches were
part of either the i.MX93 LVDS or MIPI-CSI enablement.

This small patchset decouples the blk-ctrl changes which allows the
MIPI-CSI and LVDS patchstack to be rebased ontop of this patchset.

Before adding the sub-device supprt, I converted the driver to devm_*
only API.

Regards,
  Marco

[1] https://lore.kernel.org/all/20250701-95_cam-v1-3-c5172bab387b@nxp.com/
[2] https://lore.kernel.org/all/20250304154929.1785200-4-alexander.stein@ew.tq-group.com/

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Marco Felsch (3):
      pmdomain: imx93-blk-ctrl: cleanup error path
      pmdomain: imx93-blk-ctrl: convert to devm_* only
      pmdomain: imx93-blk-ctrl: add support for optional subnodes

 drivers/pmdomain/imx/imx93-blk-ctrl.c | 75 ++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 41 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251201-v6-18-topic-imx93-blkctrl-341220f7084d

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>


