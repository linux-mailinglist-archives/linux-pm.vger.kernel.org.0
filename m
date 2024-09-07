Return-Path: <linux-pm+bounces-13832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6503F9701C9
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 13:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C1C2844FB
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 11:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D71553A7;
	Sat,  7 Sep 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iayyeep4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A93A8F0;
	Sat,  7 Sep 2024 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725707270; cv=none; b=jgA/hSbhWq7tvOr6ttsH+WA4nsd2whi7IavTpFjLJcGBby12pfeYtVXWLDZTuNzGwDWXmG1nyNm45l5yBqUrKouYXj1/+Wh+Zzz/skAVJZwhZmHTLn8LXVPc4pPcaW2Sot5jsjc5/qt2xFAX2UsLtAiUgS7A26S3uBQhNJ0GXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725707270; c=relaxed/simple;
	bh=FpEIF7mSgDnmtGiiZjz4Ru5xyoFoTmh7WQiXbDIcEe8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n6YvH/8R5BWHO/FLrmXCF2yrXh3SXNDwqUv3V6aNW0oZeFeV5g7T2oCM6tLnr6NpX3BBCd4GUQzjwxvUtabJt3wQuHHrllnEc6BYzE26LrQj9JIeNvG6NhUy8Ye6AzgszEd3fFDtbqtIhgTkAy0FVkaX//NYkZYS0HbkvWjZk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iayyeep4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so21931605e9.2;
        Sat, 07 Sep 2024 04:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725707267; x=1726312067; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAdj4+txngEBzraLv7siZVwgO3LNyZXhr3alHS/CCMM=;
        b=iayyeep4seSNftz3+RdA9f3N9etzxkTtCsBSlg0BYIGN93uMV12mbaE51omVxjS0uW
         OThNqp2DI1Qo5ynUKIeSZ7vlsKd6xFs6zhzLfKkTZh9D4grcR0scO6LPnEQO2nEfYEGF
         0CXBDNvprC13uvGn2N3OqcXX08Fi+nzdCdCmI2eS1hIg239yO/L3Qn044ndC5o2U6W3p
         3potCOnirav6osW+epmtsJnh3xT+PFVLaTRv6QDtSFghaDQcghkcYecDJmWTS7ylaHPN
         f/x+ir9xkhpmEnhI/JwUAk+nHc2561zGfcnIp381/C2K6d7bXgdJqrjXFYzQiWg0T6Jh
         XiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725707267; x=1726312067;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAdj4+txngEBzraLv7siZVwgO3LNyZXhr3alHS/CCMM=;
        b=BiqYQZlp9ZJgXGlE5Dtrw2LNUGmi06BV1j0PABiZ93JJW2DKBK3U9l2h7vg9sFHrGo
         8i2d5SEEtjMN1cnt0Jc1M/7U7wva4xP6Wy6YSXVyeWQWRlfVj7rHiDSBVzQLhyOb8DvF
         0TOtezvh8nam0B+YRbfCM/KIVYRbYXIsr049jO0xHU88YKxQgit+ZMjfG7MzyCvFco+X
         DEvWr0fkCWFXqbERvMbr11VbBFpLvlzFJZIbDnp34gYb/KTQVn6/VxOqgfkQIXwZgFow
         gvbTCkbe6h0Gew/XPYYRFnRFDpT8JqPnSRwVLR+0XwzqOoFwquD0OnNvuG4qFzK/1cvt
         A7og==
X-Forwarded-Encrypted: i=1; AJvYcCU9dwOBCiK6WKyhuVdjg3Q4xl9DLkXjz4mVXr3JZ0QlrINH+wFDIsa70WC+1GSwgk3FHdvHYA94seAhYvy0@vger.kernel.org, AJvYcCXxrkW8aCvsaU4BNY6uzgfZ6LSISmTWJrKe2+kWanHBgEGjH8qMJE+6ShGL5P9mlIL/npc+e5EYXuDM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rOXytl7OqeWNFPneIFeyzKRd+2NHBjR1hYBdtdBX4RdkSHTr
	UTWcVWBV/44VATKILWhpG6nawHzz8w8DjFH9X5OE+RNLX4MFonPwjCC+a4aC
X-Google-Smtp-Source: AGHT+IGUkg0RAB9UCpVoVpQEJKyg0k0eVE9hU1xdyLNLFy0E7O8LBBS1exgBHAnOv3Ol1KyMpGpi2g==
X-Received: by 2002:a05:600c:1c9c:b0:426:6688:2421 with SMTP id 5b1f17b1804b1-42c9f97de02mr37642775e9.11.1725707266689;
        Sat, 07 Sep 2024 04:07:46 -0700 (PDT)
Received: from [192.168.1.130] (51B6DC2A.dsl.pool.telekom.hu. [81.182.220.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb444b0sm13719415e9.21.2024.09.07.04.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 04:07:46 -0700 (PDT)
From: "=?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=" <trabarni@gmail.com>
X-Google-Original-From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH 0/2] Add omit-battery-class property for bq256xxx
Date: Sat, 07 Sep 2024 13:07:44 +0200
Message-Id: <20240907-bq256xx-omit-battery-class-v1-0-45f6d8dbd1e5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAA03GYC/x3MTQ6CMBAG0KuQWTtJLYI/VzEs2voVJ1HQTkNKC
 He3cfk2byNFEijdmo0SFlGZp4rjoaHwdNMIlkc1WWNP5mrO7L+260vh+S2ZvcsZaeXwcqoMG2L
 sL74NANXgkxCl/PP7sO8/pXQ5ymwAAAA=
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725707265; l=963;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=FpEIF7mSgDnmtGiiZjz4Ru5xyoFoTmh7WQiXbDIcEe8=;
 b=0D620IMUmvxI77KT2E2Xt6qEKqRKo2I7VJap2tM7jxKMbRnfxqpASPsIMJzVS7nluHvyAdiIL
 /Nke/hOHF2ICKehMCFUFlpkYtIIU97OP/TxUv4PW/eY2awxPO7wTaPQ
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add new omit-battery-class property for bq256xxx for avoid creating
a battery device when a fuel gauge make one.

In my case i have a Redmi Note 5A with bq25601 charger and bq27426 fg
and two battery device is created one for the charger and one for the fg
It seems battery device created by fg would be enough.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Barnabás Czémán (2):
      dt-bindings: power: supply: bq256xx: Add omit-battery-class property
      power: supply: bq256xx: Add ability to omit battery class

 .../devicetree/bindings/power/supply/bq256xx.yaml          |  6 ++++++
 drivers/power/supply/bq256xx_charger.c                     | 14 ++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)
---
base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
change-id: 20240907-bq256xx-omit-battery-class-e2cff68b3cee

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


