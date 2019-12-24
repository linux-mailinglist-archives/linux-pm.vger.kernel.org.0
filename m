Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B0512A29F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2019 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfLXOvn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Dec 2019 09:51:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41501 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLXOvm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Dec 2019 09:51:42 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so15751044ioo.8;
        Tue, 24 Dec 2019 06:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HA9SF07pomUf/mhFGeOHvPX1/YV6Atxy36iIR2tYUwc=;
        b=vIZYFYQdzUfJmTpJC+q5NIi8BYa6+DWw959lZLAuayQW3H+rhE9SRRujDIn3jIB7/u
         +UK4PiTNIrzYzzNO+Cq1xIqvuQlbnA1oMKm0XzqSs+J6wCVhQ87fZe6V/7y9nzE9HSVr
         Et8HQGgg3B90f77+UO0CLaJlWcubtJoq8Z1dBGIteQElbBYxA+BI/QHaW/KAXyJGOD0l
         3U8nc6e2Uaa9QwmniMP53YaE8uFTXY4ExSArH/Ro37qvbAhZL5/9A9Unop+xBkuiFREv
         KGW5+qjFYgmZLMbjD1qEdd7kHvyjMH7qtkCwtP0m1eN8tmq4C/5nESdZ8XHLtbSAjILj
         oajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HA9SF07pomUf/mhFGeOHvPX1/YV6Atxy36iIR2tYUwc=;
        b=av1aqDNtZGPgvTEudoYlF8ggwzFoWbrUPEpFFGIexhrPEyDy9FjZNSxzd0Z6rChgsZ
         MWi/NbH2aCd1Zpl8+sGW0YpiUa0kW4jp/S72WozJR76AXaTc1xLC6GuYbfvO3GKB5abD
         1iBfSzlEIyXsw/7PrrRjTkLLSl3FAwMJ5gHQuTTR6Vpvt2M9h3NUaQ3u9cuqgUlr65Gb
         JDE1Th8yUZXrNHHaqlvbN8W0k6M0RlbQFoQg/oElmL6COupDibUmV+UNO4K7tWO9UXlu
         9bUNl0kUyBl8n85+Y1xM3mW8nb/NGxoaXUSozl//IfROgN+6y086h9arOzRF6PeCXakF
         Ujug==
X-Gm-Message-State: APjAAAX4DoYmeJ0FoBJWNjgBbFTB5L7XHktWnLtKP8UepssOAErbqvuJ
        u7VtlxQ2KYFHOriUa4Og+7G9YjZcoT99Ak+NPvo=
X-Google-Smtp-Source: APXvYqyTA0h9UaY01CHPo22LrNq/F1xXrEI8zP9Isq32dA7+ynxUzAzjdJ1cR2bA+G2udw/5Th5u66brm9gGwVDtkeU=
X-Received: by 2002:a5d:9eda:: with SMTP id a26mr24747238ioe.238.1577199101880;
 Tue, 24 Dec 2019 06:51:41 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191223191928epcas1p128d39bb875b8654d61ae21364e466ec7@epcas1p1.samsung.com>
 <20191223191923.10450-1-tiny.windzz@gmail.com> <7230b556-7a96-14d1-ed22-43b5a6cd5a71@samsung.com>
In-Reply-To: <7230b556-7a96-14d1-ed22-43b5a6cd5a71@samsung.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 24 Dec 2019 22:51:30 +0800
Message-ID: <CAEExFWs6Wtg9dJbx9nwq4F53Lc5e__rzRn0QedJt2ffJTKU3uA@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: exynos-bus: Add error log when get event fails
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 24, 2019 at 12:00 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi,
>
> I think that you better to use 'devfreq-event' instead of just 'event'
> as following:
>
> PM / devfreq: exynos-bus: Add error log when fail to get devfreq-event
>
> On 12/24/19 4:19 AM, Yangtao Li wrote:
> > Adding an error log makes it easier to trace the function's error path.
> > Because the error code may be rewritten on return, print error code here.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/devfreq/exynos-bus.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> > index 948e9340f91c..634d63fd00ea 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -126,6 +126,8 @@ static int exynos_bus_get_dev_status(struct device *dev,
> >
> >       ret = exynos_bus_get_event(bus, &edata);
> >       if (ret < 0) {
> > +             dev_err(dev, "failed to get event from devfreq-event devices %d\n",
> > +                     ret);

Emmm, it looks a bit strange to me...
V2 has been sent.

Yours,
Yangtao


>
> Better to make it under 80 char as following:
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index f5d4c369c7fb..10f4fa1a0363 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -126,7 +126,8 @@ static int exynos_bus_get_dev_status(struct device *dev,
>
>         ret = exynos_bus_get_event(bus, &edata);
>         if (ret < 0) {
> -               dev_err(dev, "failed to get event from devfreq-event devices %d\n",
> +               dev_err(dev,
> +                       "failed to get event from devfreq-event devices %d\n",
>                         ret);
>                 stat->total_time = stat->busy_time = 0;
>                 goto err;
>
>
> >               stat->total_time = stat->busy_time = 0;
> >               goto err;
> >       }
> >
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
