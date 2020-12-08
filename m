Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E72D26AD
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 09:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgLHIz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 03:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgLHIz5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 03:55:57 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EE6C061749
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 00:55:11 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id m13so2083025ljo.11
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 00:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4nPQzm9dDx2bI1IRs/zVvhtSUidTrnotzg7LEQVqZU=;
        b=VykDxvbn47xDaFLvnvDSLFLCRWSZWLgyJHOUxPGAToQjJmmeemF/JAxrhae9jjxLlP
         D54SRMKhsMn+HXMp7Btiw+nUylXul6sh0Fo9PQr2TgnIMoyGSjs762+2sgPw8UXxIqDW
         CGnA0LuENp8KAZAscs51aDWa9LqOjMF/KrfyMZZMHlZRx/sZSclQl3v1oKGM7oC+Mm4o
         MazpLK2lDGchOruOLn8zp70RVCh8Vi1OcoWqsln1bmvPvpbEIUcCtwtxxrxSKYxFrOto
         Ts++PYYZrsJ9mfn06ZbYbbmqcA5hHPEcsF4RreUWYGK7pwX6a53+LmR65ziadKGDtZA1
         h4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4nPQzm9dDx2bI1IRs/zVvhtSUidTrnotzg7LEQVqZU=;
        b=FnVd7ofxybrXJPn3OIAlN2pZe6K8BjgItcxg+AWEmYPgw6wZZLKvdAMQYcSKVIouyh
         UYoiBfTZPvgu3W9n50ahiMtPhU5NhdaRVecFfKtcNN+W5rJZY5IUbK+L87sFt/yhMYeg
         q1OTDV0BSzvUj+7OOn6ZNOd/6/0gYZEoIUYiIBkbgGDj4LZ4enhkIx0jptUAz06UWSUe
         JRFcWIS9XeilCES8c6UqpQ6PeTtt4F4RNHnGF3ATsLwZ4onfWXBcoPP1/NYblVf2evNl
         LV8v4KGfZ/zrfkxywrxZ04ka4pkNSeC9FNrgIMAVaGsOKM0ZSO4uPnu20oGtHdGYlFn1
         PjuA==
X-Gm-Message-State: AOAM532KKdtdkOAQGd3qUdx1gHg4KJp/DruYXxa+iHxan888FqBfmoEe
        W7N1aA/p20BNDDQZd8jYpCCjfMLIxHYREY9eFJpILjRO2BthOg==
X-Google-Smtp-Source: ABdhPJwOd4Czs/vCktXWMoZ/vysyXHbLKKPmOOX4HYmtW+6g0bNv/ZT5ohYkKwkChoruQsxCClIN8KPzb14CRmvrwpA=
X-Received: by 2002:a2e:97c8:: with SMTP id m8mr9780194ljj.338.1607417710117;
 Tue, 08 Dec 2020 00:55:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com> <f2866a9052bbeaa4b3795907f91974e1d18ef68e.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <f2866a9052bbeaa4b3795907f91974e1d18ef68e.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Dec 2020 09:54:59 +0100
Message-ID: <CACRpkdYjVJ9_6L2hthkoZ-G51aazxcyeHtu4EmeT8Eoo=0e=8w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/6] power: supply: add cap2ocv batinfo helper
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Cong Pham <cpham2403@gmail.com>, rostokus@gmail.com,
        fan.chen@mediatek.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 4, 2020 at 1:41 PM Matti Vaittinen
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

Overall a good idea!

> +/**
> + * power_supply_cap2ocv_simple() - find the battery OCV by capacity
> + * @table: Pointer to battery OCV/CAP lookup table
> + * @table_len: OCV/CAP table length
> + * @cap: Current cap value
> + *
> + * This helper function is used to look up battery OCV according to
> + * current capacity value from one OCV table, and the OCV table must be ordered
> + * descending.
> + *
> + * Return: the battery OCV.
> + */

Spell out the abbreviations in the kerneldoc and not just the commit.
These will be read much more than the commit message so I would
move all the excellent info in the commit message into the kerneldoc and
diet the commit message instead.

> +int power_supply_cap2ocv_simple(struct power_supply_battery_ocv_table *table,
> +                               int table_len, int cap)
> +{
> +       int i, ocv, tmp;
> +
> +       for (i = 0; i < table_len; i++)
> +               if (cap > table[i].capacity)
> +                       break;
> +
> +       if (i > 0 && i < table_len) {
> +               tmp = (table[i - 1].ocv - table[i].ocv) *
> +                     (cap - table[i].capacity);
> +
> +               tmp /= table[i - 1].capacity - table[i].capacity;
> +               ocv = tmp + table[i].ocv;

This is some linear interpolation right? It's not immediately evident so insert
some comment about what is going on.

>  /**
>   * power_supply_ocv2cap_simple() - find the battery capacity
>   * @table: Pointer to battery OCV lookup table
> @@ -847,6 +884,20 @@ power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,

I suspect this kerneldoc could be improved in the process as well.

Yours,
Linus Walleij
