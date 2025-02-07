Return-Path: <linux-pm+bounces-21567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1333BA2D049
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 23:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2E1188B25D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 22:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7690019CD13;
	Fri,  7 Feb 2025 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4y8jdak"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019142069;
	Fri,  7 Feb 2025 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738966000; cv=none; b=pZiMfgEI/rbI/EWlKyv6wRcpx888TLU6UvxSXoxWB0SddL9SLi6nUV68f8Iyocd2gQb7ZdTMLP9fhZd3xrymn6dhyBAGXQrdNGoqNoVkEZgm2M5p9HM6A+L0qVjaftnKQorrpwXs5OCgnk21wCiLIPlBP3u5m7c88YkkHoUyBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738966000; c=relaxed/simple;
	bh=EHOF8qxEeWu1AAZ8lA3fALF37aBiezOJWkMKXsxxC2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ys1L2OxSNXDTxN8cYKpmsCHi+jOfpBxBmuUtlOaxpPG1YiEcDrmYOikyjQUR7nFo78knxLEWcQ7GcPmA74fpFGMbuglo6A/7dNt+gmghB76eHFIqheU/TRxz5ra/P9NehLHKBnBCgeP6IMb+2Aao67OhRKkXv20Gk50YyLHxLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4y8jdak; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so1207566f8f.2;
        Fri, 07 Feb 2025 14:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738965997; x=1739570797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jd6cvBCs1rpexfQo4U0YDCbJtmUP8+nkDyDnWTfu5y4=;
        b=j4y8jdakQyoSkX0kN7sahdvVQPrPytzUgLT+aEwqkgx/zJhOjyMBk0LHtkXUGz7v21
         /QFtJHRYocVPx6K6h0F1ZSE8d404a2y9gpiZfZY1xv9sJf3TTRID/n9A9qhmO3RzEUrv
         F9gGCvDa3Fgg93fpWrmlhDQLoWnkhYjLG5nvEWSGQjYpLOY1dilTtKVV5z5DbpEU6x+9
         RVKfO9a8K2VAIwRXm2kSHraBcBzeccaIEtArYgubV8PZJNoGAjZ4q04pOPOm+s3yx+xm
         ChUHvM/+CLVVKjEIutQezjeNVyeZEp4DeitElto0CqiOinKElF3tubDyQ6RJ6Qf5Xy2Q
         kdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738965997; x=1739570797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jd6cvBCs1rpexfQo4U0YDCbJtmUP8+nkDyDnWTfu5y4=;
        b=Mzv3CVZMHJKFIjOOI2ov7u+u548rfCBEgrIBfV+Ln/+t+6i4kqNbV+X1sbIgi7OkS4
         bzo/dQ5z7DA5nLxY3spiiuczq0Lvn0YLXWP0wmC2VOLNxa8Wcnaaj46JRvLUhBP5Mu65
         yiJ/1KJRdl+tAVPTuEdU03oIBRlmQgjJAi/sdpXjfvVvT4OLCfgmZqV66NlmkvcnUYQk
         fBuBK/SxnWKJphAltON7lVKerxniWaD6/ieZ4S9DJcll6UUIcDAzIm7HyBVdphItKep7
         R4lhRwEktCF5wdgK+gjGERbJlHlL/FZzdYTfLBChr1zylog3i1Lx/N7Lke+0iREbwrDx
         AdSg==
X-Forwarded-Encrypted: i=1; AJvYcCU7vSjyJyA8I619lk6t0/TYVfczAkwV+0q8hYkDkUod9HZi5yf/v37vRWS7EdYWfxR9qEfM+BRJIg==@vger.kernel.org, AJvYcCXWZNrS0oYt+u1dHmQHkIGfmeeylfGo1jVo+GpDZZkdzVAWk/rRU/HQBwY0gxMbYrtKkuFKPtp/PzQ4LrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysEsJ7u2wfZad4sXV+yOsMzyzeurV/EQOpiOZ96yC7ZjS0OeqE
	BHMW/5L+tNynqtuLrZuDcBcIPiwpGWLw4vV7RaloJHok6MQLCF0d
