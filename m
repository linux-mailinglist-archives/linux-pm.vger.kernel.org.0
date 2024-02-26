Return-Path: <linux-pm+bounces-4412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CCF868134
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 20:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B041F2259B
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 19:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA212FF67;
	Mon, 26 Feb 2024 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHVDsTgt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EE312EBF6
	for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976373; cv=none; b=Nq7JArFhnfsPOwb2xdYLghel95YIczD9/nwGS535oAsVoIbipRio6DWYrZ5P1WW33+1dKTXHR2Cfd2to4mFVYAzyIcbNEt3gTIvXp7xQ2e3MtuPQRTS1OAB9u8UDTzk7ldmGGRpMGGd/qTFEKi68IokSJEs6Mppiz6kBof+TUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976373; c=relaxed/simple;
	bh=nO5SEudmHAHlBqgu4VkpEh4/ZZk0mSoWfN8MgMswlbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CCjN1dzDUY+5Yj2BAyHp0RonvErFT0YSSfUw9uzzqGJBxZMETpV0G8oVOg7RZUxc2O+KtofF583qUNg4d0xRCVugD1hOkWf923XkuKAFlLdO7c5klWuL8gzpWgz3PcNwh+quQssrJK4wuQtdahiEaoLjwafvFjZk3UIN8om/AOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHVDsTgt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33de64c91abso269534f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976369; x=1709581169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9GHXIAhwnCj0WLA6zXCE/RabLLML7QWdshVOcgh+nlw=;
        b=VHVDsTgtddLi+gwtBqlvesfwusH6R3744Xb0SbSwxnvPdfyD1x+4L35t2KytQH4mTd
         zi5XdOJFgJYY1oIYEFMcNP+YFbztvH1rVI+9kqhwpgSuXGJxaJZ3kkLsp6mT+8Ne/Tgo
         PTQvULTxoZrPD5Xh47MPdveeECMio2LhF1+oYWB1uoz6mvFKdVWta16LrGtPMrGak9Y8
         Ha9TT2nbHYM59NPUbjILk9bSRsMWsondPCEsP6PUqfT3fQXO2qRCDigAWH0Qs/d7rDXc
         U6AXtkDaZ3CiyO6qKiZz1FcD7dc/19yRucPX4Uti5f0GMSmM4VPhwCQowON6a5Dhl1Wk
         7iVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976369; x=1709581169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GHXIAhwnCj0WLA6zXCE/RabLLML7QWdshVOcgh+nlw=;
        b=Rx2GTD58VQskhh++hPiEiurmgg4rsGe7dt6Mth3A56phwRpUfHE0l0Nka1uuKztQtu
         Kj/Hsfvx5SA/dFakyAuqlmTWCXJLJHuFCa612UJBr23yn7OlOLyJsPKOPRDg1WYnF2G6
         tItBnZuFNbBpccn4caHSJugd0e+N73oZnLzB+NzSw6Vf2ZpdPPMDubYuheK1vcJeYJZ0
         wZt8ErkSPqE/+OOxQ2oF+nVqD5wEy4NG/pRgUQp7Nf7qy/vYjNq9WHiJsKuopQo4CzSR
         yecT7dnux6fZk2gjkUEgKm1cSzSp+RxBtqBJjcP0WWcNmSfdEOw+kyCtjCxOQUDnKaHG
         b5Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUEbhj92c/Tj0cAIOcZ9VlVzYqzpd30elbCygJf86nFrxFKDUJZFm87Bl8/tLiR8vG1f/9qmAEWLns7sJbDHa4kdqQIiOlD8DE=
X-Gm-Message-State: AOJu0Yy9gSICivFouZdizC9ywZxp6D1qPSf7C1H9QHnBH9xjsjIz9+Zc
	A7JRNmsS4qg0O3hwUSAxSYI9J+elWjVVSKgVpzI8bepVOzz5RYP3
X-Google-Smtp-Source: AGHT+IGisTnkI4SBM/h0GXIKN3IsyW0lEQqWJx+2xgdsxCWRTqCwzuFE3VDPxdtnfknEOWKBrL4Uxw==
X-Received: by 2002:a5d:4a06:0:b0:33d:2b3d:b598 with SMTP id m6-20020a5d4a06000000b0033d2b3db598mr5525095wrq.70.1708976368958;
        Mon, 26 Feb 2024 11:39:28 -0800 (PST)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id ck12-20020a5d5e8c000000b0033d9f0dcb35sm9352148wrb.87.2024.02.26.11.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:39:28 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: sre@kernel.org,
	linux-pm@vger.kernel.org
Cc: maemo-leste@lists.dyne.org,
	pali@kernel.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] power: supply: bq27xxx: Report charge full state correctly
Date: Mon, 26 Feb 2024 21:37:22 +0200
Message-ID: <20240226193722.2173624-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reporting the charging status, the existing code reports the battery
as full only when the reported current flowing is exactly 0mA, which is
unlikely in practice.

Fix the reporting by giving priority to the battery's full state
indication/flag.

Tested on the Nokia N900 with bq27200 fuel gauge.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 1c4a9d137744..810f6eb468ad 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1816,17 +1816,14 @@ static int bq27xxx_battery_current_and_status(
 		val_curr->intval = curr;
 
 	if (val_status) {
-		if (curr > 0) {
+		if (bq27xxx_battery_is_full(di, flags))
+			val_status->intval = POWER_SUPPLY_STATUS_FULL;
+		else if (curr > 0)
 			val_status->intval = POWER_SUPPLY_STATUS_CHARGING;
-		} else if (curr < 0) {
+		else if (curr < 0)
 			val_status->intval = POWER_SUPPLY_STATUS_DISCHARGING;
-		} else {
-			if (bq27xxx_battery_is_full(di, flags))
-				val_status->intval = POWER_SUPPLY_STATUS_FULL;
-			else
-				val_status->intval =
-					POWER_SUPPLY_STATUS_NOT_CHARGING;
-		}
+		else
+			val_status->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 	}
 
 	return 0;
-- 
2.43.0


