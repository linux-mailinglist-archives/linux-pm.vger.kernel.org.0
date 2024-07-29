Return-Path: <linux-pm+bounces-11571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A192793FC9C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A64281169
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2AE15F301;
	Mon, 29 Jul 2024 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqbhU3Fl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2442B9D2;
	Mon, 29 Jul 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275270; cv=none; b=Ta+KN703QsTn+wFChOytTWAmQ7MbN6E3Od4DiGvjCGWikPDLfZ+sVDMgMTHtkRr6N9F+nS1wNZeZuuWDvnFwoxFhanh2ct+/xyK23e3g7eLo5xO2tnZhf9VL8fkz6rV41HOqRV1htarurBC828IYegbkVYY30amT2zt9hSEMnTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275270; c=relaxed/simple;
	bh=ZBeCVq76s1YcWohvGVE5wNLt+NvZAu6jcfawXYj2BqM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=meUyNCgcPHwtlypJd0GotFnZqXtwKOuWLXTrgO0LbtbF49OatwO2LWAEzjzQiE43t+9pOb88anHSfj4EB0PLoK/+5dx8li8z99rA3ROFvpVgY69/H6UrcJ92CkTX0Xkfdb/MhBzyRtiLU/nIQPVzgFGjgc95+iRipmSEPKVi57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqbhU3Fl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36858357bb7so1579722f8f.2;
        Mon, 29 Jul 2024 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275267; x=1722880067; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pnyl1Fm6dnpc6MtOd4c54WB7CEXHNdORrEgIOaBPmMw=;
        b=IqbhU3FlB4HSCGZtB5zXTbGnj47gG7l79dUjsKx7G/g3aHRMDzwJZdRAYta3coLSoW
         2eTferrNB54nomYtS3gmZIIMNkHooeODwzPXJB/VOTk458l5MQvwOPIshrPOyTCTL3Ww
         hkXS4zGMdEJ+EGWOadJi9xtx/6V70ZEKIjyzRnRalvaRh07PI2qXkcEvofR+tcraAV/J
         01doOVOchQgOz6yxKg+IW62UaUsucYUzzwRhRnB6u66UrAEeeMlwzms6ERMWXWiKEDQZ
         mNFXl5DjoKqcCs8PmsbrDYLGaPBNIZPCSHA6hu1rRWoV7EBlVLoXKiqPWNsOQVM9XW77
         75Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275267; x=1722880067;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pnyl1Fm6dnpc6MtOd4c54WB7CEXHNdORrEgIOaBPmMw=;
        b=b0EUVOn9qEEhsyIDQaZNXuO64hAE3H06EG0I2vX9XBrQGNyCLbANdNDiQWV/WEWXCd
         7gv8CzJBeN38lUCPj0nvYpdaS3l58zhW8m4HczG7eh4ONyM21qf2xGIS+1HQvAZBWRIR
         YIppc+pModbLHUnkUjrr3hTyYPyBal/EzHdNA3xgJsoA9/THwK67y9utgHqCfiBzn2dD
         PfIX5RJb8SetMVi4Ce8rzVkaxk85QG3E6ZghRC7+myq8FhsBamK9Oh6dCyeIG/3aTEAT
         zBrk5fC2mnDMJ/V4WLwFerSrEgrBmchHq/TSBHNH1Us8R3nPN8ls9rUWc5eyHteqgY+2
         cAOw==
X-Forwarded-Encrypted: i=1; AJvYcCVTCf8+1sdlT5hPiiEJ1Qpz88Luek0VGvOsKh0V7X3MbS0Bb9oGESrAseEGAndpSVxhW197PvkqWSwKTyH719CKyVOsdHp10XaDwBjNz+rA9HLoTIIuTFx1gyrX5e66zHhgq5tjId1Py+Vu6K0YLaPpbN2m1vFr0JLEia1j0/XCv3m4BBwNTdqaa4Mvd2pk3OngJ/mxHM78DcMCxBjT/etL7yUUUfI=
X-Gm-Message-State: AOJu0YyYdJK6vf1q5+FKzvMFXr/Gytr6ZFyNBN3/IRCsqJuQwTf7BuUX
	uTXVN3V9E0qOxPLiVqwo+NODNtNgxaYPPDYvBTJd8nUiwPHgMzb1WY2Kbw==
X-Google-Smtp-Source: AGHT+IHLvm7BPEtc9W0QLw+jMFn9fEXLREx620qqvb1/GY1x18fNukgK4rt67upiSgT2nwwCGAPipg==
X-Received: by 2002:adf:f5cd:0:b0:367:8a87:ada2 with SMTP id ffacd0b85a97d-36b5cefd2fdmr5004948f8f.26.1722275266424;
        Mon, 29 Jul 2024 10:47:46 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12716550f8f.59.2024.07.29.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:47:45 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v3 00/10] power: supply: max77693: Toggle charging/OTG
 based on extcon status
