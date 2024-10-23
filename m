Return-Path: <linux-pm+bounces-16323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE19AD4FB
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 21:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9541C2165A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60911D9A61;
	Wed, 23 Oct 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1sQxlQP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17D81D0E2B;
	Wed, 23 Oct 2024 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712582; cv=none; b=l6clTOU3CvNVNdqw8lZ+Sp4FVNMzoyddOhc5usQPf3VoqEw4hCuG8J1lLnjQjGie9NpCreCcxqNaBbWWJ25QeOmsrR3fZ/BTpitaGRxIhrczbUQlXxHebW0G4Z4IjGqcVnw6cCXiFcHN1g5C/zduA1+bKyWX0QQFFrzTACiU0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712582; c=relaxed/simple;
	bh=tCA6fw7MBrhr9mOrTf8+DhdJnsHnrQsEXArVWZBBlrk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l+HNoj7WYVBa9tLJ09y5ijofkaUT2SSYrG1CRJueAjsqquAjEKkx6r3f40A7xPfa2yuCopwyW6urd2CG1Fpzq8ORfaKp/dwtCFSRd6QXsC9/gQqERL+c8IrQkwkpKmHulXL7sdsoqzu3gyJvRtjvy/2Id4GyGydviGkBhtwVVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1sQxlQP; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so987221fa.1;
        Wed, 23 Oct 2024 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729712579; x=1730317379; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RhbLCrIKCahQuoN9WUphMNRLJJ3fa6OTKAHMEZIGPB0=;
        b=l1sQxlQPRGf55GS9v7XWLR5fybatJ9b3ZFqsbEAAa0tmgcvJ8ba5eM9EfuXaS+9vnm
         JCb4c51vIdqBLBojSRBtKZ3pa0meqzMoOqsJyt8Fyw264G6p8AIyWyCICd8AaoH4HtCA
         gQKGbCegKQIODdoMjq4bL6xjQ22g/C3qjpXPhGpyssm19xMKyYsoe90nYkVSkqn7GNoZ
         41oysLNUyn+NED2gTJ0znLaNEmfVCMqyg7Ry+xzyfGcm1njvfcGsOiWjMGS3qZ/lVYPi
         GDxxHAllxecXDAmN+ssN/SHXrW0LQwKYFLFQ333Th6tbPNOL6gAADQtXuJ01g/C3l7JH
         SN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729712579; x=1730317379;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhbLCrIKCahQuoN9WUphMNRLJJ3fa6OTKAHMEZIGPB0=;
        b=OB9iJEZZBVDM8g2mFnVe8XxUAtDht50370UFtWcNwFDeUTIgGmToPibIMzlNQm49zW
         Ke3mhLMD5PIFn3MV9VTGJA9NYOZtQyGfN3hE4VDGwgngHNArMBMoaC0Yuy/xels8+gDN
         f0dRYx5XD6cMVxXINP+oqHJX8pQRQ8yyHFjLqFN0rO3ZbFXGjufAyvkEolNGFBDXxkJG
         WI6WC0sunGF0njqkIk/4wPAn+186Iog7aJGFVnx8gabEgrM2oN3TqU61Il75QC/WUsxf
         EstUJZjkgnDukkqg1sHuKAPDx+TxNOuTDJRxGzQtJ4Im1Jj+p5QXcEjZVgHI032kpxpi
         8evg==
X-Forwarded-Encrypted: i=1; AJvYcCUE+NMKEd+0PHJ7d1DKXf7XPBQL3jg+xKAxQpMoyt1Fe/s45MZgM4f+vIWz3FAZyqeJG5TR4umfk/Nu@vger.kernel.org, AJvYcCUomC/cmyhZq7GA1SQGBDheiwxjc9//sUaWWbM7r97fZ8lBqaaW3P/SbA74BOv7+Z+ClE9+9ChReWcqLSTn@vger.kernel.org, AJvYcCV/6wPDlzq6SNiLaGuhlO1RukCE+7TMAflPXBMWZTVSaIvPlujq1+0cryy8RDwZR9B92kf8N3sQp5DDLQ==@vger.kernel.org, AJvYcCWfrDd/s2F92hrWsZ9/hM2tMxHA1hA8sZtoz5U6jdGo3Kroij+fBekbwL0MAGDcimG3FYW3CmnBXQ/h8jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtBQZ846R5rk/FOBfAH0bdntYbSjIKYZ0hnSnhZyOYpY1k86L
	OijbGZaLAIlEq10s3OjXl52z71tumITGFVBwFDXe4uEDPCdO5sx1pIMYhg==
