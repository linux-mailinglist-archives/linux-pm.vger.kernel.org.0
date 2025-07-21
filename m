Return-Path: <linux-pm+bounces-31197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A1BB0C40C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 14:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465047A62F9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856E02D3EC5;
	Mon, 21 Jul 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTlc0qZQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DE2D375E
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100773; cv=none; b=U8JpPii0TAXfMXL0tjhQGWBS0hThCOlhHxENikiij0hj6bb0yiRZ/7mOtb+zrErMxhPlPW7be5mfRu5LVdrgVkRoMeJ0v4YLQdHhs8Rxq7HQgzD8hbZME952dH/YcyLkfNhv1Wlt8EUfv+YUjlSrB2zLZrVOA7g7/YEv0qZZ7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100773; c=relaxed/simple;
	bh=2V8cx+eHM09IjMLxrm1pbDN4TamRtJnQdGk5yGSGakA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUUT5PS9N8x7oRDs3T3lLdw+TlDANrKygrf0P5DkrLTPUQj5mu5+cYj+EARs0FmXEbeE5l/WDO4ioSAqceyuPJQfoZNLCTTVZ1NLlcaNWmEX5QkuMDtnMQVaCxutGCxbKri+b+zXHg6F+NqloRoMPILHhQ/tk9ErLdomHT1HzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTlc0qZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DF6C4CEED;
	Mon, 21 Jul 2025 12:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753100773;
	bh=2V8cx+eHM09IjMLxrm1pbDN4TamRtJnQdGk5yGSGakA=;
	h=From:To:Cc:Subject:Date:From;
	b=eTlc0qZQqn0xz0qLUUcCB7UqDWCfjEiOHq5ui4SeOY9+Jo9fdT5nlPGOi6FEaipty
	 7xXznp98tBfDimuXpmHkJYIA2G8m17JEfYkNL8zI+CgSWzekA6QOyXRiuVBhKE9BM8
	 aEd3cppSWvtPKSi55VTTM8o8ZHF/D8WLtCqlyUYJX3mmg36KwVdBtaSy3/rM2mrUuR
	 ehIbrSOpasjaLQfKwq16MmhiE6XRlWy+28E8pHX8JfGV+u6NWn5Cyl1qPHwcP6iqBo
	 30EofbLKMj5juAdZLNHXHOSdZgOTHyEk2gY24S7JPTLRE3jE0ewkfVsjoqYluMEBui
	 RApaI1mbZQXdw==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/5] power: supply: Add adc-battery-helper lib and Intel Dollar Cove TI CC battery driver
Date: Mon, 21 Jul 2025 14:25:59 +0200
Message-ID: <20250721122605.46724-1-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

Here is a patch-series which primary goal is to add support for
using the coulomb-counter in the Intel Dollar Cove TI PMIC as
battery power-supply class device.

This PMIC used on some Intel Bay/Cherry Trail systems has some builtin
fuel-gauge functionality which just like the UG3105 fuel-gauge is not
a full featured autonomous fuel-gauge.

To prepare for adding support for this, this series factors out the UG3105
capacity estimating code, generalized so that it can be re-used in other
drivers.

This series has been tested on an Asus ME176C tablet with UG3105 fuel-gauge
and on an Acer A1 840 tablet which uses the Intel Dollar Cove TI coulomb-
counter as fuel-gauge.

Changes in v3:
- Drop hardcoded open-circuit-voltage to capacity mapping table, replacing
  it with using the "ocv-capacity-table-n" device-property and replace DIY
  code with power_supply_batinfo_ocv2cap()
- Rebase on latest upstream where ug3105_battery was already switched to
  "ocv-capacity-table-n" device-prop + power_supply_batinfo_ocv2cap()
- Switch fg druver to iio_read_channel_processed_scale() which moves
  the Vbat ADC calibration handling and scaling to the IIO ADC driver
- Drop (already fixed) "power: supply: adc-battery-helper: Fix reporting
  capacity > 100%"

Changes in v2:
- Drop the 2 already merged bug-fix patches
- Add missing MODULE_DESCRIPTION() to the new adc-battery-helper module

Regards,

Hans

*** BLURB HERE ***

Hans de Goede (5):
  power: supply: Add adc-battery-helper
  power: supply: ug3105_battery: Switch to adc-battery-helper
  power: supply: ug3105_battery: Put FG in standby on remove and
    shutdown
  power: supply: adc-battery-helper: Add support for optional
    charge_finished GPIO
  power: supply: Add new Intel Dollar Cove TI battery driver

 drivers/power/supply/Kconfig               |  16 +
 drivers/power/supply/Makefile              |   2 +
 drivers/power/supply/adc-battery-helper.c  | 327 +++++++++++++++++
 drivers/power/supply/adc-battery-helper.h  |  62 ++++
 drivers/power/supply/intel_dc_ti_battery.c | 394 +++++++++++++++++++++
 drivers/power/supply/ug3105_battery.c      | 346 ++++--------------
 6 files changed, 867 insertions(+), 280 deletions(-)
 create mode 100644 drivers/power/supply/adc-battery-helper.c
 create mode 100644 drivers/power/supply/adc-battery-helper.h
 create mode 100644 drivers/power/supply/intel_dc_ti_battery.c

-- 
2.49.0


