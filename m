Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB5148EBB
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 20:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbgAXTfU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 14:35:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33944 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390186AbgAXTfU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 14:35:20 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D25272686FE
Subject: Re: [PATCH v7 1/3] platform: chrome: Add cros-usbpd-notify driver
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, sre@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
References: <20200117002820.56872-1-pmalani@chromium.org>
 <c338d46d-5600-a53e-5a04-12100f5628b1@collabora.com>
 <CACeCKafMOUgLgrO-VwAH5so-O7ALZXdTaiC_=2E9M91mhfFt6g@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <75dc83a6-c183-6808-c668-d31a71a31682@collabora.com>
Date:   Fri, 24 Jan 2020 20:35:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CACeCKafMOUgLgrO-VwAH5so-O7ALZXdTaiC_=2E9M91mhfFt6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Prashant,

On 21/1/20 22:17, Prashant Malani wrote:
> Hi Enric,
> 
> Thanks for the recommendations; Please see some notes inline:
> On Tue, Jan 21, 2020 at 4:10 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi Prashant,
>>
>> Sorry, I am still having issues with this patch. It doesn't work as expected on
>> my Samsung Chromebook Plus because the below code tries to register twice the
>> driver and then hangs for some reason.
>>
>>   [    9.381368] Error: Driver 'cros-usbpd-notify' is already registered,
>> aborting...
> Hmm, is this because platform_driver_register and
> acpi_bus_driver_register both try to register a device with the same
> name?
> If so, we could simply rename the drivers (cros-usbpd-notify-platform
> and cros-usbpd-notify-acpi) and then we don't have to make any other
> modifications?
>>
>> Also I have the problem that I don't have any x86 device using the
>> cros_usbpd_charger so I can't really test for x86.
>>
>> Let me propose some changes and let's see if it works for you.
>>
>> On 17/1/20 1:28, Prashant Malani wrote:
>>> From: Jon Flatley <jflat@chromium.org>
>>> @@ -226,6 +226,16 @@ config CROS_USBPD_LOGGER
>>>         To compile this driver as a module, choose M here: the
>>>         module will be called cros_usbpd_logger.
>>>
>>> +config CROS_USBPD_NOTIFY
>>> +     tristate "ChromeOS Type-C power delivery event notifier"
>>> +     depends on CROS_EC
>>> +     help
>>> +       If you say Y here, you get support for Type-C PD event notifications
>>> +       from the ChromeOS EC. On ACPI platorms this driver will bind to the
>>> +       GOOG0003 ACPI device, and on platforms which don't have this device it
>>
>> Please use a max length of 80 characters.
> My text editor says that it is 80 chars, but I will verify it again.
>>
>>> +       will get initialized on ECs which support the feature
>>> +       EC_FEATURE_USB_PD.
>>> +
>>
>> Please add:
>>
>>           To compile this driver as a module, choose M here: the
>>           module will be called cros_usbpd_notify.
>>
>> So checkpatch --strict is more happy.
> Done
>>
>>>  source "drivers/platform/chrome/wilco_ec/Kconfig"
>>>
>>>  endif # CHROMEOS_PLATFORMS
>>> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
>>> index aacd5920d8a18..f6465f8ef0b5e 100644
>>> --- a/drivers/platform/chrome/Makefile
>>> +++ b/drivers/platform/chrome/Makefile
>>> @@ -22,5 +22,6 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)               += cros_ec_debugfs.o
>>>  obj-$(CONFIG_CROS_EC_SENSORHUB)              += cros_ec_sensorhub.o
>>>  obj-$(CONFIG_CROS_EC_SYSFS)          += cros_ec_sysfs.o
>>>  obj-$(CONFIG_CROS_USBPD_LOGGER)              += cros_usbpd_logger.o
>>> +obj-$(CONFIG_CROS_USBPD_NOTIFY)              += cros_usbpd_notify.o
>>>
>>>  obj-$(CONFIG_WILCO_EC)                       += wilco_ec/
>>> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
>>> new file mode 100644
>>> index 0000000000000..4705164e38bf4
>>> --- /dev/null
>>> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
>>> @@ -0,0 +1,180 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright 2020 Google LLC
>>> + *
>>> + * This driver serves as the receiver of cros_ec PD host events.
>>> + */
>>> +
>>> +#include <linux/acpi.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mfd/cros_ec.h>
>>> +#include <linux/platform_data/cros_ec_commands.h>
>>
>> I think this include is not needed.
> Done
>>
>>> +#include <linux/platform_data/cros_ec_proto.h>
>>> +#include <linux/platform_data/cros_usbpd_notify.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +#define DRV_NAME "cros-usbpd-notify"
>>> +#define ACPI_DRV_NAME "GOOG0003"
>>> +
>>> +static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
>>> +
>>> +/**
>>> + * cros_usbpd_register_notify - Register a notifier callback for PD events.
>>> + * @nb: Notifier block pointer to register
>>> + *
>>> + * On ACPI platforms this corresponds to host events on the ECPD
>>> + * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp events
>>> + * for USB PD events.
>>> + *
>>> + * Return: 0 on success or negative error code.
>>> + */
>>> +int cros_usbpd_register_notify(struct notifier_block *nb)
>>> +{
>>> +     return blocking_notifier_chain_register(
>>> +                     &cros_usbpd_notifier_list, nb);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cros_usbpd_register_notify);
>>> +
>>> +
>>
>> Please don't use multiple blank lines
> Sorry, done.
>>
>>> +/**
>>> + * cros_usbpd_unregister_notify - Unregister notifier callback for PD events.
>>> + * @nb: Notifier block pointer to unregister
>>> + *
>>> + * Unregister a notifier callback that was previously registered with
>>> + * cros_usbpd_register_notify().
>>> + */
>>> +void cros_usbpd_unregister_notify(struct notifier_block *nb)
>>> +{
>>> +     blocking_notifier_chain_unregister(&cros_usbpd_notifier_list, nb);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
>>> +
>>> +#ifdef CONFIG_ACPI
>>> +
>>> +static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>> +static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
>>> +{
>>> +     blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
>>> +}
>>> +
>>> +static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
>>> +     { ACPI_DRV_NAME, 0 },
>>> +     { }
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, cros_usbpd_notify_acpi_device_ids);
>>> +
>>> +static struct acpi_driver cros_usbpd_notify_acpi_driver = {
>>> +     .name = DRV_NAME,
>>> +     .class = DRV_NAME,
>>> +     .ids = cros_usbpd_notify_acpi_device_ids,
>>> +     .ops = {
>>> +             .add = cros_usbpd_notify_add_acpi,
>>> +             .notify = cros_usbpd_notify_acpi,
>>> +     },
>>> +};
>>> +
>>> +#endif /* CONFIG_ACPI */
>>> +
>>> +#ifdef CONFIG_OF
>>> +
>>
>> I propose to remove this ...
>>
>>> +static int cros_usbpd_notify_plat(struct notifier_block *nb,
>>> +             unsigned long queued_during_suspend, void *data)
>>> +{
>>> +     struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
>>> +     u32 host_event = cros_ec_get_host_event(ec_dev);
>>> +
>>> +     if (!host_event)
>>> +             return NOTIFY_BAD;
>>> +
>>> +     if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
>>> +             blocking_notifier_call_chain(&cros_usbpd_notifier_list,
>>> +                             host_event, NULL);
>>> +             return NOTIFY_OK;
>>> +     }
>>> +     return NOTIFY_DONE;
>>> +}
>>> +
>>> +static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
>>> +{
>>> +     struct device *dev = &pdev->dev;
>>> +     struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
>>> +     struct notifier_block *nb;
>>> +     int ret;
>>> +
>>
>> What about this?
>>
>> +       /*
>> +        * We only need to register the notifier if we are really using
>> +        * device-tree, otherwise, for ACPI case it will register an
>> +        * acpi_driver and use the .notify callback.
>> +        */
>> +       if (IS_ENABLED(CONFIG_OF) && !dev->of_node)
>> +               return 0;
>> +
> If we add your proposed check in cros_ec_dev.c, do we need this check
> here? It seems like both check the same thing, i.e only go ahead and
> initialize the module and add the device if "IS_ENABLED(CONFIG_OF) &&
> dev->of_node" is true.

I think that we still need because the probe function will be called on both
case. But better to check and make sure.

> Also, kindly see my note further down regarding of_node
> ("dev->of_node" evaluates to false even for the DT case on the ARM
> builds I am testing with)
>>
>>> +     nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
>>> +     if (!nb)
>>> +             return -ENOMEM;
>>> +
>>> +     nb->notifier_call = cros_usbpd_notify_plat;
>>> +     dev_set_drvdata(dev, nb);
>>> +
>>> +     ret = blocking_notifier_chain_register(&ecdev->ec_dev->event_notifier,
>>> +                                             nb);
>>> +     if (ret < 0) {
>>> +             dev_err(dev, "Failed to register notifier\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
>>> +{
>>> +     struct device *dev = &pdev->dev;
>>> +     struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
>>> +     struct notifier_block *nb =
>>> +             (struct notifier_block *)dev_get_drvdata(dev);
>>> +
>>
>> Only unregister for the device-tree case
>>
>> +       if (IS_ENABLED(CONFIG_OF) && dev->of_node)
> Same as above; is this required if we check for of_node in cros_ec_dev?
>>
>>> +     blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier,
>>> +                     nb);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static struct platform_driver cros_usbpd_notify_plat_driver = {
>>> +     .driver = {
>>> +             .name = DRV_NAME,
>>> +     },
>>> +     .probe = cros_usbpd_notify_probe_plat,
>>> +     .remove = cros_usbpd_notify_remove_plat,
>>> +};
>>> +
>>> +#endif /* CONFIG_OF */
>>> +
>>> +static int __init cros_usbpd_notify_init(void)
>>> +{
>>> +     int ret = 0;
>>> +#ifdef CONFIG_OF
>>> +     ret = platform_driver_register(&cros_usbpd_notify_plat_driver);
>>> +     if (ret != 0)
>>> +             pr_err("cros-usbpd-notify platform driver register failed.\n");
>>> +#endif
>>
>>
>> To simplify the ifdery, let's register the platform driver always, it'll be noop
>> in ACPI case.
>>
>>         int ret;
>>
>>         ret = platform_driver_register(&cros_usbpd_notify_driver);
>>         if (ret < 0)
>>                 return ret;
>>
>>
>>> +#ifdef CONFIG_ACPI
>>> +     ret = acpi_bus_register_driver(&cros_usbpd_notify_acpi_driver);
>>> +     if (ret != 0)
>>> +             pr_err("cros-usbpd-notify ACPI driver register failed.\n");
>>> +#endif
>>> +     return ret;
> We should return 0 here, correct?

Yes.

>>
>> And register the ACPI driver if CONFIG_ACPI is enabled, note that the error is
>> ignored because that call will fail on device-tree based devices with
>> CONFIG_ACPI enabled.
> 
> My initial thought was that this would fail for the case where we have
> CONFIG_ACPI && actually use an ACPI device (like newer x86
> Chromebooks), because the acpi_bus_register_driver() would fail, since
> the platform driver was already registered.
> However, on testing with CONFIG_ACPI && !CONFIG_OF on a system which
> has the GOOG0003 device, I see the "notify" call being invoked
> successfully, so this works.
>>
>> +#ifdef CONFIG_ACPI
>> +       acpi_bus_unregister_driver(&cros_usbpd_notify_acpi_driver)
>> +#endif
> Just checking, the above edit is not needed here, right? Sounds like
> it's a duplicate of what you added in _exit().

I think is still needed, but just let's check

>>
>>> +}
>>> +
>>> +static void __exit cros_usbpd_notify_exit(void)
>>> +{
>>> +#ifdef CONFIG_OF
>>> +     platform_driver_unregister(&cros_usbpd_notify_plat_driver);
>>> +#endif
>>> +#ifdef CONFIG_ACPI
>>> +     acpi_bus_unregister_driver(&cros_usbpd_notify_acpi_driver);
>>> +#endif
>>
>> And for the remove, only unregister the acpi driver if CONFIG_ACPI is enabled.
> Done.
>>
>> +#ifdef CONFIG_ACPI
>> +       acpi_bus_unregister_driver(&cros_usbpd_notify_acpi_driver);
>> +#endif
>> +       platform_driver_unregister(&cros_usbpd_notify_driver);
>>
>>
>>> +}
>>> +
>>> +module_init(cros_usbpd_notify_init);
>>> +module_exit(cros_usbpd_notify_exit);
>>> +
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
>>> +MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
>>> +MODULE_ALIAS("platform:" DRV_NAME);
>>
>>
>> Double check that the code builds with different CONFIG options. I didn't check
>> the ifery involved.
>>
>>   CONFIG_ACPI && CONFIG_OF
>>   CONFIG_ACPI && !CONFIG_OF
>>   !CONFIG_ACPI && CONFIG_OF
>>
>> And we need to _make sure_ that the platform driver is _only_ instantiated via
>> cros_ec_dev when we are really under a device-tree based device, so the check
>> probably should be something like this:
>>
>>
>> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
>> index 39e611695053..c43026754718 100644
>> --- a/drivers/mfd/cros_ec_dev.c
>> +++ b/drivers/mfd/cros_ec_dev.c
>> @@ -211,7 +211,7 @@ static int ec_device_probe(struct platform_device *pdev)
>>          * explicitly added on platforms that don't have the PD notifier ACPI
>>          * device entry defined.
>>          */
>> -       if (IS_ENABLED(CONFIG_OF)) {
>> +       if (IS_ENABLED(CONFIG_OF) && &pdev->dev.of_node) {
> I observe that when we have CONFIG_OF && !CONFIG_ACPI , the
> cros_usbpd_notify_probe_plat() function doesn't get called. I think
> adding "pdev->dev.of_node" causes the if clause to always evaluate to
> false.
> I think the check here would be :
>             if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node)
> and then remove check for of_node from cros_usbpd_notify.c
> 

I'd double check

> Also, should this change be split into a separate patch (because it is
> in the mfd driver)?
> 

Yes

> So, in summary, my proposed additions to the edits you suggested are:
> - Remove IS_ENABLED(CONFIG_OF)... checks from
> cros_usbpd_notify_probe_plat() and cros_usbpd_notify_remove_plat()
> - Change check in cros_ec_dev to be:
>               if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node)
> 
> WDYT? Could you kindly try this on your kevin configuration? I've
> tried it for the cases "CONFIG_OF && !CONFIG_ACPI" and "!CONFIG_OF &&
> CONFIG_ACPI" but not the third one (CONFIG_OF && CONFIG_ACPI) since I
> don't have an environment to test with (I can confirm it builds).
> 
> Thanks as always for helping iterate on this.
> 
> 

Let's continue talking with a new version. Could you send another one and I can
check. I have now setup both systems one with ACPi and another one with OF.

Thanks,
 Enric


>>                 if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
>>                         retval = mfd_add_hotplug_devices(ec->dev,
>>                                         cros_usbpd_notify_cells,
>>
>>
>>> diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/include/linux/platform_data/cros_usbpd_notify.h
>>> new file mode 100644
>>> index 0000000000000..4f2791722b6d3
>>> --- /dev/null
>>> +++ b/include/linux/platform_data/cros_usbpd_notify.h
>>> @@ -0,0 +1,17 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * ChromeOS EC Power Delivery Notifier Driver
>>> + *
>>> + * Copyright 2020 Google LLC
>>> + */
>>> +
>>> +#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
>>> +#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
>>> +
>>> +#include <linux/notifier.h>
>>> +
>>> +int cros_usbpd_register_notify(struct notifier_block *nb);
>>> +
>>> +void cros_usbpd_unregister_notify(struct notifier_block *nb);
>>> +
>>> +#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
>>>
>>
>> Cheers,
>>  Enric
