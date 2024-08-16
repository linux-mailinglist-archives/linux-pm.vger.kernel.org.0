Return-Path: <linux-pm+bounces-12320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 977A89543CD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173571F2267F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A2112F38B;
	Fri, 16 Aug 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR4ut5Uc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA382866;
	Fri, 16 Aug 2024 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796357; cv=none; b=P3gNLRnemQ19zwVclGSKcR/+CbHBTrmcntVNOsurvpYwcYwpgGcphUSFJxyY6iR6pPty8iylgHJV93YcpdSY21UpzMgzu9Nh4geyQnjZzJrnzq4l8yrxu5h1B8Zyz5xrfpAOwz7MBhTV0hGcbH0OxP1dlIuY4fIB8Sy8vXbLz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796357; c=relaxed/simple;
	bh=6h9z8ocfL2XATSNX1s5d9pI5+s+N88N6/riFX1N5zSI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aCpYgWI6Lw1Ds3jqzNXhj9mauXjkybju1IXx944Gv2QSO1aqg86xGt793rHPsLTjdNLUFQPjaiHxDmGSLxKdPXN4GqLsgHX8PccoU7LHngQ/Uf52ukjwZu5POhU329erjWxIGoDCv3r/AxlhVbM//onVyw9XbkFUvf6BfPvlKps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR4ut5Uc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso12855345e9.0;
        Fri, 16 Aug 2024 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796354; x=1724401154; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtDygU8gueGwJ3Zdqpj2DOV0h4FMxFQXx/h+FOpbWvI=;
        b=hR4ut5Ucbu5GWhNsBAIYh/BQ0CR1y/TACDmtyoCkrFxBMLQhUK/rURI7vxZS3RZZBZ
         i/x6zRJRh2ezGL0VWm+4fY22k2+RYlXvW5JNMqTqNJS5urkSE+cQ3RYYsyYT5gRi9mUo
         V2aBx7e3hWo2NZ5KnVvFwvZl0GSZxoV9OI3QEXcWyG53U9whBkMgs4E0wa8HOU/q+0Lu
         qmNUN4inj/CwbC1YaKag1bZ69F7ld34B8G9aS39q9oXvLBOqi6cD8VJQJEZYiFFTHFbK
         RwGseKMe8flaneqyWvHISu4S5M+ss/cEjcYz3SQhw6wsysYmhY84I7LO6HDT+/yH5nlb
         AglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796354; x=1724401154;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtDygU8gueGwJ3Zdqpj2DOV0h4FMxFQXx/h+FOpbWvI=;
        b=AYqHmPsSIzJggr0KJ43wvbYT9oF8H0MDOAEum5gbG5AdBF1sJUriizS9Y2m14ya+y1
         V+2S1Vcfaa03J0kQrlrKkGadVzTtCUiVdmVGA94rMQq7B+V4Qms0wWK22Vhe2g243ob9
         wKmq6nV/7Sy3Ydz1bclBCcQDoN+YkmH5EUoR/8oSlnJia871P1lo0FkJDtD6d2KwvECM
         Ltal+YeUDAkCL0dF96v1WEaEdAQ/YhEdVuBTRUE5irfyy3ssxYGjQ25Unrx89BC/G6fe
         /gKtX0ZBAtLpQMNvpiM1qytevtzvOl5CvF2t+hCoim4gmRr36XzWXES1z7BRJCYo1WZ5
         Nb2w==
X-Forwarded-Encrypted: i=1; AJvYcCXjbPV6+3RdPP4ZXeEpWGjeCG3Z/g1GE1xVgeEU1LNGrRHLypi25tCxdqXjhsWf2WOKqbwvTavGsldbOyyim0u5vzrTPpz51rwJqzwPCavG+k21gKx5t5GxLIRxq6yllJ1tkDZ0G8lQ6dW4VGIN7OOthjD+zIblxIB//XH2601C2vFm9A13u4HUzG1lrehewNVzNgLo8lb3dmrjiSCVExXLFqwJlyo=
X-Gm-Message-State: AOJu0YxEU30aIcs0nZvvY4ZQ/EwHxN4B+9N6SumSSI4puw6mACzWEhxj
	2jEMDrLrIt80tJ4EuK7fS6BRETeeQKDvsfLl2Zm37bn1UbY1xzNT
