Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A82422B22
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 16:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhJEOi0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 10:38:26 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:37721 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhJEOi0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 10:38:26 -0400
Received: by mail-oi1-f170.google.com with SMTP id w206so26494884oiw.4;
        Tue, 05 Oct 2021 07:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o00KyEWco01TxEwUad/z3+tPtEbuVbgl1TjuLeOWTEc=;
        b=cty5ds51cJJPznQu9I4M/OXEJarrSlvfmxcuzuOrIxbjeyX73MyIgqAX0RbO/idd9s
         M95vnX8lP9TaFjoCwhmIXLIEykgnlHzxdIPfAhtEZOqROMfB5yr7yJmdICae0f5U0Xgl
         xgpciNeyoFjH4ZOsWVaynwGlhXZIaGwRc1bRmwzZPU21nfKcDMbxDW/Flx+zQ1h5pGm7
         DZaJ9Oi+dL3LDe9r0roUxNd+kVF2Gt5/y+gXnT2siD41K04PBavEE3nN+J90IYjZ9ppr
         KfQtlK78cy0/4IbAP4dTUh4Btmnk5AVCwc3sJXKw9ZpXrYXO1g6pNgpg6QNvLzQfpV6E
         dt5Q==
X-Gm-Message-State: AOAM533YbZQj88K1p4yQUxh/NcgpGslzZZYbj5JBJ3H4gSnPjSg7+jMD
        LUTUfdAv9mEz22wIqVEphYz+LXHlLEm2TRQDbFM+VvTO
X-Google-Smtp-Source: ABdhPJxmUGMzQy4xaQJ4D/xcXxOXnvsl5XECKNhmq04hZZl4UcsycnbNHlsnnLY+S9MrIwuSYtExY4Bml9oda3xKH0c=
X-Received: by 2002:a05:6808:178c:: with SMTP id bg12mr2934456oib.157.1633444595315;
 Tue, 05 Oct 2021 07:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210920203849.32136-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20210920203849.32136-1-rikard.falkeborn@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 16:36:24 +0200
Message-ID: <CAJZ5v0jrXbuyQez1rX7-9CEjazTFp32SSH60Tx5Oqf+D2Czv5Q@mail.gmail.com>
Subject: Re: [PATCH] thermal: thermal_mmio: Constify static struct thermal_mmio_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Talel Shenhar <talel@amazon.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 21, 2021 at 3:55 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> The only usage of thermal_mmio_ops is to pass its address to
> devm_thermal_zone_of_sensor_register(), which has a pointer to const
> struct thermal_zone_of_device_ops as argument. Make it const to allow
> the compiler to put it in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/thermal/thermal_mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
> index ded1dd0d4ef7..360b0dfdc3b0 100644
> --- a/drivers/thermal/thermal_mmio.c
> +++ b/drivers/thermal/thermal_mmio.c
> @@ -34,7 +34,7 @@ static int thermal_mmio_get_temperature(void *private, int *temp)
>         return 0;
>  }
>
> -static struct thermal_zone_of_device_ops thermal_mmio_ops = {
> +static const struct thermal_zone_of_device_ops thermal_mmio_ops = {
>         .get_temp = thermal_mmio_get_temperature,
>  };
>
> --

I'm not sure what happened to this patch.

Daniel, are you going to pick it up?
