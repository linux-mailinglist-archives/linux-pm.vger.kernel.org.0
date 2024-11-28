Return-Path: <linux-pm+bounces-18197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B029D9DB461
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 09:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3497C1646F5
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD991514DC;
	Thu, 28 Nov 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwEe9LXJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB513FD86;
	Thu, 28 Nov 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784326; cv=none; b=SnMixU4lAy2Pd6dqqFzWOSLc7thxIiaJ9OkZHN6ih4cDn/jPeEaa6U3NmJHq2qAi4f0EAOi5LRWJNSBpX+L5nKD3p6hs45lMdfa8YeVIWK6rOj2J0g1nYl8RMrB5acsfCulcs8zq9vCw3nbgHRDj46P3g01tq9HvJKY/0dh9AoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784326; c=relaxed/simple;
	bh=lDxkmj/lOqewIQw93UV549SuG7YQzFEWJ/7u5QkSjg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1i8yqx8c0yxIFKQt7WKYmZT2eiS3wdxZNyoQzIl+WniXA8uxaQfUqsVZrlPZZaNmT+KzciUcOHi35pH1fIFEupVqn52u4hRm8hKr8ClqICoECQ9buNp0S8GiJh/Bgm92Cnbv78KYTmnl1P4ig88m31lCW44aaTUpoVAzDEeYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwEe9LXJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a1639637so5118055e9.1;
        Thu, 28 Nov 2024 00:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732784323; x=1733389123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F83gs/aCVwzW60RuDHg1UB3163alltbBimyRGH5Ygxg=;
        b=kwEe9LXJNdehcGmrvS+a7XXes1nnm6EjHZV4rJY3raw88iV8XjkmcSSHH+7l+7ZOmc
         BbC4oZk58Mc0Ms+CO4lYaz7xwjgXrPp9VOGH/1m4O1fo8x+un2q1mvISjUxmpPdsGxXM
         RwCOfx8uLaPDppLe+5huuCldIkxAHt5gnVKtB04VMvCShgGu9hXVqMwYJcH3h2zPu0/8
         M9J6zEPgaQJ/OOhbfsXlSkhA8mGUCbxCRkqFQWGLpwtv1qp6joeiHoxv0H/wWZ1xTN16
         MDZK6ugqD+deJUtGqjDxgQSi0YF901FUWiE8xOYxMSIECNIIIpPEVd7HqmHIWIZ43nf6
         DImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784323; x=1733389123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F83gs/aCVwzW60RuDHg1UB3163alltbBimyRGH5Ygxg=;
        b=SwAWH9FSMn0WPL8jBTEsPo+APCFI+kwUdcZTdgAfxOr5ytQ7vSgLAE3iQxZv07sN5h
         STAHmQw9y6G2M920WPdXvl/71K9SQ4E6mWA/GzcjojxyxsNTxLaaLIDv/cK8oHx1t/aL
         luC5IdAQRhqYxZTBxXRwn8aQpRK1wT72aH4dh+yQH0znIAnOrvV+HjjULguu1UGRX0SD
         PzVxQVPo1q8RhEQVLYeGZBamFeXCIBCUJZhxupirffpLqV7W8gdjy0CADWF0+yB/AdlC
         T+fjrYFfcXGG19A+8O94mEx16FdyycKkrf7DjzioDaV983+ros1pA5RD/Ls8i51lWFNQ
         zRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRXdg8YQDRMqZeKD2GRkFJ57ewxySOURAgkqmM5hduB7LzNlJpdfXFEy2ILPDQ3f2G8BijKs1DuMpZJYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznviPNLINw/KV+MmM/9UEMZHCQfxxWC1gdTbck6/KqG7zrwgrQ
	5bdsGJDvAJzIBnRO7zCq57FxIIZkGqu7sZEj94xa2K+ECkbplBWz/d3r7Ku5
X-Gm-Gg: ASbGnctNke9w3vSZbHlbnUH8xfD/ttmPMahZLMqKDkNzrREIz7UkZAsO9vfeh3W+jfs
	FoT4PJTIUIibnBkpxiIq5BDd0ZngMq58eEUSRnDh/H9yD3QNkGSx10FVctHA4twyrXx0dE/ukL+
	FRvMHkjC5lo5hTYavm8MCU6ZB+98aN4qF1FWR7F2/zfTxQHCnmfjO7jby3HBbUfJgq7YgvVDjtB
	LcUdQlbzYG6pr5tcFIfU79KUZKkIrXgfHs4Z31o0WvJq71L8w==
X-Google-Smtp-Source: AGHT+IGBQxl7Y/hdKv04zTb/y5Vf1NZPGqdglqcTt2bZU97NGcpvHHPZP1yzdkTHiNYNswgFjM+ldA==
X-Received: by 2002:a05:6000:1acc:b0:385:c511:240a with SMTP id ffacd0b85a97d-385c6ec0d07mr4103500f8f.25.1732784323049;
        Thu, 28 Nov 2024 00:58:43 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ce3f934bsm442261f8f.30.2024.11.28.00.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:58:42 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: linux-pm@vger.kernel.org
Cc: pali@kernel.org,
	sre@kernel.org,
	linux-kernel@vger.kernel.org,
	maemo-leste@lists.dyne.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 2/2] power: supply: bq2415x_charger: report charging state changes to userspace
Date: Thu, 28 Nov 2024 10:57:28 +0200
Message-ID: <20241128085759.11840-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128085759.11840-1-absicsz@gmail.com>
References: <20241128085759.11840-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continuously track the charging status register in order to send uevents
whenever the state changes. Generate an uevent also when the chip's OTG
line is toggled, in bq2415x_notifier_call().

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq2415x_charger.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 1a02195769a3..0234f7724872 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -171,6 +171,7 @@ struct bq2415x_device {
 	char *name;
 	int autotimer;	/* 1 - if driver automatically reset timer, 0 - not */
 	int automode;	/* 1 - enabled, 0 - disabled; -1 - not supported */
+	int charge_status;
 	int id;
 };
 
@@ -835,6 +836,8 @@ static int bq2415x_notifier_call(struct notifier_block *nb,
 	if (!bq2415x_update_reported_mode(bq, prop.intval))
 		return NOTIFY_OK;
 
+	power_supply_changed(bq->charger);
+
 	/* if automode is not enabled do not tell about reported_mode */
 	if (bq->automode < 1)
 		return NOTIFY_OK;
@@ -889,12 +892,19 @@ static void bq2415x_timer_work(struct work_struct *work)
 	int ret;
 	int error;
 	int boost;
+	int charge;
 
 	if (bq->automode > 0 && (bq->reported_mode != bq->mode)) {
 		sysfs_notify(&bq->charger->dev.kobj, NULL, "reported_mode");
 		bq2415x_set_mode(bq, bq->reported_mode);
 	}
 
+	charge = bq2415x_exec_command(bq, BQ2415X_CHARGE_STATUS);
+	if (bq->charge_status != charge) {
+		power_supply_changed(bq->charger);
+		bq->charge_status = charge;
+	}
+
 	if (!bq->autotimer)
 		return;
 
-- 
2.45.2


