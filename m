Return-Path: <linux-pm+bounces-39600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C211ACBF837
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 20:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AA57301A1DD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 19:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90432D43E;
	Mon, 15 Dec 2025 19:18:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAAE248F66
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826326; cv=none; b=FIy2wRuqa5Yh4LTWBfgCKKLsQEv16Kw/vdcK4dMvi3ju90FGHt4xtHxIPOdK5Lkths0bNsOmZ9wXav+V2+Eigodu1jO+q1Ux+krxrqlUWXZDs171vVHaXPny8Zx6LEFkF+MaQz0kl7pLllE2V+0i1+W6gS3c3KsEugMGSW7cJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826326; c=relaxed/simple;
	bh=uE2k4I0DPxWn2uHqbHxinuP7IlcY5FXvRNJXaelh8ls=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pc+ClnjXFrkVjuhCzfJF5EUUL9ZZOsr3FVxIiWXI0IssrZjK+qG6HwcQoqkjGxjMlDYQwembEdY1YxfWKlDUPszMDv/c1DNXml0h/u0cSsGSO5PnwZZ1BJJ0yJk57zf6zpnEW+HLro9AQCnK9OfISPwYddcW0ga9V97TqY7ivR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1vVE5a-0007x7-5s; Mon, 15 Dec 2025 20:18:34 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v3 0/3] i.MX91/93 BLK-CTRL improvements
Date: Mon, 15 Dec 2025 20:18:24 +0100
Message-Id: <20251215-v6-18-topic-imx93-blkctrl-v3-0-51dbd1333938@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAABfQGkC/43NQQ6CMBCF4auQrh3TTimgK+9hXAAdYCICKdhgC
 He3sDIxMS7/l8w3ixjJMY3iHC3CkeeR+y6EPkSibPKuJmAbWqBEo1Aq8AmoDKZ+4BL4MZ80FO2
 9nFwLOlaIskplFlsR7gdHFc+7fb2FbnicevfaX3m1rf+oXoGEwqR5ipRIJc1loK5+Tq7veD5aE
 hvt8ZPDXxwGjlJtAqXj3JZf3Lqubx1pwJ8WAQAA
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
Changes in v3:
- Link to v2: https://lore.kernel.org/r/20251202-v6-18-topic-imx93-blkctrl-v2-0-e73501034adc@pengutronix.de
- Add r-b (Frank)
- Rebase to v6.19-rc1

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
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251201-v6-18-topic-imx93-blkctrl-341220f7084d

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>


