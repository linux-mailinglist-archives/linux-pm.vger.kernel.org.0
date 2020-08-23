Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC324EAF5
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 04:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHWCyN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Aug 2020 22:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgHWCyM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Aug 2020 22:54:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E6C061573;
        Sat, 22 Aug 2020 19:54:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w13so5046539wrk.5;
        Sat, 22 Aug 2020 19:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JO459KxhJEzf2IEvI+josGJJ60W1ooA97Y5knTsxYNo=;
        b=Rb5WNI8n/gZRSeMt+vb40+nrepp/iM3BAw0azlstiR+TmHzSf13RqQXBLUE+Su0NLw
         fce1d1ywY5xSM/jbls95zUoVSn7t/r1AYVRsIzSGU6NfVWMsbkep9Vhtxw36ZeWRU1NY
         whI/eHHCx59CIvp2SlyiJwbmHXHvoCGowkEBZ8tMj7V0xT5q57zH8KAWqG7bkNvaSNKt
         2IqCrm54R7PLM0/IFnA4bVXzuDOHfd+SGvSkzCjICGk7EKpjmWdKOj6esTyEQ3ahlI3Q
         iwQh6GybEajGdzEhNyDFHdn4DND7Hm4lSxQeEjBeK8lKWeBqoAkBqc/TZWHOQAuBcTK6
         dsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JO459KxhJEzf2IEvI+josGJJ60W1ooA97Y5knTsxYNo=;
        b=e1ySMhfz0/6pZui9/VnL6TEd1TKKhF4amloTsBz5u7Q592vEz8hY3YDRwz8IFA0UV0
         fXnh54V2ayqbao8cvC+sG0FHnLUmA/qkR+oNIq5zl96QDw0OUo6WJAhk/wgMZjPrpJ+b
         cawbAFbi7V8/qUP1dh5UOVC8DWNRgQxzcVlbwSDBotxzaii0mbLAuLKjPQPhX3K4kPow
         7LRtRk5OJqYlgt6myWUO1WMmMgPdlIOz1GvuwD+DaTHScZgEUiztfiXIxpamf4doLwYJ
         OWiglq1nLsJ4T7G6wdjvtJrJokGdIkw2vQw7nB99FuGZGVhvARtkvu2hD9PNkXzWy90r
         T95g==
X-Gm-Message-State: AOAM531VSIogmgMd0bv2kzbbuHUhaUPjWAxxYNq10n3AlqW/w0L28lC3
        ht5jjI+U6SscoJhoXe5YH4J/nxGMbHhAzGbD6Yo=
X-Google-Smtp-Source: ABdhPJxVBi+fxXUP+tAoUQKNyIfnLypZr9quB2wxZNg+UUdCRFGmKVwAS0GkY0xptxxCJF0laNsknAkD1vUkiXyqd8Q=
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr147495wru.19.1598151250584;
 Sat, 22 Aug 2020 19:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597919647.git.viresh.kumar@linaro.org> <56f1c76a0061dc3ed2d6ea115a3ba8b2e2dee9fd.1597919647.git.viresh.kumar@linaro.org>
In-Reply-To: <56f1c76a0061dc3ed2d6ea115a3ba8b2e2dee9fd.1597919647.git.viresh.kumar@linaro.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sun, 23 Aug 2020 10:53:59 +0800
Message-ID: <CAKGbVbukA=M=a5uNwPJ3=tXYVT3QTVSJKb5VJFCq2JGwV0TSCw@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/lima: Unconditionally call dev_pm_opp_of_remove_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rnayak@codeaurora.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Regards,
Qiang

On Thu, Aug 20, 2020 at 6:44 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
> find the OPP table with error -ENODEV (i.e. OPP table not present for
> the device). And we can call dev_pm_opp_of_remove_table()
> unconditionally here.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/gpu/drm/lima/lima_devfreq.c | 6 +-----
>  drivers/gpu/drm/lima/lima_devfreq.h | 1 -
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
> index bbe02817721b..cd290d866a04 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.c
> +++ b/drivers/gpu/drm/lima/lima_devfreq.c
> @@ -105,10 +105,7 @@ void lima_devfreq_fini(struct lima_device *ldev)
>                 devfreq->devfreq = NULL;
>         }
>
> -       if (devfreq->opp_of_table_added) {
> -               dev_pm_opp_of_remove_table(ldev->dev);
> -               devfreq->opp_of_table_added = false;
> -       }
> +       dev_pm_opp_of_remove_table(ldev->dev);
>
>         if (devfreq->regulators_opp_table) {
>                 dev_pm_opp_put_regulators(devfreq->regulators_opp_table);
> @@ -162,7 +159,6 @@ int lima_devfreq_init(struct lima_device *ldev)
>         ret = dev_pm_opp_of_add_table(dev);
>         if (ret)
>                 goto err_fini;
> -       ldevfreq->opp_of_table_added = true;
>
>         lima_devfreq_reset(ldevfreq);
>
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
> index 5eed2975a375..2d9b3008ce77 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.h
> +++ b/drivers/gpu/drm/lima/lima_devfreq.h
> @@ -18,7 +18,6 @@ struct lima_devfreq {
>         struct opp_table *clkname_opp_table;
>         struct opp_table *regulators_opp_table;
>         struct thermal_cooling_device *cooling;
> -       bool opp_of_table_added;
>
>         ktime_t busy_time;
>         ktime_t idle_time;
> --
> 2.25.0.rc1.19.g042ed3e048af
>
