Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4563D6119CA
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 20:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiJ1SBP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJ1SBM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 14:01:12 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E762DBBC7;
        Fri, 28 Oct 2022 11:01:11 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id f22so3956966qto.3;
        Fri, 28 Oct 2022 11:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4MYfNUMplw8XEwkEObwKgGyaRaVzrUz7GmdYkwRcHA=;
        b=zdfTwP6sczAAchWajWwoCb2gK87LXGibTCxWboyfa02ox7+OoDfZmk04YVq0FFF0TO
         CfxKyybsEOb8MElkDSrS7NVQAEXTeNYfBlFESM1XuamVgzGSFR5hGoiLKi1ozzGCRgN8
         +AQvwMa212urbD81oKC95LcUPkFYufnmocL0L5LoNBiPI/7CPCdHuUDTC1AvN00JU9J5
         mbBQGxOhiIYsO6gh77t37aYanXeHS0j0gqazmWGpQ3Ex+vu4A1VEc3RpiBsMK4M0pmrZ
         lJnXUuwdy52cKmSm7+D9VimkP6h2ajDkIW3gXjiKY62S+V/sHl993pJLvehfPa11F9oa
         MafA==
X-Gm-Message-State: ACrzQf0fP1Qv+qeBvhdpkCLPe8qIJzcJkJvHmD7mWRQxu8o8pngbS75v
        9rpayCmaYLy+FYUb92hEg2ZCN5M1QN5T2ysVWz8=
X-Google-Smtp-Source: AMsMyM7M0IiO5os6xQvnXwubPo2UCoPUkOsDXDODyyF/jS74if3ZD8On+VrJuTRYGFgMDVsJviRmM1wDjMXt8xPtYgg=
X-Received: by 2002:a05:622a:44d:b0:39c:f7a4:5ee0 with SMTP id
 o13-20020a05622a044d00b0039cf7a45ee0mr661842qtx.48.1666980070744; Fri, 28 Oct
 2022 11:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <Y1vvCrOMne0XNORj@kili>
In-Reply-To: <Y1vvCrOMne0XNORj@kili>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 20:00:59 +0200
Message-ID: <CAJZ5v0iORq8Fx4jXyzj1kag-SEL82odiaPyJODOEPgA2vinkOA@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: fix error code in __thermal_cooling_device_register()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 28, 2022 at 5:02 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Return an error pointer if ->get_max_state() fails.  The current code
> returns NULL which will cause an oops in the callers.
>
> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/thermal/thermal_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 4ba7b524e5de..c4d18e462de8 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -892,7 +892,8 @@ __thermal_cooling_device_register(struct device_node *np,
>         cdev->device.class = &thermal_class;
>         cdev->devdata = devdata;
>
> -       if (cdev->ops->get_max_state(cdev, &cdev->max_state))
> +       ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
> +       if (ret)
>                 goto out_kfree_type;
>
>         thermal_cooling_device_setup_sysfs(cdev);
> --

Applied, thanks!
