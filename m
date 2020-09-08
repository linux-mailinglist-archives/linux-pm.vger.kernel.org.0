Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53C326186F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 19:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgIHRx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 13:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731575AbgIHQMs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 12:12:48 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDF9C0612A0;
        Tue,  8 Sep 2020 06:02:31 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x77so9136842lfa.0;
        Tue, 08 Sep 2020 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sXdYuavoSim9Tcuk44WZc9LhOUgtTFe2gPoDBIPVjng=;
        b=k3aS2dqgVxh8tukyJeMOiUKibIP2o5EK1HbLTyoj1EIHk7TXBXfx91plVBpAbo35qy
         NaXcni2JH8medKewgjiZU/CwZhuyyzDFlI/Z9xpUeCU0lkCyZD45E5ZPHdBEouYyaXdg
         xlEfoR8jczhnh9u9zzBkqeqjV3Blq31P2SC6AssPsVcuDQqHqKt7eow30dWh3i1Cr3vV
         dG7WT7DbQUgb+vMjiIpI8zjM+S5d5DWAK86VF9S+L70rvooQyCzTJanbXzRP6oXzAFbn
         QrqjtwB0bL4Bj4ik0lsOJeVFZjAvfnQ/X+Qw1d8e+ajyQj5kGEZOGd7OE2CvQF5FS4D5
         aDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sXdYuavoSim9Tcuk44WZc9LhOUgtTFe2gPoDBIPVjng=;
        b=VmCVc9rfIotMPNgc37q0ACxdPm+ZjfxTFqzUhdwQTVxR0l88OWaUkGIfGgxBUm7Enq
         ZcsVgLFG5JeQzPSI+jsxGwX1xtfHXH0FljM7Ed57/FDJQ6pK1SIfqLyCylwqNW7wbDsT
         KOCzGwRgVaHBa3ezLpBmv6z1AaP+39cxt75Z271BL8Z8qPiDfDVi1xfQlMCLwDHJR4eO
         SGL3zUiFdKKidb29xW/63ls1KZSvyviW26w8eq3pIjy0GoLrdBNzkpxfUKPRmpYDw4rA
         B7sUcqk7Wn9fJQnPz4vK2AN/GI5Lr1EmCqKvdeo5HQvZEYqCzvJi7locVQnNH9VplIhb
         zdaA==
X-Gm-Message-State: AOAM530sOEJdPd6P2q5jg517yPWD6P/f/W8yDBG58AYlChQUwGbBZe3p
        T1RxsP3TcdF2yi+R60NVoNsynQ/IWh4=
X-Google-Smtp-Source: ABdhPJyW70T/kdnCb/1pV8W77Azb/IMUM2E4AXoICzEHT0yIVQzTbi8wqv56HWe91+MN1H6JJWYFWw==
X-Received: by 2002:a19:8446:: with SMTP id g67mr12202070lfd.87.1599570149663;
        Tue, 08 Sep 2020 06:02:29 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id x11sm10286424ljh.106.2020.09.08.06.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 06:02:28 -0700 (PDT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200908072557.GC294938@mwanda>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0d7fd969-8957-5db0-8c4d-2077e924181b@gmail.com>
Date:   Tue, 8 Sep 2020 16:02:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908072557.GC294938@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

08.09.2020 10:25, Dan Carpenter пишет:
> This error path needs to call clk_disable_unprepare().
> 
> Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> ---
>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index e94a27804c20..dedd39de7367 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>  	if (rate < 0) {
>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
> -		return rate;
> +		err = rate;
> +		goto disable_clk;
>  	}
>  
>  	tegra->max_freq = rate / KHZ;
> @@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>  
>  	reset_control_reset(tegra->reset);
> +disable_clk:
>  	clk_disable_unprepare(tegra->clock);
>  
>  	return err;
> 

Hello, Dan! Thank you for the patch!

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
