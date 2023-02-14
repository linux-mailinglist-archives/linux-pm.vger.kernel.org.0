Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802E6695FD2
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 10:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjBNJxP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 04:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjBNJxF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 04:53:05 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB41EE3AE
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 01:53:03 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id i18so8071008pli.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 01:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmGdV1IpnhMsjWRrEzJObpGK30861bOEZaqYcgKiLho=;
        b=z615CfoeIqg2nU1qmrBUE/g7MILlMrvYNwvhNOd2hqm/4BGooq0b3YoqSFDjVHHyGO
         ynyOQEYgr8jCaVcHpAHdt+j5ukYaC64xyfp2unMa2IAwX697fDYL1+qoZIyz9qL2hysL
         EDjzsA6Gs3o8jn3NdaU9z2k/84KWVVrMr1a5DzJtTFMrvijLgUeEm4YmODNHxFRWkE88
         hK3jgL+cho30jL3AFmyJJ21Een1N/K3XHXa/S/26xW2Czw8d8N+B7WfU/EjzJ4r1qPtI
         J8pt7arBVNrIf6y/a6CB4Y+FrE8kzs20p9ZkPYQp/WpvgOywBZ1Qe8xoJa90LYdAXKaK
         sJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmGdV1IpnhMsjWRrEzJObpGK30861bOEZaqYcgKiLho=;
        b=M95lXlzVnQAWy7dRmrAU99XLgnAmO7OO/c/f9XhBkaH1kHDqtlnZx0+NG9gkKgBOmR
         +3lbbyo7zctsuTeo7QVHKXbqe4w6a7aDLRTyoc6DIyI/uhjNdMKxxfKmw2k8wRCdzuJl
         7vSKXqO9QrQLburspAB50a3ZB5ViHIw+XWW3aaor4XK5bPMvaV2fLGMRsfX+OReWLsBO
         9CUlsq862RQV7dmmG0To4EWGbc3mzX4gGYDHCqSgG4S4EpDAc2r3/JcVPZQIlw20NNIl
         NESg0k5gzyJ+Eg2EJs3Luj8McteTWQpLhUwa//VUWLfqHDoUI+7sM3aDMPPZDxCEYsvK
         PtaA==
X-Gm-Message-State: AO0yUKXQYY0E6yXDkc4jgPh8FaHCq+YPpzmaD98vZedpxWt5GLxGPnLG
        Kgt3eRN0B9pxLi2vHdN5kUnX5w==
X-Google-Smtp-Source: AK7set/cAOHYyECZofoGhGcncjfSOUlz1tBZrGmCkXK4RB6MFAgefrCg6UyXrZt2jE2Jd7ZS/ADsbg==
X-Received: by 2002:a05:6a20:3d82:b0:bf:ae32:5ed0 with SMTP id s2-20020a056a203d8200b000bfae325ed0mr1878163pzi.13.1676368383314;
        Tue, 14 Feb 2023 01:53:03 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id c188-20020a6335c5000000b004fbd91d9716sm681936pga.15.2023.02.14.01.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:53:02 -0800 (PST)
Date:   Tue, 14 Feb 2023 15:23:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rafael@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: Add missing null pointer check
Message-ID: <20230214095300.pv3e73r36poth5w4@vireshk-i7>
References: <20230214094115.23338-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214094115.23338-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-02-23, 15:11, Manivannan Sadhasivam wrote:
> of_device_get_match_data() may return NULL, so add a check to prevent
> potential null pointer dereference.
> 
> Issue reported by Qualcomm's internal static analysis tool.
> 
> Cc: stable@vger.kernel.org # v6.2
> Fixes: 4f7961706c63 ("cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 340fed35e45d..6425c6b6e393 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -689,6 +689,8 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
> +	if (!qcom_cpufreq.soc_data)
> +		return -ENODEV;
>  
>  	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_domains), GFP_KERNEL);
>  	if (!clk_data)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Rafael,

Can you still send this for 6.2 ?

-- 
viresh
