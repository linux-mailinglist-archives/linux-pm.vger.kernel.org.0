Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90159777A1B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjHJOF6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 10:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHJOF6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 10:05:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADE02127
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 07:05:57 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58451f0fefeso11928677b3.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691676357; x=1692281157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+7nZNjACq4zelmmNOIi1tmKjrktIDsZZOWRsPuPUgrM=;
        b=jPoe6aGXfC9hwSEWShxvCx66g96q5MzAa/h0Ikw5tsH6kef4ab6plUuJ95YoLkAMW4
         l/Jpw8/I2tUGWMIsM6TQDzD8KWXs+JN/oo8U7dc54EBx7eonTEPkU1gGnI1R6Xk2if7p
         yRhoaVW+wXPW7IlqFG5UhOXHkcpdkoSvc2sA1py10z7YmjZPsqIBjiFRA6U59cpM0HRL
         zA9FR/OY5BHjE0LX065fdFlvXbHcI/URQOIjEBVlwtgK8zlwhrldbErqwmgaxni7FMyn
         mtAujqPv6UM1swzfywsB9yBpQsBFwO2AUcnuSJUvyuGxubaVa0bbtLj8GCZ556gOzsL+
         kz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691676357; x=1692281157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7nZNjACq4zelmmNOIi1tmKjrktIDsZZOWRsPuPUgrM=;
        b=mDpOwv/UDWt/0eylhzr3EzYmtI8NrmuwOTnC5eYBZ8WTuNzPLOClQTcv5lxr8AlxWY
         VgHBjaFg/rjlGkf38ii6x+fP82n2elmx+gfsUSTPjYql3uGSMVb0/IUtZTADnx1Ad60D
         OSv5fwUhfPFD+5Ky+QsvPRL1QxdnSmDrrKRAGUOGmvagwgybzd+wwxU9l/U7Y4iy7Xgi
         bJE3iFLc7rx56LLQGrKgJB0F/gvVlHZ9+PlMdNnmGe60+SGQbyZZeFwyzGVTCx4++H3c
         /fWtSXT3fabAeY8D5fwBHs7u/oIAqvlkT6WoWUC3Q51l7RubyOINXha8ZqRcBrBWwbYZ
         mK5Q==
X-Gm-Message-State: AOJu0YwHC33gqvf09hD9vMkiWzG6vJYrP3HKA8uVAD0P95wHlVG64Zu2
        FazvtE/Mpdi6LIrjXqxlHn775TfEdof7Sr1+PWnFnQ==
X-Google-Smtp-Source: AGHT+IF62TSSqm3FV2vUQQBhb9axY+mcDAPlIhxx1XGnPVHUFRmEZKQYJQI+CNdKl4V95xvxzalllyPD365Z7Q4lpnE=
X-Received: by 2002:a25:d1d0:0:b0:d09:a5e8:8692 with SMTP id
 i199-20020a25d1d0000000b00d09a5e88692mr2829688ybg.45.1691676356837; Thu, 10
 Aug 2023 07:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230731064746.2717684-1-peng.fan@oss.nxp.com> <20230731064746.2717684-5-peng.fan@oss.nxp.com>
In-Reply-To: <20230731064746.2717684-5-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 10 Aug 2023 16:05:20 +0200
Message-ID: <CAPDyKFqC2=4iv-NfdY1A0oB-1eORJaG9F=T+Q6xCdQX7RH6j+g@mail.gmail.com>
Subject: Re: [PATCH V3 4/8] genpd: imx: scu-pd: do not power off console if no_console_suspend
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 31 Jul 2023 at 08:43, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Do not power off console if no_console_suspend

Perhaps extend this a bit to let the reader understand this is about
leaving the serial device's corresponding PM domain on.

>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

A comment below - that doesn't need to stop this from being applied though.

> ---
>  drivers/genpd/imx/scu-pd.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
> index 08583a10ac62..d69da79d3130 100644
> --- a/drivers/genpd/imx/scu-pd.c
> +++ b/drivers/genpd/imx/scu-pd.c
> @@ -52,6 +52,7 @@
>   */
>
>  #include <dt-bindings/firmware/imx/rsrc.h>
> +#include <linux/console.h>
>  #include <linux/firmware/imx/sci.h>
>  #include <linux/firmware/imx/svc/rm.h>
>  #include <linux/io.h>
> @@ -324,6 +325,10 @@ static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
>         msg.resource = pd->rsrc;
>         msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : IMX_SC_PM_PW_MODE_LP;
>
> +       /* keep uart console power on for no_console_suspend */
> +       if (imx_con_rsrc == pd->rsrc && !console_suspend_enabled && !power_on)

As I indicated above, I don't mind this, but I also think this is a
rather generic problem that you are trying to solve here.

In principle, I think it should be the serial driver's responsibility
to check the console_suspend_enabled flag. Based upon that, it should
inform upper layers (genpd) that its device may need to stay powered
on during system suspend. Quite similar to how we deal with system
wakeups. To make this work we could do the following instead of
$subject patch.

1. The serial driver should call device_set_wakeup_path() (the name of
that function is a bit confusing in this regard, but let's discuss
that separately) in its ->suspend() callback.
2. Set the GENPD_FLAG_ACTIVE_WAKEUP (again the name is a bit confusing
in this regard) for the corresponding genpd provider.

In this way, genpd will keep the PM domain powered on during system suspend.

> +               return -EBUSY;
> +
>         ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
>         if (ret)
>                 dev_err(&domain->dev, "failed to power %s resource %d ret %d\n",
> --
> 2.37.1
>

Kind regards
Uffe
