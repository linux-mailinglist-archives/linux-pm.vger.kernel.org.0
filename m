Return-Path: <linux-pm+bounces-23916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32AA5DC74
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 13:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0548F3A91DB
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0324169E;
	Wed, 12 Mar 2025 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH1IwRsK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF71D63FF;
	Wed, 12 Mar 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781891; cv=none; b=OEolPMQXzv4wPBLD453/eIFxa7KPA6rlwEjoa0606oABdrUlhZ0vcAv+UxdT/rW9zqaZYxDjGQdrkWszBxFu8h0frqlwBiz/dMPejAtKCn0Db4U9pCtZ1clpfSCo8FybpJux1EDTVrK/UbYt1bG+WVBY1X0/4LZ868lF3c5TPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781891; c=relaxed/simple;
	bh=WFKIG6zmYSa230Bnniy/WhtYYpdFl9deSsZCGgo/9xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lypds40rOa+OLTeXmCLN1JFFnBTPzU+4TlDWZ2BQbZgPlcZD1tnsZCVNX0n5Jvxk++0y1DneBRGsIjNhJR9jkY/bKjbjEzoysO4pijkdLZLLxSZqglkOELPjceaTWuJicIFn7d1NQv3ZWbDlzxivhlTmvWnEn2lIVcUTvt6JDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH1IwRsK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac25d2b2354so862341866b.1;
        Wed, 12 Mar 2025 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781888; x=1742386688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=107bmZRVK0IMwHXR09idsLvmbf+ZbZ5kB0kyd5notFE=;
        b=bH1IwRsKlIDSaJ0MEt7Dnu70eHta81KROT4RTLINR9/SBfZE0VWLtYpduRDDgMjaSd
         ktlruA/mCQ2OlVI7AFOY3T0CmmgbTeG8KXXiWfgQMo504Sm4zBNJoR9bMgDcM8/hv101
         PFzYu2lSR2P9HzPRnGIBjci+n/M5ZnSV7rV06PrMze+EvVyUKJOR6eDxRlk1KUi0xE9H
         AgCcUR0CyK++tSILLcqD3/T/urMNWaRelBakC9Xa+xJrxwCUaGVodAxUD7KfetiA/2Ec
         k8zb/pRrJyKAVFXjDVNWfNhTVki/oaEIomuzPZ57u3W0Y3tvPKtxKWazTKIDuGrOFDoe
         olqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781888; x=1742386688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=107bmZRVK0IMwHXR09idsLvmbf+ZbZ5kB0kyd5notFE=;
        b=myPXLPOGZpaI0UFJCsBgYtlZ3h5f0Wkt+SlbDpJvh9BOYzNuYI4z61F+3fhP8aZMAx
         30g+zAaxweV7MiQL8r/u0cKIKaTB94LYfUmxpQZ0+B5dzcYMPVZm0r/YWg3sVcZsVU7X
         N2DQeYt58rM+Cw/FKprezpwYwI1QLrtQc9ooIYaBn4asz1Yp92RvMmkmOPomxmsZLLan
         wc68M9f+P3TemG3Bmk/CiPJ99efeSIXK17vtWQxjFn8r/dM0QixIZJv6y5y2e5FYVpEN
         ynIVSOABNIpVVDBa0rJ1dDCR8yYPChZ3GaWoaNPFVWMLc1LFw0Co0IuDAmbBGIaoOLfj
         4hOg==
X-Forwarded-Encrypted: i=1; AJvYcCVomjjsZVwM163kxeEQ3VvrD8grTbU14BGZCHdfF3Hv8N33dkzTYpaYChRSyQRMje2p7ESG+j4TZzxrOag=@vger.kernel.org, AJvYcCWDRwWvQ2exW0FxpGVi18nfU7RejuKKY6r11C19u/cQRI4nJf7HcezYyU+bShyv6QQ9ENyEOXTF5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12KLjC8DHHUtTKW/v9/HQgiilHoCZgh98NFHXZMnHIogvbSRw
	ge3g4DNfMpGADeHz8MhJGJUMEvTlDwfwfM94dHZNbg+rA2Od5r0U
