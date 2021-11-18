Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7CB455276
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242419AbhKRCFi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242410AbhKRCFf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:05:35 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B6FC061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:02:36 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bf8so10718567oib.6
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4vEYzrUdQk1oeWluRtVFd4gA0NW+gSa5GYl0JXALPI=;
        b=E8ks+FYaKjwoUEBkFNIgVXYujlv33Jy4eCQXUKef9K5BygpRyQPjR0n5h0Nou62I3N
         YmZMzj8zNGj4MVs9PTPjIxhyobDYPluFdgfiSDxD9DbqXY8WF9NrIQp1td96tqkd7kf1
         218zor7Rl84nTSumlTJbTkUU11TFwZyUzKjaOTDEnlMxuhlB+6txsW2rO/MMJgWql3Qd
         PUzlz8H9GhN9nhrnFJhi9j19fyT3folCuKz6Sk3xdEP6yz4jP8ka44k8QJOpMj8yOi4A
         jN6VAVAeUwJ+3n6tLbsxvQoLto4VKluNT3TXVwm++fQeJL/d/NKiWmodasjP+J8umHi+
         RSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4vEYzrUdQk1oeWluRtVFd4gA0NW+gSa5GYl0JXALPI=;
        b=atSYbEgvu1nNieWC4Y/6dgWP939SCJ0fMBe5dubgnPl3bVmSH2U+rILsukbELHcv0B
         RvA/w8nRNhV9WnIn5AR8RWm9vGUTgF26BAsvk63mVKqu79PHOa9XWlpyoA2uh9WwUa3D
         ckJwXXGOli6vbT5xg9e++KHr3EVb+y8u614jFe7YuvyT2OlhxqvL0TkNpHYjzCi4R5yc
         GyDq0SzHyk1gtYwEr63CTHdCSkXXjkfeuKenTk/fgLq2p+SNyaZo1qAAVyOizYgaObPH
         tCc+Rs0//DFmBZ4BA/107VYn/HuBbmXWYiEXtSlEHzAL8BjOAIIX3t9xphakTPvWlWq6
         c6ew==
X-Gm-Message-State: AOAM530yxVREajQGhjVWYcgvgWM/PCeWnCyRn3wG7Dt6BV5AH2L+8pK9
        Nns6rs+r6ZZMpV0BdD3PPy5nVZpeTy2t9hRrSbp4LA==
X-Google-Smtp-Source: ABdhPJxtEyJT5YCnLe0+SjmAkihWNaVOI0kR1WcFABR9rEURrQYpiEe8po9f0QaV1McXZZcL0mh51MAHZxSlrBcnV6U=
X-Received: by 2002:a54:4791:: with SMTP id o17mr4479961oic.114.1637200954681;
 Wed, 17 Nov 2021 18:02:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com> <20cfdc60b148646a0473640a8efdb056b207c56e.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <20cfdc60b148646a0473640a8efdb056b207c56e.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 18 Nov 2021 03:02:21 +0100
Message-ID: <CACRpkdZJ50Q94inqpNfo-x4ivEq50yiisP2KAFOu3hr1Y8+Yrg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/9] power: supply: add cap2ocv batinfo helper
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 16, 2021 at 1:25 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> The power-supply core supports concept of OCV (Open Circuit Voltage) =>
> SOC (State Of Charge) conversion tables. Usually these tables are used
> to estimate SOC based on OCV. Some systems use so called "Zero Adjust"
> where at the near end-of-battery condition the SOC from coulomb counter
> is used to retrieve the OCV - and OCV and VSYS difference is used to
> re-estimate the battery capacity.
>
> Add helper to do look-up the other-way around and also get the OCV
> based on SOC
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

It seems you will need this for your chargers indeed.

> +int power_supply_dcap2ocv_simple(struct power_supply_battery_ocv_table *table,
> +                               int table_len, int dcap)
> +{
> +       int i, ocv, tmp;
> +
> +       for (i = 0; i < table_len; i++)
> +               if (dcap > table[i].capacity * 10)
> +                       break;
> +
> +       if (i > 0 && i < table_len) {
> +               tmp = (table[i - 1].ocv - table[i].ocv) *
> +                     (dcap - table[i].capacity * 10);
> +
> +               tmp /= (table[i - 1].capacity - table[i].capacity) * 10;
> +               ocv = tmp + table[i].ocv;
> +       } else if (i == 0) {
> +               ocv = table[0].ocv;
> +       } else {
> +               ocv = table[table_len - 1].ocv;
> +       }
> +
> +       return ocv;
> +}
> +EXPORT_SYMBOL_GPL(power_supply_dcap2ocv_simple);

Rewrite this using the library fixpoint interpolation function but just
copypasting from my patch:
https://lore.kernel.org/linux-pm/20211116230233.2167104-1-linus.walleij@linaro.org/

Other than that it looks good to me!

Yours,
Linus Walleij
