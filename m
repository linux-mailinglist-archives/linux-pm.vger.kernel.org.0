Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4250251CA80
	for <lists+linux-pm@lfdr.de>; Thu,  5 May 2022 22:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiEEU0s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 May 2022 16:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384539AbiEEU0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 16:26:47 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317F55EDF3
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 13:23:07 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e12so9543747ybc.11
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2022 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7ohHI7hZwug9+qHecP1FXe4M+u9ZAsSYlMj0dJWzJ4=;
        b=U0UWLr0/ULd83KocLmsPwI1CjsnadqPSrt3deokQkzVBJe0VIhcd41+NyjCWnApFdV
         hB80oQ47VQjFIweZrCvuroOw051a03SDXCCXbkRI6JZ0JXwAes5G/e39R/azZ1AJmhr5
         yqsibI2NpjDCZMmwfBD5fV8cIjwpUJSckxjdDBwh1r4pHjtGukiJpEWFKAskDgbNxDwk
         iLK4tJlTb7kWksNZ8uacakzAnq4wYsYnldwFbXQwwxSQni/+QRF0nRtduRgmUNylzuDa
         8w2jj7T3nteATBBbrTq4pUrJKCvDWbHxOigmBZCOiWkW4S2lZwD7DS4uOebe0uDbLv/n
         wLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7ohHI7hZwug9+qHecP1FXe4M+u9ZAsSYlMj0dJWzJ4=;
        b=HFUOaJJwIZoOryVqz4R8lhmaC4+l8gKl5fBj9XFrfOBSr9fV0sXDU9zbfTTJLe1evI
         d9kX4UXbAKDbOx8yOTRw4U/CXa6CxVoWyEo5ClQGDkoy6lXIYHzxsEbbd2SanweUMQx3
         0Lc4fJJBV0Omjlz/uQvgk1qQbRWjR+J/jh0Xc2UVuXRA5Er55v6juEnBMDVZxDFO8L1a
         G9ol7WqrEMebaeDmHVodFBJshsYKme6tIlAYfJXFryfojWq7tjMnYK2wZles1p9H0FYj
         WB3ckYvkbm1UR/IbFktbSus8J22l9TS+qJezW/fVUb5P30Gs0BTfOugnoUqOpladFBhL
         WW/A==
X-Gm-Message-State: AOAM533NVaBP42MMOySLE3iN/Ceui3Rb/P71XXmQQky9Tz3TY29esdRW
        HniKKZOt0yqTtbVJOO6YCgdr3zGeNMdDrgS7TDRz33TSbpc=
X-Google-Smtp-Source: ABdhPJywuc4FXzho74FJYiVJ5/O2yveNgnePxRWWFku5GXGXQW5qCZ6IPQy2s8At7EXEn6yC4jkML1EtUzSHj+8Pr3o=
X-Received: by 2002:a25:bcc3:0:b0:648:7360:8e75 with SMTP id
 l3-20020a25bcc3000000b0064873608e75mr22771434ybm.533.1651782186454; Thu, 05
 May 2022 13:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220415203638.361074-1-linus.walleij@linaro.org>
 <20220415203638.361074-2-linus.walleij@linaro.org> <36001b47-99fc-1b49-49e7-018f81b717c4@gmail.com>
In-Reply-To: <36001b47-99fc-1b49-49e7-018f81b717c4@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 May 2022 22:22:55 +0200
Message-ID: <CACRpkdbfuEJCSnC0XmUZtz8zGfFmHFBCSdc10CGhjDPbSvVJFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: ab8500: Exit maintenance if too low voltage
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 19, 2022 at 11:26 AM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> Probably just a matter of taste (like underscores in private function
> names ;] ) - I would prefer combining the cases for INITs to something like:
>
>         case STATE_MAINTENANCE_A_INIT:
>         case STATE_MAINTENANCE_B_INIT:
>
>                 mt = power_supply_get_maintenance_charging_setting(bi,
>                         (di->charge_state == STATE_MAINTENANCE_B_INIT));
>
> ...
>                 ab8500_chargalg_state_to(di, di->charge_state + 1);
>
>         break;
>
> That would slightly reduce the code although at the cost of additional
> arithmetics. I'm leaving this to you though.

Yeah there is something like a firehose of stuff here when it comes
to coding style in this charging driver, and on top of that it
"would be nice" if the kernel had some state machine primitives one
could use in order to centralize such code and make it more robust...

> FWIW: After someone telling me that I should not worry about the cold
> weather (ref. my comment for the patch 1/2)
>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks, are you pleased with my answer to 1/2?

Yours,
Linus Walleij
