Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0374315AD56
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBLQYq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 11:24:46 -0500
Received: from foss.arm.com ([217.140.110.172]:34918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgBLQYq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 11:24:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9EEF328;
        Wed, 12 Feb 2020 08:24:45 -0800 (PST)
Received: from [10.1.28.191] (e121487-lin.cambridge.arm.com [10.1.28.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCD9A3F68F;
        Wed, 12 Feb 2020 08:24:43 -0800 (PST)
Subject: Re: [PATCH v3 1/7] arm64: add support for the AMU extension v1
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     mark.rutland@arm.com, maz@kernel.org, linux-doc@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, will@kernel.org, valentin.schneider@arm.com,
        lukasz.luba@arm.com
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-2-ionela.voinescu@arm.com>
 <93472f17-6465-641d-ea82-3230b5697ffd@arm.com>
 <20200212161045.GA7475@arm.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <ade32e03-b56b-7c5d-628d-124e52279d34@arm.com>
Date:   Wed, 12 Feb 2020 16:24:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200212161045.GA7475@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2/12/20 4:10 PM, Ionela Voinescu wrote:
> Hi Suzuki,
> 
> On Wednesday 12 Feb 2020 at 11:30:44 (+0000), Suzuki Kuruppassery Poulose wrote:
>>> +static int __init set_disable_amu(char *str)
>>> +{
>>> +	int value = 0;
>>> +
>>> +	disable_amu = get_option(&str, &value) ? !!value : true;
>> minor nit: You could simply use strtobool(str) here, which accepts:
>>
>> disable_amu= [0/1/on/off/y/n]
>>
> Yes, this was intentional as I wanted "disable_amu" to be a valid option
> as well, not only "disable_amu=<option>".
> 
> If you don't mind I'd like to keep it like this. Currently the use of
> AMU is enabled by default, and the most common kernel parameter to
> disable it would be "disable_amu". Allowing "disable_amu=0" is just in
> case we change the default in the kernel to not support AMU and we'd
> like platforms to be able to enable it. 
> 

Sorry for jumping into thread, but can we avoid negatives into naming which
accept values? If is always tricky to get expected effect when both are combined.

If value doesn't really mater than can it be just "noamu"?

If value does matter can it be (per Suzuki) amu=[0/1/on/off/y/n]?

Or can you postpone introduction of "just in case" option till that case happens?

Cheers
Vladimir
