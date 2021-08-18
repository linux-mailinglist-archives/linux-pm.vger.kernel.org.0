Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F783F0193
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 12:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhHRK1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 06:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhHRK1V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Aug 2021 06:27:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E0C0613D9
        for <linux-pm@vger.kernel.org>; Wed, 18 Aug 2021 03:26:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso1990835pjy.5
        for <linux-pm@vger.kernel.org>; Wed, 18 Aug 2021 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZNayMdDzsTU4VQhyOZa4GnMMXCUMiePI+13ZGnlmmzg=;
        b=Jp/CDseKWqk8INe784MZtJm/kuPSCITNFKon/NYIe2U0JVPLMLOPgxLpNl3PIJlNHJ
         WjJqtALcc6aUc3zlFm5BcOPXapgBXE5V6p3C9NckTD/rH2mhhhGYY1kmFFp5YZ+aLpTi
         UzTYdY9ycuCsmTZ44Cl4fBZewPS1vS2DRCNq4NCrq228zueWF+PwnfsJOJND3ByZ7mWv
         B8jKa/DjvGoKGDyOy7Ze/lT6B7GLgHGVoN3AMXnepTPS4oLCSTcF7NUJ7ewUkHtRPV7t
         DuzEwtEunJF09D7d2XcdQkh6BBUb2xb+DAgMNpXKo9v4Ga/0UsKX/ohYovhkSldE6mCz
         71Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZNayMdDzsTU4VQhyOZa4GnMMXCUMiePI+13ZGnlmmzg=;
        b=BvciHV2soiEbYYzJzxhJqGTVMpb3iiDGfd7DrsGuXl0v1Yo+IjKDDnt1eBFATIiZE9
         6aBkiLxOGQpONgZA3NCIfbqPLT0EfMltKikdJj7TWm1oxheXCTMsQYAXffvsShyiQ+V0
         mTInci+Ubfx90iELYBIPK2twd8fl3CG9DAAIvsyYdLl2Kh2ifD51sno0kmYVoTlJ87J9
         v2VUHFaNVGOtc4RXPOYR68i1HwtCAYhtBcxC9U4amOx+yesxffRfD6dMH3+63zkGMS0T
         OF8qHbL45LbteOrS9XU/rneX+2QOmADauC1vpwsO6Iq6a8uZI6WYlmJNNtvFDWfXAsRL
         PuTQ==
X-Gm-Message-State: AOAM533l892eqgyF+xHqnMZ1yPe0YBvxQtKp2m8OQnEBdAgNWsKGuVUT
        etKnxtP9e6E3XI23TBYCgvKxZw==
X-Google-Smtp-Source: ABdhPJzBj/LQChQPW3D7Z6q670orrn218cjqru6OfG4Kj8M0CWWcYYzlWDZddjbT1OvCf3GKyFPeoQ==
X-Received: by 2002:a17:902:8bc4:b029:12b:8470:e29e with SMTP id r4-20020a1709028bc4b029012b8470e29emr6805469plo.2.1629282406597;
        Wed, 18 Aug 2021 03:26:46 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id r16sm4998664pje.10.2021.08.18.03.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 03:26:46 -0700 (PDT)
Date:   Wed, 18 Aug 2021 15:56:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2] cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu
 cpufreq driver flag
Message-ID: <20210818102644.v2ob46azq47beeqg@vireshk-i7>
References: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
 <CAD=FV=UF1MMKg9Y0HD3xpZ36BVZyuzr3xkwXzeSz__T1XD1r=w@mail.gmail.com>
 <77dde5fa-6b12-d970-ac3e-0d3f6c352fbe@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77dde5fa-6b12-d970-ac3e-0d3f6c352fbe@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-08-21, 15:33, Taniya Das wrote:
> Hi Doug,
> 
> Thanks for your review.
> 
> On 8/13/2021 2:03 AM, Doug Anderson wrote:
> > Hi,
> > 
> > On Thu, Aug 12, 2021 at 7:19 AM Taniya Das <tdas@codeaurora.org> wrote:
> > > 
> > > As remote cpufreq updates are supported on QCOM platforms, set
> > > dvfs_possible_from_any_cpu cpufreq driver flag.
> > > 
> > > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > > ---
> > > 
> > > [v2]
> > >    * update the dvfs_possible_from_any_cpu always.
> > > 
> > >   drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > index f86859b..53d3898 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > @@ -223,6 +223,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
> > > 
> > >          table[i].frequency = CPUFREQ_TABLE_END;
> > >          policy->freq_table = table;
> > > +       policy->dvfs_possible_from_any_cpu = true;
> > > +
> > 
> > Why is this in the qcom_cpufreq_hw_read_lut() function? Shouldn't it
> > be straight in qcom_cpufreq_hw_cpu_init()?
> > 
> All CPU policy related data is updated here, thus wanted to keep it
> together.

This function should only be updating freq table, please do it in
qcom_cpufreq_hw_cpu_init() itself, around where you set
policy->driver_data.

-- 
viresh
