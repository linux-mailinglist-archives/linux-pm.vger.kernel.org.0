Return-Path: <linux-pm+bounces-20877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED26DA1A681
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 16:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3638D160EEF
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB749211706;
	Thu, 23 Jan 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euHoumo0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4E20FAB7;
	Thu, 23 Jan 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644682; cv=none; b=EFeYlRoJNgd9nNA86l45wEJYmq0KE1Kq5NqqZ8+NIBB5ujuowNi/Ev5rdw43YmnLJHK3FDachalt/kbCGWHUl58G+VOcGPTMlOL87t60glMI6QVNUWBpeS3IrONl1lWkcD+zrtmmGD7n3CEz00K4Al2i7vW7/+SAIbDp9qKxAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644682; c=relaxed/simple;
	bh=pYAMylE78DUDOBG70XplaLvE0hv+KbuQajcSyAuUzGI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FNWD7iOANneZ3WHXNzx+nro4thLE+2lZqFBFetHDTDV3KO/5iLHWxg7EQR+VDrBCdaEf/2g6mLWu04KyWdsfoLcRTDI6GZHd+YB1oR8Ak5Fov72yoKf2ZzjdppUSKDxvwtScuiUhuzoquqB++X9UY4Oi/oTgI0HdNazltzPon8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euHoumo0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso1856214a12.0;
        Thu, 23 Jan 2025 07:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737644679; x=1738249479; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wngw1Qfbo332tUwRkteO/A0VtPLLJx5lhcBxfodB8jQ=;
        b=euHoumo0G15lnFlDS+qMsfijVoVyTo1TtCCbYRQSCXkrDT/NV6bIgqWUA7A9nS8QdZ
         zLuZ+f+q8zpwTPLrYfb0hhTcdroTPmRioQ0nZ5xknjyD5tpm5cmiP8/BnqL7PJ90CkoP
         wtruEe1V+sW0VieHI7PRfxTuOWcspIlncmMHxiCEQyb3VtM0AAQApqVINL5VF7dniy0h
         Rbx7vPyv39ol9qvX8dlzVEn6UsBEQ6BHpuujsN4+ZPZMo5QlL64/AxEG4PoH5COs52AI
         7DPBLgg3H9Ate9/wE7bkzi9donP8kg0ox50fFQOiDDRHcBfDl77OllscKz7TUMN/0sE5
         Jgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737644679; x=1738249479;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wngw1Qfbo332tUwRkteO/A0VtPLLJx5lhcBxfodB8jQ=;
        b=uS2DK0OA4JGxwB8NaAr/hRS2B/5AUXgey9ViwbmhnzwyXhlaa3ZPNpr7Ytze/yXKEu
         msG5M4RiKNgeknopg0kq609+TO64l4bslvoaKDIGMGiKIxbi//QbbWKN9HKwvp4t3LhC
         sLBypZ2II00eghrpbDkd5kkfXxoeexxZT18cmndiWf/VkhcW4EYHhRUL9pu4UGdYD0KF
         0nQKdjIO9jPTkYIa8RpbgyfjfKWbvUspwxGY167yEUl5/OGTAobu3bi6KgASlJKUtEtP
         yXGtbYWA5NsvbcCvF4Auni209bLHQCZhGDVXp8bcuw3HoLIOc0viIDm8vAu2vBC8n+F1
         6V+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUutnS+mlMXJPfsxY+yWPSTb/JLYCY+cZFWL+Y8muVc8xmkTIXXOqFo6iF0UwA4VSG4YY4tnAHvxiO9kIU=@vger.kernel.org, AJvYcCVaFC/1XaPKrkl0Qmin5CfR2utPmVFVHULK7wihvNL8l3miPeXuaDrVNJw4Cz0Sev4yPOuoAIAjdEh/iXYM@vger.kernel.org, AJvYcCVoZ+YniXUIzncT+a4MH2a+YpfFHLrmAgF66+lPdenaGG6Z0roY3N8KhU+bqy6rcHam7mWBvFviap1B@vger.kernel.org, AJvYcCWQZDRebUsooav4L8lyMsKzCAfRVkJibfrkMWCQ+exnQBUpre7/UmT3lb5Kzpxt8HCv6OGlcQ9VBgp23Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDUOYAXymJAc9VH/MxyQeqK9ImYn8ZDsruQ3jmB5gHyhqccrO
	pPjXNVSYpGcKiXoJwVGf3VRq6hay9QQTUq5M7xnI4c8G/9nVh+yZ
