Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9428499CB7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jan 2022 23:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579929AbiAXWHS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jan 2022 17:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456129AbiAXVhw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jan 2022 16:37:52 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198CDC0BD133
        for <linux-pm@vger.kernel.org>; Mon, 24 Jan 2022 12:24:11 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id y23so9072244oia.13
        for <linux-pm@vger.kernel.org>; Mon, 24 Jan 2022 12:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=w3ynFKV1fLntHunSKUJ/uGzn1fGWIgjZmU7aBt47Qlo=;
        b=i5o1/vEQIKJw1sMvH0GGqP/BOyX0hMhqYlSabek/jvvjhnl8Dd6qOmKf048VgTNIgL
         W+mER+ik7PnWfOA5TdWVnoOWd4HDBmu0KUMfwo0rA7EBo6NDHZyxLLU1Jba6TlactXU8
         TTOqJa0YtytYB5OBMJs5XhZLcXQZy6D+ZObjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=w3ynFKV1fLntHunSKUJ/uGzn1fGWIgjZmU7aBt47Qlo=;
        b=TPGOrby4ZgR3a8s2EMulVsLP/JS9/pQ7vpkcQjYgLPuGPfcJ5tJ4vWbnc5vUJT8KfJ
         bfjh3phG4jKE0Jppk0wyC3OBOyXlPJPs/9uaUw8Gww2FfDZS4r5UeuBOOOWbwitrWRmU
         3I5bgq3aMJO4EJNUxHw/yndC4w9UdDahzF2shm+1G2CJhep2z3gDzrFU5mpfxd8fJvwG
         VS0pgSYcF5h6cmLQ+ZnvCDn/ysrfZpun2e8jc42CeTArQE7HMENyKwo+fUindpqOzEf5
         x7jI6YUunq3gY3frDahCZcyGkYm0+cIT5GNOHV725HPIumu8ipete8/NEygS9Sir/6JJ
         RX/w==
X-Gm-Message-State: AOAM531bhCkAXvQ92i74aY3qeZQruClNpu3vzKd5IxyqtHVMWdelOXpa
        uLUQ3A16VDHkGQ8zXQ5MSz8PMtFQIYLWLY1NDc7bNQ==
X-Google-Smtp-Source: ABdhPJwJr+L9TLQ5U3Eh5OUnJaPwt9T0uy8XOGbvauiD6g+ZvjuWnHO+tGF2uwCLg7VOfdaAHF1gbUWcJoGO76mVM7Y=
X-Received: by 2002:aca:aa0f:: with SMTP id t15mr2917122oie.32.1643055850425;
 Mon, 24 Jan 2022 12:24:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Jan 2022 12:24:10 -0800
MIME-Version: 1.0
In-Reply-To: <20220124011143.684348-1-dnojiri@chromium.org>
References: <20220124010348.681893-1-dnojiri@chromium.org> <20220124011143.684348-1-dnojiri@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 24 Jan 2022 12:24:09 -0800
Message-ID: <CAE-0n528Mw8mCLTL9GAiaYBXxTbTBUi_f_OfeFPo_gmDpBGqXg@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: PCHG: Use MKBP for device event handling
To:     Daisuke Nojiri <dnojiri@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Daisuke Nojiri (2022-01-23 17:11:40)
> This patch makes the PCHG driver receive device events through

$ git grep "This patch" -- Documentation/process

i.e. don't use "This patch"

> MKBP protocol since CrOS EC switched to deliver all peripheral
> charge events to the MKBP protocol. This will unify PCHG event
> handling on X86 and ARM.
>
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---

Just some nitpicks

> diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
> index 305f10dfc06d1b..cb402f48087ddf 100644
> --- a/drivers/power/supply/cros_peripheral_charger.c
> +++ b/drivers/power/supply/cros_peripheral_charger.c
> @@ -237,46 +238,22 @@ static int cros_pchg_event(const struct charger_data *charger,
>         return NOTIFY_OK;
>  }
>
> -static u32 cros_get_device_event(const struct charger_data *charger)
> -{
> -       struct ec_params_device_event req;
> -       struct ec_response_device_event rsp;
> -       struct device *dev = charger->dev;
> -       int ret;
> -
> -       req.param = EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS;
> -       ret = cros_pchg_ec_command(charger, 0, EC_CMD_DEVICE_EVENT,
> -                                  &req, sizeof(req), &rsp, sizeof(rsp));
> -       if (ret < 0) {
> -               dev_warn(dev, "Unable to get device events (err:%d)\n", ret);
> -               return 0;
> -       }
> -
> -       return rsp.event_mask;
> -}
> -
>  static int cros_ec_notify(struct notifier_block *nb,
>                           unsigned long queued_during_suspend,
>                           void *data)
>  {
>         struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;

Not a problem in this patch but the cast can be dropped.

> -       u32 host_event = cros_ec_get_host_event(ec_dev);
>         struct charger_data *charger =
>                         container_of(nb, struct charger_data, notifier);
> -       u32 device_event_mask;
> +       u32 host_event;
>
> -       if (!host_event)
> +       if (ec_dev->event_data.event_type != EC_MKBP_EVENT_PCHG
> +                       || ec_dev->event_size != sizeof(host_event))

Does checkpatch complain here? Preferably it's written as

       if (ec_dev->event_data.event_type != EC_MKBP_EVENT_PCHG ||
           ec_dev->event_size != sizeof(host_event))

>                 return NOTIFY_DONE;
>
> -       if (!(host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_DEVICE)))
> -               return NOTIFY_DONE;
> +       host_event = get_unaligned_le32(&ec_dev->event_data.data.host_event);
>
> -       /*
> -        * todo: Retrieve device event mask in common place
> -        * (e.g. cros_ec_proto.c).
> -        */
> -       device_event_mask = cros_get_device_event(charger);
> -       if (!(device_event_mask & EC_DEVICE_EVENT_MASK(EC_DEVICE_EVENT_WLC)))
> +       if (!(host_event & EC_MKBP_PCHG_DEVICE_EVENT))
>                 return NOTIFY_DONE;
>
>         return cros_pchg_event(charger, host_event);
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 271bd87bff0a25..c784bed3388865 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -3386,6 +3386,9 @@ enum ec_mkbp_event {
>         /* Send an incoming CEC message to the AP */
>         EC_MKBP_EVENT_CEC_MESSAGE = 9,
>
> +       /* Peripheral device charger event */
> +       EC_MKBP_EVENT_PCHG = 12,
> +
>         /* Number of MKBP events */
>         EC_MKBP_EVENT_COUNT,
>  };
> @@ -5527,6 +5530,67 @@ enum pchg_state {
>         [PCHG_STATE_CONNECTED] = "CONNECTED", \
>         }
>
> +/**

Please use only one '*', i.e. '/*' so that this doesn't trip up
kernel-doc generation that looks for two stars.

> + * Update firmware of peripheral chip
> + */
> +#define EC_CMD_PCHG_UPDATE 0x0136
