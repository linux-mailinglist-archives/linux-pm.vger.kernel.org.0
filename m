Return-Path: <linux-pm+bounces-33301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E8B3A351
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 17:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0A816F142
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF144314A8F;
	Thu, 28 Aug 2025 14:56:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FBB313E0D
	for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392997; cv=none; b=V9DiVvy0nMv4Z73Rr9nWzb9SCQhdzowPr5HG0H4dxTiVs3EYvgQe6dK91DQGZ/X+VVFJaduQSrzrqN1tHU2th0ZO9oNFIWaSKLmESVBWT9Q1iTE28arF22u1jQtqotoJruu1csdJsbbyMTQBPUzM/tASlUXCnvsb0S7bSFUJs1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392997; c=relaxed/simple;
	bh=2HC1ShPLxSnGVenaFYSK5dML3eXYU+WgEplYRk5UCc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HGOjnUBm1ECRqD1dFt3FuLsO7/iJ02UxfJL7cOeB4qJjOGbxTBoLSFMs5EsRIdrZ065tfpymPsRnzTawFQiT+ZOQNuAmxauAMF/FKhShfZlO0+oge5StAXysSEFF6PHUMtHkxAkCrdXeQfDIv3/XLS+6jtZD5ReOXPNs1EV/c1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E221688;
	Thu, 28 Aug 2025 07:56:26 -0700 (PDT)
Received: from [10.1.37.80] (e127648.arm.com [10.1.37.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7959A3F738;
	Thu, 28 Aug 2025 07:56:34 -0700 (PDT)
Message-ID: <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com>
Date: Thu, 28 Aug 2025 15:56:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I think there's an issue with e3f1164fc9e ("PM: EM: Support late
 CPUs booting and capacity adjustment") if there's "holes" in your CPU
 topology
To: Kenneth Crudup <kenny@panix.com>, lukasz.luba@arm.com,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/22/25 06:53, Kenneth Crudup wrote:
> 
> So I'm testing the "Energy Model" CPU scheduler, which means I need to set "nosmt"; this means I've got "holes" in my CPUs:
> 
> ----
> $  ls /dev/cpu | sort -n
> 0
> 2
> 4
> 6
> 8
> 10
> 12
> 13
> 14
> 15
> 16
> 17
> 18
> 19
> ----
> 
> So in .../kernel/power/energy_model.c , when this line gets to a CPU "hole", it throws an error and breaks out of the loop:
> 
> ----
>        policy = cpufreq_cpu_get(cpu);
>            if (!policy) {
>                        pr_debug("Accessing cpu%d policy failed\n", cpu);
>                        schedule_delayed_work(&em_update_work,
>                                               msecs_to_jiffies(1000));
>                        break;
>            }
> ----

Hi Kenneth,
So there's probably a problem here, but presumably your proposal breaks the late boot
(i.e. what this code was initially supposed to support).

> 
> ... but I'm thinking (and its working here for me) that a simple "continue" for those three lines handles the "CPU hole" case:
> 
> ----
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index ea7995a25780..df6cae6f8845 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -795,12 +795,9 @@ static void em_check_capacity_update(void)
>                         continue;
> 
>                 policy = cpufreq_cpu_get(cpu);
> -               if (!policy) {
> -                       pr_debug("Accessing cpu%d policy failed\n", cpu);
> -                       schedule_delayed_work(&em_update_work,
> -                                             msecs_to_jiffies(1000));
> -                       break;
> -               }
> +               if (!policy)
> +                       continue;
> +
>                 cpufreq_cpu_put(policy);
> 
>                 dev = get_cpu_device(cpu);
> ----
> 
> Thoughts?
> 
> -Kenny
> 


