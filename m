Return-Path: <linux-pm+bounces-14673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB33985A93
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 14:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD70282CAC
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5891B7917;
	Wed, 25 Sep 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d61GYBLG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342F1B7914;
	Wed, 25 Sep 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264551; cv=none; b=bzvm/qGwJC1ZlXoGxSekRujG0ohCTZycIgyQcRf99T+Dxh/F0OfAQdksaWRJkTVUuppMFJEfe+k1iowiLM23APPuQ+uVehX7Po1NAYyaY5GEZJuLZN+wzXAJk2iTnNifheXSZCwnh0m4UpGGFDBiDMzEQf/s8jUWZm0Kw12cKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264551; c=relaxed/simple;
	bh=T2oTWp+g2oJvYD7RxFEZfHkI2F5at2sUHHBJkPxY5mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNNmRwpAWMQBd0zCA/Fjs8pyCQ0vW/y7a22ThxhBzfPUWREjmcbwehhRTIEjuD8fpFpLwPrRCtzkVoqCBHmJRnw083R+oviTO4Rkj6D7EQFu3+xR9xUsHHoDNipQhvW/p1JJd9tRFKb7G6c/TiRn08FMPDwCNcoZ5jVl+a5vh+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d61GYBLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29799C4CECE;
	Wed, 25 Sep 2024 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264551;
	bh=T2oTWp+g2oJvYD7RxFEZfHkI2F5at2sUHHBJkPxY5mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d61GYBLG2zNV3M+DbWJdgVrSqCbNeE4YV0Y/yf4TkHSs4ijPtBu9NDo3JEkuL0rgs
	 sJ0vL/LP5Ds5oNW7xQwpHxtW3HPQY9r9C2Gt+JbNBDFOg5Wk3VswrdA9Vv7Hmb2mQ9
	 qKYuvXinS3d96hvc1sK8NSg9z7pLv+YUJ/T6+YFrp+NVLDWzy4vbiMP87LwjSdgG4Y
	 vYxg3FdjmvleHH7uDYRrMHiPl2jJz4P6wByVNX8/tusHH6sFibWgA7NUmW+peZOosX
	 ihgOaqqPxyx7d/KOZo5ew6bqIHgkaEqh6ftr+PVztUPwIPcPdjr8YAEasDb0zhJ6O4
	 xjdi2CRJiE3bw==
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
Subject: [PATCH AUTOSEL 6.11 122/244] power: reset: brcmstb: Do not go into infinite loop if reset fails
Date: Wed, 25 Sep 2024 07:25:43 -0400
Message-ID: <20240925113641.1297102-122-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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


