Return-Path: <linux-pm+bounces-20564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6125A13F53
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C609188710E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CFA22CA1B;
	Thu, 16 Jan 2025 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKhovvn9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEB1DE88D;
	Thu, 16 Jan 2025 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044776; cv=none; b=Ajzn9LpeI60VrILOu2hIdVqAYgaVFGcdB/NQ1oqgNplffFTqBYHiDl8t4Yw25Ry9XrMUA5VVmBh0CicynZkAVuO1IVOfwnXN0J+YUuJtmGKdS6pRY/4vm+LfA74q5OZJ6ZJsmSNR8rG9ovqu/kmWCzT97bso2KbfgOAORmO1E4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044776; c=relaxed/simple;
	bh=oCHXUMYbPlNkcPKu04CxYn7KWlb7OnFPaDTBdH+PCzM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KvUGVV72vEEMGF4sy0RezSJ6qX3aQGB4VEhM66Bmjf/rm/N1yK1P8pyRX0pX21FHNhQBrpomss+LeLu447UM8ivlJ/8FWZlFLMudnePfvpHcPNJWmbL8aM+1zbvQf5Sr9sOOAowQx9fkxeJQ6TPrPOcxF4ZAIznX0h0ydsyFkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKhovvn9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso248281766b.3;
        Thu, 16 Jan 2025 08:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044773; x=1737649573; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6/Kk/bTf0Fsx3F1QDwnOQVYIPXlxd7CmJs2/Xxijd9g=;
        b=SKhovvn9Q0w6o4uKPP49Y9hLJxW0kc6078DF7UI6DY4YGmHgdycq/irpWEyYCfdGQf
         TZtjHUEfTwihUkg232IKoDSfgds+jCpobxf925cJM5J8L8Ez6IXm2TV72psDe33vKzy+
         +2LW8FE4/JklghN6QpstzsGqO2PMBjyCZLl48vdF0PahJih4ldtYjRp8qXgK4wNbAt+0
         AxRAAwK3cQLYoQWHhgxYRwxK3SimHAhuLXXEMpzmv6417z6O8K2l4YOSz5NEnpK/bzBB
         cGybHuPUFCXhwnAJH5wLjKRgnkrGwCEM2gu7y+ypqq7f4Qdk2BvyFrmCQL9BGH1+dx1e
         UfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044773; x=1737649573;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/Kk/bTf0Fsx3F1QDwnOQVYIPXlxd7CmJs2/Xxijd9g=;
        b=vLNLtS4y4HVzMOAKTm/f6aSN3MfQrU1+u/LDC8pUt+MEPdzif4bR/lAQ0hH/yvfhMC
         pN+xd+bBGy9WuUjYZl7uULG67ObWUqAdiyw6dKSu8CZjy3NrmLgo52TCko163Q8bUxU3
         F+H290sviFkopS1u7Bz++5boj02zaRanuoUwZTPsS3fkpERFznharwQGZHtrPYEL/LUR
         qLmLGvGgy1H/fIamYcarsun6U4RZMy9NgP4QbBrFz6Rpp1d2LIJX5cXyZTiMWNMYYgm6
         u03JH1NVRl1IcOtkxR9sUjkrA3PJOO1iyZmBxWuIaf1njGye4dySjfDyrPCGmUlhQlK7
         uHjA==
X-Forwarded-Encrypted: i=1; AJvYcCV2ndWJSR6RYQPLn1bO/46OBwtZAZ7tlelllYIaEcf+pwA0kHfEl5K8xsRaJ6uPBZJO5yX99/Tn8AjrA+Y=@vger.kernel.org, AJvYcCVAXdoE9FldISkdVx8rJnc5rnVOOc0nXZn2Z7vqYoOjUvSLNkWQJAANhqMM39Lbe5HOK4xlH69+YYgKGkt0@vger.kernel.org, AJvYcCVB+g1UB0pMcUddFV/mJbh53ogpt26qdP/OOmRDDsDxX58iY9lEY/KGZNcSF2q3Z+lCvtz4tg0UHLIFYw==@vger.kernel.org, AJvYcCWiwy+EUAou60wZ3OnTWXV5XtW5RZ2rQwTdIfeTN8xLkkzhwlx+Wa+hpEBibP/XaWG+zPejdUgEIJ8r@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3t3AsadAzCzrdc/+GdslvWYX3EF7jfNAsbE5jk+aZtDXYFpTF
	7xqztQqEpSn9rxceubtSpOVEJnGgN1oiIHytp+PfBCL4KqsdxcUF
