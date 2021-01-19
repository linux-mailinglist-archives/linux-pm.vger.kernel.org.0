Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35162FC230
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbhASVXf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbhASVXa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:23:30 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F99C061575
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 13:22:48 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id a1so9889439qvd.13
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 13:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=QoR15X76Wa8utojDFzghU0XUanvjdtOD0JtOJepg2zQ=;
        b=iPJY1moesz74BGlcRCZu6JplYli8oRPYxZQBKc+pWMMbglhVWCtRcav6p7QbWlmfum
         y9W2MoQitiRxq4vuw0hSckO056h6CHdVtyShAQ+wz+tlHDIjKqUAffiYs3CsV0+376MY
         i8hyuUkqVPwmKiEluATsxtURE48Sqj8WPxQSqwJZhULp4yCG1KlkbEwseTV8eWdQSal0
         yPhyyGwa1jxr7yCWBYKuryrDiBQ3BMIyUfykY6LKVg2m6kQdX/mCUhgPfYAb/XNq/IH6
         Xy529AmwgQW8E7Mrhw1tcFJgcBLgkfVWq+KicOk4/kvAkAggZFcFNAGg7mehzP4iYq/5
         z5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=QoR15X76Wa8utojDFzghU0XUanvjdtOD0JtOJepg2zQ=;
        b=uZrEt0Akd+Bf6y20ym+68zgJjoT26WyfBkDXKRme6e6d8JiLEQWB8Q3+5CK9syHD3E
         98N0mMfXZx0YNVAT25ZXv+FJ6mu23G0YLStYvZf1XizDU2p1Zy5i2tHQPA3k8hvG3Eso
         CLEfhLQSs+i9yy5OjRuQfr931aaFx6jRng8v/W7zZ+TQlil943DczkidR2fqCwvazuFl
         aqdiKg9z+7P0w0Jzft37fCFA9RDwIx3y2pAbR5IyQlLYrpQq2yBEBwP+RYj0Wdu7qZqY
         hUI9c0JQoIyXBvi8QtPKxrpupF21DVxWz5bZPL4OKKDXYDlslXcyc+wKLhaKwJ83lnSn
         ispA==
X-Gm-Message-State: AOAM5313aJ6angJVxC9tq9j19IT0n+yWs33n9chH28ahSgzrwmPs56eI
        JeRPIpp08Ozhl1YuA6FzxAFAOg==
X-Google-Smtp-Source: ABdhPJy7oZ+C+6qSYY0OzIqs85mSSUlDrZJnwr/XBhiMfYxFs6zMdfwcY0MyqSmEu4dZm/GSpAD4lQ==
X-Received: by 2002:ad4:4431:: with SMTP id e17mr6465871qvt.21.1611091367227;
        Tue, 19 Jan 2021 13:22:47 -0800 (PST)
Received: from xanadu.home (modemcable076.50-203-24.mc.videotron.ca. [24.203.50.76])
        by smtp.gmail.com with ESMTPSA id l38sm3459069qte.88.2021.01.19.13.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 13:22:46 -0800 (PST)
Date:   Tue, 19 Jan 2021 16:22:45 -0500 (EST)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM / clk: make PM clock layer compatible with clocks
 that must sleep
In-Reply-To: <CAMuHMdX8T+tO-sT_tgrgEi-D0z2ac7k4Atg13arHN5bA84HqTA@mail.gmail.com>
Message-ID: <s41o2qs1-49or-rnr4-s370-2444r1055@onlyvoer.pbz>
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz> <7him7sydd6.fsf@baylibre.com> <CAMuHMdX8T+tO-sT_tgrgEi-D0z2ac7k4Atg13arHN5bA84HqTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 19 Jan 2021, Geert Uytterhoeven wrote:

> Hi Kevin, Nicolas,
> 
> On Tue, Jan 19, 2021 at 7:45 PM Kevin Hilman <khilman@baylibre.com> wrote:
> > [ + Geert.. renesas SoCs are the primary user of PM clk ]
> 
> Thanks!
> 
> > Nicolas Pitre <npitre@baylibre.com> writes:
> > > The clock API splits its interface into sleepable ant atomic contexts:
> > >
> > > - clk_prepare/clk_unprepare for stuff that might sleep
> > >
> > > - clk_enable_clk_disable for anything that may be done in atomic context
> > >
> > > The code handling runtime PM for clocks only calls clk_disable() on
> > > suspend requests, and clk_enable on resume requests. This means that
> > > runtime PM with clock providers that only have the prepare/unprepare
> > > methods implemented is basically useless.
> > >
> > > Many clock implementations can't accommodate atomic contexts. This is
> > > often the case when communication with the clock happens through another
> > > subsystem like I2C or SCMI.
> > >
> > > Let's make the clock PM code useful with such clocks by safely invoking
> > > clk_prepare/clk_unprepare upon resume/suspend requests. Of course, when
> > > such clocks are registered with the PM layer then pm_runtime_irq_safe()
> > > can't be used, and neither pm_runtime_suspend() nor pm_runtime_resume()
> > > may be invoked in atomic context.
> > >
> > > For clocks that do implement the enable and disable methods then
> > > everything just works as before.
> > >
> > > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> 
> Thanks for your patch!
> 
> > > --- a/drivers/base/power/clock_ops.c
> > > +++ b/drivers/base/power/clock_ops.c
> 
> > > +/**
> > > + * pm_clk_op_lock - ensure exclusive access for performing clock operations.
> > > + * @psd: pm_subsys_data instance corresponding to the PM clock entry list
> > > + *    and clk_op_might_sleep count being used.
> > > + * @flags: stored irq flags.
> > > + * @fn: string for the caller function's name.
> > > + *
> > > + * This is used by pm_clk_suspend() and pm_clk_resume() to guard
> > > + * against concurrent modifications to the clock entry list and the
> > > + * clock_op_might_sleep count. If clock_op_might_sleep is != 0 then
> > > + * only the mutex can be locked and those functions can only be used in
> > > + * non atomic context. If clock_op_might_sleep == 0 then these functions
> > > + * may be used in any context and only the spinlock can be locked.
> > > + * Returns -EINVAL if called in atomic context when clock ops might sleep.
> > > + */
> > > +static int pm_clk_op_lock(struct pm_subsys_data *psd, unsigned long *flags,
> > > +                       const char *fn)
> > > +{
> > > +     bool atomic_context = in_atomic() || irqs_disabled();
> 
> Is this safe? Cfr.
> https://lore.kernel.org/dri-devel/20200914204209.256266093@linutronix.de/

I noticed this topic is a mess. This is why I'm not relying on 
in_atomic() alone as it turned out not to be sufficient in all cases 
during testing.

What's there now is safe at least in the context from which it is called 
i.e. the runtime pm core code. If not then hopefully the might_sleep() 
that follows will catch misuses.

It should be noted that we assume an atomic context by default. However, 
if you rely on clocks that must sleep then you must not invoke runtime 
pm facilities in atomic context from your driver in the first place. The 
atomic_context variable above is there only used further down as a 
validation check to catch programming mistakes and not an operational 
parameter.


Nicolas
