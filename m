Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB42F9A11
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 07:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbhARGoa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 01:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbhARGo3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 01:44:29 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CDCC061575
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 22:44:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l23so9127205pjg.1
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 22:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JLQANWJjKIxPwuU3hoz4mSANUDLP7iiPWINSw0uy47k=;
        b=UUa/HZeV5xy25MW7KuMyrI5ofgBcld4iGX5LysV2du9pIbqQCsYJeZhxnDXxxxrfFQ
         bVawoqcGiMdG1BfDPBbXzrvi9RNDtMMituY7dAFywHRWnF8DRwWOnYrgQh6lYozaXRqY
         NRoBa/9tn03WgLzs8f8n+xfydDAyHtvsxer/bPTiPVxdsWEijKyZRWwLYn+0ARXnWlWE
         Ys261kz1gBZfWJaFgl5aXXjbZDSCNt/XRLPQ6nXpo9H1wS8VNfUrj/tu5ubjZ6Vu5WqM
         SxB6UJWB4j4cEiDNc9X8Q+N1apGRBiAZbQUhLTvlQxQbR8lzVEagMZlTqlRdCFc51HOm
         4uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JLQANWJjKIxPwuU3hoz4mSANUDLP7iiPWINSw0uy47k=;
        b=HqNHsuQoUu4FJ5x2sr+g+BXb3QC8pnaBCzeXvUP+mvEMGBo5CIO6FfIXXhQ+bDji0Y
         9bPvc3G1tDLed5mgH5c1WkPyttLfcOlZxEpBfQGRYlaK5gmGEnZmKefTLNf/MBK5k28H
         wxJwDlXOahTaNbL144p56qMuUlPXwYt2yLSHBZERuzebeuBIWz++45mPqRrWGJMMruDJ
         7qX8ZKB6NY4ZmjyHpDrUkRh0Btc+w86ZKtXRRi7HQX+DuYSPnYvZiEgA+BP75YZ0PdQu
         ns8wYCyEYEMz06deFyvkPmn8VVFa9vRWDmgO3v0k6xwGPOox0tBjVAeaOS94fBmerdje
         8eOg==
X-Gm-Message-State: AOAM533QKfC9Vnz9FvIqlYL5N1t4f+wm1HscAXt/pwTmJoZZYSIAeNkE
        Jko5ivw3wV7ey02liQuPrk940g==
X-Google-Smtp-Source: ABdhPJyQf3XMKUEIKnHQui9k34+CkG4unBJ/scegulWoWFwGmjLU0wqkL222FKcidwZjGXGuhIyg5g==
X-Received: by 2002:a17:90a:b78a:: with SMTP id m10mr6097112pjr.164.1610952252367;
        Sun, 17 Jan 2021 22:44:12 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id n15sm6847466pjk.57.2021.01.17.22.44.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 22:44:11 -0800 (PST)
Date:   Mon, 18 Jan 2021 12:14:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: enable boost support
Message-ID: <20210118064409.ul6jzu5pb43zt56z@vireshk-i7>
References: <20210113065241.23829-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113065241.23829-1-shawn.guo@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-01-21, 14:52, Shawn Guo wrote:
> At least on sdm850, the 2956800 khz is detected as a boost frequency in
> function qcom_cpufreq_hw_read_lut().  Let's enable boost support by
> calling cpufreq_enable_boost_support(), so that we can get the boost
> frequency by switching it on via 'boost' sysfs entry like below.
> 
>  $ echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 315ee987d2d3..6eb88463a24e 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -351,6 +351,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  
>  	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
>  
> +	if (policy_has_boost_freq(policy)) {
> +		ret = cpufreq_enable_boost_support();
> +		if (ret)
> +			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
> +	}
> +
>  	return 0;
>  error:
>  	devm_iounmap(dev, base);

Applied. Thanks.

-- 
viresh
