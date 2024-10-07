Return-Path: <linux-pm+bounces-15287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF39993270
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 18:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B16B29ED6
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C621DBB1B;
	Mon,  7 Oct 2024 15:58:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4A1DBB16
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316723; cv=none; b=KrTf9CqpuQrOE1wTTegz3N+4pbs1yoWRfrqiUHbcOUGLU4zz3/RyUt9BFt6E2sCKJPVuobE+r9yA7+ix9+rUl5PynuFDoSRSx0Bqs6xgRbkwtoCE4+iN3m9fMqltC/GOXmqia2fwLNw49pQ5XyOhwi0u8/FJdhNOhlSVPM6z0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316723; c=relaxed/simple;
	bh=WgZB8D3oD101kmIMjx4Ufx4RuEoRLMQleFHZ1UWcyEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLWHPKj3UZ0Epy5+53fudFx/KaZUhC0mCjPRcTeGXnJUsiQbrevdGjymzE1AvYVtATCkBPFPvh2pGqbvneATYlQFjxsGIMOFPEpCO8STFTP/SXAIwF2eAiVvqsCH3eAXZ+ZBu1cn7nXaoZtX5u38fAnatV8belvqnjWVyrcfB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37EE9DA7;
	Mon,  7 Oct 2024 08:59:10 -0700 (PDT)
Received: from [10.1.26.21] (unknown [10.1.26.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C6BD3F64C;
	Mon,  7 Oct 2024 08:58:38 -0700 (PDT)
Message-ID: <01c3073b-84d0-4986-b6d5-a8877ae8a046@arm.com>
Date: Mon, 7 Oct 2024 16:58:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [cpuidle] 38f83090f5: fsmark.app_overhead
 51.9% regression
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
References: <202410072214.11d18a3c-oliver.sang@intel.com>
 <CAJZ5v0iyn0==dDNtdxEQpMqGaxa4O_Qr-uRxAq8DzJ+HmtWd5A@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0iyn0==dDNtdxEQpMqGaxa4O_Qr-uRxAq8DzJ+HmtWd5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/7/24 16:18, Rafael J. Wysocki wrote:
> On Mon, Oct 7, 2024 at 4:44 PM kernel test robot <oliver.sang@intel.com> wrote:
>>
>>
>>
>> Hello,
>>
>> kernel test robot noticed a 51.9% regression of fsmark.app_overhead on:
> 
> What exactly is fsmark.app_overhead?  What does it measure?

"App overhead is time in microseconds spent in the test not doing file writing related system calls."
So the loop is:
	/*
	 * MAIN FILE WRITE LOOP:
	 * This loop measures the specific steps in creating files:
	 *      Step 1: Make up a file name
	 *      Step 2: Creat(file_name);
	 *      Step 3: write file data
	 *      Step 4: fsync() file data (optional)
	 *      Step 5: close() file descriptor
	 */

And it gets the timestamps before and after each syscall.
It then subtracts all those times (spent in syscalls) from the total time.
I'll go take a look tomorrow, what's interesting is that the exit-latency
(which is the thing supposed to cause regressions here) should be time
spent blocking on syscalls.
If that is all correct that's the part that shouldn't regress on cpuidle.



