Return-Path: <linux-pm+bounces-616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E1800CC7
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 15:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87D81C20863
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F6B3C475;
	Fri,  1 Dec 2023 14:01:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D808994;
	Fri,  1 Dec 2023 06:01:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1634B1007;
	Fri,  1 Dec 2023 06:02:27 -0800 (PST)
Received: from [10.57.4.62] (unknown [10.57.4.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91D5F3F73F;
	Fri,  1 Dec 2023 06:01:39 -0800 (PST)
Message-ID: <f6d9b092-20e8-436e-9307-2c24cb0ba3a5@arm.com>
Date: Fri, 1 Dec 2023 14:02:38 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powercap: DTPM: Fix the missing cpufreq_cpu_put() calls
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 daniel.lezcano@linaro.org, rafael@kernel.org, stable@vger.kernel.org
References: <20231201123205.1996790-1-lukasz.luba@arm.com>
 <2023120139-staging-sprang-7e77@gregkh>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2023120139-staging-sprang-7e77@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

On 12/1/23 12:44, Greg KH wrote:
> On Fri, Dec 01, 2023 at 12:32:05PM +0000, Lukasz Luba wrote:
>> The policy returned by cpufreq_cpu_get() has to be released with
>> the help of cpufreq_cpu_put() to balance its kobject reference counter
>> properly.
>>
>> Add the missing calls to cpufreq_cpu_put() in the code.
>>
>> Fixes: 0aea2e4ec2a2 ("powercap/dtpm_cpu: Reset per_cpu variable in the release function")
>> Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
>> Cc: <stable@vger.kernel.org> # v5.10+
> 
> But the Fixes: tags are for commits that are only in 5.12 and newer, how
> can this be relevant for 5.10?

My apologies, you're right. Somehow I checked that this dtpm_cpu.c
was introduced in v5.10. It was in v5.12 indeed. I messed that up.

Also, the code in that v5.12 had different implementation and there was
a function cpuhp_dtpm_cpu_offline() which had the cpufreq_cpu_get().

I can craft for that v5.12 special extra patch fix addressing it and
send directly to stable list. Would that make sense?

So this patch would only be applicable for v5.16+ AFAICS.

Regards,
Lukasz

