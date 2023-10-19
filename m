Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3B37CFC35
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 16:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345906AbjJSONg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345786AbjJSONf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 10:13:35 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E318CF
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 07:13:33 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso9056800276.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697724812; x=1698329612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ1gUWflsYcH8PP7UpBaAv9qlHVSJ/Dr4WGMpYeMC38=;
        b=aLkmPGz9sgBNn8lqUAvy1cZXgicYCPPiOzkvpvUraNZxE/kG8kWFT3NpqHCKTuTdKj
         sq+96OOQbNp6bNtr8+r9H0lG8wU65fX251xfa5ZzHsP46oIr4U7v9us4WzSJPGqBGmNu
         RE9U1VpuUt6iRUNIyXNmBbulq4hWfMryDeYBZBwW5Ipg116tRB9TiPuXC2EL+ecDZSg4
         T3xIrAHAtmrZW0fOj/p04fJpV3WzMZWaMm68NsBHdgwL2WSyZhaspI3/hxcc9NeCoS38
         Eqs+sh7dymslX9i9PSCuvJ9+mWS/S78/DunckO/cH5X1CcLdD+QqWancpx1/Q45o29lm
         wObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697724812; x=1698329612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZ1gUWflsYcH8PP7UpBaAv9qlHVSJ/Dr4WGMpYeMC38=;
        b=uXcPQFkSoGCCwEBuhNvd/jCAgymzwCYe2brA30PxPs0kGRaAmb1f2lWmxwp7mHCw7F
         52g9Zw+7p37hrdi3QxInyAerj5mJYDeYuZFauQQBwSPlATvsv/cnhdV3HE4KV6EiE9jc
         6RLK8W0qsw/XMeyM2VUFb9CiY9SoaEfQMXz23/i5GTJWlDnYzbHktWV4EyOX4nG8TjZb
         lUej+4NYC7mrX8Ypojt83N6fKg8hRSCiZrPsdyLM7hfeWTQqxvd7ip1LmnbyiRmiPXJg
         2DqMGKmJZA08JrnA3dDCFrRzC1R37271dzOaY4StNybphOv+pXk4EzMnuS/PRJMaG3rj
         r+6w==
X-Gm-Message-State: AOJu0YzMD6GGKnkYmmxYv8sI93JPruz5dCJlS8SDEtsvePSYnwBRquge
        AjiFhlAqc531kNMWiA3QK9wJoBLdC9os7tD5IznFUg==
X-Google-Smtp-Source: AGHT+IFVaisEaUxifZNFQFOjPZkY0wGroDE2WXhfIoEzu0BM1WVOjIVDHR0lnPr069ziHZ4TgS1mlvhyHgpbYnanoEE=
X-Received: by 2002:a5b:404:0:b0:d9c:7d7d:1ac9 with SMTP id
 m4-20020a5b0404000000b00d9c7d7d1ac9mr2623857ybp.14.1697724812298; Thu, 19 Oct
 2023 07:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
 <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
 <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com> <ZTEph19CAvbgbN_E@gerhold.net>
