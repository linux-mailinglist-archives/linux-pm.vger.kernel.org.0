Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19BF572D42
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 07:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiGMFbM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jul 2022 01:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiGMFad (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2022 01:30:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D823653D1C
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 22:29:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id v7so7252208pfb.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mIKNUqGIZ9Qcs/aIEKfbb45zWwyQ7ymHQgJEzGuRfmY=;
        b=Ny8rhS1WZKQMuXVGjP+3D5R7oWYDMe916j3R1gOjKLQ0uNcPLnRsXXTJ8aJ6zhZFMs
         rDLokRXUEOIpoWENgB3XswNHOHfvZ5skLPosEfWp57e3Q8YP11IJDqp07+73sNtbwLn7
         n6oaXuYJRmojFkeXUYCpZpJZBTUBjmigVSXHD8izxH1M+Vo2x98/MNSbpSQV4IBrR7E9
         zNozXCMeMBmxuWeMrNYy6N7I062K5Y/qPoHuodNTT5d6CdrcGIi3BMihJrXpFCLxFR/E
         ROd0OsHcxjwqkHcyV8hnHYbYdUmcKVxwq5Fm6+VFDCHtWDhUCp7jNvcgfSXSQrrBCWpK
         cYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mIKNUqGIZ9Qcs/aIEKfbb45zWwyQ7ymHQgJEzGuRfmY=;
        b=AJIDruS2WBl/LdkggQa/8+ifzHJ1mTUjzWALs0IeagK9KYQ3CIJcAIszGL4a2ZNIMG
         cpq+tlFXgDFk/iM6a05jRaE1aiB/Zot3B7WtTL5a3cRvszNVBSSMgrSMajhJgbsUU6b/
         jcDX1KSbLHjS7XzzSzZt8AkTHM+gu8D1aRzQpxsaS0yh1FgqPaxtstwQbcSMsE9HVpnh
         LBTgJ1uvijd1CZg0FKqsB2tuntrm9RRxrgssLtGHO8B//H3+tDHrx49+Nq3Xn8HHwK55
         zV48Eut5e32TAdJ6Bi3SBucf5f/nLGnVo7o7AujVfIKyEGeFx/1UNXbZD7n23eFIFBQn
         EHhw==
X-Gm-Message-State: AJIora+HWUnZpVXjkHB5VSdRNBz1GDbCJNg5EzzRvlxiK1IbaPKCvYG6
        ttjHGavIogewQbP8SdarxuqAhQ==
X-Google-Smtp-Source: AGRyM1vwYLqbhaAA03Mv+i80sYx6T4NMLgMu73ZRb+nLgx+7PT4COnSsBifwZ3Z9fx92oFlYFbznkw==
X-Received: by 2002:a63:1c4c:0:b0:412:6eef:f91a with SMTP id c12-20020a631c4c000000b004126eeff91amr1520167pgm.361.1657690176550;
        Tue, 12 Jul 2022 22:29:36 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id p23-20020a170902a41700b0016a71196150sm7777872plq.135.2022.07.12.22.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:29:35 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:59:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 12/13] arch_topology: remove the acpi_disabled check
Message-ID: <20220713052931.hifhtonr7rkg3r2d@vireshk-i7>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
 <c31b9c213e7c3b344b299abdbef87b7d1bc29d57.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c31b9c213e7c3b344b299abdbef87b7d1bc29d57.1657638462.git.Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-07-22, 11:43, Perry Yuan wrote:
> "acpi_cpc_valid" function already includes the acpi_disabled check and we can
> remove the duplicated check here
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/base/arch_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 579c851a2bd7..73a8cb31529d 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -352,7 +352,7 @@ void topology_init_cpu_capacity_cppc(void)
>  	struct cppc_perf_caps perf_caps;
>  	int cpu;
>  
> -	if (likely(acpi_disabled || !acpi_cpc_valid()))
> +	if (likely(!acpi_cpc_valid()))
>  		return;
>  
>  	raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
