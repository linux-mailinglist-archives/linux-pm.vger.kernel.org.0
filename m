Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB83913FC01
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 23:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389756AbgAPWJP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 17:09:15 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42684 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAPWJP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 17:09:15 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so9830496qvb.9
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 14:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUb8ilLBAhUZ6/jWBRcP+4R7/8UlPkVpgXywFwbpI6U=;
        b=TYC/GqZ5SQrKgEdAAYYA9Wut1vr7vwQzUWfzcrfJ2CSuF+xvvIw7qNNmJQ4xTwesfM
         e3VyuCwNqv57wZoT7JPmfyoeilP1kSDk3rvXlnK0W8N0gJsZCmu6A76umz/I9HhPoQiM
         LkhvhsaENVh/dt2wy9RTxLdRxZ2xvim6+8lVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUb8ilLBAhUZ6/jWBRcP+4R7/8UlPkVpgXywFwbpI6U=;
        b=UzUxcaXKUJArOePuh23SRQv3xlL8aah/EH/YYsGT9eOcpV0wk7CuRx5DbzoxHHSI49
         oaVCd/hLNtxUpX2BKTeYhdZIfmAeqg3bibqzeVX/QlaMHJwoWjaORp9RAcum19q4ztkD
         D8ILtRBhNlBGDi99IS9elfSJYPZR4kw4cerjnp07oCpwwMtSr+dybf1P01QSj9gb2kM5
         A5J5/35FS9zylBM2ZjJky8piopPpPkmnmP5AmlCg0lC8A61HXhXmKaLiMIIKE2E9lR7N
         HAD1TsU8pzRCXa42o+cTev8qhRD697nBMcjnd0DYxO1F5wjF+R1/CRweY1RVmDUWDpBX
         pqhA==
X-Gm-Message-State: APjAAAXZ0H3TugO52qIrRe7X41IqFLLJoiagz1AViSEsbWglw6KLCl+B
        z7dFFHxc5vJ6Z3TORktoARB/k2R8R2vzqCCQpVI06g==
X-Google-Smtp-Source: APXvYqzXGRlWrfImjI5+ICjTTTiaWsfN0EkDJEtf2hE3RMf7K345toyyMRu3pnzUIZ1iBKJVlU2ezfP3BVKWbra3njY=
X-Received: by 2002:a0c:e790:: with SMTP id x16mr1240023qvn.18.1579212554458;
 Thu, 16 Jan 2020 14:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20200114232219.93171-1-pmalani@chromium.org> <20200114232219.93171-3-pmalani@chromium.org>
 <20200116194556.GB208460@google.com>
