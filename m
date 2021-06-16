Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC63A9593
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhFPJL4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 05:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPJLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 05:11:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC52C06175F
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 02:09:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h12so798530plf.4
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9w7ZTV6yWNrNwxmRQy6ya4uTIZcLI/zS8kXrTBt5qy8=;
        b=iU9mcGeWG87d6JdabVeozGFoOixe9OQ1VFaqtBc++lbKGlit5i8G4ws+FP3uEVrAxF
         d5BZrzQjVupNBRIgGX0IpWAdeLhWOcCXVgZSYVcMFQi8wD8jYfkAlSFhUawkOFAc5/7/
         ayl2Bfa4Ot5/viPkVcFVJQcMYRWNuuG7500/EHEsP3zrM14x3/4q1Phbp5AxWIWroIy0
         wG0lrEor9+aZSsLGgya3bnDcnhLZlqg2fpoupq5xBYTOs0dXM0Y5rHBWeLPE78C4UcBv
         eXoMqWs8xDbQ2vjE4u805AdO8eaycDDPcjykltUeDemer2iAnWPKc4FNij+rLjPgCEWH
         i24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9w7ZTV6yWNrNwxmRQy6ya4uTIZcLI/zS8kXrTBt5qy8=;
        b=FwtQe/WqpRA7umMpIQnxEVzbNORu64lAnpsGR4D2SouP/wks73f3pNGGTWEwRq4DpI
         k8H57qEmawE/j7LmB9tA9TV+zvmLNGBPwa84lzD/3qN88QC3RAhY24lAp30/aCLuxpbK
         xtY5Q+D5GJnJYaVe1AI4tPAi/iyk2pz6CEQRkeJK/9fF/gpl2m6c7CDuwDpaI2KEojiy
         ui4K6NZba0Lh1Nepywljh4wXOD5UU6/ha/6vR8w0ay/xybVMKTmLTfY+PLEGfhcYRa2A
         LXyPSKfXfolASCMhAJYFGkk9/fXACNjTeBYIpW2Y9q2gTnlamRFjkKcPx1rkEUR0Q5Vl
         TqVQ==
X-Gm-Message-State: AOAM531+TE2SR2wU5+8OUu5SUwRaiFuO7vnVEUBthMISDB9FuwvlZVrB
        uCvUPKFw7FuCD10LUvFzL6QqZQ==
X-Google-Smtp-Source: ABdhPJx8IpTTM9/g3RBknCrFkgQwBJweYVmgUVzgS9lAIGT+MWnmv8D6zokZuH9KY+LB4TYOS1hj2Q==
X-Received: by 2002:a17:90b:18d:: with SMTP id t13mr9864460pjs.191.1623834588000;
        Wed, 16 Jun 2021 02:09:48 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id n9sm1586855pfu.121.2021.06.16.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 02:09:47 -0700 (PDT)
Date:   Wed, 16 Jun 2021 14:39:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "Viresh Kumar )" <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non genpd
Message-ID: <20210616090945.sn337tftdcp7y7y6@vireshk-i7>
References: <20210616053335.4181780-1-hsinyi@chromium.org>
 <CGME20210616075555epcas1p136129544501878b4bedaf8e46f9a43dc@epcas1p1.samsung.com>
 <20210616075548.ghp3lmjf4y6pyxoy@vireshk-i7>
 <b9310754-2105-2a93-ecbf-513d9a80a91a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9310754-2105-2a93-ecbf-513d9a80a91a@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-21, 17:47, Chanwoo Choi wrote:
> On 6/16/21 4:55 PM, Viresh Kumar wrote:
> > On 16-06-21, 13:33, Hsin-Yi Wang wrote:
> >> Don't limit required_opp_table to genpd only. One possible use case is
> >> cpufreq based devfreq governor, which can use required-opps property to
> >> derive devfreq from cpufreq.
> >>
> >> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >> ---
> >> This is tested with the non genpd case mt8183-cci with passive
> >> governor[1].
> >> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com/
> >> ---
> >>  drivers/opp/of.c | 20 +-------------------
> >>  1 file changed, 1 insertion(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> >> index aa75a1caf08a3..9573facce53a5 100644
> >> --- a/drivers/opp/of.c
> >> +++ b/drivers/opp/of.c
> >> @@ -201,17 +201,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> >>  			lazy = true;
> >>  			continue;
> >>  		}
> >> -
> >> -		/*
> >> -		 * We only support genpd's OPPs in the "required-opps" for now,
> >> -		 * as we don't know how much about other cases. Error out if the
> >> -		 * required OPP doesn't belong to a genpd.
> >> -		 */
> >> -		if (!required_opp_tables[i]->is_genpd) {
> >> -			dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
> >> -				required_np);
> >> -			goto free_required_tables;
> >> -		}
> >>  	}
> >>  
> >>  	/* Let's do the linking later on */
> >> @@ -379,13 +368,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
> >>  	struct dev_pm_opp *opp;
> >>  	int i, ret;
> >>  
> >> -	/*
> >> -	 * We only support genpd's OPPs in the "required-opps" for now,
> >> -	 * as we don't know much about other cases.
> >> -	 */
> >> -	if (!new_table->is_genpd)
> >> -		return;
> >> -
> >>  	mutex_lock(&opp_table_lock);
> >>  
> >>  	list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
> >> @@ -873,7 +855,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> >>  		return ERR_PTR(-ENOMEM);
> >>  
> >>  	ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
> >> -	if (ret < 0 && !opp_table->is_genpd) {
> >> +	if (ret < 0) {
> >>  		dev_err(dev, "%s: opp key field not found\n", __func__);
> >>  		goto free_opp;
> >>  	}
> > 
> > Plus this and few changes to commit log.
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index e366218d6736..b335c077f215 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -893,6 +893,16 @@ static int _set_required_opps(struct device *dev,
> >         if (!required_opp_tables)
> >                 return 0;
> >  
> > +       /*
> > +        * We only support genpd's OPPs in the "required-opps" for now, as we
> > +        * don't know much about other use cases. Error out if the required OPP
> > +        * doesn't belong to a genpd.
> > +        */
> > +       if (unlikely(!required_opp_tables[0]->is_genpd)) {
> > +               dev_err(dev, "required-opps don't belong to a genpd\n");
> > +               return -ENOENT;
> > +       }
> > +
> 
> If you add this checking statement, I think that 
> when using dev_pm_opp_set_rate with required-opp property, it will be failed.

Yes, that is exactly what I am trying to do here. Hsin already
confirmed that you guys won't use this API, isn't ?

The point here is that the _set_required_opps() function only updates
the performance state of genpds today. So it won't work for you guys
anyway.

-- 
viresh
