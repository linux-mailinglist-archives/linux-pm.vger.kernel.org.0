Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2BD7797A0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 21:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjHKTSw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 11 Aug 2023 15:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjHKTSv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 15:18:51 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFE92709;
        Fri, 11 Aug 2023 12:18:51 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-56d26137095so370150eaf.1;
        Fri, 11 Aug 2023 12:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691781531; x=1692386331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyTF5NgYb8GTCLi6gpcp9i9P/ufgxXkVq7a1/z7YV5g=;
        b=QoQW5sRuUgL01dnb8ChiJcr7RJn0N9n75BCipiTPpqwjWVeyAlQtuViSOTmIQ3cTf7
         7A4Kke/2a3kzzyeh4iNNh98RfPvTK04JqOQGFpEFSJUIuIbrYoUV2KgqLhCI3ZX/V/Ce
         r9SPo0wM0LBDU+u3Rp9kB8ic2/SA3VExa1qLaHZ0xDfN4dpCNudyIjLS3MfDltF3uuuQ
         czaJOKi5LJLDq9KmIZ+QxMBCr/ilCx6HakAaCREi2mL2apQXLepQ0BQHCaZffLMMKXOz
         2xXpcb+lrJ0Z9lEehK9XxxsyXoVy1WUbtkx2KyBCOBXJ9Lt/iKrr5nLewZKiAYxrUb6R
         C2+g==
X-Gm-Message-State: AOJu0Yyki/BcXva8CyJhLez5S11dxzCMLcYHu5gyrYeF/0mFbzyZFxCg
        wqOwpr9VlzJZeqssih0T4bx17CtPSaDt875j7KgeoLKP
X-Google-Smtp-Source: AGHT+IFRUoYMKTpyUiA0wxMpAiHOModCyNfbW9NdMHU/GXgJUj820mik8xPWHE5qFw8J56v4Sybc7Y0XrVHm3dNZYfw=
X-Received: by 2002:a05:6820:136:b0:56d:72dc:5410 with SMTP id
 i22-20020a056820013600b0056d72dc5410mr2079960ood.1.1691781530668; Fri, 11 Aug
 2023 12:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230809112348.2302384-1-boris.brezillon@collabora.com>
In-Reply-To: <20230809112348.2302384-1-boris.brezillon@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 21:18:39 +0200
Message-ID: <CAJZ5v0jZ8By3Mz_JM6O79p0af4GaRBXE4PgiCHVOuHWcf=UQsA@mail.gmail.com>
Subject: Re: [PATCH] thermal/of: Fix a leak in thermal_of_zone_register()
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 9, 2023 at 1:23 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> thermal_zone_device_register_with_trips() copies the tzp info. After
> calling this function, we should free the tzp object, otherwise it's
> leaked.
>
> Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Hasn't this been fixed in -rc5?

> ---
>  drivers/thermal/thermal_of.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 6fb14e521197..e74ef4fa576b 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -524,10 +524,17 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>         tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
>                                                      mask, data, of_ops, tzp,
>                                                      pdelay, delay);
> +
> +       /*
> +        * thermal_zone_device_register_with_trips() copies the tzp info.
> +        * We don't need it after that point.
> +        */
> +       kfree(tzp);
> +
>         if (IS_ERR(tz)) {
>                 ret = PTR_ERR(tz);
>                 pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
> -               goto out_kfree_tzp;
> +               goto out_kfree_trips;
>         }
>
>         ret = thermal_zone_device_enable(tz);
> @@ -540,8 +547,6 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>
>         return tz;
>
> -out_kfree_tzp:
> -       kfree(tzp);
>  out_kfree_trips:
>         kfree(trips);
>  out_kfree_of_ops:
> --
> 2.41.0
>
