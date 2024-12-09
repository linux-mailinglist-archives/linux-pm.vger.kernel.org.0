Return-Path: <linux-pm+bounces-18813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B23B9E9233
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 12:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FE8164051
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805D921B8E1;
	Mon,  9 Dec 2024 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4/dRdPQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DEB216E27;
	Mon,  9 Dec 2024 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743761; cv=none; b=CGqKpbmGwdxS3ZlM5kN9T8ikx3vvxo9jYsWweFK2dh3+5wPNsbvGIX9jDRsNVqEbp4eGeDYetHT7dp7LiKp2skt9n3qjNkkgjKqyWdvapg2pHLzio/2M1IIEWnKFP2vyzTv1B4e236OK1o2fAt71HBZRIUJC3P9MzPPrLF556iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743761; c=relaxed/simple;
	bh=+2bBr8UNbtzGt4udsZBovUPprAfDHhjqZjrOn8coKRE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VFRckfQ+aOCRytizn/JTK6TqZ5EpKa6AV2clWJLfKyn821AZWJ5TB0+TGTqUZux90RNIQt17O9LXPcmEnKUt1lYEN378ZWjzmtbmXibN8rEMAGTm4wdB/eUGmx8A+7C5xo3Mb6n1aRItcZfKs0Fl1v1N10YqWRZx1wuM1nGWLfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4/dRdPQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so4187850a12.0;
        Mon, 09 Dec 2024 03:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733743758; x=1734348558; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYEKi+Rkyd0R2gXmO23GA724I6ChWaqLwkjWPF70rxw=;
        b=a4/dRdPQ5vTPDooW8B+19bGO4LU21c0Tfr8HoK4qHJMPUXtTTeO32sYj3M96zrgUEA
         FY3vvlOsXT5hdEgLTS/acSQFv9uWji938lkk7dxnfmv2CjZafUeefrBf0HLXv+cMOtpi
         aEViq9Gq2mM3VBdKyrk8QEJzhJRShDHopJ1FexWzwjaA8NY5cUfq/oQRotEA8arCkTSQ
         Bh/g3WeMfeXiPunkjkLIUKwfs7z5F8e3+I2MsWOYuhW1nsrWIc2sR69LkiDNBrmBJcQ+
         jti/4HNgBO+uRYulrGQ8uQPcDUQW7/ePH1y+7RTX+ypKAFrBOf4AhWJBlHztAOXZnBh2
         jmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743758; x=1734348558;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYEKi+Rkyd0R2gXmO23GA724I6ChWaqLwkjWPF70rxw=;
        b=GijmsZmocf1Ah5XPSnhRfMKR70UMxvZ+H26fF9T8TRM20nxaU+Bmk0fABOyYecebbv
         RQiQ/5vmvfeor+wwdIBufI9JD0S9jKzmDzazUWuytAxiwn1ciVYPYV9HcQ93THWRRQhR
         4NJPRyc7zRkjiedA9pW2+WGEpffRYNcUgqE4qo69ITudBX4+vOpZRDwpgU5l4f12nYZ0
         wh/KoHrX+DV5jXVo045e6X0NOp4PTE6CYJUdRJ4m5IxnbA3FIVHY+NvWigQ7fpvhc3YB
         /6MsZbdgHrqbglQRfYdK7FGtVIgN9qvZGduRi8lIC6CQnP3E9yNybfa6cIyRJ+RHoqlB
         0aUg==
X-Forwarded-Encrypted: i=1; AJvYcCUG8IEYmlFZNhqI4894cGlEhNSWMRWQ+/esLCMQa+ciN/E6mPmMOUvOcAcb9bZCvWY+MGxMxKEem2x/@vger.kernel.org, AJvYcCW2Fj3FrHhSewbxR9N7IxE4c92DtSla/kRoMZJ+0RbmAHaqreBMYWxG8Den0Jw43V2y0qs+1JrpDSkIxjmd@vger.kernel.org, AJvYcCXT9ehLCzXER+TtfdnQi6AhG9xhvWUyro/sIX2DpctOD3egHCT30DkakwkxaXDUImbIwt9VdvdfkeOmaw==@vger.kernel.org, AJvYcCXvyDAYdS1Rhp7FFtMoSEvLNhqt/k85WRI6vxccc4Ut9WYT6xxS3wBVKbxoD7eL/Z2i2qWtY8UKhjrci7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBNLr58GZSPFJ2ijfqq5mTY7goF1PtfZ2BvRS5yEk3QPIJHizZ
	Ap1xtSRbrQlOLTg5f+ptBls1LcV1JbTNVp0j0zR+yBdB3NkAetnVTbM4Pwtx
