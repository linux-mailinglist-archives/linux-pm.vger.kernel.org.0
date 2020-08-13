Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA6B243399
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 07:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgHMF00 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 01:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHMF0Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 01:26:25 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A85C061383
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 22:26:25 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g11so1306133ual.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 22:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rCJ4q+KoNSXFkFuWqVDiKXpOMoV1SjKATNbbYf89MU=;
        b=nERanXOEelRjMIEt3IHqFWvSp9Zgn371nAANhRijyP8pGdoXeNmNMvcYL3i+6BS4TA
         stwfvcRTCqqq+ULufLYkL7IKvKAxxFD7LFbv98VIKPsP79Oovh7PW5IAa/zuhzrY+IJu
         tm1REjtH6S62Grx3JmA1usq0/EZBDxrsaqIaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rCJ4q+KoNSXFkFuWqVDiKXpOMoV1SjKATNbbYf89MU=;
        b=A8KKJQc9zbve5B1ZHZo0DOHhho+YLpzauKDrderoOhnQc0dj1Z3va0GWsdMcleWwuk
         B0+UinphLbG+j6jijtVu6Q7cJy+3pbuf6trRkEBOSrMi3lm+S5877v/B4pugk5sZ9Mma
         6NKn/NlakRY4Bsv1Q+ptIHM9kI5XNmNlyUNsaOJrEev9Zc29gbZ4jVBq73uM7wIj7gDe
         AWASotnBfllKDD+KzXgW9zaP5xyZBwcCMZzTVJI8H7NOGVsNHi0c3halw9cOR6oyOPiX
         N2935AM+TcTg/mzRRQ1qnjh2SoW+Ra45PXJgjNXxFNc+4mgu4sOIZByX2L5tx999sIqa
         HOJg==
X-Gm-Message-State: AOAM530FlgWEdBTU2ybPPGTB5TAFlNa2hc2ZfSvaYBmdFSgSdY4Mo9r2
        FoWlMBLcp5ABPLIV7nSt6Ot7RMNZCPHaUfMmQTV/eA==
X-Google-Smtp-Source: ABdhPJxQsB0ulqavL6/Gla0u7Eswn9tjRqoMOHD+9KlFXl+HJTVxLZUHENDVltOOlWttivWvwVq8hTI13yLrdQvkYYI=
X-Received: by 2002:ab0:1696:: with SMTP id e22mr1910356uaf.1.1597296384671;
 Wed, 12 Aug 2020 22:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <0200811065307.2094930-1-ikjn@chromium.org> <20200813051008.3461515-1-ikjn@chromium.org>
 <20200813051008.3461515-3-ikjn@chromium.org>
In-Reply-To: <20200813051008.3461515-3-ikjn@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 13 Aug 2020 13:26:09 +0800
Message-ID: <CANMq1KBtTj3LqPBS4P7-njo=JobFN+2WSAzAAi6tb7O_7gBYGw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] power: supply: sbs-battery: don't assume i2c
 errors as battery disconnect
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 13, 2020 at 1:11 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Current sbs-battery considers all smbus errors as disconnection events
> when battery-detect pin isn't supplied, and restored to present state back
> when any successful transaction is made.
>
> This can lead to unlimited state changes between present and !present
> when one unsupported command was requested and other following commands
> were successful, e.g. udev rules tries to read multiple properties.
>
> This patch checks battery presence by reading known good command to
> check battery existence.
>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

Looks good now, AFAICT. Thanks!

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/power/supply/sbs-battery.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 6acb4ea25d2a..2e32fde04628 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -878,10 +878,17 @@ static int sbs_get_property(struct power_supply *psy,
>         if (!chip->enable_detection)
>                 goto done;
>
> -       if (!chip->gpio_detect &&
> -               chip->is_present != (ret >= 0)) {
> -               sbs_update_presence(chip, (ret >= 0));
> -               power_supply_changed(chip->power_supply);
> +       if (!chip->gpio_detect && chip->is_present != (ret >= 0)) {
> +               bool old_present = chip->is_present;
> +               union power_supply_propval val;
> +
> +               ret = sbs_get_battery_presence_and_health(
> +                               client, POWER_SUPPLY_PROP_PRESENT, &val);
> +
> +               sbs_update_presence(chip, !ret && val.intval);
> +
> +               if (old_present != chip->is_present)
> +                       power_supply_changed(chip->power_supply);
>         }
>
>  done:
> @@ -1067,11 +1074,13 @@ static int sbs_probe(struct i2c_client *client)
>          * to the battery.
>          */
>         if (!(force_load || chip->gpio_detect)) {
> -               rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> +               union power_supply_propval val;
>
> -               if (rc < 0) {
> -                       dev_err(&client->dev, "%s: Failed to get device status\n",
> -                               __func__);
> +               rc = sbs_get_battery_presence_and_health(
> +                               client, POWER_SUPPLY_PROP_PRESENT, &val);
> +               if (rc < 0 || !val.intval) {
> +                       dev_err(&client->dev, "Failed to get present status\n");
> +                       rc = -ENODEV;
>                         goto exit_psupply;
>                 }
>         }
> --
> 2.28.0.236.gb10cc79966-goog
>
