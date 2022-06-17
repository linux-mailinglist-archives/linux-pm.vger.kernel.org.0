Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A36254EE68
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 02:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379238AbiFQAVz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jun 2022 20:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379255AbiFQAVy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2022 20:21:54 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855D63398
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2022 17:21:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c30so3121258ljr.9
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2022 17:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zELuLJDtp+1xwhB/xB/ct9I01uRFw28EJaVsfAJ8WPo=;
        b=w3npb2ddMCloZzfe9sbgDyA/TDkG1rxKALOo84wqy8EiYmc4xxsYxWi7HsB4s1iqQO
         SyXXO27gO0kOqMXkXFYf/i98b0mMoQh9ke3JdGUuK9Rt8oHWfmW5DJpLyePmUGZMzcjG
         8IxqXXkqEirYVX82Lqte5nnieFudBD7+WxL6F9ZgSBJN1nme7n3MdrTEmdI/Os/pUFf0
         EHJF94Q7khggNh59tYRPb3kBdsf9ltL57f32QKTMSuofMAwDBTi5APHIk0strKGdXcaY
         cQCB01ybj+/uxFJ7TOP4dYRirH2QYKXoyM353xeFZ1vC9hHbcj2GAzW4X1SFjzMexUvE
         y+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zELuLJDtp+1xwhB/xB/ct9I01uRFw28EJaVsfAJ8WPo=;
        b=H+sNQdOx/RQeQL3/VDVOQcMaqcx69gubfQnbHhXbtM5o+U/eOyjMiNtTj6E0JR7Zlx
         0j3bR7+OvPRkzH/d0opTvXXJqMoUL+zf6QXUERJH6Qh7Vou6JPYJ9U6O1Re+PI92lqR2
         PZS1ykno9pBBmeUCk0DbgiXFDZ15WmkmzqlVhqU86LrATptsInbWO/HaiYdgc3rFGaiP
         2oj1t9b/o19IuV66hSv9X3UePl1zRaO0Xx0OZCiJ4oKkYnGWup1U8NiSzISor4+1P7KV
         FJ1f52V9USMHOUFAO9sJDLn3etdcDqhUCl6V4uqk75njocSv79DpqUlvuhIfNg5aRQB0
         vk5w==
X-Gm-Message-State: AJIora9QyozkGydOOq6+Dtbxu2I1VZ2BzH6Xez6keKKUmDSWNp85jwed
        fGnqTBs0/f8aLtxqe12rX8eUHg==
X-Google-Smtp-Source: AGRyM1to/gZ2Nf9OeKNJvqpJN5WGk4UVL31SFCT/xQZrevC+O/VwFUffzbhsFUTqvT9KDZYImYY5dw==
X-Received: by 2002:a2e:3315:0:b0:258:dfff:e252 with SMTP id d21-20020a2e3315000000b00258dfffe252mr3823905ljc.141.1655425311542;
        Thu, 16 Jun 2022 17:21:51 -0700 (PDT)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id r12-20020a2e80cc000000b0024f3d1dae84sm380589ljg.12.2022.06.16.17.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 17:21:51 -0700 (PDT)
Message-ID: <ce6106e5-3dfd-c2e7-07b9-91be9aef2cf4@linaro.org>
Date:   Fri, 17 Jun 2022 03:21:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] cpufreq: qcom-hw: Don't do lmh things without a throttle
 interrupt
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20220616224531.3139080-1-swboyd@chromium.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20220616224531.3139080-1-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/17/22 01:45, Stephen Boyd wrote:
> Offlining cpu6 and cpu7 and then onlining cpu6 hangs on
> sc7180-trogdor-lazor because the throttle interrupt doesn't exist.
> Similarly, things go sideways when suspend/resume runs. That's because
> the qcom_cpufreq_hw_cpu_online() and qcom_cpufreq_hw_lmh_exit()
> functions are calling genirq APIs with an interrupt value of '-6', i.e.
> -ENXIO, and that isn't good.
> 
> Check the value of the throttle interrupt like we already do in other
> functions in this file and bail out early from lmh code to fix the hang.
> 
> Reported-by: Rob Clark <robdclark@chromium.org>
> Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: a1eb080a0447 ("cpufreq: qcom-hw: provide online/offline operations")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 0253731d6d25..36c79580fba2 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -442,6 +442,9 @@ static int qcom_cpufreq_hw_cpu_online(struct cpufreq_policy *policy)
>   	struct platform_device *pdev = cpufreq_get_driver_data();
>   	int ret;
>   
> +	if (data->throttle_irq <= 0)
> +		return 0;
> +
>   	ret = irq_set_affinity_hint(data->throttle_irq, policy->cpus);
>   	if (ret)
>   		dev_err(&pdev->dev, "Failed to set CPU affinity of %s[%d]\n",
> @@ -469,6 +472,9 @@ static int qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
>   
>   static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
>   {
> +	if (data->throttle_irq <= 0)
> +		return;
> +
>   	free_irq(data->throttle_irq, data);
>   }
>   
> 
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir
