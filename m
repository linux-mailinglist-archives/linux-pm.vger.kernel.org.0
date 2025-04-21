Return-Path: <linux-pm+bounces-25810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFB8A955BA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 20:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D483A9531
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDA51E883A;
	Mon, 21 Apr 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7aVrTM4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9761A238A;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745259232; cv=none; b=GrgqL8hI4uYoPIfqR0+ypdkhA60vGQRzgn+wo91Mg222AJpg7MK/KKvaq/6f0G5JlNyB3oDA3JpkDzgJt1qxvNfTeDmEAOVq8Tx1MywyrCM3yzB4Fg32kSTw8mLC73lYV9OIcaqysqbMcuvtiS1y6lP2ypTYluNISeArAWObR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745259232; c=relaxed/simple;
	bh=dhTtr4K5vrV7Ifdau0v9q818igO+jXIFRbDPCub+EH4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ComQHUUBhCCT3ZO9BGG2dGQyZewt9fRSdfGSKQdc4PmazC93OTR8i4rJxsgPyRZ3hE5AVVWYjP+sgUGNE8cmfH55GgjnZYY13sQVBf/qnvBV7BIbJqdcGJzCaf8zB+TprbVgLTKkX6RBES0ECgM0oQ3VaS7HaxNFZTlaAhYlfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7aVrTM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 357B9C4CEE4;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745259232;
	bh=dhTtr4K5vrV7Ifdau0v9q818igO+jXIFRbDPCub+EH4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=n7aVrTM4SSiqBQsCcmlfb/iCV95UvM0+xkkUXFNELTCDTATexZEYW5OsonA9k3Ayy
	 gyAGBk/GHrCItpPeR99EkNRQoXcOH7MH5efrZlJqIQp5C0GKgNo96/lA6m4tnBA6A0
	 YXc40UzpRGl/ishD6BNxpsBnUj+8AiL+8HbDQu3JrXe0osbN3NlzWTL2PpxlqPF6F9
	 DVlejcjcY0mlL+UslpOyNiIWDnd7B4Xj8mOWuS3I1cEBMQ9v6ZyWdKCkEv38ZFKsyP
	 6SgGrkXkw0fdRqerKlbDMAbTWs1JJha1gTeEorYjX0Ixmw+QMQ2uUMpX3bMoBbCGWU
	 wciqDZZFfhsXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252F8C369AB;
	Mon, 21 Apr 2025 18:13:52 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Subject: [PATCH v3 0/5] Google Pixel 6 (oriole): max77759 fuel gauge
 enablement and driver support
Date: Mon, 21 Apr 2025 20:13:31 +0200
Message-Id: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMuKBmgC/4XNSwqDMBCA4atI1k3JS2K66j1KkUQnOtBqSWqwi
 HdvFLoplG4G/oH5ZiERAkIkp2IhARJGHIcc8lCQprdDBxTb3EQwoXge1CnaRc54fbez1ro0te+
 oYgKE5FY5KUk+fQTwOO/s5Zq7x/gcw2v/kvi2/QMmThk1VSu81c6DZOepuY1TsjgcHZDNTOLjl
 Iz/dER2Km1KYx047f2Xs67rGzi+m2oDAQAA
X-Change-ID: 20241202-b4-gs101_max77759_fg-402e231a4b33
To: Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745259219; l=4444;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=dhTtr4K5vrV7Ifdau0v9q818igO+jXIFRbDPCub+EH4=;
 b=3CyC063e2T/TqTX5MRwjHsd8hbpR6TjK1Pr6MnLxmcY/r8rh0CIB1UVM+rSZUHbSbmnsg+VHB
 +tYJgdik7b/Av0XZI4sCgokWmJuekfiYOdQMS3iNVrZba8CINTf6tbK
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
ok 1 max77759-fg.exists
ok 2 max77759-fg.uevent.NAME
ok 3 max77759-fg.sysfs.type
ok 4 max77759-fg.uevent.TYPE
ok 5 max77759-fg.sysfs.usb_type # SKIP
ok 6 max77759-fg.sysfs.online # SKIP
ok 7 max77759-fg.sysfs.present
ok 8 max77759-fg.sysfs.status # SKIP
ok 9 max77759-fg.sysfs.capacity
ok 10 max77759-fg.sysfs.capacity_level # SKIP
ok 11 max77759-fg.sysfs.model_name
ok 12 max77759-fg.sysfs.manufacturer
ok 13 max77759-fg.sysfs.serial_number # SKIP
ok 14 max77759-fg.sysfs.technology # SKIP
ok 15 max77759-fg.sysfs.cycle_count # SKIP
ok 16 max77759-fg.sysfs.scope # SKIP
ok 17 max77759-fg.sysfs.input_current_limit # SKIP(Dimitri Fedrau)
ok 18 max77759-fg.sysfs.input_voltage_limit # SKIP
ok 19 max77759-fg.sysfs.voltage_now
ok 20 max77759-fg.sysfs.voltage_min # SKIP
ok 21 max77759-fg.sysfs.voltage_max # SKIP
ok 22 max77759-fg.sysfs.voltage_min_design # SKIP
ok 23 max77759-fg.sysfs.voltage_max_design # SKIP
ok 24 max77759-fg.sysfs.current_now
ok 25 max77759-fg.sysfs.current_max # SKIP
ok 26 max77759-fg.sysfs.charge_now # SKIP
ok 27 max77759-fg.sysfs.charge_full
ok 28 max77759-fg.sysfs.charge_full_design
ok 29 max77759-fg.sysfs.power_now # SKIP
ok 30 max77759-fg.sysfs.energy_now # SKIP
ok 31 max77759-fg.sysfs.energy_full # SKIP
ok 32 max77759-fg.sysfs.energy_full_design # SKIP
ok 33 max77759-fg.sysfs.energy_full_design # SKIP

---
Thomas Antoine (5):
      power: supply: correct capacity computation
      power: supply: add support for max77759 fuel gauge
      dt-bindings: power: supply: add max77759-fg flavor
      arm64: defconfig: enable Maxim max1720x driver
      arm64: dts: exynos: gs101-oriole: enable Maxim max77759 fuel gauge

 .../bindings/power/supply/maxim,max17201.yaml      |  34 ++-
 .../boot/dts/exynos/google/gs101-pixel-common.dtsi |  10 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/power/supply/max1720x_battery.c            | 271 ++++++++++++++++++---
 4 files changed, 280 insertions(+), 36 deletions(-)
---
base-commit: e48e99b6edf41c69c5528aa7ffb2daf3c59ee105
change-id: 20241202-b4-gs101_max77759_fg-402e231a4b33

Best regards,
-- 
Thomas Antoine <t.antoine@uclouvain.be>



