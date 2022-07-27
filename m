Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A814E58343E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiG0UvP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 16:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiG0UvO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 16:51:14 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E345072E
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 13:51:13 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id q3so74835qvp.5
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MimbQxk9gBAT10hM+BMRcfkfN4McVaow40wDd+ExhE=;
        b=dk6fnxggUuYs3KCxaVouaJW51zBKcqV4CFXo1ZslOYtxvU3XxR8wedILt5Cj1SjZqW
         gJZdlzB+HKvkWoJuywbNbLPLixfxxoJz14TZMzf2lMpXeGuj9Z3e2jGkEAA9O8E9KkfJ
         wcZIAcFlRcxWH/W/TfLU8XMgnx7G0x3/gZ0gzp5utuKX3UZvOvqSLZK1g+apCHivkPoQ
         5Pl8tfOeH0edfjXGetU7VbGOMab46CVTFZIxDM5Aasjd+1EeLtzxUSGpCZFvVpwaxdVh
         cMFo8twmDnG86/c6oYpaFHn1ouXTdi/vcNtMS8HTmlYyOj7MmguqVsZt7EUHsjGDiaAP
         B2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MimbQxk9gBAT10hM+BMRcfkfN4McVaow40wDd+ExhE=;
        b=I6IvmWI0zX+nzZMA3UhWUTf2gyYuPJ6EQvsiAkJOaa2gJHIiXQa4FxtVgyED6biUOL
         6U2fi4LZ2lAJkr9KnYTpK63TtUonnY/sn+vpbTtyxxLt+uy2t8OR4eWOWD+mzl9xxrZr
         Gyu/WNaDMoRaYsBTQtLiwbKaD02TKEEFPAB93nDn4PYzVU6T78iGtvecuQROgfTNMX8F
         ee5ffK6+LD7/ChfglRzzUhm6WNpcRalG15KkwCvJVsChZQCXsNvpF9bexrZj3elX5chv
         aqYUzFgOIrUD+1ezr108+m2dnO1jJ/GlbRpkmr+YBMJF4plYuy1f5FW1HBe/bePTMKIk
         jZ0w==
X-Gm-Message-State: AJIora8VawXSf61n+Tw4QWHB8Ik63+amgtaUoWBoFkrum4/IzQzX5oZQ
        wQjMkI8TT/XjRlq2fqV8PvVmx9d5RrUf7Wfpw63MA9xs8dD0rQ==
X-Google-Smtp-Source: AGRyM1tuvxdRkL8TNAQWYCPS3S3HpR3TBUr0lC6PLUO0qAmXfaEV3lBIFV1MY0mudqjTzswos9YEBmjX7MR6zblPtq8=
X-Received: by 2002:ad4:5761:0:b0:473:7861:69d1 with SMTP id
 r1-20020ad45761000000b00473786169d1mr21147659qvx.73.1658955072842; Wed, 27
 Jul 2022 13:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAA8EJpr2S-81+q-vjmk5i+T-JwaadkRpjCr_oGi7fMf7o3iH3A@mail.gmail.com>
 <20220727111410.bglx2u26456ray2u@bogus> <CAA8EJprNPJfGjkq2=hexbZn-=t2wKG6ZjSm5Mcbo4JuPQ-sc-A@mail.gmail.com>
 <CAA8EJpqP9XMcLP+Pmj5OnXD2_SJ9ULBZ_Q492+x56oQnPzqiUA@mail.gmail.com>
In-Reply-To: <CAA8EJpqP9XMcLP+Pmj5OnXD2_SJ9ULBZ_Q492+x56oQnPzqiUA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 27 Jul 2022 23:51:01 +0300
Message-ID: <CAA8EJppWSQTrZgN7yBLhLepuxEiFsBnkhcXOgXrz2qjGj3GcLw@mail.gmail.com>
Subject: Re: PSCI domains without OSI support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 Jul 2022 at 16:39, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 27 Jul 2022 at 16:24, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, 27 Jul 2022 at 14:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Wed, Jul 27, 2022 at 12:09:27PM +0300, Dmitry Baryshkov wrote:
>
> > > > - Allow DTS forcing the PSCI power domains even if OSI enablement fails?
> > >
> > > Meaning DTS flag for this ? If OSI enable fails, why would you want to
> > > still proceed. It is non-compliant and must be fixed if the firmware
> > > supports OSI and expects OSPM to use the same.
> >
> > I'm not sure at this moment. PSCI firmware reports that OSI mode is
> > supported, but then when psci_pd_try_set_osi_mode() tries to switch
> > into OSI mode, it gets NOT_SUPPORTED.
> > Just for the sake of completeness, I added a print to the psci.c to
> > dump the result of the psci_set_osi_mode(false). It also returns
> > NOT_SUPPORTED!
> >
> > My logical assumption would be that the firmware reports support for
> > OS_INITIATED, but then just fails to properly support
> > SET_SUSPEND_MODE.
>
> Okay. From the msm-3.14 commit log:
>
> Add support to terminate all low power modes in PSCI. The lpm-levels will
> work with version 1.0 of PSCI specification using the OS initiated scheme.
> The lpm-levels driver would determine the last man standing and vote into
> TZ accordingly.
>
> Which means that the vendor kernel expected to work in the OSI mode
> without calling SET_SUSPEND (such call doesn't exist in 3.14)

After adding the debugfs file, it's clear that this is the case.

Compare msm8996:
PSCIv1.0
SMC Calling Convention v1.0 is assumed
OSI is supported
Extended StateID format is used

vs sdm845:
PSCIv1.1
SMC Calling Convention v1.2
OSI is supported
Extended StateID format is used
CPU_FREEZE is supported
SET_SUSPEND_MODE is supported

Judging by people reporting 'failure to enable OSI mode' on several
other Qualcomm SoCs (msm8976, msm8953), this bug is present on several
older Qualcomm platforms.

>
> So, this looks like the "force-psci-domains" or "ignore-osi-error"
> flag would be logical.
> The question about testing still holds.

-- 
With best wishes
Dmitry