In-Reply-To: <ZTEph19CAvbgbN_E@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 16:12:56 +0200
Message-ID: <CAPDyKFo1PVZYsdW_=92EtMmTT9hmkm-mBR69N_WvPh4f-Hw=NA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] cpufreq: qcom-nvmem: Enable virtual power domain devices
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Oct 2023 at 15:05, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Thu, Oct 19, 2023 at 01:26:19PM +0200, Ulf Hansson wrote:
> > On Thu, 19 Oct 2023 at 12:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Wed, 18 Oct 2023 at 10:06, Stephan Gerhold
> > > <stephan.gerhold@kernkonzept.com> wrote:
> > > >
> > > > The genpd core caches performance state votes from devices that are
> > > > runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
> > > > runtime PM performance state handling"). They get applied once the
> > > > device becomes active again.
> > > >
> > > > To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
> > > > calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
> > > > devices that use runtime PM only to control the enable and performance
> > > > state for the attached power domain.
> > > >
> > > > However, at the moment nothing ever resumes the virtual devices created
> > > > for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
> > > > means that performance state votes made during cpufreq scaling get
> > > > always cached and never applied to the hardware.
> > > >
> > > > Fix this by enabling the devices after attaching them and use
> > > > dev_pm_syscore_device() to ensure the power domains also stay on when
> > > > going to suspend. Since it supplies the CPU we can never turn it off
> > > > from Linux. There are other mechanisms to turn it off when needed,
> > > > usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).
> > >
> > > I believe we discussed using dev_pm_syscore_device() for the previous
> > > version. It's not intended to be used for things like the above.
> > >
>
> Sorry, looks like we still had a misunderstanding in the conclusion of
> the previous discussion. :')
>
> > > Moreover, I was under the impression that it wasn't really needed. In
> > > fact, I would think that this actually breaks things for system
> > > suspend/resume, as in this case the cpr driver's genpd
> > > ->power_on|off() callbacks are no longer getting called due this,
> > > which means that the cpr state machine isn't going to be restored
> > > properly. Or did I get this wrong?
> >
>
> We strictly need the RPMPDs to be always-on, also across system suspend
> [1]. The RPM firmware will drop the votes internally as soon as the
> CPU(s) have entered deep cpuidle. We can't do this from Linux, because
> we need the CPU to continue running until it was shut down cleanly.
>
> For CPR, we strictly need the backing regulator to be always-on, also
> across system suspend. Typically the hardware will turn off the
> regulator as soon as the CPU(s) enter deep cpuidle. Similarly, we can't
> do this from Linux, because we need the CPU to continue running until it
> was shut down cleanly.
>
> My understanding was that we're going to pause the CPR state machine
> using the system suspend/resume callbacks on the driver, instead of
> using the genpd->power_on|off() callbacks [2]. I can submit a separate
> patch for this.

If we are going to do 1) as described below, this looks to me that
it's going to be needed.

How will otherwise the cpr state machine be saved/restored during
system suspend/resume? Note that, beyond 1), the genpd's
->power_on|off() callbacks are no longer going to be called during
system suspend/resume.

In a way this also means that the cpr genpd provider might as well
also have GENPD_FLAG_ALWAYS_ON set for it.

>
> I didn't prioritize this because QCS404 (as the only current user of
> CPR) doesn't have proper deep cpuidle/power management set up yet. It's
> not entirely clear to me if there is any advantage (or perhaps even
> disadvantage) if we pause the CPR state machine while the shared L2
> cache is still being actively powered by the CPR power rail during
> system suspend. I suspect this is a configuration that was never
> considered in the hardware design.

I see.

>
> Given the strict requirement for the RPMPDs, I only see two options:
>
>  1. Have an always-on consumer that prevents the power domains to be
>     powered off during system suspend. This is what this patch tries to
>     achieve.
>
> Or:
>
>  2. Come up with a way to register the RPMPDs used by the CPU with
>     GENPD_FLAG_ALWAYS_ON. This would also be doable, but isn't as
>     straightfoward as "regulator-always-on" in the DT because the rpmpd
>     DT node represents multiple genpds in a single DT node [3].

Yes, it sounds like it may be easier to do 1).

>
> What do you think? Do you see some other solution perhaps? I hope we can
> clear up the misunderstanding. :-)

Yes, thanks!

>
> [1]: https://lore.kernel.org/linux-arm-msm/ZQGqfMigCFZP_HLA@gerhold.net/
> [2]: https://lore.kernel.org/linux-arm-msm/CAPDyKFoiup8KNv=1LFGKDdDLA1pHsdJUgTTWMdgxnikEmReXzg@mail.gmail.com/
> [3]: https://lore.kernel.org/linux-arm-msm/ZSg-XtwMxg3_fWxc@gerhold.net/
>
> > BTW, if you really need something like the above, the proper way to do
> > it would instead be to call device_set_awake_path() for the device.
> >
> > This informs genpd that the device needs to stay powered-on during
> > system suspend (assuming that GENPD_FLAG_ACTIVE_WAKEUP has been set
> > for it), hence it will keep the corresponding PM domain powered-on
> > too.
> >
>
> Thanks, I can try if this works as alternative to the
> dev_pm_syscore_device()!

Yes, please. We don't want to abuse the dev_pm_syscore_device() thingy.

>
> I will wait for your thoughts on the above before accidentally going
> into the wrong direction again. :-)

No worries, we are moving forward. :-)

Kind regards
Uffe
