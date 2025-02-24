Return-Path: <linux-pm+bounces-22843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2ABA4309D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 00:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1535517AFE4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 23:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CAB20B7EE;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFA42571AD;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439320; cv=none; b=d6WUhQYC9GRvB3tUOXqXGV9jC0uhJa3ze3t//yDoUiRxHPGM9XWgIZmC2KLJDlfblg7RgnlYyHKUePfofMtZYDqIF/4qysY/qTIBbZq0AuqHYaqi6Nx9z3xtBy/CapKgwtwzhpVU9MTtfTOjDamykW6YoJ7nsKf444FT985BUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439320; c=relaxed/simple;
	bh=FRmFi9i/dohft9kXQXHUNw9zRthT6BA/ZO7P+OEA/Tg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XXNslb6uQX8Z/wPf3tGbpVsyVJTYicOqWHvzJNcHd64kCTovbbLLJQeIFz+Fsyutw4Ws1/8mvHs726BvRJRKp8cvKHbWJ13mhOJjLrM2BXTceD6cGg04VU8fO0AhDegc0d5M/RmTPWCqEWMCY4t16LlsHBz+RVCv8ZfDeW+m+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2069AC4CEE8;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 420B218066D; Tue, 25 Feb 2025 00:21:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 0/7] power: supply: core: convert to fwnode
Date: Tue, 25 Feb 2025 00:21:33 +0100
Message-Id: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP3+vGcC/x3MPQqAMAxA4atIZgMa7aBXEQdpU83SSir+ULy7x
 eXBt7wMiVU4wVhlUD4lSQwFbV2B3ZawMoorBmrINEQt7ulBG5VLwsl64BHRXyE6RmcW0/fkbec
 HKINd2cv9z6f5fT9n8zkSbAAAAA==
X-Change-ID: 20250221-psy-core-convert-to-fwnode-d5a5442fc3f9
To: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, Samuel Holland <samuel@sholland.org>, 
 David Lechner <david@lechnology.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4565;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=FRmFi9i/dohft9kXQXHUNw9zRthT6BA/ZO7P+OEA/Tg=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBnvP8LwBsfsMPqhNW3Q9Z8oPHCkw9MnJk5mtaNE
 HkSMAD54iuJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZ7z/CwAKCRDY7tfzyDv6
 mtZyD/9gpAbaSTVDHWfO8vw/mF7Vq6c7KXwf8S7SgR/B9wmdUAdPSB/4o66mnFkSDwNz2NUMEdb
 dlxrM1cSFflYjC5saEMxvuFRhCWh6OXT4L2k14esjYg6QFX9BKkeBoOfVl+qljgJNofr/WBHb52
 4ntAMLY0BWmlKgbaqxC6RDbEoZfMh92jEzP7nIYNEg/tav/xPYfFAjxeTf8UYhYhc7rJXfESzcA
 jJFA5Bvpx6xELiY3AM3uTjgMBLY+HTl72R1ua0UlYvucPVegur7vBVsQezwDfkw2Moc6neE40zu
 WOxi1NUMtT9Z8J+TZ+yZD2rk+AKNnZ7JHabss2TzJS4RI6l8sJmD3m0RM4cRXpctLTXZdUDIcOC
 1e15+sTmn5KTnwbI4VJgdT5CGAwJfCqt0u7w04oUuv/rVzjnuegaORzyqLcZoly4K+c8u3PjFvL
 XHB2jdLu1sbacBwTP5OYkFRSwpKZ8u19SjLm6VVZDD+nPoH0BXWNMMHXw5MXYPGb03l2F4giMIb
 4ug5XqRBy9YusWNpGQx/dDqf34+8PFJ5pCdZeA6fp+nIf/kgjdAyt0im2k5W6g5TNJV29BySHib
 av5I4SFe6qScMNKXcA9UuHcqw8+H905kqiMKKE2BnR+NsMNVp1teHHgCz4/XhZbC/CPB9DeXTu3
 JrGBKUPHowjP5rA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The goal of this series is to replace any OF specific code in the
power-supply core with more generic fwnode code.

The first 5 patches of this series mostly take care of removing .of_node
from power_supply_config in favor of using the existing .fwnode.

Patch 6 replaces the OF specific logic in battery-info. This will
hopefully also allow Hans de Goede reusing the code with his Intel
Dollar Cove TI CC battery driver series.

Last but not least patch 7 replaces the OF phandle code with fwnode to
have everything converted.

