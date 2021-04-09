Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E63592EF
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 05:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhDIDSP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 23:18:15 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:61345 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhDIDSO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 23:18:14 -0400
X-Greylist: delayed 22695 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Apr 2021 23:18:12 EDT
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 1393HgZa023146;
        Fri, 9 Apr 2021 12:17:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 1393HgZa023146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617938262;
        bh=nRXeibRU4AcCoB24uvxQcso/vauounCB7Cy+XT2rzsI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VubqTYkRf4d5Up7TWCG9toaQseeku33piHD4ogq2gNSVmWkJd3z+EAeqSDxMrQuVc
         YxrmhZjriQ0JSqFRx/nQX781uIWMZ1vs6FIN9iJAwzgvaL7MaWBbO1MAnuFvIwfF27
         beESDMnlEEZKFDvqdPM2+L4x7c0Lja37o6yrvN9HJzQCvU0xi8mx7FhafayQs8lS/k
         UlvzLHOPkLDS+PO3jrCWMmL0O0Xn2K9z2Syov+7ts0Lp3W4SVoLurFETGoUZU4jjsO
         2VcWolwAGzP5qSxZ9cng7K3/r9Ymu5wxr7bZvwRIqnRhwAkCoiYryAuCYEeCc7r8n8
         y4G4Qki3Nxs/g==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id i4so2200152pjk.1;
        Thu, 08 Apr 2021 20:17:42 -0700 (PDT)
X-Gm-Message-State: AOAM531SobHQV1ZUx4ZRFE+Jn2qylXaNhDcaj2GAIm2PHF08YkvCHIay
        dfj75FAUtZIo+pP/ClUMTA140CAb5klLMEivim8=
X-Google-Smtp-Source: ABdhPJyKfwZlYOHfHkv5mwhrVgfiEf7eb7BzBT7fqlh6AUhG9PCC+r574MXFnfpu5GfVF+p/vrKZdmLmmtvfHp0+VFU=
X-Received: by 2002:a17:90a:1056:: with SMTP id y22mr11010180pjd.153.1617938261656;
 Thu, 08 Apr 2021 20:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210408205858.51751-1-masahiroy@kernel.org> <20210408205858.51751-3-masahiroy@kernel.org>
 <CAK8P3a3gzfZhNdp-_=HCxoMw385nGQeNOhhH8X+uyN=AMvHJ8Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3gzfZhNdp-_=HCxoMw385nGQeNOhhH8X+uyN=AMvHJ8Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Apr 2021 12:17:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR9+u5Q3Sf2jgBSUcpit6xbD_5_Hc-xr-9Ge_m_da-1CA@mail.gmail.com>
Message-ID: <CAK7LNAR9+u5Q3Sf2jgBSUcpit6xbD_5_Hc-xr-9Ge_m_da-1CA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pm: allow drivers to drop #ifdef and __maybe_unused
 from pm callbacks
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 9, 2021 at 6:30 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 8, 2021 at 11:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Drivers typically surround suspend and resume callbacks with #ifdef
> > CONFIG_PM(_SLEEP) or mark them as __maybe_unused in order to avoid
> > -Wunused-const-variable warnings.
> >
> > With this commit, drivers will be able to remove #ifdef CONFIG_PM(_SLEEP)
> > and __maybe_unsed because unused functions are dropped by the compiler
> > instead of the preprocessor.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> I tried this before and could not get it to work right.
>
> >
> > -#ifdef CONFIG_PM_SLEEP
> > +#define pm_ptr(_ptr)           PTR_IF(IS_ENABLED(CONFIG_PM), _ptr)
> > +#define pm_sleep_ptr(_ptr)     PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), _ptr)
> > +
> >  #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> > -       .suspend = suspend_fn, \
> > -       .resume = resume_fn, \
> > -       .freeze = suspend_fn, \
> > -       .thaw = resume_fn, \
> > -       .poweroff = suspend_fn, \
> > -       .restore = resume_fn,
> > -#else
> > -#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> > -#endif
> > +       .suspend  = pm_sleep_ptr(suspend_fn), \
> > +       .resume   = pm_sleep_ptr(resume_fn), \
> > +       .freeze   = pm_sleep_ptr(suspend_fn), \
> > +       .thaw     = pm_sleep_ptr(resume_fn), \
> > +       .poweroff = pm_sleep_ptr(suspend_fn), \
> > +       .restore  = pm_sleep_ptr(resume_fn),
>
> The problem that I think you inevitably hit is that you run into a missing
> declaration for any driver that still uses an #ifdef around a static
> function.
>
> The only way I can see us doing this is to create a new set of
> macros that behave like the version you propose here but leave
> the old macros in place until the last such #ifdef has been removed.
>
>        Arnd

Agh, you are right.
We cannot change all the callsites atomically due to the huge amount of users.

-- 
Best Regards
Masahiro Yamada
