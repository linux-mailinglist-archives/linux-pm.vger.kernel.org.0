Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4502F9A06
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 07:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbhARGj5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 01:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731704AbhARGjy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 01:39:54 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4595BC061573
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 22:39:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x20so3723954pjh.3
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 22:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CpHvZU/WHkbGaD9FSLMeszBMLktHGvhDw07CKXGAXcM=;
        b=n2447+zLT2BNNoFymdo6Rxu/Seh7vQq4D61F35xbPAcpQH6CxNWNrw7w6yiUKgl9Ro
         6pKS/BwIhKimVzuBUxM3Q54cZl/yblYhqIuVpVNNBO/RIAl6BfF0LKLFoZfaHDN8sWzW
         PQy/jevmGeg+rVsfB1r6xWvgU/F+WSZ8UM0Nr9c+MZfG2xedjDiMmaX4r4UWoFh0G7hP
         lZzHw33cUAYBZJxtf0qE+y5z0dGjZCtuExRxt7qPdw1L/ohCj6SjBrdf9gX5LG37JONn
         uOkUQPZjroxxjlgj96sKwIFlhiHkmb7EKiPWV2wOWl5QEndTK/FXi2bnRReVaAZYrS5t
         carg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CpHvZU/WHkbGaD9FSLMeszBMLktHGvhDw07CKXGAXcM=;
        b=MPfe6uCB9t65Xu9CgjwP91PnMi2EiO8CH4jzNP8HnaERAfIpzNnS+Z9Hm9Ek5uY5tP
         SYb3i7PhMJ4hO0xlni4dgLULj1zWapKvbuljW5NuzwO1WWYetVgiTOz7o2B0VI257Rnq
         8ms6OESvrlyApO1zqS0lDQLH9Vv3hK41lv/nvLzD6S94iaze3KbZEqYBYkMsNlQFNdvs
         v9PrGFZzyeFZuwQqFVMENJTdfItAHPzC7UkyHQ/02lGTkM+LK1wDlY4HkDieljxfuHJg
         f/oplSPgi0oZ9uHfL8O+Bc11M3AlECPQNzykzy2DbmOns/f5/rAVIKhBQfa8Aoo4vo0v
         w9wg==
X-Gm-Message-State: AOAM533es65ZutVwUrVjtj9qIi2mmpqFHdkdXwLvZUvBtgAVAm+xl2dO
        JBJSskh5z7sdYNm0WtvN3pV+2twxqfls4Q==
X-Google-Smtp-Source: ABdhPJzfQB0pY61O/yD92LvRQT3eJPpAsD1G0s0K5sAYQL/z6uupIyVPgf0FrCoo524PwWasTUy9qw==
X-Received: by 2002:a17:90b:80d:: with SMTP id bk13mr24583776pjb.41.1610951953745;
        Sun, 17 Jan 2021 22:39:13 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id o13sm3235849pfg.124.2021.01.17.22.39.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 22:39:12 -0800 (PST)
Date:   Mon, 18 Jan 2021 12:09:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki " <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: tegra20: Use resource-managed API
Message-ID: <20210118063910.on4vgbllfmsduezo@vireshk-i7>
References: <20210117231825.28256-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117231825.28256-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 02:18, Dmitry Osipenko wrote:
> Switch cpufreq-tegra20 driver to use resource-managed API.
> This removes the need to get opp_table pointer using
> dev_pm_opp_get_opp_table() in order to release OPP table that
> was requested by dev_pm_opp_set_supported_hw(), making the code
> a bit more straightforward.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 45 +++++++++++++++----------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 8c893043953e..e8db3d75be25 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -32,6 +32,16 @@ static bool cpu0_node_has_opp_v2_prop(void)
>  	return ret;
>  }
>  
> +static void tegra20_cpufreq_put_supported_hw(void *opp_table)
> +{
> +	dev_pm_opp_put_supported_hw(opp_table);
> +}
> +
> +static void tegra20_cpufreq_dt_unregister(void *cpufreq_dt)
> +{
> +	platform_device_unregister(cpufreq_dt);
> +}
> +
>  static int tegra20_cpufreq_probe(struct platform_device *pdev)
>  {
>  	struct platform_device *cpufreq_dt;
> @@ -68,42 +78,31 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> +	err = devm_add_action_or_reset(&pdev->dev,
> +				       tegra20_cpufreq_put_supported_hw,
> +				       opp_table);
> +	if (err)
> +		return err;
> +
>  	cpufreq_dt = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>  	err = PTR_ERR_OR_ZERO(cpufreq_dt);
>  	if (err) {
>  		dev_err(&pdev->dev,
>  			"failed to create cpufreq-dt device: %d\n", err);
> -		goto err_put_supported_hw;
> +		return err;
>  	}
>  
> -	platform_set_drvdata(pdev, cpufreq_dt);
> -
> -	return 0;
> -
> -err_put_supported_hw:
> -	dev_pm_opp_put_supported_hw(opp_table);
> -
> -	return err;
> -}
> -
> -static int tegra20_cpufreq_remove(struct platform_device *pdev)
> -{
> -	struct platform_device *cpufreq_dt;
> -	struct opp_table *opp_table;
> -
> -	cpufreq_dt = platform_get_drvdata(pdev);
> -	platform_device_unregister(cpufreq_dt);
> -
> -	opp_table = dev_pm_opp_get_opp_table(get_cpu_device(0));
> -	dev_pm_opp_put_supported_hw(opp_table);
> -	dev_pm_opp_put_opp_table(opp_table);
> +	err = devm_add_action_or_reset(&pdev->dev,
> +				       tegra20_cpufreq_dt_unregister,
> +				       cpufreq_dt);
> +	if (err)
> +		return err;
>  
>  	return 0;
>  }
>  
>  static struct platform_driver tegra20_cpufreq_driver = {
>  	.probe		= tegra20_cpufreq_probe,
> -	.remove		= tegra20_cpufreq_remove,
>  	.driver		= {
>  		.name	= "tegra20-cpufreq",
>  	},

Applied. Thanks.

Though please remember to update this to use the devm_ variant when it comes
out.

-- 
viresh