In-Reply-To: <20200116194556.GB208460@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 16 Jan 2020 14:09:04 -0800
Message-ID: <CACeCKafnm-NQrzNs7hpMRiYDuhQ-t_mdNaevCqEpefnxaZkNYw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] power: supply: cros-ec-usbpd-charger: Fix host events
To:     Benson Leung <bleung@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, sre@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Jon Flatley <jflat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 16, 2020 at 11:46 AM Benson Leung <bleung@google.com> wrote:
>
> On Tue, Jan 14, 2020 at 03:22:22PM -0800, Prashant Malani wrote:
> > From: Jon Flatley <jflat@chromium.org>
> >
> > There's a bug on ACPI platforms where host events from the ECPD ACPI
> > device never make their way to the cros-ec-usbpd-charger driver. This
> > makes it so the only time the charger driver updates its state is when
> > user space accesses its sysfs attributes.
> >
> > Now that these events have been unified into a single notifier chain on
> > both ACPI and non-ACPI platforms, update the charger driver to use this
> > new notifier.
> >
> > Signed-off-by: Jon Flatley <jflat@chromium.org>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> Only a minor nit. Otherwise,
> Reviewed-by: Benson Leung <bleung@chromium.org>
>
>
> > ---
> >
> > Changes in v6(pmalani@chromium.org):
> > - Patch first introduced into the series in v6.
> >
> >  drivers/power/supply/Kconfig              |  2 +-
> >  drivers/power/supply/cros_usbpd-charger.c | 50 ++++++++---------------
> >  2 files changed, 19 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index 27164a1d3c7c4..ba74ddd793c3d 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -659,7 +659,7 @@ config CHARGER_RT9455
> >
> >  config CHARGER_CROS_USBPD
> >       tristate "ChromeOS EC based USBPD charger"
> > -     depends on CROS_EC
> > +     depends on CROS_USBPD_NOTIFY
> >       default n
> >       help
> >         Say Y here to enable ChromeOS EC based USBPD charger
> > diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> > index 6cc7c3910e098..7f7e051262170 100644
> > --- a/drivers/power/supply/cros_usbpd-charger.c
> > +++ b/drivers/power/supply/cros_usbpd-charger.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/mfd/cros_ec.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_data/cros_ec_commands.h>
> > +#include <linux/platform_data/cros_usbpd_notify.h>
>
> Really minor nit. Alphabetize this #include. This insertion should
> be one line below.
Done. Thanks.
>
> >  #include <linux/platform_data/cros_ec_proto.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/power_supply.h>
> > @@ -524,32 +525,21 @@ static int cros_usbpd_charger_property_is_writeable(struct power_supply *psy,
> >  }
> >
> >  static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
> > -                                    unsigned long queued_during_suspend,
> > +                                    unsigned long host_event,
> >                                      void *_notify)
> >  {
> > -     struct cros_ec_device *ec_device;
> > -     struct charger_data *charger;
> > -     u32 host_event;
> > +     struct charger_data *charger = container_of(nb, struct charger_data,
> > +                                                 notifier);
> >
> > -     charger = container_of(nb, struct charger_data, notifier);
> > -     ec_device = charger->ec_device;
> > -
> > -     host_event = cros_ec_get_host_event(ec_device);
> > -     if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> > -             cros_usbpd_charger_power_changed(charger->ports[0]->psy);
> > -             return NOTIFY_OK;
> > -     } else {
> > -             return NOTIFY_DONE;
> > -     }
> > +     cros_usbpd_charger_power_changed(charger->ports[0]->psy);
> > +     return NOTIFY_OK;
> >  }
> >
> >  static void cros_usbpd_charger_unregister_notifier(void *data)
> >  {
> >       struct charger_data *charger = data;
> > -     struct cros_ec_device *ec_device = charger->ec_device;
> >
> > -     blocking_notifier_chain_unregister(&ec_device->event_notifier,
> > -                                        &charger->notifier);
> > +     cros_usbpd_unregister_notify(&charger->notifier);
> >  }
> >
> >  static int cros_usbpd_charger_probe(struct platform_device *pd)
> > @@ -683,21 +673,17 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
> >               goto fail;
> >       }
> >
> > -     if (ec_device->mkbp_event_supported) {
> > -             /* Get PD events from the EC */
> > -             charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
> > -             ret = blocking_notifier_chain_register(
> > -                                             &ec_device->event_notifier,
> > -                                             &charger->notifier);
> > -             if (ret < 0) {
> > -                     dev_warn(dev, "failed to register notifier\n");
> > -             } else {
> > -                     ret = devm_add_action_or_reset(dev,
> > -                                     cros_usbpd_charger_unregister_notifier,
> > -                                     charger);
> > -                     if (ret < 0)
> > -                             goto fail;
> > -             }
> > +     /* Get PD events from the EC */
> > +     charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
> > +     ret = cros_usbpd_register_notify(&charger->notifier);
> > +     if (ret < 0) {
> > +             dev_warn(dev, "failed to register notifier\n");
> > +     } else {
> > +             ret = devm_add_action_or_reset(dev,
> > +                             cros_usbpd_charger_unregister_notifier,
> > +                             charger);
> > +             if (ret < 0)
> > +                     goto fail;
> >       }
> >
> >       return 0;
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
