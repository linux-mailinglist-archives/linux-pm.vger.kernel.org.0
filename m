Return-Path: <linux-pm+bounces-27557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C079AC230D
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 14:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12944E14FC
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8553186342;
	Fri, 23 May 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASu98xrj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1CA7DA93;
	Fri, 23 May 2025 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004725; cv=none; b=hg2+/I18L4STlAA1xP7NT4tDtzhHn6dFRsCFolWUpYYCEb+0RwZ4C9phQaJ3B93zUBY9HF+e0so1eEMQYnTyfZmZLrcVxpijE6kDj4PyJKxYpf074hB4TqYzAeb/ym089e6jFJLGrNX9tqL76bwaWh4ppjsvDg3q2hdpW/HMF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004725; c=relaxed/simple;
	bh=OOXCkFDGtaTZMu05Xdb53pmqZzDufP0TOmEg/vN9xJQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eYKwCamWP8Fkn8iCrYulOGiHqggf3c269rL5PJPGxgyyvDCueKL+QRshE0+lnfA/nCMSRzizFsX7DNR5UHrpSCb+wzzIl5y5TVi/fAHQ1esQOIW5mPIczJn5w86uGkxeQ1TOPeuKvevs+JoYT4TmDKlPA8Vd4RmpIMLmne7zzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASu98xrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC80DC4CEE9;
	Fri, 23 May 2025 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748004724;
	bh=OOXCkFDGtaTZMu05Xdb53pmqZzDufP0TOmEg/vN9xJQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ASu98xrjaylGoqBa7TZFByLhQ+wTu8lfN1nyxbqCoIOWDbKDIETMIJa87hIrpXFkw
	 TsQSkmCkB36vlsPd4UMpnr23gLbx4tZb7/i/sdJk3BWjRK4c7C3zBrI0kBsLG7c1yX
	 R/Qreq7iC2NCmP1R+5ZHMEl6Nse9L5SUMPuSHUyb7fbY6nCS5lHysP7n122VpHo/LW
	 cpPS95RsQe2zTfcEGT4b0WS+JAMire2F1FQufJd/UJMafcjQ25ROdYtTJtYxdoF9Rf
	 xxOWNbW/+20m6MxGctI7yb8AbpUaCEb4Tc2OdLBT49Q6BbG4JRhjHuqTDdYFV2iIW7
	 jHvZ91s1rGFGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4C8C54F2E;
	Fri, 23 May 2025 12:52:04 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Subject: [PATCH v4 0/5] Google Pixel 6 (oriole): max77759 fuel gauge
 enablement and driver support
Date: Fri, 23 May 2025 14:51:43 +0200
Message-Id: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF9vMGgC/4XNUQuCMBDA8a8ie26x2yZzPfU9ImTTmw5KY8thi
 N+9KfQSRC8H/4P73UIiBo+RnIqFBEw++nHIIQ8FaXozdEh9m5twxiXkQa2kXQQG9d3MSqlS166
 jknHkAoy0QpB8+gjo/Lyzl2vu3sfnGF77lwTb9g+YgDKqq5Y7o6xDwc5TcxunZPxwtEg2M/GPU
 zL46fDsVEqX2li0yrkvZ13XN1U3WNUDAQAA
X-Change-ID: 20241202-b4-gs101_max77759_fg-402e231a4b33
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748004727; l=5403;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=OOXCkFDGtaTZMu05Xdb53pmqZzDufP0TOmEg/vN9xJQ=;
 b=5+306hTTvLvJFLGwpeid9GYxhSnl/KXZpvR6dC73BxlLdsMuvFgkwlcUSuIq7IKUtwq342f7Z
 Ef/6OZTgG0bC/U4XcKz0cumXJcZIq4SKnvfimbceB9PqIiJ2UhNiFaD
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

The Google Pixel 6 has a Maxim MAX77759 which provides a fuel gauge with
an interface with a lot in common with the Maxim max1720x.

Modify the Maxim MAX1720x driver to be compatible with the Maxim MAX77759
and enable it for the gs101-oriole board.

The voltage, current, capacity, temperature and charge have all been
tested and show coherent results. The charge full design and capacity
equal the ones seen on android, the ratio between average charge and
average current does predict pretty accurately the time to empty under
a constant workload and temperature is coherent with the dynamic state
of the device.

Health is not enabled as it always reports overheating. The time to empty
is wrong by about a factor 2 and is thus also disabled.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
Changes in v4:
- Make first patch standalone
- Separate MAX77759 defines from MAX1720x defines (Dimitri Fedrau)
- Inline device name property (Dimitri Fedrau)
- Separate MAX77759 capacity lsb logic from the MAX1720x capacity
  computation (Dimitri Fedrau)
- Use device_property_read_u32 instead of of_property_read_u32
  (Sebastian Reichel)
- Removed leftover debugs
- Move shunt-resistor-micro-ohms to out of allOf:if: (Krzysztof Kozlowski)
- Fix reg-names constraints
- Fix style errors
- Link to v3: https://lore.kernel.org/r/20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be

