Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE9E415CF8F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 02:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgBNBvb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 20:51:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbgBNBvb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 20:51:31 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95D8224649;
        Fri, 14 Feb 2020 01:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581645090;
        bh=WDRqGLlGcgsGtJnCUjmJ8SBRFPhZLI4nnSahdtCOJpY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HtJglxyTjgkyhe4CdWu2WxkDcE1vpcbE2FQM+j+/LT3a3sPVxwe4B50H6W+JTFKMB
         8UX72jZ6DWHQO9gMz2QLuDNkYpBreBVCb99ZsN1DIYDGdslV2tEZUFvz2K2H29uqep
         NgBRCfWK3CQsmLXp+IpnCygmJPeRzhieeOkihNTQ=
Received: by mail-qv1-f49.google.com with SMTP id m5so3609773qvv.4;
        Thu, 13 Feb 2020 17:51:30 -0800 (PST)
X-Gm-Message-State: APjAAAU9dBWPgKdFOIVVPkAAbR2vUc5VqJvbzyIwGHNVkCDlJkq820GB
        9vypOK6SzdAAzBCnMG2sUi2zW9tZNyQzGhsuLg==
X-Google-Smtp-Source: APXvYqyTjLz0Q5iJr0U8tlUZFBpbfIYW2iYnW0ja4OOrPVoI4LcvA1j0mwSJRTx6VSFky+W9OzdHXzwuqOuZ2A/a70w=
X-Received: by 2002:a05:6214:11ac:: with SMTP id u12mr301052qvv.85.1581645089662;
 Thu, 13 Feb 2020 17:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20200214004413.12450-1-john.stultz@linaro.org>
In-Reply-To: <20200214004413.12450-1-john.stultz@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 13 Feb 2020 19:51:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+P0FZU9DnRhgYu6kvCFVbia=Z20VWNR2qi-Zwv=YtQhQ@mail.gmail.com>
Message-ID: <CAL_Jsq+P0FZU9DnRhgYu6kvCFVbia=Z20VWNR2qi-Zwv=YtQhQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] driver core: Extend returning EPROBE_DEFER for two
 minutes after late_initcall
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Alexander Graf <agraf@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 6:44 PM John Stultz <john.stultz@linaro.org> wrote:
>
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
> time that EPROBE_DEFER is retruned by two minutes, to (hopefully)
> ensure that everything has had a chance to load.

I think regulators already has some delay like this. We should use the
same timeouts.

We also have the 'deferred_probe_timeout' cmdline option. It's deemed
a debug option currently, but we could change that and change the
default.

> Specifically, on db845c, this change allows us to set
> SDM_GPUCC_845, QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and
> get a working system, where as without it the display will fail
> to load.
>
> Cc: Alexander Graf <agraf@suse.de>
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

We can debate the design, but those work as designed. So Fixes?

> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/base/dd.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index b25bcab2a26b..35ebae8b65be 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -311,6 +311,12 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
>  }
>  static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
>
> +static void deferred_initcall_done_work_func(struct work_struct *work)
> +{
> +       initcalls_done = true;
> +}
> +static DECLARE_DELAYED_WORK(deferred_initcall_done_work, deferred_initcall_done_work_func);
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> @@ -327,7 +333,7 @@ static int deferred_probe_initcall(void)
>         driver_deferred_probe_trigger();
>         /* Sort as many dependencies as possible before exiting initcalls */
>         flush_work(&deferred_probe_work);
> -       initcalls_done = true;
> +       schedule_delayed_work(&deferred_initcall_done_work, 120 * HZ);
>
>         /*
>          * Trigger deferred probe again, this time we won't defer anything
> --
> 2.17.1
>
