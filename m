Return-Path: <linux-pm+bounces-4494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E786A8A4
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 08:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CD11C217D2
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 07:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFD32263E;
	Wed, 28 Feb 2024 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw/ILpRi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF223748
	for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709103787; cv=none; b=m/sshwuozYsDjzQ/TFHtE/U35AFdxg7Mr46X1XuZjNe22H1DNp4dKXBrfDOplf17FgvuXayJOTc0ALS7D5FaDT67XfzkIMC1WphRGcYH6EnD+0BIl5gKV9m5SWT+0ayi00uVBPytV5fyYA7f6cV+Bj371GmzuKZDeBwC5XbFKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709103787; c=relaxed/simple;
	bh=DlxnDyXvPRjqtjs5fuv9BCC964sP4PMx5BKmLHH/Whk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mA3JkAkMOjWpWzwyPABcL3MCS63Yz3DYjGeWWDQ0fhA9GPKLKZXoG1IHU9ZCQZZyyg3XA96G2NHFzVIxEaZgQmUWWBko/5IHJeCIlXsfXI6UH+GUBIIdRZa+jo88fas/xtkE/CRRqdenqKsQrU/4CHWOQLV8ANo5QKqvGz+zeAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw/ILpRi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412ad940fe8so10263545e9.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 23:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709103784; x=1709708584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhdfyLtk/TlMEuI7FsB5OVaxCAq22Onq2TSBRTzLIlY=;
        b=bw/ILpRio644T9ftCwQt9SrUESGzrIOodB3TxAJlijrsFtNu8U6fTIvWK1yHNJizKL
         vKY5ABcYoWxMYlUy9dquB/B7kGnkrJ5mcRM+ArCyGssXxdWvgGDi57dZ11537bx8AZM3
         34uZzmjQ5VModsKZDcwNHTVsoWPf6LjnbV3/26s+O4YH9+R0WCog4/rPSlPdwGI1rv2A
         wB1qHyjvRd7QWVKro0VGOOjtm30HruXE42mYv/4ZoVk49FRnKAvkXcdY5sAkyFqEyGvF
         Yvef0jZJ7kxwAP0YvLztZFAU+1bh5eLtnAPYO70ENbBjBZE7GF96bzWuumtCP552slKs
         PZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709103784; x=1709708584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhdfyLtk/TlMEuI7FsB5OVaxCAq22Onq2TSBRTzLIlY=;
        b=gRnFEliSpiKHGzOzR2pudw30TeyCX/vMedUVxvGGyPEIKVNPlCgkF1pbP7JSJAV9yq
         TGkgnwREERl6/tY1YSlDjGNFb33V9CUy4IFU1mPRnSFQNnQ8oRZqaaEmXTRX95femiGX
         rCA1/T9wJLAcfE+ITx7RiDgvJK75zhW2FzINQ8EBnn7hrTIY7WAKriPcAh7R9jaOaT7S
         YkR/11PYFzpGhd6cUVU9dv0tX92KXgphNNK8t97gO+e3LKLJwEbakK+gjCtjuFFs41Wh
         YrVdzSN3QXjHnHAEfKaKou7KB+cmnJ4ceyc7feZWn19Wlg1WoWXDdYlGabjdLyDgSlrr
         CyWw==
X-Forwarded-Encrypted: i=1; AJvYcCW362fjPtYtHCKFYSoXN+gixRD7DetrQEu1Zu5/g3e4jvh4uLBCjJFZ4HGcD8leLn36P7otCrbiReeOumDXi+eiFA/the0oQdY=
X-Gm-Message-State: AOJu0YxNG2TeduMgYm9CThIySoxMyFSSE4LtxIU2ZHpWEKyimjbRq9Qp
	PFSdw7EeAkrnmzX2qwWMv2bWpi+IkVyaqg9OFYeTHwvJ9dCk+QDa
X-Google-Smtp-Source: AGHT+IHjqFv5kR0ufdPQsEyQXIHBY9H6nSkvFWwEDSZGCtX6sxOd1mm7DZuLqJQTjLs9TplH/6whew==
X-Received: by 2002:a05:600c:154c:b0:412:b431:eb24 with SMTP id f12-20020a05600c154c00b00412b431eb24mr636973wmg.15.1709103783697;
        Tue, 27 Feb 2024 23:03:03 -0800 (PST)
Received: from tpt440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id jn5-20020a05600c6b0500b0041228b2e179sm1086578wmb.39.2024.02.27.23.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:03:03 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: sre@kernel.org,
	linux-pm@vger.kernel.org
Cc: maemo-leste@lists.dyne.org,
	pali@kernel.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2] power: supply: bq2415x_charger: report online status
Date: Wed, 28 Feb 2024 08:58:41 +0200
Message-ID: <20240228065840.2395243-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide the Online property. This chip does not have specific flags to
indicate the presence of an input voltage, but this is implied by all valid
charging states. Fault states also imply the presence of VBUS, therefore
set Online true for those as well, taking care to not set it when i2c
reads have failed.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq2415x_charger.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 6a4798a62588..8f24a33f0338 100644
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
+		/* VBUS is present for all charging and fault states,
+		 * except the 'Ready' state. On all i2c read errors, the
+		 * Online state cannot be determined.
+		 */
+		ret = bq2415x_exec_command(bq, BQ2415X_CHARGE_STATUS);
+		val->intval = ret > 0;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