X-Google-Smtp-Source: AGHT+IGNbg3I7QZJheZdQ8rGnj17FDcQiRIrDUrcZBBxXAtfo3ghCe3iY1GPVaXX7Lx+R26mA8BcUA==
X-Received: by 2002:a05:600c:45d1:b0:426:5cee:4abc with SMTP id 5b1f17b1804b1-429ed7b69e7mr15546325e9.20.1723796353283;
        Fri, 16 Aug 2024 01:19:13 -0700 (PDT)
Received: from tablet.my.domain ([37.30.8.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm69732645e9.21.2024.08.16.01.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:19:12 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v4 00/10] power: supply: max77693: Toggle charging/OTG
 based on extcon status
Date: Fri, 16 Aug 2024 10:19:06 +0200
Message-Id: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsLv2YC/3XOywqDMBAF0F8pWTclyfhIuup/lC7yGDVQtUQJF
 vHfG6VQKbi8M9wzM5MBg8eBXE8zCRj94Psuhex8IrbRXY3Uu5SJYCJjuchpq6eyLBTQtA41Bor
 TaPuOKjSmNNpJsEhS+xWw8tMm3x8pN34Y+/DeDkW+Tr8msEMzcsqos0IrzI2rgN3qVvvnxfYtW
 c0ofk7Jj3+LIjlMgqwqY7i08O/AzhHq2IHVEcBzXchCuWzvLMvyARRNLopOAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4991;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=6h9z8ocfL2XATSNX1s5d9pI5+s+N88N6/riFX1N5zSI=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmvwt9/xI5SBsf/+z7dMXn1agclu2xIMH1MNshx
 xKSiQPwujSJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZr8LfQAKCRCzu/ihE6BR
 aMr4D/9uiT5kwxvbyjh6f+350O+wBpl/dc/tthZezeLzvz/ovq0TjYpXN7A/OOmFVdQWk8mo5Jb
 jv0QRYyppxvIsmxbK2zvbV7KmlHH19v8482DSCFUYybk8zNYrvEXN7RgtWw5YHyuUKd/4biKOBL
 1BUMw47CmpmyctbIgemvtfW/1oRflvzkq1adhqTdCwWv+oLqXStH8PP3BJnh6lDkqMiw07moNhF
 oXigDotDgRuve0+jn4DZD3fQTiFqo618GnTxN0xEFBMhKPI0wowJi9aOoXG0gFGECWmhijw6I4D
 I5U8rhIMD5R2bFD17A1EEOWwobjevNE+h6fxO4Wuee5e/zaRb6VKBkSzK+aThpLG/GmTDfH2zak
 nd1AUiOTfqQRlG8rvnXzQRJJ+nz5kytxQQjHAR9HWDtAaKIe+7tMTNL5OkCEuseO+cSt0Rx712p
 vP3hfOmpeds/gHlT1uM02sU0CNXR5v4vOa055FtIu64/Lcfny2YNYQleajAZTDgJ2lQPjsfHt6E
 Yy9scDrvd66VPxZkBcCJ7hDX1BH1+F/vey7DpcCv2MSPYrDERFjaGjvs/EhgICRk5Cb4/JNj2kq
 isWU86FIe4H7SQJps/LVRZlSUtEv3+/+/HySRSc/21yr7Z9RPSlYAo+6GJWwpRihTx4WW6prNPn
 t9oycjk0T2zeShw==
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
Changes in v4:
- Fix probe deferrals on missing maxim,usb-connector property
- Link to v3: https://lore.kernel.org/r/20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com

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
      ARM: dts: samsung: exynos4212-tab3: Drop CHARGER regulator

 .../bindings/power/supply/maxim,max77693.yaml      |  15 +
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi     |  22 +-
 drivers/power/supply/Kconfig                       |   1 +
 drivers/power/supply/max77693_charger.c            | 304 ++++++++++++++++++++-
 include/linux/mfd/max77693-private.h               |  12 +
 5 files changed, 339 insertions(+), 15 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240525-max77693-charger-extcon-9ebb7bad83ce

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


