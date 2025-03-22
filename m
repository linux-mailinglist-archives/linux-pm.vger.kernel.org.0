Return-Path: <linux-pm+bounces-24427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B9DA6CB69
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 17:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548AF17DBF1
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878D512B17C;
	Sat, 22 Mar 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhjl93T7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3872E338A;
	Sat, 22 Mar 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742660276; cv=none; b=MknZlK3epIUqoKKLC6Bg7ak68X0Cd+HFsdQbFWCM7yPIX1UxN/GfNjzkq/fPt5RmSe8TJsg9ToZhBXYl8/LOGnZla4w1mwGp6ow6KoDfcjmZe3agPw+78Yap5+WUDk/fbPF0sUuFfz8jQ6GqcZ2QEoDCNto1WeJS2HDPR5dTOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742660276; c=relaxed/simple;
	bh=AardSaMFs75OVIlKqdEsf4mTlnoK4d53ygJV4adwmrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThblcHoIp0hpP1+9cj4xGByu5OiNvbnEjyLUhSq588xNIRZPwhcauOpQyL9GlYJRpgxC0K7o6IyscZeros9AeGC8Hw/zKJVUkjwQcto0Ax4LeUi/x1jzzbQ+Z18wLEpRo5WkjdFoszExdYg9tntzyXW/AmYiLLsupeG9R/yFgBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhjl93T7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso20975555e9.1;
        Sat, 22 Mar 2025 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742660272; x=1743265072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ne0KR/Wc+NhwKP0jGJXiWDl4vOKs38NJ/GDoQe4enGU=;
        b=Rhjl93T7gammiCAnA8ySa21mITYNNq8RDv94eK/6MAgiatJqcQCCf2OY61zfKbaOqz
         YUrpGURIrSXUfLaPz3BL8ZpgcKBqO6vSv1ekox22pqzxeKz2n8Ob1mwtSPr0SDS8EMCf
         jvVTbkTr+Vf7MGibylun38GIkIhx9IL1cSI84ifJqvraV8+5goxzaQUc1StSbLo7J2+K
         Ux8cbiRlcrTzPcD/AFrN7yldW/D67yUVOhE6roHek1frfBZC3X08k5CtgednlQGvKfzS
         yvgQ5i+GI1B13+YFs3SDcduUAvmPDtR93txFt9yDVl2tWt7+XfjpwXfW58qvURk5B1Mj
         1GvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742660272; x=1743265072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ne0KR/Wc+NhwKP0jGJXiWDl4vOKs38NJ/GDoQe4enGU=;
        b=T7BqzI8f9YQJ3iXoCJz3718ioEpK+5NgBWSDJqmgePl2d6T17Us7GdjCwhHMZoGGtq
         9ebH6si6ISXk2uTuBsm9fOAQdxVF8GCnypEI1JMq74QjcxEBdmYdJvcTNOJ5VzWnvM70
         xASYfIjkmHVaxOtYp8Uw5weNjVemjWojL/mKb2F3HsY36nW3pdbbmGfIEUEsGkYznY4a
         Q9+B/XbMRHUVUKWdyZwf/i18vloPLb6dwr+lF+FAtQtlzcMQr7yeXgICHf1P1T2BCt71
         JPSHr4yc9YbmOSSzLjTCE/ZXL760iPQOw88JKsHlsS4XtjbXQfB+f/aHSMZbbgsBfH93
         95Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWu/9h4eqXRhn/DCRLPlk2T6XZWbFQD8y+ANqWfc7zu25tIxWePe+DMDtNAOkZaCfOiISqfbLc8TNBT/EE=@vger.kernel.org, AJvYcCXmcBThoKT+fEARKt2w4TTalZEaUwgCuYIQGlM5yUcihO91oTb7IneDtMdO4+PdjJEPZIRhqL8fQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2IYZor9D5f1hdD4ZJekdSBodfjuOU0G1qFBp5oJfoe77ae80
	ON1mcI3ELcR2L/vjQbaGDhSyW/ODD4tNBt3yP9YA5TVujEtKqvJw
