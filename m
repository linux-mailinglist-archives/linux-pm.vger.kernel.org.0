Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737A73B87D5
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhF3RoB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 13:44:01 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40782 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhF3RoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 13:44:01 -0400
Received: by mail-ot1-f43.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so3535506otk.7;
        Wed, 30 Jun 2021 10:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WuoWABrkilomkOA5uB95Bfp7IioH6BpIGGeWdbIgIzE=;
        b=WzzXCUx0RpQ8iwzaqeTR+ME8b1QmkTO+61R67JTfPb0jQZr7+ZpTGrWTk6v+Q2ici7
         oSoz3b/R7Oxs/2ydKZiT0hI9VEvF4nY6fYlLxdEonfSs2xQfE7zKSxFzS/z7410eKvwZ
         j3pRbYvEPjK2QnBOS6pOuno5ayNQ6F7g/o5FdYgycQh9P/kJjxMR5+H0Ws3xEVeRmYE7
         wE1DyFDg8jDpZZuNUPq0ncuveZwQmckbHbMCtE14R3sBGoBZZygoQ4zArVF3ExA6F7Ac
         9wDNRqzkU7dsRYNY0N1swZLOgihPa5HEe8taffPLnEdiCUEEqfxViDnVuNlHC1B4bNZf
         erqA==
X-Gm-Message-State: AOAM5329YmIOn0X2QYTGKVyfPOn4iCnQTkKr9hrWePuU538sDG6DuxXn
        H3dHlU0EkU10yJia10SpsFnbNd1mWGzKha7HqD8z5y71
X-Google-Smtp-Source: ABdhPJxNcVyWVlpPEYsRHXT4kE9Adn2eAGiw5uJ3MGDwUdILM7IzPFy4Lwat9pHW6IU+Ld0yyq+k0MloSd6s8FBsQ1s=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr10055713otm.260.1625074891758;
 Wed, 30 Jun 2021 10:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210624084403.1163-1-wjc@cdjrlc.com>
In-Reply-To: <20210624084403.1163-1-wjc@cdjrlc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 19:41:21 +0200
Message-ID: <CAJZ5v0h9Nx-u0U5O1hp1-BzzKXMVd3UO5BuGH6oc95aXQeu=ag@mail.gmail.com>
Subject: Re: [PATCH] powercap: Replace symbolic permissions with octal permissions
To:     Jinchao Wang <wjc@cdjrlc.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 24, 2021 at 10:44 AM Jinchao Wang <wjc@cdjrlc.com> wrote:
>
> Resolve following checkpatch issue,
> Replace symbolic permissions with octal permissions

I don't see much value in this replacement and checkpatch complaining
about the existing code base is not something to worry about in
general.

> Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
> ---
>  drivers/powercap/powercap_sys.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> index f0654a932b37..e706548c59bb 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -223,46 +223,46 @@ static int seed_constraint_attributes(void)
>
>         for (i = 0; i < MAX_CONSTRAINTS_PER_ZONE; ++i) {
>                 ret = create_constraint_attribute(i, "power_limit_uw",
> -                                       S_IWUSR | S_IRUGO,
> +                                       0644,
>                                         &constraint_attrs[i].power_limit_attr,
>                                         show_constraint_power_limit_uw,
>                                         store_constraint_power_limit_uw);
>                 if (ret)
>                         goto err_alloc;
>                 ret = create_constraint_attribute(i, "time_window_us",
> -                                       S_IWUSR | S_IRUGO,
> +                                       0644,
>                                         &constraint_attrs[i].time_window_attr,
>                                         show_constraint_time_window_us,
>                                         store_constraint_time_window_us);
>                 if (ret)
>                         goto err_alloc;
> -               ret = create_constraint_attribute(i, "name", S_IRUGO,
> +               ret = create_constraint_attribute(i, "name", 0444,
>                                 &constraint_attrs[i].name_attr,
>                                 show_constraint_name,
>                                 NULL);
>                 if (ret)
>                         goto err_alloc;
> -               ret = create_constraint_attribute(i, "max_power_uw", S_IRUGO,
> +               ret = create_constraint_attribute(i, "max_power_uw", 0444,
>                                 &constraint_attrs[i].max_power_attr,
>                                 show_constraint_max_power_uw,
>                                 NULL);
>                 if (ret)
>                         goto err_alloc;
> -               ret = create_constraint_attribute(i, "min_power_uw", S_IRUGO,
> +               ret = create_constraint_attribute(i, "min_power_uw", 0444,
>                                 &constraint_attrs[i].min_power_attr,
>                                 show_constraint_min_power_uw,
>                                 NULL);
>                 if (ret)
>                         goto err_alloc;
>                 ret = create_constraint_attribute(i, "max_time_window_us",
> -                               S_IRUGO,
> +                               0444,
>                                 &constraint_attrs[i].max_time_window_attr,
>                                 show_constraint_max_time_window_us,
>                                 NULL);
>                 if (ret)
>                         goto err_alloc;
>                 ret = create_constraint_attribute(i, "min_time_window_us",
> -                               S_IRUGO,
> +                               0444,
>                                 &constraint_attrs[i].min_time_window_attr,
>                                 show_constraint_min_time_window_us,
>                                 NULL);
> @@ -366,9 +366,9 @@ static void create_power_zone_common_attributes(
>                                         &dev_attr_max_energy_range_uj.attr;
>         if (power_zone->ops->get_energy_uj) {
>                 if (power_zone->ops->reset_energy_uj)
> -                       dev_attr_energy_uj.attr.mode = S_IWUSR | S_IRUSR;
> +                       dev_attr_energy_uj.attr.mode = 0600;
>                 else
> -                       dev_attr_energy_uj.attr.mode = S_IRUSR;
> +                       dev_attr_energy_uj.attr.mode = 0400;
>                 power_zone->zone_dev_attrs[count++] =
>                                         &dev_attr_energy_uj.attr;
>         }
> --
> 2.31.1
>
>
>
