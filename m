Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A135960EB71
	for <lists+linux-pm@lfdr.de>; Thu, 27 Oct 2022 00:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJZWSL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Oct 2022 18:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJZWSK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2022 18:18:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4995F63F7
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 15:18:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f37so31711338lfv.8
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jqI46+e/77kTgH7h4PL7uKuCpH6Cjz4yNeCC9Ks3dc=;
        b=MAx9GoqJUSQhB9bUYYAAInmItHedCwfDzU+a4AbWRsIeK/Yc90GUigg1RMlpIdTisx
         mC4FlztFxd+wbVprYc/rwG8i1qM8Y+NnBwRdOv4HkLoF5IBFaptL9QGCipm79reH71Aj
         Y9bT4Uf/if6xXcCHZImJQqf7A78epbLOgSNMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jqI46+e/77kTgH7h4PL7uKuCpH6Cjz4yNeCC9Ks3dc=;
        b=kfx23Skw0M3VRoxwE/u6GPn3ycGg8DdRNcHLuBvB09TFBt1F8H1oFmA7a9vSfD4Ckc
         93LYX23O2VjZQSqp1NEiycDOL8Fc9xfkp5mnR7K/QrH3twvMiodbtWjY7q28Nd2uVNtN
         FDZ0xFX5dLH16Eoa8o8Mhst+Or8E1srApxIzHjXdVMNQZAtBaxpZZobgOWz70cWP+VV+
         hIpoeUdlvbfDqL1BGTF6Y54sKGWiaybHD5xK4aNSHBTwE1qxmz4SP9lPNSHvEjmhXH4I
         HALtT97aEUqeHHlASMw4OvEChOEQjri0HjPNqBg1acnPir72sxEBX1Y1pZG5YamY+X+j
         YTGQ==
X-Gm-Message-State: ACrzQf1QsSDySVJSqYWuYS32qnVJW2N+/+xqZg6NHghgcqXhnUlJTrog
        qpaMiIaM/0DgCrBSU9s1AqsXla5GL1AmNPUPpowGng==
X-Google-Smtp-Source: AMsMyM4NW2ATDJXFwKq7wuAg3X3McqDZmNzLYBOFH6QkeLPvXebMrquLMvO2T31xyTlgJ0snNV/KF5PqAsctW7ikaq4=
X-Received: by 2002:a05:6512:3dac:b0:4a4:8044:9c3 with SMTP id
 k44-20020a0565123dac00b004a4804409c3mr16238548lfv.145.1666822686108; Wed, 26
 Oct 2022 15:18:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Oct 2022 18:18:05 -0400
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpay0w6n6rtv+bsdcTvL4ijtEPBODo1=XJpUFNdaooTcg@mail.gmail.com>
References: <CAE-0n52xbZeJ66RaKwggeRB57fUAwjvxGxfFMKOKJMKVyFTe+w@mail.gmail.com>
 <CAPDyKFpay0w6n6rtv+bsdcTvL4ijtEPBODo1=XJpUFNdaooTcg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 26 Oct 2022 18:18:05 -0400
Message-ID: <CAE-0n52Bfe-7Fpawct=_3=miLBygR_-YXm1YPnhCWOwxFnjv7g@mail.gmail.com>
Subject: Re: clk: qcom: genpd lockdep warning in gdsc
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Yu Zhao <yuzhao@google.com>, linux-arm-msm@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reviving this old thread because this commit has lead to a couple bugs
now.

Quoting Ulf Hansson (2022-06-22 03:26:52)
> On Fri, 17 Jun 2022 at 21:58, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Hi Bjorn and Dmitry,
> >
> > Yu reported a lockdep warning coming from the gdsc driver. It looks like
> > the runtime PM usage in gdsc.c is causing lockdep to see an AA deadlock
> > possibility with 'genpd->mlock'. I suspect this is because we have
> > commit 1b771839de05 ("clk: qcom: gdsc: enable optional power domain
> > support"), and that is now calling runtime PM code from within the genpd
> > code.

This commit has caused a deadlock at boot for Doug[1] and I see that the
camera driver on Google CoachZ and Wormdingler devices doesn't work
after resuming from suspend once this commit is applied. I'm leaning
towards sending a revert, because it seems to cause 3 issues while
removing the regulator hack that was in place to enable MMCX. This patch
is cleaning up the hack, but trading the hack for three more problems.

> I think genpd already has nested lock support, so the only
> > solution is to not use runtime PM from within genpd code and start
> > expressing genpd parent relationships in genpd itself?
>
> Not sure exactly what you mean here, but yes, expressing the
> parent/child domain relationship is always needed.
>
> Having gdsc_disable() to do runtime PM calls (gdsc_pm_runtime_put())
> seems awkward to me. Why is that needed, more exactly?

It seems like this is needed so that the gdsc_enable() and
gdsc_disable() calls can read/write the registers for the genpd, while
those registers live in some clk controller that needs either a
different clk (probably some AHB clk) or another genpd to be enabled. It
looks like for qcom,sm8250-dispcc it relies on MMCX gdsc (which is a
genpd). From a hardware view, the MDSS_GDSC provided by the display clk
controller is probably not a sub-domain of MMCX. Instead, we need to
have MMCX enabled so that we can access the registers for the MDSS GDSC.

My question is if it makes sense to simply describe that the GDSCs
provided by a device are sub-domains of whatever power domains are
listed in DT for that device? I think if we did that here for sm8250
dispcc, we wouldn't need to use runtime PM within the genpd code
assuming that the MMCX parent genpd is enabled before we attempt to
read/write the dispcc gdsc registers. Hopefully that is also done, i.e.
enabling parent domains before enabling child domains if the parent is
disabled.

Is this already being done with pm_genpd_add_subdomain() in
gdsc_register()? I see that we're attaching that to dispcc's struct
device::pm_domain, but I assume that is different from the MMCX genpd.
Maybe that is the problem here. Dmitry can you further describe the
problem being solved?

>
> > Or maybe genpd
> > needs to drop locks while calling down into gdsc_disable() and reacquire
> > them after that?
>
> Nope, that doesn't work. This internals of genpd relies on this
> behaviour, as it allows it to properly deal with power-on|off for
> parent/child domains, for example.

Ok.

[1] https://lore.kernel.org/r/20220922154354.2486595-1-dianders@chromium.org
