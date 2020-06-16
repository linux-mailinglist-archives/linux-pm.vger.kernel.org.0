Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51CF1FAB3B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 10:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFPIbQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFPIbP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 04:31:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B8C03E96A
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 01:31:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so19833760wrt.5
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O9PrYTho49Bp6EVdK3E+npj+dEJ0SrzzaYmk25xGQCs=;
        b=IVV0TzJSfu6Cb6fbIfYYBpYjGCuxgbVN6r850piGyx/5zINEAkRFXfc72poc2cK3SZ
         VcEF0dEg5+XAe+ur1GnVppYchAQG97vZPiCl91UlA+lO45mdrqXZkQBH73ga3MUse6k8
         PIJS0YoOXZtsj9PPGtsNUfzRCyLXcKDCZjKMgvvYQcE98rVzgsqVF/3jX6iwWqlzOXnZ
         spDdTuXYgP3RMFGGFUaiblGaaV/T/RQ3mmLF9ELJoLXNag3y3Jlvcw26NSv+DvAClrkM
         Od/Kvm4WsC4LM9LUOt0LLdyQgRNEF6e7Ejc1Koa1sidd62IiKTJKeu9cI6v6cmCgIS4t
         pdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O9PrYTho49Bp6EVdK3E+npj+dEJ0SrzzaYmk25xGQCs=;
        b=lPNoKXz+EH2brqTVgGRqFl2B60k6bccyzVIZkJ9W7U54o7uzNhf043/dDaTYNyVq6J
         NsMn+Jv6Wrk4wYRIWeaf/54DZGQb0jQr5saEdGt8VPIzNyXR2L9+CAP5Bn+PC2rhhogI
         /K9gWWLxEV8wZV1i9mjeCaVav8B1yfALh+7Xz3ErAgVdwWTqNj87AAzpJNlkX1oOnhTu
         XdqFsCWW0kT6v0hzWVBpndNh+T2JUblvIPPMLX/Kfgl9uuiioj+hclJZdCQlRGorED7s
         KOyg5VhLz8ZrarWDnPC1NkZkX5DHRXStMaXLv8futatNHV8yHw1SfEeMxH+giIH+kdRe
         ztCw==
X-Gm-Message-State: AOAM532mUI1sftsgUJpJ2kgmREOkbfuoFx0QgUrVDmJD+bwCE/iGLpeF
        2g+60AlYTJ4gPNhINTbqbt+xDQ==
X-Google-Smtp-Source: ABdhPJyGVDBmCjx821OXOVBJ+fFcT06h8c84Po1Zcr2LqYcehjC7g284lXeFVlBS/b/VGmEgEyVJRg==
X-Received: by 2002:adf:9ccf:: with SMTP id h15mr1815949wre.275.1592296271800;
        Tue, 16 Jun 2020 01:31:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id b8sm27846943wrm.35.2020.06.16.01.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:31:10 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:31:07 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200616083107.GA122049@google.com>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
 <20200616043143.obk5k3rv737j5dnd@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616043143.obk5k3rv737j5dnd@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Viresh,

On Tuesday 16 Jun 2020 at 10:01:43 (+0530), Viresh Kumar wrote:
> On 15-06-20, 17:55, Quentin Perret wrote:
> > +static void cpufreq_get_default_governor(void)
> > +{
> > +	default_governor = cpufreq_parse_governor(cpufreq_param_governor);
> > +	if (!default_governor) {
> > +		if (*cpufreq_param_governor)
> > +			pr_warn("Failed to find %s\n", cpufreq_param_governor);
> > +		default_governor = cpufreq_default_governor();
> 
> A module_get() never happened for this case and so maybe a
> module_put() should never get called.

Correct, however cpufreq_default_governor() being a weak function, we're
basically guaranteed the governor we get from there is builtin, so
gov->owner is NULL. That is, module_put() is not actively useful, but it
doesn't harm. So I figured that should be fine. That could definitely
use a comment, though :)

> > +	}
> > +}
> > +
> > +static void cpufreq_put_default_governor(void)
> > +{
> > +	if (!default_governor)
> > +		return;
> > +	module_put(default_governor->owner);
> > +	default_governor = NULL;
> > +}
> > +
> >  static int cpufreq_init_governor(struct cpufreq_policy *policy)
> >  {
> >  	int ret;
> > @@ -2701,6 +2721,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
> >  
> >  	if (driver_data->setpolicy)
> >  		driver_data->flags |= CPUFREQ_CONST_LOOPS;
> > +	else
> > +		cpufreq_get_default_governor();
> >  
> >  	if (cpufreq_boost_supported()) {
> >  		ret = create_boost_sysfs_file();
> > @@ -2769,6 +2791,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
> >  	subsys_interface_unregister(&cpufreq_interface);
> >  	remove_boost_sysfs_file();
> >  	cpuhp_remove_state_nocalls_cpuslocked(hp_online);
> > +	cpufreq_put_default_governor();
> >  
> >  	write_lock_irqsave(&cpufreq_driver_lock, flags);
> >  
> > @@ -2792,4 +2815,5 @@ static int __init cpufreq_core_init(void)
> >  	return 0;
> >  }
> 
> And since this is a per boot thing, there is perhaps no need of doing
> these at driver register/unregister, I would rather do it at:
> cpufreq_core_init() time itself and so we will never need to run
> cpufreq_put_default_governor() and so can be removed.

Right, so the reason I avoided cpufreq_core_init() was because it is
called at core_initcall() time, which means I can't really assume the
governors have been loaded by that time. By waiting for the driver to
probe before detecting the default gov, we get that nice ordering. But
yes, it feels odd to have it here :/

Thinking about it more, the natural fit for this would rather be the
register/unregister path for governors directly. If that sounds good to
you (?) I'll try to move it there in v2.

> And another thing I am not able to understand (despite you commenting
> about that in the commit log) is what happens if the default governor
> chosen is built as a module ?

So the answer is 'it depends'. If the driver is built as a module too,
then you should load the governor module first, and then the driver
module, and everything will work just fine.

But in the case where the governor is loaded _after_ the driver (either
because we got the module ordering wrong, or because the driver is
builtin), then the policies will be initialized with the builtin
default, and nothing special will happen when the governor module is
loaded.

That behaviour very much is open for discussion, though. A possible
alternative would be to automatically switch all policies to the default
governor upon loading. That would have the nice benefit or removing the
ordering dependency, but that is more involved and I didn't have a
use-case for it, so I went for the simpler option ('the-default
governor-needs-to-be-registered-before-the-policies-are-created').

Thoughts?

Thanks,
Quentin
