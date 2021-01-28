Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5793073AA
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 11:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhA1KYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 05:24:49 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42960 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhA1KYC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 05:24:02 -0500
Received: by mail-ot1-f48.google.com with SMTP id f6so4661706ots.9;
        Thu, 28 Jan 2021 02:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gmohf92thXCgnWNXBIkteP5MCZIewZGUS0ihSmdrono=;
        b=Lx1h/7KJdOhtRKDsXT8IpfRsREpCGJ30jtR9gVh2L4x4KIW5qYhsP5ytfREUEkKvOV
         yfQIaFvCFao/B5TME2HYKZ3M2O+6uP1a1RUoDz1wr6Wrrphxs0grrMEMftRK4vB7R5Jd
         VUfvLu8KwQ5E/RiMGadrWEqVA4SamJDYPV8sL7zR88xGk6etZZffdX8/qJmaar/nldrJ
         xlYPRTFjyX/QGGT7iBWHrCFc16fNoQZRMVgyDgUSdbP09lT/wcJQIaFgIrPjVaWbHm1l
         XIRR6Psb1+ME8q/eguu+mIyvGgg7DXq5n9hbnekX734kZy9kbWW84I2bT3oVgJsol1pJ
         4YBQ==
X-Gm-Message-State: AOAM530IPxAxuNTQiDUVKlwWPoAnbIZk/bRXQuKXOxxaJ8Yz5l9iwqzz
        t/N405oz6NNonaldyVCck1BK4P9GXB3AYBLPg0A=
X-Google-Smtp-Source: ABdhPJz2JsbM785dSppFtayfF32mQBJFoGoCgyX1owdBPGhH3NaBveB7k1HEjJct57Cr5r01VRmzQdtIkYeeztyXMgo=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr11170677otm.206.1611829401499;
 Thu, 28 Jan 2021 02:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20201231060319.137133-1-kai.heng.feng@canonical.com> <s5h7dnxxz1k.wl-tiwai@suse.de>
In-Reply-To: <s5h7dnxxz1k.wl-tiwai@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Jan 2021 11:23:08 +0100
Message-ID: <CAJZ5v0jeZea4gHN0EJWfbZr4rdXvsc1KuYBQm5XmLhLvWZgM6g@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: core: Resume suspended device if
 direct-complete is disabled
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Kenneth R. Crudup" <kenny@panix.com>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 28, 2021 at 9:11 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 31 Dec 2020 07:03:19 +0100,
> Kai-Heng Feng wrote:
> >
> > HDA controller can't be runtime-suspended after commit 215a22ed31a1
> > ("ALSA: hda: Refactor codjc PM to use direct-complete optimization"),
> > which enables direct-complete for HDA codec.
> >
> > The HDA codec driver doesn't expect direct-complete will be disabled
> > after it returns a positive value from prepare() callback. So freeze()
> > is called directly when it's runtime-suspended, breaks the balance of
> > its internal codec_powered counting.
> >
> > So if a device is prepared for direct-complete but PM core breaks the
> > assumption, resume the device to keep PM operations balanced.
> >
> > Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Kai-Heng, is this fix still needed for 5.11?
>
> The description mentions about HD-audio controller, while the recent
> revert was the HD-audio codec, so I suppose it's still affected?

Regardless, this is not the right fix, because it doesn't take driver
flags into account AFAICS.

> > ---
> >  drivers/base/power/main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 46793276598d..9c0e25a92ad0 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1849,6 +1849,10 @@ static int device_prepare(struct device *dev, pm_message_t state)
> >               (ret > 0 || dev->power.no_pm_callbacks) &&
> >               !dev_pm_test_driver_flags(dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> >       spin_unlock_irq(&dev->power.lock);
> > +
> > +     if (ret > 0 && !dev->power.direct_complete)
> > +             pm_runtime_resume(dev);
> > +
> >       return 0;
> >  }
> >
> > --
> > 2.29.2
> >
