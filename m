Return-Path: <linux-pm+bounces-41086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22296D3A809
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 13:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB70F3007194
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD6359F85;
	Mon, 19 Jan 2026 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIN1Bb7q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9322FE0E
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824537; cv=none; b=dqIDXabBo5Usu09eX0anI7aCGA0e+VN+aFgpbB1b+H1bKrm099ls63j+0jRQ+NR61xSR9UFhAX/In8r87MveRZEFN9rKZbsA+ZxBBnRAEYxoncVDczpWrQgbvzDKVSTpF+OF+74Lx6uxCsGh4K/O2QyW+bljV5psmQYGKHL4gTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824537; c=relaxed/simple;
	bh=vjxKctKqh1C+lpYUfF3aR59o+hjb5fIwKm+AM9mWzG8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t9SOME6Kr+Edq0RVxiF4CTLew462tfcwQcMRaXjoNa0cgZBicfNY2G8OVDF23Sxen+qEmwZi1gmVCLFjMtAJWhpjg2lDxogWNVQ1cUY6WU6FjrbMsLDgRPpTUZSXMURG3sxi847suei6ovW4tF//8DPesQxwD5iGfjInqTFzeb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nIN1Bb7q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fed090e5fso2304566f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 04:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768824533; x=1769429333; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKnIFFfc9VQE0U5sGGzfGa64S/N4XCAB3mzxFk6dO2I=;
        b=nIN1Bb7qawMvf+xAbBYQXZ1Ut0pvPCurNunxmtamD1NmJMUWeY5rvqNc4+QfttkYrh
         ceX50FnHKz3QsalFkZkouroQdbT2SilA6Gii8QVox9e+tqGDTl6tKZVqIEs7kdkscem4
         siMOGsH4FBlnpOg+hfSKabGaDHv06hjsJYWoZDOK/YgAyK0GoR+RSd0yLlDVx2yI0N6e
         tioPAPSjLD58DuI5w1xC58v4gKaamkHoNkNNB09r1GkJpsD1+XLJ5vIRj4wfNMKX0sAh
         Mlydof1HPDXpowWnRZXThwO9B5O4ORtY0njHSOPwFmFmjgRPxkkHNMYm6PjIBW9yQGyr
         geCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768824533; x=1769429333;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKnIFFfc9VQE0U5sGGzfGa64S/N4XCAB3mzxFk6dO2I=;
        b=ht/GwZywzxN9K1pG6ypb4aZrzTTjj3oytgrAUmuM0lmVusxQjhxzKXs3tqGnncMgVJ
         NqCIS90pUvVgJzDu2anrCCGg71eVK8Fg+iUKnqYGC2QUZs7t9yF8urfuC790a+tQZY5Z
         4vcWqk+fw2XAPXKcgb7UOP0zJEDV69vf89qy4tPB09XAmbykMymfVx5oClVUecGHhmH/
         PFW2jAnEL6vBGCl2Boeqd7dMNxIwKLIbUZFEwoBy9gKG1+mr+nfYlp8JI3duvItEZp+t
         5nLhswsQBNlH6OUf0jhWh/NnhEebdPBvCTgNLqb2PVLdlgz/Lm0nE/UHvj3EObYZfZID
         WH+g==
X-Forwarded-Encrypted: i=1; AJvYcCVrOHHzEsHRrDdNg1VFLR8A/GtXQFHrDa2ihJ4vWCYleKMEIz/qKyz8gO+U0DhFBUZiskPrWkrfAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdUjZ6qeDAcCbOeQcX6MmA7jDAoiw8uIuj8Cwb0t7qcU2S03Dx
	n7sbTd3igBNEXdUkwQ/YUz2V2i39uyP5gwqsr+AelMcRxo8jEH/w61JEIcMFt97Qg6I=
X-Gm-Gg: AZuq6aKzulx+JRp9y8vUKbM2VivV2BUCdd/8oBnpKx9Xp6SF06Whtu1NNJWEhn3W2TA
	nZNTwPUJxtIgDB+OY5LBGTvzu1zVpHPnRvqygHbRLbt10ajr7pRruOIMQaq2R53NCAAV2/zUnsi
	lF27c5JtaHJ65TuVARXUTR9u2NaWW2rGzIfsJ+EaNuEx0l5zElnDsTpLwuDmov2mitiGzvbsfZy
	vdMO+i8LuGNznQD3qiJpeK7yytofetkxGObEOGKd0x3/VP66amjIK0LkME4Uq9ZmdW3U0QSmz3u
	9dJgXvkSPBHVvxwFpWZorulIL3m+yXgFA1Tks2e3Btpum5FCqJc6xgtDkOyWTmWO8RcrA893ENz
	6i6iqYhymSBJ9t768quyrUq0GrD0CZ8j1qtOWV2KDr3P2UBl5DHvvnLNI538ZtB2MU/HEFfuAE/
	9xbpNpHFf05BfUCNKVQLHKDD8qaMIEc5K//GyvH89oe4HYEIy+028JRkGof65CHL0vRS+KiQ==
