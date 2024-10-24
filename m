Return-Path: <linux-pm+bounces-16349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370A89AE055
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 11:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C051C224C4
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829441B6D0A;
	Thu, 24 Oct 2024 09:14:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7391B392C;
	Thu, 24 Oct 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761250; cv=none; b=Ose8A47k/bIBeFZhhPQutJRV+Cq86tmPiJYStql8Vd0IShHYGNyO3tm/c9iv7cELQ5MN4IHc8SzsYHRX46PzGavpFrDUm/bn8vy5044MLuTlCNPdSJpiubTWXVsNHocssdi+lI9zKIrC7Xr+zST6IZkgJ5Qki2TKSg56Fl9hsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761250; c=relaxed/simple;
	bh=0dzYr9wKqIl96gl44VDYmj5L/BbxzZNy8P6cHkaNWrc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XYqClVHouA9Ps4XcOgdJK1srRR37dYCqZWNdsUzLQ2Ekf2xYewW//oFYknX1nxPyAOvSsOynzxPrhi4VzBBGzK0mKcMywwLHZXysoZLEsrEBv7P/QkDmjQlQtaoLHywem+EoYiZISZZ8NTVod+mlbpx53r68AvWPCkX1pmzNAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34278339;
	Thu, 24 Oct 2024 02:14:36 -0700 (PDT)
Received: from [192.168.3.172] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EB0C3F73B;
	Thu, 24 Oct 2024 02:14:03 -0700 (PDT)
Message-ID: <b60bd51b-14e9-4b5c-adfe-bf546691a94d@arm.com>
Date: Thu, 24 Oct 2024 10:13:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] cpufreq/schedutil: Only bind threads if needed
From: Christian Loehle <christian.loehle@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Qais Yousef
 <qyousef@layalina.io>, Vincent Guittot <vincent.guittot@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>
 <CAJZ5v0jpdZBX5tJgdiOvEZbdRJ0kXxT6+uX=s++NG=dNrCMntQ@mail.gmail.com>
 <e09f3682-ee0c-4abc-b387-5358bbdf6e79@arm.com>
Content-Language: en-US
In-Reply-To: <e09f3682-ee0c-4abc-b387-5358bbdf6e79@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/7/24 11:42, Christian Loehle wrote:
> On 10/1/24 19:31, Rafael J. Wysocki wrote:
>> On Fri, Sep 27, 2024 at 10:59 AM Christian Loehle
>> <christian.loehle@arm.com> wrote:
>>>
>>> Remove the unconditional binding of sugov kthreads to the affected CPUs
>>> if the cpufreq driver indicates that updates can happen from any CPU.
>>> This allows userspace to set affinities to either save power (waking up
>>> bigger CPUs on HMP can be expensive) or increasing performance (by
>>> letting the utilized CPUs run without preemption of the sugov kthread).
>>>
>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>
>> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
>>
>> and I'm assuming that this will go in via tip.
> 
> Peter, is that fine with you?
> 
> @Juri: I didn't add your (somewhat implied?) ACK on v2, so I'd be happy to
> get it on the dl_task_check_affinity() part.
> 

Peter,
gentle ping on this.
Thank you.

Regards,
Christian


