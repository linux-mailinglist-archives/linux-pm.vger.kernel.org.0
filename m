Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70558261EE9
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgIHT5E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 15:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgIHPgL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 11:36:11 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FD9C061365
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 08:35:58 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g10so15188533otq.9
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/DW0Pv++fUgCZxfo9rYcn7qda+ZUC8ohqv27lkw1ucQ=;
        b=G1KRjLzjqiJVs5Jo0i8Ep+KEXzN1G+zUkbUqGWsKVVHCcm4PnHAJE9Da81N4V7p0OC
         Ch4wJ2osMI1Tu7nf379jWemywMcKIO8BKFsmN3R5vMvG5Tr/YnO6kRDUhDGO6sWOCTDY
         MOwXmI+zGKnjiNNB5W+sZAdrA/ULr5l3r4utIgOL0g1hjbrZRUVN+QOzJIfDSiknfF8i
         0TiMdv2Z719+Y9C9tk1SfTB2UPlKBN2SKrAFoWf5M26Cpli6K2ppX5riwg0b1kN+vFFC
         rlpPwhGA7JRzWHskGvipioh/WSCllEZkW7c4TpRSGxnzv/aO7EgyugG8S89tRWDb6QXj
         3Zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/DW0Pv++fUgCZxfo9rYcn7qda+ZUC8ohqv27lkw1ucQ=;
        b=gU/xG+YjP6uxmLkAl+5+25rQReyWInz8CuS5omrR0ZSpoqeYbJUmMvPpbAw5VSNjCt
         qI/GPG9DECjGPkUxGedeehpC2Wyzma7ThNbq3lZvu8IQWprlrA4AZrztPYvcHC0JZQos
         1Jui6P+wJn1Zm6irUwOZUmkqC3P49oLg4DA95Skm6EYXY0mApJDg0K032fJvdRqwJwaK
         RK0UfaVFHZkoJjdcGYPiFlDnaD/LQLdCBHTZRmJhnl4rsUCbFyXc6m6YLoWJsVM8t1sQ
         5sK0GHBg832O2lcr4C45KxMcdamgY/NKQ5Bjw7/j2iEOa2JrLfk61ZhzZPt6PKK7llC+
         dYEA==
X-Gm-Message-State: AOAM533jGHXatQW9eM3DWFiqFEcfi0WYoi783yaGqSXetU/rBlAQ2uvY
        uv7aA8/IGbiT4LOf0XQb/BGpoQ==
X-Google-Smtp-Source: ABdhPJzASL9cBRJCM2R8eqEuUTsxBq1o0FtmeN3bHyw1qVZM60i+l330TfHGLpPohTTmc3QpgtEwqw==
X-Received: by 2002:a9d:21c4:: with SMTP id s62mr18414200otb.350.1599579357887;
        Tue, 08 Sep 2020 08:35:57 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id e7sm2948400otk.59.2020.09.08.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:35:57 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:35:54 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 7/7] cpufreq: qcom-hw: Use
 devm_platform_ioremap_resource() to simplify code
Message-ID: <20200908153554.GQ3715@yoga>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-8-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908075716.30357-8-manivannan.sadhasivam@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 08 Sep 02:57 CDT 2020, Manivannan Sadhasivam wrote:

> devm_platform_ioremap_resource() is the combination of
> platform_get_resource() and devm_ioremap_resource(). Hence, use it to
> simplify the code a bit.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index c3c397cc3dc6..6eeeb2bd4dfa 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -307,7 +307,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	struct of_phandle_args args;
>  	struct device_node *cpu_np;
>  	struct device *cpu_dev;
> -	struct resource *res;
>  	void __iomem *base;
>  	struct qcom_cpufreq_data *data;
>  	const struct of_device_id *match;
> @@ -333,13 +332,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  
>  	index = args.args[0];
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> -	if (!res)
> -		return -ENODEV;
> -
> -	base = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!base)
> -		return -ENOMEM;
> +	base = devm_platform_ioremap_resource(pdev, index);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data) {
> -- 
> 2.17.1
> 