X-Received: by 2002:a05:6000:3109:b0:430:96bd:411b with SMTP id ffacd0b85a97d-43569bd47e7mr15049639f8f.58.1768824533142;
        Mon, 19 Jan 2026 04:08:53 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e664sm20698421f8f.30.2026.01.19.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:08:52 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/7] thermal: samsung: Add support for Google GS101 TMU
Date: Mon, 19 Jan 2026 12:08:46 +0000
Message-Id: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM4ebmkC/0XMQQrCMBCF4auUWRtJJlqpq95DuojppB2wTUlqU
 ErubiyIy//x+DaIFJgiXKsNAiWO7OcSeKjAjmYeSHBfGlBiLZXSwthlEuv0FHghVE4SWn2Hcl8
 COX7t1K0rPXJcfXjvclLf9Yec/khSQgrr6Fz3jaZGuvbBswn+6MMAXc75A46eC7ChAAAA
X-Change-ID: 20260113-acpm-tmu-27e21f0e2c3b
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768824532; l=4379;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=vjxKctKqh1C+lpYUfF3aR59o+hjb5fIwKm+AM9mWzG8=;
 b=wXnHsdPH6H91y8OZ1SvxH9pevq+ULVCQNWr1P0Do/JfHOlidnlm9D04J3aht/OhyxQt+CpmUS
 mfS2vbxsmfWAWC5izRW9M7ycjSgKXtMl+tIQ0mSkr9PsPJ5HylEv5TM
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add support for the Thermal Management Unit (TMU) on the Google GS101
SoC.

The GS101 TMU implementation utilizes a hybrid architecture where
management is shared between the kernel and the Alive Clock and
Power Manager (ACPM) firmware.

Dependencies
============

- firmware patches 2, 3: required by the thermal driver (patch 4).
- bindings (patch 1): required for DTS validation.
- thermal driver patch 4: required by defconfig (patch 7) - logical
dependency. 

Given the thermal driver is a new addition, I suggest everything to go
through the Samsung SoC tree, with ACKs from the Thermal maintainers.

If the Thermal maintainers prefer to take the bindings and the thermal
driver patches via their tree we'll need:
- an immutable branch containing the firmware patches (2 and 3) from the
  Samsung SoC tree to serve as a base for the thermal driver.
- an immutable branch containing the bindings and the thermal driver
  from the thermal tree to serve as a base for the dts and defconfig.

Architecture Overview
=====================

The hardware supports two parallel control paths. For this
implementation, responsibilities are split as follows:

1. Kernel Responsibility:
- maintain direct memory-mapped access to the interrupt pending
  (INTPEND) registers to identify thermal events.
- map physical hardware interrupts to logical thermal zones.
- coordinate functional operations through the ACPM IPC protocol.

2. Firmware Responsibility (ACPM):
- handle sensor initialization and calibration.
- manage thermal thresholds and hysteresis configuration.
- perform temperature acquisition and expose data via IPC.

Sensor Mapping (One-to-Many)
============================

The SoC contains multiple physical temperature sensors, but the ACPM
firmware abstracts these into logical groups (Clusters) for reporting:

- ACPM Sensor 0 (Big Cluster): Aggregates physical sensors 0, 6, 7, 8, 9.
- ACPM Sensor 1 (Mid Cluster): Aggregates physical sensors 4, 5.
- ACPM Sensor 2 (Little Cluster): Aggregates physical sensors 1, 2.

The driver maps physical interrupt bits back to these logical parents.
When an interrupt fires, the driver checks the bitmask in the INTPEND
registers and updates the corresponding logical thermal zone.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v2:
- architecture: switch from a syscon/MFD approach to a thermal-sensor
  node with a phandle to the ACPM interface
- bindings: address Krzysztof's feedback, drop redundencies,
  interrupts description.
- firmware: introduce devm_acpm_get_by_phandle() to standardize IPC
  handle acquisition.
- thermal driver: drop compatible's data and use the static data from
  the driver directly.
- defconfig, make EXYNOS_ACPM_THERMAL a module
- Link to v1: https://lore.kernel.org/r/20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org

---
Tudor Ambarus (7):
      dt-bindings: thermal: Add Google GS101 TMU
      firmware: samsung: acpm: Add TMU protocol support
      firmware: samsung: acpm: Add devm_acpm_get_by_phandle helper
      thermal: samsung: Add support for GS101 TMU
      MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver
      arm64: dts: exynos: gs101: Add thermal management unit
      arm64: defconfig: enable Exynos ACPM thermal support

 .../bindings/thermal/google,gs101-tmu-top.yaml     |  67 +++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi   | 209 +++++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  18 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/firmware/samsung/Makefile                  |   1 +
 drivers/firmware/samsung/exynos-acpm-tmu.c         | 212 +++++++
 drivers/firmware/samsung/exynos-acpm-tmu.h         |  33 ++
 drivers/firmware/samsung/exynos-acpm.c             |  35 ++
 drivers/thermal/samsung/Kconfig                    |  16 +
 drivers/thermal/samsung/Makefile                   |   2 +
 drivers/thermal/samsung/acpm-tmu.c                 | 643 +++++++++++++++++++++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  30 +
 13 files changed, 1275 insertions(+)
---
base-commit: e2211f5d980086dd9fbdab3bcd86b715e12cae13
change-id: 20260113-acpm-tmu-27e21f0e2c3b

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


