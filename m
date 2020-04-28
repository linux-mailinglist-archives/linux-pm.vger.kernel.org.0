Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5CD1BCD61
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 22:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgD1U3f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 16:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbgD1U3e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 16:29:34 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F022C03C1AC
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 13:29:32 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id y10so22893076uao.8
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 13:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pkj7kKKcclLvASvEGyrCI/6i5twP0NxxYNk+RIVUFp8=;
        b=Z4mcO0+46Tgu18zZ1ILlmbNz2QscI6HGOLUt2jq9eozqAy5T/bsUTxE9llCisBgdq+
         5Q8HDvyffxiry0/gYfAQjrpVLASdlCL8cJWR9DtHuywPHkbpv5UlZ7yrx0huAeHh3ftC
         4ppmcha4ZlkJHkdZntWl60jDD3kul+Qv5BesDKBCWQHLpYdPWOGZbK9Ck4YLgF+4xU2c
         d0smJ1hXHK4q7+TZ834uhiMqXPmGT0UvC8BiFmH9I+C3VwMeqV7fKbPcteAB4h4nFgNG
         6bGKK1FofR25GczJ3bsbw+Ftw4WKY9bo2sNOtpPjsp6BLPQ1DoW/twAvS9ae2K1NG1TM
         zXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pkj7kKKcclLvASvEGyrCI/6i5twP0NxxYNk+RIVUFp8=;
        b=fg3VeYS/2wGKGjHLxwiwL/1ybTPpgIfJd+lDlvSPYH4ONuarra6o4PCiTqoWuqBzzG
         Z5NZE+wUu/kMwBNBeVk/iBQ9pOAPsnUKc++hPZQwd8p/CcSmso4Ckn/peFcYQjMEo/Jl
         qJzjoH+1T+686tjON0uoFGVSC/eEFLAEgd3XJGRNwCFdJqIXhUoOhkGRfHWWI407wsBF
         Q4Hh2hDodvEo4N19zYgwg92m6pe58ANcQc3/raqCxSFkrEOQVNyNhjGXoI/8Cc4R3pyZ
         qENFVCqvvKHujZp4DsevYNFiPJ0yQEjqhqe18oZT10QRumQAnQ0nI3OwjompQT59AwSl
         FClw==
X-Gm-Message-State: AGi0Pua9snxH/jE9ugDtEaTZC7D8U2c+tzJj6YSB1hEVbRxlI/UYNf6i
        DIo7k8sxOLVRIdjlHBcO7H1QqAAO2lq7KtEPlYvVLg==
X-Google-Smtp-Source: APiQypJRtqhFbG7Rpns7Xg65/400D7gj9RtZJmOOrneoEGGX2VN0LUGpUc52NK91FBqKp4r/OAxibEQH/VFYLqZScB4=
X-Received: by 2002:a67:e9d9:: with SMTP id q25mr22043390vso.27.1588105771956;
 Tue, 28 Apr 2020 13:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <1585232945-23368-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1585232945-23368-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 29 Apr 2020 01:58:56 +0530
Message-ID: <CAHLCerP7O19cRsK6OfmGm89K7KefRQnCUdNCNQM8mEAbycUjbg@mail.gmail.com>
Subject: Re: [PATCH V2] thermal: imx: Add missing of_node_put()
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 26, 2020 at 8:06 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> After finishing using cpu node got from of_get_cpu_node(), of_node_put()
> needs to be called.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
>         - improve the logic, no need to use got.
> ---
>  drivers/thermal/imx_thermal.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index e761c9b..1b84ea6 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -649,7 +649,7 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
>  static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>  {
>         struct device_node *np;
> -       int ret;
> +       int ret = 0;
>
>         data->policy = cpufreq_cpu_get(0);
>         if (!data->policy) {
> @@ -664,11 +664,12 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>                 if (IS_ERR(data->cdev)) {
>                         ret = PTR_ERR(data->cdev);
>                         cpufreq_cpu_put(data->policy);

You could move this policy release outside the if block too, no?

> -                       return ret;
>                 }
>         }
>
> -       return 0;
> +       of_node_put(np);
> +
> +       return ret;
>  }
>
>  static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data *data)
> --
> 2.7.4
>
