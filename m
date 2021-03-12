Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DE8338F41
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhCLN6Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 08:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhCLN6I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 08:58:08 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4EC061574
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 05:58:08 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w11so33638iol.13
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 05:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfGNxFGx/GSqQ8J+prbrVB3YoseYYdcfdmqBB1ZWsf4=;
        b=KCVpgGaszvjmh10So7k3QGeTRqp7SjFil5pxA1T6Y6eWZaIKdoJYOOBL+T4IbWbkjo
         UCD6o0LrAm5I5CJE9wjyA1ccZrqCeRnIopcWV31HmV1bSv+vGjsEDQU1qeASKHWc7ZbD
         OMrENlRbdkMujDZ7uOHyjS/fAXQ/LbjN+Xt48kFu9tCuQunKi4OvE/2iFi4ft+TlDvRq
         YGhb6hFJ8Gymj8rPMAr+qCERnnOckCHtgJiU3h/F//8LymiX+vKW0OU6fFfolII5h8/s
         27yvKbWve/Ad7raTIzRyyY+k91G2HJolY4So7He/zevu5vm3N/HsLbiLvQyGBlGY0HsW
         p2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfGNxFGx/GSqQ8J+prbrVB3YoseYYdcfdmqBB1ZWsf4=;
        b=iLfWWxEKCpaXm7S/xstsRycgpDXYFlfFr/JDBjD8nykJxalIioJjR4VbhuEa9O431y
         DZ1j+s9QWXIX6Se1Q56gXW9vTFDNQGqNByHWqo5ZJUiiwUrLAkMirndT7CCAN4J03Htq
         aJ1MxaFvtITyOxp9F7OouG7M4yOxlBQA6sxLxgvd4K+P8nUfBrPrrQTVWSn1Fx8WnqJM
         WzBQjRWjLVwuAZ87bZZkrEIobq0A+45sBIYRPSRbeYdsOChVWWZmIs4P/dsWRKc4sXiA
         0EZ/x8cNR/Y1zlbiD28RvSAQwULcjNYOlhR2DoP5rN5IP5apfWwGaoXbii0I1EwvPfqq
         /fug==
X-Gm-Message-State: AOAM531sSfuWrTMGp8PU8gq6cnf5orPIDiclVWH8q9/HbSC24rVnZDsY
        zd5xOu7mNnjVREIjpX/3zhzfudcHDSvyCXv/pHtxEw==
X-Google-Smtp-Source: ABdhPJwKSJnXvI9/NG4m48LW0+vy+lK8zsv8TIliueMw8ZAxuGgekU1/vc+Rj3Qh3ZoQ7xO+ZF+8KpfOFY+a0mjoEwA=
X-Received: by 2002:a6b:ea04:: with SMTP id m4mr9913728ioc.160.1615557487699;
 Fri, 12 Mar 2021 05:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20210308133146.3168995-1-raychi@google.com> <20210309185807.ka4iljasq5cmpmil@earth.universe>
In-Reply-To: <20210309185807.ka4iljasq5cmpmil@earth.universe>
From:   Ray Chi <raychi@google.com>
Date:   Fri, 12 Mar 2021 21:57:56 +0800
Message-ID: <CAPBYUsCJ3ftC4ur412rFZGeeM_kDHrCh=BVci3=8SE2eFdPcQg@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: fix build error when POWER_SUPPLY is not enabled
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, naresh.kamboju@linaro.org,
        Kyle Tso <kyletso@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

Sorry for the late reply.

On Wed, Mar 10, 2021 at 2:58 AM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Mon, Mar 08, 2021 at 09:31:46PM +0800, Ray Chi wrote:
> > Fix build error when CONFIG_POWER_SUPPLY is not enabled.
> >
> > The build error occurs in mips (cavium_octeon_defconfig).
> >
> > mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_remove':
> > drivers/usb/dwc3/core.c:1657: undefined reference to `power_supply_put'
> > mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_get_properties':
> > drivers/usb/dwc3/core.c:1270: undefined reference to `power_supply_get_by_name'
> > mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_probe':
> > drivers/usb/dwc3/core.c:1632: undefined reference to `power_supply_put'
> >
> > Fixes: 59fa3def35de ("usb: dwc3: add a power supply for current control")
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Ray Chi <raychi@google.com>
> > ---
>
> While I'm fine with merging this after fixing up the subject, the
> original patch for dwc3 [0] looks completly incorrect to me.
>
> First of all it uses wrong scale (power-supply uses uA, not mA),
> so you are charging 1000x slower than expected. Then the patchset
> introduces a new DT property to get the power-supply device, but
> does not update the DT binding documentation and does not Cc the
> DT binding maintainer.

Yes, it should use uA and send this information, and I will update a
patch to fix it and add the DT binding documentation.

> Next the property itself looks not very
> smart to me. Usually one would use a device reference, not the
> Linux device name.
>
> Finally all existing devices solve this by registering a usb
> notifier from the charger, so why are you going the other way
> around? This is going to break once you want to use one of the
> existing chargers with dwc3.

Only the USB controller will know USB state/speed so that I think it is
better to send this information from the USB side.
For example:
For USB high speed, charging current should be limited to 500 mA in
configured state.
For USB super speed, charging current should be limited to 900 mA in
configured state.

>
> I suggest to drop/revert the whole patchset.
>
> [0] https://lore.kernel.org/linux-usb/20210222115149.3606776-1-raychi@google.com/
>
> -- Sebastian
>
> >  include/linux/power_supply.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 81a55e974feb..6e776be5bfa0 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -381,8 +381,14 @@ struct power_supply_battery_info {
> >  extern struct atomic_notifier_head power_supply_notifier;
> >  extern int power_supply_reg_notifier(struct notifier_block *nb);
> >  extern void power_supply_unreg_notifier(struct notifier_block *nb);
> > +#if IS_ENABLED(CONFIG_POWER_SUPPLY)
> >  extern struct power_supply *power_supply_get_by_name(const char *name);
> >  extern void power_supply_put(struct power_supply *psy);
> > +#else
> > +static inline void power_supply_put(struct power_supply *psy) {}
> > +static inline struct power_supply *power_supply_get_by_name(const char *name)
> > +{ return NULL; }
> > +#endif
> >  #ifdef CONFIG_OF
> >  extern struct power_supply *power_supply_get_by_phandle(struct device_node *np,
> >                                                       const char *property);
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >
