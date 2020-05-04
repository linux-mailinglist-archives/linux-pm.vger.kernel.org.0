Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9431C3218
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 07:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgEDFNG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 01:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgEDFNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 01:13:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649B3C0610D5
        for <linux-pm@vger.kernel.org>; Sun,  3 May 2020 22:13:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so6328612plk.10
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2020 22:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CGgfVInUBc8d8MeEEhRqNzZfEuhBaHkKRq5GSypONxA=;
        b=ML7679GiJcCvmMTmxW61nvXsnDgL1EIu+eX/BfjNOZQTioT5PmIWm0iw6HgAKA9CLX
         fujQoQ59MLeuXJBLGfQf7vz19E+afar2cBGtutwAIe1BTznB+gCPJXfCR16XPNwCg069
         5PcIp4JY3+yw/a/zMCMvFyejBLCvLvy1ng5Y8SMlOPBLkohTz49BVDw2aABiRa8jPRqV
         xBgCMYQPLzxXhTEE5r93YfAWnhABYgHz1EFW3461Kl1RxgGsNGtTFyFCiQhDjx5fzMGX
         zTx3D5QZBQ7YhXZDvinmpYR17xQ2TEhat1T1XQ8f+ai/8RASDDQp/i4lUxIbeKeRSB2L
         mF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CGgfVInUBc8d8MeEEhRqNzZfEuhBaHkKRq5GSypONxA=;
        b=jHSA2IxlJsA+uSFZJRfSTPGsIWxj5s3HyiEan78ni8CGIO8xCeF94/jIyvsn/cnlzG
         1dqxi/EWbiI8WB81PG63A4yvM9gspFbdOOjenglMmBu+xZ4pS9e77cFNVAkjsvJtp/vX
         5iTcSEdK6QJAKqw153uVp/ugOkEUoYVodxgoL8AyjHc3ss6EO8NaHiJjwR48HAV6q5yz
         tYwwSgzrLKWEPLVhSdE1KrJv1UdU5qSs+423Zbrl7OKo8+2knCU47fBC711T1yN07QTE
         dukPrMOFrVAPbOILrSPdsXdR/8JnkFRe6r/EZ3/8diupbHC+20ea4ghsvHcPJzznDZy0
         8Iog==
X-Gm-Message-State: AGi0PuaFMJX6D9DQfcQy+t9WW6iLWUgeubLsumiDjV5TABuYARY6Dq5Q
        iw1Kc8RPRQRPWL6zTdB6NxpfvA==
X-Google-Smtp-Source: APiQypI6IdV05QBzAML2J+Fi9YQIWcD1PVuThQvH6+otzWE9wJBnp3sC6BNSCfGKWji9101yrzoIJg==
X-Received: by 2002:a17:90b:1993:: with SMTP id mv19mr14636453pjb.88.1588569185845;
        Sun, 03 May 2020 22:13:05 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id a99sm5755483pje.35.2020.05.03.22.13.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2020 22:13:05 -0700 (PDT)
Date:   Mon, 4 May 2020 10:43:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom: fix wrong compatible binding
Message-ID: <20200504051303.zvmvvjipdkjpo4yh@vireshk-i7>
References: <20200430222225.3941-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430222225.3941-1-ansuelsmth@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-05-20, 00:22, Ansuel Smith wrote:
> Binding in Documentation is still "operating-points-v2-kryo-cpu".
> Restore the old binding to fix the compatibility problem.
> 
> Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index a1b8238872a2..d06b37822c3d 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -277,7 +277,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  	if (!np)
>  		return -ENOENT;
>  
> -	ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");
> +	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
>  	if (!ret) {
>  		of_node_put(np);
>  		return -ENOENT;

Applied. Thanks.

-- 
viresh
