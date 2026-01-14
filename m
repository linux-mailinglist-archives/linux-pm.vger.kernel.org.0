Return-Path: <linux-pm+bounces-40857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E5D1F598
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 15:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CD713004E1A
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE702DCF61;
	Wed, 14 Jan 2026 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0z8lVLy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C092DA75F
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400230; cv=none; b=ICm8n033aKj4MRcON3O8rTNJrLafWBWXWZBaXh2mlELCctfFto4VTBHyunN0FOIYN8X1B7EzIJcBddWgshsGdluBHI5jWJ6mkveRckeVrLSK2CSqmlV6zjWHkBHdXnCninEALV34WLXCH3hlbHa6A5iFmi1ns3foPraGtmpGi2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400230; c=relaxed/simple;
	bh=7iSVRaIrBvJwUyayWLQUtaaFeLqq1IG5ekXvTcN/l1c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HwzjKtDfb0Xx/vz7Ttn72LQvmPr9Tb/tCcru2migM9O/FCbWsKvev5lF+J1vd11uFQejj23V36XRmmobruQ7TrrAnCvl6z8tGZCgY+Iqu6DfHUlLaQw8fESSP2G8Pryze7peEBADdnwEraSZq3OCV198b7uu+adCjG/5ZSqRelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z0z8lVLy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so5425085e9.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 06:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768400225; x=1769005025; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gOr0r09swBSNVjbYo9yz2YviIiFXOTNHaYP7I0YlkxY=;
        b=Z0z8lVLyQLeqDwuhkbZVuQ5++pZfrDPu2pxhe8lQIi0PmwOoRLwVMy9hgYGktPLShd
         H9bbJGJdsiCLbQX/nhQfaYMGEXjY5JeU/KVue6YJkUJgadVQgdTdeor1qQZ5hruzAbpz
         wdSt+BDSnxkskGNzePz4sO5+qHW0svzXAhiYV865Jy4W0Kud1Ex2oVAjrChyc+FjTdjj
         iKQSDInPMicx4dIhuyZ9PtZgHg08AcTTF5zvMe4gpnocKsiVIme0g4SxcPFEpiJw1e7G
         uoLfZza/1NyYLLg917wPHnSYLKbEGvkeExVtK9RAOJkrCaGEyQk4GMFK5U9NYChz9OKG
         KaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400225; x=1769005025;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOr0r09swBSNVjbYo9yz2YviIiFXOTNHaYP7I0YlkxY=;
        b=OwIscOvsqKCMNDGNh8cRuyWoJQK6z1tzzkhtDsQnxiVBssXaqdxEwauwtBUe9IkTvZ
         B1TtWFR6H0uwJCMQ5wkiRjbWhTzy8pcvS+WwY4fHcM1HZ1A6EJrM9YVuo1eVGGlG4UMR
         2G6QdfX3dNbpSNeH+DKn/CR1eFgW7W4CIJgb9rxrKti/rXN4MhG3NhD8tQ3FcN+U15Af
         5AwD+6di1hcZKhdJ2zI7tWDBPVY+l+nUp2A2cJtGROpmNY9Twd0cOXMQe0o1ALXZ8spA
         OTyF9wyyCer3bQDVTwG7rVph7cxdvxXlkHAs1FGmP34OpTQi0g3J8ppof9YE1AX1fhET
         W2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9B36wNFFF8OOoeWVPqyTMWgARLYt2wI8ll/j3wu2gxrgFcc4dFtkVhh3XLPRAjNqSIjU6ute1uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YylBz736eIq8sEKfraqEvgtSGhESlomAzxSSEhzCzV/2J41lIIz
	7cNYK5lPUL2dGNYLwvah7KSnrO7RfuSGBktczsakwT3eYwU3Ia9C/moSMvq9MIvVqYw=
X-Gm-Gg: AY/fxX71usHMiXZd1yqMy+vX8jm3Jw1BC+jzmDUs/AX+V9dMVDgpFTCxuCQ6WjHxHMB
	fvwkCn+6EaNvWoxVcl7GzWb+KnGcEkf1U4wUGtFGC61hxJsoMM9pY7LcsFjh6YZd4PcGRpv9fE5
	sNuEWXY89D2IL3k7Dhi1qo/jaUk+zl5hI8EIHb+2yXpwMkUnKylxZy+Zg9WM2mCxAMUv30x09ty
	gOSl3K/UGcMHBsab9xHZBcUfeAV6dfCVKFsx9vkas0T066GVvePPbhodkoFGnX2Nt3PCfT1TJvo
	KXVxfNSO741Ut8pr7dAGvyGfeb5+apOa60TEY5V2oGpY05EZEOYtDKrb/QKRn5rbMv6fBQY7eTI
	BkOOyJWrQBXL+niF+UbuRrugH+qlN+1uAEGVPE38eVF6CKJ+P3mwCofl1fXy65xmaU/HTK2r0jj
	AdyfpiV7eaU/ZowKrnALt7lFTRpnuXtwrIaqcyMEZU9Jltozh1+J6859WBvGJjR6ULu3kWVg==
