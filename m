Return-Path: <linux-pm+bounces-11102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83C9314FD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C6B1F21BAE
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B098518D4A8;
	Mon, 15 Jul 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs1FI234"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0118C34F;
	Mon, 15 Jul 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048113; cv=none; b=WiUeR1EeNeYZWzYwGe5uqEokXJhV6M3omixa86Q6VHE5hLgI6nrQgXbRMrNmTPNRBJVE6GVMMemS49gRoHjsjoWdoUV1pI9rPf71TgjslVWWDci+9RdLINmh++q+sPJwgFUqQH81Mbw7LSO2WRqJf9FdAEZn+HEQnI4s2FsCfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048113; c=relaxed/simple;
	bh=joW1dUBhJoxnwAipx4tWr4333aQdsreO5ngTla7wYSs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dcbzrRE0mrzgF8GX+8mWTpWJoSNr4JTPsuobNpvLaE5tmh3KcB/GLoGvPu/5u2rkYe5CUZM/ATXHoyR+ssPEwecq/Zr7yVXCSlYxOkKKW8A4ClhbE+My0W5gRYejU7dUc9Fw80b/c8buQAVsiCBFrSdiL1V5a1VrONip3lbjs9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs1FI234; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so277050a12.1;
        Mon, 15 Jul 2024 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721048110; x=1721652910; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4oxwn9faJBZWNYakjxQw34lzbdzSD9MrW7c7EhtXGw=;
        b=fs1FI234eRSSTEHb0G1e9uznsBVrTpQRjc+fcgpFgNmyh+7G7xUszq7msvbfxjgash
         53pRWD3ZQKyaek7zwXTbnS5horLFEeAnX30jjnk1cuV+vppJP0WChXqmb2zzrc6ukSW9
         HcIu4QvM2b3lI2WnllbEnFb/G3YuU1kFVVmLNGELVY+Hx8+5aO7NdcmnIaR9s/txmspJ
         yA9JVZ+qB7f9IJe9svB3kFyBhePKSW7eubABni7/UyBhN6b9ncuiRDdOOQFSYd/YDcCG
         QxsSyAkRKJzp5WdoLHMvYILFloQF/t76yFMBt1PCVVi5/1ZWw7W9XEhc0j4EXdqPlqof
         Uwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048110; x=1721652910;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4oxwn9faJBZWNYakjxQw34lzbdzSD9MrW7c7EhtXGw=;
        b=Ou+xfFdIcSf0AWXLvMel3aEl0z8T3/qxQTSFmXUy7fqfEZNYBfLAojdEX2q53y5MWw
         cHk7fc7SfZ10n3jEVJEgvHmY1X0OEVOfyYVS4eL951BpT7QHKer40oMCO1IQXGTUs3V6
         O1R3mRZw4TfUlobet8yUvsqjopgCDLCCn2j4BJnDQEU6slSS220GU/M3Uk5LfPDbO7i/
         EQ1R0oGaFbAVWTSjeuClit74CKmbjzYjUIYEyuYXOlUAeB4jHyy/5piyQ6cA/eqQi0MK
         DH9zKAzTK+HAtEqnmhMGsE3U891vGW0rEggJE1CuizfnDr6tAZq8hb002aLSNHhBrwCK
         m8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWccPQX8pY0Sbnx+W7pF6Kg2AA9wboy7IsCUeeLlQApTSRcJIrlSdSNhHDz/p3BcMPZZ5FjlWCgCoxfZJErYmc0lfdEUQ19YGlx2FdKOP2Tc00dXNseiGXoaSFHEJ+0NrWyg8V+OCjshG4l7a/OIDvqUBYjjknG2Ie4gcGBVUeucEO6RGvt2c0MSmTzJJ2ctH0f/SGiV/xaJxn6iOXb7FhY8kEnBAs=
X-Gm-Message-State: AOJu0Yzox9RTLdMsIR+E4RljzsnJtnuOTB7WWE3iuf3QxfSu5RsUdXSK
	Zndf8CRsEvzVhoWqBfrotvkn1v48IQFyeATus8nDc+iTIyjPMNabWutMNZ4O
X-Google-Smtp-Source: AGHT+IFiuhD+U3uimNCwm9sMXN3yk+88hpselw5hq29H3RlOMCChzciDUtnwlTqLtREIV1f6gBzhyw==
X-Received: by 2002:a50:d7c9:0:b0:59a:442d:67bd with SMTP id 4fb4d7f45d1cf-59a442d68acmr4790387a12.20.1721048109582;
        Mon, 15 Jul 2024 05:55:09 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-210.multi.internet.cyfrowypolsat.pl. [37.248.157.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62165sm3333307a12.87.2024.07.15.05.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:55:09 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2 0/9] power: supply: max77693: Toggle charging/OTG based
 on extcon status
