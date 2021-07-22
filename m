Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F2D3D1FBF
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 10:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhGVHgf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 03:36:35 -0400
Received: from foss.arm.com ([217.140.110.172]:47004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhGVHgf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Jul 2021 03:36:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F845D6E;
        Thu, 22 Jul 2021 01:17:10 -0700 (PDT)
Received: from [10.57.9.248] (unknown [10.57.9.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 576813F694;
        Thu, 22 Jul 2021 01:17:08 -0700 (PDT)
Subject: Re: [PATCH v4 6/9] cpufreq: Add a new freq-table relation
 CPUFREQ_RELATION_E
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com, mka@chromium.org
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <1625738946-295849-7-git-send-email-vincent.donnefort@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <fc67df08-e128-d395-4c73-53bdaeb21f5a@arm.com>
Date:   Thu, 22 Jul 2021 09:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1625738946-295849-7-git-send-email-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/8/21 11:09 AM, Vincent Donnefort wrote:

[snip]

>   static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>   						 unsigned int target_freq,
>   						 unsigned int relation)
>   {
> +	unsigned int idx;
> +
>   	if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
>   		return cpufreq_table_index_unsorted(policy, target_freq,
>   						    relation);
>   
> +	relation = cpufreq_frequency_relation_efficient(policy, relation);
> +
>   	switch (relation) {
>   	case CPUFREQ_RELATION_L:
> -		return cpufreq_table_find_index_l(policy, target_freq);

Isn't a place where the 'fallthrough;' is needed? Any warnings seen
maybe in other arch compiler?

> +	case CPUFREQ_RELATION_E:
> +		idx = cpufreq_table_find_index_l(policy, target_freq);
> +		return relation == CPUFREQ_RELATION_L ? idx :
> +			cpufreq_frequency_find_efficient(policy, idx);
>   	case CPUFREQ_RELATION_H:
>   		return cpufreq_table_find_index_h(policy, target_freq);
>   	case CPUFREQ_RELATION_C:
> 
