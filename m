Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F451227D23
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 12:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgGUKet (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 06:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgGUKes (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 06:34:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E48C061794;
        Tue, 21 Jul 2020 03:34:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so2378607wmb.0;
        Tue, 21 Jul 2020 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PR207KjqevVDyNeFnarAVrMh7guCycUdfg2gqQY0iTw=;
        b=grSCYZ9yfxXj1LTfpzEem6QVQiZA7XwJ9qI6PT6eA79VKuD74Dl7sgOOj3TEvMJlWF
         DucXWL/7R8sZjsaHBePjWD/IgJWTJemThanbNtKutbbEr9B/7LoMNYf0L8T8x6y1iZss
         kApA0a3L/NJ6A7aqrONOSTsvUc0Ss0uCgVlh+b5/p/qb5NI4Q85kT/PM0sQbWY3rMtXi
         SreisLyl9YadxHSXNDwvCMTUxgTfMBJUQyXEpLy68P5yoLlp7MPGIfn4CL+XcoWgnBCj
         OKOKdHnPFtEFrhrwwNx0VIlRNMrdDwBKsOthirQSNzJLdICjBR5z5pb12E8bhpDVqPBS
         XpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PR207KjqevVDyNeFnarAVrMh7guCycUdfg2gqQY0iTw=;
        b=ZWDVpH1s9iMz5yX7Ewl/QBqvkzZm1ZcSZeoCm7YNE0QGW3+DkdteqPsSCzdqXUOiAy
         Abj39xl+Fw96/QY4UccBjdLl9RdXT3Bv2BtBxrwkcN2uOuFtfiSj/YiH7dSgnm4ps8C5
         4ZGf6EfzC9bWQFm+Kf+kCeG8jiss7/SzgfyGO0nAu+J3Baw+QfeWOsYqEN8DoUzL7peK
         mqdSVUVYeOPmD8Gr9Mhsd1zj2eSeyW1Zp9sCkkMbk9AUxwuzf7m0ai70wsksyHNNKy1i
         3XLyJR68pi7Aj5aqr4el7eV1V76EvSGU8d5Os0GpRPkbMNqbN0VCkEZ2hLbtqQXoy6Na
         SYtw==
X-Gm-Message-State: AOAM532/KgMrRF+oP0wc51SEVGwPLjGV/TIZNmqxkfGV855jVGZvYYGh
        zmPfNj1sNFdbMiTMBhccKqQfabU4Znrh+1QeEIM=
X-Google-Smtp-Source: ABdhPJweggcxhMTjACf7jDYE4AzuHJqzfg26Cc0HUXoyVp0PlF/AqxyLVMLd7ow8vNLRCP3yKxc9VZzEM3QTSj6i+uk=
X-Received: by 2002:a7b:c921:: with SMTP id h1mr3210338wml.29.1595327687081;
 Tue, 21 Jul 2020 03:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595301250.git.huangqiwu@xiaomi.com> <b383d79629d0afca00838fcbaad4458e383d7262.1595301250.git.huangqiwu@xiaomi.com>
 <20200721082000.GD1655283@kroah.com> <CAPtXDt2CXYJNoqnu3r7+vV2BZzT3fMR_G1yOyu1v0dgS8EkjNg@mail.gmail.com>
 <20200721103241.GA1675802@kroah.com>
In-Reply-To: <20200721103241.GA1675802@kroah.com>
From:   ivan <yanziily@gmail.com>
Date:   Tue, 21 Jul 2020 18:34:35 +0800
Message-ID: <CAPtXDt04J10+cnG-U9e=W2Uq8XJNi13J7nr3xZFAgxRmVd0VWQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] power: supply: core: add wireless signal strength property
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 21, 2020 at 6:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 21, 2020 at 06:21:20PM +0800, ivan wrote:
> > On Tue, Jul 21, 2020 at 4:19 PM Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> > >
> > > On Tue, Jul 21, 2020 at 01:59:36PM +0800, Qiwu Huang wrote:
> > > > From: Qiwu Huang <huangqiwu@xiaomi.com>
> > > >
> > > > reports wireless signal strength.
> > > > The value show degree of coupling between tx and rx.
> > > >
> > > > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
> > > >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> > > >  include/linux/power_supply.h                |  1 +
> > > >  3 files changed, 12 insertions(+)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Document=
ation/ABI/testing/sysfs-class-power
> > > > index 03ab449fae8a..75ec7de2fe78 100644
> > > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > > @@ -757,3 +757,13 @@ Description:
> > > >                       13: ADAPTER_VOICE_BOX,
> > > >                       14: ADAPTER_PRIVATE_PD_50W.
> > > >
> > > > +What:                /sys/class/power_supply/<supply_name>/signal_=
strength
> > > > +Date:                Jul 2020
> > > > +Contact:     Fei Jiang <jiangfei1@xiaomi.com>
> > > > +Description:
> > > > +             In PING phase, RX transmits a signal strength packet =
as the first
> > >
> > > What does "PING phase" mean?
> >
> > The Qi Wireless Power Transfer System is published by the Wireless
> > Power Consortium.
> > The ping phase is the necessary stage for matching transmitter and
> > receiver. In this phase,
> > the Power Transmitter executes a Digital Ping, and listens for a
> > response. If the
> > Power Transmitter discovers a Power Receiver, the Power Transmitter
> > may extend the Digital Ping,
> > i.e. maintain the Power Signal at the level of the Digital Ping. This
> > causes the system to proceed to the
> > identification & configuration phase. If the Power Transmitter does
> > not extend the Digital Ping, the
> > system shall revert to the selection phase.
>
> Thanks for the description, so perhaps turning this response into the
> text in the description would be good?

OK=EF=BC=8C I will

>
> thanks,
>
> greg k-h



--=20
Thanks

Qiwu
