Return-Path: <linux-pm+bounces-39074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A3C9B949
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 14:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3051D4E4769
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C827313528;
	Tue,  2 Dec 2025 13:21:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE6158535
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764681707; cv=none; b=Q0JC3KkoCmgYVRmjzqsdZj5YE3JXkqws+BLvz8K3xy+edu7+HyJZE1gDWD/lVZhXdgPKFPDdVoBKU+ug/nGKTOk32Y2zsmlT+SzQf3ryz1Pg18Qn86Y6MuLrT1+8ouiqpYA1l5WCmt5OgecA3wG0NzmRQ2ifcROLLGYkNd3r/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764681707; c=relaxed/simple;
	bh=3UOeRD4KPPaMbagLYB6H6W5V8CnjCL6uh/WLWt4IRQg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lPIKVKNCJ10x/WB+5QLFzsS1oUjBGcwIbPiyqfRjCkNk8g/CSE/Z3dr1z0LilWMwvbUbu0IodznX6F/b9g8xW6E3GAq/VUYX3VRCVF/nAeW1biGLKZWyVb0XfmLQk3PWf7NT1Wg3dckGveeER74TN9sPU6D5mVkc6fSNIRtxHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1vQQJu-0003pJ-MD; Tue, 02 Dec 2025 14:21:30 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v2 0/3] i.MX91/93 BLK-CTRL improvements
Date: Tue, 02 Dec 2025 14:21:01 +0100
Message-Id: <20251202-v6-18-topic-imx93-blkctrl-v2-0-e73501034adc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3nLmkC/42Nyw6CMBBFf4V07Zh2eMrK/zAseAwwEVvS1gZD+
 HcrX+DynOSeuwtHlsmJOtmFpcCOjY6Al0T0c6snAh4iC5SYK5QKQgGqAm9W7oFf2y2Fbnn23i6
 QZgpRjqWsskHE/Wpp5O1sP5rIMztv7Oe8Cupn/6kGBRK6vGxLpEIqmd9X0tPbW6N5uw4kmuM4v
 l1lvdjHAAAA
X-Change-ID: 20251201-v6-18-topic-imx93-blkctrl-341220f7084d
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Frank Li <Frank.Li@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>
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

---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20251201-v6-18-topic-imx93-blkctrl-v1-0-b57a72e60105@pengutronix.de
- Adapt patch2 commit message (Frank)
- Check devm_pm_runtime_enable() return (Frank)
- Add r-b tags (Frank, Alexander)

---
Marco Felsch (3):
      pmdomain: imx93-blk-ctrl: cleanup error path
      pmdomain: imx93-blk-ctrl: convert to devm_* only
      pmdomain: imx93-blk-ctrl: add support for optional subnodes

 drivers/pmdomain/imx/imx93-blk-ctrl.c | 77 ++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 41 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251201-v6-18-topic-imx93-blkctrl-341220f7084d

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>


