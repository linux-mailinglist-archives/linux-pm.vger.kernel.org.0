Return-Path: <linux-pm+bounces-40450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDCDD02FDE
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 14:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57B64300B9AE
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438DB4EAC87;
	Thu,  8 Jan 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKlmo2OD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172034F1546;
	Thu,  8 Jan 2026 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878331; cv=none; b=Kd9Sg2kbIwicFJuMWHXNSnmg9zsICFyyulEbqv0MoiVtSzqjWpq7I0s9GqHrQjBICXT9gCEWxxWX7SBtavMasRSPQukCiaDFtKHj82PRitHpn5+Z4OdZK/TsvfUyJLuKNxRlOnm2ce2Z+ve8B6Rnsa4m6cw0+i7WKcV5orzWfJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878331; c=relaxed/simple;
	bh=/YUbOZyHu9lNHH6tzNkLGVe+2dLu2CFhEPiXi7I2fUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JqkoJRGuXgM+kPQWwT5mlhI6a5TMC+BSZ7TOe7guc6MxCWgx63/W5TAg3H2/5SUlkFcL8h1jVAa+QrWRTh/NnNsTVahUDcYkmwwmbcFy2v5sa2hFZ23F2uSxSpNnSEeH2c2LftiuU1Y3V/JjmGwo6YcuFOH6s+gwxVBdrPhYJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKlmo2OD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE829C19424;
	Thu,  8 Jan 2026 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767878330;
	bh=/YUbOZyHu9lNHH6tzNkLGVe+2dLu2CFhEPiXi7I2fUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RKlmo2ODLjgXoCcE6FybeXC/koDaEP9EHirJU0nY3h/7EElyn4C/Lm+qJTLTBm2b/
	 MUZLfYOntzknA5e3xQIruZNQinupFeSoHeJqfPZx2tJMu5x5JmA/1ZbOqettgO6Gk7
	 uA9Ooy5yY8XB3JHt1NSJaa/YHA3dia+3+x+jPOVshYoVH+xXcLrsLXUDaaCRdY5NhY
	 VuObWrOr0ArQYfQGvPF3g3ia202v4YFS3+n4yDeostQkX+08nik3hfcxxK/kAfm3Dk
	 pvpCWTlTZg3z6HsdlTpB2vYetA09vgytWfBbfNy+jj1tvk/IZ49d0GqFw9sgZCCu/B
	 C/IRBDVmUnbkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA55D185F3;
	Thu,  8 Jan 2026 13:18:50 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Fri, 09 Jan 2026 00:18:49 +1100
Subject: [PATCH v2 2/2] mfd: macsmc: Wire up Apple SMC power driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-macsmc-power-v2-2-93818f1e7d62@gmail.com>
References: <20260109-b4-macsmc-power-v2-0-93818f1e7d62@gmail.com>
In-Reply-To: <20260109-b4-macsmc-power-v2-0-93818f1e7d62@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767878329; l=801;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=uag1kKlvUx4ATUulWYAHXmnzGW1u1x2TnZFa9uDBZWc=;
 b=Ch7BexD/JjZdjCCxIiuzHuZ3sJiu2c6EBZQdJyMMp5WRt3j06YLMQdTcs6bP6XAPhaouFYVb4
 cM0SaigWaziBm/ZJC2LIb3S646Q06qiL9FBAFufCvQesuXtCjzdp3j+
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



