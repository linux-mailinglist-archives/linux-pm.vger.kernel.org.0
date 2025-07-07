Return-Path: <linux-pm+bounces-30300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3FDAFB80C
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 17:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706843A204F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DB721B9FE;
	Mon,  7 Jul 2025 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kazoe.org header.i=@kazoe.org header.b="MhghkCwU"
X-Original-To: linux-pm@vger.kernel.org
Received: from srv.kazoe.org (ns3132923.ip-51-75-130.eu [51.75.130.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DF21767A
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.130.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903713; cv=none; b=j3ygcHOcDFCubgMI11U+QKW1RvP86nS0KkH+n0s+pyEvwxmnV8KmVhqZMCEy1OyUWtg46KUn62qjk3MLgsmltTnE5GFITGmJ7/QDoKCT6TNswfEzI5Yn5zDmN+96ZCfCPynvV4fFZAH2p9rhc9fzpn7IPXv6LUB5VVBUQty5JDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903713; c=relaxed/simple;
	bh=McOr9CNNTaYw1i9Mq0ckPGAv1sbc5EWwsnznUZ5lXPw=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=LakTElKK0hCK226eP2fSywBXxuPM8EEMBN2yHv/8D/sDkR7QNxC8dA2WBCHYQdG6HZ9rRqFPVOt55gE9nu0RpF9by21s5272D5sZbqzTDJ/Dqf6XLB4vo36bB61vNmCeVqhAwth6/rVQZf4x9c7PMh0esfEZUqdV0s31x+cs58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kazoe.org; spf=pass smtp.mailfrom=kazoe.org; dkim=pass (2048-bit key) header.d=kazoe.org header.i=@kazoe.org header.b=MhghkCwU; arc=none smtp.client-ip=51.75.130.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kazoe.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kazoe.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kazoe.org; s=mail;
	t=1751903708; bh=McOr9CNNTaYw1i9Mq0ckPGAv1sbc5EWwsnznUZ5lXPw=;
	h=Date:From:To:Cc:Subject:From;
	b=MhghkCwUPH9xGRksWIW0l/NzbDbXIhJNJAXTfOMTZeecPLf+AfyzWe2QFYsbGG9v1
	 d+BcbsRS+fNuy42vuyuj9voMCQFSG5eneMZ+xmmZrAShpK8AbA4LTFZY/ZKyIZJcDL
	 8NwELojd8tT0iGTBz76uPiVNHwlLd5OnUgRMX0S0QQLt5jU/zTdmkjSFwHhlDwwke0
	 VGGbt7w9kEpunr/kwuRWPNTf4p3PU3xXSSadxugeMx0L6fXzMgdzw3m3M1BH5E5pMp
	 y+NhamjC5WGVSMFGR66fkgduFeg9m+Df8MOgUYJK62PdM2nXNR+gJrH24SeGr05aft
	 2cqrUDNSPRZng==
Received: from webmail.kazoe.org (localhost [IPv6:::1])
	by srv.kazoe.org (Postfix) with ESMTPSA id 8E82152004B4;
	Mon,  7 Jul 2025 15:55:08 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Jul 2025 17:55:08 +0200
From: fabien.proriol@kazoe.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: sbs-charger: Support multiple devices
Message-ID: <dbcaebb545667cafd53d60da19308ae1@kazoe.org>
X-Sender: fabien.proriol@kazoe.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi, I'm resending this patch from another email account since the format of my previous one was corrupted by my company's Exchange server.

Subject: [PATCH] power: supply: sbs-charger: Support multiple devices

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
---
 drivers/power/supply/sbs-charger.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index 27764123b929..4bf4dfb50539 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -154,8 +154,7 @@ static const struct regmap_config sbs_regmap = {
        .val_format_endian = REGMAP_ENDIAN_LITTLE, /* since based on SMBus */
 };
 
-static const struct power_supply_desc sbs_desc = {
-       .name = "sbs-charger",
+static const struct power_supply_desc sbs_default_desc = {
        .type = POWER_SUPPLY_TYPE_MAINS,
        .properties = sbs_properties,
        .num_properties = ARRAY_SIZE(sbs_properties),
@@ -166,8 +165,19 @@ static int sbs_probe(struct i2c_client *client)
 {
        struct power_supply_config psy_cfg = {};
        struct sbs_info *chip;
+       struct power_supply_desc *sbs_desc;
        int ret, val;
 
+       sbs_desc = devm_kmemdup(&client->dev, &sbs_default_desc,
+                       sizeof(*sbs_desc), GFP_KERNEL);
+       if (!sbs_desc)
+               return -ENOMEM;
+
+       sbs_desc->name = devm_kasprintf(&client->dev, GFP_KERNEL, "sbs-%s",
+                       dev_name(&client->dev));
+       if (!sbs_desc->name)
+               return -ENOMEM;
+
        chip = devm_kzalloc(&client->dev, sizeof(struct sbs_info), GFP_KERNEL);
        if (!chip)
                return -ENOMEM;
@@ -191,7 +201,7 @@ static int sbs_probe(struct i2c_client *client)
                return dev_err_probe(&client->dev, ret, "Failed to get device status\n");
        chip->last_state = val;
 
-       chip->power_supply = devm_power_supply_register(&client->dev, &sbs_desc, &psy_cfg);
+       chip->power_supply = devm_power_supply_register(&client->dev, sbs_desc, &psy_cfg);
        if (IS_ERR(chip->power_supply))
                return dev_err_probe(&client->dev, PTR_ERR(chip->power_supply),
                                     "Failed to register power supply\n");
-- 
2.47.2


