Return-Path: <linux-pm+bounces-21129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE82A22E6C
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912BB7A213D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 13:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6D51E5700;
	Thu, 30 Jan 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXn4vhIH"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D83187FEC
	for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245648; cv=none; b=amIpK4PmR4354nNg6e5JYE/hxFbcHbVuWXJcvaMbqbvw3OsiWSnGaQ5AaMMytStJWsfOOtlGJG0pRJ/HEBY6+NtfoLjVzxvHyDcBRsEoVnT5hgjYhpqADCfUL5ln6xRPMEhtH68JK2Dac/GgoDbbD0GSPSruiuea0lpzSaL793w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245648; c=relaxed/simple;
	bh=aJpkp7InaYydNvpRZDWndJBX9xM+VW/kg3kkESwZVfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdXZPFOrr3Raq0k3jOfXi6UPTsJItm+dpupQrXAkqy62TT8HdzjoBViT7zzS5+FEH6sqoVssgvnnlUitU6/hYv9eaM5Vo6KkRUxZr+1XysFbIfAh2o/882uAk4KZ8TLQkml9KH2D8233WNx9Fnffw+gMOttX8SKsd45c75EmVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXn4vhIH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738245645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5pEqdPkEqJQT8krAuLESl2ph61LT66PtGsU3+s8d+nc=;
	b=UXn4vhIH8YQacFcK5KHYBNdJtm6beXlDDM0kZesHFwcl9AxV8fkOP/Vdmo/A0utRn063HE
	ITqWhM2+qgYdhaNsiam+R4rEB8Yxvs/hGY7DdDOhtjFGq2OTJ1GHfqmp3WUs4gwmmC2Mpz
	Deew9WI65wUe9FL0dCiD+uOaDIOyFpQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-JPHgXIslOMGPcDoovm9fpQ-1; Thu,
 30 Jan 2025 09:00:41 -0500
X-MC-Unique: JPHgXIslOMGPcDoovm9fpQ-1
X-Mimecast-MFC-AGG-ID: JPHgXIslOMGPcDoovm9fpQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E025819560BA;
	Thu, 30 Jan 2025 14:00:38 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.0])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1A0B1956094;
	Thu, 30 Jan 2025 14:00:36 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH] power: supply: core: Fix extension related lockdep warning
Date: Thu, 30 Jan 2025 15:00:35 +0100
Message-ID: <20250130140035.20636-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Since commit 6037802bbae8 ("power: supply: core: implement extension API")
there is the following ABBA deadlock (simplified) between the LED trigger
code and the power-supply code:

1) When registering a power-supply class device, power_supply_register()
calls led_trigger_register() from power_supply_create_triggers() in
a scoped_guard(rwsem_read, &psy->extensions_sem) context.
led_trigger_register() then in turn takes a LED subsystem lock.
So here we have the following locking order:

* Read-lock extensions_sem
* Lock LED subsystem lock(s)

2) When registering a LED class device, with its default trigger set
to a power-supply LED trigger (which has already been registered)
The LED class code calls power_supply_led_trigger_activate() when
setting up the default trigger. power_supply_led_trigger_activate()
calls power_supply_get_property() to determine the initial value of
to assign to the LED and that read-locks extensions_sem. So now we
have the following locking order:

* Lock LED subsystem lock(s)
* Read-lock extensions_sem

Fixing this is easy, there is no need to hold the extensions_sem when
calling power_supply_create_triggers() since all triggers are always
created rather then checking for the presence of certain attributes as
power_supply_add_hwmon_sysfs() does. Move power_supply_create_triggers()
out of the guard block to fix this.

Here is the lockdep report fixed by this change:

[   31.249343] ======================================================
[   31.249378] WARNING: possible circular locking dependency detected
[   31.249413] 6.13.0-rc6+ #251 Tainted: G         C  E
[   31.249440] ------------------------------------------------------
[   31.249471] (udev-worker)/553 is trying to acquire lock:
[   31.249501] ffff892adbcaf660 (&psy->extensions_sem){.+.+}-{4:4}, at: power_supply_get_property.part.0+0x22/0x150
[   31.249574]
               but task is already holding lock:
[   31.249603] ffff892adbc0bad0 (&led_cdev->trigger_lock){+.+.}-{4:4}, at: led_trigger_set_default+0x34/0xe0
[   31.249657]
               which lock already depends on the new lock.