X-Gm-Gg: ASbGncug0UtlHDRA+W8vARyBRpZHCbJ6AbmfblBZHWi5PKPAuYPdUHlSgKPo263uAaR
	UuKBhRERMo3gwFfpFxfVSC80mzJo7b7JpflLMT0KCIt9RtFkEcDLy0DNCqurtItlwCPx5+o4IhN
	Zn9J89IZhZnzlWVwu+9AtE154P1CbfP8puTRzkgnu0IqDHfkYqRCxmS+bgFOvGRj+8dkFcm0Y+b
	of8o/rTcAOc0jK1ustZ0e8j4bbWS8cIon9a0PQ6arzUhS2uy0gR1Q9P0pOyRyidlYFoQOcGPsbS
	fJpQ3GroTY0rq515qIEPBBG8rnllSzLFZ+JiQ+cUwjrP
X-Google-Smtp-Source: AGHT+IENOU3N7qB/5mOZ66HTHXmgIpnkCj9+HZrI7hxNC0NhCXzLtTT3E3TWoubnsFWivKyxp4dn1Q==
X-Received: by 2002:a17:906:dc8b:b0:ab7:6fa9:b0a9 with SMTP id a640c23a62f3a-ac2525e0417mr2882460266b.11.1741781887704;
        Wed, 12 Mar 2025 05:18:07 -0700 (PDT)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac28847a0a8sm623586166b.119.2025.03.12.05.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:18:07 -0700 (PDT)
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
Subject: [PATCH 2/2] power: supply: bq27xxx: do not report incorrect zero values
Date: Wed, 12 Mar 2025 14:14:09 +0200
Message-ID: <20250312121712.146109-3-absicsz@gmail.com>
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
 drivers/power/supply/bq27xxx_battery.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 2f31d750a4c1..29fc51653b5f 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2147,6 +2147,10 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_battery_current_and_status(di, val, NULL, NULL);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
+		/* If 0 is reported, it is expected that EDVF is also set */
+		if (!di->cache.capacity && di->opts & BQ27XXX_O_ZERO &&
+		   !(di->cache.flags & BQ27000_FLAG_EDVF))
+			return -EINVAL;
 		ret = bq27xxx_simple_value(di->cache.capacity, val);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
@@ -2157,9 +2161,17 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
 		ret = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE, val);
+		/* If 0 is reported, it is expected that EDVF is also set */
+		if (!ret && !val->intval && di->opts & BQ27XXX_O_ZERO &&
+		   !(di->cache.flags & BQ27000_FLAG_EDVF))
+			return -EINVAL;
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 		ret = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP, val);
+		/* If 0 is reported, it is expected that EDVF is also set */
+		if (!ret && !val->intval && di->opts & BQ27XXX_O_ZERO &&
+		   !(di->cache.flags & BQ27000_FLAG_EDVF))
+			return -EINVAL;
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
 		ret = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF, val);
@@ -2171,10 +2183,15 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR)
+		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR) {
 			ret = bq27xxx_battery_read_nac(di, val);
-		else
+			/* If 0 is reported, it is expected that EDVF is also set */
+			if (!ret && !val->intval && di->opts & BQ27XXX_O_ZERO &&
+			   !(di->cache.flags & BQ27000_FLAG_EDVF))
+				return -EINVAL;
+		} else {
 			ret = bq27xxx_battery_read_rc(di, val);
+		}
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = bq27xxx_battery_read_fcc(di, val);
@@ -2199,6 +2216,10 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
 		ret = bq27xxx_battery_read_energy(di, val);
+		/* If 0 is reported, it is expected that EDVF is also set */
+		if (!ret && !val->intval && di->opts & BQ27XXX_O_ZERO &&
+		   !(di->cache.flags & BQ27000_FLAG_EDVF))
+			return -EINVAL;
 		break;
 	case POWER_SUPPLY_PROP_POWER_AVG:
 		ret = bq27xxx_battery_pwr_avg(di, val);
-- 
2.47.2


