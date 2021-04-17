Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F1D362EA1
	for <lists+linux-pm@lfdr.de>; Sat, 17 Apr 2021 10:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhDQIuH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Apr 2021 04:50:07 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:46723 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbhDQIuH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Apr 2021 04:50:07 -0400
Received: by mail-lj1-f171.google.com with SMTP id u20so33592211lja.13;
        Sat, 17 Apr 2021 01:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=9Q8i358kUoVCgVrcMHeBfy2VnHJ+AKT+L+dEpF7HrO0=;
        b=LE+Do5dr5+IwHWkfDjY5TdL/bYDeuYaC2ie3WJiyaFhdIFod/WLgUcicr25mDxCaim
         XixpjrtYhp3uU1yzELV/YFMIP6Qw/FooXWNGb3sXT3uRSl1pljKKOFkHRMtgDW46nXgd
         qSniydgG3Vt4YGxe/sy6NT3mZ3o2dggiF2f17Z+3ds0lNNE2Nig4Q42KQ5ltiZ5YJe8c
         hk30LPCFdxpPfs+9XylEGSztDJeYghVCXDBiwNdTFH/pisdeRc38m5jZxHoudeopya3P
         /X1tO2zDSSlk225tEhc0wz9HN6HZNxwt1Z/RiHZApLBw5gBOhUmGicArPnSy0GSujRoN
         roxw==
X-Gm-Message-State: AOAM53046QNl4ugNX6fs0P6Iw8fHUZ5lqT0GhkHA8oKw7qaRxfYYONqX
        BARzZpU1nMzYu7tseBcO5EQO1JCktIav1Q==
X-Google-Smtp-Source: ABdhPJxwyxi+pbhWVb+mB84S0MDuc/MbX60vLFRp3xgZ5N8SXQ8hv5/O6s1Z66VXMYZ6Y4JMpcdJjA==
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr1478809lje.445.1618649378453;
        Sat, 17 Apr 2021 01:49:38 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id l18sm1171756ljj.55.2021.04.17.01.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 01:49:37 -0700 (PDT)
Message-ID: <1aac32e16906c4e7def072698d9d3b32d8e32ca5.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v7 2/9] reboot: thermal: Export hardware protection
 shutdown
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pm@vger.kernel.org
In-Reply-To: <ce0918d9-bedb-e48f-5779-c0ef47c6909d@linaro.org>
References: <cover.1618377272.git.matti.vaittinen@fi.rohmeurope.com>
         <adf417797006c996605a03c8bacfb4961e8f0b42.1618377272.git.matti.vaittinen@fi.rohmeurope.com>
         <ce0918d9-bedb-e48f-5779-c0ef47c6909d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Sat, 17 Apr 2021 11:49:32 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Thank you for the review. Much appreciated!

On Sat, 2021-04-17 at 07:32 +0200, Daniel Lezcano wrote:
> On 14/04/2021 07:52, Matti Vaittinen wrote:
> > Thermal core contains a logic for safety shutdown. System is
> > attempted to
> > be powered off if temperature exceeds safety limits.
> > 
> > Currently this can be also utilized by regulator subsystem as a
> > final
> > protection measure if PMICs report dangerous over-voltage, over-
> > current or
> > over-temperature and if per regulator counter measures fail or do
> > not
> > exist.
> > 
> > Move this logic to kernel/reboot.c and export the functionality for
> > other
> > subsystems to use. Also replace the mutex with a spinlock to allow
> > using
> > the function from any context.
> > 
> > Also the EMIF bus code has implemented a safety shut-down. EMIF
> > does not
> > attempt orderly_poweroff at all. Thus the EMIF code is not
> > converted to use
> > this new function.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> > Changelog
> >  v7:
> >   - new patch
> > 
> > Please note - this patch has received only a minimal amount of
> > testing.
> > (The new API call was tested to shut-down my system at driver probe
> > but
> > no odd corner-cases have been tested).
> > 
> > Any testing for thermal shutdown is appreciated.
> > ---
> >  drivers/thermal/thermal_core.c | 63 ++-----------------------
> >  include/linux/reboot.h         |  1 +
> >  kernel/reboot.c                | 86
> > ++++++++++++++++++++++++++++++++++
> 
> Please send a patch implementing the reboot/shutdown and then another
> one replacing the thermal shutdown code by a call to the new API.

I guess your suggestion makes sense. That way if the change causes any
problems in thermal-core it can be reverted without impacting other
potential users of this API. My original thinking was that this was
more of an move of functionality than adding an API. Having the move as
one patch makes sense as it shows where the code came from.

> 
> >  3 files changed, 91 insertions(+), 59 deletions(-)
> > 
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c
> > index 996c038f83a4..b1444845af38 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -36,10 +36,8 @@ static LIST_HEAD(thermal_governor_list);
> >  
> > 

...

> > +static bool prot_power_off_triggered;
> > +static DEFINE_SPINLOCK(poweroff_lock);
> > +
> > +/**
> > + * hw_protection_shutdown - Trigger an emergency system poweroff
> > + *
> > + * @reason:		Reason of emergency shutdown to be
> > printed.
> > + * @ms_until_forced:	Time to wait for orderly shutdown
> > before tiggering a
> > + *			forced shudown. Negative value disables the
> > forced
> > + *			shutdown.
> > + *
> > + * Initiate an emergency system shutdown in order to protect
> > hardware from
> > + * further damage. Usage examples include a thermal protection or
> > a voltage or
> > + * current regulator failures.
> > + * NOTE: The request is ignored if protection shutdown is already
> > pending even
> > + * if the previous request has given a large timeout for forced
> > shutdown.
> > + * Can be called from any context.
> > + */
> > +void hw_protection_shutdown(const char *reason, int
> > ms_until_forced)
> > +{
> > +	unsigned long flags;
> > +
> > +	pr_emerg("HARDWARE PROTECTION shutdown (%s)\n", reason);
> > +
> > +	spin_lock_irqsave(&poweroff_lock, flags);
> > +	if (prot_power_off_triggered) {
> > +		spin_unlock(&poweroff_lock);
> 
> Why not spin_unlock_irqrestore() ?
> 

Well spotted It for sure must be spin_unlock_irqrestore. My bad.

> > +		return;
> > +	}
> > +	prot_power_off_triggered = true;
> > +	spin_unlock_irqrestore(&poweroff_lock, flags);
> 
> Why not take the spin_lock definitively for all the procedure ?
> 
> eg.
> 
> {
> 	...
> 
> 	pr_emerg( ... );
> 
> 	if (spin_trylock(&lock))
> 		return;
> 
> 	hw_failure_emergency_poweroff(ms_until_forced);
> 
> 	orderly_poweroff(true);
> }
> 
> No need of prot_power_off_triggered and the spin_lock can be declared
> static inside the function.

I think this makes perfect sense. My thinking just jammed to replacing
the mutex thermal-core used with a spin-lock using similar logic. I
guess this could even be just an atomic cmpxchg (or equivalent, I don't
remember what atomic abstractions we have) just to return if function
has been previously executed. Well, the spin_trylock() should work just
fine as far as I can say. So - thanks.


Best Regards
	Matti Vaittinen

