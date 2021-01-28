Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCAE30710A
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 09:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhA1IQL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 03:16:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60800 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhA1IQJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 03:16:09 -0500
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l52Sb-0001ir-Ph
        for linux-pm@vger.kernel.org; Thu, 28 Jan 2021 08:15:25 +0000
Received: by mail-lj1-f199.google.com with SMTP id z8so2680882lji.8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 00:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npBoJHUyDIoP0AaWV09xjto53fPPvArZmQZUhrzQfTU=;
        b=FLLS/wYnVIYXk0G7mNb/Bfmtv8qJgkQ4jdFuMl84aJlKOm/kzjynWoUEzt1enJpiy5
         k5PQBU3r7pCTKnJ/95UsmSs+FrqrDnvecHiLFjys3+JMtxLmBc8fLFNEJY9C8aB8sW93
         2z0STDQDll18/zNAEYiq7njERtfl4HaTQCtKvuGcTnh5pyDLqodHZW17jMcNGg5zrfvt
         MCwmRLKbW3sWal36A/VReCsVG4WX4jOoyfwgVULx1l/d+wAowAB2cJ2O/mxfavoKDO78
         ZEUXwNIHE6kAacVPwZCwkCQzb9/gREidb4bDNjWHZIKnQE+oK4cdqWjgfjjJYbzksJD0
         56wQ==
X-Gm-Message-State: AOAM5339g/ft3Yz62S9+/7idNrILsC6SA6qugvAU5sFYG/B3R3em65Tk
        +v+BVY2tMZP3UscDeEWZ9eFrN0+jqX1eTJKZd9qvsGutgbXAZoHOKyyZa9tn8G3Md/lxfLAjP1O
        yaRJt5RfUr0H5iaPDVTNcsujTL/bELGUMUBlKE9g7bIEtn76wLme5
X-Received: by 2002:a19:f707:: with SMTP id z7mr7251300lfe.548.1611821725183;
        Thu, 28 Jan 2021 00:15:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxG8Unj0A2eJCeR8bdkKl/6pdbf0Ax5vlnwUIKbwTqTCYuV4HsVt6BthHRuTKx/chfYIONg0Hb5M2/nOAx4Jj0=
X-Received: by 2002:a19:f707:: with SMTP id z7mr7251289lfe.548.1611821724911;
 Thu, 28 Jan 2021 00:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20201231060319.137133-1-kai.heng.feng@canonical.com> <s5h7dnxxz1k.wl-tiwai@suse.de>
In-Reply-To: <s5h7dnxxz1k.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 28 Jan 2021 16:15:10 +0800
Message-ID: <CAAd53p5cg=ye5DnXAhb89HoUyJG6ecx3-OQp4ntgFumQWSnxQA@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: core: Resume suspended device if
 direct-complete is disabled
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 28, 2021 at 4:09 PM Takashi Iwai <tiwai@suse.de> wrote:
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

No it's not needed anymore because "ALSA: hda: Balance runtime/system
PM if direct-complete is disabled" is in place.

>
> The description mentions about HD-audio controller, while the recent
> revert was the HD-audio codec, so I suppose it's still affected?

Not affected anymore if above mentioned patch is applied.

Kai-Heng

>
>
> thanks,
>
> Takashi
>
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
