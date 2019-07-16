Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB266A61E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfGPKFn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 06:05:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46455 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfGPKFn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 06:05:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so9834243plz.13
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 03:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eOw4mJCwxsos04l+iE4dhcTh1ydYMzdors+pgowvvxM=;
        b=tMocE6swchBVuMnt58lGP9P628g1yOafJT46XmsoPTPU6cu+QH3WHGgsc/TzqTykTJ
         rdGZzvn6Mr6/PJqwPcSatTt4KCjIUHOWmaND9V8869f0KdmOna8tDoC4N31GVxqzyEuP
         EuNPIbAPdLAlOZZ4YTGbeCRtM8Qt76g0ldmmzrdR8bhfhTUk8KDNxnBisgvO+StyihUL
         hUdt9bMl/8WwQFG2nJBH9y99Wp6WaJ5G64VHqBZaakuCUgHohQgp4dbB8Omi6hF7rJ3c
         EvZCoX+goncN8mcgg/ODeGn69779oS06XcVejTPoaDJQg1DvPHhgrQ8c03ZGbvjjNjQS
         F7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eOw4mJCwxsos04l+iE4dhcTh1ydYMzdors+pgowvvxM=;
        b=SuoO8ct6EnKSeP3aG+fPkSEDfTmNnrXa+QofA9GyytLrkBfezZhBAZnrGlBQcYebuo
         zxFg5FKsDmxgj4RfBHfJ4bJp+24JrL+jxOcEju89P+HvLS9KTanKP8tJVgi6sLFkVPYu
         zA9hgI7wiQsHMcWMOFtKnVYVuXEraR3N8VX7WRc0+Xl1iHVZVLKO244JFwjoUopPGTnX
         LGDX4O4srcstAik2DeM+zvfXLEByaiGh7D2huAStw+6SlOTXpL0Kc5tLI2OAtoExKooc
         is16k7j2KeNtzRVWT77kYJ6FXEvqdVGRuAjkn/dEV/ytaMxxDlkIo4ZosYG/2j9PgMCX
         p8Wg==
X-Gm-Message-State: APjAAAVFB9EpUlaZByYwHbfbvKBgKG5cJsBEUwhQ/xT+zaLfBhDnfS43
        CLU3qd2M+uYgnyi7Qu5dO5Yc5w==
X-Google-Smtp-Source: APXvYqxwTXMWEmk/VEda4x6ElrsGyejRqXGCt8fhdrVypQtnG9VBy8x7GNe4fxfIxk0bDln28cUC3w==
X-Received: by 2002:a17:902:6b02:: with SMTP id o2mr31420099plk.99.1563271542213;
        Tue, 16 Jul 2019 03:05:42 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id f6sm21071066pga.50.2019.07.16.03.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 03:05:41 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:35:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] opp: core: add regulators enable and disable
Message-ID: <20190716100539.4uqelbxqz7bmtmea@vireshk-i7>
References: <20190715120416.3561-1-k.konieczny@partner.samsung.com>
 <CGME20190715120430eucas1p19dddcc93756e6a110d3476229f9428b3@eucas1p1.samsung.com>
 <20190715120416.3561-2-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715120416.3561-2-k.konieczny@partner.samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-19, 14:04, Kamil Konieczny wrote:
> Add enable regulators to dev_pm_opp_set_regulators() and disable
> regulators to dev_pm_opp_put_regulators(). This prepares for
> converting exynos-bus devfreq driver to use dev_pm_opp_set_rate().
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> --
> Changes in v2:
> 
> - move regulator enable and disable into loop
> 
> ---
>  drivers/opp/core.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0e7703fe733f..069c5cf8827e 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1570,6 +1570,10 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>  			goto free_regulators;
>  		}
>  
> +		ret = regulator_enable(reg);
> +		if (ret < 0)
> +			goto disable;

The name of this label is logically incorrect because we won't disable
the regulator from there but put it. Over that, I would rather prefer
to remove the label and add regulator_put() here itself.

> +
>  		opp_table->regulators[i] = reg;
>  	}
>  
> @@ -1582,9 +1586,15 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>  
>  	return opp_table;
>  
> +disable:
> +	regulator_put(reg);
> +	--i;
> +
>  free_regulators:
> -	while (i != 0)
> -		regulator_put(opp_table->regulators[--i]);
> +	for (; i >= 0; --i) {
> +		regulator_disable(opp_table->regulators[i]);
> +		regulator_put(opp_table->regulators[i]);

This is incorrect as this will now try to put/disable the regulator
which we failed to acquire. As --i happens only after the loop has run
once. You can rather do:

	while (i--) {
		regulator_disable(opp_table->regulators[i]);
		regulator_put(opp_table->regulators[i]);
        }


> +	}
>  
>  	kfree(opp_table->regulators);
>  	opp_table->regulators = NULL;
> @@ -1610,8 +1620,10 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
>  	/* Make sure there are no concurrent readers while updating opp_table */
>  	WARN_ON(!list_empty(&opp_table->opp_list));
>  
> -	for (i = opp_table->regulator_count - 1; i >= 0; i--)
> +	for (i = opp_table->regulator_count - 1; i >= 0; i--) {
> +		regulator_disable(opp_table->regulators[i]);
>  		regulator_put(opp_table->regulators[i]);
> +	}
>  
>  	_free_set_opp_data(opp_table);
>  
> -- 
> 2.22.0

-- 
viresh
