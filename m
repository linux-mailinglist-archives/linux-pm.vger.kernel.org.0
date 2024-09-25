Return-Path: <linux-pm+bounces-14676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA52985F46
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9561C2584B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F50221E23;
	Wed, 25 Sep 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/lFZIdi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B66189523;
	Wed, 25 Sep 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266513; cv=none; b=JPWMmdMUasWUUBpkX0ivfFcN4uzUOlJvFytC4pxaRA9bsMTndqLsuOKLcsyXEG77Ex0W7/5sKTIGffjpQ2wTT8LYjTEsIg14mbN1X4863Hh7Bv6whINwlvU7Ltfb3ZXIf3DwLCDxzdvYkmQxQ6YwluJaW92zHYGiKZ24Dat6iG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266513; c=relaxed/simple;
	bh=T2oTWp+g2oJvYD7RxFEZfHkI2F5at2sUHHBJkPxY5mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS8IV3iK7mZDkH5MG9wcv5eqdjpXpzQU2PITy3TomLYT7E/s9tjyMW8UcbRM24nayFTdbCMtx3INkgpiV1mQdGh59chtdueOaif9RzLEBCEetLuQcrZ64V3SC3sXrj+Pd6LZrdbxLd9LTcfAJbyi2Y0lwzF8uQjzq8BJlLRZY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/lFZIdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA19C4CEC3;
	Wed, 25 Sep 2024 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266513;
	bh=T2oTWp+g2oJvYD7RxFEZfHkI2F5at2sUHHBJkPxY5mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/lFZIdiOHq/i6s/fNNoPboa1OXrJZdaAfRGWzrHkVGFyOMDyZeV1YBsaMfCsJmih
	 gB1xsX6n1SYGDuXTdkrkmfGzLJY1GtCRRTUrBAg2Mq7q38BekJ86zu3Zr6VcwZHYuL
	 RFx6krB2nyrvqvwRkP0m78Tc5RPLNukHuKK/5BpMs5mkbnAQmiPnHDDEdzgDO49vCk
	 cimztuNetPQekyhRpD/9N9Llhbd41y+oW5xjwPuOgf0vz8i66i4pVvpH2z/ykJHsxQ
	 Ghq/lYvdg3VLuHi2J75N5V+9+c2whiIFEzEgpP4ZW0h7G3WsVXuqw19OHOXfwzR0v8
	 51STuBCkvn+ag==
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
Subject: [PATCH AUTOSEL 6.6 080/139] power: reset: brcmstb: Do not go into infinite loop if reset fails
Date: Wed, 25 Sep 2024 08:08:20 -0400
Message-ID: <20240925121137.1307574-80-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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


