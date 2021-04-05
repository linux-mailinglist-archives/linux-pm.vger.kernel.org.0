Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222F53546F4
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbhDETJA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239304AbhDETIx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 15:08:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4571C061756;
        Mon,  5 Apr 2021 12:08:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a7so18233700ejs.3;
        Mon, 05 Apr 2021 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0QHNXbaTwsfV7jLzNxr19KZRs0HIlfTov9iWUs+upXI=;
        b=K+DUF5gw8r6nKsV0tNbOlg+H1Ur9B4kf/X+ffat7G/31mHHx0MeCCdJOLKjpsrIpfc
         qbMQcg5ttE3c7nIehjVgrapcvkbAr47437eh2cgL+FMzOhAoJi+bd6r3PXiDLZ7dLr0D
         2sfh0eNXF0V3m64gA3vYoHZkqx/tf7jZnOvGazRrty6+B2dVXEBJUu/jvCS7MwYkPErV
         hjwkL8giU5nHTBjP3XOlLQvnnIV76qYnjYyEb6cfYQ3nAE6TLhuZllcPpGbEN+7TFe+s
         apPyfcwpGp845oxy2Q6UiFNeKbpeqUaf8FOAzEtUybWiuXOPjMruCBHvBCA9sNbdUL7Z
         GJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0QHNXbaTwsfV7jLzNxr19KZRs0HIlfTov9iWUs+upXI=;
        b=NO8ga0fEpJUROvg1hoxuzuvoOGul22X1z0NvESTwwCJM5du/aijEnikSYAPVaLARYF
         b5R2iJuTNA3bUt7IN8JMoiriFX0fljs+QpRsPFlHHLQKdYYbQUkizvzJ74U+g/wjxiG5
         fnfJfBiAcTsN6Tbl5s1dwMSdY0Iquu51nSU/PgkCsSv0kJAXWOXSaX+6erQQR75Rayko
         OtSq5dUsVzASkjelKjxS8i/nl+gloC3mslVKVHDtpN5XyFz8SL3oiWzfFFNT8WNv7C5U
         5CMIDB/3AqHUCAC3Qhu+OWV9kltl5ve2/ZIdnaGclFYrmhy+bjanqCxro1nhhO16g04J
         2Jbg==
X-Gm-Message-State: AOAM531OvXWamueqHo5E031fDrHg1McdK0x0OJ2eA4H9HXPEnCRGdAok
        zT9xb8QrBVhvKXRZc7hzp8Tf0nzk3ak=
X-Google-Smtp-Source: ABdhPJxuRW4ice3UncXEZxZr9CP/PdlqGhCZ0NVqAS0NkMNR06axwvD+ecIxmcQ4XkiMwf6n4lylPQ==
X-Received: by 2002:a17:907:105c:: with SMTP id oy28mr11627437ejb.552.1617649722988;
        Mon, 05 Apr 2021 12:08:42 -0700 (PDT)
Received: from [10.18.0.9] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a3sm9356936ejv.40.2021.04.05.12.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 12:08:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] power: supply: Add AC driver for Surface Aggregator
 Module
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210309000530.2165752-1-luzmaximilian@gmail.com>
 <20210309000530.2165752-3-luzmaximilian@gmail.com>
 <20210405154730.3ezemy7jcnmooget@earth.universe>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <5a4b2bea-42ee-8516-bb90-c398238b31aa@gmail.com>