X-Gm-Gg: ASbGncsADJPVokx+QCYD3tVx1r4m0nO3MatYZrhAt018L3QPPLBcZvRpyTFrBZVdqig
	2QX1SwYFnPRHBFpdL38ZxeUXV/7+RgeQ6k8SiUCXF2PzVvmcTHxBroodyaS/JlWPkIcOyw1ouPc
	aTLAJLlxHhcbeFkjhZUkZgF6K9mwGv2lgWU1oYH5nCevD46rtXU7SAMeb72k3Pg6DVlWiQfo/eC
	k8eba2oiA+S6QYW0sdrxFwdcLtinlsnpoB/w1iiCP9iaZgL
X-Google-Smtp-Source: AGHT+IFs82PycH0e0JljkwUgCwpxT6iy6z2/u5edqNGXBl1wL37dSOBnHYGAkfdnInmnuKhvL01v6Q==
X-Received: by 2002:a05:6402:3719:b0:5d3:ec6e:64bf with SMTP id 4fb4d7f45d1cf-5d41864318bmr202548a12.34.1733743757632;
        Mon, 09 Dec 2024 03:29:17 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608faesm5980350a12.44.2024.12.09.03.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:29:17 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v11 0/9] Add support for Maxim Integrated MAX77705 PMIC
Date: Mon, 09 Dec 2024 14:26:24 +0300
Message-Id: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOHTVmcC/43T3WrrMAwA4FcpuZ6H5P/0au9xGEO25TbQpJ2Th
 h1G331uyzkL3cVyY7CCP8mK/NmMXDoem+3msyk8d2N3HOoG8WnTxD0NOxZdqoFGgtRg0YlxovJ
 +mDjuh7dumHhXaKqH3s6ncSpMvQjRW28gyMyqqUygkUUoNMR9hYbz4VCDp8K5+7gl/vNa9/tun
 I7l762OWV2j/zL63zPOSoBgla21EtBRfNn11B2e47Fvrvisv8EW1QpQV1AmyTmZaLxzj6BZVri
 iJ7O5VgigVEaNCX+A9j+IAGtAW0FIygcDLUTzA3QLUK65sqtgGzKRypqQ4BH0C1DhCtBfe5ip/
 pQolQJ+BNtvsC4rwLaCtbIUVSCWwT+CCEtRrxCx9lC4xN6w9mysXJKX+5gWfj/XZzHdZ/U+zfV
 7303bTdbeRk+ENnh0MlsVUooOEC1B9K0jl1UG2Sxf03ZzqxDBi6BFTx/oQEvRKrA5OkOZeFsn9
 vVy+QKEy/HTngMAAA==
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733743755; l=5509;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=+2bBr8UNbtzGt4udsZBovUPprAfDHhjqZjrOn8coKRE=;
 b=qZIPP1aawVWQZ7vR7e1Y5+fom2WgqteXLp2CtuvNvBWresY6vcs579JFNcTH/cTmhmAOFtO8R
 ruDNcs5x/4RACDoQ2oUSvjcF7ADy+vhejjHmzmtdD8pRLbKc22owpCg
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
Dzmitry Sankouski (9):
      power: supply: add undervoltage health status property
      dt-bindings: power: supply: max17042: add max77705 support
      dt-bindings: power: supply: max17042: split on 2 files
      dt-bindings: mfd: add maxim,max77705
      power: supply: max17042: add max77705 fuel gauge support
      mfd: Add new driver for MAX77705 PMIC
      input: max77693: add max77705 haptic support
      power: supply: max77705: Add charger driver for Maxim 77705
      leds: max77705: Add LEDs support

 Documentation/ABI/testing/sysfs-class-power                             |   2 +-
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml               | 190 +++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max17042-base.yaml |  66 +++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml      |  48 +--------
 MAINTAINERS                                                             |   6 +-
 drivers/input/misc/Kconfig                                              |   4 +-
 drivers/input/misc/Makefile                                             |   1 +
 drivers/input/misc/max77693-haptic.c                                    |  15 ++-
 drivers/leds/Kconfig                                                    |   6 ++
 drivers/leds/Makefile                                                   |   1 +
 drivers/leds/leds-max77705.c                                            | 267 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                                     |  12 +++
 drivers/mfd/Makefile                                                    |   2 +
 drivers/mfd/max77705.c                                                  | 233 +++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/Kconfig                                            |   6 ++
 drivers/power/supply/Makefile                                           |   1 +
 drivers/power/supply/max17042_battery.c                                 |   3 +
 drivers/power/supply/max77705_charger.c                                 | 586 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c                               |   1 +
 include/linux/mfd/max77693-common.h                                     |   4 +-
 include/linux/mfd/max77705-private.h                                    | 194 ++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                                  | 194 ++++++++++++++++++++++++++++++++++++
 include/linux/power_supply.h                                            |   1 +
 23 files changed, 1790 insertions(+), 53 deletions(-)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3
prerequisite-change-id: 20241108-b4-max17042-9306fc75afae:v4
prerequisite-patch-id: a78c51c4a1b48756c00cbc3d56b9e019577e4a6b
prerequisite-patch-id: 735d52c3137c5e474f3601adf010f9fe2f3f7036

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


