Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4577F78240B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjHUGw4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Aug 2023 02:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjHUGw4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 02:52:56 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B15DB1
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 23:52:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a8036d805eso2304182b6e.3
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692600774; x=1693205574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ve8D51PRNPIO0v8XFqJRtrlKQMMc1izQOOwzjOms4oM=;
        b=RBpLm79g77HG58MzWOOx0OuACWpsNWqfrmqRnljb2KSgHJ0IIg2uuDeeItZWOgVvUe
         6OZFtqpilZli4aD7We97iEtueZMnj/SaqmOocaBj4j9kLbKa2CUqhA+oUW9DiPqH6NU5
         yXnhp9nWdNw2b60iot1HLsgjqMVZNdyw1Faox59xjhMSF+xl3mUf8y2vyJQ+oX48nxbj
         0XJ3Rj3xydLvJQqMaRMm4KM3kcGlMhzLaeLkZrAekBt32LIaXt3JI5mgXhwv4UDvHzog
         1nMAwAEGqbaEmFWjCmaHQHIjK1Bwa0e4iAGjuD8XRcgfDGkN+JgMsg2/w5PacEHhrxoV
         td6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692600774; x=1693205574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve8D51PRNPIO0v8XFqJRtrlKQMMc1izQOOwzjOms4oM=;
        b=jQtuOUlS/Rk3Pwv+2zeR7yDrQbMTFLgMGYlFjn8C2HkzA6wPf8ZC6LUQY6X3OKQ2VB
         gty/YkY7o7ifWIrLt4kZNlnNZeoWxgSuv+GfyQBzSBbBjHtAvGoOTI5JsalMW7QwH0Na
         G51ogjWs/UXuUrLJFHTFeKJ7/g39sYUqybn6CwZewB5gtdWi86yF+DouRTnmEwHKLN4t
         Q/VgmPgSi854KEt072u7J84eN/u5yhVZnU3OR3TPHfOyjPcAEMlJw3U0kKvHbYq8fOWh
         R6sJFYyv5aOGSt3125IuLLYz7YYRtQdk8OWHS07V9Tvv0m3AxkoKACYmC0Lm1Xm+QBrQ
         u3Vg==
X-Gm-Message-State: AOJu0Yxg4UNceHsegfg1hGNiVPt/UAe+7o73U6X/pZvfF+2OLLmo2YJU
        8qIJZMOd13SHVYFCqMSKAmCQtQ==
X-Google-Smtp-Source: AGHT+IHCzbmFF/CCMTXlVU/61Q8U5IED/IrulPQT4R1ZXNHBKizJ+8pmgnMHsjQoT+FflakA4O/aWw==
X-Received: by 2002:a54:4e1b:0:b0:3a8:4392:5b7 with SMTP id a27-20020a544e1b000000b003a8439205b7mr7489784oiy.39.1692600773712;
        Sun, 20 Aug 2023 23:52:53 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id u15-20020a62ed0f000000b006887be16675sm5394897pfh.205.2023.08.20.23.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 23:52:52 -0700 (PDT)
Date:   Mon, 21 Aug 2023 12:22:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: stats: Improve the performance of
 cpufreq_stats_create_table()
Message-ID: <20230821065250.oz7jga5jcveiddlg@vireshk-i7>
References: <20230818095000.937633-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818095000.937633-1-liaochang1@huawei.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-08-23, 09:50, Liao Chang wrote:
> In the worst case, the freq_table of policy data is not sorted and
> contains duplicate frequencies, this means that it needs to iterate
> through the entire freq_table of policy to ensure each frequency is
> unique in the freq_table of stats data, this has a time complexity of
> O(N^2), where N is the number of frequencies in the freq_table of
> policy.
> 
> However, if the policy.freq_table is already sorted and contains no
> duplicate frequencices, it can reduce the time complexity of creating
> stats.freq_table to O(N), the 'freq_table_sorted' field of policy data
> can be used to indicate whether the policy.freq_table is sorted.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 55c7ffd37d1c..fcb74050711a 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -243,7 +243,8 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  
>  	/* Find valid-unique entries */
>  	cpufreq_for_each_valid_entry(pos, policy->freq_table)
> -		if (freq_table_get_index(stats, pos->frequency) == -1)
> +		if ((policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) ||
> +		    (freq_table_get_index(stats, pos->frequency) == -1))
>  			stats->freq_table[i++] = pos->frequency;
>  
>  	stats->state_num = i;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
