Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2CB2E040
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 16:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfE2OzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 10:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfE2OzB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 10:55:01 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2C223B19;
        Wed, 29 May 2019 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559141701;
        bh=LRmVdjDfCx+iRHnx/tteucrVD9i835WHaCbePlhLWRk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BSnkMURPbHIQyJR6xI3csCIcpEyI0H7IYzYtgDBn9Zs52KbmvZSHYvU0wJ4MwwgVl
         uthsUtmAVKB7sMufy5GCCjXTz3eD+EN60IwwLDKqltxU1IdlHKuPpnRYT7Y8w51ezP
         XULafr/o3P7VESNxjkWLx5VHCWjq+yOKyqBbUCoQ=
Received: by mail-lj1-f180.google.com with SMTP id y15so331554ljd.9;
        Wed, 29 May 2019 07:55:00 -0700 (PDT)
X-Gm-Message-State: APjAAAUV5GVAPpvxs0hsFzui9y3UyGDnst1t1vjKuzu2ZGKf2+UeKo6V
        yeU+QpfJGQiWkTfdRIBz7q94V63131VY0Hu4peQ=
X-Google-Smtp-Source: APXvYqxLCHSTSKRtNMOeK3w1Vw8PySGLMX5dD0AObBoh6u42Fc0i9Za2sWvtQXUMhZOw5+Z47zy+mzrPzD2fvtbbbaU=
X-Received: by 2002:a2e:9a9a:: with SMTP id p26mr4207037lji.64.1559141698364;
 Wed, 29 May 2019 07:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br> <20190527022258.32748-5-matheus@castello.eng.br>
In-Reply-To: <20190527022258.32748-5-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 May 2019 16:54:47 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcFPwBJ26V2rOS7t5H221B0H-MsDmC4Xb7gGHRX_ETxtQ@mail.gmail.com>
Message-ID: <CAJKOXPcFPwBJ26V2rOS7t5H221B0H-MsDmC4Xb7gGHRX_ETxtQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] power: supply: max17040: Clear ALRT bit when the
 SOC are above threshold
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 May 2019 at 04:45, Matheus Castello <matheus@castello.eng.br> wrote:
>
> In order to not generate duplicate interrupts we clear the ALRT bit when
> the SOC is in a state that shows that the battery is charged above the set
> threshold for the SOC low level alert.

I think interrupt/alert bit should be cleared while handling
interrupt, not later because:
1. It is logical to clear it when servicing it,
2. It is simpler - no need for "chip->alert_bit",
3. The alert threshold is understood as alert/warning so every
interrupt should generate uevent. I understand you wanted to remove
"duplicate interrupts" but in fact there are no duplicates. Every next
interrupt comes from change of SoC while being below the critical
level. Therefore on each such change user-space should be woken up and
notified (e.g. to show the message to the user).

I also think this should be squashed with previous patch as it does
not make sense as standalone commit.

>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 2f4851608cfe..61e6fcfea8a1 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -48,6 +48,7 @@ struct max17040_chip {
>         int status;
>         /* Low alert threshold from 32% to 1% of the State of Charge */
>         u32 low_soc_alert_threshold;
> +       int alert_bit;
>  };
>
>  static int max17040_get_property(struct power_supply *psy,
> @@ -107,6 +108,7 @@ static void max17040_reset(struct i2c_client *client)
>  static int max17040_set_low_soc_threshold_alert(struct i2c_client *client,
>         u32 level)
>  {
> +       struct max17040_chip *chip = i2c_get_clientdata(client);
>         int ret;
>         u16 data;
>
> @@ -118,6 +120,7 @@ static int max17040_set_low_soc_threshold_alert(struct i2c_client *client,
>                 data &= MAX17040_ATHD_MASK;
>                 data |= level;
>                 max17040_write_reg(client, MAX17040_RCOMP, data);
> +               chip->alert_bit = 0;
>                 ret = 0;
>         } else {
>                 ret = -EINVAL;
> @@ -144,6 +147,11 @@ static void max17040_get_soc(struct i2c_client *client)
>         soc = max17040_read_reg(client, MAX17040_SOC);
>
>         chip->soc = (soc >> 8);
> +
> +       /* check SOC level to clear ALRT bit */
> +       if (chip->soc > chip->low_soc_alert_threshold && chip->alert_bit)
> +               max17040_set_low_soc_threshold_alert(client,
> +                       chip->low_soc_alert_threshold);
>  }
>
>  static void max17040_get_version(struct i2c_client *client)
> @@ -229,6 +237,9 @@ static irqreturn_t max17040_thread_handler(int id, void *dev)
>         /* send uevent */
>         power_supply_changed(chip->battery);
>
> +       /* ALRT bit is seted */

s/seted/set/

Best regards,
Krzysztof

> +       chip->alert_bit = 1;
> +
>         return IRQ_HANDLED;
>  }
>
> --
> 2.20.1
>
