Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACE81E0BDC
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389784AbgEYKeI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 06:34:08 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:40903 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389781AbgEYKeI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2020 06:34:08 -0400
Received: by mail-oo1-f65.google.com with SMTP id f39so177043ooi.7;
        Mon, 25 May 2020 03:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjMPWMCD4/ms3xeffCL8OqWKsyazuZCpK4C7dZThzLM=;
        b=nEkqjuIykSBKGe+RHXBkooG+ga/2OXGbnRJRC7fRx/a8BqBBUKZNdkCI6tdnjMbWHK
         f8Iuz23d+m3c0nu7yDyN1fZeozcWodHu5g8h5ha3W4JSMAk2Bfyi4bSy76N73jMiZhIo
         Wfj2SdW1Yt0B0g5Ix6ZB0BjvJbEdFpDGn8N/RGE+5BQyJhJaXznOI7Z/QD0mI+Qklk0Q
         u/MFXXBpwf+KUKw5kR5j9P+0eipROLmaFaHO6wTdKzLVhTo5IVIZlX+rFwG9ApnPvE10
         fsTJwUDHR25jEkecRxy3g8aq+HY8e0rh+fbCmWjmwIdvO1CKK9Dn61FtU+VrvNrpZAKT
         wvRg==
X-Gm-Message-State: AOAM531rtMndD7z9soqDKaK+IRIveDM4dd0rZKUIlaApcBKzRZsOHwlt
        qUtUav1UORLaKXkk6uZesIYbDUYnFaJxq/Ena244Z2nH
X-Google-Smtp-Source: ABdhPJzFEaaABlZi0ZZ8/w6NAJuysnEm/zE41Tzt7tOtIyxUChOExPgjQOSAL/A60gxyCB3PPxBiUKhCCSwd2CsVGJE=
X-Received: by 2002:a4a:e759:: with SMTP id n25mr12553301oov.75.1590402846269;
 Mon, 25 May 2020 03:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200520074309.19366-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200520074309.19366-1-dinghao.liu@zju.edu.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 May 2020 12:33:49 +0200
Message-ID: <CAJZ5v0j5XB_me9YSUemUaz6URair4CtRVSU1U6F62FWCi2SRJg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: bq24190_charger: fix runtime pm imbalance
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Sebastian Reichel <sre@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 10:01 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> pm_runtime_get_sync() increments the runtime PM usage counter even
> it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/power/supply/bq24190_charger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 453d6332d43a..4f7c6b6abb56 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -481,8 +481,10 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
>                 return ret;
>
>         ret = pm_runtime_get_sync(bdi->dev);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               pm_runtime_put_autosuspend(bdi->dev);

The autosuspend thing is not necessary here, because the suspend is
not going to work anyway due to the resume error, so this can be
_put_noidle().

You might as well do something like

count = ret;
goto out;

here and add an "out" label before the pm_runtime_mark_last_busy() call, though.

>                 return ret;
> +       }
>
>         ret = bq24190_write_mask(bdi, info->reg, info->mask, info->shift, v);
>         if (ret)
> --
> 2.17.1
>
