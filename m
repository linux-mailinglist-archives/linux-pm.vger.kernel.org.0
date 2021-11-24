Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB51045C9FF
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 17:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhKXQbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 11:31:33 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33501 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhKXQbc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 11:31:32 -0500
Received: by mail-oi1-f173.google.com with SMTP id q25so6518525oiw.0;
        Wed, 24 Nov 2021 08:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBEAh6TF3eaWQopmxjQ0UJdDXHvFAPQQfgLZKQTVie4=;
        b=2ok5m8E5dHB66Dzj6edItHDkSUUHh/TS02QJWU4r9eAsTXambOEEOa+8r+aHu3ETlW
         ZX3AblJm6jtuDAcO3LBatAzoe/uHpHQoA4hC9umpsWXV0Qcl2lS7yxXPoBs+kkcVx6uD
         fUx+OwOcEAthQyEV9ulTW3CgVhVt8p30HeDPaZwpswuhraaIrwT4hCT1cbZq4S3o32UL
         pfklL+tgJbd3znn3crvciq6NkbmZaRwzxYPZj0ucjBF5ZHG/+L0zOzCWOwqfO3qd/8gI
         WalgR8iYqRJPi5auwKM4LF3xmlcMLw0Ixoqfg9OZb7+uveX+ajggB+78gcjxPUSDHiac
         nSWg==
X-Gm-Message-State: AOAM530FxoihdB1qNosCLfUuG7s5pbb4CcrutDLl1XlNLJbGuFJvLtGy
        QsP8R9NbimsjYOIdGugDnQn8Uvaj+IwYcMP/ZsE=
X-Google-Smtp-Source: ABdhPJw3lBx/1RQvn+Plm4HnYLdVYnQB1LXy/ZTQmx43D4+q1Bt4K9MBRHRXR5On1zrilsMNpnozdt4rza8o4dDdvq8=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr7374685oil.166.1637771302689;
 Wed, 24 Nov 2021 08:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20211112090946.9026-1-ran.jianping@zte.com.cn>
In-Reply-To: <20211112090946.9026-1-ran.jianping@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 17:28:11 +0100
Message-ID: <CAJZ5v0i1mrj6gzsKxFoEhJLq-9_E+JupwcC2q7jyqVp8EFOVTg@mail.gmail.com>
Subject: Re: [PATCH] tools/thermal: remove unneeded variable
To:     cgel.zte@gmail.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>, ran.jianping@zte.com.cn,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 12, 2021 at 10:09 AM <cgel.zte@gmail.com> wrote:
>
> From: ran jianping <ran.jianping@zte.com.cn>
>
> Fix the following coccicheck review:
> /tools/thermal/tmon/pid.c:57:5-8: Unneeded variable
>
> Remove unneeded variable used to store return value.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
> ---
>  tools/thermal/tmon/pid.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/thermal/tmon/pid.c b/tools/thermal/tmon/pid.c
> index c54edb4f630c..296f69c00c57 100644
> --- a/tools/thermal/tmon/pid.c
> +++ b/tools/thermal/tmon/pid.c
> @@ -54,7 +54,6 @@ static double xk_1, xk_2; /* input temperature x[k-#] */
>   */
>  int init_thermal_controller(void)
>  {
> -       int ret = 0;
>
>         /* init pid params */
>         p_param.ts = ticktime;
> @@ -65,7 +64,7 @@ int init_thermal_controller(void)
>
>         p_param.t_target = target_temp_user;
>
> -       return ret;
> +       return 0;
>  }
>
>  void controller_reset(void)
> --

Applied as 5.17 material, thanks!