X-Gm-Gg: ASbGncvAEY1HbB6CTcZLsyjngXONKTwS+ES8k1JmPT4nYUhNfawYw5meP0LXQ+wuH7S
	bdJiRCZ6SA+cg1g7K66hVp0hJw+ytetSi9DYUYKi6em67MbL9lOdw11DE1kni3eFDQ9cAKBi9yw
	78vtVytZ3LWLZ/6dy5calQcg7qmy0RRptxmKj4gKwRwyGc3QeRr22zNBMNxdorfn+5WC+oR8/qw
	GOeaDNO4vjcgMHGTyMSh2MIG/nMSEnLYqZwfzYKJjtRiLqDVMVHAZPwWxjnDFM9kkn0FxE4tgni
	y5cxeMXCud9uYA==
X-Google-Smtp-Source: AGHT+IFCskicJhfr4+Yyi+bpW5QAdYXDnAjSRmZ+/p7hyy+jepP9pDvj/LhxaPQC+vCst9gNGbSRVA==
X-Received: by 2002:a17:907:7fa8:b0:aaf:123a:e4f0 with SMTP id a640c23a62f3a-ab38b0b6886mr2687262166b.6.1737644678641;
        Thu, 23 Jan 2025 07:04:38 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.22])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f2903esm1084727266b.109.2025.01.23.07.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 07:04:38 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v17 0/7] Add support for Maxim Integrated MAX77705 PMIC
Date: Thu, 23 Jan 2025 18:04:25 +0300
Message-Id: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHlakmcC/43UzW7bMAwA4FcpfJ4HUv/aae8xDIV+qMRA4rS2Y
 7Qo8u6juq314sN0MSAB/kRSIt+6maaB5u7bw1s30TrMw2XkBdovD106hvFA/ZB5oxMgFBi0/by
 E6fm0UDqOj8O40GEKC//0eH2al4nCuY/JGachikKyYyaGmfo4hTEdGRqvpxNvPk1Uhpf3g3/85
 PVxmJfL9Poexyrr7t8T3f9PXGUPPclijBGANqTvh3MYTl/T5dxVfFWfoEfZACoGRRZUsk7aWXs
 P6m2EDTVZdY0QQMqCCjPuQPMBIkALaBiELF3U4CHpHWg3oGhJ2TLoYwlBFhUwwD3oNqDEBtDVG
 pbAl5KElED3oP8E+dMAegY5spxkDCSiuwcRtqJqEJFr2NtMTpNypI3YkbglfQuJTOYE2jsnHAH
 uSLEhm94Oivp4suPHq1Txap+43JBNl421Y0pMBiFZcHKf+EfLaEBo6UGsPVMMOUVJQPZmR+oNi
 aaFrF2TihA+ky9W7xM3W7KplrVvEEMJ3NXCmn9Gxe33YJro+cqDcPkznW63XwsRybEmBQAA
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737644676; l=6789;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=pYAMylE78DUDOBG70XplaLvE0hv+KbuQajcSyAuUzGI=;
 b=QEU2xxMDnHmkWKD2aO2vwK7duviNfImG93DtZ6W0COqXEzkZExMswMzzkGNQcRQzRxce1TUYC
 2Njio7yeYVuCEhoQkT7mfqbe2CX1bVuJfxYOh0nGeVLP4DTi7U5GBsx
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

The Maxim MAX77705 is a Companion Power Management and Type-C
interface IC which includes charger, fuelgauge, LED, haptic motor driver and
Type-C management IC. It's used in Samsung S series smart phones
starting from S9 model.

Add features:
  - charger
  - fuelgauge
  - haptic
  - led

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v17:
- update trailers
- fix led driver regmap creation
- rebase on latest linux-power-supply
- Link to v16: https://lore.kernel.org/r/20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com

