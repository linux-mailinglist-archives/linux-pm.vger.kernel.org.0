Return-Path: <linux-pm+bounces-15204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A24E9915D5
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2FCB23B36
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA39914D2B9;
	Sat,  5 Oct 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="M4A1qthn"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D29143722;
	Sat,  5 Oct 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122794; cv=none; b=qZUMCJfg13YkWR4aOoljZZHelPaFTRSsIF1HaVbIAFlX9LqbQ6vQZoGsLF6HRkoqec0Hqlk5BzQO//Kr+MZG7iO0KVuY71qaHioCL8VV0w817gctIwu7Sbj43h6G8kvi0vkivyobJSQJEB14xmr/qe0Eh1ZAhJZHE0hvRxVmc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122794; c=relaxed/simple;
	bh=rQqJk4dyO0+vcBE042JZaU+PemfPpi5XskxKiPeoKH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDk8oDl5RL9kDse489kZsfOZ5pUW6iSrQ1DBDwEZcbx8BQ/S6HLwHPVIxacvCev0NqTPh0JBSuIfU6DkQDQbPvMKu8020J3+urG7Xyocrfux8iPqITCy2wENs1VhLnW0KvuaDXscYMuI9/F3jnY89sf3HjrPSKjP6Xl8jSiaMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=M4A1qthn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122791;
	bh=rQqJk4dyO0+vcBE042JZaU+PemfPpi5XskxKiPeoKH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M4A1qthnEe6R9V3fRwtv2JJhQtNADyH48dz9ZIvvxI4pSPwuetlz5KF499o7QnG38
	 Qfsoe5K0kUKgiINh4kjUpjvxa0N9wNGT4q8/t3KAIZkPBJzk4VWMQvMTiceAExzjm5
	 GyM2UlD9LGsD7FHco1t7K7fo+5zNSi/ADOUH4iDs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:06:15 +0200
Subject: [PATCH 1/4] power: supply: core: use device mutex wrappers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-cleanups-v1-1-45303b2d0a4d@weissschuh.net>
References: <20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net>
In-Reply-To: <20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122791; l=1155;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rQqJk4dyO0+vcBE042JZaU+PemfPpi5XskxKiPeoKH4=;
 b=ilW1nhcHjJI7VD50fAviaxeuVWC3BqFooOZLwGFtFGpvGpDnl27HbnGjbYE7w08ugPexIEipq
 yf5FGpVC/9pCkyBoMcgWcs/DVUnzr0+3OAnFnjqRkxVgySMUdMXB/Ah
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The mutex is an implementation detail of struct device.
Use the dedicated wrappers to access the field.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 49534458a9f7d3f6d7c01bd91fa1bb6ed23bc7ad..c4608c60f7de2618941aae6e345a413ee249c0ae 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -152,7 +152,7 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 						deferred_register_work.work);
 
 	if (psy->dev.parent) {
-		while (!mutex_trylock(&psy->dev.parent->mutex)) {
+		while (!device_trylock(psy->dev.parent)) {
 			if (psy->removing)
 				return;
 			msleep(10);
@@ -162,7 +162,7 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 	power_supply_changed(psy);
 
 	if (psy->dev.parent)
-		mutex_unlock(&psy->dev.parent->mutex);
+		device_unlock(psy->dev.parent);
 }
 
 #ifdef CONFIG_OF

-- 
2.46.2


