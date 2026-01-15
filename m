Return-Path: <linux-pm+bounces-40905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5409BD22B7B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 08:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E949305DE4C
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 07:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7CA3254B1;
	Thu, 15 Jan 2026 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vwufild1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB21E7C03;
	Thu, 15 Jan 2026 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768460905; cv=none; b=TdOXVDFUSXsc/NGop8eNTx0SZD9UyPWIJCckISUZqB9D2K/pnsbxAhyB4Fq6vRrgDoX6z9g/aDlFZjtIdVoxYUxTkDrUtCw5P13znvF4eQVMJw3DMn0OpDrgmwqTdFUTHyd+g7amGNKaqZgcM/IoDCjlflBNmzlDGLTm/npyuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768460905; c=relaxed/simple;
	bh=cP4GmaEtVpxPmeyytNYbYkgAMv3oQd/5ywe08WS5YKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYky1FeiLK+TeqK7uP7btmZqztSdAeDhEmeyJGlkQQP4Z3fd9j8MqEvEDeHmdJEIOhBj9SIWoZacSjXPy09tem2FPaCwqPLLeAE96wI1y/dEEdpbDvszn+1tb5g6WdzRil8r0OgesBGWjjlq9/0eiWisXsbpIOqSnZKFhIXJx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vwufild1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE265C19424;
	Thu, 15 Jan 2026 07:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768460904;
	bh=cP4GmaEtVpxPmeyytNYbYkgAMv3oQd/5ywe08WS5YKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Vwufild17USCNmpj1sGc7MrkwuGz5Jn7wcPOe5w8tpta6qJv4+hIDNCYYJHHHu61f
	 ANnGTcP8WEFKRlQz/Pvz50GQ/ipAdVjKLaVdU3ZXiLCwwzgzrZvN/0OhHXGyPpI5mZ
	 Xa6vK5YH2WjK7voOGdlSU/m3ouimPru8WSchkTzAhF7CKtHFee2NlqTwEZKY1uI7oM
	 HB5RgOMcMHvA5EvgBcofpOaHN6Z2m/hlU1btlGLrlgyGb5Eqd2r5QA1tbNvWr1FvH7
	 2rk16kkZno2byx/Su1E/4IysT2ZTZNZLo/lWv1ppuAQDvDPJKU+xjXkZu4Z1LxrDTL
	 xFoii/UPDxvFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B3D3CCB7;
	Thu, 15 Jan 2026 07:08:24 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Thu, 15 Jan 2026 18:08:16 +1100
Subject: [PATCH v3 2/2] mfd: macsmc: Wire up Apple SMC power driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-b4-macsmc-power-v3-2-c236e09874be@gmail.com>
References: <20260115-b4-macsmc-power-v3-0-c236e09874be@gmail.com>
In-Reply-To: <20260115-b4-macsmc-power-v3-0-c236e09874be@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768460903; l=869;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=pPwBsBWIsTSasQaGOKu1mKoA6/kk951MwDXnYg4cljc=;
 b=T0S9aQuOIdFj4nfC6B+Vg43orEdfW0DIHViAU1+v5ZiMTHNvE3hvNDbTomYG6ra0z+W61p8yM
 InFmkvwd5cMD79KgFLvLihDvNhGirHB3cIkMVn24asgWqhYXygum2pd
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
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 drivers/mfd/macsmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index 1b7e7b3e785f..358feec2d088 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -46,6 +46,7 @@
 
 static const struct mfd_cell apple_smc_devs[] = {
 	MFD_CELL_NAME("macsmc-input"),
+	MFD_CELL_NAME("macsmc-power"),
 	MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
 	MFD_CELL_OF("macsmc-hwmon", NULL, NULL, 0, 0, "apple,smc-hwmon"),
 	MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),

-- 
2.51.2



