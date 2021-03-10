Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44889333C09
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 13:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhCJMCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 07:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbhCJMCk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 07:02:40 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE0BC061761
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 04:02:39 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso10859438wmq.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 04:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dlqVLTWOTrikd1dncf0ixNXcbLRecLbYPdhiTz2QQsg=;
        b=IlbejYfHeXrIsqw5NZNVZk+8IE4RQ4b8f8wSrjm/SSTVYsip2XiKzDeCcFu175GzWM
         5no/YG1PM040hYzcBSHClu3O/dhHRKyWdFHli1vNQLZwFDwWeThwiqfMUKQH2dHmYA2T
         rA591uTi4Uj5souPrH0ka0y1h5e+YjLJ125d8f8mOqBB1G18bA9g24xmdVzJWzaZ9RFl
         t/6o1aIi/ehzFUJYI1+OL4k7LhgVsjQjpkScP4LJvCDOKn76cQGePll9JIDF7Tl69sys
         fovELYDyLK6zzX0gxPaED5ocON9r55Dd2WPNKtSFyvBrgcPg2ztbk2xGyj1w+PJnDunk
         p9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dlqVLTWOTrikd1dncf0ixNXcbLRecLbYPdhiTz2QQsg=;
        b=TqVZZWjxk8TWVha/NUf0DEDICQ3dtAKzm3bm8ABWIrE63n4iEHPdJExu9lwF42VN8e
         oytGKFYk3vqERhJIjP/wi1suYruj0sLCZAgKUKWzsbaKwAZUD0fK7aVLwCsg4K9TKoW6
         /cPW2kz4NQnl4FepYIX6IsKPjB/+N/Gw18It19BTZwAtDJW5lXuMNKcxn07LG6VokzBv
         3gy6dfmB7QWtg5ak378amCQb8uAraCBhL0OFYhLdI/QEw2edZjbIUQ3WBURPlIX2XgoC
         FE2wRM7T5pXae6tcDLekGUvP+bvPc00O5QAu/E25n746kdoJAb5TzyjNGRVL7WK3OYp+
         TTlg==
X-Gm-Message-State: AOAM530RnqYpWv4nQNUX+DkZl0B8P1nzbUeFf8ee01UG6gSnJNrlNNCo
        pXXEfU9WBHydSEQpYRS6ptbgWA==
X-Google-Smtp-Source: ABdhPJzyl0mOxjO8QTMhpDMKlfhOPmDe6unEELImhzPQxinkABg6DsE/szmYglilSx0lHPd30rN2pw==
X-Received: by 2002:a05:600c:220d:: with SMTP id z13mr3046652wml.1.1615377758337;
        Wed, 10 Mar 2021 04:02:38 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8018:efa9:4421:9140? ([2a01:e34:ed2f:f020:8018:efa9:4421:9140])
        by smtp.googlemail.com with ESMTPSA id y10sm28607210wrl.19.2021.03.10.04.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 04:02:37 -0800 (PST)
Subject: Re: [PATCH] thermal: thermal_of: fix error return code of
 thermal_of_populate_bind_params()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210306141106.18695-1-baijiaju1990@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ac49897d-fdcd-57aa-fb1a-2bf7f3b2296d@linaro.org>
Date:   Wed, 10 Mar 2021 13:02:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210306141106.18695-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/03/2021 15:11, Jia-Ju Bai wrote:
> When kcalloc() fails and __tcbp is NULL, no error return code of
> thermal_of_populate_bind_params() is assigned.
> To fix this bug, ret is assigned with -ENOMEM in this case.
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/thermal/thermal_of.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 69ef12f852b7..e8c9041482e9 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -710,8 +710,10 @@ static int thermal_of_populate_bind_params(struct device_node *np,
>  	}
>  
>  	__tcbp = kcalloc(count, sizeof(*__tcbp), GFP_KERNEL);
> -	if (!__tcbp)
> +	if (!__tcbp) {
> +		ret = -ENOMEM;
>  		goto end;
> +	}

Thank you for your patch.

Seems like the same happens a few lines before:

        count = of_count_phandle_with_args(np, "cooling-device",
                                           "#cooling-cells");
        if (!count) {
                pr_err("Add a cooling_device property with at least one
device\n");
                goto end;
        }

Mind to send a patch fixing both ?

Thanks

  -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
