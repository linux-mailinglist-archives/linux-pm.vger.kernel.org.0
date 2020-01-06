Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BCF130CC8
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 05:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgAFEcI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 23:32:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45334 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgAFEcI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 23:32:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id v28so46352212edw.12;
        Sun, 05 Jan 2020 20:32:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMDutFxXoe3ZkyaegKexXIdDhONjUtjuJvY6xSY/yc8=;
        b=WL5GzdehY53YY3faQhGnYSEkmL4ADln3WlFgnvNwSXkshB4an+9R5batUjOXKWUSSQ
         exBDaJsGop3jVLWxSZ8oBLgS4BPLVL+2kyWV+7nC4CjznCruCJ08X7lhMX9Ne1j2agrC
         ZHZbHpakWy0WYD7hKmnNslYEJl2yPZvLfGGEhGUbphDAWRJyGoijgZdkuoPwuohm2pGz
         /H6e25ub+m8KAdxtFaDsi950Bb9wpL8O5xOKtZtqhKrLnyycLCGMwNT2PWx2qNr5rWj4
         SydJ5IjETKHtD+KZursDU7auIsXHgL2JlWHJCPoWzj6RDenCnbsXmzCHTZdBlXW1hfnX
         FFjQ==
X-Gm-Message-State: APjAAAW7pfcxK9RIaBAaMVpYLPoSNAWYycOx2PqF3URc+g+Pyd0EQv9i
        euIJAoaqHIMwa5sQF4C04VxhG0cBmKI=
X-Google-Smtp-Source: APXvYqyFc9hrz1FKSCTolUkHf/GfC+DQ2v30cgKvp73ML+AV6cxgMbki+X4tp3pQS36uSkonnEYDtw==
X-Received: by 2002:a17:906:cc8b:: with SMTP id oq11mr107808909ejb.193.1578285125946;
        Sun, 05 Jan 2020 20:32:05 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id u2sm7334173edx.35.2020.01.05.20.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 20:32:05 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id z7so48164626wrl.13;
        Sun, 05 Jan 2020 20:32:05 -0800 (PST)
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr102285473wrp.142.1578285125179;
 Sun, 05 Jan 2020 20:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20191228171904.24618-1-tiny.windzz@gmail.com>
In-Reply-To: <20191228171904.24618-1-tiny.windzz@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 6 Jan 2020 12:31:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v67YPLy_qFuLKKMFytPEdFRUazoNfsQ1tYj8z3WVSRqC3Q@mail.gmail.com>
Message-ID: <CAGb2v67YPLy_qFuLKKMFytPEdFRUazoNfsQ1tYj8z3WVSRqC3Q@mail.gmail.com>
Subject: Re: [PATCH] thermal: sun8i: Add hwmon support
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 29, 2019 at 1:19 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Expose sun8i thermal as a HWMON device.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 23a5f4aa4be4..619e75cb41b0 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -20,6 +20,8 @@
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>
> +#include "thermal_hwmon.h"
> +
>  #define MAX_SENSOR_NUM 4
>
>  #define FT_TEMP_MASK                           GENMASK(11, 0)
> @@ -477,6 +479,10 @@ static int sun8i_ths_register(struct ths_device *tmdev)
>                                                              &ths_ops);
>                 if (IS_ERR(tmdev->sensor[i].tzd))
>                         return PTR_ERR(tmdev->sensor[i].tzd);
> +
> +               if (devm_thermal_add_hwmon_sysfs(tmdev->sensor[i].tzd))
> +                       dev_warn(tmdev->dev,
> +                                "Failed to add hwmon sysfs attributes\n");

Maybe you want a hard failure instead?

ChenYu

>         }
>
>         return 0;
> --
> 2.17.1
>