Date: Mon, 15 Jul 2024 14:55:02 +0200
Message-Id: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACYclWYC/3WNzQ6CMBCEX4Xs2TWlFRFPvofh0J8FNhFKWtJgC
 O9uJV49fjOZbzaIFJgi3IsNAiWO7KcM8lSAHfTUE7LLDFLIi6hkhaNe6/raKMx16CkgrYv1EzZ
 kTG20uylLkNdzoI7Xw/xsMw8cFx/ex1Eqv+nPqcRfZypRoLNSN1QZ1ynx6EfNr7P1I7T7vn8Ak
 w8nUL4AAAA=
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2480;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=joW1dUBhJoxnwAipx4tWr4333aQdsreO5ngTla7wYSs=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmlRwo9PihOl5L28LE9qP4hgOpnfxfXs8CFPp05
 CKvz5ISW/+JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpUcKAAKCRCzu/ihE6BR
 aB0vD/90CLEESM73nmoes655DvnKe9FoKfY0xRcn8DjYELj1oRQsnFmYNzH+Hm4TLWm5wE7Styi
 FGgmxM/d/ffqC87fdmUpqsmntH5snyajqNAmA7NSPg31xUhoD/MyuEnDc+pm5p4Lngr3iGKPmz1
 1RT4MMjLoc1eATadbdTl0bohDfQd5sV1gWsb475Tu7GoevaUzvAs4boj38JKMQtstZ3r5J7Jymm
 FUgbSioMlcAlF+Hnz6vfgY89jkfwwbbzrtDnp0azbXjm3kS3LBWlttOS9hPHdTe+sLgPs7hfk9a
 wp6ETUNq0YdSNRUvqJDmJBR014OIxJWOJ/LQfTpr51PSDSa7ALYJAU+lM+CLcX2iaEbxzBqkh0m
 HvBAhGcYLq+U7tMg1xQbhbQD/MfR0435xZq6I9911JcbyaarK1U+HUnpbqq4i6+OgN2dxHpiPfS
 w5PowAQzE96/3BfURYLYtzuPTljJrKZzxjIaP9rsezom8vF7Ih4SB90gLUFBrpbq+JrvDIaPpIQ
 bGFxTcWR2A/5qX3P+WuNsaUfn+lVSbGFCYBY2mbEdJjyDfVYjfscHaMsp9zZRSSOMdOvqna3K6g
 lFfRsiFhkAZTl4EkZEh+EueB3kMOHgMYSxovU7GgyunqAIc+h1udPKU02Ri5HxMOY9rrqvisyjn
 0p9vpp5IDI5eFxw==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

This patchset does the following:

- Add CURRENT_MAX and INPUT_CURRENT_MAX power supply properties to
  expose the "fast charge current" (maximum current from charger to
  battery) and "CHGIN input current limit" (maximum current from
  external supply to charger).

- Add functions for toggling charging and OTG modes.

- Add an extcon-based handler that enables charging or OTG depending
  on the cable type plugged in. The extcon device to use for cable
  detection can be specified in the device tree, and is entirely
  optional.

The extcon listener implementation is inspired by the rt5033 charger
driver (commit 8242336dc8a8 ("power: supply: rt5033_charger: Add cable
detection and USB OTG supply")).

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
See v1 for old description:

https://lore.kernel.org/r/20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com
---
Changes in v2:
- Changed to use monitored-battery for charge current value
- Both current limit variables are now set by the CHARGER regulator
- Link to v1: https://lore.kernel.org/r/20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com

---
Artur Weber (9):
      dt-bindings: power: supply: max77693: Add monitored-battery property
      dt-bindings: power: supply: max77693: Add maxim,usb-connector property
      regulator: max77693: Set fast charge current in MAX77693 CHARGER regulator
      power: supply: max77693: Expose CURRENT_MAX property
      power: supply: max77693: Set charge current limits during init
      power: supply: max77693: Add USB extcon detection for enabling charging
      power: supply: max77693: Add support for detecting and enabling OTG
      ARM: dts: samsung: exynos4212-tab3: Add battery node with charge current value
      ARM: dts: samsung: exynos4212-tab3: Add USB connector node

 .../bindings/power/supply/maxim,max77693.yaml      |  15 ++
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi     |  19 ++
 drivers/power/supply/Kconfig                       |   1 +
 drivers/power/supply/max77693_charger.c            | 273 ++++++++++++++++++++-
 drivers/regulator/max77693-regulator.c             |  34 ++-
 include/linux/mfd/max77693-private.h               |  11 +
 6 files changed, 340 insertions(+), 13 deletions(-)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240525-max77693-charger-extcon-9ebb7bad83ce

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