X-Gm-Gg: ASbGncvInQuOOQCvL+sNYJ0GErVXku0cL7RudNmY2xURyu4uWdBS9o/mwvuh7Mep8RM
	QMOG3QNMUcZ8SMq52gOX/YlKkCFeaiqP7qWGop5PtYxa1zNMIw0OX0j37czS8JxRs9pvpPCsM7b
	n44iX0E5Vv2370oUo90Ga1NHFuH2q9bn+maojPnA6TFAy2f36ih5OOsRZaEDFcyLaE8ZGBhNK2F
	eMlzEER59DLRw5q+/32QE25rVSNGj2gbvmrKCOAiNqYwNbzqmexvIRA1RrXzTcuC1JdzqSNi/oL
	b8XNkJk=
X-Google-Smtp-Source: AGHT+IHZzvfhCWkQ3JZMCqN9v83K6xwyhBDtL4/NrRPlNX0cqbcIt742xyWM2LM9ag3Y1m2w40XTUg==
X-Received: by 2002:a5d:6151:0:b0:388:da10:ff13 with SMTP id ffacd0b85a97d-38dc8dcbedamr3140378f8f.21.1738965996756;
        Fri, 07 Feb 2025 14:06:36 -0800 (PST)
Received: from tpt440p.. ([41.84.244.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca0041sm66294405e9.14.2025.02.07.14.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 14:06:36 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: pali@kernel.org,
	sre@kernel.org,
	linux-pm@vger.kernel.org
Cc: maemo-leste@lists.dyne.org,
	phone-devel@vger.kernel.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] power: supply: bq27xxx: do not report bogus zero values
Date: Fri,  7 Feb 2025 23:51:44 +0200
Message-ID: <20250207220605.106768-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the bq27x00 and bq27x10 variants, a number of conditions may reset the value
stored in the NAC register. This will cause capacity, energy, and charge to
report the value 0, even when the battery is full. On the other hand, the chip
also provides a flag, EDVF, which accurately detects the true battery empty
condition, when capacity, charge, and energy are really 0.  Therefore, discard
readings for these properties if their value is 0 while EDVF is unset.

Tested on the Nokia N900 with bq27200.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 90a5bccfc6b9..df92f55c63f6 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2115,6 +2115,10 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret = bq27xxx_simple_value(di->cache.capacity, val);
+		/* If 0 is reported, it is expected that EDVF is also set */
+		if (!ret && di->opts & BQ27XXX_O_ZERO &&
+		   !(di->cache.flags & BQ27000_FLAG_EDVF))
+			return -EINVAL;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		ret = bq27xxx_battery_capacity_level(di, val);
@@ -2138,10 +2142,15 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR)
+		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR) {
 			ret = bq27xxx_battery_read_nac(di, val);
-		else
+			/* If 0 is reported, it is expected that EDVF is also set */
+			if (!ret && di->opts & BQ27XXX_O_ZERO &&
+			   !(di->cache.flags & BQ27000_FLAG_EDVF))
+				return -EINVAL;
+		} else {
 			ret = bq27xxx_battery_read_rc(di, val);
+		}
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = bq27xxx_battery_read_fcc(di, val);
@@ -2163,6 +2172,10 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
 		ret = bq27xxx_battery_read_energy(di, val);
+		/* If 0 is reported, it is expected that EDVF is also set */
+		if (!ret && di->opts & BQ27XXX_O_ZERO &&
+		   !(di->cache.flags & BQ27000_FLAG_EDVF))
+			return -EINVAL;
 		break;
 	case POWER_SUPPLY_PROP_POWER_AVG:
 		ret = bq27xxx_battery_pwr_avg(di, val);
-- 
2.47.2


