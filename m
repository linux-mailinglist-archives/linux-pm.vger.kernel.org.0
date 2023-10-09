Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E625C7BE1CA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Oct 2023 15:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377555AbjJINyW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 9 Oct 2023 09:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377659AbjJINyK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2023 09:54:10 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C391;
        Mon,  9 Oct 2023 06:54:07 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6c4c40ca4f4so424557a34.0;
        Mon, 09 Oct 2023 06:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696859646; x=1697464446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tr0Ks+DzpCxj2Tm5X8RhGp9w9ypX3KRdOtOpwoJiGjc=;
        b=CH9wo4Okm35EP2ZIibm+LRUjll1w6vMlD6czBHK6v1P1P6AJKGKkdgPWZhoFP8W3eA
         Y1K68DgcATNtJsbrvuEHBhXirFqzH9CZTKQAHzJ8EYG2iIXBiyqUzuTUshpz9EXawoNV
         4uT/TVqKG1wnw1P/9fo/R50wZZG2zOi4cpgyX/yxIFVpOT3rTrtsHfeCvqP4kq276XcC
         H5xoGDHZ4sLJxlJ1laPEplPPcbXiNgFPq7qsH2bB7ltK2byHp8k2wForYjZMy4vXi1pc
         +WGHpSX77viPOSVVpm3omSinB5SusRuIUKoLxxLyJnw2t14+aLas/4TCHDtH4L/D30d0
         9nrQ==
X-Gm-Message-State: AOJu0YywWQLSdJNVx+OzWbCD0NO/Hf5DX4R7k10XptRXKr/1C2U9hIpe
        sQ9d48gHOMN+90rQWCIAymuhB4QtqWhzAmhSAbFO1RFT
X-Google-Smtp-Source: AGHT+IE9Rwip+TGOvl+gCaBsaQyvpRsKiROcw1KB4xANYuzHZvexXqgz5D1FfrnpNxVuH2aTgbILb7LAbYIO8ego840=
X-Received: by 2002:a4a:c509:0:b0:57e:c9bf:696e with SMTP id
 i9-20020a4ac509000000b0057ec9bf696emr13507256ooq.1.1696859646687; Mon, 09 Oct
 2023 06:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <514ef814-458d-4421-b93d-2d30bdc4a1e7@moroto.mountain>
In-Reply-To: <514ef814-458d-4421-b93d-2d30bdc4a1e7@moroto.mountain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Oct 2023 15:53:55 +0200
Message-ID: <CAJZ5v0j83GHpmWhQPPJG6Xrv9ryy0tKEzcX=nbM0K71arpAwog@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: prevent potential string overflow
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Sujith <sujith.thomas@intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 7, 2023 at 10:59 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The dev->id value comes from ida_alloc() so it's a number between zero
> and INT_MAX.  If it's too high then these sprintf()s will overflow.
>
> Fixes: 203d3d4aa482 ("the generic thermal sysfs driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 45d0aa0b69b7..61f0b5a3b00c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -681,7 +681,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
>         if (result)
>                 goto release_ida;
>
> -       sprintf(dev->attr_name, "cdev%d_trip_point", dev->id);
> +       snprintf(dev->attr_name, sizeof(dev->attr_name), "cdev%d_trip_point",
> +                dev->id);
>         sysfs_attr_init(&dev->attr.attr);
>         dev->attr.attr.name = dev->attr_name;
>         dev->attr.attr.mode = 0444;
> @@ -690,7 +691,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
>         if (result)
>                 goto remove_symbol_link;
>
> -       sprintf(dev->weight_attr_name, "cdev%d_weight", dev->id);
> +       snprintf(dev->weight_attr_name, sizeof(dev->weight_attr_name),
> +                "cdev%d_weight", dev->id);
>         sysfs_attr_init(&dev->weight_attr.attr);
>         dev->weight_attr.attr.name = dev->weight_attr_name;
>         dev->weight_attr.attr.mode = S_IWUSR | S_IRUGO;
> --

Applied as 6.7 material, thanks!
