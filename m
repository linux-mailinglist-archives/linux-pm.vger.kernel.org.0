Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30CA9165BA3
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 11:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgBTKg3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 05:36:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32979 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgBTKg3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 05:36:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id w6so3218860otk.0;
        Thu, 20 Feb 2020 02:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miXTb5HAsIjYSRoFoX3UH15Dws4NhNQxWNMPkO2fDLE=;
        b=JOEgvdemrDTCAe4fgny6maoWpUYXoCVcYMq3RT3K+uCEzUvFU/TtbjWAc3w+lavnjo
         QRt5CSjMXhUkjlica9XxU393ZmdANYZU7shc3gCuO3mpJUaR8WMBcHPiTzBkJuWMfWVY
         zphhYT2IiAEPyloqxCjyhWjCGbXnAhKKa9xLS4lfbZ8vsZt3miJZHsNL33zCZxwzad5X
         qB4ml7LVBVUACI0z5mZo5Ig4LRGxDUF9sSgMZILsQ9j1Sw9dnlXRiGJE980YXDpnHOxI
         wXIHlayCqYqVdoYeOMY+oHIJlPsqW6mhwYEHl1iKmQN0R5+sRLQ8Af7obOyunEy4romq
         jvKA==
X-Gm-Message-State: APjAAAWNd6irPlJqNnUMHx6Kwgu8JtleRDodLhlDpFFamcOHJv8E0c+H
        zkdcziguG1HYAiIciE2jTeXkbZEgbgZVLT1jBz8=
X-Google-Smtp-Source: APXvYqzKD8vfsYd9LIyX1NTkCe04vt+5krg0iwxtBfD5CVB9Bx8JIBmvjT94OvR0nDTq/oxZhnlqp2jiITkDYILcSeY=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr1304767otd.266.1582194988112;
 Thu, 20 Feb 2020 02:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20200220050440.45878-1-john.stultz@linaro.org> <20200220050440.45878-3-john.stultz@linaro.org>
In-Reply-To: <20200220050440.45878-3-john.stultz@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 11:36:16 +0100
Message-ID: <CAJZ5v0jZ8VVEFjMcCMby-RdEwUY6mS5w3pMktv-hfJQ7OEp9Gg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] driver core: Set deferred_probe_timeout to a
 longer default if CONFIG_MODULES is set
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

Looks reasonable to me.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>  static int __init deferred_probe_timeout_setup(char *str)
>  {
>         int timeout;
> --
