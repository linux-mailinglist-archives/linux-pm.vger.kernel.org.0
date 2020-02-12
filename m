Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6115AB68
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 15:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBLOyt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 09:54:49 -0500
Received: from foss.arm.com ([217.140.110.172]:33824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgBLOyt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 09:54:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8540B328;
        Wed, 12 Feb 2020 06:54:48 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63BE63F68F;
        Wed, 12 Feb 2020 06:54:46 -0800 (PST)
Subject: Re: [PATCH v3 1/7] arm64: add support for the AMU extension v1
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, sudeep.holla@arm.com, lukasz.luba@arm.com,
        rjw@rjwysocki.net
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-2-ionela.voinescu@arm.com>
 <93472f17-6465-641d-ea82-3230b5697ffd@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <b2b640ac-0cc3-b09e-1f6c-f01234295b3b@arm.com>
Date:   Wed, 12 Feb 2020 14:54:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <93472f17-6465-641d-ea82-3230b5697ffd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/02/2020 11:30, Suzuki Kuruppassery Poulose wrote:
>> +static bool has_amu(const struct arm64_cpu_capabilities *cap,
>> +               int __unused)
>> +{
>> +    /*
>> +     * The AMU extension is a non-conflicting feature: the kernel can
>> +     * safely run a mix of CPUs with and without support for the
>> +     * activity monitors extension. Therefore, if not disabled through
>> +     * the kernel command line early parameter, enable the capability
>> +     * to allow any late CPU to use the feature.
>> +     *
>> +     * With this feature enabled, the cpu_enable function will be called
>> +     * for all CPUs that match the criteria, including secondary and
>> +     * hotplugged, marking this feature as present on that respective CPU.
>> +     * The enable function will also print a detection message.
>> +     */
>> +
>> +    if (!disable_amu && !zalloc_cpumask_var(&amu_cpus, GFP_KERNEL)) {
> 
> This looks problematic. Don't we end up in allocating the memory during
> "each CPU" check and thus leaking memory ? Do we really need to allocate
> this dynamically ?
> 

For the static vs dynamic thing, I think it's not *too* important here since
we don't risk pwning the stack because of the cpumask. That said, if we are
somewhat pedantic about memory usage, the static allocation is done
against NR_CPUS whereas the dynamic one is done against nr_cpu_ids.
Pretty inconsequential for a single cpumask, but I guess it all adds up
eventually...
