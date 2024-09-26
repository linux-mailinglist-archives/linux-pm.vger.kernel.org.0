Return-Path: <linux-pm+bounces-14813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A50D987134
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 12:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0EC1C22EBB
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF71AD413;
	Thu, 26 Sep 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhcjoVNP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA21ACE0D;
	Thu, 26 Sep 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346052; cv=none; b=a0aFKEq2SRncqm18jTsTc5AX8zA4mQ+qPMiPFYnyXmV4+R8vsOpwjj+oYU+K73tPFDfVUOfHcYDDTJHlcgDdB4/7UOtgHFwxWxx2mW6YYPEm/FdvuQFF7YN9HKgjWDNEtclI4gGSxmAz6VoROwMp5NkvkKex4Pp5bcD5OyJdeF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346052; c=relaxed/simple;
	bh=NuL4dI2poc5wNfVuOhusNAL0N90LbOn9S9VV9BLqC8g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pFPSJc3K+Md9vdMd0zgD74wWxckAEMEp7OATZIi4bZDIkj86r3br5gubGa+3zgwMVrMRth5ogOOAYJMK8zSfU6NUIAbWvNUJ+O5Cwm0A4nfq/3W3NoWfQrb/R8gAtu0MuKoi1Wq8QxDEw1s9frJ6sKz4aCujQxhxWb88TQbBLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhcjoVNP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso1206449e87.2;
        Thu, 26 Sep 2024 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727346049; x=1727950849; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8IVre1yMyrMqTq/PbcIC9hra/9CR9DAifO0gVMmtGPY=;
        b=AhcjoVNPbbsZMJabNv+Ye1FEaaPDnhqGUJo9nxBWQBSHnd4nq8VMTVpMtwR5OXT9l8
         4Y81wmWVUkkiSpqg3GsGt+DW1y/CsL1CZiHSYiw4OdhW/pxvspB1jVcb1hSgGAf6wy//
         AosN4hJxwaeYxe7OYG9+AR2WB3d5dmCct9mh23ewm0JDqJzcbp1oaUhblHzG1mWazTWS
         avrBe8kQkF1kpMSiaXbxEKmxFLX8VQ5cfxvWcOT5oWFb6HDVhnqGSCUxpUJmSwi8Xodz
         xw3lLZsAZG/GXIZCxQ5tBSffN3Jj+zq7cc2uzzjPBjlMi7TiTTTEBEtAtgbvLFG7EI5P
         iCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727346049; x=1727950849;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IVre1yMyrMqTq/PbcIC9hra/9CR9DAifO0gVMmtGPY=;
        b=JJ302NOM/UEILupiVeHqF1O3jOvEr14n6/Rt3mMpVINfrbvRKGyaUb5SAoRSguVCVQ
         3CGqIWCoYog06wQD4+fSCNPqPDeb4PEqIjqRioM/NLMJDVKe/RHQRVN2IMqCd72+oEY0
         jf3GwI93itOFT3g3ath+OAfWlzsOv8dVhZ+YyD6dnt0NryWzRsn+Ymg/bhWBUxnT9n7V
         8BD75As95KI5Z83ZeY4fBaClVd6sCKlpf+O/tF9GQ46saIgli7MmwfE5i6grAs98xtVa
         QHiS2Pfyjx/aNCnqueeIcFbAnkDWlE7U6nSkTlZ/nSZJZyXaUtbFlkoVitjs2VO0B/JC
         lXSA==
X-Forwarded-Encrypted: i=1; AJvYcCVprT1wDR9naVw/eQJKRgF3Mr0k86dzAtwho9UjHqto+QHrDoztaKN2reAomwE0oschNjG/dW6YsyHxPME=@vger.kernel.org, AJvYcCWCNEd9KGBhwChCdXs3Z06/1VkIMQsyNhhEADevDd1i6rXKj3m/bMhDfddE1uoYtCbTW0vESlS9ep4bWg==@vger.kernel.org, AJvYcCWiwQn2Z93TCjDfa8o9qkQu/XkJsSmYYIVdb//NZchmMcjzyWD5dM5BLE0BXi5L8Y3j5G+C6bT90Qu1SQhm@vger.kernel.org, AJvYcCX+W6K6xFA+mfF49ZRPatw4bpnDHL/P+umvTKV8X0j691iTkZaDHH0VRUghpfPBTGbyhawwWs9F4IOM@vger.kernel.org
X-Gm-Message-State: AOJu0YyJzq8RDQz2gaKRTnMpZr4TB3Ezge4MB5z1vsYt1eHejMfvzY/D
	ADo1KcjYIO+mPQT5l4T6Xxs2fyIW1/jHQZlB3Gs3apYBHLVKdKQJ