X-Gm-Gg: ASbGncsa42n+oWgn/32JgOv2rJWKnrtodpFNp4oAk2qnTWguImfS/xbmqCrv9z+8BLZ
	WkProtHjFbDSZhZ9IuCyJd4OpZQntUYW9H4k/OVNk06I4bF6pRm/HoHTCHTNY+D+Wx9xT64ORJA
	OXi5mLV/QLctuuco2a1VxRgOW7tqqyzIIFtxQ+3nMDCHeUtZMZgDDZgliYNVOldG0ZFTrK5a5ee
	69BSOo5PApeFUReZf9gNsiTz3FsjttxyXOCHTxjk6hBqT6WreQaaThij+lO4gKxH5hZizrHDYd2
	3W9KedGq2V8HxciSB1u1ygWrNgzdukJwtNQH
X-Google-Smtp-Source: AGHT+IEv+RgmG+hFJdNYSwnip31w30bpwCQkYs9Xsubq5BBGnVz3tZWnMxcyEzCJ9SG+CTlcUSXnnQ==
X-Received: by 2002:a05:600c:198a:b0:43c:fd27:a216 with SMTP id 5b1f17b1804b1-43d52376b88mr62459555e9.23.1742660271635;
        Sat, 22 Mar 2025 09:17:51 -0700 (PDT)
Received: from tpt440p.. ([41.84.242.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed4cbsm112526565e9.34.2025.03.22.09.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 09:17:51 -0700 (PDT)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: hns@goldelico.com,
	pali@kernel.org,
	phone-devel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	akemnade@kernel.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2] power: supply: bq27xxx: do not report incorrect zero values
Date: Sat, 22 Mar 2025 17:43:31 +0200
Message-ID: <20250322161718.253093-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the bq27x00 and bq27x10 variants, a number of conditions can reset the
value stored in the NAC register. This will cause capacity, time-to-empty,
energy, and charge to report the value 0, even when the battery is full.
On the other hand, the chips provide a flag, EDVF, which reliably reports
the true battery empty condition, when these properties are really zero.
Therefore, discard readings for these properties if their value is 0 while
EDVF is unset.

Tested on the Nokia N900 with bq27200.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 2f31d750a4c1..8e5795c5754e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2107,6 +2107,15 @@ static int bq27xxx_battery_read_dmin_volt(struct bq27xxx_device_info *di,
 	return 0;
 }
 
+static bool bq27xxx_value_is_valid(struct bq27xxx_device_info *di, int value)
+{
+	/*
+	 * On bq27xxx_0_zero, consider zero values invalid if EDVF is not set
+	 */
+	return value || !(di->opts & BQ27XXX_O_ZERO) ||
+	       (di->cache.flags & BQ27000_FLAG_EDVF);
+}
+
 static int bq27xxx_simple_value(int value,
 				union power_supply_propval *val)
 {
@@ -2147,6 +2156,8 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_battery_current_and_status(di, val, NULL, NULL);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
+		if (!bq27xxx_value_is_valid(di, di->cache.capacity))
+			return -EINVAL;
 		ret = bq27xxx_simple_value(di->cache.capacity, val);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
@@ -2157,9 +2168,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
 		ret = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE, val);
+		if (!ret && !bq27xxx_value_is_valid(di, val->intval))
+			return -EINVAL;
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 		ret = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP, val);
+		if (!ret && !bq27xxx_value_is_valid(di, val->intval))
+			return -EINVAL;
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
 		ret = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF, val);
@@ -2171,10 +2186,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR)
+		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR) {
 			ret = bq27xxx_battery_read_nac(di, val);
-		else
+			if (!ret && !bq27xxx_value_is_valid(di, val->intval))
+				return -EINVAL;
+		} else {
 			ret = bq27xxx_battery_read_rc(di, val);
+		}
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = bq27xxx_battery_read_fcc(di, val);
@@ -2199,6 +2217,8 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
 		ret = bq27xxx_battery_read_energy(di, val);
+		if (!ret && !bq27xxx_value_is_valid(di, val->intval))
+			return -EINVAL;
 		break;
 	case POWER_SUPPLY_PROP_POWER_AVG:
 		ret = bq27xxx_battery_pwr_avg(di, val);
-- 
2.49.0


