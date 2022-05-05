Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B980351CA72
	for <lists+linux-pm@lfdr.de>; Thu,  5 May 2022 22:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378257AbiEEUVC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 May 2022 16:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbiEEUVB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 16:21:01 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685ED59976
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 13:17:21 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2f7d19cac0bso60933937b3.13
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2022 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=axejSY/pqvKpUjTY7jHIkoiEEtPl20e4rTjvYrHNVbw=;
        b=e7DCq22XEADDXvFPdYNJ47OVxs5TWNEPL2lGRgMN3xk8aokNcNxoFrbWkPPiGR0CAC
         M84oDrpx6xlTvN5OcIi4tV6k/iEFmKSZs1aFSMFOWK5zNcdWsyCUB2563YOCPZ4xrHID
         THhu73eNNgjLXq/k95hm4pds31E9/p5Wl3WjRLt2ZKKhNVJjyaDZpn1IOC0Lj6+/ZWx7
         V08aWljX6dOfhO2Ahsoo5bUkfDpEEe9g5rOlFkNy4Vv4NTJr6jx/Xz9J0mUEuHakqMJt
         QDS6zjOy5DsTPt9ncCOwxNHmWzGcal94e+ujFwPWp6Uprjinq44xe0odwXy95vSOfDeF
         KMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=axejSY/pqvKpUjTY7jHIkoiEEtPl20e4rTjvYrHNVbw=;
        b=kkodlJRtCKFVyX5GahJkPOPtG/P7h7E7RF9dudutPXbh/EitkZVXCjg2Jvku2/Y5QD
         LAQInN+YvjACzPCzKfB7ioYQVLcoLT7rpzxaLkHyLUDeEB4PLpgxot1fYLaHxFWF5OC7
         +qlZhxvBBaJQqDUqU6hYkV6aMCm8A2VgZ0mkpstA7meCRjMJSi8RkO5Ewjq3l95VKtcn
         SwKHLkyoftHOdYxfjYKm8irxEt4SAK6Q9t89jXwDOHEUvaCSq6JwLlPzkaGPJulONi1X
         OU7z8Pc2an+5wvtcYJzlIp9IvCNCsKYEhh+pj67MM0mR6wFgBlDd3j4J/8luWtSz50Tg
         Iczw==
X-Gm-Message-State: AOAM530tLPLvNWHetVR0+Ml3/Lsa+mfPx7LKccHf4WfvMwIVHmppggSj
        QnBuXcE6yZCoIveA7fKuMuLTvD6S/f4gqTY/5ypQLN6fPDxNFg==
X-Google-Smtp-Source: ABdhPJyXp4oT66IDvOQKKqB6pnkOYhJ3BK2rTJHRGD0cW0LLCKcwpgcnjkHn1YQn8XVpXGe1jg3YkuaI1ETTq+b/j9w=
X-Received: by 2002:a0d:c4c2:0:b0:2f1:6c00:9eb4 with SMTP id
 g185-20020a0dc4c2000000b002f16c009eb4mr26666859ywd.448.1651781840688; Thu, 05
 May 2022 13:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220415203638.361074-1-linus.walleij@linaro.org> <a1ad97a5-4048-1f8e-272b-6d1e99bd20cf@fi.rohmeurope.com>
In-Reply-To: <a1ad97a5-4048-1f8e-272b-6d1e99bd20cf@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 May 2022 22:17:09 +0200
Message-ID: <CACRpkdYCWYgUAUJVVKy0jU4yF=d95e0Ead=coeMaA=uD3WV35Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: supply: ab8500: Respect charge_restart_voltage_uv
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matti,

sorry for slow replies!

On Tue, Apr 19, 2022 at 10:51 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

> Hi again Linus,
>
> For some reason I am always slightly terrified when charging is
> controlled by the software ;)

That is a normal reaction... The AB8500 has a few hardware safeguards
to make sure it is somewhat safe. Such as multiple thermal sensors
and over-voltage protection. But it also has a pretty elaborate state
machine.

> On 4/15/22 23:36, Linus Walleij wrote:

> > +     /* Some batteries tell us at which voltage we should restart char=
ging */
>
> Is utilizing this limit something that has already existed for these
> batteries?

Yes, look for example at the Kyle battery, Samsung SDI EB425161LA:
https://github.com/linusw/u8500/blob/Samsung-SGH-I407-Kyle/arch/arm/mach-ux=
500/board-kyle-bm.c
line 312 called "recharge_vol" is set to 4.3 V
Then in the charging algorithm:
https://github.com/linusw/u8500/blob/Samsung-SGH-I407-Kyle/drivers/power/ab=
8500_chargalg.c
line 2229 you can see how it is used the same way.

> I am just slightly worrying if this can cause problems at low
> temperatures? I am by no means an expert on this area (as I've told
> earlier :]) so I may be completely off here. Anyways, I think I've seen
> voltage curves for batteries at different temparetures - and AFAIR, the
> voltage of a battery with near 100% SOC at -20  Ccan be close to the
> voltage of a nearly depleted battery at +40 C.

Probably true, because the batteries have operational conditions for
low/high temperatures which change the behaviour of the charging,
so that is how they choose to deal with this.

> Hence I am just asking if this is not causing my phone to keep charging
> even when the battery is full. I mean, when I am at next autumn spending
> the night in a tent at Enonteki=C3=B6 Finland - and forget to disconnect =
my
> phone from charger before the campfire fades away? :]

The battery in my example EB425161LA is defined in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/power/supply/samsung-sdi-battery.c
lines 677-719, there you find .temp_alert_min =3D 0, and if you look in
the charging algorithm:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/power/supply/ab8500_chargalg.c
below that temperature the charging algorithm will switch to a lower rechar=
ging
current by going into the state TEMP_UNDEROVER where this
recharging voltage does not apply, instead a much lower voltage
alert_low_temp_charge_voltage_uv =3D 4000000 will apply, 4.0V
instead of 4.3V.

Further you see that temp_min =3D -30, so if the temperature goes
below -30 degrees, the algorithm will shut down charging altogether.

Yours,
Linus Walleij