Changes in v3:
- Update base tree to avoid conflicts
- Fix capacity computation for max1720x
- Add separate properties for the max7759 to disable non-functional ones
- Take TASKPERIOD into account for voltage computation of max77759
- Simplify vcell computation (Dimitri Fedrau)
- Switch has_nvmem to bool and keep it only in chip_data (Dimitri Fedrau)
- Drop the yes_range from the write table (Sebastian Reichel)
- Add test_power_supply_properties.sh to cover letter (Sebastian Reichel)
- Switch back some changes to binding and actually use allOf:if: to
  restrict constraints (Krzysztof Kozlowski)
- Fix style errors
- Link to v2: https://lore.kernel.org/r/20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be

Changes in v2:
- Add fallback for voltage measurement (André Draszik)
- Add regmap for the max77759 (André Draszik)
- Add chip identification for the max77759 (André Draszik, Peter Griffin)
- Move RSense value to a devicetree property shunt-resistor-micro-ohms
  (Dimitri Fedrau, André Draszik)
- Use allOf:if to narrow binding per variant (Krzysztof Kozlowski)
- Remove binding example (Krzysztof Kozlowski)
- Change defconfig order to follow savedefconfig (Krzysztof Kozlowski)
- Fix style errors
- Link to v1: https://lore.kernel.org/r/20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be

tools/testing/selftests/power_supply/test_power_supply_properties.sh:
  # Testing device max77759-fg
  ok 1 max77759-fg.exists
  ok 2 max77759-fg.uevent.NAME
  ok 3 max77759-fg.sysfs.type
  ok 4 max77759-fg.uevent.TYPE
  ok 5 max77759-fg.sysfs.usb_type # SKIP
  ok 6 max77759-fg.sysfs.online # SKIP
  # Reported: '1' ()
  ok 7 max77759-fg.sysfs.present
  ok 8 max77759-fg.sysfs.status # SKIP
  # Reported: '78' % ()
  ok 9 max77759-fg.sysfs.capacity
  ok 10 max77759-fg.sysfs.capacity_level # SKIP
  # Reported: 'MAX77759' ()
  ok 11 max77759-fg.sysfs.model_name
  # Reported: 'Maxim Integrated' ()
  ok 12 max77759-fg.sysfs.manufacturer
  ok 13 max77759-fg.sysfs.serial_number # SKIP
  ok 14 max77759-fg.sysfs.technology # SKIP
  ok 15 max77759-fg.sysfs.cycle_count # SKIP
  ok 16 max77759-fg.sysfs.scope # SKIP
  ok 17 max77759-fg.sysfs.input_current_limit # SKIP
  ok 18 max77759-fg.sysfs.input_voltage_limit # SKIP
  # Reported: '4238593' uV (4.23859 V)
  ok 19 max77759-fg.sysfs.voltage_now
  ok 20 max77759-fg.sysfs.voltage_min # SKIP
  ok 21 max77759-fg.sysfs.voltage_max # SKIP
  ok 22 max77759-fg.sysfs.voltage_min_design # SKIP
  ok 23 max77759-fg.sysfs.voltage_max_design # SKIP
  # Reported: '-149689' uA ()
  ok 24 max77759-fg.sysfs.current_now
  ok 25 max77759-fg.sysfs.current_max # SKIP
  ok 26 max77759-fg.sysfs.charge_now # SKIP
  # Reported: '4716000' uAh (4.716 Ah)
  ok 27 max77759-fg.sysfs.charge_full
  # Reported: '4524000' uAh (4.524 Ah)
  ok 28 max77759-fg.sysfs.charge_full_design
  ok 29 max77759-fg.sysfs.power_now # SKIP
  ok 30 max77759-fg.sysfs.energy_now # SKIP
  ok 31 max77759-fg.sysfs.energy_full # SKIP
  ok 32 max77759-fg.sysfs.energy_full_design # SKIP
  ok 33 max77759-fg.sysfs.energy_full_design # SKIP

---
Thomas Antoine (5):
      power: supply: max1720x correct capacity computation
      power: supply: add support for max77759 fuel gauge
      dt-bindings: power: supply: add max77759-fg flavor
      arm64: defconfig: enable Maxim max1720x driver
      arm64: dts: exynos: gs101-oriole: enable Maxim max77759 fuel gauge

 .../bindings/power/supply/maxim,max17201.yaml      |  42 +++-
 .../boot/dts/exynos/google/gs101-pixel-common.dtsi |  10 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/power/supply/max1720x_battery.c            | 276 ++++++++++++++++++---
 4 files changed, 294 insertions(+), 35 deletions(-)
---
base-commit: e48e99b6edf41c69c5528aa7ffb2daf3c59ee105
change-id: 20241202-b4-gs101_max77759_fg-402e231a4b33

Best regards,
-- 
Thomas Antoine <t.antoine@uclouvain.be>



