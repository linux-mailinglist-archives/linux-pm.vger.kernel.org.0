Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436C8433AC3
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 17:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhJSPkM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 11:40:12 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:36817 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhJSPkE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 11:40:04 -0400
Received: by mail-ot1-f50.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so2152154otk.3;
        Tue, 19 Oct 2021 08:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oi0YFzbyDdujFoeaFkytw0IIhvWV9WS3QlKHGlCcx5I=;
        b=VtWwWkxpY89sNjp+651Dk6HLa4AK7ZGu3b9HjJfDibKGWSudtzNg3wqfmlLJ9opzta
         tXLHGJ8PZk6TftK8lTGzrPUHwQ2Ko0+qpsierX5Xd7Jo4OdYuCbCLseDrtJMdyaTOyJe
         EVtFvjir6DFHQIK93x9uT4RALgBICcwjrFU8USPesuvzqlo+wtDZmWdlLB4sw4CL88xU
         JAuKqOR7oKVzmeY7Kel4eqgQFrOAlpoaaCgiTad5aImeb5MfRDoBQVS7EEnoWrHneYfJ
         71EmTo1D66gX6z3svLTwHMa9w2W1WuRxfND1GVNxpoFRRXAD6hcF8J/dopFmiPLlAIYD
         ZSAQ==
X-Gm-Message-State: AOAM532Xuafhzx9TDp3EU4Xhdq/OeCIxWeu7ul9cMQOvKgtMpXXRKAPh
        z8L6XhmbBMqbrL5iRHmWWvsRji4D0aoJr5Quugc=
X-Google-Smtp-Source: ABdhPJxsacgYWHnNskW5xrkGns/5G7PuRvViV0hPsCp9ZyMzOa7CgqDRIh1vkobS3eGAA1JqfJsC+Rev4U5PmMXTDvw=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr5642762otd.16.1634657871328;
 Tue, 19 Oct 2021 08:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211019150203.2805738-1-daniel.lezcano@linaro.org>
In-Reply-To: <20211019150203.2805738-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 17:37:40 +0200
Message-ID: <CAJZ5v0hew_DeWVw80ovz6+q3_zxkHsVeFBwRGqaY2XHw+oPcpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal/core: Make the userspace governor deprecated
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 19, 2021 at 5:02 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The userspace governor is sending temperature when polling is active
> and trip point crossed events. Nothing else.
>
> AFAICT, this governor is used with custom kernels making the userspace
> governor co-existing with another governor on the same thermal zone
> because there was no notification mechanism, implying a hack in the
> framework to support this configuration.
>
> The new netlink thermal notification is able to provide more
> information than the userspace governor and give the opportunity to
> the users of this governor to replace it by a dedicated notification
> framework.
>
> The userspace governor will be removed as its usage is no longer
> needed.
>
> Add a warning message to tell the userspace governor is deprecated.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/thermal/gov_user_space.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
> index 82a7198bbe71..f4fe050e1cbc 100644
> --- a/drivers/thermal/gov_user_space.c
> +++ b/drivers/thermal/gov_user_space.c
> @@ -15,6 +15,14 @@
>
>  #include "thermal_core.h"
>
> +static int user_space_bind(struct thermal_zone_device *tz)
> +{
> +       pr_warn("Userspace governor deprecated: use thermal netlink "   \
> +               "notification instead\n");
> +
> +       return 0;
> +}
> +
>  /**
>   * notify_user_space - Notifies user space about thermal events
>   * @tz: thermal_zone_device
> @@ -43,5 +51,6 @@ static int notify_user_space(struct thermal_zone_device *tz, int trip)
>  static struct thermal_governor thermal_gov_user_space = {
>         .name           = "user_space",
>         .throttle       = notify_user_space,
> +       .bind_to_tz     = user_space_bind,
>  };
>  THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
> --
> 2.25.1
>
