Return-Path: <linux-pm+bounces-12383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DF5955752
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 12:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CA01F21BD3
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 10:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BBE144304;
	Sat, 17 Aug 2024 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT7htaDT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146913AA4C;
	Sat, 17 Aug 2024 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723891884; cv=none; b=aq+XkY9RAKAMNhCJ95ad4/Z4gNVH0PTHCL1MXzdqfigWXZaLzBkuRfv5wvm80/blGbu0Fcm4Q1hSXniSb9H7UJT5tJiW1oEtZ46RIHsACe65pqwgPYtr+/6p/ymoTrUUjBUs6NJ1nWWLYVgtRlcGELP0BV9wKk+mi+IaId/WXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723891884; c=relaxed/simple;
	bh=uLoOYzQPRrSIRoGlDl7dOmzB4I4MrNepJEy3xkLy350=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jxckmUD/W+yr2ZaqFE3BUt+20gI3Rt0ow3JvkSG9OUtoBLVm8PxJ95Y6fy3+1tneZLzRoQF+MPQB2ci6eVVdSGO3oT6Oys48mMvIhQXl9sh1tF0vZ41uDc4B3jxSBvKWOgY0EgQaGh/qlOPln99yd/XaKIB9ET0Q/0X/B8Kt1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT7htaDT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso28457435e9.3;
        Sat, 17 Aug 2024 03:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723891881; x=1724496681; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TK4QaE0PfcJ3+Kl/aP/anltlX14nLiwOatCWazNYV2M=;
        b=dT7htaDTxM8+A/cvIxgwvaSiNojcXHGlag/swSamS8ytrfDglxcxKJI+KV25mvdWfT
         yCG4GTX3b/WOEeS0dOxjnucYUXCJnBjERyQLQGyO1acnZNDBZKzQf0xfaY2JK4PtAlHR
         98IthHoo3eGdwtgeyVN7+Tyk1LfdqMu3oZnBM+yqwo66jLKtBP5rjGaz7VzaP97Yi4W3
         Q2qZqepFlnwWa+woV9EIwJV8wsY8ydunYXMH9nfETZ9imiExKNXzQBMgxY5qwYa8P7Kc
         xzgEESzlFByUPMkplzea36Ez9N0fLpLAoL1bLDAY8aourLaxCUWDerlSX7kDQdqEGQMv
         3oeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723891881; x=1724496681;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TK4QaE0PfcJ3+Kl/aP/anltlX14nLiwOatCWazNYV2M=;
        b=DYNzhuz50qon2Y6gShH2itYZV4pWf3XyygThetUQL6LCvtjtYNz17g3H1Qi7O1CF++
         Kwt4zRUq+SlyLpO0Akh1wFkqyG20h27pSYcAOhV6RBF2LhYshLi70UA3YiaEGGQI6FGn
         B50ng7wUVvc1mtU1zbHmJ43jlBZHYR1UQb7ICckpC4zKHCcCPxBbDvoOivjk0YigJtSm
         qyHPrAcO/7pUqsinGfwuuQVOonuKfh6KMecdl8wWxqYck51VesHl1WQ3DKPxbiq3pwrX
         cBu/DSUDVcSdDzJZ1LVgthZJBLJD4bW3srow7KkHw74PF5IiYrPralVNCANb5JSVJ1ki
         n6iw==
X-Forwarded-Encrypted: i=1; AJvYcCW8KU6GYDGQ5Z/jqk62op2RFTNnMlZtSnn4gMJHFogrARVGCRyA4MLO7pH7u2q8JpKFEFIbVUqEMEaEjpDDX9Ps8oZGtk/ewnTeGwli77s2yksgE1j6p/TOIsDiBQa66Ii3JJNRu/s=
X-Gm-Message-State: AOJu0YyCaKhnCLzxkIC1+P666eAB/cCpGj+YL0PUjSiLQGLhINZbHfrZ
	7IW6012rTHZm7jyDcdoEaUN7c/I4xxSJ6pXOvmLa8/m/+Ilp1bTO
X-Google-Smtp-Source: AGHT+IFz7OE1r94wpiTFu5fzPtfVegwzx7R9wztJ1meZm1RxrBltZau6Bs/7l9+5qZUMFJd7ELOjfA==
X-Received: by 2002:a05:600c:4f47:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-42aa6b8f345mr25896865e9.23.1723891880886;
        Sat, 17 Aug 2024 03:51:20 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed648ef5sm46579425e9.10.2024.08.17.03.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 03:51:20 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 17 Aug 2024 12:51:14 +0200
