Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F98272AEB
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIUQCd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 21 Sep 2020 12:02:33 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41111 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgIUQCd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 12:02:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id q21so12800567ota.8
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2020 09:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kp/e2M9JL4AVHHaxLuKUDgiDvKuz5GDLkg8ubpm9sn4=;
        b=przhbCIY66VLcfQ435lT0AA1/hHo9LqQu9CBe3Zk87XcVHreCHwL31P/gb4RaD/Zsx
         wz1DhxK+XN/7Lz9fFlXchYN9xWV18vqniutZumYjpRt+5i+cT1A/YN1Tew5c3wphVFZY
         GBvmJEJ2fLnWhCI0/qCSmYwSuHAZrX4zvKHalO25eKy//79aNc8rjmm+22WlG/oegQFU
         Up8vZl4HtOSeC9AkXyex2FYUtnF9KMySoYKOqbB/vWM+JUzU7BOUe6VaroDxmX4Mu7Rz
         f+TvUBMft8forcyDxZypt8p5DcO3tCWKKyernrDoUb3xipmICItj6ugSFwkQgWOTbGNF
         y7BQ==
X-Gm-Message-State: AOAM530zoIHT7cNxXWwmhVzccGflwkFZaY/ICjcQ8tKujjjxM26aXiVv
        oI45p1lcPWaVw9CBZcJ2VupqauojCvk93yNIfG8=
X-Google-Smtp-Source: ABdhPJxN5F5GOYnz5x4gmxoc/6QVUGSt8V4zL2giYuWnECypIqio65skrE/m5lfSgLT/9bNRlYhxRBytwA3bPYku/F0=
X-Received: by 2002:a05:6830:150a:: with SMTP id k10mr114472otp.167.1600704152212;
 Mon, 21 Sep 2020 09:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <1596088129-88814-1-git-send-email-chenxiang66@hisilicon.com> <28bc46a7-7140-cc80-43a5-c1de8adfd81f@hisilicon.com>
In-Reply-To: <28bc46a7-7140-cc80-43a5-c1de8adfd81f@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 18:02:20 +0200
Message-ID: <CAJZ5v0hkUqBLw-PjTeP2nSxF1+knTUoFevv3hPQL=6x1t5BcoA@mail.gmail.com>
Subject: Re: [RFC PATCH] PM:runtime:Remove the link state check in function rpm_get_supplier()
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 21, 2020 at 9:12 AM chenxiang (M) <chenxiang66@hisilicon.com> wrote:
>
>
>
> 在 2020/7/30 13:48, chenxiang 写道:
> > From: Xiang Chen <chenxiang66@hisilicon.com>
> >
> > To support runtime PM for hisi SAS driver (the dirver is in directory
> > drivers/scsi/hisi_sas), we add device link between scsi_device->sdev_gendev
> > (consumer device) and hisi_hba->dev(supplier device) with flags
> > DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE.
> > After runtime suspended consumers and supplier, unload the dirver which
> > cause a hung. We find that it calls function device_release_driver_internal()
> > to release supplier device hisi_hba->dev, as the device link is busy,
> > it sets the device link as DL_STATE_SUPPLIER_UNBIND, and then call function
> > device_release_driver_internal() to release consumer device
> > scsi_device->sdev_gendev). Then It will try to call pm_runtime_get_sync()
> > to resume consumer device, as consumer-supplier relation exists, it will try
> > to resume supplier first, but as the link state is already set as
> > DL_STATE_SUPPLIER_UNBIND, so it skips resuming supplier and only resume
> > consumer which cause a hung (it sends IOs to resume scsi_device while
> > SAS controller is suspended). Simple flow is as follows:
> >
> > device_release_driver_internal -> (supplier device)
> >      if device_links_busy ->
> >           device_links_unbind_consumers ->
> >               ...
> >               WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND)
> >               device_release_driver_internal (consumer device)
> >      pm_runtime_get_sync -> (consumer device)
> >       ...
> >       __rpm_callback ->
> >           rpm_get_suppliers ->
> >               if link->state == DL_STATE_SUPPLIER_UNBIND -> skip the action of resuming the supplier
> >               ...
> >      pm_runtime_clean_up_links
> >      ...
>
> Hi Rafael, do you have any idea about this issue?
>
> > It should guarantee correct suspend/resume ordering between a supplier
> > device and its consumer devices (resume the supplier device before resuming
> > consumer devices, and suspend consumer devices before suspending supplier
> > device) for runtime PM, but it seems the check in rpm_get_supplier() breaks
> > the rule, so remove it.
> >
> > Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> > ---
> >   drivers/base/power/runtime.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 9f62790..a8edd92 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -291,8 +291,7 @@ static int rpm_get_suppliers(struct device *dev)
> >                               device_links_read_lock_held()) {
> >               int retval;
> >
> > -             if (!(link->flags & DL_FLAG_PM_RUNTIME) ||
> > -                 READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
> > +             if (!(link->flags & DL_FLAG_PM_RUNTIME))

AFAICS you need to make the analogous change in rpm_put_suppliers(),
but apart from this it should be fine.

Thanks!

> >                       continue;
> >
> >               retval = pm_runtime_get_sync(link->supplier);
>
>
