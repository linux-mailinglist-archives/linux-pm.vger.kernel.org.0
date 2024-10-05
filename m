Return-Path: <linux-pm+bounces-15188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A599915AB
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FAD1F22D9E
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EC3146593;
	Sat,  5 Oct 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TaJF7eIB"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC8136349;
	Sat,  5 Oct 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122689; cv=none; b=O5U6nVgvnZxpL7OY5NQOsNiIkJOl4ZdSMzxb3nUgsLM64YksDv8+O5g+xMRTQFLTuWoZEWTKG6+04Ps8pM3n/eqANp13vq2iDbfOlPZD0IfJSWAY8JPTeKTjmJ2nycHnUGD6R/IrubF7GAF7bvzhrDi19IEuKE7GnP+LJbIEXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122689; c=relaxed/simple;
	bh=AwYwiT2DeM2wVq1UwoseCa2sO84nhlWpq31txXWMSQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E00BoG4gSZpFepXGxdvJVQ0vhmvD3c6BGDPkYv+rrocqSQzkXuLsfihQ3hPyQsUuR2rlXkLFXWIBzGGpyzuAVRIl/8m5gJ78id7agUh7LvvN1eFRNc9NbXmapvwcGDATNEGQ9d4VQIiO9+r5WeWb3Lx/v80S8+UisXdjH+NyrLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TaJF7eIB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122684;
	bh=AwYwiT2DeM2wVq1UwoseCa2sO84nhlWpq31txXWMSQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TaJF7eIB0+nzM2l5m6N4sVRy8C7mdn/Otg/147qaEivoRYvXabb81daAcfZC9kqE2
	 tr5z3taDitdzrQHSHDGJE/EqdozU4fUZ6SqRcYfh6tbMdZ0TwQUMGiZbZhm8AtJPUM
	 Bg/oAC9INA4Lcxef1/1ataOoOKPayORp3V2lbtcE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:04:19 +0200
Subject: [PATCH 3/7] power: supply: samsung-sdi-battery: constify
 resistance table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-battery-const-v1-3-c1f721927048@weissschuh.net>
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
In-Reply-To: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122683; l=1114;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AwYwiT2DeM2wVq1UwoseCa2sO84nhlWpq31txXWMSQE=;
 b=qmXj7XvxaS6SK4/Sp2D3XOW7fmip94fNft/oIVu1Db0RHo82w4sTF95qCTAHgGy1Kq9Ko3Erz
 1VoEUftrA6qBCGRRt9sk2sZsiHLon4dGrm//jU6H6NZG+aMpW53X1XR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The power supply core now allows this constification.
Prevent accidental or malicious modification of the data.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/samsung-sdi-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/supply/samsung-sdi-battery.c
index b63fd2758c2f13f35d9e2ae5e8ebf25d92f847dc..263592d625837e3851ccb30b4cf1272139ee923d 100644
--- a/drivers/power/supply/samsung-sdi-battery.c
+++ b/drivers/power/supply/samsung-sdi-battery.c
@@ -431,7 +431,7 @@ static const struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb58515
  * temperature compensation tables so we just state 100% for every temperature.
  * If you have the datasheets, please provide these tables.
  */
-static struct power_supply_resistance_temp_table samsung_temp2res[] = {
+static const struct power_supply_resistance_temp_table samsung_temp2res[] = {
 	{ .temp = 50, .resistance = 100 },
 	{ .temp = 40, .resistance = 100 },
 	{ .temp = 30, .resistance = 100 },

-- 
2.46.2


