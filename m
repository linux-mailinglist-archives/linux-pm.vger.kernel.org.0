Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB23140BE76
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 05:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhIODwi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Sep 2021 23:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhIODwg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Sep 2021 23:52:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A58FC061574;
        Tue, 14 Sep 2021 20:51:18 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x7so1414673pfa.8;
        Tue, 14 Sep 2021 20:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WY/GfQ6Rqj3YqcjxHunRfD2akCMAESTt8w8d4Zhvv5w=;
        b=cidkH9uNAQVLWGXkGqup50kNyFpt9UfpsxbDMxH4DEWVoSOKCTkJP/9p3l5/DO1wM5
         6td4Vdmgew2BjUtOCCsxOTSAhsonJGb9pE/r1SI56ZDFDLea3/fSIKUCkQAvoB+OsV5+
         QjSAzx3IXZ6KuhmgiB1gpvYO8/6siBifHz37BuqW8099S9xdd7Nk5jWFw6fCDlqTC8aH
         NyONlBFplS9uaHiQZfkTgNCMshDOd4EnjngmGlbFjnF9qvOQb2iXKdgp131w/7ghyxOM
         SspDxoLm19L9tDIaIn9hgSTQhM+i+29m9whyL44T3HDc6ozEk4+IFtOEpZ16qu+lZtBR
         Zgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WY/GfQ6Rqj3YqcjxHunRfD2akCMAESTt8w8d4Zhvv5w=;
        b=dXSVnf2VkfVexZ5gMvvBLZrbWzF0z2jFp0/dt38LKzZAjUJyab0Dt+5doSqpB5tlw2
         Skq+yM178I6CjxYkmyGMCle4ck4+5Q9esmiLXLfGp69w8a4TWX6e4SbImiegZcu/geB+
         1IN4imLbIkKuKzDpJ7C+n6Gu+Vwe6ZVPUPnGAJQPhmQkI3NMs24Tt2txmt+4HPfr35dS
         ia71VLXk7yhkbbhhhF4QFWXpECEsYPMSP2Pk8tdJIMlgvO2lORUaenA2jkf3+1GuBUV2
         b/2WlYSodPsZK8IQVTV1x0kNnpRc9keZpwOPrBxju4PwsOEUVATqxOF7c748x9aBl348
         U34A==
X-Gm-Message-State: AOAM531u+upPYhKhMF/dXZyoRPfnzrnB9kukz+nStXQvtRvLq8NY5RXA
        6p7efhYoKvrI1H0/14O3Inn+nW/ZE8Y=
X-Google-Smtp-Source: ABdhPJxWW7TCDRwjHxpafjz7AYg5hmkid5cCZqZxbl30Qs1pvrqYrInkK8WG54ZWYHUP4u1AlY+C5A==
X-Received: by 2002:a63:1259:: with SMTP id 25mr18628737pgs.48.1631677877500;
        Tue, 14 Sep 2021 20:51:17 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id q20sm13131648pgu.31.2021.09.14.20.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 20:51:17 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] PM / devfreq: tegra30: Check whether
 clk_round_rate() returns zero rate
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210912184458.17995-1-digetx@gmail.com>
 <20210912184458.17995-5-digetx@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <9fa66405-883a-3653-eb5d-3cd7eee07a0a@gmail.com>
Date:   Wed, 15 Sep 2021 12:51:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210912184458.17995-5-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 21. 9. 13. 오전 3:44, Dmitry Osipenko wrote:
> EMC clock is always-on and can't be zero. Check whether clk_round_rate()
> returns zero rate and error out if it does. It can return zero if clock
> tree isn't initialized properly.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/devfreq/tegra30-devfreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index d83fdc2713ed..65ecf17a36f4 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -891,9 +891,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>   		return err;
>   
>   	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
> -	if (rate < 0) {
> +	if (rate <= 0) {
>   		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
> -		return rate;
> +		return rate ?: -EINVAL;
>   	}
>   
>   	tegra->max_freq = rate / KHZ;
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