Subject: [PATCH] power: supply: max17042_battery: Fix SOC threshold calc w/
 no current sense
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240817-max17042-soc-threshold-fix-v1-1-72b45899c3cc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKGAwGYC/x3MSwqAMAwA0atI1gba4P8q4qJotAG10ogI4t0tL
 t8s5gHlKKzQZQ9EvkQl7Ak2z2D0bl8YZUoGMlSYxta4udvWpiDUMOLpI6sP64Sz3MhtNdvSVUR
 cQhockVP+5/3wvh/bo/hNbAAAAA==
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Anton Vorontsov <anton.vorontsov@linaro.org>, 
 Ramakrishna Pallala <ramakrishna.pallala@intel.com>, 
 Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2876;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=uLoOYzQPRrSIRoGlDl7dOmzB4I4MrNepJEy3xkLy350=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmwICmJJrC04ndO+rQpaxhYYVhmShdDkYlArCPh
 Im6MqU9tkiJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZsCApgAKCRCzu/ihE6BR
 aNrED/9MAPC2bpEgR/x+kJgAU6uv9CpPeK83J40BctxD7MhYbMXtXrk41yRMnt9ULYfhwRgFKzK
 9xqDyevaQeIsKpyieGWJb4lAxeKOwjw99GOAWF+esXDqI5etLIzU2IC7+BTShRXEvhh6m2kCNF/
 yXa0xDtn7czRWkgLncMth2/71qsM8FxcuLC0X2GJpO0a60czCMYOjzAsEfSOshJGMPcJ8ZuckDl
 ZIvaAZBHxlTTqan34I4QGDV0Y/6rDdyi8Fc7G9Y+YZxhuidFPYRyx9xYk25Rs5krXldXmUohJii
 TvcQ8p48XySAjmog9SpTeIOErpaW5p++nsmjlNX0tdC7AELUqS1ihhevv6NNiv2yu7Q9q4T4Zp4
 FJQlqDAYkL0CJGS3UPLGW+Qh9K8hQraADiWWoQjctc5FBM03A5Jd6hgDkRTHFuS853/K6bu7o64
 MR/uSBAh+na4PwBripqg6mJ/m6C4o9fUyLxyTvHdv2fvEZKZ2eZ8xlHqEsP+eJQkBnvOBo2xrjB
 7TjVSD6ESt9HD8pXYU85hFJ/qbQ6Klmstes3Rj7toyFvgNsY/93eJTi4CegavSgdKT6a7k88qjd
 35UHY4RvyoZGu4YbM6tBSV6/BbCcouv6hv7bpL429rorrVXEtYwoIPfw8nyJg86Zkjxv5eFX7Td
 IvFpoxn7QoY10QA==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Commit 223a3b82834f ("power: supply: max17042_battery: use VFSOC for
capacity when no rsns") made it so that capacity on systems without
current sensing would be read from VFSOC instead of RepSOC. However,
the SOC threshold calculation still read RepSOC to get the SOC
regardless of the current sensing option state.

Fix this by applying the same conditional to determine which register
should be read.

This also seems to be the intended behavior as per the datasheet - SOC
alert config value in MiscCFG on setups without current sensing is set
to a value of 0b11, indicating SOC alerts being generated based on
VFSOC, instead of 0b00 which indicates SOC alerts being generated based
on RepSOC.

This fixes an issue on the Galaxy S3/Midas boards, where the alert
interrupt would be constantly retriggered, causing high CPU usage
on idle (around ~12%-15%).

Fixes: e5f3872d2044 ("max17042: Add support for signalling change in SOC")
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Commit 223a3b82834f ("power: supply: max17042_battery: use VFSOC for
capacity when no rsns") made it so that capacity on systems without
current sensing would be read from VFSOC instead of RepSOC. However,
the SOC threshold calculation still read RepSOC to get the SOC
regardless of the current sensing option state.

Fix this by applying the same conditional to determine which register
should be read.

This also seems to be the intended behavior as per the datasheet - SOC
alert config value in MiscCFG on setups without current sensing is set
to a value of 0b11, indicating SOC alerts being generated based on
VFSOC, instead of 0b00 which indicates SOC alerts being generated based
on RepSOC.

This fixes an issue on the Galaxy S3/Midas boards, where the alert
interrupt would be constantly retriggered, causing high CPU usage
on idle (around ~12%-15%).
---
 drivers/power/supply/max17042_battery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index e7d37e422c3f..496c3e1f2ee6 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -853,7 +853,10 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
 	/* program interrupt thresholds such that we should
 	 * get interrupt for every 'off' perc change in the soc
 	 */
-	regmap_read(map, MAX17042_RepSOC, &soc);
+	if (chip->pdata->enable_current_sense)
+		regmap_read(map, MAX17042_RepSOC, &soc);
+	else
+		regmap_read(map, MAX17042_VFSOC, &soc);
 	soc >>= 8;
 	soc_tr = (soc + off) << 8;
 	if (off < soc)

---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240817-max17042-soc-threshold-fix-e96f15a622e5

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


