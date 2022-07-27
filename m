Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4AE582798
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 15:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiG0NYh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 09:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiG0NYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 09:24:36 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AB0326E7
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 06:24:35 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id b21so12559386qte.12
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ILD3jhWMzdiJ0UnxmEqCyngtffCuYYLo3vFHeHzSO8E=;
        b=DLJBiRjcDRgTqQ+APm+zW7bpwc5qz4nKHXclIycWYZuqxNnm0JdIiREuTCp/9UPBR+
         J661FqlbkIWa0uw85l9nCRG0WJqg7HRcp4t3L57KwuzHtgEtqbZwxyTI0MPsXOqfNZy0
         VV5g3J1ugqLolgivF4VyKGVRm0MoL0jIuMWSpNm8qrbr1IlZGZziprR2Cd5hUZKsMnWQ
         VfWj27RfxjspxrVGRDe/8vB/RNhogLmWdj88vNyryj0EQEWEObOsLfCy6y98HbrMrFPG
         TDQfF4l9sxDYfhivjs5PdwFESA+OR5qp69yVSpQwHkwiQEiW9SZ9aa/8PAPxE4b9Cw33
         pd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ILD3jhWMzdiJ0UnxmEqCyngtffCuYYLo3vFHeHzSO8E=;
        b=yTytZiipfOOxkD8w0l+BhWAzDvwum+sueKEtCUji6fohTYY+8ZbHrub+OvM4SXh8K6
         EvKoPcHz9VVxtrp/Udud7EmDRfwZSNjYkKrzL2CB+m6VpAD8G4dnL1a9rUW4MtAJv+Cl
         NZpuo6ulXqcx8pf2gLMnXGF1kYt9NwQq3NGR3gVuTlB7ypwmopsvL9zFBc/yhJLwD1He
         wOTInXS3bQme7Q99fgSAfPq89Z8NrNlvDAigjmtYfkvmfAJz+Z72oZYa1T2Cpq42cD0f
         +i7wUvuokUD/jeH+8lm3cXzAnHDpthlJgjfITxdAiRVn340VCl5x44U/DYsU5DykBXrj
         gUHg==
X-Gm-Message-State: AJIora/8zAkG5TW3cMquukKPnNXKUEBn2kKFaiOTv+QBW5Qb8s0sztb0
        yDYv4W+VAToQMEQPSi89jin9+RwR8g82ESR1lkdJ/g==
X-Google-Smtp-Source: AGRyM1s2IGOa6eZ4KDwsiroGfmTfXl4fNPiIcS4Py1GAfQE9djxZ0Q54MmpvAJ546bfgLsfuQi9oeBE2J17Eb4XAoaE=
X-Received: by 2002:a05:622a:178a:b0:31e:f9ff:c685 with SMTP id
 s10-20020a05622a178a00b0031ef9ffc685mr19041474qtk.62.1658928274125; Wed, 27
 Jul 2022 06:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAA8EJpr2S-81+q-vjmk5i+T-JwaadkRpjCr_oGi7fMf7o3iH3A@mail.gmail.com>
 <20220727111410.bglx2u26456ray2u@bogus>
In-Reply-To: <20220727111410.bglx2u26456ray2u@bogus>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 27 Jul 2022 16:24:22 +0300
Message-ID: <CAA8EJprNPJfGjkq2=hexbZn-=t2wKG6ZjSm5Mcbo4JuPQ-sc-A@mail.gmail.com>
Subject: Re: PSCI domains without OSI support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 Jul 2022 at 14:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jul 27, 2022 at 12:09:27PM +0300, Dmitry Baryshkov wrote:
> > Hi,
> >
> > Lately I have been working on improving the msm8996 platform support.
> > Vendor kernel seems to support domain-like idle (see [1], [2]).
> > However when I tried changing upstream msm8996.dtsi to use PSCI
> > domains, I faced the firmware reporting NOT_SUPPORTED to an attempt to
> > enable OSI (thus rendering PSCI domains useless, as they are now
> > marked with ALWAYS_ON).
> >
>
> That's not good to hear =F0=9F=99=81.
>
> > I noticed that vendor kernel makes a call to cpu_suspend() with
> > power_state following the original format (described in PSCI spec
> > 5.4.2.1). What would be the best way to support this?
>
> And why is this not possible with the existing code ? Not sure if I
> understood it right, I am assuming you are mentioning that it is not
> possible.

It's not possible with the cpuidle-psci-domains.c. The driver marks
all genpds as ALWAYS_ON, thus making sure that they are never
suspended.

> > - Allow DTS forcing the PSCI power domains even if OSI enablement fails=
?
>
> Meaning DTS flag for this ? If OSI enable fails, why would you want to
> still proceed. It is non-compliant and must be fixed if the firmware
> supports OSI and expects OSPM to use the same.

I'm not sure at this moment. PSCI firmware reports that OSI mode is
supported, but then when psci_pd_try_set_osi_mode() tries to switch
into OSI mode, it gets NOT_SUPPORTED.
Just for the sake of completeness, I added a print to the psci.c to
dump the result of the psci_set_osi_mode(false). It also returns
NOT_SUPPORTED!

My logical assumption would be that the firmware reports support for
OS_INITIATED, but then just fails to properly support
SET_SUSPEND_MODE.
I should probably try ignoring the error psci-domain.c and continue
with binding power domains. What would be the best way to check that
the domains setup works as expected?

>
> > - Add a separate cpuidle driver?
>
> I would avoid that.
>
> > - Just forget about it and use plain PSCI as we currently do?
> >
>
> Worst case yes. My main worry is how many of the old SDM SoC has such a
> behaviour and how much they wary from each other. The OSI mode was pushed
> after lengthy discussions to support all these platforms and now we have
> platforms needing separate idle driver ?

I'm not sure. 32-bit SoCs use non-PSCI idle driver. MSM8916, sdm845
and later SoCs are using proper domains support.
I tested the sdm660, it looks like it can work with the power domains.
So this leaves only MSM8992/4/8 in question (at least from the
platforms that are supported by the mainline).

>
> > Additional topic: for one of idle states the vendor kernel uses a
> > proprietary call into the hypervisor ([3]).
>
> Again I would say it is not spec compliant.

Yes, of course. Otherwise there would not be such a question.
Judging from the vendor kernels, this call is limited to 8996 only.

>
> > Up to now we have ignored this, as 8996 seems to be the only platform u=
sing
> > it. I suppose that adding it to cpuidle-psci.c would be frowned upon.
>
> Indeed.
>
> > Is this assumption correct? Would it add another point for adding a sep=
arate
> > cpuidle driver?
> >
>
> I am getting a sense that this would be cleaner approach but I would like
> to understand how much of these non-compliance is carried to the other
> relatively newer SoCs. I understand this is atleast 5-6+ years old. I don=
't
> want this to set example to deviate from standard driver by adding new
> drivers though they all are supposedly using PSCI(and are not fully compl=
iant)

At this moment I fear that it might be limited to msm8996 only. Maybe
including 8992/4/8.

--=20
With best wishes
Dmitry
