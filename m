Return-Path: <linux-pm+bounces-33483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E764FB3D2D4
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 14:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D19C188E9FA
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFEE239E97;
	Sun, 31 Aug 2025 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss8NPyBC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F8273FD
	for <linux-pm@vger.kernel.org>; Sun, 31 Aug 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756643386; cv=none; b=P4fimbqr1/xnJjKvA0vgsLpfkgluJ5GZPieDWjyIdXwrei/VCNEPkx/DPpLRuuX5SSCLBSI2ECsH2OseC6UvXgKP6KjmrOjCrDXTM85r/hf36mHONYdfeh70QM5lSgKcLzKgLkjb1y5E6QB26tg8Ns7yiAe/ZJ3RxrpJC98ZYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756643386; c=relaxed/simple;
	bh=h6fHTmvFTThBbhoJAEe5xq9rAaydUnjnglMlm/O3ytI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ci1ypWKDsv+AlU9H8t+0JOU9v2Z8XZZ62v5EXtKxGWx1jaL6penHqyEkezJ7llFhKwE2LPveVOhTAviy38XkE0eMLjbEdWqbWIRImyo0i/bHBI0ae7vkTThEhSym61/0LiBeMGzYbM4Lkuk6DW23FtR4f6bPBjYD6Rls1D/KgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss8NPyBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7087CC4CEED;
	Sun, 31 Aug 2025 12:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756643385;
	bh=h6fHTmvFTThBbhoJAEe5xq9rAaydUnjnglMlm/O3ytI=;
	h=From:To:Cc:Subject:Date:From;
	b=ss8NPyBCJyrFplxJuRj9z4HOcKbURqqXgalOYQNHJ3zKPgUGz+bWPWsC48L1gIqki
	 Ju9yl4DX9ElA1OzRChbGI2P2jTqZajaTZPblDwwFrUvue+eQPiSaBrlS/1+YEEwSM4
	 TUJXCjP45v6IjhKJrN/tZQDUBvAUDiKcfH7tC9u7+8NQWG/I+iaKQ/MZ432NeXO/rM
	 w25scaf7ExHMbT7MSKs1MOiz8ie25LRFq3ZZ+lfpXxZuk2RrNFZGbIuZwVtfX6HpQC
	 1eHaURajWirALKlW2xT8sNRsr3ZGIxayBEumwKgW70RwohcbmR1YL44DjYXuWDn5T8
	 /OL3U+nkwg6bg==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 0/5] power: supply: Add adc-battery-helper lib and Intel Dollar Cove TI CC battery driver
Date: Sun, 31 Aug 2025 14:29:36 +0200
Message-ID: <20250831122942.47875-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
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

Changes in v4:
- s/MOV_AVG_WINDOW/MOV_AVG_WINDOW_SIZE/
- s/CELCIUS/CELSIUS/
- s/procent/percent/
- Add Linus' Reviewed-by to all patches

Changes in v3:
- Drop hardcoded open-circuit-voltage to capacity mapping table, replacing
  it with using the "ocv-capacity-table-n" device-property and replace DIY
  code with power_supply_batinfo_ocv2cap()
- Rebase on latest upstream where ug3105_battery was already switched to
  "ocv-capacity-table-n" device-prop + power_supply_batinfo_ocv2cap()
- Switch fg driver to iio_read_channel_processed_scale() which moves
  the Vbat ADC calibration handling and scaling to the IIO ADC driver
- Drop (already fixed) "power: supply: adc-battery-helper: Fix reporting
  capacity > 100%"

Changes in v2:
- Drop the 2 already merged bug-fix patches
- Add missing MODULE_DESCRIPTION() to the new adc-battery-helper module

Regards,

Hans


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
2.51.0


