Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC9513FBF8
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 23:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389746AbgAPWG3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 17:06:29 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37225 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389709AbgAPWG2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 17:06:28 -0500
Received: by mail-qv1-f67.google.com with SMTP id f16so9848757qvi.4
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 14:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTahV1GtMN4KybIOWmxhd6seRxPFIwEPBPYiQMgNktc=;
        b=E9QaEx95aathN8Wz33qb3J0l0uaqUlb4hHoFlae249pHM7nLFU5Ukt/Llz+yugn3H0
         R2j7fBAi+ZQehL+WpOwZNFDVi+AHeWRXTCbmPG5UF1ifspWvUWDuuPKg8RbkL50oorwG
         3l015kb7WaiKhAtV5YqDIs2bCbqxjhPy/kAd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTahV1GtMN4KybIOWmxhd6seRxPFIwEPBPYiQMgNktc=;
        b=XKNgFCLdTFse/LPcswi8+cPuVTsNk8oEIM9v9R2P44CCRLBgw871imgfxF/9mL6e3h
         CIRvX4OJ6QZ0JyysjVfaccrNZOblOlj9TnGimy7QyPMWg9GApp3iIzoA5Hd5KFAJ+QN0
         LA380L1XZuUFq4qdqZn/H86sYJDbJUMwm953eh+l5CiGsrRXgQf+ic70ADYVNTuP/J/X
         CpSECH6BkXEHDKB9OBD7ZLnp8zuaEg52qba4tLz2fu1S0X9/Ug1QM/n3Ujk3LCu3uC1C
         gc41UghoaXamdRvnZt3boyjltVDSFNzXCqLTl+kDAxocCcMOhOBMR8MAeki1gaFISjX6
         9dlA==
X-Gm-Message-State: APjAAAWYUdOkHL3meGFtot8MLyhtoOCs49QFtl3qGvFpOPROf24FI2OJ
        rJPrJK0FZLH7ILtn1F4oyqJf2k1df26sFiX1IJOjgw==
X-Google-Smtp-Source: APXvYqw2VoMKNnGQJcQw3R7LDZtFBy1XQhNRN7JUwCsrBtWrV/1SWU+9BOXTMNzpxhCo7z0/XaPLAX0EEWVdm0sDeH8=
X-Received: by 2002:a05:6214:192f:: with SMTP id es15mr4937880qvb.219.1579212387126;
 Thu, 16 Jan 2020 14:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20200114232219.93171-1-pmalani@chromium.org> <20200116195129.GD208460@google.com>
