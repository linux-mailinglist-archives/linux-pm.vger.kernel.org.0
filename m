Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C46173085
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 06:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgB1Fhr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 00:37:47 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34014 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1Fhr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 00:37:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id l16so1240025qtq.1;
        Thu, 27 Feb 2020 21:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76wpTcV+LXA0Dyl54UG5BsW53npVN0WBYlbvd10TsrE=;
        b=m56oWDYKo8U2gzUmdVaIuVwDYDH1S0NbqGtJxGC0Xrn3fn8ho6S2oL8qWWNALQetIM
         uqyo2M47TbrDiO+VFYm0ulOAWEtDn6vNNAQ/dHu/Pw9kmLOaLNwn5cG7/3/MtIbEWSpW
         fVOCJOfwASE1gDGQiNLoalDMAbVrBVP43vXFDA5HYIAGLGu8nOFC7hYBOFRBpFTrYxNI
         ASliIuBzEzmhrIlS2na9tmr3QySr4JHhi8FXJ0AZqXNaVvcV2pYGSOmL7FiUo4juyd7S
         Xy618Hsae7VRaQM6S7ic4uZ2OR6/GK64ON0zaxKjREicZeUC4vC798EXPyHMcLVnbmJJ
         KqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76wpTcV+LXA0Dyl54UG5BsW53npVN0WBYlbvd10TsrE=;
        b=tiSSsifFNhCPKQ+4K3u9cz9sD8b04Mw2dQVnmrtEUzOMvy+eSoXM8o/JMF6T8F+T6Y
         ZajEY2/wrtlqgOQpmyBdpHoNs+xr0OruB7Cj3EsUiYlQsKpdTUbysBqs0NmaFtAJJI3V
         +66uXbXjguUy/cXZGxzRg8ZplT7oare7oeDfYnt4/t7N3wQ7IeTqLCtGj+46279a6e+/
         IUrqhLw6ShrJyEBg+XQClNr8CJKh2IkRXIvkto97bDVFfBtaZYBEoeD9O/I7q5P1d2S5
         ZAkJYsSqKdznKFe1PvI1Qo9dT+OFkJV1xmsUGy9ChhbZgOR5YKYbqKXkpTAcI23fHzFV
         Qacw==
X-Gm-Message-State: APjAAAW0WeMELilQxt5sUDtOQVHlbhK0+dOkcxwyGoq12kJYMiJLdC9X
        YXmbYUpr2XPzcRCD8YbWFIwlJc3iWWuGJYQLYFQ=
X-Google-Smtp-Source: APXvYqzdZ5n6FJrj5vA0szsVSQuMvUkyI8pNtv9isE32QqsWjw84Uy4YqANwFZmeFvuz0Yaz0msbBkkFnCPM66TEqVw=
X-Received: by 2002:aed:2202:: with SMTP id n2mr3003286qtc.4.1582868266510;
 Thu, 27 Feb 2020 21:37:46 -0800 (PST)
MIME-Version: 1.0
References: <2d0854b00d7f85e988aff4f8186e8ac5d8a9aff2.1581410798.git.baolin.wang7@gmail.com>
 <CA+H2tpFAZuPSH0EErLt0Lj=TKLVq3XwEox06tbGzFaquSpKa0w@mail.gmail.com> <CAGETcx9695=uVkSmtym36t6jbFXcEGf2JPVqWBi+sLZNG4xzSg@mail.gmail.com>
In-Reply-To: <CAGETcx9695=uVkSmtym36t6jbFXcEGf2JPVqWBi+sLZNG4xzSg@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 28 Feb 2020 13:37:34 +0800
Message-ID: <CADBw62oMztoidXGuv3YZ1Na9ouRAHfvuHc2yP30BccPh22443w@mail.gmail.com>
Subject: Re: [PATCH] power: supply: Allow charger manager can be built as a module
To:     Saravana Kannan <saravanak@google.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>, sre@kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 28, 2020 at 10:54 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Feb 27, 2020 at 8:06 AM Orson Zhai <orsonzhai@gmail.com> wrote:
> >
> > Hi Sebastian and other guys here,
> >
> > On Tue, Feb 11, 2020 at 4:51 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > Allow charger manager can be built as a module like other charger
> > > drivers.
> > >
> > What do you think about this patch?
> > We want to set charger-manager as module in our project for new Android devices.
> >
> > -Orson
> >
> > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > ---
> > >  drivers/power/supply/Kconfig          |    2 +-
> > >  include/linux/power/charger-manager.h |    7 +------
> > >  2 files changed, 2 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > > index 9a5591a..195bc04 100644
> > > --- a/drivers/power/supply/Kconfig
> > > +++ b/drivers/power/supply/Kconfig
> > > @@ -480,7 +480,7 @@ config CHARGER_GPIO
> > >           called gpio-charger.
> > >
> > >  config CHARGER_MANAGER
> > > -       bool "Battery charger manager for multiple chargers"
> > > +       tristate "Battery charger manager for multiple chargers"
> > >         depends on REGULATOR
> > >         select EXTCON
> > >         help
> > > diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
> > > index ad19e68..40493b2 100644
> > > --- a/include/linux/power/charger-manager.h
> > > +++ b/include/linux/power/charger-manager.h
> > > @@ -248,11 +248,6 @@ struct charger_manager {
> > >         u64 charging_end_time;
> > >  };
> > >
> > > -#ifdef CONFIG_CHARGER_MANAGER
> > >  extern void cm_notify_event(struct power_supply *psy,
> > > -                               enum cm_event_types type, char *msg);
> > > -#else
> > > -static inline void cm_notify_event(struct power_supply *psy,
> > > -                               enum cm_event_types type, char *msg) { }
> > > -#endif
> > > +                           enum cm_event_types type, char *msg);
> > >  #endif /* _CHARGER_MANAGER_H */
>
> You are breaking the kernel if CONFIG_CHARGER_MANAGER is disabled. Why

No, now no users in mainline have called cm_notify_event() function,
and if some charger drivers want to use the charger manager, they
should select CHARGER_MANAGER, like:
config CHARGER_SC2731
        tristate "Spreadtrum SC2731 charger driver"
        depends on MFD_SC27XX_PMIC || COMPILE_TEST
        select CHARGER_MANAGER

> not simple change the #ifdef to
> #if IS_ENABLED(CONFIG_CHARGER_MANAGER)
> ?

Yes, this also can work, and either way is okay for me. Sebastian,
what do you prefer? Thanks.
