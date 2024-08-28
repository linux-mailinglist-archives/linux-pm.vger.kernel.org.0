Return-Path: <linux-pm+bounces-13045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A7A962F4E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 20:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2090D1F2238A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946D1A7070;
	Wed, 28 Aug 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BCNSI5w+"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289211A7AE3;
	Wed, 28 Aug 2024 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868293; cv=none; b=Xt31/V2i2+NC+/tE8gfm82FP7gPo9Q2nMi8N9IMt3rYVkqQlPN7NY6Ghsxp95NbTp+14IOotL9k13Byx4w2NQDIRZZdrPvIJBG5eMhsnj5lbGhwKUZnayWSTvy2VMuZRxhQd42z4ZQ5OUPueiZQTwbkLNZFRRmr/Jcv+cTYMIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868293; c=relaxed/simple;
	bh=13XN6LZQvncMGjUarxPOUbwCHv4R/AT5HrtJxeivgzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ga2x68sZJ3CH22pp1IJd7JI1To+YTEGJu89U1H6pUlnCx2ZW8+LAdmQs3+XGx7RUWznrbCoeB0SEtHh0sOalNoKpIbYri3S/AkLMMR2XoXRAaOBZW79TuHdnPkemjs5yJPFs0xEULBVXmnl6HEPtcfNoTXGSnJQTVM9t3bD6sCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BCNSI5w+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724868281;
	bh=13XN6LZQvncMGjUarxPOUbwCHv4R/AT5HrtJxeivgzo=;
	h=From:Date:Subject:To:Cc:From;
	b=BCNSI5w+r6yFZ8TUx9mAuKp++42tcWqEI0kgiF/B+ke9XQp3PwW5xuPc3Sub+/Oju
	 rCXHs0MIOG7UDL0y17LDabo7R/WNYOMBDWQycnWHsbtkc6j/iw9jo0m4OsbLLLyMwB
	 /G4FQ5Bk65sF+18Qj0fnrUu4eiG++VG3Ng6/ek0s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 28 Aug 2024 20:04:29 +0200
Subject: [PATCH] power: supply: core: constify psy_tzd_ops
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240828-power-supply-const-psy_tzd_ops-v1-1-dc27176fda5b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKxmz2YC/x3NTQqDMBBA4avIrDugwUrsVUoRSSZ2oCRDxt+Kd
 2/o8tu8d4JSZlJ4VCdkWlk5xYLmVoF7j3EiZF8MpjZtbY1FSRtl1EXkc6BLUWcUPYb564ckit6
 E1vXdvbGhhxKRTIH3/+D5uq4fNmW7kXAAAAA=
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724868280; l=917;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=13XN6LZQvncMGjUarxPOUbwCHv4R/AT5HrtJxeivgzo=;
 b=DIsqmwZ2KaHU7c4v1g/5eKg+r6lfRY0ZtCszDkdQN3V3YTjixGT2MMoS2ItmtHmASQiI8PaFc
 sYbAsO0ZOH/AZMxL5pbuRH+a2MuuardxawYrFfpjtKM1NS09MUKQ2tn
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This struct is never modified, so mark it const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 8f6025acd10a..ecd011cb455b 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1296,7 +1296,7 @@ static int power_supply_read_temp(struct thermal_zone_device *tzd,
 	return ret;
 }
 
-static struct thermal_zone_device_ops psy_tzd_ops = {
+static const struct thermal_zone_device_ops psy_tzd_ops = {
 	.get_temp = power_supply_read_temp,
 };
 

---
base-commit: 86987d84b968b69a610fd00ab9006c13db193b4e
change-id: 20240828-power-supply-const-psy_tzd_ops-d2f4c96518f9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


