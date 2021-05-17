Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E37382399
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 06:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhEQE6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 00:58:39 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:46894 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhEQE6j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 00:58:39 -0400
Received: by mail-lf1-f43.google.com with SMTP id i9so6759350lfe.13;
        Sun, 16 May 2021 21:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=ZlBxGhYLZ60uGDaPOSr/zz7izf5PGo7iYr82/TiNDOQ=;
        b=E+zP2LSMSbK65WxXy9THvknp5RylijQ7mfAxj5iwLuA63uOVbTCjdSsNakY2CFRo3w
         LOnsYBxw4rOJEBDxwkyHOhU8e3PhrV3jhAQEcg8v2PGCJA+bI6NQcBeUAvYHdZwsiiIo
         ORJg3fGAzaAf0EQH0cJAE4MsmWLVI3XlqFH9/Vm3w88MPoz9bY6vH1hSOZ4T73d46E4G
         3BBNsMlzByFJb+O4NTJFY4gVg/V6ycwj/H0goTNZrGlmbrLiGbRW1KEiuaHWyzl8boEj
         6uOrAtWE6cnAAJ2JZCYo4G4VycAS94EsWbjjBuqDdZlSHZkHwllHup3jUZ0QME1yOKNH
         FSSA==
X-Gm-Message-State: AOAM531qw2B2rIgSesCMiMuLiYHI9jX9yZ3DTIqvI5Gc66Tq2hiYlbOa
        /4/FE+fdz+l3t4Q5Ox08GS4=
X-Google-Smtp-Source: ABdhPJz6XlOoLFS1OExcL4aOBvUwCPGZFB6U6VqCJpuJZQYA/MBhFsa1h3+611hseFVm2x5fKxip8Q==
X-Received: by 2002:ac2:54ba:: with SMTP id w26mr41231726lfk.78.1621227440658;
        Sun, 16 May 2021 21:57:20 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id g28sm2775163ljn.134.2021.05.16.21.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 21:57:19 -0700 (PDT)
Message-ID: <fefd2daff66123d5a812ad41466095e56e699bf2.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v9 02/10] reboot: Add hardware protection power-off
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Petr Mladek <pmladek@suse.com>
Cc:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "mcroce@microsoft.com" <mcroce@microsoft.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        rostedt@goodmis.org, Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <YJzkq+NPW4ZMB8AF@alley>
References: <cover.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
         <97260f8e150abb898a262fade25860609b460912.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
         <YJuPwAZroVZ/w633@alley>
         <2149df3f542d25ce15d049e81d6188bb7198478c.camel@fi.rohmeurope.com>
         <YJzkq+NPW4ZMB8AF@alley>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Mon, 17 May 2021 07:57:11 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 2021-05-13 at 10:34 +0200, Petr Mladek wrote:
> On Wed 2021-05-12 12:00:46, Vaittinen, Matti wrote:
> > On Wed, 2021-05-12 at 10:20 +0200, Petr Mladek wrote:
> > > On Mon 2021-05-10 14:28:30, Matti Vaittinen wrote:
> > > > There can be few cases when we need to shut-down the system in
> > > > order to
> > > > protect the hardware. Currently this is done at east by the
> > > > thermal
> > > > core
> > > > when temperature raises over certain limit.
> > > > 
> > > > Some PMICs can also generate interrupts for example for over-
> > > > current or
> > > > over-voltage, voltage drops, short-circuit, ... etc. On some
> > > > systems
> > > > these are a sign of hardware failure and only thing to do is
> > > > try to
> > > > protect the rest of the hardware by shutting down the system.
> > > > 
> > > > Add shut-down logic which can be used by all subsystems instead
> > > > of
> > > > implementing the shutdown in each subsystem. The logic is
> > > > stolen
> > > > from
> > > > thermal_core with difference of using atomic_t instead of a
> > > > mutex
> > > > in
> > > > order to allow calls directly from IRQ context.
> > > > 
> > > > Signed-off-by: Matti Vaittinen <
> > > > matti.vaittinen@fi.rohmeurope.com>
> > > > 
> > > > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > > > index a6ad5eb2fa73..5da8c80a2647 100644
> > > > --- a/kernel/reboot.c
> > > > +++ b/kernel/reboot.c
> > > > @@ -518,6 +519,85 @@ void orderly_reboot(void)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(orderly_reboot);
> > > >  
> > > > +/**
> > > > + * hw_failure_emergency_poweroff_func - emergency poweroff
> > > > work
> > > > after a known delay
> > > > + * @work: work_struct associated with the emergency poweroff
> > > > function
> > > > + *
> > > > + * This function is called in very critical situations to
> > > > force
> > > > + * a kernel poweroff after a configurable timeout value.
> > > > + */
> > > > +static void hw_failure_emergency_poweroff_func(struct
> > > > work_struct
> > > > *work)
> > > > +{
> > > > +	/*
> > > > +	 * We have reached here after the emergency shutdown
> > > > waiting
> > > > period has
> > > > +	 * expired. This means orderly_poweroff has not been
> > > > able to
> > > > shut off
> > > > +	 * the system for some reason.
> > > > +	 *
> > > > +	 * Try to shut down the system immediately using
> > > > kernel_power_off
> > > > +	 * if populated
> > > > +	 */
> > > > +	WARN(1, "Hardware protection timed-out. Trying forced
> > > > poweroff\n");
> > > > +	kernel_power_off();
> > > 
> > > WARN() look like an overkill here. It prints many lines that are
> > > not
> > > much useful in this case. The function is called from well-known
> > > context (workqueue worker).
> > 
> > This was the existing code which I stole from the thermal_core. I
> > kind
> > of think that eye-catching WARN is actually a good choice here.
> > Doing
> > autonomous power-off without a WARNing does not sound good to me :)
> > 
> > > Also be aware that "panic_on_warn" commandline option will
> > > trigger
> > > panic() here.
> > 
> > Hmm.. If panic() hangs the system that might indeed be a problem.
> > Now
> > we are (again) on a territory which I don't know well. I'd
> > appreciate
> > any input from thermal folks and Mark. I don't like the idea of
> > making
> > extreme things like power-off w/o well visible log-trace. Thus I
> > would
> > like to have WARN()-like eye-catcher, even if the call-trace was
> > not
> > too varying. It will at least point to this worker. Any better
> > suggestions than WARN()?
> 
> Heh, it might make sense to create a system wide API for these. I am
> sure that WARN() is mis-used this way on many other locations.
> 
> There already are two locations that use another eye-catching text.
> A common API might help to avoid duplication of the common parts,
> see
> https://lore.kernel.org/lkml/20210305194206.3165917-2-elver@google.com/
> 
> Well, it might be out of scope for this patchset.

I just had a very brief "chat" with Geert (3 IRC messages, posted
during 4 or 5 days :]) - and Geert pointed me to this:

https://lore.kernel.org/linux-iommu/20210331093104.383705-4-geert+renesas@glider.be/

So, maybe I'll just go with simple pr_emerg() and trust that the
emerg() print should catch attention as such level print probably
should. I'll respin the patch series (probably tomorrow) - let's see
what thermal and regulator folks say :)

Thanks for all the help this far!

Best Regards
	Matti Vaittinen

