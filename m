Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740B95B6181
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 21:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiILTIt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiILTIs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 15:08:48 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012542AEA
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 12:08:46 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-333a4a5d495so112716677b3.10
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PBuxdMIJGedDZd05zs/f/jp8HdD4J0iF/zmnT1wLkM8=;
        b=PyqBbUve7IYKpQ6eXW4wKk9nSq88BRzddnMBlWWuiACKDVm9VowwZeYqUV0i8VNs0F
         BXXZVU8QXfNUWTYmwURUzXLXJDwg3NdS9NvM+tUlEbS4Qtxog6NTJfy+suhgmC8rbaXU
         p3y0dqzyZIdvDqZCUUkb0NZRitK5wwiaYsOaVuE/ygAE46iIi4Mu2bCKNlNPrJZruaNG
         Z7wavJMndgsIYtA+h6eU8hYfHhfpoqfP1qetmCD+SuQ5LO1ljrWEHwD+t028JlYNpwcT
         gFX2DLWgWIPbIuHjspJ+l7a2gq8EFe65RvhNre/5rNqaBzlO1SyqpAPyQzmv1NRd5nNB
         56YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PBuxdMIJGedDZd05zs/f/jp8HdD4J0iF/zmnT1wLkM8=;
        b=qsMNI7Q0nReZGKJ4b1FalbHESelkmbdr6PMsgGkd/6rUsQ/NRZEjecICl5SkO2TPJZ
         ufORiKZvhAUPBew2sdX7j/cTBv4bm8oFIU/GhtNZJzvOVALE9fJbzD1hhyo/CYdv0U3S
         J/vmhKtTfW2O/+d/R8CrQMhgUKyjxYwPLEdqWGwco2tC8+45/OQlF3FiXyLdCA1KgNOM
         Xk0nyBpPLpUSpADZa0i1TX2AbDWi0F3/MpOFLOHPC+TuvFjMyI+hozOPSWWxEcD6hB/Q
         +66CBu0fgNBUeQ2yATAMeW+GHx5H7mV4a3xe/Fhj6N88plQ+nfnpsUuuwJYZ4HIAeftt
         aySQ==
X-Gm-Message-State: ACgBeo3idpz2RS1ojWewLqPSE+R7lqiMEZc9GJeuUZdom3CdmNGYCKL7
        FRghp3ZcqZYgZ69hcVjpikYArdkyLXM5RUzSbM22KQ==
X-Google-Smtp-Source: AA6agR7WT+jTNvariBjRh8IzBKOFyY8T7XsX4dwLbBG3JRqM+O0AgFncsTP9h73X8XTUz/PkgpZvL0c4PgFs6vFTGFg=
X-Received: by 2002:a81:6954:0:b0:344:e73e:5fde with SMTP id
 e81-20020a816954000000b00344e73e5fdemr23603847ywc.37.1663009725802; Mon, 12
 Sep 2022 12:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220911184232.3198957-1-bhupesh.sharma@linaro.org>
 <CAA8EJpoM5nW=pVJB4zy4Jh9Q3gE4KOju2QVy_WtmUokKMyXtuw@mail.gmail.com>
 <75a5789e-9100-b398-1df2-50d49823831c@linaro.org> <2f658a69-a49c-67be-26b9-421095cde2b7@linaro.org>
In-Reply-To: <2f658a69-a49c-67be-26b9-421095cde2b7@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 13 Sep 2022 00:38:34 +0530
Message-ID: <CAH=2NtyBCbrK-K4WEYeDg3UJ976q7818mvDwR2j3HCUNi6vAnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: Introduce CONFIG_QCOM_THERMAL in Makefile
 and qcom/Kconfig
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
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

On Mon, 12 Sept 2022 at 23:44, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 12/09/2022 20:11, Bhupesh Sharma wrote:
> >
> >
> > On 9/12/22 1:08 AM, Dmitry Baryshkov wrote:
> >> On Sun, 11 Sept 2022 at 21:42, Bhupesh Sharma
> >> <bhupesh.sharma@linaro.org> wrote:
> >>>
> >>> Introduce CONFIG_QCOM_THERMAL to allow better control
> >>> over selection of various Qualcomm Thermal drivers
> >>> available inside qcom/ directory.
> >>>
> >>> This is a preparatory change to allow new drivers to
> >>> be added inside qcom/ directory in a more structured
> >>> fashion.
> >>>
> >>> Cc: Bjorn Andersson <andersson@kernel.org>
> >>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>> Cc: Amit Kucheria <amitk@kernel.org>
> >>> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> >>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >>> ---
> >>>   drivers/thermal/Makefile     |  2 +-
> >>>   drivers/thermal/qcom/Kconfig | 12 ++++++++++++
> >>>   2 files changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> >>> index def8e1a0399c..a12b647be0d1 100644
> >>> --- a/drivers/thermal/Makefile
> >>> +++ b/drivers/thermal/Makefile
> >>> @@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)  += da9062-thermal.o
> >>>   obj-y                          += intel/
> >>>   obj-$(CONFIG_TI_SOC_THERMAL)   += ti-soc-thermal/
> >>>   obj-y                          += st/
> >>> -obj-$(CONFIG_QCOM_TSENS)       += qcom/
> >>> +obj-$(CONFIG_QCOM_THERMAL)     += qcom/
> >>
> >> Following other platforms around qcom, I think just `obj-y += qcom/`
> >> would work well enough.
> >
> > I have no strong opinion on using `obj-y += qcom/` here, but I would
> > still like us to define a CONFIG_QCOM_THERMAL like flag in the
> > qcom/Kconfig, similar to the ST platforms which use similar selection
> > mechanism via 'CONFIG_ST_THERMAL'.
>
> `QCOM_THERMAL' is fine for me.

Sure, let me send v2 accordingly.

Thanks,
Bhupesh
