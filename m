Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F481D08CB
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 08:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgEMGkk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 02:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgEMGkj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 02:40:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC299C061A0E
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 23:40:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n18so82524pfa.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 23:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OIQYxN0drZOAEHo9yCmLQaZoQizu+u7jnHq31+ZplXg=;
        b=iiIHnvneP2z1jk8I3wWR4QAmnW+Vj6eDQ4MF/8mgzVDPV+bsMSsYtzBncTmjla2oyB
         y65VlpFXlZ7mixiPQV4BAro1nMcioFqadCIpkKS57WtngHNdYmHxIoVeuV9haIyxzUMM
         Rpv0lcc8U/GKf3uCRaS9WX+iJrMZ2KZ/KwmNaLZ5bkdNY8NJhNgyGPruDbbE4EN21W7P
         b+JHgElAM+xeamNa87VdCXbOCIcR1OAM/c6fGGy87P+1qKaMWpmX4g0cr9o4Xu04l+3x
         LnivZJvPyoEmOAwvgChhkTFmaE+OLgSyxofyMTRcU6LdcDxU+bGBbeOyo8OAXn6pbMLs
         gvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OIQYxN0drZOAEHo9yCmLQaZoQizu+u7jnHq31+ZplXg=;
        b=e7kRpGJlISNNiOBy9XVmK/QBc8/FBYYqnNpR6a997a/NXbAlObS732Jqmph4sp/Owm
         hIV1PNLvuCd4y+nPv+TqI+7V+gjxNvMQBTI9ao07WtEsG7tT6a3hyIFd0ZLGAAsWKSR9
         iq/XBmMZsoeGVFWsGZtmnEEmU584yty8+jRT0Pu5JGp8vQr/KT9vfoil2Q0VFnx8xvpc
         4tFVTAelc11U4oT0Y+7D3Bbp/gEBvo4WZ7MYk2gzY8Uejxl+EaPw4reoHvHABa5BiVby
         5kh8LQJe/hAoIT4ordaV03jTxdtU30dasdoy8zRHidVy7q1dvFgneT4JkFi5MGACnWIK
         qYQg==
X-Gm-Message-State: AGi0PubM3YzDniwuS6BlBX42hd4f/LNp1Vrrsr+o1ECja+2hkQpreH6z
        VDg5KcoFTKKjPEbT5r+gz1MHgQ==
X-Google-Smtp-Source: APiQypI1+pqcLAKzyinEccL70VMvcXaX/Tm3CNUYsFJxdmGD890CGgwWQ6X2kLiefLCRhYAMNHRdGw==
X-Received: by 2002:a63:a61:: with SMTP id z33mr22823838pgk.440.1589352037298;
        Tue, 12 May 2020 23:40:37 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id w69sm13705056pff.168.2020.05.12.23.40.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 23:40:36 -0700 (PDT)
Date:   Wed, 13 May 2020 12:10:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org,
        robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/10] OPP: Add helpers for reading the binding
 properties
Message-ID: <20200513064034.vj66ldzam7qnatbe@vireshk-i7>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512125327.1868-3-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-05-20, 15:53, Georgi Djakov wrote:
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c

> @@ -558,26 +580,13 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  	if (!new_opp)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = of_property_read_u64(np, "opp-hz", &rate);
> -	if (ret < 0) {
> -		/* "opp-hz" is optional for devices like power domains. */
> -		if (!opp_table->is_genpd) {
> -			dev_err(dev, "%s: opp-hz not found\n", __func__);
> -			goto free_opp;
> -		}
> -
> -		rate_not_available = true;
> -	} else {
> -		/*
> -		 * Rate is defined as an unsigned long in clk API, and so
> -		 * casting explicitly to its type. Must be fixed once rate is 64
> -		 * bit guaranteed in clk API.
> -		 */
> -		new_opp->rate = (unsigned long)rate;
> +	ret = _read_opp_key(new_opp, np, &rate_not_available);
> +	/* The key is optional for devices like power domains. */

Dropped this comment as key isn't optional for genpd as well as you
handled that in a later patch..

> +	if (ret < 0 && !opp_table->is_genpd) {
> +		dev_err(dev, "%s: opp key field not found\n", __func__);
> +		goto free_opp;
>  	}

-- 
viresh
