Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B224C165B7A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 11:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgBTK2m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 05:28:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41142 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgBTK2m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 05:28:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so26995252oie.8;
        Thu, 20 Feb 2020 02:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFBAIbuDCjTjmW06WHYZexwuHI/VktjiadQxllE5tFo=;
        b=HONQm9eIsvaRDW+4iW2uC9laW5HC6PIzQqVKQa1jDwpbeEfFfrNl1CBGiNNwKAbjvZ
         PH5hOIsPnACwLDyztCxqEEhHk2EtSp9OB1TJlZknrktm5mO4u6Z3+0ObNxgKgpRHtnIm
         QwaH4T302tYIIlu6/0ITMIafdwVix4zXBHSUrUb0leJ+eEb2qKnzLfAygL/7H0GGi/dh
         31H259DhwYNh+0sE/4xLPgY+kcaWRCtaT2Eio6BH+PDF31YtJCM2a8w/ShK+O6Mmjesl
         PAxg/l1XwNA680w5+JUsm9GdL3zNnJ8Fc7EQbf2e8L0DtQp02PhQgdyIueclgSP855us
         GfNw==
X-Gm-Message-State: APjAAAX3BHasixomluyuiUcUvgIB6fAjC2ge9uYQXwk4ibH5EONOuqpw
        6Gwbip8jc2cP3OYTx4J7dpSvb3HJNZsL/pVOT1M=
X-Google-Smtp-Source: APXvYqzZ6ybSzXMcdaP3OhqdQD94MQHqguLaLbx0WQl2FUi/mEWzifAg752SnrHoBp9RtMPM/JcmiG8RTEXRWlzY+0Q=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr1503321oif.57.1582194521672;
 Thu, 20 Feb 2020 02:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20200220050440.45878-1-john.stultz@linaro.org> <20200220050440.45878-2-john.stultz@linaro.org>
In-Reply-To: <20200220050440.45878-2-john.stultz@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 11:28:30 +0100
Message-ID: <CAJZ5v0iotVcMU5R1vb+p1c-L3mY31iQ56nUNsEA110RMEVWbMg@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] driver core: Fix driver_deferred_probe_check_state()
 logic
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
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

On Thu, Feb 20, 2020 at 6:05 AM John Stultz <john.stultz@linaro.org> wrote:
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
> -       if (!initcalls_done)
> +       if (!initcalls_done || deferred_probe_timeout > 0)
>                 return -EPROBE_DEFER;

Makes sense to me.

>
>         if (!deferred_probe_timeout) {
> @@ -252,9 +252,11 @@ static int __driver_deferred_probe_check_state(struct device *dev)
>   * driver_deferred_probe_check_state() - Check deferred probe state
>   * @dev: device to check
>   *
> - * Returns -ENODEV if init is done and all built-in drivers have had a chance
> - * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
> - * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
> + * Returnes -EPROBE_DEFER if initcalls have not completed, or the deferred

s/Returnes/Returns/

And I would write

* Return:
* -EPROBE_DEFER if initcalls have not completed, or the deferred
*  probe timeout is set, but not expried.
* -ETIMEDOUT if the deferred probe timeout was set and has expired.
* -ENODEV if initcalls have completed and the deferred probe timeout
was not set.

> + * probe timeout is set, but not expried.
> + * Returns -ETIMEDOUT if the probe timeout was set and has expired.
> + * Returns -ENODEV if initcalls have completed and the deferred probe timeout
> + * was not set.
>   *
>   * Drivers or subsystems can opt-in to calling this function instead of directly
>   * returning -EPROBE_DEFER.
> --
