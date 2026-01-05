Return-Path: <linux-pm+bounces-40191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B5CF3A81
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 13:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A60F230090E1
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CCD34405F;
	Mon,  5 Jan 2026 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvBt0Yot"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92293375A7;
	Mon,  5 Jan 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617809; cv=none; b=gB6dv9zaKhsVvfrfMxmTy8O9gpRLHjR13cxJBRF2u++iLLG1OoxNTEdN7VRBPBWJ8Qgf07CdE2HQvemSVewleHGUgcGrWK+g8osdsG5LnxbYxqKecF8oR9khjQ8QNdOF9t+H2pTlkrswd4Gvnr5WFoBsIcTPtK0tkpJL0HA7cno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617809; c=relaxed/simple;
	bh=qmt/PcU1Yu1EV0KhbS4i0pP6/2A6eNrCy2u0NVbxqrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kujp228Lqac09wrG+nmX+8JusVpDonuROTHz+nMuCtYS9aX5NRcFrfc9FSRt7s9EBDd5at5T56pWhI48oKvUyyyQSJSY698nQCJIQWuo8ZayAEHRJk6PpIQ5clfO+MUqgPEEAzm/fY+z2mLKgKERgZ0MgNFozGtnoKm+SuCxrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvBt0Yot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 693D9C19425;
	Mon,  5 Jan 2026 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767617807;
	bh=qmt/PcU1Yu1EV0KhbS4i0pP6/2A6eNrCy2u0NVbxqrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AvBt0Yots1PaxpFEKEg+PvmaPucv7i/OgnHLSBT4FW9QjA/BvNrvZmoC63BqXF9xa
	 B92rlzLz9Yl+qsi4upuDW4q/orKSMz2oxqF1oY1S8jP6MXmWSVhwY7xmbJzYxwi1Rg
	 GPsU3ZG2kVOy/bV5hc/KTpE8LpucyW9MoLzcCvaY243mQSLnJkwbWcPjMRYWhSPO6X
	 W5oZN617UAwbZpN8DAdC1iqInFQkD1XUbX4OaBh1uk4gPNRFMJoO/Rc4cA3sufIt3n
	 YDMOXnz0DajoJHQb5zGgVe8VhLpIS2PVnmS1YEnSbMBzsgVfM3LbphKCYRGpgm/EhL
	 I2ubXsgUJ/oyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B325C79F87;
	Mon,  5 Jan 2026 12:56:47 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Mon, 05 Jan 2026 23:56:37 +1100
Subject: [PATCH 2/2] mfd: macsmc: Wire up Apple SMC power driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-b4-macsmc-power-v1-2-62954c42a555@gmail.com>
References: <20260105-b4-macsmc-power-v1-0-62954c42a555@gmail.com>
In-Reply-To: <20260105-b4-macsmc-power-v1-0-62954c42a555@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767617806; l=759;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=vIxVriW7LVSbZfkV9TYc6jdqEm/Rah71gDngXrG5xT8=;
 b=gEO+8YJiCNJnMoPAkVVFkeBS2Bp+zqvI2YBPM8YBi4e8rNuaYViJT9wmJNVsFpR/BWU0KnzkM
 BEHGIxPEbgJAzaHpT36JJsDTt6mzSGCiZNC/Vd81ZOM8uz/gefQvheP
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=QIrgWBGCm3LG0YYc6MLCDkwuVXLTGGooVBdWX/KhSiU=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20260105
 with auth_id=591
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Michael Reeves <michael.reeves077@gmail.com>

Add the cell for the macsmc-power driver so it is probed by the
MFD core.

Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 drivers/mfd/macsmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index e3893e255ce5..061b43fc842d 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -45,6 +45,7 @@
 #define SMC_TIMEOUT_MS		500
 
 static const struct mfd_cell apple_smc_devs[] = {
+	MFD_CELL_NAME("macsmc-power"),
 	MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
 	MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),
 };

-- 
2.51.2



