Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8391741B43
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jun 2023 23:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjF1V5Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jun 2023 17:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjF1V4z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2023 17:56:55 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1782B2D60
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 14:56:32 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5700b15c12fso210287b3.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687989391; x=1690581391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnGMQOEnuXwr/opUEDGr/9OsjO1I6gHLazySPyM8Vng=;
        b=CUQC9Y0eQtr0n5pjuu2Txm57WGoabBOUVRjQ5EHElC3JMNgpioNjrtlcoP5zbhWO1O
         Rf/R60eeZb+7LKZt51pv+J/dMGFxdPoVwNgWW7x1+Ujl+EdwYo1VXnQsB/B5/SFvEfwq
         AonYCd9uflcMdqxozOZbma0uz55i25/BhftkpLEeuCb1IF6AFoMwcrOIsv5+w1I57IO9
         R8XtcQogCe0Z8jcrJnJTy2YOjXcfIWgqZWmr+UiPd+uXGX4QlVT/DOO5zTQt1IDGVmzY
         i4TUL80wSMN4CpMrpnWxQDD/SlK6xBYsDK8+F1mKPfTGZfMMoskacTFx5N79B0551sox
         JceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989391; x=1690581391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnGMQOEnuXwr/opUEDGr/9OsjO1I6gHLazySPyM8Vng=;
        b=E1XdT3+pffaLgckqutlHdym8HbMCY20aa0QQRDvl1WE2YBTRZCPb13pS3qUMdFGlKp
         /UfI9O22ds7bpLfsvW773vgJkhHc8wymKUsRlC5/EsA3vf4jjHoOgEh4e5vGsGwJQzQp
         7S9NjMHo3Dz6UtnhYsOwaMTVidDNRCV7xc1jkDqYHjJIMpx2cSlkVaTjpknh+zeXG5gD
         nf5rbNRVIcsxkLoOFg4AnNDaJLt2tWUuz89ah7d+Gmp6bCuAJ5O0LEKFEenrSnjXAI2V
         AL56ht3zke8Igq+VQ5N2MwtHNdZ8nDVVFI8W3rB/hkWfAR+UN5+y802brvMmEUAHDfrC
         VHZQ==
X-Gm-Message-State: AC+VfDyQxy+UJzezesJxtA7NDaJ7LsIQzUiovm652hRQ6NbPUF+6Cvvs
        pW0S6D9xsUMOf0PWc1hffoAGB91+nsYAASlweedYRw==
X-Google-Smtp-Source: ACHHUZ5wljNS/rozuIyPT6I2Z+jlk2Dv0uMmEMWXCme0AmmEZ66URZbi1CF/E0uJ5bJQocNix0qKBWxom4DQj52EsuA=
X-Received: by 2002:a25:a4aa:0:b0:c00:e6c4:1812 with SMTP id
 g39-20020a25a4aa000000b00c00e6c41812mr19609040ybi.63.1687989391111; Wed, 28
 Jun 2023 14:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230628105652.1670316-1-abel.vesa@linaro.org> <CAJZ5v0i-+b+oFOP92rhNw_UOKu3-QOy_-stQRa5X2HbaTq9XMA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i-+b+oFOP92rhNw_UOKu3-QOy_-stQRa5X2HbaTq9XMA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 28 Jun 2023 23:55:54 +0200
Message-ID: <CAPDyKFoO85-k38-eXzJ3wRK9tfS=DfUw8-jE6fXORTVSoRLXzQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] PM: domains: Add control for switching back and forth
 to HW control
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, avel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 28 Jun 2023 at 19:15, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jun 28, 2023 at 12:57=E2=80=AFPM Abel Vesa <abel.vesa@linaro.org>=
 wrote:
> >
> > This is just a resend of [1]. This resend just adds the back story behi=
nd
> > the need for such a generic API as a cover letter. Also added my SoB ta=
g
> > to Ulf's patch.
> >
> > Some of the newer Qualcomm platforms support handing of the control of
> > some of the GDSCs (implemented as power domains in Linux) to some devic=
e
> > firmware. The idea behind such approach is that the firmware knows best
> > when such a power domain can be powered off or not and leads most of th=
e
> > time to better power consumption.
> >
> > At this point, if such GDSC provides HW control support, the current
> > implementation is switching to HW control right after the GDSC gets
> > powered on and it is left in HW control mode until right before the
> > request for power off is done. This needs to remain as is for now, as w=
e
> > do not know for sure what each firmware expects from its related GDSCs.
> > For example, the venus driver expects the codec GDSCs to remain always
> > in HW control mode, otherwise the firmware would crush.
> >
> > But in some cases, the consumer driver needs to switch back and forth.
> > And the explanation for such case is when a driver needs to interract
> > with the device (e.g. reading status bits) and the firmware doesn't
> > guarantee the GDSC will be enabled when in HW mode. Therefore, the
> > consumer would need to switch back to SW mode, do its thing, and then
> > switch again back to HW mode.
> >
> > This is where the patch from Ulf comes in. It allows consumers that
> > actually need to control the HW/SW mode to do so.
> >
> > The GDSC patch just implemets the set_hwmode op and sets it for each
> > GDSC that provides HW control mode.
> >
> > [1] https://lore.kernel.org/all/20230627104033.3345659-1-abel.vesa@lina=
ro.org/
> >
> > Abel Vesa (1):
> >   clk: qcom: gdsc: Add support for set_hwmode_dev
> >
> > Ulf Hansson (1):
> >   PM: domains: Allow devices attached to genpd to be managed by HW
> >
> >  drivers/base/power/domain.c | 66 +++++++++++++++++++++++++++++++++++++
> >  drivers/clk/qcom/gdsc.c     | 22 +++++++++++++
> >  include/linux/pm_domain.h   | 15 +++++++++
> >  3 files changed, 103 insertions(+)
> >
> > --
>
> I can queue up this series if I get an ACK for the second patch.

Thanks, but please hold on until you get additional confirmation from me.

I would like the consumer APIs that are being added in patch1 to have
a user. At least I want to see a plan for upstreaming one user of it,
before I think we should move forward. FYI, there are discussions
around this offlist too.

Kind regards
Uffe
