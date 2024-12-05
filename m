Return-Path: <linux-pm+bounces-18606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585979E502F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 09:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33A616A075
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 08:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572101D54E9;
	Thu,  5 Dec 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJEWXteS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAC1D0E26;
	Thu,  5 Dec 2024 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388384; cv=none; b=UFdqNis547JeUUMSGSSmsUCD1g+JI/RCc5xHiUxVrIgfIyfif/jYenlpSufMC/7ehqZ/EhCwznr015hD6nrD8kyKvrbkfpa7qnjtDX9/WgXBok38gaedTgjoeoAQ1XhBxRa8pq22OAAiffL/KQZDWxBxn4z5XW9fmct2DqHiW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388384; c=relaxed/simple;
	bh=0tWDJjxXVM/jzVCAaK7bUdLrvjKANFBUU2HoomjE72g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9KWR4DvF+zVQDVmrjMee7+eMGoChSF48Wjccl/kjEsqhfepBS04YmpWRG8fNTCjd8/y7T1XTWApxYNxzGRKI7i0q09zB4avHjta1LGTj1yIGlzd1a408xZsaopa2lIr4H3hNA2RSG1CPY5cSLIpKULgcOzNvQ1yT4qoIvfbkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJEWXteS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72590a998b4so1252263b3a.0;
        Thu, 05 Dec 2024 00:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733388382; x=1733993182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aXVrFfUnhGfe/pTbmgNe0xji7D1EvjIFCip+YxUelLE=;
        b=nJEWXteSlgkEerC2ku1vYhkF802MVFgG4CKiRhXVhJSwGUZZoPpZydE67sXkRKDMAi
         rxct/khmjVAJSfeiZ0qJlvbjLiZNClsZevNjwerYpIN4dl+lppJNRgGoQLV6aoIZeZ+T
         W1GcH7FiHGa4yYJrdm7z51xboNzLtJPDOcGJYvMJfs7GkDqWjRZiFzlj/Qloe99k7q/h
         +4DQPezj2xXuGsT8Xly7X4ABu7VAcrcRZhxSsTqXiHuOhyFAG7vWmHHiJNyYYqis+jTa
         nH1ZjaIOIqNZaCPBAp/DQ3AmWVWPiwNn1v06LuewHE1xJ7Qg6HAsP/jQPTbc2FumvynR
         rOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733388382; x=1733993182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXVrFfUnhGfe/pTbmgNe0xji7D1EvjIFCip+YxUelLE=;
        b=SCafr7MHTOMvsQLwfAVnQIel8ZHWZGy9cFuHrq4pCVK9Aziqq7Nw89Eohl3qhCEJOy
         IcwI0ipCtTJzk97HSVHBuE+2cD3mo7u0yV+rSmK7M330rM0dX/jXQhCaa0wV8fPZudDj
         l0z7sOYmz3UgN9rFHaSD8gX8xInyAF/ajr2x/qZR5EH4vCgzKdl0lrhntXy5HD9IgxPG
         VD1eUNxhW4HZFPRp4t6vsSehqKIiLclBh+jIpJkGCXj6a/ks2LYPLHiPBGlSQjtoEOz3
         7JIZ5H4jfFgOFSYf2NDJeiS6Le869KTCtlQwecBlt89mnovh88699LvFWx+2qnwxNfSv
         Isww==
X-Forwarded-Encrypted: i=1; AJvYcCVHg2gtj00vNLVK3NPV63v3Rj+djFX0Ai0j+45FWKAw1Xs3FlCawsNKrMqOu5riTXz82RbCuq8zWrEu0CQ=@vger.kernel.org, AJvYcCXgoJG/mnH86/97z1j1RJbva7TAIuiBQr67rseidP3ThEonSKL9HRNJUgujHTuWoIq4skHJuUCChB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrmqXaHiSI/Ua+VxTmc0IQ8QrtAEcRER6yQWUh20ITYlVO7nR
	b5eKnPGAB4zRKlXQCIXHwXUD4rz6n3e09dDqPZ9uPRp8opFRBIzF
X-Gm-Gg: ASbGncv37JwdFHRXICO9yVQojfKcrUGdmzJQdOM8VtEn2MRljt7oM0UsiEZdsqQ+yuZ
	HI25N0iPKJiKI/H2XFpeNccVG/jYHuzOAdHlvcT0xdxDsaIjOzGQ4kqDRgA5aiQxUEhDtCNbL5S
	JdUbNmZW8KQmVRxepQnATRfqoE5DZdj9En+w7PypE/8PpoOpF42iJFxMg8WbLoRnK2z0oyF4srR
	amSDK9R3Oz4B8hrcLtDTuhYuHxMUta3KeW7eUhu+0XCMbTucm6m37zRuzyExUZ9eNyehKYULEHI
	46Dyugdr6yQ9O+cEwYgjFL4=
X-Google-Smtp-Source: AGHT+IHTIhYUyolqsVJ1tTskDD6HEcof3cro+Hbr4f6SlXP/phGJgWtGGz/olJe0nA5rrkUVMb6Isg==
X-Received: by 2002:a17:903:2a8e:b0:215:2d2c:dd0c with SMTP id d9443c01a7336-215f3c7ee68mr46392115ad.14.1733388382228;
        Thu, 05 Dec 2024 00:46:22 -0800 (PST)
Received: from archlinux.. (opt-203-112-63-105.static.client.pikara.ne.jp. [203.112.63.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f30fsm7907375ad.74.2024.12.05.00.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 00:46:21 -0800 (PST)
From: Sho Tanimoto <mojyack@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Sho Tanimoto <mojyack@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: bq24190_charger: Fix typo 'jeta' -> 'jeita'
Date: Thu,  5 Dec 2024 17:46:00 +0900
Message-ID: <20241205084601.2720462-1-mojyack@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs file 'jeta_iset' was probably intended for 'jeita_iset'

Signed-off-by: Sho Tanimoto <mojyack@gmail.com>
---
 drivers/power/supply/bq24190_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 2b393eb5c282..3b97f7884967 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -422,7 +422,7 @@ static struct bq24190_sysfs_field_info bq24190_sysfs_field_tbl[] = {
 	BQ24190_SYSFS_FIELD_RO(watchdog,	CTTC,	WATCHDOG),
 	BQ24190_SYSFS_FIELD_RW(en_timer,	CTTC,	EN_TIMER),
 	BQ24190_SYSFS_FIELD_RW(chg_timer,	CTTC,	CHG_TIMER),
-	BQ24190_SYSFS_FIELD_RW(jeta_iset,	CTTC,	JEITA_ISET),
+	BQ24190_SYSFS_FIELD_RW(jeita_iset,	CTTC,	JEITA_ISET),
 	BQ24190_SYSFS_FIELD_RW(bat_comp,	ICTRC,	BAT_COMP),
 	BQ24190_SYSFS_FIELD_RW(vclamp,		ICTRC,	VCLAMP),
 	BQ24190_SYSFS_FIELD_RW(treg,		ICTRC,	TREG),
-- 
2.47.1


