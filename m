Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40C014C790
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 09:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgA2Ih2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 03:37:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2Ih2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 03:37:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C36AF291A32
Subject: Re: [PATCH v8 1/4] platform: chrome: Add cros-usbpd-notify driver
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@google.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, sre@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
References: <20200124231834.63628-1-pmalani@chromium.org>
 <adcf2a99-d6d8-cd4e-e22d-9ce539d87b7f@collabora.com>
 <20200127184439.GA150048@google.com>
 <CACeCKafdroLXf62aHeP8CZPuiR02EEmKAGmhHczzoSyX0bFv5g@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <dc1fec43-1bb0-53de-af17-a91fea42a3f5@collabora.com>
Date:   Wed, 29 Jan 2020 09:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CACeCKafdroLXf62aHeP8CZPuiR02EEmKAGmhHczzoSyX0bFv5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 29/1/20 2:11, Prashant Malani wrote:
> On Mon, Jan 27, 2020 at 10:44 AM Benson Leung <bleung@google.com> wrote:
>>
>> On Mon, Jan 27, 2020 at 03:58:42PM +0100, Enric Balletbo i Serra wrote:
>>> Hi Prashant,
>>>
>>> On 25/1/20 0:18, Prashant Malani wrote:
>>>> From: Jon Flatley <jflat@chromium.org>
>>>>
>>>> ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
>>>> related events. The existing cros-usbpd-charger driver relies on these
>>>> events without ever actually receiving them on ACPI platforms. This is
>>>> because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
>>>> ACPI driver that offers firmware updates to USB-C chargers.
>>>>
>>>> Introduce a new platform driver under cros-ec, the ChromeOS embedded
>>>> controller, that handles these PD events and dispatches them
>>>> appropriately over a notifier chain to all drivers that use them.
>>>>
>>>> On platforms that don't have the ACPI device defined, the driver gets
>>>> instantiated for ECs which support the EC_FEATURE_USB_PD feature bit,
>>>> and the notification events will get delivered using the MKBP event
>>>> handling mechanism.
>>>>
>>>> Co-Developed-by: Prashant Malani <pmalani@chromium.org>
>>>> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>>>> Reviewed-by: Benson Leung <bleung@chromium.org>
>>>> Signed-off-by: Jon Flatley <jflat@chromium.org>
>>>> Signed-off-by: Prashant Malani <pmalani@chromium.org>
>>>> ---
>>>>
>>>
>>> Just a nit below but for my own reference:
>>>
>>> Acked-for-chrome-platform: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>
>>> I am not sure if we're on time to get this merged on this merge window, though.
>>
>> I'm OK with creating a branch for this series and merging it into
>> chrome-platform-5.7 once Linus releases v5.6-rc1 late next week.
> Thanks; I'm guessing one of the maintainers will perform the creation
> of chrome-platform-5.7 and merge this patch into that branch.
> Also, kindly pick https://lkml.org/lkml/2020/1/24/2068 , i.e patch 4/4
> of this series (I think an earlier version of this patch, i.e
> https://lkml.org/lkml/2020/1/17/628 was marked "Reviewed-by: Sebastian
> Reichel <sebastian.reichel@collabora.com>"
> 

That patch should go through Sebastian's tree, we will create an immutable
branch for him when rc1 is released.

Thanks,
 Enric

> Thanks!
>>
>>>
>>> Thanks,
>>>  Enric
>>>
>>>> Changes in v8(pmalani@chromium.org):
>>>> - Fix style nits.
>>>> - Remove unrequired header.
>>>> - Remove #ifdef CONFIG_OF dependency for platform driver registration.
>>>> - Add module compile text to Kconfig help section.
>>>>
>>>> Changes in v7(pmalani@chromium.org):
>>>> - Removed use of module_platform_driver() and module_acpi_driver() since
>>>>   that was causing redefinition compilation errors on arm64 defconfig.
>>>>   Instead, explicitly defined the init and exit routines and
>>>>   register/unregister the platform and ACPI drivers there.
>>>> - Alphabetize #include header.
>>>>
>>>> Changes in v6(pmalani@chromium.org):
>>>> - Fix build error from typo in cros_usbpd_notify_acpi_device_ids
>>>>   variable name.
>>>>
>>>> Changes in v5(pmalani@chromium.org):
>>>> - Split the driver into platform and ACPI variants, each enclosed by
>>>>   CONFIG_OF and CONFIG_ACPI #ifdefs respectively.
>>>> - Updated the copyright year to 2020.
>>>> - Reworded the commit message and Kconfig description to incorporate
>>>>   the modified driver structure.
>>>>
>>>> Changes in v4(pmalani@chromium.org):
>>>> - No code changes, but added new version so that versioning is
>>>>   consistent with the next patch in the series.
>>>>
>>>> Changes in v3 (pmalani@chromium.org):
>>>> - Renamed driver and files from "cros_ec_pd_notify" to
>>>>   "cros_usbpd_notify" to be more consistent with other naming.
>>>> - Moved the change to include cros-usbpd-notify in the charger MFD
>>>>   into a separate follow-on patch.
>>>>
>>>> Changes in v2 (pmalani@chromium.org):
>>>> - Removed dependency on DT entry; instead, we will instantiate
>>>>   the driver on detecting EC_FEATURE_USB_PD for non-ACPI platforms.
>>>> - Modified the cros-ec-pd-notify device to be an mfd_cell under
>>>>   usbpdcharger for non-ACPI platforms. Altered the platform_probe() call
>>>>   to derive the cros EC structs appropriately.
>>>> - Replaced "usbpd_notify" with "pd_notify" in functions and structures.
>>>> - Addressed comments from upstream maintainer.
>>>>
>>>>  drivers/platform/chrome/Kconfig               |  13 ++
>>>>  drivers/platform/chrome/Makefile              |   1 +
>>>>  drivers/platform/chrome/cros_usbpd_notify.c   | 170 ++++++++++++++++++
>>>>  .../linux/platform_data/cros_usbpd_notify.h   |  17 ++
>>>>  4 files changed, 201 insertions(+)
>>>>  create mode 100644 drivers/platform/chrome/cros_usbpd_notify.c
>>>>  create mode 100644 include/linux/platform_data/cros_usbpd_notify.h
>>>>
>>>> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
>>>> index 5f57282a28da0..e45e0fe057586 100644
>>>> --- a/drivers/platform/chrome/Kconfig
>>>> +++ b/drivers/platform/chrome/Kconfig
>>>> @@ -226,6 +226,19 @@ config CROS_USBPD_LOGGER
>>>>       To compile this driver as a module, choose M here: the
>>>>       module will be called cros_usbpd_logger.
>>>>
>>>> +config CROS_USBPD_NOTIFY
>>>> +   tristate "ChromeOS Type-C power delivery event notifier"
>>>> +   depends on CROS_EC
>>>
>>> Like other cros-ec subdevices I am wondering if we should depend on
>>> MFD_CROS_EC_DEV instead of CROS_EC (as doesn't really makes sense to only
>>> depends on CROS_EC)
>>>
>>> Also, like other cros-ec subdevices, we might be interested on have a:
>>>
>>>        default MFD_CROS_EC_DEV
>>>
>>> So it is selected when the cros-ec dev is configured by default.
>>>
>>> Thanks,
>>>
>>>  Enric
>>>
>>>> +   help
>>>> +     If you say Y here, you get support for Type-C PD event notifications
>>>> +     from the ChromeOS EC. On ACPI platorms this driver will bind to the
>>>> +     GOOG0003 ACPI device, and on platforms which don't have this device it
>>>> +     will get initialized on ECs which support the feature
>>>> +     EC_FEATURE_USB_PD.
>>>> +
>>>> +     To compile this driver as a module, choose M here: the
>>>> +     module will be called cros_usbpd_notify.
>>>> +
>>>>  source "drivers/platform/chrome/wilco_ec/Kconfig"
>>>>
>>>>  endif # CHROMEOS_PLATFORMS
>>>> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
>>>> index aacd5920d8a18..f6465f8ef0b5e 100644
>>>> --- a/drivers/platform/chrome/Makefile
>>>> +++ b/drivers/platform/chrome/Makefile
>>>> @@ -22,5 +22,6 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)             += cros_ec_debugfs.o
>>>>  obj-$(CONFIG_CROS_EC_SENSORHUB)            += cros_ec_sensorhub.o
>>>>  obj-$(CONFIG_CROS_EC_SYSFS)                += cros_ec_sysfs.o
>>>>  obj-$(CONFIG_CROS_USBPD_LOGGER)            += cros_usbpd_logger.o
>>>> +obj-$(CONFIG_CROS_USBPD_NOTIFY)            += cros_usbpd_notify.o
>>>>
>>>>  obj-$(CONFIG_WILCO_EC)                     += wilco_ec/
>>>> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
>>>> new file mode 100644
>>>> index 0000000000000..6ead5c62b3c5f
>>>> --- /dev/null
>>>> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
>>>> @@ -0,0 +1,170 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright 2020 Google LLC
>>>> + *
>>>> + * This driver serves as the receiver of cros_ec PD host events.
>>>> + */
>>>> +
>>>> +#include <linux/acpi.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/mfd/cros_ec.h>
>>>> +#include <linux/platform_data/cros_ec_proto.h>
>>>> +#include <linux/platform_data/cros_usbpd_notify.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +#define DRV_NAME "cros-usbpd-notify"
>>>> +#define ACPI_DRV_NAME "GOOG0003"
>>>> +
>>>> +static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
>>>> +
>>>> +/**
>>>> + * cros_usbpd_register_notify - Register a notifier callback for PD events.
>>>> + * @nb: Notifier block pointer to register
>>>> + *
>>>> + * On ACPI platforms this corresponds to host events on the ECPD
>>>> + * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp events
>>>> + * for USB PD events.
>>>> + *
>>>> + * Return: 0 on success or negative error code.
>>>> + */
>>>> +int cros_usbpd_register_notify(struct notifier_block *nb)
>>>> +{
>>>> +   return blocking_notifier_chain_register(&cros_usbpd_notifier_list,
>>>> +                                           nb);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cros_usbpd_register_notify);
>>>> +
>>>> +/**
>>>> + * cros_usbpd_unregister_notify - Unregister notifier callback for PD events.
>>>> + * @nb: Notifier block pointer to unregister
>>>> + *
>>>> + * Unregister a notifier callback that was previously registered with
>>>> + * cros_usbpd_register_notify().
>>>> + */
>>>> +void cros_usbpd_unregister_notify(struct notifier_block *nb)
>>>> +{
>>>> +   blocking_notifier_chain_unregister(&cros_usbpd_notifier_list, nb);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
>>>> +
>>>> +#ifdef CONFIG_ACPI
>>>> +
>>>> +static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
>>>> +{
>>>> +   return 0;
>>>> +}
>>>> +
>>>> +static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
>>>> +{
>>>> +   blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
>>>> +}
>>>> +
>>>> +static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
>>>> +   { ACPI_DRV_NAME, 0 },
>>>> +   { }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(acpi, cros_usbpd_notify_acpi_device_ids);
>>>> +
>>>> +static struct acpi_driver cros_usbpd_notify_acpi_driver = {
>>>> +   .name = DRV_NAME,
>>>> +   .class = DRV_NAME,
>>>> +   .ids = cros_usbpd_notify_acpi_device_ids,
>>>> +   .ops = {
>>>> +           .add = cros_usbpd_notify_add_acpi,
>>>> +           .notify = cros_usbpd_notify_acpi,
>>>> +   },
>>>> +};
>>>> +
>>>> +#endif /* CONFIG_ACPI */
>>>> +
>>>> +static int cros_usbpd_notify_plat(struct notifier_block *nb,
>>>> +                             unsigned long queued_during_suspend,
>>>> +                             void *data)
>>>> +{
>>>> +   struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
>>>> +   u32 host_event = cros_ec_get_host_event(ec_dev);
>>>> +
>>>> +   if (!host_event)
>>>> +           return NOTIFY_BAD;
>>>> +
>>>> +   if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
>>>> +           blocking_notifier_call_chain(&cros_usbpd_notifier_list,
>>>> +                                        host_event, NULL);
>>>> +           return NOTIFY_OK;
>>>> +   }
>>>> +   return NOTIFY_DONE;
>>>> +}
>>>> +
>>>> +static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
>>>> +{
>>>> +   struct device *dev = &pdev->dev;
>>>> +   struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
>>>> +   struct notifier_block *nb;
>>>> +   int ret;
>>>> +
>>>> +   nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
>>>> +   if (!nb)
>>>> +           return -ENOMEM;
>>>> +
>>>> +   nb->notifier_call = cros_usbpd_notify_plat;
>>>> +   dev_set_drvdata(dev, nb);
>>>> +
>>>> +   ret = blocking_notifier_chain_register(&ecdev->ec_dev->event_notifier,
>>>> +                                          nb);
>>>> +   if (ret < 0) {
>>>> +           dev_err(dev, "Failed to register notifier\n");
>>>> +           return ret;
>>>> +   }
>>>> +
>>>> +   return 0;
>>>> +}
>>>> +
>>>> +static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
>>>> +{
>>>> +   struct device *dev = &pdev->dev;
>>>> +   struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
>>>> +   struct notifier_block *nb =
>>>> +           (struct notifier_block *)dev_get_drvdata(dev);
>>>> +
>>>> +   blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier, nb);
>>>> +
>>>> +   return 0;
>>>> +}
>>>> +
>>>> +static struct platform_driver cros_usbpd_notify_plat_driver = {
>>>> +   .driver = {
>>>> +           .name = DRV_NAME,
>>>> +   },
>>>> +   .probe = cros_usbpd_notify_probe_plat,
>>>> +   .remove = cros_usbpd_notify_remove_plat,
>>>> +};
>>>> +
>>>> +static int __init cros_usbpd_notify_init(void)
>>>> +{
>>>> +   int ret;
>>>> +
>>>> +   ret = platform_driver_register(&cros_usbpd_notify_plat_driver);
>>>> +   if (ret < 0)
>>>> +           return ret;
>>>> +
>>>> +#ifdef CONFIG_ACPI
>>>> +   acpi_bus_register_driver(&cros_usbpd_notify_acpi_driver);
>>>> +#endif
>>>> +   return 0;
>>>> +}
>>>> +
>>>> +static void __exit cros_usbpd_notify_exit(void)
>>>> +{
>>>> +#ifdef CONFIG_ACPI
>>>> +   acpi_bus_unregister_driver(&cros_usbpd_notify_acpi_driver);
>>>> +#endif
>>>> +   platform_driver_unregister(&cros_usbpd_notify_plat_driver);
>>>> +}
>>>> +
>>>> +module_init(cros_usbpd_notify_init);
>>>> +module_exit(cros_usbpd_notify_exit);
>>>> +
>>>> +MODULE_LICENSE("GPL");
>>>> +MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
>>>> +MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
>>>> +MODULE_ALIAS("platform:" DRV_NAME);
>>>> diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/include/linux/platform_data/cros_usbpd_notify.h
>>>> new file mode 100644
>>>> index 0000000000000..4f2791722b6d3
>>>> --- /dev/null
>>>> +++ b/include/linux/platform_data/cros_usbpd_notify.h
>>>> @@ -0,0 +1,17 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * ChromeOS EC Power Delivery Notifier Driver
>>>> + *
>>>> + * Copyright 2020 Google LLC
>>>> + */
>>>> +
>>>> +#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
>>>> +#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
>>>> +
>>>> +#include <linux/notifier.h>
>>>> +
>>>> +int cros_usbpd_register_notify(struct notifier_block *nb);
>>>> +
>>>> +void cros_usbpd_unregister_notify(struct notifier_block *nb);
>>>> +
>>>> +#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
>>>>
>>
>> --
>> Benson Leung
>> Staff Software Engineer
>> Chrome OS Kernel
>> Google Inc.
>> bleung@google.com
>> Chromium OS Project
>> bleung@chromium.org
