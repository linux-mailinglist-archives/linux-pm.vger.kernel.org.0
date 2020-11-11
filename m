Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45C72AE87A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 06:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgKKFyF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 00:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgKKFyF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 00:54:05 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89712C0613D6
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 21:54:03 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q5so956219pfk.6
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 21:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z9P2/0O75mWnsAx8oZbLnThzZUiIC3AEplGBmhCEgMc=;
        b=X8GTCLnVhPTHspNJxX3km3UYVp4nyC6BpfIOKE/DdY+uRQjvemgYnXh8VFokLkJrAS
         ZqtHrunQPVA9pFblN+6OYjTpS27k+3qzxsRuUbq4xgpRKXK+MQAEhjzLGXROppqWR9D0
         5jdgnPnuQCRevLav+EcdMJ4IWzhFftP3TpovBCaNjMjTSrs7yC7Sk5VEVbDt+MzoCUXt
         D6rESQcjx+u3Y2fMR5OPaJ2B4YTZ8PyAUAjs5NFDAJZU5Qrvtoa6xjdZuBPIoyggPRl9
         JHkOBKUfFnzo79XoomjoJgY7H3V/Q9sVxWPcTdq+Nyv3t8MJb6qbybYDXvP5J6cgEFKD
         XKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z9P2/0O75mWnsAx8oZbLnThzZUiIC3AEplGBmhCEgMc=;
        b=e2p/1ecxoyYTIUSS/VOMWPkNGokdOD5nq0aYXb478rwMzrTNX77VU6aBeQbajYu47c
         yCE7W7FqHAOU/TKqfcrydat7gR94AF4pawSzA/ftsgS6Ym0dnQFvfKUA11K2BABClEOx
         497yEU4IwWiZMHOrg3X9FPlS08dW499MERt4LkyFaGqsNPwX9JWVbTAG59xoDrkMHsFy
         8vtO6Q72BKLA6JjB+pjkPuXFuy8pxbTb+t1Q02zOO5vlSRb6gROhJdxftUF1htWoji/m
         FFaZSxJ/Q8AUqeQA0JvfDlgR1E3MyTc85Qzx0GInEsnRx+mp/yHFNKHu1WBBsau/IAOs
         bUrw==
X-Gm-Message-State: AOAM530LyQTRiXPD2OEgaDhFR6Y8h7EW2JroKeBtZDJfTdsoPKq+msxW
        RNN5FXrBkXw2VnCMHbuP8QLDzA==
X-Google-Smtp-Source: ABdhPJzCesDnaFKRgNtLIoN64pjuJ7aVVMAE9U+58KC8+aSCcNQm9J/waPMH5YmalfzWdRrq03fmZw==
X-Received: by 2002:a62:7883:0:b029:18a:e054:edf1 with SMTP id t125-20020a6278830000b029018ae054edf1mr21361245pfc.70.1605074042985;
        Tue, 10 Nov 2020 21:54:02 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id p4sm909594pjo.6.2020.11.10.21.54.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 21:54:02 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:24:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 02/26] memory: tegra20-emc: Use
 dev_pm_opp_set_clkname()
Message-ID: <20201111055400.7lnooqnxo3yy4gif@vireshk-i7>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-3-digetx@gmail.com>
 <20201111054541.hstqrlvtpwxxbv4m@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111054541.hstqrlvtpwxxbv4m@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-11-20, 11:15, Viresh Kumar wrote:
> On 11-11-20, 04:14, Dmitry Osipenko wrote:
> > The dev_pm_opp_get_opp_table() shouldn't be used by drivers, use
> > dev_pm_opp_set_clkname() instead.
> > 
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/memory/tegra/tegra20-emc.c | 30 +++++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
> > index 5e10aa97809f..bb3f315c9587 100644
> > --- a/drivers/memory/tegra/tegra20-emc.c
> > +++ b/drivers/memory/tegra/tegra20-emc.c
> > @@ -902,7 +902,7 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
> >  
> >  static int tegra_emc_opp_table_init(struct tegra_emc *emc)
> >  {
> > -	struct opp_table *opp_table;
> > +	struct opp_table *reg_opp_table = NULL, *clk_opp_table;
> >  	const char *rname = "core";
> >  	int err;
> >  
> > @@ -917,19 +917,24 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
> >  	}
> >  
> >  	/* voltage scaling is optional */
> > -	if (device_property_present(emc->dev, "core-supply"))
> > -		opp_table = dev_pm_opp_set_regulators(emc->dev, &rname, 1);
> > -	else
> > -		opp_table = dev_pm_opp_get_opp_table(emc->dev);
> > +	if (device_property_present(emc->dev, "core-supply")) {
> > +		reg_opp_table = dev_pm_opp_set_regulators(emc->dev, &rname, 1);
> > +		if (IS_ERR(reg_opp_table))
> > +			return dev_err_probe(emc->dev, PTR_ERR(reg_opp_table),
> > +					     "failed to set OPP regulator\n");
> > +	}
> >  
> > -	if (IS_ERR(opp_table))
> > -		return dev_err_probe(emc->dev, PTR_ERR(opp_table),
> > -				     "failed to prepare OPP table\n");
> > +	clk_opp_table = dev_pm_opp_set_clkname(emc->dev, NULL);
> > +	err = PTR_ERR_OR_ZERO(clk_opp_table);
> 
> Don't check for NULL here.

My bad. You aren't checking but just converting to err. Its fine.

-- 
viresh