In-Reply-To: <20200116195129.GD208460@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 16 Jan 2020 14:06:16 -0800
Message-ID: <CACeCKacARUw6AE3yUs0j7duL8y2JtHhpyQfTErARFsFvWREaeg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] platform: chrome: Add cros-usbpd-notify driver
To:     Benson Leung <bleung@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, sre@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 16, 2020 at 11:51 AM Benson Leung <bleung@google.com> wrote:
>
> On Tue, Jan 14, 2020 at 03:22:18PM -0800, Prashant Malani wrote:
> > From: Jon Flatley <jflat@chromium.org>
> >
> > ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
> > related events. The existing cros-usbpd-charger driver relies on these
> > events without ever actually receiving them on ACPI platforms. This is
> > because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
> > ACPI driver that offers firmware updates to USB-C chargers.
> >
> > Introduce a new platform driver under cros-ec, the ChromeOS embedded
> > controller, that handles these PD events and dispatches them
> > appropriately over a notifier chain to all drivers that use them.
> >
> > On platforms that don't have the ACPI device defined, the driver gets
> > instantiated for ECs which support the EC_FEATURE_USB_PD feature bit,
> > and the notification events will get delivered using the MKBP event
> > handling mechanism.
> >
> > Co-Developed-by: Prashant Malani <pmalani@chromium.org>
> > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: Jon Flatley <jflat@chromium.org>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> Minor nit, otherwise,
> Reviewed-by: Benson Leung <bleung@chromium.org>
Thanks, will add this in the next version.
>
>
> > ---
> > diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
> > new file mode 100644
> > index 0000000000000..858e494995843
> > --- /dev/null
> > +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> > @@ -0,0 +1,153 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2020 Google LLC
> > + *
> > + * This driver serves as the receiver of cros_ec PD host events.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/module.h>
> > +#include <linux/mfd/cros_ec.h>
> > +#include <linux/platform_data/cros_ec_commands.h>
> > +#include <linux/platform_data/cros_usbpd_notify.h>
>
> Same nit as other: Alphabetize #include list.
Done
>
> > +#include <linux/platform_data/cros_ec_proto.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define DRV_NAME "cros-usbpd-notify"
> > +#define ACPI_DRV_NAME "GOOG0003"
> > +
> > +static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
> > +
> > +/**
> > + * cros_usbpd_register_notify - Register a notifier callback for PD events.
> > + * @nb: Notifier block pointer to register
> > + *
> > + * On ACPI platforms this corresponds to host events on the ECPD
> > + * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp events
> > + * for USB PD events.
> > + *
> > + * Return: 0 on success or negative error code.
> > + */
> > +int cros_usbpd_register_notify(struct notifier_block *nb)
> > +{
> > +     return blocking_notifier_chain_register(
> > +                     &cros_usbpd_notifier_list, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(cros_usbpd_register_notify);
> > +
> > +
> > +/**
> > + * cros_usbpd_unregister_notify - Unregister notifier callback for PD events.
> > + * @nb: Notifier block pointer to unregister
> > + *
> > + * Unregister a notifier callback that was previously registered with
> > + * cros_usbpd_register_notify().
> > + */
> > +void cros_usbpd_unregister_notify(struct notifier_block *nb)
> > +{
> > +     blocking_notifier_chain_unregister(&cros_usbpd_notifier_list, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
> > +
> > +#ifdef CONFIG_ACPI
> > +
> > +static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
> > +{
> > +     blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> > +}
> > +
> > +static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
> > +     { ACPI_DRV_NAME, 0 },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, cros_usbpd_notify_acpi_device_ids);
> > +
> > +static struct acpi_driver cros_usbpd_notify_acpi_driver = {
> > +     .name = DRV_NAME,
> > +     .class = DRV_NAME,
> > +     .ids = cros_usbpd_notify_acpi_device_ids,
> > +     .ops = {
> > +             .add = cros_usbpd_notify_add_acpi,
> > +             .notify = cros_usbpd_notify_acpi,
> > +     },
> > +};
> > +module_acpi_driver(cros_usbpd_notify_acpi_driver);
> > +
> > +#endif /* CONFIG_ACPI */
> > +
> > +#ifdef CONFIG_OF
> > +
> > +static int cros_usbpd_notify_plat(struct notifier_block *nb,
> > +             unsigned long queued_during_suspend, void *data)
> > +{
> > +     struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
> > +     u32 host_event = cros_ec_get_host_event(ec_dev);
> > +
> > +     if (!host_event)
> > +             return NOTIFY_BAD;
> > +
> > +     if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> > +             blocking_notifier_call_chain(&cros_usbpd_notifier_list,
> > +                             host_event, NULL);
> > +             return NOTIFY_OK;
> > +     }
> > +     return NOTIFY_DONE;
> > +}
> > +
> > +static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
> > +     struct notifier_block *nb;
> > +     int ret;
> > +
> > +     nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
> > +     if (!nb)
> > +             return -ENOMEM;
> > +
> > +     nb->notifier_call = cros_usbpd_notify_plat;
> > +     dev_set_drvdata(dev, nb);
> > +
> > +     ret = blocking_notifier_chain_register(&ecdev->ec_dev->event_notifier,
> > +                                             nb);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to register notifier\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
> > +     struct notifier_block *nb =
> > +             (struct notifier_block *)dev_get_drvdata(dev);
> > +
> > +     blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier,
> > +                     nb);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver cros_usbpd_notify_plat_driver = {
> > +     .driver = {
> > +             .name = DRV_NAME,
> > +     },
> > +     .probe = cros_usbpd_notify_probe_plat,
> > +     .remove = cros_usbpd_notify_remove_plat,
> > +};
> > +module_platform_driver(cros_usbpd_notify_plat_driver);
> > +
> > +#endif /* CONFIG_OF */
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
> > +MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
> > +MODULE_ALIAS("platform:" DRV_NAME);
> > diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/include/linux/platform_data/cros_usbpd_notify.h
> > new file mode 100644
> > index 0000000000000..4f2791722b6d3
> > --- /dev/null
> > +++ b/include/linux/platform_data/cros_usbpd_notify.h
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ChromeOS EC Power Delivery Notifier Driver
> > + *
> > + * Copyright 2020 Google LLC
> > + */
> > +
> > +#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> > +#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> > +
> > +#include <linux/notifier.h>
> > +
> > +int cros_usbpd_register_notify(struct notifier_block *nb);
> > +
> > +void cros_usbpd_unregister_notify(struct notifier_block *nb);
> > +
> > +#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
>
> --
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org
