Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792C46679E7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jan 2023 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbjALPxn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Jan 2023 10:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240130AbjALPxV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2023 10:53:21 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832C2DEA5
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 07:41:56 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m6so28988236lfj.11
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 07:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvVJkpynNn6IA1P//L3YcO7yOYdHOM5TGw7F2BW1HfI=;
        b=mZWf1t9tcyeMA4GQXcr8qTcdv/+TqM/BqV5iKqOE4y36tTw81YCsd9DwsTWmqmATMc
         AsCQwj+j4RhhGoFWCypPO6gwZe7gNrQ+rEJpsUwvo4v1+rQ5etZSLfo5zKUX1NN9adCa
         K8PI0tEg+HxUEeMK6+eybaJ8n3GKQSkJd2cZ0YvkfW6eElvJmy91/yk96w71yp5AEKfT
         onTtLLpRppF0eRpuoeD17TIapXgfjIVQs5MjULq63CuI3w0bdGuE9zNjqMVOmAf9ptCN
         nrlkdfmWRWEZCy98bH9MP3G9uCXJ5AlYZO8s5TiFo7Mh2ppOWitQyNS0XBJ7fCScklwi
         pqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvVJkpynNn6IA1P//L3YcO7yOYdHOM5TGw7F2BW1HfI=;
        b=jKTK8WSOBH6YxuGfQmdIWIU+qJ5kh2+SBcngfk8ggHAKmpuPya3GEzynKUmvzCmQsI
         1IbzCoonMrxERc0G7oSV4KsJguKxsInYM3BVoYiCpY8BekeO3Vb2QYEPESZ/aeYI6RfS
         l/5vDcFVFhAbJuxvG/ffCjxGCTipEF7Vs/U86SpNHfn44ukZXjUJU76caRFvLoVIi2RK
         sofYJA1b5NTs9Uohtz47aJ5n/hBxHjYOKRaL82BH0eLx8aUlNDSqElzjF4ExT7I56dPf
         sGQcTqqmDIOXhMSn5gaBfhMk0PBfGX6x1ereZ5ub2QpSekQaFf3DrcqSWcZDPIhQ2T7f
         wnOA==
X-Gm-Message-State: AFqh2kqhsaWA1cHE2R8ZAtonO2/38bqmSGsEzfyxSBLwnY5wbeJ3YSHW
        F5hLIuVL+uC/0yq5pJc5Fx3OQA==
X-Google-Smtp-Source: AMrXdXu+pSZjQKg6YWKPpwwT1Cd28e2/W6qw8KqQ+mgP9Ohv6zo0OgYdcKPEM9ehempAL9hiEPw07g==
X-Received: by 2002:a05:6512:2213:b0:4bb:7028:f6b6 with SMTP id h19-20020a056512221300b004bb7028f6b6mr25214095lfu.49.1673538114309;
        Thu, 12 Jan 2023 07:41:54 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id y3-20020ac24463000000b004ceb053c3ebsm41710lfl.179.2023.01.12.07.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 07:41:52 -0800 (PST)
Message-ID: <7dec47af-0981-7d70-3926-69419f5d1c8e@linaro.org>
Date:   Thu, 12 Jan 2023 16:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Ensure only freq-domain regs are
 counted in num_domains
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230111205125.1860858-1-konrad.dybcio@linaro.org>
 <20230111205125.1860858-2-konrad.dybcio@linaro.org>
 <20230112153704.6d37dygm4yfexdq6@builder.lan>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230112153704.6d37dygm4yfexdq6@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12.01.2023 16:37, Bjorn Andersson wrote:
> On Wed, Jan 11, 2023 at 09:51:25PM +0100, Konrad Dybcio wrote:
>> In preparation for CPRh-aware OSM programming, change the probe
>> function so that we determine the number of frequency domains by
>> counting the number of reg-names entries that begin with
>> "freq-domain", as the aforementioned changes require introduction
>> of non-freq-domain register spaces.
>>
> 
> Requiring reg-names would break backwards compatibility with at least
> sc7280 and sm6115.
Ouch, you're correct..

Does checking for reg-names and applying the code flow proposed in this
patch if found and the existing one if not sound good?

Konrad
> 
> Regards,
> Bjorn
> 
>> Fixes: 1a6a8b0080b0 ("cpufreq: qcom-hw: Fix reading "reg" with address/size-cells != 2")
>> Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/cpufreq/qcom-cpufreq-hw.c | 34 ++++++++++++++++++++++---------
>>  1 file changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 9505a812d6a1..89d5ed267399 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -651,8 +651,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>>  	struct device *dev = &pdev->dev;
>>  	struct device_node *soc_node;
>>  	struct device *cpu_dev;
>> +	const char *reg_name;
>>  	struct clk *clk;
>> -	int ret, i, num_domains, reg_sz;
>> +	int ret, i, num_reg_names, num_domains = 0;
>>  
>>  	clk = clk_get(dev, "xo");
>>  	if (IS_ERR(clk))
>> @@ -684,19 +685,32 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>>  	if (!soc_node)
>>  		return -EINVAL;
>>  
>> -	ret = of_property_read_u32(soc_node, "#address-cells", &reg_sz);
>> -	if (ret)
>> +	num_reg_names = of_property_count_strings(dev->of_node, "reg-names");
>> +	if (num_reg_names <= 0) {
>> +		ret = num_reg_names ? num_reg_names : -ENODATA;
>>  		goto of_exit;
>> +	}
>>  
>> -	ret = of_property_read_u32(soc_node, "#size-cells", &i);
>> -	if (ret)
>> -		goto of_exit;
>> +	for (i = 0; i < num_reg_names; i++) {
>> +		ret = of_property_read_string_index(dev->of_node, "reg-names", i, &reg_name);
>> +		if (ret < 0)
>> +			goto of_exit;
>>  
>> -	reg_sz += i;
>> +		/*
>> +		 * Check if the i-th reg is a freq-domain base, no need to add 1
>> +		 * more byte for idx, as sizeof counts \0 whereas strlen does not.
>> +		 */
>> +		if (strlen(reg_name) == sizeof("freq-domain")) {
>> +			/* Check if this reg-name begins with "freq-domain" */
>> +			if (!strncmp(reg_name, "freq-domain", sizeof("freq-domain") - 1))
>> +				num_domains++;
>> +		}
>> +	}
>>  
>> -	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * reg_sz);
>> -	if (num_domains <= 0)
>> -		return num_domains;
>> +	if (num_domains <= 0) {
>> +		ret = -EINVAL;
>> +		goto of_exit;
>> +	}
>>  
>>  	qcom_cpufreq.data = devm_kzalloc(dev, sizeof(struct qcom_cpufreq_data) * num_domains,
>>  					 GFP_KERNEL);
>> -- 
>> 2.39.0
>>
