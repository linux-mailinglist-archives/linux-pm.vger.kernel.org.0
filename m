Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9106916EB50
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 17:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgBYQY0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 11:24:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33201 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbgBYQY0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 11:24:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id w6so97133otk.0;
        Tue, 25 Feb 2020 08:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElkWtD05bpJz0nVAaK9Zxby7+iR2LvCo6qCQ1kcJkb8=;
        b=BFwOjgb3qvMkPpj6BbgzqCHGtSsgrYnpMbTPViSmlIYBr1/I90E1m5KqxOwxy/QIJU
         QhlYsuroRBS8D7BCw3fMIqVTFW/JMaL0tZeUVjvTnzhVLfE024hCRGbmj4OBepcdtx3A
         pLSnay+IMX96O5OqCqrG7izEBmrofrsdecl202qr0QxQ/Av5dZQ7obT8B4+R0kBOiwlC
         QU25R+e0QBtKvzn6xzpOxZEXE2lRcy6l4UAHM8I8lObaW+h+CTu9GEUtndMlIifH6kV9
         IIvhf8iVWomOuvT8P0t6v8UQSsocDj+bRUZxHoZemUjcljiHiAknrbO17TzNl/zZiHWE
         n8+Q==
X-Gm-Message-State: APjAAAVtEjp21OxHPIAGrcwJmTYAtl/LNDgbqQZRhZm6vCDcCSpCru7O
        izCuwzjdwQLMqbni4NqN80x046MTKHsI0+IqFF8=
X-Google-Smtp-Source: APXvYqwKdQMsgAI31D0CTHFGEH5+24plVvLyCRNnBzVO50zYXso/wv+RUoxfNGl/HfCpSc/O7agAGNn8m2aboYQmg88=
X-Received: by 2002:a9d:7653:: with SMTP id o19mr43593382otl.118.1582647864921;
 Tue, 25 Feb 2020 08:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20200225050828.56458-1-john.stultz@linaro.org> <20200225050828.56458-2-john.stultz@linaro.org>
In-Reply-To: <20200225050828.56458-2-john.stultz@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Feb 2020 17:24:13 +0100
Message-ID: <CAJZ5v0husR3hgnSKOhQuGTaDVsQxS477JGLC2pdW=k2qJuA5mw@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] driver core: Fix driver_deferred_probe_check_state()
 logic
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 25, 2020 at 6:08 AM John Stultz <john.stultz@linaro.org> wrote:
>
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
> * If late_initcall has passed, and modules are not enabled
>   it returns -ENODEV
>
> * If modules are enabled and deferred_probe_timeout is set,
>   it returns -EPROBE_DEFER until the timeout, afterwhich it
>   returns -ETIMEDOUT.
>
> * In all other cases, it returns -EPROBE_DEFER
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
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v4:
> * Simplified logic suggested by Andy Shevchenko
> * Clarified commit message to focus on logic change
> v5:
> * Cleanup comment wording as suggested by Rafael
> * Tweaked the logic to use Saravana's suggested conditionals
> ---
>  drivers/base/dd.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index b25bcab2a26b..d75b34de6964 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -237,24 +237,26 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
>
>  static int __driver_deferred_probe_check_state(struct device *dev)
>  {
> -       if (!initcalls_done)
> -               return -EPROBE_DEFER;
> +       if (!IS_ENABLED(CONFIG_MODULES) && initcalls_done)
> +               return -ENODEV;
>
>         if (!deferred_probe_timeout) {
>                 dev_WARN(dev, "deferred probe timeout, ignoring dependency");
>                 return -ETIMEDOUT;
>         }
>
> -       return 0;
> +       return -EPROBE_DEFER;
>  }
>
>  /**
>   * driver_deferred_probe_check_state() - Check deferred probe state
>   * @dev: device to check
>   *
> - * Returns -ENODEV if init is done and all built-in drivers have had a chance
> - * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
> - * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
> + * Return:
> + * -ENODEV if initcalls have completed and modules are disabled.
> + * -ETIMEDOUT if the deferred probe timeout was set and has expired
> + *  and modules are enabled.
> + * -EPROBE_DEFER in other cases.
>   *
>   * Drivers or subsystems can opt-in to calling this function instead of directly
>   * returning -EPROBE_DEFER.
> @@ -264,7 +266,7 @@ int driver_deferred_probe_check_state(struct device *dev)
>         int ret;
>
>         ret = __driver_deferred_probe_check_state(dev);
> -       if (ret < 0)
> +       if (ret != -ENODEV)
>                 return ret;
>
>         dev_warn(dev, "ignoring dependency for device, assuming no driver");
> @@ -292,7 +294,7 @@ int driver_deferred_probe_check_state_continue(struct device *dev)
>         int ret;
>
>         ret = __driver_deferred_probe_check_state(dev);
> -       if (ret < 0)
> +       if (ret != -ENODEV)
>                 return ret;
>
>         return -EPROBE_DEFER;
> --
> 2.17.1
>
