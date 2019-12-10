Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A881182E6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 09:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLJI5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 03:57:48 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:44479 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfLJI5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 03:57:47 -0500
Received: by mail-pl1-f177.google.com with SMTP id bh2so5909483plb.11
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 00:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bcvv3s1jlwFos7tbnxmBqdUoy0tu/VtVTQxA5iaPcwE=;
        b=lx8HIhZk+ygBX8lJ/MTRADe13GIXlNbzU3K320CRY43bowe4jd9jf6OrMzFg4A9fZT
         PeUp3hbntNu+RpAed6kTowxybflcGJumztWgd32F9vPsInuXzOF8XHSf9Z/4Gb7sgT93
         Zfa01+cr+ov+vVk4bWi8jX/a5DhNFXq9aKZCFOP3bg3qZCgxfeCXsOYtr/sUmchddfy9
         cmp382UD8yc10J54AlIBwdHX+hAvTPPLeo5bXjb38cHswP1tHX3hgR82F4UQvq9r1hq5
         VxjQWiEFOuZZsmh1YQKMLL+xYLpt2qIk5po2Qv0TlWEh3vqR7KAONplB8+QEmaPdDt3u
         NZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bcvv3s1jlwFos7tbnxmBqdUoy0tu/VtVTQxA5iaPcwE=;
        b=Fs3cJTTC7/8ManOOUezlGW4TIDspZfbV5ivQIcYD6U1dGeJWY+s+4FARxbNTM299Ar
         vFDfSpXp+YTpelCqmLj118DFiPlFvpWSJiop7VTjzrMmC2Hr4FglpH0Mg3C9lUwcH0gZ
         ITwNWZMDYcZwhwS0ApOMae4U+Y/TEy+IHyali8WMedZtmDp332H48YbHGDRPbc3wf3GS
         yjrJkzC7i1Hf+Xe1LOUfhZJ+qFY2PQ3hs6Yz/2u3d1Pl5LfH2WQ8GfdFpopEciJ+A+rV
         rW9d5JSyTA704VzYnf/1EYiCJ4VEJm/sXh9B8DR+sLi8TjsiG3QHmEMZtr61URakCIsX
         t/zA==
X-Gm-Message-State: APjAAAVUxGJ2e9MqhmQiZODT2+nsE94HihrKUEXH01xceiR11S1M7K2S
        9jopdIGPqey2myXRpeu5T0/qiw==
X-Google-Smtp-Source: APXvYqyxM7U/jHIJI99B9C1EdcCTCFFBM786IAXFXgnhGT2sRjVDedtvXvw5d/hkYDOQxl8zi5wjgg==
X-Received: by 2002:a17:902:208:: with SMTP id 8mr8245745plc.53.1575968267123;
        Tue, 10 Dec 2019 00:57:47 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id d22sm2419859pfn.164.2019.12.10.00.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 00:57:46 -0800 (PST)
Date:   Tue, 10 Dec 2019 14:27:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Message-ID: <20191210085744.ocdcpubkmac6mk3i@vireshk-i7>
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0hmaCPNX3O=Yvwh6zt13F9-sFApZn1Rnqx=_xzPde34Pw@mail.gmail.com>
 <DB3PR0402MB3916781D19ECB96C530B410DF55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <40413247.HltoIgKm8r@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40413247.HltoIgKm8r@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-12-19, 09:50, Rafael J. Wysocki wrote:
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -599,11 +599,13 @@ static inline bool cpufreq_this_cpu_can_
>  {
>  	/*
>  	 * Allow remote callbacks if:
> -	 * - dvfs_possible_from_any_cpu flag is set
>  	 * - the local and remote CPUs share cpufreq policy
> +	 * - dvfs_possible_from_any_cpu flag is set and the CPU running the
> +	 *   code is not going offline.
>  	 */
> -	return policy->dvfs_possible_from_any_cpu ||
> -		cpumask_test_cpu(smp_processor_id(), policy->cpus);
> +	return cpumask_test_cpu(smp_processor_id(), policy->cpus) ||
> +		(policy->dvfs_possible_from_any_cpu &&
> +		 !cpumask_test_cpu(smp_processor_id(), policy->related_cpus));

This isn't enough as you are assuming that only a CPU from policy->related_cpus
can do remote processing. On a ARM platform (like Qcom's Krait, octa-core), all
8 CPUs have separate policies as they don't share clock lines. Though they can
still do remote processing for each other as the clk registers are common.

Also policy->related_cpus can anyway update frequency for the policy even if
dvfs_possible_from_any_cpu is set to false.

-- 
viresh