[   31.249696]
               the existing dependency chain (in reverse order) is:
[   31.249735]
               -> #2 (&led_cdev->trigger_lock){+.+.}-{4:4}:
[   31.249778]        down_write+0x3b/0xd0
[   31.249803]        led_trigger_set_default+0x34/0xe0
[   31.249833]        led_classdev_register_ext+0x311/0x3a0
[   31.249863]        input_leds_connect+0x1dc/0x2a0
[   31.249889]        input_attach_handler.isra.0+0x75/0x90
[   31.249921]        input_register_device.cold+0xa1/0x150
[   31.249955]        hidinput_connect+0x8a2/0xb80
[   31.249982]        hid_connect+0x582/0x5c0
[   31.250007]        hid_hw_start+0x3f/0x60
[   31.250030]        hid_device_probe+0x122/0x1f0
[   31.250053]        really_probe+0xde/0x340
[   31.250080]        __driver_probe_device+0x78/0x110
[   31.250105]        driver_probe_device+0x1f/0xa0
[   31.250132]        __device_attach_driver+0x85/0x110
[   31.250160]        bus_for_each_drv+0x78/0xc0
[   31.250184]        __device_attach+0xb0/0x1b0
[   31.250207]        bus_probe_device+0x94/0xb0
[   31.250230]        device_add+0x64a/0x860
[   31.250252]        hid_add_device+0xe5/0x240
[   31.250279]        usbhid_probe+0x4dc/0x620
[   31.250303]        usb_probe_interface+0xe4/0x2a0
[   31.250329]        really_probe+0xde/0x340
[   31.250353]        __driver_probe_device+0x78/0x110
[   31.250377]        driver_probe_device+0x1f/0xa0
[   31.250404]        __device_attach_driver+0x85/0x110
[   31.250431]        bus_for_each_drv+0x78/0xc0
[   31.250455]        __device_attach+0xb0/0x1b0
[   31.250478]        bus_probe_device+0x94/0xb0
[   31.250501]        device_add+0x64a/0x860
[   31.250523]        usb_set_configuration+0x606/0x8a0
[   31.250552]        usb_generic_driver_probe+0x3e/0x60
[   31.250579]        usb_probe_device+0x3d/0x120
[   31.250605]        really_probe+0xde/0x340
[   31.250629]        __driver_probe_device+0x78/0x110
[   31.250653]        driver_probe_device+0x1f/0xa0
[   31.250680]        __device_attach_driver+0x85/0x110
[   31.250707]        bus_for_each_drv+0x78/0xc0
[   31.250731]        __device_attach+0xb0/0x1b0
[   31.250753]        bus_probe_device+0x94/0xb0
[   31.250776]        device_add+0x64a/0x860
[   31.250798]        usb_new_device.cold+0x141/0x38f
[   31.250828]        hub_event+0x1166/0x1980
[   31.250854]        process_one_work+0x20f/0x580
[   31.250879]        worker_thread+0x1d1/0x3b0
[   31.250904]        kthread+0xee/0x120
[   31.250926]        ret_from_fork+0x30/0x50
[   31.250954]        ret_from_fork_asm+0x1a/0x30
[   31.250982]
               -> #1 (triggers_list_lock){++++}-{4:4}:
[   31.251022]        down_write+0x3b/0xd0
[   31.251045]        led_trigger_register+0x40/0x1b0
[   31.251074]        power_supply_register_led_trigger+0x88/0x150
[   31.251107]        power_supply_create_triggers+0x55/0xe0
[   31.251135]        __power_supply_register.part.0+0x34e/0x4a0
[   31.251164]        devm_power_supply_register+0x70/0xc0
[   31.251190]        bq27xxx_battery_setup+0x1a1/0x6d0 [bq27xxx_battery]
[   31.251235]        bq27xxx_battery_i2c_probe+0xe5/0x17f [bq27xxx_battery_i2c]
[   31.251272]        i2c_device_probe+0x125/0x2b0
[   31.251299]        really_probe+0xde/0x340
[   31.251324]        __driver_probe_device+0x78/0x110
[   31.251348]        driver_probe_device+0x1f/0xa0
[   31.251375]        __driver_attach+0xba/0x1c0
[   31.251398]        bus_for_each_dev+0x6b/0xb0
[   31.251421]        bus_add_driver+0x111/0x1f0
[   31.251445]        driver_register+0x6e/0xc0
[   31.251470]        i2c_register_driver+0x41/0xb0
[   31.251498]        do_one_initcall+0x5e/0x3a0
[   31.251522]        do_init_module+0x60/0x220
[   31.251550]        __do_sys_init_module+0x15f/0x190
[   31.251575]        do_syscall_64+0x93/0x180
[   31.251598]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   31.251629]
               -> #0 (&psy->extensions_sem){.+.+}-{4:4}:
