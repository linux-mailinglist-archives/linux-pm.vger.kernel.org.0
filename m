Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E669458ABCB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 15:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiHENsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 09:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiHENsh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 09:48:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D322B4D151
        for <linux-pm@vger.kernel.org>; Fri,  5 Aug 2022 06:48:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t1so3503133lft.8
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2022 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Qu42GkSZgSwJNVcCZcDAVdJgynuhwiHLKNU0w0qTtI=;
        b=jTc9Thnexb9GxgUgrlkof29rYFwEScpVooPrSpeoAddqfUklQtPW2FvIf+uA8yhNB2
         ksRm0oHYBDIGrC2ls2PGDj/jq+VtZz3xUag/gUBSZiaG/PR+hKiLQ6TOl05QbzJvssH7
         ePm6GgMf7mIm+O2laFeDHqN6FL6YZgSyF0TfxQEEFVtE5Wx9ZM7tGAPDAi/6h3XZIQzb
         6n8TEwgYK2khaJv77FcKOZXr66GhFIWlQPF5VoSlE5SlMDCbY9J4M7kmU+gyB1J451dr
         E5j7GfVPRGa7WxX/PX9fBa43JfBEWmzXmc4J1qK8JtKRi8tubxh4OntZYYdQm72Wxkje
         jyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Qu42GkSZgSwJNVcCZcDAVdJgynuhwiHLKNU0w0qTtI=;
        b=h6gRBIZ+vQpakaTknAmaNoJVYdcTm/GClD/FeZ0H50Jmv/i3ASiWv0kU6Amx1q0VLK
         hgYpm2bIW81iEMbQcUChVHjL9W0vnqAI+WQVg3DjNPgB4xb7FrCZxGf57ZpJYcNstbQG
         3sAU6oNA69u7Mh+2aUirr2wBlO708IBaEBo070bLFxvJNc6q4pY0yTzvTn49Fc9U8G42
         x2YzW4Rd7dssiNYo2lgNGEUf96knmZRyHpH2Znrv4zzGHPe/Y4zeve1JqI1nbMXCAYAd
         7OkD248ZR+2Hk5t1bkPvQH7Kx+fbsTMPMMIUBeLtX8fb1Xn2rW65NjVHHzLtrUjYPfEO
         ORFg==
X-Gm-Message-State: ACgBeo0tlh1mUnmMwfInCp5TrtdPoZ0ajI3E1nG4J4jc9v+qwJ9svHPE
        jRYLxB12VpQLgCtAVBtFg4An5sFayvslPuq7auTqVg==
X-Google-Smtp-Source: AA6agR6zlbnodh7A88lmlV3/ndU82/uMEk4Guofki8d9vqHREYM9WObWKDa13yhXY+LMQ0DPNGeGgkbtP80ffPZFn/M=
X-Received: by 2002:a05:6512:3403:b0:481:60ae:7ebc with SMTP id
 i3-20020a056512340300b0048160ae7ebcmr2489455lfr.358.1659707314190; Fri, 05
 Aug 2022 06:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAA8EJpr2S-81+q-vjmk5i+T-JwaadkRpjCr_oGi7fMf7o3iH3A@mail.gmail.com>
 <20220727111410.bglx2u26456ray2u@bogus> <CAA8EJprNPJfGjkq2=hexbZn-=t2wKG6ZjSm5Mcbo4JuPQ-sc-A@mail.gmail.com>
 <CAA8EJpqP9XMcLP+Pmj5OnXD2_SJ9ULBZ_Q492+x56oQnPzqiUA@mail.gmail.com> <CAA8EJppWSQTrZgN7yBLhLepuxEiFsBnkhcXOgXrz2qjGj3GcLw@mail.gmail.com>
In-Reply-To: <CAA8EJppWSQTrZgN7yBLhLepuxEiFsBnkhcXOgXrz2qjGj3GcLw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 5 Aug 2022 15:47:56 +0200
Message-ID: <CAPDyKFo5ejVDn+9meM+5=bb8SF=a8DGABP4KYF9AHhc-DCuf1Q@mail.gmail.com>
Subject: Re: PSCI domains without OSI support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 Jul 2022 at 22:51, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 27 Jul 2022 at 16:39, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, 27 Jul 2022 at 16:24, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Wed, 27 Jul 2022 at 14:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Wed, Jul 27, 2022 at 12:09:27PM +0300, Dmitry Baryshkov wrote:
> >
> > > > > - Allow DTS forcing the PSCI power domains even if OSI enablement fails?
> > > >
> > > > Meaning DTS flag for this ? If OSI enable fails, why would you want to
> > > > still proceed. It is non-compliant and must be fixed if the firmware
> > > > supports OSI and expects OSPM to use the same.
> > >
> > > I'm not sure at this moment. PSCI firmware reports that OSI mode is
> > > supported, but then when psci_pd_try_set_osi_mode() tries to switch
> > > into OSI mode, it gets NOT_SUPPORTED.
> > > Just for the sake of completeness, I added a print to the psci.c to
> > > dump the result of the psci_set_osi_mode(false). It also returns
> > > NOT_SUPPORTED!
> > >
> > > My logical assumption would be that the firmware reports support for
> > > OS_INITIATED, but then just fails to properly support
> > > SET_SUSPEND_MODE.
> >
> > Okay. From the msm-3.14 commit log:
> >
> > Add support to terminate all low power modes in PSCI. The lpm-levels will
> > work with version 1.0 of PSCI specification using the OS initiated scheme.
> > The lpm-levels driver would determine the last man standing and vote into
> > TZ accordingly.
> >
> > Which means that the vendor kernel expected to work in the OSI mode
> > without calling SET_SUSPEND (such call doesn't exist in 3.14)
>
> After adding the debugfs file, it's clear that this is the case.
>
> Compare msm8996:
> PSCIv1.0
> SMC Calling Convention v1.0 is assumed
> OSI is supported
> Extended StateID format is used
>
> vs sdm845:
> PSCIv1.1
> SMC Calling Convention v1.2
> OSI is supported
> Extended StateID format is used
> CPU_FREEZE is supported
> SET_SUSPEND_MODE is supported
>
> Judging by people reporting 'failure to enable OSI mode' on several
> other Qualcomm SoCs (msm8976, msm8953), this bug is present on several
> older Qualcomm platforms.
>
> >
> > So, this looks like the "force-psci-domains" or "ignore-osi-error"
> > flag would be logical.
> > The question about testing still holds.

Alright, so this looks like a deviation from the spec. Nevertheless,
it seems quite simple for us to fix by overriding the FW error, by
adding a new DT flag, in the way you propose.

In principle, I think the new DT flag should avoid us to call
psci_set_osi_mode() in psci_pd_try_set_osi_mode(), but rather just
return true when the flag is set.

In this way, the GENPD_FLAG_ALWAYS_ON will not be set for the genpds
that are created, so things should work as the PSCI FW has OSI mode
enabled.

Kind regards
Uffe