X-Gm-Gg: ASbGncvj22q5hjqGPLgDkKh8Z0HvGBCf3PO29wyVNZc6ddnm7MH1Wbwsc1z2JSGwFq4
	/EnY+Vd7wHT2UP4TUPPn0nwEp6aJabpndgr90iURxquphgX03xoeUx7+rgbfi4A6pw1NmSGnnYV
	LcedIx+JliyCPxsOyekEKlDaklv/0vUpy55BNoxDz0EYY4UxjyxRFFyVhv2rGVPrKUKy97XAWtT
	N3iDyZbGTYCsKgO2Lo1Q7OwNnxD+bZjAyPq7U4jCCVFOFQFZjggUDuunSdmUo9aSkDsyY5Ftx2B
	/2gWlAN986C2imcvsF88NrO64g==
X-Google-Smtp-Source: AGHT+IHmivIw7M4pdhXzxbC6D1Qdp4KQx7ZQyVlXUH6dpocqn3iOafQeSpqNZ8LDAU0vncASeoDs8g==
X-Received: by 2002:a17:907:3e24:b0:aa6:7737:199c with SMTP id a640c23a62f3a-ab2ab6fd036mr2496263966b.15.1737044772530;
        Thu, 16 Jan 2025 08:26:12 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f29260sm16411666b.94.2025.01.16.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:26:12 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v15 0/7] Add support for Maxim Integrated MAX77705 PMIC
Date: Thu, 16 Jan 2025 19:26:02 +0300
Message-Id: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABsziWcC/43U3U7rMAwA4FdBvabIzl8TrngPhFB+nK3S1kHaV
 SC0d8eFc6BaL8hNpVjKZzuJ+9GMVHoam/ubj6bQ3I/9aeAF6tubJu79sKO2TxxoBAgFBrt2nHx
 5PUwU98NzP0y0K37iTc/nl3Eq5I9tiNZYDUFkkg0zwY/UhuKHuGdoOB8OHHwplPu3r8SPT7ze9
 +N0Ku9fdcxyif7PaP/OOMsWWpLZGCMAOx8fdkffH+7i6dgs+Kx+QYeyAlQMiiQoJx217bprUK8
 rrDiTWS8VAkiZUWHCDWh+QASoAQ2DkKQNGhxEvQG7FShqWu4YdCF7L7Py6OEatCtQYgVolzPMn
 i8lCimBrkH3C/KnAnQMcmUpyuBJBHsNIqxFVSEin2HbJbKalCVtxIbENelqSGQyRdDOWmEJcEO
 KFVn1dlAsjydZfrxKZae2jcsVWXXZuExMDtEgxA6s3Db+MzIaEGpmEJeZyYasoiggObMmL98jX
 +j1zL+Y6d/cXy6fVLjVRIAEAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737044771; l=6591;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=oCHXUMYbPlNkcPKu04CxYn7KWlb7OnFPaDTBdH+PCzM=;
 b=WHX9ZYLM2ER1RfHJhkaMDOwk4UfvRVqZBQjM0mxdb/OUsNtwZ6JLFpkOvm6RA8Oik507IpN96
 HX1Px2UajX+DdCDKNkeqZKGf+ilMHQLqeniac+V4NLNb0SAuwAkcOTp
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

 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml          | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml |  50 +++++++++++++++++++++++++++
 MAINTAINERS                                                        |   4 +++
 drivers/input/misc/Kconfig                                         |   4 +--
 drivers/input/misc/Makefile                                        |   1 +
 drivers/input/misc/max77693-haptic.c                               |  15 +++++++-
 drivers/leds/Kconfig                                               |   8 +++++
 drivers/leds/Makefile                                              |   1 +
 drivers/leds/leds-max77705.c                                       | 279 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                                |  13 +++++++
 drivers/mfd/Makefile                                               |   2 ++
 drivers/mfd/max77705.c                                             | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/simple-mfd-i2c.c                                       |  11 ++++++
 drivers/power/supply/Kconfig                                       |   6 ++++
 drivers/power/supply/Makefile                                      |   1 +
 drivers/power/supply/max77705_charger.c                            | 581 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77693-common.h                                |   4 ++-
 include/linux/mfd/max77705-private.h                               | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                             | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 19 files changed, 1707 insertions(+), 4 deletions(-)
---
base-commit: 260d7c5e5392ac41c94152005d416172ba0a906d
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


