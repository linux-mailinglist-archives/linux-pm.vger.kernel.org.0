Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD12240296
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 09:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgHJHcc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 03:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHJHc1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2020 03:32:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6988C061786
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 00:32:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t10so3987837ejs.8
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2XNfznpF0pdfJM5rxFFMyVk437Nb/j/jzg4c3V8/ik=;
        b=M2n+2g4nU2Y3nIArM6ULS5YENJO3Z4OVsd5mbmciZh6sHt0G+RMGHFMJBlNpbn0Uwm
         CmHjIOJIsHbSh3e9WWN3KNPe6otPvE+M7luJU9dlhKtLCwbQLfpIfkEze+t8qpcBLkC/
         AXA/19ebFe3j0Fmk1PCFmgPZm1hCz1T8Vsa5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2XNfznpF0pdfJM5rxFFMyVk437Nb/j/jzg4c3V8/ik=;
        b=Ip/O4QX66PCYZj7LYpHldl5LqcAYuV+r0/Qmsj+JuKpuKvSjQPxDy8hIVyTnF6SOds
         sSYyjHAIn5gm+WJsrj5OsZEm670SaPgiV9/6VFAosfo5cv9B49PauKKB6c/OS/v4s10E
         9pdGAwraOXyWYB10mV6ouCmiO6sl0TpPg4aOsP0nthKvqNHD76GYyLkPbFq8UUlaunCE
         0z+/M5e+zs464qdhT5ybpVXpeyeY6bkuP/3ZtlKp/85qh9BTbKQq1sVoRNq18H2mk7aW
         D++HXxNuWzava+c8WyxZcpsQS4QqKlGiPLHWVQiMPz0T4OAFjGZWihIbgxkWYJkhxg3s
         N0YQ==
X-Gm-Message-State: AOAM531uj97tuKOwdXcupAHeQF7XHTyN0vM2Ff7B28m5+eBC6rAwJbnR
        HamX4aa1H0IIBY7l+M+Yr7atf6t23t+Qm8WuBjuEQA==
X-Google-Smtp-Source: ABdhPJxiNV7gdV622cBg3T83hmJVpfH+8SXzgYz58cBvm7DjsF6gJWAgRCPO7C7dcpZwEzN0qBE+V7z6lLAD4MPIBok=
X-Received: by 2002:a17:906:824d:: with SMTP id f13mr16052303ejx.190.1597044745597;
 Mon, 10 Aug 2020 00:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200810070159.662863-1-ikjn@chromium.org>
In-Reply-To: <20200810070159.662863-1-ikjn@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 10 Aug 2020 15:32:14 +0800
Message-ID: <CANMq1KC=yL=tqxOWPEygB55ROE3Vs6uaJ1m7HuS9tEASj61tvQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: sbs-battery: don't assume i2c errors as
 battery disconnect
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 10, 2020 at 3:02 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Current sbs-battery considers all smbus errors as diconnection events
> when battery-detect pin isn't supplied, and restored to present state back
> on any successful transaction were made.
>
> This can leads to unlimited state changes between present and !present
> when one unsupported command was requested and other following commands
> were successful, e.g. udev rules tries to read multiple properties.
>
> This patch checks battery presence by reading well-known register to
> check battery existence.
>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
>  drivers/power/supply/sbs-battery.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 73461321eb05..483f814385a3 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -875,10 +875,17 @@ static int sbs_get_property(struct power_supply *psy,
>                 return -EINVAL;
>         }
>
> -       if (!chip->gpio_detect &&
> -               chip->is_present != (ret >= 0)) {
> -               sbs_update_presence(chip, (ret >= 0));
> -               power_supply_changed(chip->power_supply);
> +       if (!chip->gpio_detect && chip->is_present != (ret >=0)) {
> +               bool old_present = chip->is_present;
> +               union power_supply_propval val;
> +
> +               ret = sbs_get_battery_presence_and_health(
> +                               client, POWER_SUPPLY_PROP_PRESENT, &val);
> +
> +               sbs_update_presence(chip, !ret && !!(val.intval));

No need for the !!: !ret && val.intval .

> +
> +               if (old_present != chip->is_present)
> +                       power_supply_changed(chip->power_supply);
>         }
>
>  done:
> @@ -1063,11 +1070,11 @@ static int sbs_probe(struct i2c_client *client)
>          * to the battery.
>          */
>         if (!(force_load || chip->gpio_detect)) {
> -               rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> -
> -               if (rc < 0) {
> -                       dev_err(&client->dev, "%s: Failed to get device status\n",
> -                               __func__);
> +               union power_supply_propval val;
> +               rc = sbs_get_battery_presence_and_health(
> +                               client, POWER_SUPPLY_PROP_PRESENT, &val);
> +               if (rc < 0 || !val.intval) {
> +                       dev_err(&client->dev, "Failed to get present status\n");
>                         goto exit_psupply;

sbs_get_battery_presence_and_health also reads
sbs_data[REG_STATUS].addr. That's good.

However, with psp == POWER_SUPPLY_PROP_PRESENT,
sbs_get_battery_presence_and_health always returns 0, but sets
val.intval = 0 in case of error.

This means that you goto exit_psupply with rc == 0, and sbs_probe does not fail.

I wonder if you should just drop this change, and use
sbs_read_word_data(client, sbs_data[REG_STATUS].addr); above, too.

>                 }
>         }
> --
> 2.28.0.236.gb10cc79966-goog
>
