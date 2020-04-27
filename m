Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E651C1BA052
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 11:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgD0Jsp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 05:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726604AbgD0Jsp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 05:48:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84E9C0610D5
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 02:48:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so18802142wmj.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rvoonvuH1XZk7YgYas1FUIUOgK1WKMyamprodjp5yVo=;
        b=TU82lExp8hS5GpeuvSNNaMEUzvUQw1yKbwfQHuLeIjxyZouPYCgr+9DYKcwLBQGmTt
         tZC43KW3Kwmfpw6xWTTFkOogPt0EzfjP2JB3HvNn/Sj+s/+r0UUV4UHLu5IUN50mcC85
         pEC6zYrIBmfifzEv4CX6j4lZpevZhjNRcaJTjcWAtafx25ycyZqbcvFoTIIk38qZs06o
         GMnYNIOu2nODJlpQ2Fiyw5cN03XNhy5KnWWdkWutvDLXsr6fKsaskZIo3QP88ZmgTrWl
         iPvjTs1362KFsacIfkTMieQWrOZI6bmAh+9NUOFGRKbr+Py4BcP3xs8MfUDd3v0b6rdc
         dPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rvoonvuH1XZk7YgYas1FUIUOgK1WKMyamprodjp5yVo=;
        b=D2s3jE3t6rUIjEewciGkgBKFjxpHESNGdwdO37cWve/KcMgP/dz2hyFZvKskQ90fge
         9dycvB29D4oivS3rWGvApRcwgRjdQlSgMVqV8g2Yf/AAwUy0CECaPzDVPHdqMwX0T5gW
         V7lM3SAA4/9KWzwHP7fvuVAo+dO3pqtkpKjEDvIJ7BTjXnR7630hk57XkoRg0HCFkA+x
         78hvDXJWlfCuQIg82rUHQrL2xK+Fch7lhUCJIJ+5RB8LwLZtdEpMRW1B4DgHZBfbA1LQ
         v4pmvNnr0RTNlY5R/fc8wDwvipbHLn+WKpc8iuwkWCHyPQZVf4o39vjFNeynl59sg/th
         Py+g==
X-Gm-Message-State: AGi0PuaT8SYM7oo2ndkZ83VhqVhPaK5UzlH8mEtCol2gteCnS4rv0j/t
        tq5Smwby21uvLITk+Jr5QhI=
X-Google-Smtp-Source: APiQypIb9LUz9ar07dDqWHAuWF9kt/zVlUIyQ80xI5J5JoygiY4k8On/KPXxXAA4j4DxCnos84I0Rw==
X-Received: by 2002:a1c:6402:: with SMTP id y2mr25839220wmb.116.1587980923446;
        Mon, 27 Apr 2020 02:48:43 -0700 (PDT)
Received: from dumbo (zarathustra.tor.k0nsl.org. [2605:6400:30:fd17:5f56:ce5b:f14f:e252])
        by smtp.gmail.com with ESMTPSA id j10sm15768171wmi.18.2020.04.27.02.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 02:48:42 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jT0NU-00037E-Kd; Mon, 27 Apr 2020 11:48:40 +0200
Date:   Mon, 27 Apr 2020 11:48:40 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] uswsusp: build only when configured
Message-ID: <20200427094840.GA29259@dumbo>
References: <20200413190843.044112674@gmail.com>
 <20200413193718.956985775@gmail.com>
 <4068729.AMvo8hvaBI@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4068729.AMvo8hvaBI@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 26, 2020 at 06:16:29PM +0200, Rafael J. Wysocki wrote:
> On Monday, April 13, 2020 9:08:45 PM CEST Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > uswsusp is no longer the preferred way to suspend/hibernate and the
> > userspace tools have not received any update in years.
> > 
> > Make it possible to enable the uswsusp support only if needed, prepare
> > for future phase out.
> > 
> > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Linux PM <linux-pm@vger.kernel.org>
> > 
> > ---
> >  kernel/power/Kconfig  |    5 +++++
> >  kernel/power/Makefile |    3 ++-
> >  kernel/power/power.h  |    5 +++++
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > Index: b/kernel/power/Kconfig
> > ===================================================================
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -80,6 +80,11 @@ config HIBERNATION
> >  
> >  	  For more information take a look at <file:Documentation/power/swsusp.rst>.
> >  
> > +config HIBERNATION_USER
> > +	bool "Userspace software suspend interface (DEPRECATED)"
> > +	depends on HIBERNATION
> > +	default n
> 
> This needs to be "default y" for the time being.
> 
> Also, I would call the option HIBERNATION_SNAPSHOT_DEV, because it effectively
> controls whether or not the snapshot device is available.
> 
> > +
> >  config PM_STD_PARTITION
> >  	string "Default resume partition"
> >  	depends on HIBERNATION
> > Index: b/kernel/power/Makefile
> > ===================================================================
> > --- a/kernel/power/Makefile
> > +++ b/kernel/power/Makefile
> > @@ -10,7 +10,8 @@ obj-$(CONFIG_VT_CONSOLE_SLEEP)	+= consol
> >  obj-$(CONFIG_FREEZER)		+= process.o
> >  obj-$(CONFIG_SUSPEND)		+= suspend.o
> >  obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
> > -obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o user.o
> > +obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o
> > +obj-$(CONFIG_HIBERNATION_USER)	+= user.o
> >  obj-$(CONFIG_PM_AUTOSLEEP)	+= autosleep.o
> >  obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
> >  
> > Index: b/kernel/power/power.h
> > ===================================================================
> > --- a/kernel/power/power.h
> > +++ b/kernel/power/power.h
> > @@ -158,8 +158,13 @@ extern sector_t alloc_swapdev_block(int
> >  extern void free_all_swap_pages(int swap);
> >  extern int swsusp_swap_in_use(void);
> >  
> > +#ifdef CONFIG_HIBERNATION_USER
> >  bool swsusp_try_enter(void);
> >  void swsusp_leave(void);
> > +#else
> > +static inline bool swsusp_try_enter(void) { return 1; }
> > +static inline void swsusp_leave(void) {}
> > +#endif
> 
> It is possible in theory that two processes write "disk" to /sys/power/state
> concurrently.
> 
> Is there enough mutual exclusion in place to handle this gracefully after the
> above change?

No, indeed.

It looks like hibernate.c needs the mutual exclusion and user.c could
just use it. Should I move snapshot_device_available to hibernate.c
and rename it hibernate_available?

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
