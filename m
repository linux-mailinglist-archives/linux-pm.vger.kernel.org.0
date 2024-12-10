Return-Path: <linux-pm+bounces-18955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A1C9EBC30
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAE91644C7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2323123A573;
	Tue, 10 Dec 2024 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I+ZHRQFX"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601CF2397B6;
	Tue, 10 Dec 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867765; cv=none; b=OFZbhHeP6zqDdEBpL5eP7SXos074l8bt2au4AXjHJQ0LvKc+oDSMVBlRrXrzQfcqK7FAjeFMPgygVaAP/Ut5ck44ix9vmsFOUn3Aw/mu8/awl2M90Mf/i9qnp0NTyirED+KvD12x8HswqFZeStdNVE4bBILeANo62SNa/DthfAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867765; c=relaxed/simple;
	bh=Rkince4SbmHoWAJI8yRTlw7n74O79dIb/szqZ+k52X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BeQg7N9wo9cE2Pvp1KbAZSOwPG9ZziRfiq+64pjQEcMFDthZeb4lWkznPjWCY+gza1ypxE+hiUpoiDxE8gUY0vPi9O3Jp7fraZbjqP/I46SGhvYEAyZqYRKq1+yfKLS3wfQVU79lMoPj/zUvJUfXoDX6gvf49ymsfClW+2Bh5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=I+ZHRQFX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867760;
	bh=Rkince4SbmHoWAJI8yRTlw7n74O79dIb/szqZ+k52X0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I+ZHRQFXvnnI7tKo1uptF7DaH5A5OF2A3GrxYi29NmNFRFf+JKZoody+UDZu52gEl
	 1qa6yM1KgKGA84MVNEEPt9GDlkKfBa+UPJEsez0WBkh2w0+khF+GQxk/4QYtpLylxO
	 Ilkt85jdz49W9sG2lO8FwFriG1fhy8Sgw7BPFOkg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:55:48 +0100
Subject: [PATCH v2 01/14] power: supply: mm8013: use accessor for driver
 data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-1-9d8c9d24cfe4@weissschuh.net>
References: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
In-Reply-To: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=795;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Rkince4SbmHoWAJI8yRTlw7n74O79dIb/szqZ+k52X0=;
 b=yRMd1OWjV5tRW6wmCgjUKhLOZqxJwf3GO3jOa8Pqda4apXT6jYmJOW7d+hrX8gSaFXH0hjEdc
 42RJ3CdFFnvBj1tWrPE15HS7nJDH9T/sEpQghDNgZttfPxfE1JAdIa/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Instead of directly accessing the structure member, use the accessor.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/mm8013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
index 5bcfaeeda3db755e05a449cbfd6f0c72162b6890..4adf2acc2779366323e52c467cff4f99ebb9d6ea 100644
--- a/drivers/power/supply/mm8013.c
+++ b/drivers/power/supply/mm8013.c
@@ -90,7 +90,7 @@ static int mm8013_get_property(struct power_supply *psy,
 			       enum power_supply_property psp,
 			       union power_supply_propval *val)
 {
-	struct mm8013_chip *chip = psy->drv_data;
+	struct mm8013_chip *chip = power_supply_get_drvdata(psy);
 	int ret = 0;
 	u32 regval;
 

-- 
2.47.1


