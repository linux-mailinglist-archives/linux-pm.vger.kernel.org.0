Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518152474A
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 09:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351160AbiELHrZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 03:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351162AbiELHrX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 03:47:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1BF1B579E
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 00:47:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c9so4152070plh.2
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vwkfMqkkpGs1FVotSl8gOPBh3VAjsH5HCd0W5khKpM0=;
        b=QwOMO2oq5TbAyOFDFvpvkgkWVG6EaFOmZlzyuwsRB7Flg+Ox5gGrxGlgd257ueDece
         fAIvn+7oEvIbuelneZQjTzbxL+CSaBt4skadbYywXlDR4ZoqdF4Jo5aIouhWpRx2qpsl
         bpaVmdL7fcragnIuna4eczG35NFsj5Fgjn6TXwwsJ+P6s/WXLxqPiSVc5kHe1LyILLw1
         5Kuc9nX8N/8UVRcAjKl9ry49jeTRNn8+5BE/tPtuTlGEQ5h3osSjs+0ywkuWTx/M2HQY
         ZZmO8ghKDlLqpecBME9A6nLni9x7hRLyp8im5ldlY/plFQEKIeDSSiEOVFZNZD3X6A0N
         Z3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vwkfMqkkpGs1FVotSl8gOPBh3VAjsH5HCd0W5khKpM0=;
        b=G21Yj+Umv6IzQ1uvuw6IeVob1GAT+PguJfigZVGtcwlU/79GfFBzb2MXwpx0wN9hwX
         QVhelBoDoTthCBRfcAKF8JzxDSnVz+NMpKaZAl+XWhIFQelEDsfwqFV2s8zOCSwfstz3
         AoT08MDKiP4D5pHrsiVjg7RKZGTB3gXnF8gl6jK0iV0Nv8ITxCOTkDznqZRG7dqf3BxZ
         j4tQx8W52eGxf7ePYKjbZv1Wqm13vj1CEQHlvT9pg4jCKXDlPpn3TtL+fEV4JFO6EQdd
         +yGyFaYCNo8qeK5tnm1BiqYmDE9qWFQ1z1wg1pU+fUBkJn0fDPV4jZ26sW9Z48Sby2ek
         sp+A==
X-Gm-Message-State: AOAM530hoHmfuwdvtHkLH+WUkM0yF00zY3fbTUa6ul0RIlhzn7/KyFhw
        NlS5R3kzCt72vUUrg+ANYjIBBQ==
X-Google-Smtp-Source: ABdhPJx0gFtg0LRz6XpvrQ6zmby9LlayUCFmF87pWSFCFPlW3HOI/+gcMgEygACnvoeQR4T/ohb3ug==
X-Received: by 2002:a17:902:f78d:b0:14d:522e:deb3 with SMTP id q13-20020a170902f78d00b0014d522edeb3mr29111982pln.173.1652341635112;
        Thu, 12 May 2022 00:47:15 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id z12-20020a170902708c00b0015e8d4eb1desm3180431plk.40.2022.05.12.00.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:47:14 -0700 (PDT)
Date:   Thu, 12 May 2022 13:17:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH v1 5/5] cpufreq: CPPC: Enable dvfs_possible_from_any_cpu
Message-ID: <20220512074712.oaf7qaqeds5hlg63@vireshk-i7>
References: <20220511134559.1466925-1-pierre.gondois@arm.com>
 <20220511134559.1466925-5-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511134559.1466925-5-pierre.gondois@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-05-22, 15:45, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> The communication mean of the _CPC desired performance can be
> PCC, System Memory, System IO, or Functional Fixed Hardware (FFH).
> 
> PCC, SystemMemory and SystemIo address spaces are available from any
> CPU. Thus, dvfs_possible_from_any_cpu should be enabled in such case.
> For FFH, let the FFH implementation do smp_call_function_*() calls.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 000a0c610c30..ad1535fbf389 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -558,6 +558,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  
>  	policy->fast_switch_possible = cppc_allow_fast_switch();
> +	policy->dvfs_possible_from_any_cpu = true;
>  
>  	/*
>  	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
