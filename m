Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFDA6E128C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 18:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDMQlX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDMQlU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 12:41:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFA6AF32
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 09:41:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s12so6359928wrb.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681404072; x=1683996072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tfEPKp0YHzoTdFnLl04W9z5A7WO7SsXRhhDTfhF0Tg=;
        b=Tf26MIz6QsWdn3u9biucHVNvpdpeoHfjt0DnhDmpSyjb58uF9heOnJm7aHLzpkru30
         x2Xavp7VspzTJbytjzOyQ9hUIuzKl5qgn0Qj8nNzyg2jf3qAvwm+88fCLu1pvGco6NO3
         eASOR4wFJRz1ma/JGbVjloQfwYO5nDK9MikSC+1v+mo8cN+exBj6YmjeWeTd+C5YaUmA
         wxp4AFwKoWIdo1RZ63nzLB6uUJlX86cbgJ9p7epCQV19gfNAbsx57T2r5vwCXZDx+rSy
         8QcAJQDrGt1ee+GpAQP1rWYiJg0N8pwxCiYUJszM83VLOjFWzBZU77Dim5BjtGtnb+SC
         98rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681404072; x=1683996072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tfEPKp0YHzoTdFnLl04W9z5A7WO7SsXRhhDTfhF0Tg=;
        b=VSyYGsLfo4NO0l+mIdj5s9FDqRoBv7pQoA2d4uqa8LstjH7y4k3LtmiroLjfGPHpsf
         ANIiw1+ZHQ2NcRG6DAAFWYBimUnFX1L6otyflm2pc+chhqYGs+Yom8gyIx/cvaJd51az
         +1tvjpylSnnMjUbPMRNJTiHayMvrgB4q5ce0Dk8Nto2koD2OY3x9Eavz4K6UzhnchO/l
         54kui5fTivk8dh1zvLOAo0vxAwtsOjZeE4/IXIG+ldz3iaraNkRM3G1BzzJ+fSt+lr4O
         ez2/lNnSa2gVYK4TyXvGoB+74pTAmkIax+wdLsr8uv/V+2pPslCY0hFHWcpwgnmJy4Ae
         gFrQ==
X-Gm-Message-State: AAQBX9cYJT0mqdg2AuBlw2vXTDplZz1DCEMAqBZLoZl37L/lAOGmsCm4
        8ZknvaK+mX/vM3d2f8dIQRXp0syOWQw9OcOcHrqp6uxF
X-Google-Smtp-Source: AKy350b7SJJHGI+y5mlYQw6V3Z3s/tmrg7v7uRNqcKbXPwJrkrHha0t+UERi/8IBVQcQcpIX+eBuukO06KTMsJ7m/uA=
X-Received: by 2002:a5d:560d:0:b0:2e5:e0e8:9c8d with SMTP id
 l13-20020a5d560d000000b002e5e0e89c8dmr537191wrv.13.1681404071692; Thu, 13 Apr
 2023 09:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230413100941.115529-1-hdegoede@redhat.com>
In-Reply-To: <20230413100941.115529-1-hdegoede@redhat.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 13 Apr 2023 09:40:44 -0700
Message-ID: <CA+E=qVd70a2kJvfdPdssiwMwS0PHHb1C06sgK9G6MjQwG+C5+A@mail.gmail.com>
Subject: Re: [PATCH] power: supply: leds: Fix blink to LED on transition
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 13, 2023 at 3:09=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> When a battery's status changes from charging to full then
> the charging-blink-full-solid trigger tries to change
> the LED from blinking to solid/on.
>
> As is documented in include/linux/leds.h to deactivate blinking /
> to make the LED solid a LED_OFF must be send:
>
> """
>          * Deactivate blinking again when the brightness is set to LED_OF=
F
>          * via the brightness_set() callback.
> """
>
> led_set_brighness() calls with a brightness value other then 0 / LED_OFF
> merely change the brightness of the LED in its on state while it is
> blinking.
>
> So power_supply_update_bat_leds() must first send a LED_OFF event
> before the LED_FULL to disable blinking.
>
> Fixes: 6501f728c56f ("power_supply: Add new LED trigger charging-blink-so=
lid-full")

Wow, it's a commit from 2011 :)

> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  drivers/power/supply/power_supply_leds.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/sup=
ply/power_supply_leds.c
> index e2f554e4e4e6..c7db29d5fcb8 100644
> --- a/drivers/power/supply/power_supply_leds.c
> +++ b/drivers/power/supply/power_supply_leds.c
> @@ -33,8 +33,9 @@ static void power_supply_update_bat_leds(struct power_s=
upply *psy)
>                 led_trigger_event(psy->charging_full_trig, LED_FULL);
>                 led_trigger_event(psy->charging_trig, LED_OFF);
>                 led_trigger_event(psy->full_trig, LED_FULL);
> -               led_trigger_event(psy->charging_blink_full_solid_trig,
> -                       LED_FULL);
> +               /* Going from blink to LED on requires a LED_OFF event to=
 stop blink */
> +               led_trigger_event(psy->charging_blink_full_solid_trig, LE=
D_OFF);
> +               led_trigger_event(psy->charging_blink_full_solid_trig, LE=
D_FULL);
>                 break;
>         case POWER_SUPPLY_STATUS_CHARGING:
>                 led_trigger_event(psy->charging_full_trig, LED_FULL);
> --
> 2.39.1
>