X-Google-Smtp-Source: AGHT+IGoOK01spO2Q3H9lmeaZa4e6Rq/V0S5zzHLf/ni1DhBL8Y8pIZE9kHVeUw88+6Hktw7qtRsNA==
X-Received: by 2002:a2e:a288:0:b0:2fb:57d6:f464 with SMTP id 38308e7fff4ca-2fc9d30ef7bmr18046541fa.20.1729712578385;
        Wed, 23 Oct 2024 12:42:58 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.244.166])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b1d8sm4803940a12.72.2024.10.23.12.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 12:42:57 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v7 0/7] Add support for Maxim Integrated MAX77705 PMIC
Date: Wed, 23 Oct 2024 22:42:48 +0300
Message-Id: <20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALhRGWcC/43QzWrEIBQF4FcZXNdy1WicrvoepQzGXBMhMVN1p
 GXIu9cM9H/RLM8Fv3PwShJGj4k8HK4kYvHJL6GG9u5A7GjCgNT3NRMOvAHFWpqyiS9TRjuGkw8
 Zh2hyfXO6nFOOaGbaWa20hI47FKQynUlIu2iCHSsULtNUj+eIzr/eep+eax59ykt8u80oYrt+N
 Or/G4ugQFE4pRQH1hr7OMzGT/d2mcmGl+YLPDKxA2wqyHuOrpdW6rb9DcrvC3f8SZHbQgAhHGt
 Yz/6A6hNkAHtAVUHohe4kHMHKH+C6ru+MW0Pn2AEAAA==
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729712576; l=3825;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=tCA6fw7MBrhr9mOrTf8+DhdJnsHnrQsEXArVWZBBlrk=;
 b=iJCye/ip5nY1sYZWNwja3osS5QzB0nWVM549PsVhEyPmegK/xYuwk7wAmjXeAXX6RVKVo+dLm
 gE2GyWUYoeABW8ueEEt9EQAakLg4Ch1O5EJs6V789i/dMfTJWXmX6T9
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
      power: supply: add undervoltage health status property
      dt-bindings: mfd: add maxim,max77705
      mfd: Add new driver for MAX77705 PMIC
      input: max77693: add max77705 haptic support
      power: supply: max77705: Add charger driver for Maxim 77705
      power: supply: max77705: Add fuel gauge driver for Maxim 77705
      leds: max77705: Add LEDs support

 Documentation/ABI/testing/sysfs-class-power               |   2 +-
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 174 +++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   4 +
 drivers/input/misc/Kconfig                                |   4 +-
 drivers/input/misc/Makefile                               |   1 +
 drivers/input/misc/max77693-haptic.c                      |  15 +++-
 drivers/leds/Kconfig                                      |   6 ++
 drivers/leds/Makefile                                     |   1 +
 drivers/leds/leds-max77705.c                              | 168 ++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                       |  12 +++
 drivers/mfd/Makefile                                      |   2 +
 drivers/mfd/max77705.c                                    | 224 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/Kconfig                              |  13 +++
 drivers/power/supply/Makefile                             |   2 +
 drivers/power/supply/max77705_charger.c                   | 602 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/max77705_fuel_gauge.c                | 364 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c                 |   1 +
 include/linux/mfd/max77693-common.h                       |   5 +-
 include/linux/mfd/max77705-private.h                      | 198 ++++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                    | 215 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_fuelgauge.h                  |  60 +++++++++++++
 include/linux/power_supply.h                              |   1 +
 22 files changed, 2069 insertions(+), 5 deletions(-)
---
base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


