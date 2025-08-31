Return-Path: <linux-pm+bounces-33486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C7CB3D2D7
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E6917B218
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9710125A631;
	Sun, 31 Aug 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjI6jHsV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E3273FD
	for <linux-pm@vger.kernel.org>; Sun, 31 Aug 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756643390; cv=none; b=O8jhmo0UljOG69g+AEsNXW8qj4YyrP7tzQ33Iikd/v06oeUWdIAPiqPDi9j4x9dSFvJlKfc2WSRWoumMqRDAwaP+Q68VUeLPXmFACucI+CUfaQq2ZB49XzMOv5WXoUA8e7Riyjic7NChRscjsu0HUWGSkPcA5c2TW3rnRw5xM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756643390; c=relaxed/simple;
	bh=XP2xrCfxbUyUdnHUck7yc4q4XC6UEufXZ9DQrPc4TXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2FCYtNUrPjyOnodZjkthsr0gwVKIhXxsQhh2bkwftUkcJPEB1mDz5ZM4eSJ7qmEygUrZNIO0Nowq5zUZhu5c1s7pAr3yDmgEGPGZIY0sOQx3jXTs6s+EF+YwqlwFEBLRWZ9EhBNUhODI9NrsJsNFly/SyNPmDKCAfw0F5beZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjI6jHsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F77C4CEED;
	Sun, 31 Aug 2025 12:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756643390;
	bh=XP2xrCfxbUyUdnHUck7yc4q4XC6UEufXZ9DQrPc4TXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjI6jHsVqco2v1QeR5ObbV2AlxxFjUkB9fr7Or9PIHHf8rKsPAj1JjXE/YiewiyN4
	 chX6U48ZOo02a9O1RaaadbgUzjFdSOe0vDO7/GXvmHJ9A0cWUhkfHpegr/cW6y99Pt
	 O3k1d2vWMC1ds2mpLV0dECG8KUnFsIkUw13wupuqLF+VvKllynDa08vSDACiLpEI0e
	 teD7kbZsfYEDCD5WMKFKkc4uTtA1SA2ajRHNUm81ufdJehKkJ6MHM9g4QA5DSgBRZm
	 L0nVbAVV5yukFzIsP5F+dUZCyrDX4nrBE2x3iRimm38L7kBZBoZU6rvJCoSdNggLnU
	 TG7q3zljEhOTg==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 3/5] power: supply: ug3105_battery: Put FG in standby on remove and shutdown
Date: Sun, 31 Aug 2025 14:29:39 +0200
Message-ID: <20250831122942.47875-4-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831122942.47875-1-hansg@kernel.org>
References: <20250831122942.47875-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put the fuel-gauge in standby mode when the driver is unbound and on
system shutdown.

This avoids unnecessary battery drain when the system is off.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/ug3105_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index 70dd58e121e3..c4d4ac859fa4 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -206,6 +206,8 @@ static struct i2c_driver ug3105_i2c_driver = {
 		.pm = &ug3105_pm_ops,
 	},
 	.probe = ug3105_probe,
+	.remove = ug3105_stop,
+	.shutdown = ug3105_stop,
 	.id_table = ug3105_id,
 };
 module_i2c_driver(ug3105_i2c_driver);
-- 
2.51.0


