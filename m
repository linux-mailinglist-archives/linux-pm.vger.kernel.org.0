Return-Path: <linux-pm+bounces-23915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8897A5DC73
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 13:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0601897679
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8D023E259;
	Wed, 12 Mar 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byQehigK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE31DE4CD;
	Wed, 12 Mar 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781889; cv=none; b=Yb9hQtrq2NIN9M9QY4L8EbNd3l57pa/416Kd6d4EJlyVS9/diZnkpBnJphNgbU7P0DkFRgBmM+EyzUXlmfCRFxGVplCB80ameEMRRRh8AmYvd0sxAIsBSN2OQCd+jKdPkYqD/HnAq/UZgu82iUbZHLNaIzMX51AiSbQi9IJwYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781889; c=relaxed/simple;
	bh=I6WyCOT4N3CVW9SmcgROuu4zAmQtkq040BcPAQTYdeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H56iHrCB+sHYHmNNnJQGamZazPQR1EIXiVNRyAy/DuGl69vpAI45ONwxldgN6FVG/Y74V9ULQOIyhcem5oGot4uMOiSHjTfxvNo2jpTdpJNEwMEa9FJj3lBtNKZAr195hhqzyem9ec2rcbk+Dnx0+3tu3Sog++ZNe/VkLCJfFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byQehigK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so292958466b.0;
        Wed, 12 Mar 2025 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781884; x=1742386684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdMjUYe6z3VR75a+sCY2beOBEfi9qqLjrghKLfqKu9Y=;
        b=byQehigKU1imOeTFjD1FA3kOFkTMxeOtaScZS80/bp3CMm41SZ1y41tubm+TM6KdjY
         mNPk3uRBSYrW+L6ALncESRE5k1MJzGSVEUq3JtFZff9nzHkZKlS/VV79gXN9j50o9rSV
         YXNmL3XjcIZDmIhufwOj4+wZ+UKHZc++g73tfM5vb1tO5MqLQZbezCzv5w13OUUWxZKI
         MpPDGoULBIkcokJEXe157bfnS5MkTeb4jrNYPoYFIahiJYlyGBP0TKp7zQtzTPmoZIh2
         3SyWo33FKeHT16kttfoBJchBciB3QMNM4XW5uUDE+qAlK7V50EfjSzKHFhF4mZkhOnLL
         dB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781884; x=1742386684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdMjUYe6z3VR75a+sCY2beOBEfi9qqLjrghKLfqKu9Y=;
        b=Gi3LeQ99F9/xCslJWkAAA5kVjF5zjU4QHHNdGcYMVZB18dfBhE0Yud8Z5Y+HZ9ECeW
         gZML1ZO5pxSI2se613ujuyqqlCjabfu7KLDvvApJsp1fYg3Gblrw/0J8OFfzj3tTAHJw
         sVCJnNHTErABUgSOP++TG38IE0cCD1LEalS5RVMdYQlZYjtOueH0WB1FDsZJeRDPyl8k
         SL4ILjyof8dvE0eX8pPaWj+NPCcV58zImfAE2cl9pPw63+g1tRdzp1y17chXsQ4+JA6+
         QGv8VbUqrYhyk6eY9YviFpXwj/33aCoeN6e4Tomv7AA/uP2cL1/sxCv8k3hpwY1BeOVG
         k7vA==
X-Forwarded-Encrypted: i=1; AJvYcCWOFlT3uO9Sqf4cPXh/yI48Xd0TmhkXsKSrQN+XxXAktoUGCKRqyGcLnRpfbZLZSvilZDqa7GcXyg==@vger.kernel.org, AJvYcCWkLjmTCTxfGxPjEOPzgf2Xh8WJc62MiYiV3ciriaYazgtHgaefxYFcvdmRpnsWRqTR14JcDASnaKaWY8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbhSBjGxzcGH3YVx7BhkCHVYGVm/lXs2Ep0nsjq8av771kjj9q
	FJIGGp9SAZdesgcpZ37DSCbMan1tzrBv6q8IZ7KAI8QFOKA84doS
