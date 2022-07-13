Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B665737DD
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 15:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiGMNuP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jul 2022 09:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiGMNuN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2022 09:50:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F887E31
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2022 06:50:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bf9so19121910lfb.13
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2022 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hdLLLHosQ1sLvF2rzApRhs/cgJ52KrTVDElat0mNK1Y=;
        b=c6p1/yLsOu0fZ1pvQNURB8hKJMV0IKIehOpBVFDXl4bZjlDxhlk3oQOK4ov0100Yes
         AOEiwreROOVoCnjv2ykC79FBzKrjVxmDJWUcU1j2KwEoDBJsbu1/15sZr0XJ3icWpDDI
         mJPpjrWUJXc5tKUsrp6ORHmmbWZQ4l3AEUcu+VDvu/pZ0Pv0Ke/hOhUNW3vaoiIR+CcH
         9BtsCD9to16ItSy6UciEPsDl7WM0Ajn6d7iMjb6v6PPiH1nCZUGnxEa3IwrGMGklg6+T
         gU6xmdwPmcE9ghunqmKr1++U9d0JlD3+P4LpB5Lzz7DjjOC+Aqosr/EMg6CS5+fuGUGu
         1DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hdLLLHosQ1sLvF2rzApRhs/cgJ52KrTVDElat0mNK1Y=;
        b=Q4NjJX18RpNM2vLXfY2+XoVBNvpXcSTqLFNubcIv9lSiYpn2Oy7Xc4STEHdoKxi52c
         gcoBE3oAdrKGRqrL9pDg2IvMYG8IlAeGj7uPfx38LgNG3QO2EdO8WyBFS4KP+bsKakTw
         fal3Uyoe2wLYrEVkDVxdHrPOaxgPwVGDUzgpsAAzZfqfd0yJPT/ERhsr3rh+jah+PyAm
         McV5hX53wDVMZT1bY9io0iM1FvkFs4o3rc3XlTqox/lUJ6yqdJo9o2TLC9KLVkru+RN2
         SS8ZxAnprhpjS0819tF4RC1y7c0tU8MwToRBZy/qUrOqjzJokInVdZbiJMMLHv392csD
         VN4w==
X-Gm-Message-State: AJIora8RW7gbV0V2YgvhZOgcZnfoliPOGQ5W8xGF8WIYw7QFfVVGWo+2
        gB67LJQCtGNjlNhBBbF5m0+1yA==
X-Google-Smtp-Source: AGRyM1sNVngn8FMJmdpIP6siehGCogcUhnvnih+EqAKBFOx/wSxPTbMdS7qqNH46hqZAizBPr+dsTA==
X-Received: by 2002:a05:6512:a86:b0:489:42fd:de1e with SMTP id m6-20020a0565120a8600b0048942fdde1emr2012554lfu.174.1657720207884;
        Wed, 13 Jul 2022 06:50:07 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b21-20020a196455000000b0047f943112e3sm2810998lfj.285.2022.07.13.06.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 06:50:07 -0700 (PDT)
Message-ID: <e160364f-68b9-2ab6-e48d-86d12e4a2f0c@linaro.org>
Date:   Wed, 13 Jul 2022 16:50:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RESEND PATCH 4/5] cpufreq: qcom-cpufreq-nvmem: Rename qcs404
 data to cpr_genpd
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, ilia.lin@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
 <20220629130303.3288306-5-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220629130303.3288306-5-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/06/2022 16:03, Bryan O'Donoghue wrote:
> At the moment the CPR genpd based code is named after the qcs404 however
> msm8936, msm8939 and other antecedent processors of the qcs404 can also
> make use of this data.
> 
> Rename it to reflect a more generic use.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 6dfa86971a757..355c8b99e974a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -252,10 +252,10 @@ static const struct qcom_cpufreq_match_data match_data_krait = {
>   	.get_version = qcom_cpufreq_krait_name_version,
>   };
>   
> -static const char *qcs404_genpd_names[] = { "cpr", NULL };
> +static const char *cpr_genpd_names[] = { "cpr", NULL };

As a generic comment, as you are touching this piece of code, code you 
please move cpr_genpd_names above match_data_kryo? So that all 
match_data instances can use it.

>   
> -static const struct qcom_cpufreq_match_data match_data_qcs404 = {
> -	.genpd_names = qcs404_genpd_names,
> +static const struct qcom_cpufreq_match_data match_data_cpr_genpd = {
> +	.genpd_names = cpr_genpd_names,
>   };
>   
>   static int qcom_cpufreq_probe(struct platform_device *pdev)
> @@ -454,7 +454,7 @@ static struct platform_driver qcom_cpufreq_driver = {
>   static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>   	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
>   	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
> -	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
> +	{ .compatible = "qcom,qcs404", .data = &match_data_cpr_genpd },
>   	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
>   	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
>   	{ .compatible = "qcom,msm8974", .data = &match_data_krait },


-- 
With best wishes
Dmitry
