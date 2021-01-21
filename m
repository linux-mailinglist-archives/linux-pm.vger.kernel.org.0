Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8E42FF768
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 22:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbhAUVhu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 16:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbhAUVgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 16:36:50 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5706C06174A;
        Thu, 21 Jan 2021 13:36:09 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id p13so4237643ljg.2;
        Thu, 21 Jan 2021 13:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YVqgssMQdQhf9y4JoWK0z3t3swC1/ivpAtAAVdvhll4=;
        b=s/o8iP3f3g2RyAf0tsVr2o+psJr/byantEoQeD3hFGfAIysCZTR59lyN5PZ3XKN1qW
         /xvkhqeg2suJDIb+8ByOo5mgTbwsHJH5qM1SAQCd2h+0QO8zG/L6pjwWlbcC6COTaOyl
         +KGRl3IcRVFS5tXYbGgL0MShb+stQyDjOK2zhlF5rxntfW5yFJVU1SVWo6IWbIxuhhrR
         5k5QLe5ddFfQYycgWlOjNSP+BMjPQjmyhC5pMqVKxujTrP+F4NMckZfULHmo8HA8Szga
         Fl7DbYX+KTT+VSgn2b3v+T9CRDx9K7lk4APaIfekExKBDRBcP8vlYQyWUbFCm9yIkcCG
         EUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YVqgssMQdQhf9y4JoWK0z3t3swC1/ivpAtAAVdvhll4=;
        b=HK68l1QWyfb4eUQ03GfUvyeXyLq2+wj2ttouSAv90VaZtZTHezM8zk3of0S38OABtW
         eR2rXZiRfTPHXIgesLH17jYIFo38J9qDCINmcNfw+11zD2PGqbksgy4Gzu+EZPwJJoIR
         3YTwS2tFm8lhs6M9LupYsGUpV9Y5NixrfQ0eKGeKuE5GISLgxJUPalpi8KbXD5+5c9gD
         15ifsVD0+zlODTJk5vG/CUmCUm6IldQJwUZnayW/enaKZ+gMpjiKW8Ba2dvfPwaPgvbG
         yv9qDFkpp2oKdrdvf/xAIHs9v1EZmx5kTVQVIicdcT5ypdNCbxKCxCfgaZnojO3vZVGB
         vAmg==
X-Gm-Message-State: AOAM531E4R1c+kql3ocWVKU4qvawpVVVuw5gM+5+Rc8JbCLflSkOgvc8
        QvDnRLe8AVc/uiMWXiSaGVN02Vnsil8=
X-Google-Smtp-Source: ABdhPJwIPaV85WcNNtbxmI3PgM7773oygI3tszwUBIQeJepq5sb+YObOjRnU/5o3/Z0ZlU4qsIoo8Q==
X-Received: by 2002:a05:651c:2049:: with SMTP id t9mr693818ljo.58.1611264968032;
        Thu, 21 Jan 2021 13:36:08 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id p3sm652233lfu.271.2021.01.21.13.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 13:36:07 -0800 (PST)
Subject: Re: [PATCH 11/13] devfreq: tegra30: Migrate to dev_pm_opp_set_opp()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <3345fd49f7987d022f4f61edb6c44f230f7354c4.1611227342.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <71451eb2-46b2-1ea0-efcc-0811568159a4@gmail.com>
Date:   Fri, 22 Jan 2021 00:36:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <3345fd49f7987d022f4f61edb6c44f230f7354c4.1611227342.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.01.2021 14:17, Viresh Kumar пишет:
> dev_pm_opp_set_bw() is getting removed and dev_pm_opp_set_opp() should
> be used instead. Migrate to the new API.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 117cad7968ab..d2477d7d1f66 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -647,7 +647,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  		return PTR_ERR(opp);
>  	}
>  
> -	ret = dev_pm_opp_set_bw(dev, opp);
> +	ret = dev_pm_opp_set_opp(dev, opp);
>  	dev_pm_opp_put(opp);
>  
>  	return ret;
> 

This patch introduces a very serious change that needs to be fixed.

Now dev_pm_opp_set_opp() changes both clock rate and bandwidth, this is
unacceptable for this driver because it shall not touch the clock rate.

I think dev_pm_opp_set_bw() can't be removed.
