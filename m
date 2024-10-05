Return-Path: <linux-pm+bounces-15192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E310F9915B3
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2121C1C21755
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748B214D70B;
	Sat,  5 Oct 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="S69peaYp"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C53149013;
	Sat,  5 Oct 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122691; cv=none; b=RaSXUc6rCqDkgtySEakpRlUyuNcBjisK88/MXaA+2eDJzWfhX+Kte6Q8GPwqZAKGqLhMkmDo7O6mQX3o8TkfAH5Wm3LJut90oD/g8glXc8bs3D20qXHUZSiJ/uZWmo6mo0IJOzWLjLaR1iOQm48sPTFtSmaLp8rz24Vx7Zj5wdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122691; c=relaxed/simple;
	bh=1aycd4QjgM3twjcHPu5RfSlFvnFJGjYZ0UUPaZfkKpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wy0PSUghnfhTm47mh5ekZ8f4FK/yLPNtWYHPGES6xhTC2rydNmYyacvy1fj07ovbx5SOs9Tfr+4sSsw6rhpKf6t3lvubZRRbw4++a+MQj1IU924yvCZ0C38BvQ+HZ+fTi4OX2PoEIXY7/bEqnweO049ZYteIWPQCkvGXK3U/7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=S69peaYp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122684;
	bh=1aycd4QjgM3twjcHPu5RfSlFvnFJGjYZ0UUPaZfkKpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S69peaYpHJAnEEIJgo43r3BppS9kiqF0RM1obBfUEifVUlnk7+hZBfmpMyO40FEpv
	 eGINlTHZkCQvm+8jG92/L1sly+ttFjtQgdyA4VcOH8y0xzSdjrtzL9g04n+/uNq/Z+
	 JdHtlaLr5Kf/YPvnWcQyOIWeqQdj/T58XYWGe12A=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:04:20 +0200
Subject: [PATCH 4/7] power: supply: sc27xx: use const reference to ocv
 table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-battery-const-v1-4-c1f721927048@weissschuh.net>
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
In-Reply-To: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122683; l=982;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1aycd4QjgM3twjcHPu5RfSlFvnFJGjYZ0UUPaZfkKpU=;
 b=8ID4HvF5nYm05f3Bl8tRwMYItx+s/IjINSd8wSzfMesTYQbsOFGFa55u+r9VkMxLl070BTNIH
 uxqF0wLHY9mDUqckKN8I81F5HcfuEENZnrNBJDkWDBEjlZb/nxO3sar
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The table is not modified, so constify the reference.
This enables a constification in the power supply core.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index bd23c4d9fed43482e972ccc086311e7bfcec2d54..426d423b935b581a7673be076ae71b8899f17e2e 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -992,7 +992,7 @@ static int sc27xx_fgu_calibration(struct sc27xx_fgu_data *data)
 static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 {
 	struct power_supply_battery_info *info;
-	struct power_supply_battery_ocv_table *table;
+	const struct power_supply_battery_ocv_table *table;
 	int ret, delta_clbcnt, alarm_adc;
 
 	ret = power_supply_get_battery_info(data->battery, &info);

-- 
2.46.2


