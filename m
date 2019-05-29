Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224762E067
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfE2PAV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 11:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfE2PAU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 11:00:20 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2FC23B6B;
        Wed, 29 May 2019 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559142019;
        bh=bYiranAi895/NjKUTPX6vKqk8K7WSCczMh8oc0zU6X0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JipIPQ6Pcr9drnwT2YhTdXdIY32GOe68LiMkl3Cov3na5JFk9BHYoT/BIpADt0o/6
         Y0CTxVDEYqCg/SREpRAn8AC5G47k/ZODCQAU3cxONpINB9DbNUIiXBj5NivM0B1TwH
         hG4+5f9xsXXVE1QcveQIGOxzSE6SlTXXA5dRyJMI=
Received: by mail-lj1-f174.google.com with SMTP id q62so2792587ljq.7;
        Wed, 29 May 2019 08:00:19 -0700 (PDT)
X-Gm-Message-State: APjAAAWbAiikIrDZmvYzYJHArGmoJRHiLJFmJqHQ1D4kIeDC0NLegeSf
        SfE/bBJGDlMjz0sv5y55J3iBKNVu4NVa3g9S7+o=
X-Google-Smtp-Source: APXvYqwjLMuAJjajnkiA9vjKloiYF6lUhLhDlQgaGfMY8Rd6UXQclDmRa8DBOLTFrlK3GW69/ObI1iLSbgT31JBZO+s=
X-Received: by 2002:a2e:9601:: with SMTP id v1mr22273608ljh.60.1559142017603;
 Wed, 29 May 2019 08:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br> <20190527022258.32748-6-matheus@castello.eng.br>
In-Reply-To: <20190527022258.32748-6-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 May 2019 17:00:06 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
Message-ID: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] power: supply: max17040: Send uevent in SOC and
 status change
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

On Mon, 27 May 2019 at 04:23, Matheus Castello <matheus@castello.eng.br> wrote:
>
> Notify core through power_supply_changed() in case of changes in state
> of charge and power supply status. This is useful for user-space to
> efficiently update current battery level.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 61e6fcfea8a1..34278845cfe5 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -176,6 +176,9 @@ static void max17040_get_online(struct i2c_client *client)
>  static void max17040_get_status(struct i2c_client *client)
>  {
>         struct max17040_chip *chip = i2c_get_clientdata(client);
> +       int last_status;
> +
> +       last_status = chip->status;
>
>         if (!chip->pdata || !chip->pdata->charger_online
>                         || !chip->pdata->charger_enable) {
> @@ -194,6 +197,9 @@ static void max17040_get_status(struct i2c_client *client)
>
>         if (chip->soc > MAX17040_BATTERY_FULL)
>                 chip->status = POWER_SUPPLY_STATUS_FULL;
> +
> +       if (last_status != chip->status)
> +               power_supply_changed(chip->battery);

Why splitting it from max17040_work()? It seems logical to check soc
and status at the same time.

Best regards,
Krzysztof

>  }
>
>  static void max17040_get_of_data(struct max17040_chip *chip)
> @@ -217,10 +223,18 @@ static void max17040_check_changes(struct i2c_client *client)
>  static void max17040_work(struct work_struct *work)
>  {
>         struct max17040_chip *chip;
> +       int last_soc;
>
>         chip = container_of(work, struct max17040_chip, work.work);
> +
> +       /* store SOC for check change */
> +       last_soc = chip->soc;
>         max17040_check_changes(chip->client);
>
> +       /* check changes and send uevent */
> +       if (chip->soc >= 0 && last_soc != chip->soc)
> +               power_supply_changed(chip->battery);
> +
>         queue_delayed_work(system_power_efficient_wq, &chip->work,
>                            MAX17040_DELAY);
>  }
> --
> 2.20.1
>
