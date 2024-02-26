Return-Path: <linux-pm+bounces-4413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0625586815E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 20:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7D3280E01
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD83130ADE;
	Mon, 26 Feb 2024 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFFibW15"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E227F7F7
	for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976737; cv=none; b=aQxBMqJo3BJxbesK5GL47IQqYnepIDu9WWkMRX60O4y8zRpwfk/O8J5x42z4OxPtmgy2+w5OM7r9wi83QMFXsXrkZh88bP3SUXnKbPfSLvXpHyLfAks4eCpK7Ur5FJ95giFjafT6CMVgNzls34biQ8fDke8A/8g0FvfXuso/eOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976737; c=relaxed/simple;
	bh=FDHDDWxB1Doz+ND5nk4FsY5olMp9cbllAPxafeEheOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSxsoB/0beleQh7Dp4q0x7v/8ZhEbbXBD/e984DgeGBfHck4kuNidJFKuwNVXjba5eWEgjtzN7DKzGZzEddWvLN8fX6+4J+IGZLit8MMVbTrg/LXITaktSYbeulsehbVpTCs9KcPdTG/S54ps/NxygD3YXmebTbmBhvRjeY26P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFFibW15; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412a4055897so11922585e9.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 11:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976730; x=1709581530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzJinRf3GMOFGCElQCaE54c9/lpjf6i1JUGcZRbYzh4=;
        b=YFFibW159Bu6NyJPw0v/GoffGSZ/OOrVwQWmdcmeOktrnckv0E+G0fNEvatERpIMcv
         41KyPhdprvJIVjiOWKIJkHPzbAri0KI4jJFNagpTfBKbUK3+mY5Wuz+RAjQTIoyUG57D
         s7kQiYwRz41DXLVRKG8SalksotxEaUDq5AzSnHc/3lwWfTj/DIlokWoHjDH8wRJnwjLQ
         XrfH5OEszxdewVLeHqe36da64lVMq0E3gi8kWApncH8ltdxtZQOaeasj3U0wrQHx3U8y
         wlXB/gTxbimvvnsy34zBFhG0dAsemhLhmyM3HED5JbhNuJnfshUGScE8R/nA35Zjkxfr
         kWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976730; x=1709581530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzJinRf3GMOFGCElQCaE54c9/lpjf6i1JUGcZRbYzh4=;
        b=MY7iV+wImqxIu+cIHc6U6whmaOiP8+7OR1eRwTjz6LXpBHaB95IQB7D4GMDoOlMIkX
         DRyqSSjGs5p6y3T8FJIY2cEk04EpQrQEPLtbaGk0kVfWaJqXQCdkj3I8HB+zSZITOShG
         gvPDT6v8WEQYcSdGF23qfqcNNnn4DDOZwUqFNj43UYNI79dRraXF+U5ozb5jXTPboPNm
         J3MA2/FqsszLhSSOiE4gXPSwxGOIOaVk4Zrfn4HCsdxgigPeepaiixU50PA33X6MszTc
         6QDcOAkAYK151aRFSZd/BB1IV7uFxcKVzgSDHV7pFEf5pgK0Mlh9eA1mAp1tQfNqJ0MM
         n0/g==
X-Forwarded-Encrypted: i=1; AJvYcCWtRG04ujNj96Zxjck13pm9VMQS9AB6/JBiDHwSzFImqowq88w7LwkbTrvd+4z6dO5uP0WXh9R4Xx6SN9l0biFHis7XVm+RZjo=
X-Gm-Message-State: AOJu0YxPrl3kSkZOzC5Ea0nvz/MMucffI5Sc3Tadx2eowI8he0yOdSGE
	2tZz78m/YIqZk0aMFynmTiKUkDovIRzaZOH66pkcdy+DYLrSK3KuBsB0A46aIbUoYA==
X-Google-Smtp-Source: AGHT+IFw5JabCnO2tHrDLNn1YnK6dcx/8TBVeV6hU6zqsqignz95lbhDixpXmbNWaJlOymKqiAm7Uw==
X-Received: by 2002:a05:600c:5592:b0:412:6de0:69a9 with SMTP id jp18-20020a05600c559200b004126de069a9mr5118938wmb.39.1708976729615;
        Mon, 26 Feb 2024 11:45:29 -0800 (PST)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c0a0e00b00412a37130ccsm5389657wmp.48.2024.02.26.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:45:29 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: sre@kernel.org,
	linux-pm@vger.kernel.org
Cc: maemo-leste@lists.dyne.org,
	pali@kernel.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] power: supply: bq2415x_charger: report online status
Date: Mon, 26 Feb 2024 21:44:32 +0200
Message-ID: <20240226194432.2174095-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide the Online property. This chip does not have specific flags to
indicate the presence of an input voltage, but this can be inferred from
the reported charging status.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq2415x_charger.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 6a4798a62588..5b47a1d0a51a 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -991,6 +991,7 @@ static enum power_supply_property bq2415x_power_supply_props[] = {
 	/* TODO: maybe add more power supply properties */
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_ONLINE,
 };
 
 static int bq2415x_power_supply_get_property(struct power_supply *psy,
@@ -1017,6 +1018,14 @@ static int bq2415x_power_supply_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = bq->model;
 		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = bq2415x_exec_command(bq, BQ2415X_CHARGE_STATUS);
+		/* Charger is Online when Charging or Full are reported. It is
+		 * also likely online for the Unknown/Fault state too, but
+		 * there is no way to be absolutely sure.
+		 */
+		val->intval = (ret == 1 || ret == 2);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


