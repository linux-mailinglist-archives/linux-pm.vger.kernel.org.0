Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0EBC15FD67
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2020 08:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgBOHwI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Feb 2020 02:52:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39591 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgBOHwI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Feb 2020 02:52:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so4697628plp.6
        for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2020 23:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+m12PrSZ5JNlP//5j/kuBBtfoGEJ+I6Trjsep0GfxQI=;
        b=Ffj7SnrIUPtsAxBy96NPJCHLDUrvn5RzTWywpPezxDtk3sJ++Mqnoyf5TNNCHy4DSN
         jrkck5ZfqvbPph8DLNJ92Ff7ljKEvmb0w4s4ftHaIIR4ZqyDegPjVawAdaMpJoyMz69f
         lwL/9m2NfJWrHnLaghIrg/rnTErbzAONGCiXzI1Nu2F+19n4hFSaX7l2qwAT1yp9Z74W
         0grs93Toi8mVa2tGo6fo5MudEnBy+GbtKKuBe+K0D3kM/g7bXDHwpmptJv35nQpN9h1j
         FE7P+D5ny+RXUOuVVGp1DIk21DTXksWziTvfC0/iv94ukGeUMTmcu7oolAUyL4Lqyv8h
         rwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+m12PrSZ5JNlP//5j/kuBBtfoGEJ+I6Trjsep0GfxQI=;
        b=LzWgYwUztes34gJBV87BecH32cNLUg3GX/4wIWEB+XCjrpgeDBgGZnWJC/1jCWGbxA
         yeJSM8ZCMMdPgEJQQlQG1X9KMfpdecR1oEzIfFb4SU8Mm2Pf9XdoPzyCQz2UUx4piLwy
         Hlj5JiVxz6K5dXgvKjgXHqhF7eGj8LmlKEAAwxdUp+9ZhTOyXoRqRQT854kfyfSS6clJ
         02eqM/iiZHu7ocofRI8mZy8Pytl9v7vANeuwYC+WGXFUFEyLc9UYAfc2C5TihEOCOmFe
         mEURkuqV25rDPjYD4d262newMxqemUD/3CagebzxXNS0HC5rQU/CTQUeM4lq5A9tsXIX
         YfQQ==
X-Gm-Message-State: APjAAAVMhNqdxT5WfMajIprDqeCFRUA4fH8yuhyAaLrczW1BfVG8yqvb
        GktWLG2y3Q+FQfu8yJ80IN8+2A==
X-Google-Smtp-Source: APXvYqzpxec/nzCo5ySMXrzsLWRfDr9U9SBQ0ymgwJIi5JizRlkMgbo7+Tg1Z3Z0WDI0gm6tFRpBMA==
X-Received: by 2002:a17:90a:234f:: with SMTP id f73mr8091615pje.109.1581753127771;
        Fri, 14 Feb 2020 23:52:07 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o11sm8975653pjs.6.2020.02.14.23.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 23:52:07 -0800 (PST)
Date:   Fri, 14 Feb 2020 23:51:16 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Extend returning EPROBE_DEFER for two
 minutes after late_initcall
Message-ID: <20200215075116.GT955802@ripper>
References: <20200214233226.82096-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214233226.82096-1-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 14 Feb 15:32 PST 2020, John Stultz wrote:

> Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> at the end of initcall"), along with commit 25b4e70dcce9
> ("driver core: allow stopping deferred probe after init") after
> late_initcall, drivers will stop getting EPROBE_DEFER, and
> instead see an error causing the driver to fail to load.
> 
> That change causes trouble when trying to use many clk drivers
> as modules, as the clk modules may not load until much later
> after init has started. If a dependent driver loads and gets an
> error instead of EPROBE_DEFER, it won't try to reload later when
> the dependency is met, and will thus fail to load.
> 
> Instead of reverting that patch, this patch tries to extend the
> time that EPROBE_DEFER is retruned by 30 seconds, to (hopefully)
> ensure that everything has had a chance to load.
> 
> 30 seconds was chosen to match the similar timeout used by the
> regulator code here in commit 55576cf18537 ("regulator: Defer
> init completion for a while after late_initcall")
> 
> Specifically, on db845c, this change allows us to set
> SDM_GPUCC_845, QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and
> get a working system, where as without it the display will fail
> to load.
> 

With the $subject adjustment

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Cc: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Fixes: e01afc3250255 ("PM / Domains: Stop deferring probe at the end of initcall")
> Fixes: 25b4e70dcce9 ("driver core: allow stopping deferred probe after init")
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Add calls to driver_deferred_probe_trigger() after the two minute timeout,
>   as suggested by Bjorn
> * Minor whitespace cleanups
> * Switch to 30 second timeout to match what the regulator code is doing as
>   suggested by Rob.
> ---
>  drivers/base/dd.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index d811e60610d3..0f519ef3b257 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -311,6 +311,15 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
>  }
>  static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
>  
> +static void deferred_initcall_done_work_func(struct work_struct *work)
> +{
> +	initcalls_done = true;
> +	driver_deferred_probe_trigger();
> +	flush_work(&deferred_probe_work);
> +}
> +static DECLARE_DELAYED_WORK(deferred_initcall_done_work,
> +			    deferred_initcall_done_work_func);
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> @@ -327,7 +336,8 @@ static int deferred_probe_initcall(void)
>  	driver_deferred_probe_trigger();
>  	/* Sort as many dependencies as possible before exiting initcalls */
>  	flush_work(&deferred_probe_work);
> -	initcalls_done = true;
> +	schedule_delayed_work(&deferred_initcall_done_work,
> +			      msecs_to_jiffies(30000));
>  
>  	/*
>  	 * Trigger deferred probe again, this time we won't defer anything
> -- 
> 2.17.1
> 
