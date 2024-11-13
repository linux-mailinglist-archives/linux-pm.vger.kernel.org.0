Return-Path: <linux-pm+bounces-17477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824019C6E6F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 12:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0ED1F256F8
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2BF20650B;
	Wed, 13 Nov 2024 11:53:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C225B206067;
	Wed, 13 Nov 2024 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498822; cv=none; b=jhw/JzEvQApIkZKRz8rLj0GAi0A9f2Lwdb2WWCu0hfUWBAWwk8cptHzC84dx0YgQN2zoW9Ajjssb00qI5Xf+9xv6z0+HbHh9RgoINq1iMios+IFrMQSSu0tKbXHP1wBKs3HdRDX5pwrWHBV/bXJvTff5+jDlypeO/jWbpz+6zRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498822; c=relaxed/simple;
	bh=TaiTcrbdgFMDzzeszL/ot5ZPKDLmC7Snh1VpNpuzkrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlDYIJHU8GJ+uouuGJbJWojUC7Zkr2Im9Xdb17SC03tjdVhvWiAGXfQXy2u2esCbVUdJX8eKIU5noALyz02S8LOJQuhCEdv6MY28BW66W/xwOFx4L+TahLXWyxOHod0D9YYZH54XjjBoh+WqeuUqFgPMmcciNl0GZs1Nx7F2Xlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 626801655;
	Wed, 13 Nov 2024 03:54:02 -0800 (PST)
Received: from [10.34.129.21] (unknown [10.34.129.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 960273F66E;
	Wed, 13 Nov 2024 03:53:29 -0800 (PST)
Message-ID: <872c894d-1caa-4752-bb6a-08c29f1fb3ad@arm.com>
Date: Wed, 13 Nov 2024 12:53:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/cpufreq: Ensure sd is rebuilt for EAS check
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
References: <35e572d9-1152-406a-9e34-2525f7548af9@arm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <35e572d9-1152-406a-9e34-2525f7548af9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I could reproduce the issue on an ACPI/CPPC based platform.

It seems the reason it doesn't work is that for CPPC,
CPUFREQ_HAVE_GOVERNOR_PER_POLICY is not set. So
   kernel/sched/cpufreq_schedutil.c::global_tunables
is set and we don't bail out in sugov_init().

On a system with CPUFREQ_HAVE_GOVERNOR_PER_POLICY set,
the issue is not triggered. sugov_eas_rebuild_sd() is always called.

The patch effectively solved the issue for me.

Regards,
Pierre

On 11/9/24 01:24, Christian Loehle wrote:
> Ensure sugov_eas_rebuild_sd() is always called when sugov_init()
> succeeds. The out goto initialized sugov without forcing the rebuild.
> 
> Previously the missing call to sugov_eas_rebuild_sd() could lead to EAS
> not being enabled on boot when it should have been, because it requires
> all policies to be controlled by schedutil while they might not have
> been initialized yet.
> 
> Fixes: e7a1b32e43b1 ("cpufreq: Rebuild sched-domains when removing cpufreq driver")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   kernel/sched/cpufreq_schedutil.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index c6ba15388ea7..28c77904ea74 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -783,9 +783,8 @@ static int sugov_init(struct cpufreq_policy *policy)
>   	if (ret)
>   		goto fail;
>   
> -	sugov_eas_rebuild_sd();
> -
>   out:
> +	sugov_eas_rebuild_sd();
>   	mutex_unlock(&global_tunables_lock);
>   	return 0;
>   

