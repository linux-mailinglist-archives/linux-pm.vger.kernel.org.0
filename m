Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4237C1960E9
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 23:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgC0WPw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 18:15:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40444 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgC0WPv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2020 18:15:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id t24so5240731pgj.7
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2020 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TEwTFJQjvV6Mx5spN7GpwpVz8q19VnSJjUr5y2zOQf4=;
        b=p9SBNdR+ETIPSTXcv5EhsgX4tSQOTcZTMdhoZo/8WYUG+a++O1VV0uJ6+modK5pxzh
         HMITDpSbUK0bPjS+gKppaVH4D6idOVczgD3d/rfavsXFgmDbsSJQAGgO9g/wkbGj3kMn
         PnoH2d0IKUqvRfBtogvE07RRc5sijJBwuAmz6F4pNACVZD6o+Mc83UJ+FzcaLxBAqyQI
         JEzwo+ApKOBsJjORG+54L5O8FR8LRtj8oNjw+d2rQkVunVbiKXhFKn+DoUdiBKTsd6HE
         98xUG1mGuTYvcEEnUlVpqZitjoQ4FiNZPwhkJiMYBdyB98fu1AMII5hzw/KR4Tjb14iI
         4KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEwTFJQjvV6Mx5spN7GpwpVz8q19VnSJjUr5y2zOQf4=;
        b=J0e9+ZH/JKaBrGsdU180K1XFLxOJ/PGMVTM/hX1yfgyYGfriQ9y6IIy+xhnC83d/9S
         mwtJ9FFRegcvk0Dl5DKB72gocMy/scab1Gs+npNm15dlYtdmyIlYQkZ1Xo4bD9yzVTXe
         KtqVaOBDhc0egRdd0Pbn3xnxSpI7i3qU3KjKB4mmYVWY5rrLaRUiZ0QFo/eqHTet2qJP
         6oU45rUqhv7fSphfp6KDqgJexp/024spigx+6tIxepVJxHJBSuO7Yke60/Va5Uleb7ay
         w3RrW0YySs0iTm3WHCXrlsKqHBYjuDSJM3hba0Za5Bgk+yNreq1l6YTx7qg0i88b4nbd
         OxrA==
X-Gm-Message-State: ANhLgQ3a3eOnnX+o9paZRZGT626S0P+fG7ouNxWgmRW620xqmHKUAP/Z
        MhtDgpus0PpZ+sTbg+JQSQXHJw==
X-Google-Smtp-Source: ADFU+vud/GGU22qfW9z9qf0DG+nmWdPXJx314vADEi1cJKcHiCmBXY49eDWGGyDc8y3g/2VXMAR/aw==
X-Received: by 2002:a63:a65:: with SMTP id z37mr1441563pgk.31.1585347348852;
        Fri, 27 Mar 2020 15:15:48 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r4sm4564372pgp.53.2020.03.27.15.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 15:15:47 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:15:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, agross@kernel.org, robh@kernel.org,
        amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v5 2/6] soc: qcom: rpmhpd: Introduce function to retrieve
 power domain performance state count
Message-ID: <20200327221545.GF5063@builder>
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
 <20200320014107.26087-3-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320014107.26087-3-thara.gopinath@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 19 Mar 18:41 PDT 2020, Thara Gopinath wrote:

> Populate .get_performace_state_count in genpd ops to retrieve the count of
> performance states supported by a rpmh power domain.
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/soc/qcom/rpmhpd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 4d264d0672c4..7142409a3b77 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -341,6 +341,13 @@ static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd
>  	return dev_pm_opp_get_level(opp);
>  }
>  
> +static int rpmhpd_performance_states_count(struct generic_pm_domain *domain)
> +{
> +	struct rpmhpd *pd = domain_to_rpmhpd(domain);
> +
> +	return pd->level_count;
> +}
> +
>  static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>  {
>  	int i;
> @@ -429,6 +436,8 @@ static int rpmhpd_probe(struct platform_device *pdev)
>  		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
>  		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
>  		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
> +		rpmhpds[i]->pd.get_performance_state_count =
> +					rpmhpd_performance_states_count;

I would prefer if you ignore the 80-char limit here and leave the line
unwrapped.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
>  
>  		data->domains[i] = &rpmhpds[i]->pd;
> -- 
> 2.20.1
> 
