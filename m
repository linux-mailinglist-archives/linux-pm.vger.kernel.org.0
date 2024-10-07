Return-Path: <linux-pm+bounces-15259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A273992967
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 12:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36FE1F241A9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225211C0DED;
	Mon,  7 Oct 2024 10:42:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC5B14AD17;
	Mon,  7 Oct 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297765; cv=none; b=qKX7z77Riog+sr762yRyKrpx/8e1+C2eCfyho4Tn47iPqi3xoSlzoonr28d0FYg7M7n9r2oiJ2u6vL2yUaHixOKlL3NBnZ0zLL6829/oCkPrDgus0VSD536kqj/aaqmWexGCGcEGDvVzccR9gidgT/9QHot8xqIiDFwqN7/KKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297765; c=relaxed/simple;
	bh=JH57S4uvMEkOBCydwIZLIfePSx+J/9+QDPMg343I4Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukHmcbH4lk23RPPEhuGKyM/B3PCtTGXVkZovPx00ANfnP7aJnfp79Cpwq+Yv3Q7hXMHXNvXWgk5/8k1n6end7oD2hN9RarrY8aeWuMG0MXoWiokB5u6blJlOBYF7oh9w3xlpywRMlky8pcQgH3wlpW5Fle9DA7fiAFtpLWawc98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BF1CFEC;
	Mon,  7 Oct 2024 03:43:12 -0700 (PDT)
Received: from [10.1.26.21] (unknown [10.1.26.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E0623F64C;
	Mon,  7 Oct 2024 03:42:40 -0700 (PDT)
Message-ID: <e09f3682-ee0c-4abc-b387-5358bbdf6e79@arm.com>
Date: Mon, 7 Oct 2024 11:42:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] cpufreq/schedutil: Only bind threads if needed
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Qais Yousef
 <qyousef@layalina.io>, Vincent Guittot <vincent.guittot@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>
 <CAJZ5v0jpdZBX5tJgdiOvEZbdRJ0kXxT6+uX=s++NG=dNrCMntQ@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0jpdZBX5tJgdiOvEZbdRJ0kXxT6+uX=s++NG=dNrCMntQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/1/24 19:31, Rafael J. Wysocki wrote:
> On Fri, Sep 27, 2024 at 10:59 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> Remove the unconditional binding of sugov kthreads to the affected CPUs
>> if the cpufreq driver indicates that updates can happen from any CPU.
>> This allows userspace to set affinities to either save power (waking up
>> bigger CPUs on HMP can be expensive) or increasing performance (by
>> letting the utilized CPUs run without preemption of the sugov kthread).
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> and I'm assuming that this will go in via tip.

Peter, is that fine with you?

@Juri: I didn't add your (somewhat implied?) ACK on v2, so I'd be happy to
get it on the dl_task_check_affinity() part.


Regards,
Christian




