Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314656461CE
	for <lists+linux-pm@lfdr.de>; Wed,  7 Dec 2022 20:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLGThK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Dec 2022 14:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGThJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2022 14:37:09 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944F63D5C
        for <linux-pm@vger.kernel.org>; Wed,  7 Dec 2022 11:37:08 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3704852322fso197507887b3.8
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2022 11:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dGT2RVQlnmZbYYn31iEVNk3Sq6r/U1P4VLOHcEx5sE=;
        b=swJSuvudVFJVSw2xAeuf7bAfy56peg4UCq/Kx4lq8+bIdVG8pzAV/EBJsmvt0TgEqr
         WExctJjRqOqjLVHMLdewaJjbfhBUIBd0prS2JH7JiDqnsPlCK+yILlHpgu2BUAIqJ69t
         HnSK0zrQ1+5AVBwBY+v79uKeJZg9/bSaVslYDlQfpeILnSdYH9QqpAPiAR2bANof+5iP
         jguLye4n7GEEHAbLIETfhuSTDUwkoXmoDQiLZYALwZ1dcjYGu5bXUY67axtSUKHx/Igi
         IqYQdMlk5AXOp2xPS81Ndpyi2Ne34ABjJxvPauI7xkWonsOR0+aererm916V3DYbbTik
         yHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dGT2RVQlnmZbYYn31iEVNk3Sq6r/U1P4VLOHcEx5sE=;
        b=sDcqb6BgoEm0VScWqKTAZfMwzW10HUZWvac40LBsbu/Mor8gTKT/StjJRvQbHb1jFv
         pMrlgflTW4nGiGnMfOdKpQmT24RQQQtAfBD83b3A1DLHdrcEFcKLDMsW5rH+yJCtH4kd
         VJX46K6JFEIfkFNp4jAHW0TUib6vixUzCPHF9I9agvndU3y2485UQdFZ0LySsSfoQHwN
         aeDSSBaWovLfM3/isaf4CDFXxikEzLDrP2/CaetQWU92Fa2vc5OfpMcpWETYnD9Ii5eC
         7cRd3N8u22C5BkCFMAfz/8+ih7Or78rdvF9Atu9iqlF54oAVtxdiJHuKUC/UpGoXVNHL
         CCYQ==
X-Gm-Message-State: ANoB5pk57G9fLSHALzkl4O0bBII2Btvc/+5knLZECXaxmGe3nUSWylNu
        8ccvTcxqT3OSm4jnTWV9dDYEmuDl5tuv4EER1dkCjg==
X-Google-Smtp-Source: AA0mqf7jFNbNjHHwit9S/nx0d3kZqwvfuZthVmtKujAKX+zpV7GGw9EEqUXa5FsW9phhPUMkW5RS8xMZ35pnbSe/HjE=
X-Received: by 2002:a81:598b:0:b0:3b7:78c8:a205 with SMTP id
 n133-20020a81598b000000b003b778c8a205mr58568868ywb.188.1670441827188; Wed, 07
 Dec 2022 11:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
 <20221204055909.1351895-9-dmitry.baryshkov@linaro.org> <2186df0393c6cf4dab88772aceed7202090f5a1d.camel@mailoo.org>
 <b0d37b049ebedd5e04f69d505afb36ab6f0a1492.camel@mailoo.org> <97651945-428e-c667-b7d8-7e627f900d05@linaro.org>
In-Reply-To: <97651945-428e-c667-b7d8-7e627f900d05@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 7 Dec 2022 21:36:56 +0200
Message-ID: <CAA8EJppDcrmnGuwG2rPWjrnOHtxE0QFj6OOmjk20c8NGCj=Wgw@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] thermal/drivers/tsens: Drop single-cell code for msm8939
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 5 Dec 2022 at 14:42, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 04/12/2022 19:25, Vincent Knecht wrote:
> > Le dimanche 04 d=C3=A9cembre 2022 =C3=A0 19:42 +0100, Vincent Knecht a =
=C3=A9crit :
> >> Le dimanche 04 d=C3=A9cembre 2022 =C3=A0 07:59 +0200, Dmitry Baryshkov=
 a =C3=A9crit :
> >>> There is no dtsi file for msm8939 in the kernel sources. Drop the
> >>> compatibility with unofficial dtsi and remove support for handling th=
e
> >>> single-cell calibration data on msm8939.
> >>
> >> Could one invoke a "msm8916-like exemption" here ?

Colleagues, I know that it adds a bit of pain on your side, however
I'd also kindly ask to rework the dtsi. I'd really like to drop as
much of the 'legacy parsing' as possible. The existing code is painful
to handle already, it is redundant, self-duplicated, etc.
See, how easier is to handle the DT cells + nvmem_cell API vs old
shifts and masks code.

> >
> > Ignore that, guess we'll just have to implement it like there:
> > https://lore.kernel.org/linux-arm-msm/20221204055909.1351895-9-dmitry.b=
aryshkov@linaro.org/T/#m19cffb13114b6f4f153058e3e7a1943251acaf81
> >
> >> Also, msm8939.dtsi was submitted once [1],
> >> and if helps we could send a v2 this month...
> >>
> >> [1] https://lore.kernel.org/linux-arm-msm/20220419010903.3109514-1-bry=
an.odonoghue@linaro.org/
> >
> > Offer still stands, the current community one is here:
> > https://github.com/msm8916-mainline/linux/blob/msm8916/6.1-rc7/arch/arm=
64/boot/dts/qcom/msm8939.dtsi
> >
> >
> >
>
> heh - here's my current
>
> https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=
=3Dtracking-qcomlt-msm8939
>
> I've been working on clearing out blockages in legacy yaml conversions
>
> phy
> mdss-dsi-ctrl
>
> which thrown up errors on 8939
>
> I took a good bunch of feedback from the list for v1 into that dtsi -
> there's not much left blocking v2.
>
> I'll see if I can get that out this week
>
> ---
> bod
>
>


--=20
With best wishes
Dmitry
