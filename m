Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88A2615C77
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 07:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKBGul (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 02:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKBGuk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 02:50:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B975FA9
        for <linux-pm@vger.kernel.org>; Tue,  1 Nov 2022 23:50:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v17so12672482plo.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Nov 2022 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXMD3gyfvxWm4qyf9rawBC7bW9w48hpLGmrypv4ln1g=;
        b=wkdjC1PniWFSbFrDePUQAaP9UVwGpIgFBA0HEmknycO0fpZaOLVIcTuvLe9MXUXPuO
         OqMN+nxIDrX2qi8687Nmr8KNh2EJ7a0Z3JlW5+L7iHCqhj8OfZ+IQdXaZK37VWSQ26Ko
         XBvmjbyMqyPOTU75V5sUEvv3kjUGYVzkzV+dxUzsB90IfYx9OnfkJB3kjVy99Ye3xRYw
         tPaa8K+ed/Z33ISnDtjJFfPnVhAl+VojVMhd3KxLnP9PVSG4CXpVcK3A4Mvq5O/iUFZW
         a5iHtG52TJZSY8wHwtB+/YQcHwE8F7x+QfAIKcUVYKUv8hRuyy8y7tl2GUPFcK1UanoA
         gHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXMD3gyfvxWm4qyf9rawBC7bW9w48hpLGmrypv4ln1g=;
        b=fyPn4bJ48FW2iLhrbmFGapWzSb0cvgRBQ7kjifKIp+qWRRQ7KVzK5el7QFkFlMT9Ol
         DFxI61iFwcl1wsZrNZOvV21L/5rewZnWEMSVwZZ+/0sB4xXMMZKRWTV8ZRNy4I38Nvrp
         R68lYPW2GNyI1TjVa4mEwkjwlS03yIV3SJRGlPUn8ZE2AtIYUwixyRQOwjEVEoGtfrWp
         CASKxwV0VfEBqXwvEFFW9ItQ6q/O2/hjultkeOxmyj/uWr1k/ni91OGWhKd5zX1vB3B7
         AErpLgX8KyoSfKintkANVEw4pyNz4IaDsjsbthryr2egyTmpwyyhlLdf0S7B1AcKqi/+
         7ytQ==
X-Gm-Message-State: ACrzQf3FQZfa+iycCKiZJGQac07jvzkBy1tFCHklxnrOYYDs70B+f6GS
        V5VV6adl3eWSGIEx2V0yD+Mqfw==
X-Google-Smtp-Source: AMsMyM7OvQSo6gb7wQUvtS2ULXR7iqGuA2Ug2BbbNx40CAc1ubs+jJVTckNeJREbLffs4UtWPWyuzw==
X-Received: by 2002:a17:902:ea04:b0:187:4923:56f4 with SMTP id s4-20020a170902ea0400b00187492356f4mr1288331plg.97.1667371838052;
        Tue, 01 Nov 2022 23:50:38 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id c28-20020aa7953c000000b005624e2e0508sm7602798pfp.207.2022.11.01.23.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 23:50:37 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:20:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/7] cpufreq: qcom-hw: Remove un-necessary
 cpumask_empty() check
Message-ID: <20221102065035.nf7m33acsjp4foit@vireshk-i7>
References: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
 <20221025073254.1564622-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025073254.1564622-4-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-10-22, 13:02, Manivannan Sadhasivam wrote:
> CPUFreq core will always set the "policy->cpus" bitmask with the bitfield
> of the CPU that goes first per domain/policy. So there is no way the
> "policy->cpus" bitmask will be empty during qcom_cpufreq_hw_cpu_init().
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index d5ef3c66c762..a5b3b8d0e164 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -552,11 +552,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  		data->per_core_dcvs = true;
>  
>  	qcom_get_related_cpus(index, policy->cpus);
> -	if (cpumask_empty(policy->cpus)) {
> -		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> -		ret = -ENOENT;
> -		goto error;
> -	}
>  
>  	policy->driver_data = data;
>  	policy->dvfs_possible_from_any_cpu = true;

Applied. Thanks.

I tried applying 4-6 as well, but git am failed. You can send such
cleanups separately, so they don't need to wait for others to reviews.

-- 
viresh
