Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D620172EEA
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 03:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgB1Cyx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 21:54:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39900 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgB1Cyx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 21:54:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id r16so1470247oie.6
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 18:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bD6p8dcTtfdHzz0f6asxLTnkbd00ssfd980H/08fj1I=;
        b=Hbm1HsNBIKexuD+XezDLN0SZgA6Z3LEpl/wpBG6jQ1++y1adMfpQFoenYs9y0uZ2iF
         7tJxDr91/k6G5gcB726MxjYDJtgSJjIDXta8OcVzoFPY8H4GhqLN4YnrAi72EIII6qGA
         8uRG/lYkyoBUdybV5Swb5ngu/jk7PJDylIINQ9V3Cmn3htVVZRj9A7XXgzbUD4NtM0b3
         Lsvl2Tm/oSyVjBG0QRgkkAHSAn6DIU1v2VdiIOR5o0m9FEsxNcxTwIwZWHja4dIdvt6J
         nT5cEh7NbF48TLzQOY/YMsGsj5rNjdl3yExZcy9KbBpCJJzJ2xc226TNoGtQryuQeneh
         pWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bD6p8dcTtfdHzz0f6asxLTnkbd00ssfd980H/08fj1I=;
        b=YXLkr9g/r6qJnvqTVe1ANxfSgHC+DzAPYpwuywi8ldNT1qITpL/pQ5zCsfDeBQX2pl
         6ZnzmWf5LJueoDCoQxnIBufWOKcjcwxiZIXWv5n8cDG8N5iTR95B+T6oU6siRvyIdF+B
         GKui/tG8IAelL0oAzffiqdqRNovMZ/YChhTeuQPhgFcVN3kSmhmvXJToMGNrrpMjYiBX
         Bt6YxAJetrNhtkoDcwFsjTrImLtvWXuUVLJu/lWoNDJT1L37GvFW1zB4nmwoBRBdJiFE
         W3+afSW+VwfrqvFt4pxkjPoaQEAwcdbj2cGlu4d7O2diXPLB+y/oPcYCz+P9V0vYUGfp
         Abpw==
X-Gm-Message-State: APjAAAVEL99VR6uIvF+/qeqnSy4vQoG76OCIMBiX3Bhza+LRKSYTL3VW
        6rHwVdhusrU8oup9M5F5PZl7BNWy5QfK4i5xcVR/2XR7
X-Google-Smtp-Source: APXvYqzOtdLo3Cz5Al5jNuz4CA/Vj66hkyNZWzckFomzU+qBVXRWd3RkhCNDInK7JBeNq1nVKZX8OuVvEPp3TRluSfU=
X-Received: by 2002:aca:4789:: with SMTP id u131mr1537159oia.43.1582858492144;
 Thu, 27 Feb 2020 18:54:52 -0800 (PST)
MIME-Version: 1.0
References: <2d0854b00d7f85e988aff4f8186e8ac5d8a9aff2.1581410798.git.baolin.wang7@gmail.com>
 <CA+H2tpFAZuPSH0EErLt0Lj=TKLVq3XwEox06tbGzFaquSpKa0w@mail.gmail.com>
In-Reply-To: <CA+H2tpFAZuPSH0EErLt0Lj=TKLVq3XwEox06tbGzFaquSpKa0w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 27 Feb 2020 18:54:16 -0800
Message-ID: <CAGETcx9695=uVkSmtym36t6jbFXcEGf2JPVqWBi+sLZNG4xzSg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: Allow charger manager can be built as a module
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, sre@kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 27, 2020 at 8:06 AM Orson Zhai <orsonzhai@gmail.com> wrote:
>
> Hi Sebastian and other guys here,
>
> On Tue, Feb 11, 2020 at 4:51 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Allow charger manager can be built as a module like other charger
> > drivers.
> >
> What do you think about this patch?
> We want to set charger-manager as module in our project for new Android devices.
>
> -Orson
>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> >  drivers/power/supply/Kconfig          |    2 +-
> >  include/linux/power/charger-manager.h |    7 +------
> >  2 files changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index 9a5591a..195bc04 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -480,7 +480,7 @@ config CHARGER_GPIO
> >           called gpio-charger.
> >
> >  config CHARGER_MANAGER
> > -       bool "Battery charger manager for multiple chargers"
> > +       tristate "Battery charger manager for multiple chargers"
> >         depends on REGULATOR
> >         select EXTCON
> >         help
> > diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
> > index ad19e68..40493b2 100644
> > --- a/include/linux/power/charger-manager.h
> > +++ b/include/linux/power/charger-manager.h
> > @@ -248,11 +248,6 @@ struct charger_manager {
> >         u64 charging_end_time;
> >  };
> >
> > -#ifdef CONFIG_CHARGER_MANAGER
> >  extern void cm_notify_event(struct power_supply *psy,
> > -                               enum cm_event_types type, char *msg);
> > -#else
> > -static inline void cm_notify_event(struct power_supply *psy,
> > -                               enum cm_event_types type, char *msg) { }
> > -#endif
> > +                           enum cm_event_types type, char *msg);
> >  #endif /* _CHARGER_MANAGER_H */

You are breaking the kernel if CONFIG_CHARGER_MANAGER is disabled. Why
not simple change the #ifdef to
#if IS_ENABLED(CONFIG_CHARGER_MANAGER)
?

-Saravana
