Return-Path: <linux-pm+bounces-9800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD22913271
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 09:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97589B22D14
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096E014B07E;
	Sat, 22 Jun 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="szrI0ced"
X-Original-To: linux-pm@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32963B9;
	Sat, 22 Jun 2024 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719039910; cv=none; b=O0U6KEvbv0sAGt99KiEsVWHYQE8yREDDUnoRl+QPOIlebvvN6Q+IuTOGX6b7MEy0Va9QjpWchwnRic/bU892q9jeGNbWeTk0abAej8XCPkDF2oq5X2XO7BPWzfP4ab6y6hc+L/xqK8lwknaOiiqYDOzPgkRyyPXv3HgjIiQPHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719039910; c=relaxed/simple;
	bh=wl4Oh+/jcuV5dztmBE+rcwbtt7bJGwO1nNOfT6/79Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAO5tnE7qaon0htXd3k0XGZI8hPZUL6Dp6koZU6EI0D+IMt4KjwtAc7ywRzjks1fsr6d8OFBEPl2eugAZroySOiZgC9og6EW0y/Q1ffwpX9LH8k80A+R8y+BIvquwH+k/bTdp8af4N0s58FbofPEqv5P+kIAGN5niUp73Rc6Kn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=szrI0ced; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id KuntsjGzHYBZjKuo0snU85; Sat, 22 Jun 2024 09:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719039900;
	bh=nhyBkDq32jl+R9Ua8KZNEkN0tT+dJccJjgDIgm6fY2E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=szrI0cedmpJldS4Bv9xGHjPWpAQMq/jSiAj9474O8uIbPwoAkcsR0x7hvQsYHiULS
	 AaJerQLqJvwHfDd7zyJEijj+oU4M9FKKFG+tBADI07zW7rcZaSqpUxOOi48YKLNZ2E
	 oCxAur1eK5shGwNJay6VETSN373gl2+5OxVfuuV7jQbcAvLXnJ8zQy5d+s0T+st4bq
	 QudxjYzKRtSsmbDpLtIrBj7d4YsE9JAX0ZbgRHiprVf5NlZpt8nW0L5Tw1vQSxCAV2
	 7KHtXzc1xWbFWfHNR2715B/37wAgYU3r2keayduESZ9Rw8JAtau1rVK3IkT1EvVhbR
	 7GFjz/elkSNhA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jun 2024 09:05:00 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: linus.walleij@linaro.org,
	sre@kernel.org,
	jic23@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/3] power: supply: ab8500: Fix error handling when calling iio_read_channel_processed()
Date: Sat, 22 Jun 2024 09:04:24 +0200
Message-ID: <f9f65642331c9e40aaebb888589db043db80b7eb.1719037737.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719037737.git.christophe.jaillet@wanadoo.fr>
References: <cover.1719037737.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ab8500_charger_get_[ac|vbus]_[current|voltage]() functions should
return an error code on error.

Up to now, an un-initialized value is returned.
This makes the error handling of the callers un-reliable.

Return the error code instead, to fix the issue.

Fixes: 97ab78bac5d0 ("power: supply: ab8500_charger: Convert to IIO ADC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only, but should be fine because it restores the behavior
before 97ab78bac5d0.
---
 drivers/power/supply/ab8500_charger.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 9b34d1a60f66..4b0ad1b4b4c9 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -488,8 +488,10 @@ static int ab8500_charger_get_ac_voltage(struct ab8500_charger *di)
 	/* Only measure voltage if the charger is connected */
 	if (di->ac.charger_connected) {
 		ret = iio_read_channel_processed(di->adc_main_charger_v, &vch);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
+			return ret;
+		}
 	} else {
 		vch = 0;
 	}
@@ -540,8 +542,10 @@ static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
 	/* Only measure voltage if the charger is connected */
 	if (di->usb.charger_connected) {
 		ret = iio_read_channel_processed(di->adc_vbus_v, &vch);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
+			return ret;
+		}
 	} else {
 		vch = 0;
 	}
@@ -563,8 +567,10 @@ static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
 	/* Only measure current if the charger is online */
 	if (di->usb.charger_online) {
 		ret = iio_read_channel_processed(di->adc_usb_charger_c, &ich);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
+			return ret;
+		}
 	} else {
 		ich = 0;
 	}
@@ -586,8 +592,10 @@ static int ab8500_charger_get_ac_current(struct ab8500_charger *di)
 	/* Only measure current if the charger is online */
 	if (di->ac.charger_online) {
 		ret = iio_read_channel_processed(di->adc_main_charger_c, &ich);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
+			return ret;
+		}
 	} else {
 		ich = 0;
 	}
-- 
2.45.2


