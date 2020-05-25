Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948741E0C84
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 13:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgEYLJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 07:09:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45209 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbgEYLJL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2020 07:09:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id c3so13518843otr.12;
        Mon, 25 May 2020 04:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SB0wil5McK190NuQj9OZqwjEId4UBlaUoJWnHA0mJ7Y=;
        b=tJZkYuy/83pyaG94T2GyhpZfTr/essjsHtK6rPaZ9eS87JXvjzDUfCRI98tA6odFCt
         F5wCr6J1rqLutKnPeqSq/kFDD8c0MXxPUZU1MGiI3PoCiYXQXlRLym/NmbuuVQ9lU92B
         ovGkXCounnw910c0l7JpSqZGPGvMLYlVCLJe2YUdbJfyfz5MBze7cChTHyxplDg70qxy
         nhmOO0oX2wJ+NkvbCGleXFSYnZP9jpoiVrpQFDHA/wyd9zldOloFGAvrG2Dx7BV64PZu
         m23VWjPGoaSHLecrCWHncjpPETYZ1rv1JhahvWQ45nAXBAKXkei5XS7tgWWnh90rAgH+
         bPRg==
X-Gm-Message-State: AOAM531OZ9Vr3Ux9zUNMuOUfkz4BQ+kTvmf693TrdcXkhOhs8/GZBFgC
        ouiXp5Nva4V/yuuYwfW3OEwyVdSOUyDXXJ5r12EAOA==
X-Google-Smtp-Source: ABdhPJzrnyOd62zbBJsrbKsaVS2KQXryawISoD+ng7KNkAatkOYfv5p1N8glpoiD0mjKlyRE6+1P7B4oWAeXdua48Ps=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr1428590otf.167.1590404950954;
 Mon, 25 May 2020 04:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200525110540.6949-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200525110540.6949-1-dinghao.liu@zju.edu.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 May 2020 13:09:00 +0200
Message-ID: <CAJZ5v0j7cy1qZ5q3jWjJ77zJrVp+Kt2-4sWN3KF0jBgV9FOQew@mail.gmail.com>
Subject: Re: [PATCH] [v2] power: supply: bq24190_charger: Fix runtime PM
 imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Sebastian Reichel <sre@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 25, 2020 at 1:05 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> pm_runtime_get_sync() increments the runtime PM usage counter even
> it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Better now:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
> Changelog:
>
> v2: - Use pm_runtime_put_noidle() rather than
>       pm_runtime_put_autosuspend().
> ---
>  drivers/power/supply/bq24190_charger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 453d6332d43a..7b24c41a2137 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -481,8 +481,10 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
>                 return ret;
>
>         ret = pm_runtime_get_sync(bdi->dev);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               pm_runtime_put_noidle(bdi->dev);
>                 return ret;
> +       }
>
>         ret = bq24190_write_mask(bdi, info->reg, info->mask, info->shift, v);
>         if (ret)
> --
> 2.17.1
>
