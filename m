Return-Path: <linux-pm+bounces-15189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6F79915AC
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FCAB217B7
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA451465BA;
	Sat,  5 Oct 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MbENSiQz"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2445136337;
	Sat,  5 Oct 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122689; cv=none; b=RT7zPRX0SonWp4XXb3yrJslYYU7nF3zeCONOCXhjwOVcS4ew+3/ioBHt8ZEyTZp5zRNdJ+1rYmkQSi8QxyooaLPTgjAe3V/GMv8V2YNhbQZAr5Dy4G0wogdu2U9fljg4qjQKaOQTdBQbrTjgy4/DtvCB/yjfBaSfu0RzPQ2UvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122689; c=relaxed/simple;
	bh=+l2pGuOAnlI1p5kUoYdQR6K905nYeVw99+tbMlmF4S0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApEcIcmrt5qcTo7krjJh25i6YsqrDWzI+x67l6ZuVKf0D8tbN+47BLIcl8ZIG9FNw7W7eOLsoTWBYVj4zE31GjvQAKnIVaAqOIk6Btr9dtGVsGK4pq2sfL+aS5b4nfTlkkGd1ZutdrqdjD1vpeRbMesHG/vIQ9LJQNEinIYzfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MbENSiQz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122684;
	bh=+l2pGuOAnlI1p5kUoYdQR6K905nYeVw99+tbMlmF4S0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MbENSiQzNmRJBB5dFqpYyW0CUm5DoUJICB/7xn9ihkixHYf9wzd475tSXDwDLTkSU
	 G0Wqvimtzu9gBMA51PtCzq29PJ70oWjtQtphKVXIIJBeEn/EUxbBJgXc6Uy8o8zxOR
	 whrLZNP6INwXLxO7S7ANZKwiQEWr0wTpS4tOgOZ0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:04:18 +0200
Subject: [PATCH 2/7] power: supply: ab8500: constify resistance table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-battery-const-v1-2-c1f721927048@weissschuh.net>
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
In-Reply-To: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122683; l=1125;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+l2pGuOAnlI1p5kUoYdQR6K905nYeVw99+tbMlmF4S0=;
 b=R8Pla5NqT6Y23irNX/MFV7AxWBIQUfi3KOdQSyGqD2FBVHOFE1lN6auREKfih0sd82apgRjd9
 eREXhH4c65DDCHt9knioh/uvfK/Zh4FNJ2c8kI6azp6cbFEHKtb7syQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The power supply core now allows this constification.
Prevent accidental or malicious modification of the data.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/ab8500_bmdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 3e6ea22372b2dca319779ae067ea578f03f21674..2fcfbbef050383eaef461ec2e8191e9b269305ff 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -48,7 +48,7 @@ static struct power_supply_battery_ocv_table ocv_cap_tbl[] = {
  * temperature values to work. Factory resistance is 300 mOhm and the
  * resistance values to the right are percentages of 300 mOhm.
  */
-static struct power_supply_resistance_temp_table temp_to_batres_tbl_thermistor[] = {
+static const struct power_supply_resistance_temp_table temp_to_batres_tbl_thermistor[] = {
 	{ .temp = 40, .resistance = 40 /* 120 mOhm */ },
 	{ .temp = 30, .resistance = 45 /* 135 mOhm */ },
 	{ .temp = 20, .resistance = 55 /* 165 mOhm */ },

-- 
2.46.2


