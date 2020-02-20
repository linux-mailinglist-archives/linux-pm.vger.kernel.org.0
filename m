Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 270F1166185
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgBTP4B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 10:56:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38735 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgBTP4A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 10:56:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so1708935plj.5
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 07:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dPLlvkm9LDItGatWM8z0zqMFKuHSP92PMk+ALHwse6g=;
        b=ziQRes5Wn8emIACRiQKqwWQd7p+hOvkb67mJ6Bz09tTlUTSaeOt6azfgjJBuzGxsVx
         XrkSwyDlksNCs4l+mjPgIhrQI8wQC4jCoSmlcxefVgwinDvD0GV9iPu37Uu7FGHLQ3d8
         9rHCoKTuh7/OZJDwUonf8aJhm2Y3qa+mlLgX9bXWUEjQd59BjeeskxAHjtohAuDX7juC
         JukbhoovrJ+3s2YDXq6GdAt0p9A5JpVvweXA0i0ZlTYRg6alPWV0V+1v8VjHqAfXhjkA
         mtizN6+hPmJOZP9fOQst8tsBOv5XiYOlVjbdL2EhtNBHAho8BnWSbJiEQA/OVpugM2+9
         Helw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dPLlvkm9LDItGatWM8z0zqMFKuHSP92PMk+ALHwse6g=;
        b=D5W9PZiZkd9IZHNmfsyw+Fra0bQJ7wyzYbgwLJO7DRmHY1ESShgx8RRLXjSSs+vlqV
         a6FpCKvgXb/VhoiWOgHrUOsFz2AroZm2xB9K8QyCYwQWrwZ1LQxidD1j4KaHrtu3oDPc
         lScZ7H1R44CRT46+FkOkOvadyRwiIZDUefG9xWY7AxZiCevvHgJ45ZvJ355ldgf/LtTv
         hH+xcJzsG6T8UAuGcMVL6ehOx5SV0rR8r5j8wMLDS8TI0pyNm3YR4V72idKDrnirno4Z
         7xEYvRh4OiCPB93n2T/HE0eJ2LvBT4P90+lAGya+R7Z22IRnsjA86+u0YVqAWrpMUIev
         uTUg==
X-Gm-Message-State: APjAAAX8CcUJKuuDT389SIcb5s1k8QlNs6XABPFY1B0FK0qYn/ZUgJq2
        7R0OHj8GOTpaW5gACa3MH17m4Q==
X-Google-Smtp-Source: APXvYqzQg5xdhcudupIotNjSrqXf+6W08xrzP5NVdRO6Vhdy1jTtk44EddZdLaITBvHl0445gSYhzA==
X-Received: by 2002:a17:902:528:: with SMTP id 37mr32621886plf.322.1582214159735;
        Thu, 20 Feb 2020 07:55:59 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q6sm19046pfh.127.2020.02.20.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:55:59 -0800 (PST)
Date:   Thu, 20 Feb 2020 07:55:03 -0800
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
Subject: Re: [PATCH v4 1/6] driver core: Fix
 driver_deferred_probe_check_state() logic
Message-ID: <20200220155503.GD955802@ripper>
References: <20200220050440.45878-1-john.stultz@linaro.org>
 <20200220050440.45878-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220050440.45878-2-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 19 Feb 21:04 PST 2020, John Stultz wrote:

> driver_deferred_probe_check_state() has some uninituitive behavior.
> 
> * From boot to late_initcall, it returns -EPROBE_DEFER
> 
> * From late_initcall to the deferred_probe_timeout (if set)
>   it returns -ENODEV
> 
> * If the deferred_probe_timeout it set, after it fires, it
>   returns -ETIMEDOUT
> 
> This is a bit confusing, as its useful to have the function
> return -EPROBE_DEFER while the timeout is still running. This
> behavior has resulted in the somwhat duplicative
> driver_deferred_probe_check_state_continue() function being
> added.
> 
> Thus this patch tries to improve the logic, so that it behaves
> as such:
> 
> * If deferred_probe_timeout is set, it returns -EPROBE_DEFER
>   until the timeout, afterwhich it returns -ETIMEDOUT.
> 
> * If deferred_probe_timeout is not set (-1), it returns
>   -EPROBE_DEFER until late_initcall, after which it returns
> 
> This will make the deferred_probe_timeout value much more
> functional, and will allow us to consolidate the
> driver_deferred_probe_check_state() and
> driver_deferred_probe_check_state_continue() logic in a later
> patch.
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
> Change-Id: I8349b7a403ce8cbce485ea0a0a5512fddffb635c

Please drop the Change-Id.

> ---
> v4:
> * Simplified logic suggested by Andy Shevchenko
> * Clarified commit message to focus on logic change
> ---
>  drivers/base/dd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index b25bcab2a26b..bb383dca39c1 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -237,7 +237,7 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
>  
>  static int __driver_deferred_probe_check_state(struct device *dev)
>  {
> -	if (!initcalls_done)
> +	if (!initcalls_done || deferred_probe_timeout > 0)
>  		return -EPROBE_DEFER;
>  
>  	if (!deferred_probe_timeout) {
> @@ -252,9 +252,11 @@ static int __driver_deferred_probe_check_state(struct device *dev)
>   * driver_deferred_probe_check_state() - Check deferred probe state
>   * @dev: device to check
>   *
> - * Returns -ENODEV if init is done and all built-in drivers have had a chance
> - * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
> - * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
> + * Returnes -EPROBE_DEFER if initcalls have not completed, or the deferred

As pointed out by Rafael, this should be Return:

With that addressed, you have my
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> + * probe timeout is set, but not expried.
> + * Returns -ETIMEDOUT if the probe timeout was set and has expired.
> + * Returns -ENODEV if initcalls have completed and the deferred probe timeout
> + * was not set.
>   *
>   * Drivers or subsystems can opt-in to calling this function instead of directly
>   * returning -EPROBE_DEFER.
> -- 
> 2.17.1
> 
