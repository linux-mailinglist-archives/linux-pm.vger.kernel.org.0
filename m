Return-Path: <linux-pm+bounces-14675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC75985DD1
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B0CB2C985
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5EB1E1A14;
	Wed, 25 Sep 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiadWUYK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE71E1A0E;
	Wed, 25 Sep 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265809; cv=none; b=OIabqF7l+8Wy+HWdVRePLFN/cw54p7l3I3TGJSuJmqlAYbB8QE4jMK5aXVXDn3Rj/D/4Mz9/Ha9iERXnxYk7/lB4J98tkAu6HN1b5yyIMCFVyDh/0e60cyOUH6r/qharRIrJYbyfk0+r0JHKtBambmAx4ASh6JtNvflXZe9dY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265809; c=relaxed/simple;
	bh=T2oTWp+g2oJvYD7RxFEZfHkI2F5at2sUHHBJkPxY5mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fz6FU8QLi1SRUQT6wRmSaR6bFWkRKUk6rTOAAu+/mKRYJdprPGVQqbPlr7zBkE4xD0C0ERQcLhjia8OQ7wQxxaopGcZ3Mic2mPAFHJHUqmRqkvF50lACFOQMZFcY/czOVZGAHMx71XCZKKzQ4Rz1KlB7Fg5ezgtxwhsLu2RtU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiadWUYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02552C4CEC3;
	Wed, 25 Sep 2024 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265809;
	bh=T2oTWp+g2oJvYD7RxFEZfHkI2F5at2sUHHBJkPxY5mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XiadWUYKdTyu617uVlMM8bFTN2pr2bztr3ZJd6FFyPvcHdX8IxhYzYzcT5QPUkjjP
	 SKTeHAozEX8EjRZy6Doi4qPbTkniPf4xyRaFtbC+IB7ZVByJtvc4hjJiRbzhKgmQdx
	 0LR9lndxxAf5QLo+gspC10tGH3v4W4yNg3M2ei91JBTp/DLO6gv6PnjXt5VtQFoHFa
	 B0V1yX0BSsIyaf9ozJx2PaSwflxWi70bImPkJ81/TyEtRsXcCotjNkhLuU3PNqRIzN
	 z6la+1tG/KKWb/E8ubBJGcwWZp5RLbpI0L7ZTQlZY/yprqMPMXSZ9udrat/0xi64cP
	 D9xfYAZHW8rNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 105/197] power: reset: brcmstb: Do not go into infinite loop if reset fails
Date: Wed, 25 Sep 2024 07:52:04 -0400
Message-ID: <20240925115823.1303019-105-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Andrew Davis <afd@ti.com>

[ Upstream commit cf8c39b00e982fa506b16f9d76657838c09150cb ]

There may be other backup reset methods available, do not halt
here so that other reset methods can be tried.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20240610142836.168603-5-afd@ti.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/reset/brcmstb-reboot.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 0f2944dc93551..a04713f191a11 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -62,9 +62,6 @@ static int brcmstb_restart_handler(struct notifier_block *this,
 		return NOTIFY_DONE;
 	}
 
-	while (1)
-		;
-
 	return NOTIFY_DONE;
 }
 
-- 
2.43.0