X-Received: by 2002:a05:600c:548c:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47ee3371876mr36058035e9.17.1768400225203;
        Wed, 14 Jan 2026 06:17:05 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee57a2613sm29595445e9.6.2026.01.14.06.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:17:04 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/8] thermal: samsung: Add support for Google GS101 TMU
Date: Wed, 14 Jan 2026 14:16:28 +0000
Message-Id: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD2lZ2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0Nj3cTkglzdktxSXSPzVCPDNINUo2TjJCWg8oKi1LTMCrBR0bG1tQB
 +IQsDWgAAAA==
X-Change-ID: 20260113-acpm-tmu-27e21f0e2c3b
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768400224; l=4502;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=7iSVRaIrBvJwUyayWLQUtaaFeLqq1IG5ekXvTcN/l1c=;
 b=VldPEq1aLcmN8GvMlCPb3GSq97ZYIjYcVJ1HPKvNgmWuc/m5TOg/1yIYM3XuK7n87gKGGVHI9
 asGZcF9DEDIDlAGWAhUklMa+lXPxsoBl7nyIKO6JUw/CJxYJ3u7I4N9
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

This series adds support for the Thermal Management Unit (TMU) on the
Google GS101 SoC (Tensor).

The GS101 TMU implementation differs from previous Exynos generations.
It utilizes a hybrid architecture where control responsibilities are
split between the kernel and the Alive Clock and Power Manager (ACPM)
firmware.

Dependencies
============
1. The thermal driver patch (5) depends on the firmware helpers (4).
2. Typical dependency of the DT patch (7) depending on the bindings
   patches (1), (2) and (3) (to pass dtbs_check)
3. defconfig (8) logical dependency on (5).

The bindings patches (1-3) are independent of each other. They can be
applied in any order, though logical grouping (Firmware -> Thermal)
is still nice for reading.

The Firmware driver (4) is independent.

Given the dependencies, I'd suggest everything to go through the
Samsung SoC tree, with ACKs from the MFD and Thermal maintainers.

If the Thermal maintainers prefer to take patch 5 via their tree, an
immutable branch containing patch 4 (firmware) will be required from the
Samsung SoC tree to serve as a base.

Architecture Overview
=====================

1. Firmware Responsibility (ACPM):
   - Initializes the hardware.
   - Performs ADC conversions and temperature calibration.
   - Manages thermal thresholds and hysteresis configuration.
   - Exposes a high-level protocol for temperature reading and trip
     point configuration.

2. Kernel Responsibility:
   - Communicates with ACPM via the mailbox protocol to set thresholds
     and read temperatures.
   - Monitors the interrupt pending status registers directly via a
     syscon interface.
   - Maps physical hardware interrupts to logical thermal zones.

Sensor Mapping (One-to-Many)
============================

A key aspect of this hardware is the mapping between the logical "ACPM
Sensors" and the physical TMU sensors.

The SoC contains multiple physical temperature sensors scattered across
the die (e.g., near specific cores). However, the ACPM firmware abstracts
these into logical groups (Clusters).

- ACPM Sensor 0 (Big Cluster): Aggregates physical sensors 0, 6, 7, 8, 9.
- ACPM Sensor 1 (Mid Cluster): Aggregates physical sensors 4, 5.
- ACPM Sensor 2 (Little Cluster): Aggregates physical sensors 1, 2.

While ACPM reports a single temperature per logical sensor (likely the
max of the group), the thermal interrupts are raised by the physical
blocks individually.

Therefore, the driver is designed to map these physical interrupt bits
back to their logical parent. When an interrupt fires, the driver checks
the syscon register against the masks defined above. If any bit within
a group's mask is set, the corresponding logical thermal zone is updated.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (8):
      dt-bindings: thermal: Add Google GS101 TMU
      dt-bindings: firmware: google,gs101-acpm-ipc: Add TMU child node
      dt-bindings: mfd: Add Google GS101 TMU Syscon
      firmware: samsung: acpm: Add TMU protocol support
      thermal: samsung: Add support for GS101 TMU
      MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver
      arm64: dts: exynos: gs101: Add thermal management unit
      arm64: defconfig: enable Exynos ACPM thermal support

 .../bindings/firmware/google,gs101-acpm-ipc.yaml   |  17 +
 .../bindings/mfd/google,gs101-tmu-syscon.yaml      |  37 ++
 .../bindings/thermal/google,gs101-tmu-top.yaml     |  64 +++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi   | 209 +++++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  22 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/firmware/samsung/Makefile                  |   1 +
 drivers/firmware/samsung/exynos-acpm-tmu.c         | 212 +++++++
 drivers/firmware/samsung/exynos-acpm-tmu.h         |  33 ++
 drivers/firmware/samsung/exynos-acpm.c             |  12 +
 drivers/thermal/samsung/Kconfig                    |  16 +
 drivers/thermal/samsung/Makefile                   |   2 +
 drivers/thermal/samsung/acpm-tmu.c                 | 638 +++++++++++++++++++++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  24 +
 15 files changed, 1296 insertions(+)
---
base-commit: fefc12a70eb12e0b04f0b59b623965dd3ab1f4ba
change-id: 20260113-acpm-tmu-27e21f0e2c3b

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