Changes in v16:
- cleanup review fixes
- Link to v15: https://lore.kernel.org/r/20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com

Changes in v15:
- update copyright year
- fix mA/mV in charing driver
- rebase on latest linux-power-supply tree
- various formatting and optimization review comments fixes
- Link to v14: https://lore.kernel.org/r/20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com

Changes in v14:
- binding review fixes
- add trailers
- Link to v13: https://lore.kernel.org/r/20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com

Changes in v13:
- revert: max17042 binding: split in 2 files, so its binding code can be reused
- include previously removed patch:
  'dt-bindings: power: supply: max17042: add max77705 support'
- use same of_node for matching simple-mfd-i2c and setting max17042
  driver
- Link to v12: https://lore.kernel.org/r/20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com

Changes in v12:
- charger: move out of mfd because separate device
- charger: add it's own binding file
- fuel gauge: move to simple-mfd-i2c along with additional measurement
  capabilities, which will be implemented in max77705-hwmon driver
- fix review comments
- reorder commits to stick mfd together
- Link to v11: https://lore.kernel.org/r/20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com

Changes in v11:
- charger: code review fixes
- max17042 binding: split in 2 files, so its binding code can be reused
  in MFD bindings
- Link to v10: https://lore.kernel.org/r/20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com

Changes in v10:
- drop NACKed 'dt-bindings: power: supply: max17042: remove reg from
  required' patch
- review fixes
- use dev_err_probe for errors in probe functions
- Link to v9: https://lore.kernel.org/r/20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com

Changes in v9:
- fuel gauge: use max17042 driver instead of separate max77705
- fix kernel bot error
- charger: enable interrupt after power supply registration
- add dependency on max17042 patch series
- Link to v8: https://lore.kernel.org/r/20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com

Changes in v8:
- Fix comment style
- join line where possible to fit in 100 chars
- Link to v7: https://lore.kernel.org/r/20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com

Changes in v7:
- Fix review comments
- Link to v6: https://lore.kernel.org/r/20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com

Changes in v6:
- fix binding review comments
- update trailers
- Link to v5: https://lore.kernel.org/r/20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com

Changes in v5:
- Split patchset per subsystem
- Link to v4: https://lore.kernel.org/r/20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com

Changes in v4:
- Rewrite max77705, max77705_charger, max77705_fuel_gauge from scratch
- Reorder patches:
  - squash max77705 subdevice bindings in core file because
    no resources there
  - split device tree changes
- Use _ as space for filenames in power/supply like the majority
- Link to v3: https://lore.kernel.org/r/20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com

---
Dzmitry Sankouski (7):
      dt-bindings: power: supply: add maxim,max77705 charger
      dt-bindings: mfd: add maxim,max77705
      power: supply: max77705: Add charger driver for Maxim 77705
      mfd: simple-mfd-i2c: Add MAX77705 support
      mfd: Add new driver for MAX77705 PMIC
      input: max77693: add max77705 haptic support
      leds: max77705: Add LEDs support

 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml          | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml |  50 ++++++++++++++++++++++++
 MAINTAINERS                                                        |   4 ++
 drivers/input/misc/Kconfig                                         |   6 +--
 drivers/input/misc/max77693-haptic.c                               |  13 ++++++-
 drivers/leds/Kconfig                                               |   8 ++++
 drivers/leds/Makefile                                              |   1 +
 drivers/leds/leds-max77705.c                                       | 275 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                                |  13 +++++++
 drivers/mfd/Makefile                                               |   1 +
 drivers/mfd/max77705.c                                             | 182 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/simple-mfd-i2c.c                                       |  11 ++++++
 drivers/power/supply/Kconfig                                       |   6 +++
 drivers/power/supply/Makefile                                      |   1 +
 drivers/power/supply/max77705_charger.c                            | 581 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77693-common.h                                |   4 +-
 include/linux/mfd/max77705-private.h                               | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                             | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 18 files changed, 1699 insertions(+), 5 deletions(-)
---
base-commit: b4a95b8fd3e67c1222c76bdd1078d43c9a11d132
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


