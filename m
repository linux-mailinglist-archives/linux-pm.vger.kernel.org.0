Return-Path: <linux-pm+bounces-18768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D439E852A
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FAF1884CE0
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25814B06E;
	Sun,  8 Dec 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CW2ThGx6"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF4C1482F3;
	Sun,  8 Dec 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662962; cv=none; b=UZUKkLrcw1IRIWzaeC0BWYE7GOipB7jh+/Kiu1eQNMQMUKW+6XBt8yWjaM9l0CJHB+vPsqruVibnkbUyCR4ft9pArxOwZ9GH7OMZ3R+pIfpJ5LkKR143W9Doy7H74ZonaadlfR54+vmif8UsPuHjWkX8r89N/+6qAbkxoC43hv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662962; c=relaxed/simple;
	bh=Rkince4SbmHoWAJI8yRTlw7n74O79dIb/szqZ+k52X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hmOLgutZNfu7G2pO5fvrj4ZvOMsUwKcKsQdw/cz+x3cfTR9EfQXzpP9C+YvDFDf/q+tFNr4sBKGBjpOtMXrkZuCBt+MnrSLMJRfCXNg11kQln+tjizfFJfREEMi/QtkoZtmHVF+NdBjYW1t894O2S9QRff+8ch+n2svD6bJH+94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CW2ThGx6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733662958;
	bh=Rkince4SbmHoWAJI8yRTlw7n74O79dIb/szqZ+k52X0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CW2ThGx6w0Ye7p2Lg7pIrgqwMkxt4Dt23JeuCCrT57Xpb1EOUQ/GJnpX0UqFUCCih
	 NjEI11gL8LlwhUoKOT4ZoEpzzu+bS3QCHIDOeBlGomnORUFzjF2t2BSvqE3Na37o0I
	 Vc3sCoB2eHEPkNPuhTo9/5iW8rROCpxjh2czcABI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 14:02:33 +0100
Subject: [PATCH 01/14] power: supply: mm8013: use accessor for driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-power-supply-dev_to_psy-v1-1-f95de9117558@weissschuh.net>
References: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
In-Reply-To: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733662957; l=795;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Rkince4SbmHoWAJI8yRTlw7n74O79dIb/szqZ+k52X0=;
 b=Ljh2Qs+T1UwsJ32x2IIlbYlCEOb6R+oj6IyIEwVAx1rXuHMhZmCcl6lVsHx5V3VWhiLn8x3HV
 ZoSWn+N3RDGCiuYV4lpoeXmZH2IO+2ULQgVsK5nKcHQj1vudvuv120C
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