X-Gm-Gg: ASbGnctawSjWiqeo/r3tWIBYz0VQ6emm8aEOp0pkLP+BSQuTKdo3MAjOKMAtn3qjkf+
	uj75SX5pub1afr8i1fg0aWGHh+6gRyTguTAfqrkVgOlYnQFVOB0ojAnEmxmFgfvJI4CKsR4qiZx
	ZR6dUL3xIEis54FI4lO7roU9eADubsxt6UDvtny+U0rxXDjlYvRfJEYzicxv9fxf/DfaDSnG/kq
	VCW5NpgatW98JyengsGhXsg9EmzccPOzryvxiR7hW6Gy/CiuMoSpS4ZwZxa6CclF9/y/Kstr8fU
	3/Q8LiCd7IYu6mV9zt8LCptMDplf13xOCb9jmvhZq2x1
X-Google-Smtp-Source: AGHT+IH6U8yxqAbx+DKK8vPNl6FS2aFT8qN6zmAUBfpbIyULWVorT14l2kOVR8iryvAF2CIy2egsSw==
X-Received: by 2002:a17:907:94c5:b0:ac1:e752:17d2 with SMTP id a640c23a62f3a-ac2527048bdmr2251962866b.19.1741781883993;
        Wed, 12 Mar 2025 05:18:03 -0700 (PDT)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac28847a0a8sm623586166b.119.2025.03.12.05.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:18:03 -0700 (PDT)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "H . Nikolaus Schaller" <hns@goldelico.com>,
	pali@kernel.org,
	maemo-leste@lists.dyne.org,
	phone-devel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	akemnade@kernel.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 1/2] Revert "power: supply: bq27xxx: do not report bogus zero values"
Date: Wed, 12 Mar 2025 14:14:08 +0200
Message-ID: <20250312121712.146109-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312121712.146109-1-absicsz@gmail.com>
References: <20250312121712.146109-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f3974aca381e ("power: supply: bq27xxx: do not report bogus zero
values") breaks property reporting on chips which are reporting normal
values. During testing, excessive emphasis was evidently placed on the
chip with non-working conditions, and not enough testing was done on a
battery that had normal state.

A correct fix will be submitted in a separate patch.

Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Closes: https://lore.kernel.org/linux-pm/CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com/
Fixes: f3974aca381e ("power: supply: bq27xxx: do not report bogus zero values")
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 1789167c68e3..2f31d750a4c1 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2148,10 +2148,6 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret = bq27xxx_simple_value(di->cache.capacity, val);
-		/* If 0 is reported, it is expected that EDVF is also set */
-		if (!ret && di->opts & BQ27XXX_O_ZERO &&
-		   !(di->cache.flags & BQ27000_FLAG_EDVF))
-			return -EINVAL;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		ret = bq27xxx_battery_capacity_level(di, val);
@@ -2175,15 +2171,10 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR) {
+		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR)
 			ret = bq27xxx_battery_read_nac(di, val);
-			/* If 0 is reported, it is expected that EDVF is also set */
-			if (!ret && di->opts & BQ27XXX_O_ZERO &&
-			   !(di->cache.flags & BQ27000_FLAG_EDVF))
-				return -EINVAL;
-		} else {
+		else
 			ret = bq27xxx_battery_read_rc(di, val);
-		}
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = bq27xxx_battery_read_fcc(di, val);
@@ -2208,10 +2199,6 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
 		ret = bq27xxx_battery_read_energy(di, val);
-		/* If 0 is reported, it is expected that EDVF is also set */
-		if (!ret && di->opts & BQ27XXX_O_ZERO &&
-		   !(di->cache.flags & BQ27000_FLAG_EDVF))
-			return -EINVAL;
 		break;
 	case POWER_SUPPLY_PROP_POWER_AVG:
 		ret = bq27xxx_battery_pwr_avg(di, val);
-- 
2.47.2