X-Google-Smtp-Source: AGHT+IHhBPBUZ84Fgt19/l7LY0tBpRg2LadPCUuvfGyPkpOXS7Cr4FdmWzOS4+1f8kb8oCWhWOBAOw==
X-Received: by 2002:a05:6512:a8d:b0:536:53e3:feae with SMTP id 2adb3069b0e04-5387048a6cbmr4909154e87.11.1727346048462;
        Thu, 26 Sep 2024 03:20:48 -0700 (PDT)
Received: from [127.0.1.1] (mm-20-1-84-93.mgts.dynamic.pppoe.byfly.by. [93.84.1.20])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-537a85ee54esm759071e87.96.2024.09.26.03.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:20:47 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v5 0/7] Add support for Maxim Integrated MAX77705 MFD
Date: Thu, 26 Sep 2024 13:20:17 +0300
Message-Id: <20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGE19WYC/43O0Q6CIBQG4FdxXEdDULCueo/WHOJR2RQNkNWc7
 x66tbqry//fzvefBTmwGhw6JwuyELTTo4khPyRIddK0gHUdM6KEZoSnAjsv7b33oDpTauOhtdL
 Hm3KenLcgB1ypghc5qWgDDEWmkg5wZaVRXYTM3PexnCw0+rHvXm8xd9r50T73NwLb2vdi8XsxM
 EwwsIZzTkkqpLq0g9T9UY0D2vCQfcBTyv4AswjSmkJT5yovhPgG13V9Ad5rAaM2AQAA
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727346045; l=3311;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=NuL4dI2poc5wNfVuOhusNAL0N90LbOn9S9VV9BLqC8g=;
 b=O+7i7z4OuBRIMMt8I9vxRGXW79EiAJ2IYyvi/vsFtSdHQIfvus9bWWBctJ7qdgF8Kwl3ns308
 SQZHXqt24KvCRrQpY+25jwdqULhwYfzOs6ETmeIb8JOD9FwRTVFkPbE
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
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 177 +++++++++++++++++++++
 MAINTAINERS                                               |   4 +
 drivers/input/misc/Kconfig                                |   4 +-
 drivers/input/misc/Makefile                               |   1 +
 drivers/input/misc/max77693-haptic.c                      |  15 +-
 drivers/leds/Kconfig                                      |   6 +
 drivers/leds/Makefile                                     |   1 +
 drivers/leds/leds-max77705.c                              | 157 ++++++++++++++++++
 drivers/mfd/Kconfig                                       |  12 ++
 drivers/mfd/Makefile                                      |   2 +
 drivers/mfd/max77705.c                                    | 248 +++++++++++++++++++++++++++++
 drivers/power/supply/Kconfig                              |  13 ++
 drivers/power/supply/Makefile                             |   2 +
 drivers/power/supply/max77705_charger.c                   | 585 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/max77705_fuel_gauge.c                | 348 ++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c                 |   1 +
 include/linux/mfd/max77693-common.h                       |   6 +-
 include/linux/mfd/max77705-private.h                      | 180 +++++++++++++++++++++
 include/linux/power/max77705_charger.h                    | 215 +++++++++++++++++++++++++
 include/linux/power/max77705_fuelgauge.h                  |  65 ++++++++
 include/linux/power_supply.h                              |   1 +
 22 files changed, 2040 insertions(+), 5 deletions(-)
---
base-commit: 3469b89bd13f10d679d1b1f5b47fb71953e96349
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