Note, that I do not own a single device making use of the
"ocv-capacity-celsius" and "resistance-temp-table", which means patch 7
is basically untested. I would really appreciate if somebody gives this
series a test run on an affected device.

---
Sebastian Reichel (7):
      power: supply: core: get rid of of_node
      regulator: act8865-regulator: switch psy_cfg from of_node to fwnode
      usb: common: usb-conn-gpio: switch psy_cfg from of_node to fwnode
      power: supply: all: switch psy_cfg from of_node to fwnode
      power: supply: core: remove of_node from power_supply_config
      power: supply: core: battery-info: fully switch to fwnode
      power: supply: core: convert to fwnnode

 drivers/power/supply/ab8500_charger.c       |   4 +-
 drivers/power/supply/acer_a500_battery.c    |   3 +-
 drivers/power/supply/act8945a_charger.c     |   2 +-
 drivers/power/supply/axp20x_ac_power.c      |   2 +-
 drivers/power/supply/axp20x_battery.c       |   2 +-
 drivers/power/supply/axp20x_usb_power.c     |   2 +-
 drivers/power/supply/bd99954-charger.c      |   2 +-
 drivers/power/supply/bq2415x_charger.c      |   4 +-
 drivers/power/supply/bq24190_charger.c      |   2 +-
 drivers/power/supply/bq24735-charger.c      |   2 +-
 drivers/power/supply/bq2515x_charger.c      |   2 +-
 drivers/power/supply/bq256xx_charger.c      |   2 +-
 drivers/power/supply/bq25980_charger.c      |   2 +-
 drivers/power/supply/bq27xxx_battery.c      |   2 +-
 drivers/power/supply/cpcap-battery.c        |   2 +-
 drivers/power/supply/cpcap-charger.c        |   2 +-
 drivers/power/supply/ds2760_battery.c       |   3 +-
 drivers/power/supply/generic-adc-battery.c  |   2 +-
 drivers/power/supply/gpio-charger.c         |   2 +-
 drivers/power/supply/ingenic-battery.c      |   2 +-
 drivers/power/supply/ip5xxx_power.c         |   2 +-
 drivers/power/supply/lego_ev3_battery.c     |   3 +-
 drivers/power/supply/lt3651-charger.c       |   2 +-
 drivers/power/supply/ltc4162-l-charger.c    |   2 +-
 drivers/power/supply/max17042_battery.c     |   2 +-
 drivers/power/supply/max77650-charger.c     |   2 +-
 drivers/power/supply/max8903_charger.c      |   2 +-
 drivers/power/supply/mm8013.c               |   2 +-
 drivers/power/supply/mt6360_charger.c       |   2 +-
 drivers/power/supply/mt6370-charger.c       |   2 +-
 drivers/power/supply/olpc_battery.c         |   4 +-
 drivers/power/supply/pm8916_bms_vm.c        |   2 +-
 drivers/power/supply/pm8916_lbc.c           |   2 +-
 drivers/power/supply/power_supply_core.c    | 178 +++++++++++++++-------------
 drivers/power/supply/qcom_battmgr.c         |   5 +-
 drivers/power/supply/qcom_pmi8998_charger.c |   2 +-
 drivers/power/supply/qcom_smbb.c            |   2 +-
 drivers/power/supply/rk817_charger.c        |   2 +-
 drivers/power/supply/rt5033_battery.c       |   2 +-
 drivers/power/supply/rt5033_charger.c       |   3 +-
 drivers/power/supply/rt9455_charger.c       |   2 +-
 drivers/power/supply/rt9467-charger.c       |   2 +-
 drivers/power/supply/rt9471.c               |   2 +-
 drivers/power/supply/sbs-battery.c          |   2 +-
 drivers/power/supply/sbs-charger.c          |   2 +-
 drivers/power/supply/sbs-manager.c          |   2 +-
 drivers/power/supply/sc2731_charger.c       |   2 +-
 drivers/power/supply/sc27xx_fuel_gauge.c    |   3 +-
 drivers/power/supply/smb347-charger.c       |   2 +-
 drivers/power/supply/tps65090-charger.c     |   2 +-
 drivers/power/supply/tps65217_charger.c     |   2 +-
 drivers/power/supply/ucs1002_power.c        |   2 +-
 drivers/regulator/act8865-regulator.c       |   2 +-
 drivers/usb/common/usb-conn-gpio.c          |   2 +-
 include/linux/power_supply.h                |   4 +-
 55 files changed, 158 insertions(+), 144 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250221-psy-core-convert-to-fwnode-d5a5442fc3f9

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


