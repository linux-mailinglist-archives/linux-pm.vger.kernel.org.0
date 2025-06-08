Return-Path: <linux-pm+bounces-28253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E12AD143F
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3412A7A4DC7
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B67253F2B;
	Sun,  8 Jun 2025 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZJJzKzw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE818CC1C
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415214; cv=none; b=h/SGTuXjrKVkxc7/g9+xaZcN1HGUiUpsHCVhPZl0JqmpyO/hif/NQSw/Q3vvKw/KHYodewfxjtrRRXIvqn74kK5IGz2unyNF0E5C0imWEsZhycQorJ7Mq/4DS7O/dYuAl/3uHUIIgw5BGwS/G9du1/zl68M8xPJIDPbiFmmMjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415214; c=relaxed/simple;
	bh=1OEJpRB13IcI/bXBoK7ym0bWpyJu3MyyFVCpaqfm90w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKL6vnkBZ8OSoKbaMY0zIVjhZ9v+4vWKjKIdBH5R5wIySc4YoJh8SnlOABRwjYr7poziN7w3VjDDVGUJuu9l1oxQbXsDszQrWsAkoQjW6t1oaCsDTQLa3c1ZC5deh4pwo+dCtcdpzqys7aGIhM9LfQdH4qmHxsToyWId5Qt1eeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZJJzKzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1201C4CEEE;
	Sun,  8 Jun 2025 20:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749415214;
	bh=1OEJpRB13IcI/bXBoK7ym0bWpyJu3MyyFVCpaqfm90w=;
	h=From:To:Cc:Subject:Date:From;
	b=kZJJzKzw6XpP1g0VqZR5T9PGx+geRnGeQUZjGG6mv50kjdWiKMCHlaW1xkkO5BU6l
	 Zvzrn/82kYY0iOBazKMgzgboZT8W6kgVeW94FLjQ7yINB4XijA3xk6wWgvga0lDbh0
	 vBXWNflB6Fv1xu2mXfhTYakawy5pbRVQ8DOKvOjkKLVBifg2h0bcWt8fj8iEwyWBDW
	 7H5zXZv6vVcgVY22+/lehIJflmSpUayszjfXptSQwqDQEbvDJkKJVAdq/ZpBOClC0B
	 9afOrc+ApIW8cO/tbW5694W2chKZ2Sg9Rl1hzfQn8sTBfvySWj9CTThaOScd5UwdME
	 G06fQPfDZ59wg==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 00/10] power: supply: ug3105_battery: Switch to power_supply_batinfo_ocv2cap()
Date: Sun,  8 Jun 2025 22:40:00 +0200
Message-ID: <20250608204010.37482-1-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series converts the ug3105_battery driver from using
a static ovc - capcity mapping table + its own DIY code to using
the ovc-capacity-table(s) from the battery fwnode and using the
power_supply_batinfo_ocv2cap() helper.

Since the ug3105_battery driver is used on ACPI platforms this relies
on sre's "[PATCH v2 0/5] power: supply: core: convert to fwnode" series
for completenes sake I've added a copy of that series + 2 fixup patches to
"[PATCH v2 3/5] power: supply: core: battery-info: fully switch to fwnode",
the original patches are unmodified.

While working on this I also noticed somewhat of a memleak in the bq24190
driver, so the final patch in the series is a fix for that.

Regards,

Hans


Hans de Goede (5):
  fixup! power: supply: core: battery-info: fully switch to fwnode
  fixup! power: supply: core: battery-info: fully switch to fwnode
  power: supply: ug3105_battery: Use psy->battery_info
  power: supply: ug3105_battery: Switch to power_supply_batinfo_ocv2cap()
  power: supply: bq24190: Free battery_info

Sebastian Reichel (5):
  regulator: act8865-regulator: switch psy_cfg from of_node to fwnode
  power: supply: core: remove of_node from power_supply_config
  power: supply: core: battery-info: fully switch to fwnode
  power: supply: core: convert to fwnnode
  power: supply: core: rename power_supply_get_by_phandle to
    power_supply_get_by_reference

 drivers/phy/allwinner/phy-sun4i-usb.c    |   2 +-
 drivers/power/supply/bq2415x_charger.c   |   2 +-
 drivers/power/supply/bq24190_charger.c   |   2 +
 drivers/power/supply/power_supply_core.c | 185 ++++++++++++-----------
 drivers/power/supply/ug3105_battery.c    |  81 ++--------
 drivers/regulator/act8865-regulator.c    |   2 +-
 include/linux/power_supply.h             |  16 +-
 7 files changed, 118 insertions(+), 172 deletions(-)

-- 
2.49.0


