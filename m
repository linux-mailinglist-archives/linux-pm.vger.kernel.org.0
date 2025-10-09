Return-Path: <linux-pm+bounces-35858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B00BC9F93
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 356904FE30B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC51C2F90CE;
	Thu,  9 Oct 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQpm4sz8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CAD2EFDAD;
	Thu,  9 Oct 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025517; cv=none; b=VtntqaVn1fE4u2A8mJqDHyFN1aqSl5RjPsXE5H2PGpHUMRJEVi970jEUVNSboxw7nY6l8ElhVFulO1uBkRN6Ob3Q2qsmt7wjPheeRkSWjCQOpBb7+qZgJ2fxHNWF7tW2MXKQRaIPlQ9Z4ryPpcnCfgWnEksaSsQ/6iTlq2t8dk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025517; c=relaxed/simple;
	bh=NoqpCHX3FP6ZDpeLmw4YBB/YIvuwXxwH+X+JXRPWeYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS2+HDRe/P88bS8tL22tJ+IijRhHEM9iZirfmPfOMDqtalYmruwOKGGiwUprHYaY1iH923TVY8znVBH/SN8Q64yeuRuFYqthDOmJM514aVpF4VsDGEvRQkzhvaJKCzofrpTsHxWbD9J+bXNGZNlhAcMAyR5CAOLgfB0wZP/LoNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQpm4sz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06EFC4CEF8;
	Thu,  9 Oct 2025 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025517;
	bh=NoqpCHX3FP6ZDpeLmw4YBB/YIvuwXxwH+X+JXRPWeYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQpm4sz8TU4jLCadkgJW2T/tfhEBhV3R1g1/K3/Iaj7pbnsGfCWP8S9HlB5Iy2CVq
	 Xrhht2uPI6MKMt86xsN+NspENSE6esqV8ZvvIQa8LkYrgrEIO312yNQ5iHtn8NPcuO
	 PhsQVkq/2nmpB8b6zlIguEYggdBiTeT6XuWThep3eVnJqAOuTugSrZwm3USPM/hvXk
	 0+rNx6xgKn9alXfiIhxgTnuqhNgYpgR7kQPdcC1NZ2IDVDwBGC+owgaO9SJHKLr6C+
	 V6Nsc+/ZHw206wUTTp+s+IjlxMRC0secqcMPx3BqQTZWGTFKAo8aXErJrHMxDXPa5F
	 3gwF8NjvL5E0w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Fabien Proriol <fabien.proriol@viavisolutions.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.15] power: supply: sbs-charger: Support multiple devices
Date: Thu,  9 Oct 2025 11:54:52 -0400
Message-ID: <20251009155752.773732-26-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fabien Proriol <fabien.proriol@viavisolutions.com>

[ Upstream commit 3ec600210849cf122606e24caab85f0b936cf63c ]

If we have 2 instances of sbs-charger in the DTS, the driver probe for the second instance will fail:

[    8.012874] sbs-battery 18-000b: sbs-battery: battery gas gauge device registered
[    8.039094] sbs-charger 18-0009: ltc4100: smart charger device registered
[    8.112911] sbs-battery 20-000b: sbs-battery: battery gas gauge device registered
[    8.134533] sysfs: cannot create duplicate filename '/class/power_supply/sbs-charger'
[    8.143871] CPU: 3 PID: 295 Comm: systemd-udevd Tainted: G           O      5.10.147 #22
[    8.151974] Hardware name: ALE AMB (DT)
[    8.155828] Call trace:
[    8.158292]  dump_backtrace+0x0/0x1d4
[    8.161960]  show_stack+0x18/0x6c
[    8.165280]  dump_stack+0xcc/0x128
[    8.168687]  sysfs_warn_dup+0x60/0x7c
[    8.172353]  sysfs_do_create_link_sd+0xf0/0x100
[    8.176886]  sysfs_create_link+0x20/0x40
[    8.180816]  device_add+0x270/0x7a4
[    8.184311]  __power_supply_register+0x304/0x560
[    8.188930]  devm_power_supply_register+0x54/0xa0
[    8.193644]  sbs_probe+0xc0/0x214 [sbs_charger]
[    8.198183]  i2c_device_probe+0x2dc/0x2f4
[    8.202196]  really_probe+0xf0/0x510
[    8.205774]  driver_probe_device+0xfc/0x160
[    8.209960]  device_driver_attach+0xc0/0xcc
[    8.214146]  __driver_attach+0xc0/0x170
[    8.218002]  bus_for_each_dev+0x74/0xd4
[    8.221862]  driver_attach+0x24/0x30
[    8.225444]  bus_add_driver+0x148/0x250
[    8.229283]  driver_register+0x78/0x130
[    8.233140]  i2c_register_driver+0x4c/0xe0
[    8.237250]  sbs_driver_init+0x20/0x1000 [sbs_charger]
[    8.242424]  do_one_initcall+0x50/0x1b0
[    8.242434]  do_init_module+0x44/0x230
[    8.242438]  load_module+0x2200/0x27c0
[    8.242442]  __do_sys_finit_module+0xa8/0x11c
[    8.242447]  __arm64_sys_finit_module+0x20/0x30
[    8.242457]  el0_svc_common.constprop.0+0x64/0x154
[    8.242464]  do_el0_svc+0x24/0x8c
[    8.242474]  el0_svc+0x10/0x20
[    8.242481]  el0_sync_handler+0x108/0x114
[    8.242485]  el0_sync+0x180/0x1c0
[    8.243847] sbs-charger 20-0009: Failed to register power supply
[    8.287934] sbs-charger: probe of 20-0009 failed with error -17