Date:   Mon, 5 Apr 2021 21:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210405154730.3ezemy7jcnmooget@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/5/21 5:47 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Mar 09, 2021 at 01:05:30AM +0100, Maximilian Luz wrote:
>> On newer Microsoft Surface models (specifically 7th-generation, i.e.
>> Surface Pro 7, Surface Book 3, Surface Laptop 3, and Surface Laptop Go),
>> battery and AC status/information is no longer handled via standard ACPI
>> devices, but instead directly via the Surface System Aggregator Module
>> (SSAM), i.e. the embedded controller on those devices.
>>
>> While on previous generation models, AC status is also handled via SSAM,
>> an ACPI shim was present to translate the standard ACPI AC interface to
>> SSAM requests. The SSAM interface itself, which is modeled closely after
>> the ACPI interface, has not changed.
>>
>> This commit introduces a new SSAM client device driver to support AC
>> status/information via the aforementioned interface on said Surface
>> models.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>
>> Note: This patch depends on the
>>
>>      platform/surface: Add Surface Aggregator device registry
>>
>> series. More specifically patch
>>
>>      platform/surface: Set up Surface Aggregator device registry
>>
>> The full series has been merged into the for-next branch of the
>> platform-drivers-x86 tree [1]. The commit in question can be found at
>> [2].
>>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=fc622b3d36e6d91330fb21506b9ad1e3206a4dde
>>
>> ---
>>   MAINTAINERS                            |   1 +
>>   drivers/power/supply/Kconfig           |  16 ++
>>   drivers/power/supply/Makefile          |   1 +
>>   drivers/power/supply/surface_charger.c | 296 +++++++++++++++++++++++++
>>   4 files changed, 314 insertions(+)
>>   create mode 100644 drivers/power/supply/surface_charger.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f44521abe8bf..d6651ba93997 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11867,6 +11867,7 @@ L:	linux-pm@vger.kernel.org
>>   L:	platform-driver-x86@vger.kernel.org
>>   S:	Maintained
>>   F:	drivers/power/supply/surface_battery.c
>> +F:	drivers/power/supply/surface_charger.c
>>   
>>   MICROSOFT SURFACE GPE LID SUPPORT DRIVER
>>   M:	Maximilian Luz <luzmaximilian@gmail.com>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index cebeff10d543..91f7cf425ac9 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -817,4 +817,20 @@ config BATTERY_SURFACE
>>   	  Microsoft Surface devices, i.e. Surface Pro 7, Surface Laptop 3,
>>   	  Surface Book 3, and Surface Laptop Go.
>>   
>> +config CHARGER_SURFACE
>> +	tristate "AC driver for 7th-generation Microsoft Surface devices"
>> +	depends on SURFACE_AGGREGATOR_REGISTRY
>> +	help
>> +	  Driver for AC devices connected via/managed by the Surface System
>> +	  Aggregator Module (SSAM).
>> +
>> +	  This driver provides AC-information and -status support for Surface
>> +	  devices where said data is not exposed via the standard ACPI devices.
>> +	  On those models (7th-generation), AC-information is instead handled
>> +	  directly via a SSAM client device and this driver.
>> +
>> +	  Say M or Y here to include AC status support for 7th-generation
>> +	  Microsoft Surface devices, i.e. Surface Pro 7, Surface Laptop 3,
>> +	  Surface Book 3, and Surface Laptop Go.
>> +
>>   endif # POWER_SUPPLY
>> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
>> index 134041538d2c..a7309a3d1a47 100644
>> --- a/drivers/power/supply/Makefile
>> +++ b/drivers/power/supply/Makefile
>> @@ -102,3 +102,4 @@ obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
>>   obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
>>   obj-$(CONFIG_BATTERY_ACER_A500)	+= acer_a500_battery.o
>>   obj-$(CONFIG_BATTERY_SURFACE)	+= surface_battery.o
>> +obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
>> diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
>> new file mode 100644
>> index 000000000000..fe484523a2c2
>> --- /dev/null
>> +++ b/drivers/power/supply/surface_charger.c
>> @@ -0,0 +1,296 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * AC driver for 7th-generation Microsoft Surface devices via Surface System
>> + * Aggregator Module (SSAM).
>> + *
>> + * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
>> + */
>> +
>> +#include <asm/unaligned.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/types.h>
>> +
>> +#include <linux/surface_aggregator/device.h>
>> +
>> +
>> +/* -- SAM interface. -------------------------------------------------------- */
>> +
>> +enum sam_event_cid_bat {
>> +	SAM_EVENT_CID_BAT_ADP   = 0x17,
>> +};
>> +
>> +enum sam_battery_sta {
>> +	SAM_BATTERY_STA_OK      = 0x0f,
>> +	SAM_BATTERY_STA_PRESENT	= 0x10,
>> +};
>> +
>> +/* Get battery status (_STA). */
>> +SSAM_DEFINE_SYNC_REQUEST_CL_R(ssam_bat_get_sta, __le32, {
>> +	.target_category = SSAM_SSH_TC_BAT,
>> +	.command_id      = 0x01,
>> +});
>> +
>> +/* Get platform power source for battery (_PSR / DPTF PSRC). */
>> +SSAM_DEFINE_SYNC_REQUEST_CL_R(ssam_bat_get_psrc, __le32, {
>> +	.target_category = SSAM_SSH_TC_BAT,
>> +	.command_id      = 0x0d,
>> +});
>> +
>> +
>> +/* -- Device structures. ---------------------------------------------------- */
>> +
>> +struct spwr_psy_properties {
>> +	const char *name;
>> +	struct ssam_event_registry registry;
>> +};
>> +
>> +struct spwr_ac_device {
>> +	struct ssam_device *sdev;
>> +
>> +	char name[32];
>> +	struct power_supply *psy;
>> +	struct power_supply_desc psy_desc;
>> +
>> +	struct ssam_event_notifier notif;
>> +
>> +	struct mutex lock;  /* Guards access to state below. */
>> +
>> +	__le32 state;
>> +};
>> +
>> +
>> +/* -- State management. ----------------------------------------------------- */
>> +
>> +static int spwr_ac_update_unlocked(struct spwr_ac_device *ac)
>> +{
>> +	u32 old = ac->state;
>> +	int status;
>> +
>> +	lockdep_assert_held(&ac->lock);
>> +
>> +	status = ssam_retry(ssam_bat_get_psrc, ac->sdev, &ac->state);
>> +	if (status < 0)
>> +		return status;
>> +
>> +	return old != ac->state;
>> +}
>> +
>> +static int spwr_ac_update(struct spwr_ac_device *ac)
>> +{
>> +	int status;
>> +
>> +	mutex_lock(&ac->lock);
>> +	status = spwr_ac_update_unlocked(ac);
>> +	mutex_unlock(&ac->lock);
>> +
>> +	return status;
>> +}
>> +
>> +static int spwr_ac_recheck(struct spwr_ac_device *ac)
>> +{
>> +	int status;
>> +
>> +	status = spwr_ac_update(ac);
>> +	if (status > 0)
>> +		power_supply_changed(ac->psy);
>> +
>> +	return status >= 0 ? 0 : status;
>> +}
>> +
>> +static u32 spwr_notify_ac(struct ssam_event_notifier *nf, const struct ssam_event *event)
>> +{
>> +	struct spwr_ac_device *ac;
>> +	int status;
>> +
>> +	ac = container_of(nf, struct spwr_ac_device, notif);
>> +
>> +	dev_dbg(&ac->sdev->dev, "power event (cid = %#04x, iid = %#04x, tid = %#04x)\n",
>> +		event->command_id, event->instance_id, event->target_id);
>> +
>> +	/*
>> +	 * Allow events of all targets/instances here. Global adapter status
>> +	 * seems to be handled via target=1 and instance=1, but events are
>> +	 * reported on all targets/instances in use.
>> +	 *
>> +	 * While it should be enough to just listen on 1/1, listen everywhere to
>> +	 * make sure we don't miss anything.
>> +	 */
>> +
>> +	switch (event->command_id) {
>> +	case SAM_EVENT_CID_BAT_ADP:
>> +		status = spwr_ac_recheck(ac);
>> +		return ssam_notifier_from_errno(status) | SSAM_NOTIF_HANDLED;
>> +
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>> +
>> +/* -- Properties. ----------------------------------------------------------- */
>> +
>> +static enum power_supply_property spwr_ac_props[] = {
>> +	POWER_SUPPLY_PROP_ONLINE,
>> +};
>> +
>> +static int spwr_ac_get_property(struct power_supply *psy, enum power_supply_property psp,
>> +				union power_supply_propval *val)
>> +{
>> +	struct spwr_ac_device *ac = power_supply_get_drvdata(psy);
>> +	int status;
>> +
>> +	mutex_lock(&ac->lock);
>> +
>> +	status = spwr_ac_update_unlocked(ac);
>> +	if (status)
>> +		goto out;
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_ONLINE:
>> +		val->intval = !!le32_to_cpu(ac->state);
>> +		break;
>> +
>> +	default:
>> +		status = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&ac->lock);
>> +	return status;
>> +}
>> +
>> +
>> +/* -- Device setup. --------------------------------------------------------- */
>> +
>> +static void spwr_ac_init(struct spwr_ac_device *ac, struct ssam_device *sdev,
>> +			 struct ssam_event_registry registry, const char *name)
>> +{
>> +	mutex_init(&ac->lock);
>> +	strncpy(ac->name, name, ARRAY_SIZE(ac->name) - 1);
>> +
>> +	ac->sdev = sdev;
>> +
>> +	ac->notif.base.priority = 1;
>> +	ac->notif.base.fn = spwr_notify_ac;
>> +	ac->notif.event.reg = registry;
>> +	ac->notif.event.id.target_category = sdev->uid.category;
>> +	ac->notif.event.id.instance = 0;
>> +	ac->notif.event.mask = SSAM_EVENT_MASK_NONE;
>> +	ac->notif.event.flags = SSAM_EVENT_SEQUENCED;
>> +
>> +	ac->psy_desc.name = ac->name;
>> +	ac->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
>> +	ac->psy_desc.properties = spwr_ac_props;
>> +	ac->psy_desc.num_properties = ARRAY_SIZE(spwr_ac_props);
>> +	ac->psy_desc.get_property = spwr_ac_get_property;
>> +}
>> +
>> +static void spwr_ac_destroy(struct spwr_ac_device *ac)
>> +{
>> +	mutex_destroy(&ac->lock);
> 
> same as battery driver - use devm_add_action_or_reset or
> just drop it. It's not very useful at the end of remove().

Right, I'll drop that.

>> +}
> 
> static char *battery_supplied_to[] = {
>      "BAT1",
>      "BAT2",
> };
> 
>> +static int spwr_ac_register(struct spwr_ac_device *ac)
>> +{
>> +	struct power_supply_config psy_cfg = {};
>> +	__le32 sta;
>> +	int status;
>> +
>> +	/* Make sure the device is there and functioning properly. */
>> +	status = ssam_retry(ssam_bat_get_sta, ac->sdev, &sta);
>> +	if (status)
>> +		return status;
>> +
>> +	if ((le32_to_cpu(sta) & SAM_BATTERY_STA_OK) != SAM_BATTERY_STA_OK)
>> +		return -ENODEV;
>> +
>> +	psy_cfg.drv_data = ac;
> 
> psy_cfg.supplied_to = battery_supplied_to;
> psy_cfg.num_supplicants = 2;

Thanks, I'll add that.

> 
>> +	ac->psy = power_supply_register(&ac->sdev->dev, &ac->psy_desc, &psy_cfg);
>> +	if (IS_ERR(ac->psy))
>> +		return PTR_ERR(ac->psy);
>> +
>> +	status = ssam_notifier_register(ac->sdev->ctrl, &ac->notif);
>> +	if (status)
>> +		power_supply_unregister(ac->psy);
>> +
>> +	return status;
>> +}
>> +
>> +static int spwr_ac_unregister(struct spwr_ac_device *ac)
>> +{
>> +	ssam_notifier_unregister(ac->sdev->ctrl, &ac->notif);
>> +	power_supply_unregister(ac->psy);
> 
> This driver can also use devm_power_supply_register :)

I'll switch to that.
  
>> +	return 0;
>> +}
>> +
>> +
>> +/* -- Driver setup. --------------------------------------------------------- */
>> +
>> +static int __maybe_unused surface_ac_resume(struct device *dev)
>> +{
>> +	return spwr_ac_recheck(dev_get_drvdata(dev));
>> +}
>> +SIMPLE_DEV_PM_OPS(surface_ac_pm_ops, NULL, surface_ac_resume);
>> +
>> +static int surface_ac_probe(struct ssam_device *sdev)
>> +{
>> +	const struct spwr_psy_properties *p;
>> +	struct spwr_ac_device *ac;
>> +	int status;
>> +
>> +	p = ssam_device_get_match_data(sdev);
>> +	if (!p)
>> +		return -ENODEV;
>> +
>> +	ac = devm_kzalloc(&sdev->dev, sizeof(*ac), GFP_KERNEL);
>> +	if (!ac)
>> +		return -ENOMEM;
>> +
>> +	spwr_ac_init(ac, sdev, p->registry, p->name);
>> +	ssam_device_set_drvdata(sdev, ac);
>> +
>> +	status = spwr_ac_register(ac);
>> +	if (status)
>> +		spwr_ac_destroy(ac);
>> +
>> +	return status;
>> +}
>> +
>> +static void surface_ac_remove(struct ssam_device *sdev)
>> +{
>> +	struct spwr_ac_device *ac = ssam_device_get_drvdata(sdev);
>> +
>> +	spwr_ac_unregister(ac);
>> +	spwr_ac_destroy(ac);
>> +}
>> +
>> +static const struct spwr_psy_properties spwr_psy_props_adp1 = {
>> +	.name = "ADP1",
>> +	.registry = SSAM_EVENT_REGISTRY_SAM,
>> +};
>> +
>> +static const struct ssam_device_id surface_ac_match[] = {
>> +	{ SSAM_SDEV(BAT, 0x01, 0x01, 0x01), (unsigned long)&spwr_psy_props_adp1 },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(ssam, surface_ac_match);
>> +
>> +static struct ssam_device_driver surface_ac_driver = {
>> +	.probe = surface_ac_probe,
>> +	.remove = surface_ac_remove,
>> +	.match_table = surface_ac_match,
>> +	.driver = {
>> +		.name = "surface_ac",
>> +		.pm = &surface_ac_pm_ops,
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>> +};
>> +module_ssam_device_driver(surface_ac_driver);
>> +
>> +MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
>> +MODULE_DESCRIPTION("AC driver for Surface System Aggregator Module");
>> +MODULE_LICENSE("GPL");
> 
> Otherwise LGTM.
> 
> Thanks,
> 
> -- Sebastian
> 

Thanks for the review!

I'll start working on v2 right away.

Regards,
Max