[   31.251668]        __lock_acquire+0x13ce/0x21c0
[   31.251694]        lock_acquire+0xcf/0x2e0
[   31.251719]        down_read+0x3e/0x170
[   31.251741]        power_supply_get_property.part.0+0x22/0x150
[   31.251774]        power_supply_update_leds+0x8d/0x230
[   31.251804]        power_supply_led_trigger_activate+0x18/0x20
[   31.251837]        led_trigger_set+0x1fc/0x300
[   31.251863]        led_trigger_set_default+0x90/0xe0
[   31.251892]        led_classdev_register_ext+0x311/0x3a0
[   31.251921]        devm_led_classdev_multicolor_register_ext+0x6e/0xb80 [led_class_multicolor]
[   31.251969]        ktd202x_probe+0x464/0x5c0 [leds_ktd202x]
[   31.252002]        i2c_device_probe+0x125/0x2b0
[   31.252027]        really_probe+0xde/0x340
[   31.252052]        __driver_probe_device+0x78/0x110
[   31.252076]        driver_probe_device+0x1f/0xa0
[   31.252103]        __driver_attach+0xba/0x1c0
[   31.252125]        bus_for_each_dev+0x6b/0xb0
[   31.252148]        bus_add_driver+0x111/0x1f0
[   31.252172]        driver_register+0x6e/0xc0
[   31.252197]        i2c_register_driver+0x41/0xb0
[   31.252225]        do_one_initcall+0x5e/0x3a0
[   31.252248]        do_init_module+0x60/0x220
[   31.252274]        __do_sys_init_module+0x15f/0x190
[   31.253986]        do_syscall_64+0x93/0x180
[   31.255826]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   31.257614]
               other info that might help us debug this:

[   31.257619] Chain exists of:
                 &psy->extensions_sem --> triggers_list_lock --> &led_cdev->trigger_lock

[   31.257630]  Possible unsafe locking scenario:

[   31.257632]        CPU0                    CPU1
[   31.257633]        ----                    ----
[   31.257634]   lock(&led_cdev->trigger_lock);
[   31.257637]                                lock(triggers_list_lock);
[   31.257640]                                lock(&led_cdev->trigger_lock);
[   31.257643]   rlock(&psy->extensions_sem);
[   31.257646]
                *** DEADLOCK ***

[   31.289433] 4 locks held by (udev-worker)/553:
[   31.289443]  #0: ffff892ad9658108 (&dev->mutex){....}-{4:4}, at: __driver_attach+0xaf/0x1c0
[   31.289463]  #1: ffff892adbc0bbc8 (&led_cdev->led_access){+.+.}-{4:4}, at: led_classdev_register_ext+0x1c7/0x3a0
[   31.289476]  #2: ffffffffad0e30b0 (triggers_list_lock){++++}-{4:4}, at: led_trigger_set_default+0x2c/0xe0
[   31.289487]  #3: ffff892adbc0bad0 (&led_cdev->trigger_lock){+.+.}-{4:4}, at: led_trigger_set_default+0x34/0xe0

Fixes: 6037802bbae8 ("power: supply: core: implement extension API")
Cc: Thomas Weißschuh <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d0bb52a7a036..76c340b38015 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1592,11 +1592,11 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto register_thermal_failed;
 
-	scoped_guard(rwsem_read, &psy->extensions_sem) {
-		rc = power_supply_create_triggers(psy);
-		if (rc)
-			goto create_triggers_failed;
+	rc = power_supply_create_triggers(psy);
+	if (rc)
+		goto create_triggers_failed;
 
+	scoped_guard(rwsem_read, &psy->extensions_sem) {
 		rc = power_supply_add_hwmon_sysfs(psy);
 		if (rc)
 			goto add_hwmon_sysfs_failed;
-- 
2.47.1


