Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28614B8F2D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 18:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiBPReR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 12:34:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbiBPReR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 12:34:17 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD5222182
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 09:34:04 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id h16so520598iol.11
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 09:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NabgQQsJH6X4TlMYnFn6QKKl4Vhu4efuUjjjXfJ7lgQ=;
        b=dsj9GnWa++50RRrfwADJFF/o/2xUy5SXce8mZRDSEslyWwm7KHBXT56e43oz/709yQ
         v6saAUnzbVJhjV866YrKpAvUNAqwFYjn+5AgFFwx9D58EMUeHX/g43j3II9/r5rQUbF6
         V8RdxhwLOzhhmc3RRL6JvuABsDiRaVSPwjpYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NabgQQsJH6X4TlMYnFn6QKKl4Vhu4efuUjjjXfJ7lgQ=;
        b=sk6wpu8A/Z3Ixzn+nTodcqPLQwaxScBQRtbgQuQOj5hS9WUdJVii59Dd1EFOR2EoYK
         bAOOhGeuJeMLV852vvhyx7aKHlSzGhqTO4Qt1vxykr5mbl6eyeOEGBRM0t0h5Lxj0EWg
         RLbL/m/u9I67bpT7R0a9WAP3Pgsuvbmpyp8jEViginTzEwGsiOhdy9mHl+NP4IRP0WiV
         O7grcAnia6r5ghJQKbYS+3YHCwKI+pFXUOfWk9T8/Up3w7r4+4rbkUtaXjlg6SvxGtAI
         80bwepr5ZDyAT8ih1K4uabPSfAbMIj8DfAiEpPbtCzlSRK9x9foGXwOde3bsGRBJwOK4
         Mxzg==
X-Gm-Message-State: AOAM533v0vk4qqxpi+nkhlL+CuSNWFHNH8SRh8HqjPACvGTxLidByPuh
        aGGC50akVVg6aACn1e6TPz9EdQ+lJRP8zw==
X-Google-Smtp-Source: ABdhPJzaH+Co8T/pVjiMsuMpHNrFocP9LK3clj40BB1+ECnKiT0SMs975siTgRS3PE0oXB/izfoLJA==
X-Received: by 2002:a05:6638:2102:b0:313:e481:6fef with SMTP id n2-20020a056638210200b00313e4816fefmr2308601jaj.231.1645032843805;
        Wed, 16 Feb 2022 09:34:03 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id j15sm210578ile.6.2022.02.16.09.34.02
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 09:34:03 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id c18so102230ioh.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 09:34:02 -0800 (PST)
X-Received: by 2002:a6b:ed01:0:b0:635:2020:c11 with SMTP id
 n1-20020a6bed01000000b0063520200c11mr2514847iog.136.1645032842511; Wed, 16
 Feb 2022 09:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20220207073036.14901-1-lukasz.luba@arm.com> <20220207073036.14901-2-lukasz.luba@arm.com>
 <YgG+TmLrCSXX4Bvt@google.com> <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
 <YgKnnFl7Gp8AS30X@google.com> <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com>
 <YgQ9XLcto9v0fyTf@google.com> <d120110a-7d01-0cfd-f7eb-d160e17ec2a8@arm.com>
In-Reply-To: <d120110a-7d01-0cfd-f7eb-d160e17ec2a8@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Feb 2022 09:33:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VntGw1_AzJPpdOk0zSpOVZRH2X1JNg84JX+zCeU1jvXg@mail.gmail.com>
Message-ID: <CAD=FV=VntGw1_AzJPpdOk0zSpOVZRH2X1JNg84JX+zCeU1jvXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre.Gondois@arm.com, Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Feb 16, 2022 at 7:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Matthias,
>
> On 2/9/22 10:17 PM, Matthias Kaehlcke wrote:
> > On Wed, Feb 09, 2022 at 11:16:36AM +0000, Lukasz Luba wrote:
> >>
> >>
> >> On 2/8/22 5:25 PM, Matthias Kaehlcke wrote:
> >>> On Tue, Feb 08, 2022 at 09:32:28AM +0000, Lukasz Luba wrote:
> >>>>
> >>>>
>
> [snip]
>
> >>>> Could you point me to those devices please?
> >>>
> >>> arch/arm64/boot/dts/qcom/sc7180-trogdor-*
> >>>
> >>> Though as per above they shouldn't be impacted by your change, since the
> >>> CPUs always pretend to use milli-Watts.
> >>>
> >>> [skipped some questions/answers since sc7180 isn't actually impacted by
> >>>    the change]
> >>
> >> Thank you Matthias. I will investigate your setup to get better
> >> understanding.
> >
> > Thanks!
> >
>
> I've checked those DT files and related code.
> As you already said, this patch is safe for them.
> So we can apply it IMO.
>
>
> -------------Off-topic------------------
> Not in $subject comments:
>
> AFAICS based on two files which define thermal zones:
> sc7180-trogdor-homestar.dtsi
> sc7180-trogdor-coachz.dtsi
>
> only the 'big' cores are used as cooling devices in the
> 'skin_temp_thermal' - the CPU6 and CPU7.
>
> I assume you don't want to model at all the power usage
> from the Little cluster (which is quite big: 6 CPUs), do you?
> I can see that the Little CPUs have small dyn-power-coeff
> ~30% of the big and lower max freq, but still might be worth
> to add them to IPA. You might give them more 'weight', to
> make sure they receive more power during power split.
>
> You also don't have GPU cooling device in that thermal zone.
> Based on my experience if your GPU is a power hungry one,
> e.g. 2-4Watts, you might get better results when you model
> this 'hot' device (which impacts your temp sensor reported value).

I think the two boards you point at (homestar and coachz) are just the
two that override the default defined in the SoC dtsi file. If you
look in sc7180.dtsi you'll see 'gpuss1-thermal' which has a cooling
map. You can also see the cooling maps for the littles.

I guess we don't have a `dynamic-power-coefficient` for the GPU,
though? Seems like we should, but I haven't dug through all the code
here...

-Doug
