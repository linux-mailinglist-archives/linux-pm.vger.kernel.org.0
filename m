Return-Path: <linux-pm+bounces-9824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28007913807
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 07:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571D21C210B9
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 05:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99821426F;
	Sun, 23 Jun 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="avMDEYy+"
X-Original-To: linux-pm@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-209.smtpout.orange.fr [193.252.23.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D587FD;
	Sun, 23 Jun 2024 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719121918; cv=none; b=WWnHywJKBLEc23HKA1r4JR8JOWZzP6wffkoynEecNdTrOznbBrHny6vzM/taXwK6wTGj0J+iUfCiNhcOjd9g9MBee7I1fFA4BqcwhSfE4gnk2/55YIx1CBGfv1v45dn4FeJYDKUUis5WLrdAImSF+HcpTGjAlBFVr/QYgJRNwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719121918; c=relaxed/simple;
	bh=Cd2SyuRK9YrNE+mv9R88nDo2JxhCzCsvUFL6HwzkUHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMPl9mkoCjUYMogS7g+ISA4vrZZu1kxNb5i3IsfqK2yyx9ofFbaZz1oxokaKBb7GKBMDWj+GkVFIStN63H8fmuBVDtc92BR3n9alTs/+FMVN6XZpmLou1esnGuFB6IrZYJkWHiQoI/5ZIXqt90cIBp1SZ4WpyoLP59PD4NDue1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=avMDEYy+; arc=none smtp.client-ip=193.252.23.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id LG7csGen4jiKDLG7csmuih; Sun, 23 Jun 2024 07:50:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719121845;
	bh=1RAR2hjJePdFBRujGabmMIXRMO+LOncR48fid7AVn+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=avMDEYy+qFQyLB9kez5bH7ffN4XGNH4YwZMHZN8n4EB91X7D+73x+uP7OCYXReKJC
	 SaX5l4MiVpdvvVROtWr+eksb9P/xAAWvQeVR4QZKsP6p3uYxlphbUkkNEpCXknI9r0
	 YCw8V/Do1I/viuP3G4oDNO2tUD6ZZ0CQvs69n25ZTDyb36+oHL4kKmyuavWgYwOdDx
	 9p+C0X+/A9IOeCQ3pBl+CHL5HQwfxnw4hIXdFwCApH9Zw1h0nJxcyu6HAMJEEGdzRU
	 NYax7iLhzqYkxtpUhqwtop0p1Og45wDjMVqRGVxEM9EzQjtLL5YPUmowps8Wj4oOWd
	 SZV0WVORC5InQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 23 Jun 2024 07:50:45 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Paul Cercueil <paul@crapouillou.net>,
	Sebastian Reichel <sre@kernel.org>,
	Artur Rojek <contact@artur-rojek.eu>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-mips@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: ingenic: Fix some error handling paths in ingenic_battery_get_property()
Date: Sun, 23 Jun 2024 07:50:32 +0200
Message-ID: <51e49c18574003db1e20c9299061a5ecd1661a3c.1719121781.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If iio_read_channel_processed() fails, 'val->intval' is not updated, but it
is still *1000 just after. So, in case of error, the *1000 accumulate and
'val->intval' becomes erroneous.

So instead of rescaling the value after the fact, use the dedicated scaling
API. This way the result is updated only when needed. In case of error, the
previous value is kept, unmodified.

This should also reduce any inaccuracies resulting from the scaling.

Finally, this is also slightly more efficient as it saves a function call
and a multiplication.

Fixes: fb24ccfbe1e0 ("power: supply: add Ingenic JZ47xx battery driver.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/ingenic-battery.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index 2e7fdfde47ec..0a40f425c277 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -31,8 +31,9 @@ static int ingenic_battery_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_HEALTH:
-		ret = iio_read_channel_processed(bat->channel, &val->intval);
-		val->intval *= 1000;
+		ret = iio_read_channel_processed_scale(bat->channel,
+						       &val->intval,
+						       1000);
 		if (val->intval < info->voltage_min_design_uv)
 			val->intval = POWER_SUPPLY_HEALTH_DEAD;
 		else if (val->intval > info->voltage_max_design_uv)
@@ -41,8 +42,9 @@ static int ingenic_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_HEALTH_GOOD;
 		return ret;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = iio_read_channel_processed(bat->channel, &val->intval);
-		val->intval *= 1000;
+		ret = iio_read_channel_processed_scale(bat->channel,
+						       &val->intval,
+						       1000);
 		return ret;
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		val->intval = info->voltage_min_design_uv;
-- 
2.45.2


