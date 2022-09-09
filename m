Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E705B3613
	for <lists+linux-pm@lfdr.de>; Fri,  9 Sep 2022 13:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIILMn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Sep 2022 07:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIILMn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2022 07:12:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C330AA369
        for <linux-pm@vger.kernel.org>; Fri,  9 Sep 2022 04:12:41 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v6so1451763ljj.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2022 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=e+uTv/SYWGWMl5U3Nr6CC1Ub+MvpDQLyrmA9O8Tyh4Y=;
        b=FcZuQ3uTMYxzo2v4vfDYBxVw7navKQalV0dbZhxoIflG8rhAtD+jXeeRLSy7k4ZTzZ
         PQxqEoDCxIqiZsJGroAS48r2Lb1Yj0+UUro192bIAWUSquTuTU1EsMMohkfc4QXl2Jh9
         3u8KQ9AZfQKRglHkMd04guKunCZldg8gcl59GTnx4vFqVxB3frYrr82ncnWXcvaEIWjZ
         lVtq5pnQnkx01ZNAeQikkZMh+nqm+oiGafb8Cgfidy+DnN/r6b085cmTSVlwcuyQ5VnQ
         FAjevdPM3JZEP7vEFNt5I5v6nzVpdm3hiIQtJ+39up+fwwqkvWalawTywuK00BAx4hFH
         JX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=e+uTv/SYWGWMl5U3Nr6CC1Ub+MvpDQLyrmA9O8Tyh4Y=;
        b=vbyDMqUJ2swsh2JYZNIVzYdQRF8PIDL+4MO/OZsGZfShXhQGFmw0E9AmdxDa4WrL4R
         5mZlVpY/gqM0dYZC1V8uXLCHEX/0S8F6WvipoXlMlfQLB+quy9EuF3APMNh9FIA7fqv7
         yGTAO2sMxHvs5OxvkaU2rWggG0PWtYMp/17LhxO2TZv0LOBL1FJ3d64hin1TLPr9P6HW
         ccgeHSHoKdRg22hXzv0JPDsVGFqmp0fmRtDiXLmMH/avX03Xsw8rmWC1HeYcQJ65Nzz0
         tLyA1HRvowK6lvoNwtnXvRFj1WWcmDKM/IFyHNuoXhmfUbb1xEsWDbEAea+u0b3mU1vx
         ctdg==
X-Gm-Message-State: ACgBeo3dFmuyYZ6LUHXzbdLcOVy2Y3ybyv0ZUFhORCy9CCRAdFmRqTzx
        dF7yCwozyGcQC+9NKScLUaLHvpfz9hVVgV9SyOsHqQ==
X-Google-Smtp-Source: AA6agR5K28NAXhLVQ3AZ/+iCEqL6L1kZX7Yk63olKpzdzJUqX31SgMjxUDnsSiME8sI3TF1Qsysh+Qa1rqzhOUO7BrY=
X-Received: by 2002:a2e:938f:0:b0:26a:d228:50d1 with SMTP id
 g15-20020a2e938f000000b0026ad22850d1mr2750810ljh.300.1662721959956; Fri, 09
 Sep 2022 04:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com> <20220908173840.rqy335cdeg5a2ww5@bogus>
In-Reply-To: <20220908173840.rqy335cdeg5a2ww5@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Sep 2022 13:12:03 +0200
Message-ID: <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
Subject: Re: Question: why call clk_prepare in pm_clk_acquire
To:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>
Cc:     "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "npitre@baylibre.com" <npitre@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 8 Sept 2022 at 19:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > Hi All,
> > >
> > > We are facing an issue clk_set_rate fail with commit a3b884cef873 ("firmware:
> > > arm_scmi: Add clock management to the SCMI power domain") ,
> >
> > Hmm, I wonder about the main reason behind that commit. Can we revert
> > it or is there some platform/driver that is really relying on it?
> >
>
> IIUC, at the time of the commit, it was needed on some Renesas platform.
> Not sure if it is still used or not.

Okay! Maybe Nico remembers more, as he authored the patch...

Normally it's best decided on a platform basis, whether it really
makes sense to use the GENPD_FLAG_PM_CLK. As the scmi power domain is
a cross platform power domain, it worries me that we lose some needed
flexibility, which is likely to make it more difficult to use it for
some platforms. Also note, the main point behind GENPD_FLAG_PM_CLK,
was just to consolidate code.

That said, I decided to do some research, by looking at the DTS files
in the kernel. So far, there is only Juno and the imx8 based
platform(s) that are using the scmi power domain.

For the imx8 based platforms [1], there are only three consumers
(three mmc controllers) of the scmi power domain ("scmi_devpd"). The
corresponding mmc host driver is the
drivers/mmc/host/sdhci-esdhc-imx.c, which needs to handle the clocks
itself. I assume this is the one Peng is referring to.

>
> > >
> > > we use scmi power domain, but not use scmi clk, but with upper commit, the clk is prepared
> > > when pm_clk_acquire.
> > >
>
> Is this based on latest SCMI clocks that support atomic or older one
> which doesn't. If latter, I see pm_clk_acquire doesn't actually call
> prepare as if clk_is_enabled_when_prepared(clk) = true. Do you see have
> issue ?

It doesn't really matter if we would be using an atomic clock or not.

The problem is that when using GENPD_FLAG_PM_CLK, during runtime
resume (genpd_runtime_resume) we end up calling pm_clk_resume(), but
prior invoking the consumer driver's ->runtime_resume() callback. In
other words, the clock(s) will already be prepared and enabled when
the driver's ->runtime_resume() callback gets invoked. That certainly
isn't going to work for all cases.

In this particular case, sdhci_esdhc_runtime_resume() needs to make
some preparations before it can prepare/enable the clocks (it calls
clk_set_rate() for example).

>
> > > However the clk has flag CLK_SET_RATE_GATE, clk_set_rate will fail in driver, because
> > > clk is prepared in pm_clk_acquire.
> > >
>
> Where is CLK_SET_RATE_GATE set exactly ?
>
> > > Looking into drivers/base/power/clock_ops.c, I see pm_clk_suspend/pm_clk_resume
> > > will handle clk prepare/unprepared, so why pm_clk_acquire will also prepare the clk?
> >
>
> As asked above do you see the actual clk_prepare getting called as I
> see it isn't if lk_is_enabled_when_prepared(clk) = true.
>
> > I agree, the behaviour is certainly questionable to me too. However,
> > it may be tricky to change by now, due to the deployment that has
> > happened over the years.
> >
>
> Agreed.
>
> > In principle we would need to make the part where pm_clk_acquire
> > prepares the clock to become optional, in some clever way.
> >
>
> I see it is already, let us see what is Peng's observation.

Yes, good point, I didn't notice that! However, as stated above, it
seems like it doesn't really matter.

In my opinion we should really try to move away from using
GENPD_FLAG_PM_CLK for the scmi power domain. I can prepare a patch, if
you think it makes sense?

>
> --
> Regards,
> Sudeep

Kind regards
Uffe
