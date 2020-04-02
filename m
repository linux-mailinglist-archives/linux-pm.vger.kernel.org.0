Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF819BF91
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 12:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbgDBKoU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 06:44:20 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34822 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbgDBKoT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 06:44:19 -0400
Received: by mail-vs1-f67.google.com with SMTP id u11so1977955vsg.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 03:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gL8fHfqHi6qcFCDBXj+QaMk/V5SGiyp+PEgt7ceo9WU=;
        b=Z8sTzIds8P65a8Efr/HpR7f/sFnL78fv7JdRdCYFOMTUD3xEgpbcAeWrl/PsfvaOhf
         KWJQgfBnJchQZT0JuK+Pt4w31Wwk94i9Yy3p9BV6eyd4ALSNMq7kH0crycw1vaWHJVKE
         JA/UbrOVw9lLXjW1BQSufi1WHrRsy5CeLaHUZ364nmIaUcD2NYY9BhIWxSwrHbaVg5JY
         6lokynAKlh1fFhkF2EquMQ+uKxt0bB9JuALqSN+InrOtgffiqSSm+/VgLt7nboHRbVLn
         JzXPRrpqfV0t4jTvQY6T/Gc07hbvcKmteIgtW1ZykMjpBg1rJmRijAxhxZjy6dv52jjw
         Bp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gL8fHfqHi6qcFCDBXj+QaMk/V5SGiyp+PEgt7ceo9WU=;
        b=Z1dY3i8PMKUC74E+CkvjEKdT1usakxgm/lxunjaiDBY0z1AmunE6lav+By6OQzaGu5
         sAEmcXzM/g6lkD8imoAcIkt18LViq7/13e8JGcv+b2U26IWP6Z3y0HVPzXH8QiQBdXjX
         CaevgOjylQ+LbSN5G8po7JYAk30IDFlYTkgE8yNqCcL9KnC0PSYlo1D5Xs8C4hJ2CaBR
         8MEoUMALgEIRgiVKRFzk9u4nYNkMYxny0MTU92os/HXHPWqoIMxJKc/g/aKdOOOp5lwc
         FaQVLnL8qbUcwq45zfYEoVCmO15XQwa1lRnMjecdoPPASq8AhNYEZkQiztA0S0y9Im3F
         bskw==
X-Gm-Message-State: AGi0PuaABrn6CMWPZWnwcL7b7PNRZxITn/ReFlx6hzhVnxkfuh53/lhK
        lNiixU+wRVONpaCUPt7Mkd4p/cufGrUZYmzykJMj4rWo8/rmUQ==
X-Google-Smtp-Source: APiQypKz4BReUDIMGlqUgHLZ6zPYqg56f8V7z9tHS+iJNEZZVkZB/6k3hDtCI0DWnf55+ITwD1Gdb2k5UQXU0UMW3qw=
X-Received: by 2002:a05:6102:104b:: with SMTP id h11mr1714887vsq.182.1585824256368;
 Thu, 02 Apr 2020 03:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <1585192411-25593-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1585192411-25593-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 2 Apr 2020 16:14:05 +0530
Message-ID: <CAHLCerOZvYT71gcZd7_NpWKon6LSH9kcA1UK1objTc9aK4nOvA@mail.gmail.com>
Subject: Re: [PATCH] thermal: imx_sc_thermal: Add hwmon support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 26, 2020 at 8:50 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Expose i.MX SC thermal sensors as HWMON devices.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/imx_sc_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> index a8723b1..b2b68c9 100644
> --- a/drivers/thermal/imx_sc_thermal.c
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -14,6 +14,7 @@
>  #include <linux/thermal.h>
>
>  #include "thermal_core.h"
> +#include "thermal_hwmon.h"
>
>  #define IMX_SC_MISC_FUNC_GET_TEMP      13
>
> @@ -115,6 +116,9 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
>                         ret = PTR_ERR(sensor->tzd);
>                         break;
>                 }
> +
> +               if (devm_thermal_add_hwmon_sysfs(sensor->tzd))
> +                       dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
>         }
>
>         of_node_put(sensor_np);
> --
> 2.7.4
>
