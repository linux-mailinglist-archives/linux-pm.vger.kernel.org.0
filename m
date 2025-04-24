Return-Path: <linux-pm+bounces-26122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74106A9AEB5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 15:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8081744F8
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980022B59C;
	Thu, 24 Apr 2025 13:15:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3B27C14A;
	Thu, 24 Apr 2025 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500524; cv=none; b=smGU6lWMjjMd5Q5ygGELCdz5ocKrikgUWtZj2Ygnci7a9pia5Ym9qhaBco+2x0a0ZrY9S5gTNQ7/dTSro978wQaqnG6n4rF3x8g9+MDtLqYSePpTATQN+EO4cI+Y/mfz36eqyFnmPFugjTqn2pkgSSE/JBi+UL6M47T/mfG94Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500524; c=relaxed/simple;
	bh=MNVkVSCEZTSB+cgGONYkHkO3xBVyotsiAWdk0ztyIq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KjembB90BrgzIJ65P/nqoRhMwI9M5Kovq1fFbrD+SJhr+zgkRAR2lrr+I2/7kF+zXw1zQOFIyGZqrHjzunneRb+PFVHVBlRI/0RgC9z9pjW3bwlLyp+P3BDG6HPNPEj52FMU5ZJhW9uP347F9oQGOqVa79swAmR/L8EqoO+mL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZjxDq03xJzvWrP;
	Thu, 24 Apr 2025 21:11:07 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id A71DA140154;
	Thu, 24 Apr 2025 21:15:16 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Apr
 2025 21:15:16 +0800
Message-ID: <435855f8-7c92-4fc3-be07-8856772e729f@huawei.com>
Date: Thu, 24 Apr 2025 21:15:15 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] cpufreq: acpi: Don't enable boost on policy exit
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Nicholas Chin <nic.c3.14@gmail.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>
References: <cover.1745315548.git.viresh.kumar@linaro.org>
 <7ce4ffb166beef83cf1bd703a41bf91622011585.1745315548.git.viresh.kumar@linaro.org>
 <CAJZ5v0iCrQeKs=4S-x83Fgf-W4u=2JYLA5VmgKPaLCvYAkNpig@mail.gmail.com>
 <20250424071503.2uhc4k3jxy7x5mo2@vireshk-i7>
 <CAJZ5v0hLBE0vLvpw6k8E7KxiUGqXbH7wEZwFhEziJNYqfxJbyA@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0hLBE0vLvpw6k8E7KxiUGqXbH7wEZwFhEziJNYqfxJbyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/24 19:26, Rafael J. Wysocki wrote:

> On Thu, Apr 24, 2025 at 9:15 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 23-04-25, 16:14, Rafael J. Wysocki wrote:
>>> Even after commit 2b16c631832d, the code removed by this patch does a
>>> useful thing.  Namely, it clears the boost-disable bit in the MSR so
>>> that the offline CPU doesn't prevent online CPUs from getting the
>>> boost (in case the boost settings change after it has been taken
>>> offline).
>>
>> I didn't understand this part earlier (and even now). How does a CPU
>> with boost-disabled, prevents others from boosting ? I have tried
>> looking at git logs, and still don't understand it :(
> 
> At the HW level, this is certainly possible.
> 
> Say two (or more) cores are driven by the same VR.  Boost typically
> (always?) requires a separate OPP with a higher voltage and this
> applies to all cores sharing the VR, so if one of them says it doesn't
> want that (which is what the bit in the boost-disable MSR effectively
> means), they all won't get it.

IIUC, this means that if one sets unboost to policy A, another core in
policy B (but sharing the same VR with core in policy A) will not be able
to achieve boost freq too. Then if policy A goes exit, the core in policy B
will get back to boost freq (without patch 1). And then core in B will be
unboosted again after core in A goes online/resume (because of patch 2).
But in the entire process, the boost flag in policy B is always enabled.

Please tell me I misunderstood because it looks really weird.😥

> 
> They arguably should belong to the same cpufreq policy, but this
> information is often missing from the ACPI tables, sometimes on
> purpose (for instance, the firmware may want to be in charge of the
> frequency coordination between the cores).
> 
>> Also, IIUC this and the boost-enabling at init() only happens for one
>> CPU in a policy, as init() and exit() are only called for the first
>> and last CPU of a policy. So if a policy has multiple CPUs, we aren't
>> touching boost states of other CPUs at init/exit.
> 
> But there may be a policy per CPU.
> 
>> And yes, this patch isn't mandatory at all for the
>>
>>> Moreover, without the $subject patch, the change made by the next one
>>> will cause the boost setting in the MSR to get back in sync with
>>> policy->boost_enabled during online AFAICS, so why exactly is the
>>> $subject patch needed?
>>
>> Right, this is merely a cleanup patch and isn't really required for
>> the next patch to make it work.
> 
> So I'd rather not make this change.
> 
> Evidently, someone made the effort to put in a comment explaining the
> purpose of the code in question, so it looks like they had a reason
> for adding it.
> 


