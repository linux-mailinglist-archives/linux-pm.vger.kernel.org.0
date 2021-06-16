Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3513A9183
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 07:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhFPGAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 02:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhFPGAt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 02:00:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A727C06175F
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 22:58:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k7so1047776pjf.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 22:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7xvwoO8Ytc6MOpsNDQsCGNHeuXbvkCIDk/kxP7pcjQw=;
        b=iiWtZhTEKSWgGjBEaDk01uj2vVqy8X4M33F63CNP79hOR7rBZpln+wYtpS5bvvVFtr
         BMqbp8n8jtGYVTnOiKN1amjbZKBlrHVPexshpSX6CIWImM/7923hmswcqYM1eidzKS3F
         HF+rJxOM8mxE7GjAPx2RJLwZXrkFAQZIHXyVlmO30ySOzFgsP7RNkRdFSc+LjohPN7MT
         CcTWCXzNGVDmw+vCsYZyhyBUMRU5+VR9h+SfVN0HCDu21R0ofQqlrAOsYq6+bbAnEGeA
         c7KNyOI8ZN5xSlrAw+G8QGgV4qmc7ucYRiXggi1wQrtdHRo6HJ8YqnstWiemdIfsuHxE
         QDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7xvwoO8Ytc6MOpsNDQsCGNHeuXbvkCIDk/kxP7pcjQw=;
        b=Adt5W5lxYFM91mjwg6HvTkKGE/lit/KlNRe4klwIZ5ce01ffpxzE8cu0rFjYILwbRR
         sp4oaKsdK0Pw6XEPXAg78yid4h1mljUGJzmhrFZI4ml2dSTfXftJg8ZaTCdRHNnAcddt
         YKgzb/1SCTIAXM6GNT9orwJTmoYsJjwdDH2AupyhTxpxyCRoRzMd6NGeTZOxH5+0m2Rm
         Zutt2DCgDyA4Y3hmRBc/m7L3kIscK3ZeW47VO8Kpul2n3as6gmzD99HxrHc6hhjhs1wr
         VCpV7aZrSspshP5lVPz0BC8e8hkI+UT6MVkKlDReOEZahCAV5mfxcI80epv3hcEWrzzA
         hK0g==
X-Gm-Message-State: AOAM531U75WvidPrwkE1qGleIIdpfnQbcV3Rr2g79IaN7TRvghYGD8wB
        ayr/5XjP2uWwvZQBpP1b55nm7A==
X-Google-Smtp-Source: ABdhPJx0aKfU6+OwD5FCsycPLn4rb3C3qNctosL+7c1A4Foj1zZFOWT3aGqfI85u8ab7JZzwPgI42g==
X-Received: by 2002:a17:90b:1d06:: with SMTP id on6mr3350997pjb.50.1623823123716;
        Tue, 15 Jun 2021 22:58:43 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id m1sm1010827pgd.78.2021.06.15.22.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 22:58:43 -0700 (PDT)
Date:   Wed, 16 Jun 2021 11:28:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "Viresh Kumar )" <vireshk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non genpd
Message-ID: <20210616055841.4m7y6nxnxbgw5rzi@vireshk-i7>
References: <20210616053335.4181780-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616053335.4181780-1-hsinyi@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-21, 13:33, Hsin-Yi Wang wrote:
> Don't limit required_opp_table to genpd only. One possible use case is
> cpufreq based devfreq governor, which can use required-opps property to
> derive devfreq from cpufreq.
> 
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> This is tested with the non genpd case mt8183-cci with passive
> governor[1].
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com/
> ---
>  drivers/opp/of.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index aa75a1caf08a3..9573facce53a5 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -201,17 +201,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  			lazy = true;
>  			continue;
>  		}
> -
> -		/*
> -		 * We only support genpd's OPPs in the "required-opps" for now,
> -		 * as we don't know how much about other cases. Error out if the
> -		 * required OPP doesn't belong to a genpd.
> -		 */
> -		if (!required_opp_tables[i]->is_genpd) {
> -			dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
> -				required_np);
> -			goto free_required_tables;
> -		}
>  	}
>  
>  	/* Let's do the linking later on */
> @@ -379,13 +368,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
>  	struct dev_pm_opp *opp;
>  	int i, ret;
>  
> -	/*
> -	 * We only support genpd's OPPs in the "required-opps" for now,
> -	 * as we don't know much about other cases.
> -	 */
> -	if (!new_table->is_genpd)
> -		return;
> -
>  	mutex_lock(&opp_table_lock);
>  
>  	list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
> @@ -873,7 +855,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  		return ERR_PTR(-ENOMEM);
>  
>  	ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
> -	if (ret < 0 && !opp_table->is_genpd) {
> +	if (ret < 0) {
>  		dev_err(dev, "%s: opp key field not found\n", __func__);
>  		goto free_opp;
>  	}

How are you setting the required OPPs ? I mean when someone tries to
change frequency of a device which has some required-opps, who is
configuring those required OPPs ?

-- 
viresh