Date: Mon, 29 Jul 2024 19:47:34 +0200
Message-Id: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALbVp2YC/3XOyw6CMBAF0F8hXVvTh9jiyv8wLvqYQhOhpCUNh
 vDvFmKiG5Z3JvfMLChB9JDQrVpQhOyTD0MJ/FQh06mhBextyYgRdiE1q3GvZiGuDcdlHVuIGOb
 JhAE3oLXQykpuAJX2GMH5eZcfz5I7n6YQ3/uhTLfp1+Tk0MwUE2wNUw3U2jpO7m2v/OtsQo82M
 7OfI+jxb5kVh0gundOaSsP/nXVdP5ss+r0GAQAA
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
 Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4799;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=ZBeCVq76s1YcWohvGVE5wNLt+NvZAu6jcfawXYj2BqM=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp9W98Mdnl67vI2rkeJCCu+vhxYNNREfuNvBtU
 n3iwxgaY3mJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqfVvQAKCRCzu/ihE6BR
 aJJ7EACYEfWhfKcmtoLfb+s8cjo4YaBDhaY44DbG+hWpObrevEb3Cpe/nVxC4tyH7FWqVWjWk5k
 3+CDF3t38H355pscftMTQTs23cosdgkh2ZfJsb81CitzFJKCehwXWiVbY2fbP+w5dqmn8KsI5wi
 eKSuI5VAT8RQNkGyIC+jawaqIOWUqtTZKHXwT8xWudcJHmZkvp+NYZoyfMvWAfiN/Po+Vy5wjmZ
 kAOnWBvg2Y+qhcIfTlEis97pM0XcY74ADiN6iuoulT5J76WGt3qDXh44WXNNYH7KveVixrhb8Nd
 xGYkDx7fAMoGA8OxroyZyhs9D8cp3p+wIhEyqTKKAzdbtRD7nD1Obr9mJT5mRgFZlTIInIChzw8
 qtvaxMPvJxYs9w2ncs3miYwde4cVO8AdpXn4lhlehk0w+Jvbt+R3lphytX9eWyk/j4siTeKCcuh
 0QdyjozRefV0okQk5hHr7ZlHa4KoNatXq9Xz/iUt6wRhRZWhrzsGHsLabTwfbGbQfuyEdoJcU28
 v8dFlpAjksS1PRcPuw4V0TSbvBD5WfEzpc3PR2W/Ir5VzzLHam4eFoC7V55hRfRcTcN8FvQB4dy
 TveJfBzV3bPIvEjwMuva42sQi79JkC57dgtWiATjUOapf7jus1P9NlSv/lU9EpL1bDA2Ja/kjcu
 b/FUadLBbleBGoQ==
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
v3 no longer uses the CHARGER regulator to manage the power status, and
that's for two reasons:

- Regulator enable/disable behavior was interfering with how the power
  supply driver worked (we occasionally got "unbalanced disables"
  errors when switching charging state, despite checking for the
  regulator status with regulator_is_enabled() - the CHARGER reg would
  report as enabled despite the enable count being 0).
  This broke OTG insertion if the OTG cable was plugged in first, and
  sometimes caused warnings on unsuspend.

- Changing the charging values directly in the power supply driver is
  less opaque and lets us avoid bringing in a dependency on regulators.

It also splits the current limits back into two properties:
INPUT_CURRENT_LIMIT and CONSTANT_CHARGE_CURRENT_MAX. Again, there are
two reasons for this split:

- They are two separate current controls, one for USB->charger and one
  for charger->battery, and they have different limits (0-2.1A for CC
  vs 60mA-2.58A for input). Given that the power supply core has the
  properties for both values separately, it's more logical to present
  them as such.

- It's safer to keep these separate; CONSTANT_CHARGE_CURRENT_MAX is
  pretty explicitly only set *once* - at probe time with a safe value
  specified in the DT. This way, INPUT_CURRENT_LIMIT is safer to modify
  since in the event of an invalid value the CC current will hold back
  the extra current thus preventing damage to the battery.

The latter is relevant as I'm working on a follow-up patchset that
allows for controlling the charging parameters using power supply
properties/sysfs properties rather than the CHARGER regulator.

Note that the CHARGER regulator gets disabled automatically if it's
not used, which will disable charging if it was auto-enabled by the
extcon code. This can be worked around by re-attaching the cable, or
more properly by removing the CHARGER regulator from DT for devices
that use the extcon-based charger management, as has been done in the
Galaxy Tab 3 8.0 DTSI.

See v1 for old description:

https://lore.kernel.org/r/20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com
---
Changes in v3:
- Drop uses of CHARGER regulator, manage registers directly in power
  supply driver instead
- Link to v2: https://lore.kernel.org/r/20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com

Changes in v2:
- Changed to use monitored-battery for charge current value
- Both current limit variables are now set by the CHARGER regulator
- Link to v1: https://lore.kernel.org/r/20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com

---
Artur Weber (10):
      dt-bindings: power: supply: max77693: Add monitored-battery property
      dt-bindings: power: supply: max77693: Add maxim,usb-connector property
      power: supply: max77693: Expose input current limit and CC current properties
      power: supply: max77693: Set charge current limits during init
      power: supply: max77693: Add USB extcon detection for enabling charging
      power: supply: max77693: Add support for detecting and enabling OTG
      power: supply: max77693: Set up charge/input current according to cable type
      ARM: dts: samsung: exynos4212-tab3: Add battery node with charge current value
      ARM: dts: samsung: exynos4212-tab3: Add USB connector node
      ARM: dts: exynos4212-tab3: Drop CHARGER regulator

 .../bindings/power/supply/maxim,max77693.yaml      |  15 +
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi     |  22 +-
 drivers/power/supply/Kconfig                       |   1 +
 drivers/power/supply/max77693_charger.c            | 302 ++++++++++++++++++++-
 include/linux/mfd/max77693-private.h               |  12 +
 5 files changed, 337 insertions(+), 15 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240525-max77693-charger-extcon-9ebb7bad83ce

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


