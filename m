Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3768FD11E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 23:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKNWuU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 17:50:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36979 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKNWuT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 17:50:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id z24so4725448pgu.4
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 14:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=fV40oETXjKcGlIr1gGKnzSoiYzzgILYSSWxjfebyNP8=;
        b=IQttiHaAJGKACK5iLQHgc60JB1JPMzLpLI1DfqpXl7axGbV2ULuY8eJUGc9Qoado47
         UGVaSRRH1bnSNoxedmuguxdiav53vPa3kaEGVLaAQ3wkPsnqskxDHoBu+bPY/30ZD8PK
         nr9n7pQ3Ltf+Jy66JShXkhoWL328ExLRzYYu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=fV40oETXjKcGlIr1gGKnzSoiYzzgILYSSWxjfebyNP8=;
        b=NarnFv2BjoRhAfzhq7lu+iaDJk2STAmDVM4jhx0PZ7t2jHHXvbAZrdTnE3DkwKACB6
         /39OTfI5roVvHN84dhllEK46158Nf5xWq8nJFqIXiG76oRB55Ui3u31MM/1XtJGkwP9i
         P/QOz6RJvzGJ0m0mM84D9u9E5/VifKrtCJO57B5xqZW7HWY8nFT8jHwgmfXL054hZ/A0
         4v1m/g+vtQw3gxOopIXW6aXZfWi4+ggiW4sezHuabftCMuKv2VaEHBguPcD/zNQCCu5w
         Lki6bnvay4VN5RIyuBNseXerJmFZZjGYVXZ6JNFn7aL5kGEd35KYqPnc9RX/SNG7zP45
         YRog==
X-Gm-Message-State: APjAAAUD8RlbNjpaIUvj31VY72FMDS1RVWAy0VyERH6gJgfj9MtHLvei
        Q2yLH+HjP3PkD67N59q64W4S1g==
X-Google-Smtp-Source: APXvYqwGZF0CNHJX1S5Aa2rAAxaMTnHOr5W0JJN8PB1EeZukU4bqr9Ehf1A2qoVMQcXBra2LOY9T8Q==
X-Received: by 2002:a17:90b:d8e:: with SMTP id bg14mr14990905pjb.26.1573771818995;
        Thu, 14 Nov 2019 14:50:18 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u207sm9215633pfc.127.2019.11.14.14.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 14:50:18 -0800 (PST)
Message-ID: <5dcdda2a.1c69fb81.27852.ac35@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4b949a4f401a7f9d403ed0f0c16c7feb083f3524.1573499020.git.amit.kucheria@linaro.org>
References: <cover.1573499020.git.amit.kucheria@linaro.org> <4b949a4f401a7f9d403ed0f0c16c7feb083f3524.1573499020.git.amit.kucheria@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        edubezval@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Subject: Re: [PATCH 1/3] drivers: thermal: tsens: Add critical interrupt support
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 14 Nov 2019 14:50:17 -0800
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-11-11 11:21:27)
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/t=
sens-common.c
> index 4359a4247ac3..2989cb952cdb 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -321,6 +357,65 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, en=
um tsens_ver ver)
>         return 0;
>  }
> =20
> +/**
> + * tsens_critical_irq_thread - Threaded interrupt handler for critical i=
nterrupts
> + * @irq: irq number
> + * @data: tsens controller private data
> + *
> + * Check all sensors to find ones that violated their critical threshold=
 limits.
> + * Clear and then re-enable the interrupt.
> + *
> + * The level-triggered interrupt might deassert if the temperature retur=
ned to
> + * within the threshold limits by the time the handler got scheduled. We
> + * consider the irq to have been handled in that case.
> + *
> + * Return: IRQ_HANDLED
> + */
> +irqreturn_t tsens_critical_irq_thread(int irq, void *data)
> +{
> +       struct tsens_priv *priv =3D data;
> +       struct tsens_irq_data d;
> +       bool enable =3D true, disable =3D false;

Why not just use true and false in the one place these variables are
used?

> +       unsigned long flags;
> +       int temp, ret, i;
> +
> +       for (i =3D 0; i < priv->num_sensors; i++) {
> +               struct tsens_sensor *s =3D &priv->sensor[i];

Maybe make this const?

> +               u32 hw_id =3D s->hw_id;
> +
> +               if (IS_ERR(priv->sensor[i].tzd))

IS_ERR(s->tzd)?

> +                       continue;
> +               if (!tsens_threshold_violated(priv, hw_id, &d))
> +                       continue;
> +               ret =3D get_temp_tsens_valid(s, &temp);

Can this accept a const 's'?

> +               if (ret) {
> +                       dev_err(priv->dev, "[%u] %s: error reading sensor=
\n", hw_id, __func__);
> +                       continue;
> +               }
> +
> +               spin_lock_irqsave(&priv->ul_lock, flags);
> +
> +               tsens_read_irq_state(priv, hw_id, s, &d);
> +
> +               if (d.crit_viol &&
> +                   !masked_irq(hw_id, d.crit_irq_mask, tsens_version(pri=
v))) {
> +                       tsens_set_interrupt(priv, hw_id, CRITICAL, disabl=
e);
> +                       if (d.crit_thresh > temp) {
> +                               dev_dbg(priv->dev, "[%u] %s: re-arm upper=
\n",
> +                                       priv->sensor[i].hw_id, __func__);

hw_id instead of priv->sensor...?

> +                       } else {
> +                               dev_dbg(priv->dev, "[%u] %s: TZ update tr=
igger (%d mC)\n",
> +                                       hw_id, __func__, temp);
> +                       }
> +                       tsens_set_interrupt(priv, hw_id, CRITICAL, enable=
);
> +               }
> +
> +               spin_unlock_irqrestore(&priv->crit_lock, flags);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
>  /**
>   * tsens_irq_thread - Threaded interrupt handler for uplow interrupts
>   * @irq: irq number
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 7d317660211e..784c4976c4f9 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -121,6 +121,27 @@ static int tsens_register(struct tsens_priv *priv)
> =20
>         enable_irq_wake(irq);
> =20
> +       if (tsens_version(priv) > VER_1_X) {
> +               irq =3D platform_get_irq_byname(pdev, "critical");
> +               if (irq < 0) {
> +                       ret =3D irq;
> +                       goto err_put_device;
> +               }
> +
> +               ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> +                                               NULL, tsens_critical_irq_=
thread,
> +                                               IRQF_TRIGGER_HIGH | IRQF_=
ONESHOT,
> +                                               dev_name(&pdev->dev), pri=
v);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "%s: failed to get critical i=
rq\n", __func__);
> +                       goto err_put_device;

Do we need to disable_irq_wake() for the previous irq here?

> +               }
> +
> +               enable_irq_wake(irq);
> +       }
> +
> +       return 0;
> +
>  err_put_device:
>         put_device(&pdev->dev);
>         return ret;
