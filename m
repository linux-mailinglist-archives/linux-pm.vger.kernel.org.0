Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3951C2AEC62
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 09:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKKIw6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 03:52:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41068 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgKKIw5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 03:52:57 -0500
Received: by mail-ed1-f66.google.com with SMTP id t9so1434312edq.8;
        Wed, 11 Nov 2020 00:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FR2fk7Xv4lSmlOc9Dd3jcBxGV7rUmCYq9p4pf48MgkE=;
        b=tox7I0j/B7PNhimf9a/kzxON4iMlFC7xWD/Lpw7EATJfO1VEDVXvUe87/rdgBcu0Vf
         FhXEuczvHuXub5YMuen2Racx++0oncxhhvxyNV2+VTnJDfqGHfHlIEv6XWcdKN6rihnx
         lIsGN1wZUycIcajeVsMjILEUgJxgZT//WNK2KnQC9sjCfclJ5nXRot2B5a5tL4FK7PU5
         sZ0xAmNQySb9QnAlBvOHlqa/flu2cg2v70QllNuNfVO25A+HCB5ALuRYvk0yO857M2FH
         4vb94Y20ejL0AVFN9WcaZCgkexUFtGTXME2JNlKdo7SSTeB5Nut616dE0D2T3bmj6hQm
         7D/w==
X-Gm-Message-State: AOAM530Q0zgLIQibVOLYD1cJ+s8L/Ul/PGS4bS+I67xMiL/EXRI7L9A1
        1uMcSSPf4qoPMyK2OF3L6Cg=
X-Google-Smtp-Source: ABdhPJwji6ikeI/Mly+Q6njYPrhT9ggbKIXuArTDm7S8d2rj8FwDw4fd/HOZiSUe1NQbAdVvsnmJTA==
X-Received: by 2002:a05:6402:54c:: with SMTP id i12mr26442371edx.9.1605084774010;
        Wed, 11 Nov 2020 00:52:54 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id f19sm596038edm.70.2020.11.11.00.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 00:52:52 -0800 (PST)
Date:   Wed, 11 Nov 2020 09:52:50 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 10/26] memory: tegra30-emc: Factor out clk
 initialization
Message-ID: <20201111085250.GA11589@kozik-lap>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-11-digetx@gmail.com>
 <20201111085115.GA4050@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111085115.GA4050@kozik-lap>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 09:51:15AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Nov 11, 2020 at 04:14:40AM +0300, Dmitry Osipenko wrote:
> > Factor out clk initialization and make it resource-managed. This makes
> > easier to follow code and will help to make further changes cleaner.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/memory/tegra/tegra30-emc.c | 70 ++++++++++++++++++++----------
> >  1 file changed, 47 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
> > index d27df842a667..1df42e212d73 100644
> > --- a/drivers/memory/tegra/tegra30-emc.c
> > +++ b/drivers/memory/tegra/tegra30-emc.c
> > @@ -1550,6 +1550,49 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
> >  	return err;
> >  }
> >  
> > +static void devm_tegra_emc_unset_callback(void *data)
> > +{
> > +	tegra20_clk_set_emc_round_callback(NULL, NULL);
> > +}
> > +
> > +static void devm_tegra_emc_unreg_clk_notifier(void *data)
> > +{
> > +	struct tegra_emc *emc = data;
> > +
> > +	clk_notifier_unregister(emc->clk, &emc->clk_nb);
> > +}
> > +
> > +static int tegra_emc_init_clk(struct tegra_emc *emc)
> > +{
> > +	int err;
> > +
> > +	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
> > +
> > +	err = devm_add_action_or_reset(emc->dev, devm_tegra_emc_unset_callback,
> > +				       NULL);
> > +	if (err)
> > +		return err;
> > +
> > +	emc->clk = devm_clk_get(emc->dev, NULL);
> > +	if (IS_ERR(emc->clk)) {
> > +		dev_err(emc->dev, "failed to get EMC clock: %pe\n", emc->clk);
> > +		return PTR_ERR(emc->clk);
> > +	}
> > +
> > +	err = clk_notifier_register(emc->clk, &emc->clk_nb);
> > +	if (err) {
> > +		dev_err(emc->dev, "failed to register clk notifier: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	err = devm_add_action_or_reset(emc->dev,
> > +				       devm_tegra_emc_unreg_clk_notifier, emc);
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> > +}
> > +
> >  static int tegra_emc_probe(struct platform_device *pdev)
> >  {
> >  	struct device_node *np;
> > @@ -1599,25 +1642,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
> >  		return err;
> >  	}
> >  
> > -	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
> > -
> > -	emc->clk = devm_clk_get(&pdev->dev, "emc");
> > -	if (IS_ERR(emc->clk)) {
> > -		err = PTR_ERR(emc->clk);
> > -		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
> > -		goto unset_cb;
> > -	}
> > -
> > -	err = clk_notifier_register(emc->clk, &emc->clk_nb);
> > -	if (err) {
> > -		dev_err(&pdev->dev, "failed to register clk notifier: %d\n",
> > -			err);
> > -		goto unset_cb;
> > -	}
> > +	err = tegra_emc_init_clk(emc);
> > +	if (err)
> > +		return err;
> >  
> >  	err = tegra_emc_opp_table_init(emc);
> >  	if (err)
> > -		goto unreg_notifier;
> > +		return err;
> >  
> >  	platform_set_drvdata(pdev, emc);
> >  	tegra_emc_rate_requests_init(emc);
> > @@ -1632,13 +1663,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
> >  	try_module_get(THIS_MODULE);
> >  
> >  	return 0;
> > -
> > -unreg_notifier:
> > -	clk_notifier_unregister(emc->clk, &emc->clk_nb);
> 
> You added this code in patch #8, so adding-and-removing a piece of code

Correction: you added this in patch #9.

Best regards,
Krzysztof


> is a nice hint that this patch should be before. Don't add new code
> which later you simplify. Move all bugfixes and all simplifications to
> beginning of patchset.
> 
> That's quite similar case to v6 where you put bugfixes in the middle
> of patchset.
> 
