Return-Path: <linux-pm+bounces-15279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF6599321E
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BBDB257AA
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A6C1DA0F1;
	Mon,  7 Oct 2024 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG97wFtG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EFC1D2B2F;
	Mon,  7 Oct 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316564; cv=none; b=Fla/zgbir/ujf6vXpO0MR+e3oeaU6QKHbcTGdkE2bVPYTVrGK/11O2+go2baNnhh73VLtosqNhyAOtg+pzvZjwUcMz7eS9Tdd785UCHmdI/07RAFsV2hdSVhbjldwVD0iPt+AHUhMSrxfBYXFBXgA8QFFuWsQCEwMAczN3jYksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316564; c=relaxed/simple;
	bh=U3I0Yeb7/KB7xdTKRwbimw5rVxIsm7Qjs67Yaxtf1fY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T0chn8MPXKnvuR3CTYT7rKp/2vFceiJQ2GR3Dxap3lKCVM8JwUiFiiWi9v0MzWg0Pt7gslEBJCIFQB0xxj15qIq9AqJPHBU2iZhMc6/vdN3XpUA7akP/ik+zaPcOjVcYT8nloYB+9gJi3pmNA0qMKTra+0ahEStV+n6NJYhN16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RG97wFtG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fac187eef2so54902281fa.3;
        Mon, 07 Oct 2024 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728316560; x=1728921360; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvK5muP8pA+viykzfE3EvXhLc3LMfxtLGQJeAfH0CQs=;
        b=RG97wFtGK77l9lYCwD4N7nOi8qYqADQmokhYMXgJb8mCjBIEpCYdHKSPuKYu3zzXAG
         oNgPX32RS04T3MagcTXGaGaHAVklMkmoMAr3RNeZQBjx9m/uEUbtJ19aEPwxpI57b94W
         no9FULgYqRJKCAZzb5Xtes5hYK9IfO0Q5ugm/CxsXFMTZq9JIm1UsKnPc+nackb/a8GR
         Hgpg4iuNQ6O2fbzsa9WiuME3I8AQ7Gn5toyY3EJhmk/xRy8o+7OdV0JWN3jHTRIi+v4d
         9zVffIAYBpwdsc7dslF8oOsAclW4W7OMY4zMZaspz3eIfWNZFVdyclcgORDtVd3jpETb
         dy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316560; x=1728921360;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvK5muP8pA+viykzfE3EvXhLc3LMfxtLGQJeAfH0CQs=;
        b=shq2NHUO9Rw/qzwAqy+w9AGatJYHU1w4iZoS7pXsqUnTDN3QYyNN9Nja1CS0Tn6Dto
         Kn8g436BhsH24eJCGDv8bJ0SESHqeCh4JL3iNDogsVRMGHNzMbFepOZEpve39eVtpx1F
         PxCHvl+5HcSI9Gndfnn1FDBE2ci/8z92GGxlqFBwmtpcjwm1+vlsy1d3GvlOEct3HQyB
         y/4WtTDoMyfX73fGrPQQJo8iGaHsNJOpFD6Bz7uOrZEGd3eF+CzQYvUoJgKwi/bQOkUa
         sc3uY9qHt9Rl5o93NM5G9nIrQbsg7WvJkA+8XIW3jE1QgGGaabMi8UoNbTln356cKXa1
         Z+Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVd8UOenGJm+44L+mmGAPJYh8lT63gHgXETkn6zoMLb4D9age1o7MhfzQEbLA189sz7ACY6/h8xbgMmNw==@vger.kernel.org, AJvYcCWHyrPgPio76X/gpFj1kDan4xU4+PucBhPze0jrPqdmzteEaaAwBW21/eKIu4y+Gj5HE04kjkz7hseEwC+j@vger.kernel.org, AJvYcCWZNr1pgLoucqfDfEMomRNWyxd6Wtm6zzBHRug0OnH0k3lhsPM7AU4/995weEVDXr9eS1X+WtCUROtF@vger.kernel.org, AJvYcCWcfXvpgqf3ZWvp0SNflBpzcGugMUlGVAN4PGhyXgCU3Q6BZ+4pO4amWAxvfwKASJwi1wBGPz9Rwlvb2cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtGpkm/A3Mh73Xtsne0YLkc12HBePGhCkBVpEe+eJ7PKZyIvF
	gr5D4lM88eKMD06waBsBuQat5RADsFH1Wa5fLpZc6awXc/9NvHg+orfRsQ==
