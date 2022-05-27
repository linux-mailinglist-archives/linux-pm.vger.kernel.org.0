Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BCB5357E0
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiE0Cwp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiE0Cwo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:52:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F67B7092F
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 19:52:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so3022486plg.5
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 19:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UPWllmKFo1Fw7F8K8QyAtjfx5pfLC29DKjd5hqqB6l8=;
        b=bdN+v1sL1z2M3MueFSRDkPG096pydIpu4/sAPisOwXk3kcyDJZ2weWtHQXahw2H0qB
         xhKd9yg1TyUJDznvecx3046et2KPweRm65BTVgatKLS7rrTAVbYt8tqf6/iUWfX+Wszu
         K9etpaWkB4D9WJVUkGypFfWIYOIQFBE3OvU8EVpl+boH8+mUcdvaK0PuV+bEU2NLUKrH
         ClL1mVgYLMJJ002pLbDTCAX/PLuXVQLtd7gR9BRK8VHpJHm8aFp2Ya3LZZ+bx5PlN+CQ
         AShCZCo3YtO6KnhdCJDPrjEa2aLqmeqNq3XxrPfZaHLcog+Y9y2XQ6HepHCNZYCTtCAe
         I1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UPWllmKFo1Fw7F8K8QyAtjfx5pfLC29DKjd5hqqB6l8=;
        b=rxyOjdb2Oru+5sys2UmKgSeeaGtZKyz2r2lGtACYZubbohFd+yXWf0g4bd0xH/p7jA
         AfbXWg3d7Qko4CO0IjKZWYIiRyM7hUYNgQ9+9u0TDwBnJATV/CYBS4u2FetucbnFPYqz
         KFBHXs31HvjIlp5DjfQaUR8wSIkYBil+p+TgZf3CU+ZjlPXGz5eSzQB20DiTJLOhcahi
         +9g9ExxBUlOgBNrIlZFO4ijHs/cFOsKEJeK17oZFx0rVNkRbJcv9b251XaxGdvj3bYg4
         q7biwte6VlXOSI4x39XTEbha5OaSBeoB92kznUsf3ghd47wHaGeMFl5iTS+j2Iw7ms5n
         6Nig==
X-Gm-Message-State: AOAM5308W6VMHJyY9unvbgq5Sx7Z+HX4zSXVB/O92joqpBJNiRbhrqfK
        rwcXopW6f7unWFpluI+DxO2ybA==
X-Google-Smtp-Source: ABdhPJxyHwzoH3uH4iRF2pEttIVuof6Vk3DBuB1LyJpSMZetrq9DJ5F73X6BavnXDj6bkZBngRRBzg==
X-Received: by 2002:a17:90b:4d8b:b0:1dc:aebe:4c8b with SMTP id oj11-20020a17090b4d8b00b001dcaebe4c8bmr5869036pjb.145.1653619963586;
        Thu, 26 May 2022 19:52:43 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b0015e8d4eb2adsm2362804pll.247.2022.05.26.19.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:52:43 -0700 (PDT)
Date:   Fri, 27 May 2022 08:22:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/31] soc/tegra: Remove the call to
 devm_pm_opp_set_clkname()
Message-ID: <20220527025241.z5b5yxjowjzerk5a@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <1e88b248352afe03cd3bf0e887b1f2be86b5afb5.1653564321.git.viresh.kumar@linaro.org>
 <45c29859-f7a6-48e5-be48-bd8191ac299a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45c29859-f7a6-48e5-be48-bd8191ac299a@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-05-22, 20:57, Dmitry Osipenko wrote:
> On 5/26/22 14:42, Viresh Kumar wrote:
> > The OPP core already performs devm_pm_opp_set_clkname() with name as
> > NULL, the callers shouldn't be doing the same unless they have a
> > different clock name to add here.

This is confusing. Updated this as:

    The OPP core already performs clk_get(dev, NULL) by default for everyone
    and the callers shouldn't try to set clkname unless they have an actual
    clock name to add here.


> > 
> > Drop the call.
> > 
> > Cc: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/soc/tegra/common.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> > index 32c346b72635..49a5360f4507 100644
> > --- a/drivers/soc/tegra/common.c
> > +++ b/drivers/soc/tegra/common.c
> > @@ -108,12 +108,6 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
> >  	u32 hw_version;
> >  	int err;
> >  
> > -	err = devm_pm_opp_set_clkname(dev, NULL);
> > -	if (err) {
> > -		dev_err(dev, "failed to set OPP clk: %d\n", err);
> > -		return err;
> > -	}
> > -
> >  	/* Tegra114+ doesn't support OPP yet */
> >  	if (!of_machine_is_compatible("nvidia,tegra20") &&
> >  	    !of_machine_is_compatible("nvidia,tegra30"))
> 
> I can't see where OPP core performs devm_pm_opp_set_clkname().

Sorry about that, it is clk_get() it performs from
_update_opp_table_clk().

I don't think you need to call devm_pm_opp_set_clkname() here, but
lets see if this breaks anything for you.

-- 
viresh
