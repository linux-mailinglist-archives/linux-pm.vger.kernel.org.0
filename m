Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C5216618C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 16:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgBTP44 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 10:56:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35561 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgBTP4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 10:56:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id v23so2146744pgk.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 07:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rNBzr+gKL7W/4+tMuEJmqqL2ELw8zx9/UXsCB1+eKjY=;
        b=GhANP2g0294bY7ihToE8mRKMYwYIxEuzTTlWpZSq/Oj/DNB7wcAnz6UBnSA/0JlzO1
         zQgrDPIGpwOyPqKz3rhBKLyBVINls8WEGLZ3i38vALuFb74X4TA2EQdBwdsRdEqMClwJ
         7O6L2YGcyC6eoVlx39mkCRWCcNx4o+Iv397gKPOTx0tqlh/+B3R7Sm1uW4vNC3l3/E6E
         uYudBzcX7IR1ofHCR+nbozHYZ5oAl97JP2DFKmeN2P1pBfUJJQBSyxzMxf021nn65FTI
         x0h4wu/RANDJ/gFpme5Stsyy2G1FMyFjvLmgLy2zW8nr5FgDNhLBm8J7G0+vKQfU12Po
         xnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rNBzr+gKL7W/4+tMuEJmqqL2ELw8zx9/UXsCB1+eKjY=;
        b=lK8KPrxX3qoOjBWhhKvMo8OAQ3IVeXsb+dxOC3pDQUYB6VvO+xCxqx1j8RXZnvRatw
         9hWzf+a3ZsRFbZXgj5HFNFJ+U0/8NUJnjysI0RZBw4CaA8xFxfoMVMiOJqZ2Df9cxQ3/
         6/jUspM6rO3fcSS7OEmTeyQVVuDoSC3oAtQzhDDUgH4G6gj44KwtGaAI9MuxPpr09Y9A
         xD2Vk1f9huWrJ4swuU1aOJcFy6DD07Sj+7DlK5C34uE81T3DRoDaxmhESUHV3lNXyvuC
         XiLNG2aNskvkIH6CKxrBhYqBJ1fl5pxPymQB9cnAimxP30KsEOamFugB5QD/elszHC0X
         OXeQ==
X-Gm-Message-State: APjAAAX1trDFBXzEinuXAVJ1mCUcA82A1wWO26WuV4Z59RqSS0OfO21z
        gUCTlXhUY2LrwdXGykNNabTpWA==
X-Google-Smtp-Source: APXvYqxgmpLr0iQFDhJMwwmGPN0p+UlmPhonwyMbkL9R2pkVjF5jGqMHkbnHZVBJ+BMwHtftaA4qJw==
X-Received: by 2002:a63:33c4:: with SMTP id z187mr33761577pgz.114.1582214212585;
        Thu, 20 Feb 2020 07:56:52 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f13sm4218442pgk.12.2020.02.20.07.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:56:51 -0800 (PST)
Date:   Thu, 20 Feb 2020 07:55:56 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/6] driver core: Set deferred_probe_timeout to a
 longer default if CONFIG_MODULES is set
Message-ID: <20200220155556.GE955802@ripper>
References: <20200220050440.45878-1-john.stultz@linaro.org>
 <20200220050440.45878-3-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220050440.45878-3-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 19 Feb 21:04 PST 2020, John Stultz wrote:

> When using modules, its common for the modules not to be loaded
> until quite late by userland. With the current code,
> driver_deferred_probe_check_state() will stop returning
> EPROBE_DEFER after late_initcall, which can cause module
> dependency resolution to fail after that.
> 
> So allow a longer window of 30 seconds (picked somewhat
> arbitrarily, but influenced by the similar regulator core
> timeout value) in the case where modules are enabled.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: I9c5a02a54915ff53f9f14d49c601f41d7105e05e

Change-Id...

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> v4:
> * Split out into its own patch as suggested by Mark
> * Made change conditional on CONFIG_MODULES
> ---
>  drivers/base/dd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index bb383dca39c1..fa138f24e2d3 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -224,7 +224,16 @@ static int deferred_devs_show(struct seq_file *s, void *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(deferred_devs);
>  
> +#ifdef CONFIG_MODULES
> +/*
> + * In the case of modules, set the default probe timeout to
> + * 30 seconds to give userland some time to load needed modules
> + */
> +static int deferred_probe_timeout = 30;
> +#else
> +/* In the case of !modules, no probe timeout needed */
>  static int deferred_probe_timeout = -1;
> +#endif
>  static int __init deferred_probe_timeout_setup(char *str)
>  {
>  	int timeout;
> -- 
> 2.17.1
> 