This is mainly because the "name" field of power_supply_desc is a constant.
This patch fixes the issue by reusing the same approach as sbs-battery.
With this patch, the result is:
[    7.819532] sbs-charger 18-0009: ltc4100: smart charger device registered
[    7.825305] sbs-battery 18-000b: sbs-battery: battery gas gauge device registered
[    7.887423] sbs-battery 20-000b: sbs-battery: battery gas gauge device registered
[    7.893501] sbs-charger 20-0009: ltc4100: smart charger device registered

Signed-off-by: Fabien Proriol <fabien.proriol@viavisolutions.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – the patch is a focused bugfix that should be carried into stable.

- Today every SBS charger instance shares the hard-coded `sbs-charger`
  name, so the second probe fails with `-EEXIST` and the device never
  registers; the change replaces that constant with a per-device
  descriptor template (drivers/power/supply/sbs-charger.c:157) and
  allocates a new copy during probe so each instance can be adjusted
  safely (drivers/power/supply/sbs-charger.c:167,
  drivers/power/supply/sbs-charger.c:171).
- The newly formatted `sbs-%s` name derives from the I²C device name
  (drivers/power/supply/sbs-charger.c:176) and is passed to
  `devm_power_supply_register()` (drivers/power/supply/sbs-
  charger.c:205), eliminating the duplicate sysfs entry that caused the
  regression without touching the rest of the driver.
- This mirrors the long-standing approach already used by the companion
  SBS gas-gauge driver (drivers/power/supply/sbs-battery.c:1125,
  drivers/power/supply/sbs-battery.c:1130), so the fix aligns the
  charger with existing subsystem practice and has no hidden
  dependencies.
- Scope is limited to this driver; no core power-supply or regmap
  behaviour changes, and the added helpers (`devm_kmemdup`,
  `devm_kasprintf`) are available in all supported stable branches.
- The only behavioural change is the user-visible power-supply name, but
  that’s the minimal way to let multiple chargers coexist—systems
  currently fail outright, while after backport they work and follow the
  same naming convention as the SBS battery driver.

 drivers/power/supply/sbs-charger.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index 27764123b929e..7d5e676205805 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -154,8 +154,7 @@ static const struct regmap_config sbs_regmap = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE, /* since based on SMBus */
 };
 
-static const struct power_supply_desc sbs_desc = {
-	.name = "sbs-charger",
+static const struct power_supply_desc sbs_default_desc = {
 	.type = POWER_SUPPLY_TYPE_MAINS,
 	.properties = sbs_properties,
 	.num_properties = ARRAY_SIZE(sbs_properties),
@@ -165,9 +164,20 @@ static const struct power_supply_desc sbs_desc = {
 static int sbs_probe(struct i2c_client *client)
 {
 	struct power_supply_config psy_cfg = {};
+	struct power_supply_desc *sbs_desc;
 	struct sbs_info *chip;
 	int ret, val;
 
+	sbs_desc = devm_kmemdup(&client->dev, &sbs_default_desc,
+				sizeof(*sbs_desc), GFP_KERNEL);
+	if (!sbs_desc)
+		return -ENOMEM;
+
+	sbs_desc->name = devm_kasprintf(&client->dev, GFP_KERNEL, "sbs-%s",
+					dev_name(&client->dev));
+	if (!sbs_desc->name)
+		return -ENOMEM;
+
 	chip = devm_kzalloc(&client->dev, sizeof(struct sbs_info), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
@@ -191,7 +201,7 @@ static int sbs_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, ret, "Failed to get device status\n");
 	chip->last_state = val;
 
-	chip->power_supply = devm_power_supply_register(&client->dev, &sbs_desc, &psy_cfg);
+	chip->power_supply = devm_power_supply_register(&client->dev, sbs_desc, &psy_cfg);
 	if (IS_ERR(chip->power_supply))
 		return dev_err_probe(&client->dev, PTR_ERR(chip->power_supply),
 				     "Failed to register power supply\n");
-- 
2.51.0


