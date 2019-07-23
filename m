Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16093715A3
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 12:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfGWKEK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 06:04:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33023 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGWKEJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 06:04:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so20362679plo.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 03:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YpUM1Im+XRL13SexNhkl9pzwji5CXQiG7CSz3y2BWPQ=;
        b=il988Img6c4wKh6uWkXOX+qoaDNsC08/nBXqNp0wwfCmRJqGOdbpGusPcc2mDBESgw
         sbnGpJRaaADtKWcAW9g3X3AmyKTqoJKf+M7vRurOB9HCyRnbGRyM6KVJ1sGbXILS+xD6
         +ehsGxDQjMiGKyaqnyPB6TcpLU88zycboAIrGszRmf+/cUKXS0yqivUvA+ikFN+rh2Ma
         RE0mI9sdVaUpK5epaNfKafiYZjh4T4+Baf7BToZFR5BbDRNa6GvzY7xMzpllTEoDG4OS
         ECy30v1BWaYlim2sft1qt8Pavn3QIj+9YBuUOLDvTu9RVqqWp5GoCDjhOGVQDuhiDy4Q
         q5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YpUM1Im+XRL13SexNhkl9pzwji5CXQiG7CSz3y2BWPQ=;
        b=R6yuqbkT0iFawoLP02FXalcZmShgaM5u98LYOMxtH6Vm997NACrlqQ5N2HVEnoZfrJ
         PpEgsfZOlnH/hUqGW+4mu2hIVQDgmY8UQ+2WmSqUjmwpsWbNkXjlILUw+TGjooCZRSRE
         G2LImtbXUnk3rOYH8vz8G9paciKH9iWDn3mUvtsxlvkg3PZzQX0GVLzUPWAgrs2Zzr90
         sDuy5IJyBguYT6lwPb7rpqo8QyA47DPDoCmuEqEZkjM6+eQYK81yyuLzZkNGIgrRqMuA
         CWG9X1jbM0SbaEsYeohcm2aTUlRr6T1GwDl9BDxAkvXmC4qIH01jq9X5AOkMoJZd1nws
         wdlQ==
X-Gm-Message-State: APjAAAWnbfSkdVUfihkQw794NI7Zai42yVHV32fBkv4FfQw3H3dZaA/X
        KlKcggqn9MpdQ/lxcIFbV/H3Ug==
X-Google-Smtp-Source: APXvYqxL20ZsFOnKLphiCT4Vy4tslrXNuQ4Q67ehYKSMAxdeRlDY8/KD73Moz7KT7p/7p+Ul845UmQ==
X-Received: by 2002:a17:902:788f:: with SMTP id q15mr81217864pll.236.1563876249250;
        Tue, 23 Jul 2019 03:04:09 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id r9sm23763629pjq.3.2019.07.23.03.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 03:04:08 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:34:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] PM / devfreq: Add required OPPs support to
 passive governor
Message-ID: <20190723100406.7zchvflrmoaipxek@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-6-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717222340.137578-6-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-07-19, 15:23, Saravana Kannan wrote:
> Look at the required OPPs of the "parent" device to determine the OPP that
> is required from the slave device managed by the passive governor. This
> allows having mappings between a parent device and a slave device even when
> they don't have the same number of OPPs.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 58308948b863..24ce94c80f06 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -19,7 +19,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  			= (struct devfreq_passive_data *)devfreq->data;
>  	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
>  	unsigned long child_freq = ULONG_MAX;
> -	struct dev_pm_opp *opp;
> +	struct dev_pm_opp *opp = NULL, *p_opp = NULL;

This won't be required if ...

>  	int i, count, ret = 0;
>  
>  	/*
> @@ -56,13 +56,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	 * list of parent device. Because in this case, *freq is temporary
>  	 * value which is decided by ondemand governor.
>  	 */
> -	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> -	if (IS_ERR(opp)) {
> -		ret = PTR_ERR(opp);
> +	p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> +	if (IS_ERR(p_opp)) {
> +		ret = PTR_ERR(p_opp);
>  		goto out;
>  	}
>  
> -	dev_pm_opp_put(opp);
> +	if (devfreq->opp_table && parent_devfreq->opp_table)
> +		opp = dev_pm_opp_xlate_opp(parent_devfreq->opp_table,
> +					   devfreq->opp_table, p_opp);

you put p_opp right here.

Also shouldn't you try to get p_opp under the above if block only? As
that is the only user of it ?

> +	if (opp) {
> +		*freq = dev_pm_opp_get_freq(opp);
> +		dev_pm_opp_put(opp);
> +		goto out;
> +	}
>  
>  	/*
>  	 * Get the OPP table's index of decided freqeuncy by governor
> @@ -89,6 +96,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	*freq = child_freq;
>  
>  out:
> +	if (!IS_ERR_OR_NULL(opp))
> +		dev_pm_opp_put(p_opp);
> +
>  	return ret;
>  }
>  
> -- 
> 2.22.0.510.g264f2c817a-goog

-- 
viresh
