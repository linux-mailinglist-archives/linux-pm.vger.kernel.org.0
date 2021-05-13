Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC2937F432
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 10:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhEMIgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 04:36:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:39336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhEMIgD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 May 2021 04:36:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620894892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMbyojh6a77y/n4n2x5m5FSvtbZLYhRvkKdMCE0XqIo=;
        b=f6iDbhj56ru9OVo+GW8gX1a7hFo49kjc71l/SieGk8e/McEB2FQaWhtotl1rQHP0FsuzSZ
        peEKBaqtnxuV5XgmYts9dYJQ6slqQkQYduFsx0O6YRi04bZShvTWaNbjyAxKSW4Y23n82D
        35S4vaiboE50cwddR8FkRM/h57FbY/Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED2EEAD9F;
        Thu, 13 May 2021 08:34:51 +0000 (UTC)
Date:   Thu, 13 May 2021 10:34:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
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
Subject: Re: [PATCH v9 02/10] reboot: Add hardware protection power-off
Message-ID: <YJzkq+NPW4ZMB8AF@alley>
References: <cover.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
 <97260f8e150abb898a262fade25860609b460912.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
 <YJuPwAZroVZ/w633@alley>
 <2149df3f542d25ce15d049e81d6188bb7198478c.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2149df3f542d25ce15d049e81d6188bb7198478c.camel@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 2021-05-12 12:00:46, Vaittinen, Matti wrote:
> On Wed, 2021-05-12 at 10:20 +0200, Petr Mladek wrote:
> > On Mon 2021-05-10 14:28:30, Matti Vaittinen wrote:
> > > There can be few cases when we need to shut-down the system in
> > > order to
> > > protect the hardware. Currently this is done at east by the thermal
> > > core
> > > when temperature raises over certain limit.
> > > 
> > > Some PMICs can also generate interrupts for example for over-
> > > current or
> > > over-voltage, voltage drops, short-circuit, ... etc. On some
> > > systems
> > > these are a sign of hardware failure and only thing to do is try to
> > > protect the rest of the hardware by shutting down the system.
> > > 
> > > Add shut-down logic which can be used by all subsystems instead of
> > > implementing the shutdown in each subsystem. The logic is stolen
> > > from
> > > thermal_core with difference of using atomic_t instead of a mutex
> > > in
> > > order to allow calls directly from IRQ context.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > 
> > > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > > index a6ad5eb2fa73..5da8c80a2647 100644
> > > --- a/kernel/reboot.c
> > > +++ b/kernel/reboot.c
> > > @@ -518,6 +519,85 @@ void orderly_reboot(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(orderly_reboot);
> > >  
> > > +/**
> > > + * hw_failure_emergency_poweroff_func - emergency poweroff work
> > > after a known delay
> > > + * @work: work_struct associated with the emergency poweroff
> > > function
> > > + *
> > > + * This function is called in very critical situations to force
> > > + * a kernel poweroff after a configurable timeout value.
> > > + */
> > > +static void hw_failure_emergency_poweroff_func(struct work_struct
> > > *work)
> > > +{
> > > +	/*
> > > +	 * We have reached here after the emergency shutdown waiting
> > > period has
> > > +	 * expired. This means orderly_poweroff has not been able to
> > > shut off
> > > +	 * the system for some reason.
> > > +	 *
> > > +	 * Try to shut down the system immediately using
> > > kernel_power_off
> > > +	 * if populated
> > > +	 */
> > > +	WARN(1, "Hardware protection timed-out. Trying forced
> > > poweroff\n");
> > > +	kernel_power_off();
> > 
> > WARN() look like an overkill here. It prints many lines that are not
> > much useful in this case. The function is called from well-known
> > context (workqueue worker).
> 
> This was the existing code which I stole from the thermal_core. I kind
> of think that eye-catching WARN is actually a good choice here. Doing
> autonomous power-off without a WARNing does not sound good to me :)
> 
> > Also be aware that "panic_on_warn" commandline option will trigger
> > panic() here.
> 
> Hmm.. If panic() hangs the system that might indeed be a problem. Now
> we are (again) on a territory which I don't know well. I'd appreciate
> any input from thermal folks and Mark. I don't like the idea of making
> extreme things like power-off w/o well visible log-trace. Thus I would
> like to have WARN()-like eye-catcher, even if the call-trace was not
> too varying. It will at least point to this worker. Any better
> suggestions than WARN()?

Heh, it might make sense to create a system wide API for these. I am
sure that WARN() is mis-used this way on many other locations.

There already are two locations that use another eye-catching text.
A common API might help to avoid duplication of the common parts,
see
https://lore.kernel.org/lkml/20210305194206.3165917-2-elver@google.com/

Well, it might be out of scope for this patchset.

Best Regards,
Petr