X-Google-Smtp-Source: AGHT+IGQ/L05LSerhKxoSZS6+82yLgfXH0sh2pWfjzOSNs/tBMLSzWtm5qLGKNZK3aYoeNVam6T5Uw==
X-Received: by 2002:a05:651c:19a6:b0:2fa:fc41:cf80 with SMTP id 38308e7fff4ca-2fafc41d377mr30498271fa.43.1728316560024;
        Mon, 07 Oct 2024 08:56:00 -0700 (PDT)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-75.telecom.by. [46.53.210.75])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2faf9b24a22sm8552461fa.93.2024.10.07.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:55:58 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v6 0/7] Add support for Maxim Integrated MAX77705 MFD
Date: Mon, 07 Oct 2024 18:55:48 +0300
Message-Id: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIQEBGcC/43Q3QrCIBgG4FsJjzP8mW511H1EhHOfm7C5UpMid
 u+5IPo5qcP3A5/3xRsK4C0EtFnckIdkgx1dDnK5QLpTrgVsm5wRI6wgkpY4ROVPfQTduYN1EVq
 vYn5zOB9D9KAGXOtKVoLUzABHmalVAFx75XSXIXfu+3w8ejD28ujd7XPubIijvz5mJD5fn43V7
 8bEMcHAjZSSEVoqvW0HZfuVHgc046l4gWvK/wCLDLKGgWmEFlVZfoPifeEff5LEvJAQzg0taEM
 /wGma7j3hPK6HAQAA
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728316556; l=3619;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=U3I0Yeb7/KB7xdTKRwbimw5rVxIsm7Qjs67Yaxtf1fY=;
 b=sFZL1yOHgDza3Uqx9TSj9mWn6wyMQl9WCorxQ8f1YG7NHKMDg1VYH+1oLzYPI+MPfaa6ta24P
 SexAOaMESv6DyLdPf5DjMVtoEoIe/2OrTWGTCjhTzXFW7Whsb8mv2nU
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
      power: supply: add undervoltage health status property
      dt-bindings: mfd: add maxim,max77705
      mfd: Add new driver for MAX77705 PMIC
      input: max77693: add max77705 haptic support
      power: supply: max77705: Add charger driver for Maxim 77705
      power: supply: max77705: Add fuel gauge driver for Maxim 77705
      leds: max77705: Add LEDs support

 Documentation/ABI/testing/sysfs-class-power               |   2 +-
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 174 +++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   4 +
 drivers/input/misc/Kconfig                                |   4 +-
 drivers/input/misc/Makefile                               |   1 +
 drivers/input/misc/max77693-haptic.c                      |  15 ++-
 drivers/leds/Kconfig                                      |   6 ++
 drivers/leds/Makefile                                     |   1 +
 drivers/leds/leds-max77705.c                              | 157 ++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                       |  12 +++
 drivers/mfd/Makefile                                      |   2 +
 drivers/mfd/max77705.c                                    | 248 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/Kconfig                              |  13 +++
 drivers/power/supply/Makefile                             |   2 +
 drivers/power/supply/max77705_charger.c                   | 585 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/max77705_fuel_gauge.c                | 348 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c                 |   1 +
 include/linux/mfd/max77693-common.h                       |   6 +-
 include/linux/mfd/max77705-private.h                      | 180 +++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                    | 215 +++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_fuelgauge.h                  |  65 ++++++++++++
 include/linux/power_supply.h                              |   1 +
 22 files changed, 2037 insertions(+), 5 deletions(-)
---
base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


