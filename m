Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56928639014
	for <lists+linux-pm@lfdr.de>; Fri, 25 Nov 2022 19:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKYSxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Nov 2022 13:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKYSxt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2022 13:53:49 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF3B1E70E
        for <linux-pm@vger.kernel.org>; Fri, 25 Nov 2022 10:53:48 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id s4so3010864qtx.6
        for <linux-pm@vger.kernel.org>; Fri, 25 Nov 2022 10:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waofd/HhZeM/9AMqKYY+jJg95QbN2Vuyvpq7CibLBg8=;
        b=z+WIQ22YUSOu1bDygen4GiGeJYK3sTb0ks3qHKo+4gZqNzScnvWvLL5+ZJ8PQ7YXmH
         4dyf7yV6lF1BP/9A9z5uaEgRFtXhl/kv840WhjIEfagU96OqWB3lRqjuQiEcJ2ZHDQ6A
         ok2A3+cxozryysmllJdBOBLzDF/OqPMLpdbXjp3eH+eC1+SIE7cmgl+86QSt6XujAMiM
         PESCo4r9LwUwJh8/GJfBDttr17gIYRj/QR0ozeIODhLCs88/NLOQ9iR6+a+liXojrdDY
         hCgOgHjlA8kpRkV+y+duhNnxU3BIbBQHYo9PZ5UtO+SKzu9KFFArCJx4TiUfw4j8rq1T
         0qRg==
X-Gm-Message-State: ANoB5pmk1O6mx0u51dGsmB1xE7J3W2dplxwlQckA30G4CfL8hiSiA59Y
        dUR0Rliw2ZG2/DA+x3gN48wNVtzFI72ZaSti8KNu1doS
X-Google-Smtp-Source: AA0mqf6MTC46cemetGP3lQvrpz29y2baO+dGHXhn2qUDWdjZeipRsP4jDXfk9ydHanibnaGOYF3ccGvnkdijZjkv11U=
X-Received: by 2002:ac8:60d3:0:b0:3a5:4678:5b24 with SMTP id
 i19-20020ac860d3000000b003a546785b24mr36697799qtm.411.1669402428002; Fri, 25
 Nov 2022 10:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20221115091945.921469-1-yangyingliang@huawei.com>
In-Reply-To: <20221115091945.921469-1-yangyingliang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Nov 2022 19:53:36 +0100
Message-ID: <CAJZ5v0i_FZ8ABUede18vup4+OXiix5xHaGN_+2Nxttc-mn3tMA@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: fix some possible name leaks in error paths
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        songyuanzheng@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 15, 2022 at 10:21 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
>
> In some error paths before device_register(), the names allocated
> by dev_set_name() are not freed. Move dev_set_name() front to
> device_register(), so the name can be freed while calling
> put_device().
>
> Fixes: 1dd7128b839f ("thermal/core: Fix null pointer dereference in thermal_release()")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/thermal/thermal_core.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 117eeaf7dd24..46c7adf0a1fc 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -883,10 +883,6 @@ __thermal_cooling_device_register(struct device_node *np,
>         cdev->id = ret;
>         id = ret;
>
> -       ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> -       if (ret)
> -               goto out_ida_remove;
> -
>         cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
>         if (!cdev->type) {
>                 ret = -ENOMEM;
> @@ -901,6 +897,11 @@ __thermal_cooling_device_register(struct device_node *np,
>         cdev->device.class = &thermal_class;
>         cdev->devdata = devdata;
>         thermal_cooling_device_setup_sysfs(cdev);
> +       ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> +       if (ret) {
> +               thermal_cooling_device_destroy_sysfs(cdev);
> +               goto out_ida_remove;
> +       }
>         ret = device_register(&cdev->device);
>         if (ret)
>                 goto out_kfree_type;
> @@ -1234,10 +1235,6 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>         tz->id = id;
>         strscpy(tz->type, type, sizeof(tz->type));
>
> -       result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
> -       if (result)
> -               goto remove_id;
> -
>         if (!ops->critical)
>                 ops->critical = thermal_zone_device_critical;
>
> @@ -1260,6 +1257,11 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>         /* A new thermal zone needs to be updated anyway. */
>         atomic_set(&tz->need_update, 1);
>
> +       result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
> +       if (result) {
> +               thermal_zone_destroy_device_groups(tz);
> +               goto remove_id;
> +       }
>         result = device_register(&tz->device);
>         if (result)
>                 goto release_device;
> --

Applied as 6.2 material, but please note that I had to rebase it, so
please check the result in my bleeding-edge branch.
