Return-Path: <linux-pm+bounces-36082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D26DBDA496
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD58C5026AC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32722FFDD7;
	Tue, 14 Oct 2025 15:11:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C062F5A37;
	Tue, 14 Oct 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454685; cv=none; b=A2mhq47XVWptJkx8bChfxeGrdgxvPHfYQiXfbQ6L3LSVpu9Qr2m4WYeptmHRRLldwSjnFa4kW8eeZBvWN6WdIlSlUn97jFUl7MAJSfrhnLKz0u3catIHsw2LQFV/kKEY3BBRAAfk0KZ3/UvnMhaAoRktK8CI16U17vBNYXA6A+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454685; c=relaxed/simple;
	bh=LA5bgj0TT25oB118SpFwNDavFaQw24CzooeImBzh+LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKspDhWYEbRr3UKSQjN+oL8cZHFQSBaQqH/cAuhC8JRDgO/lBq2wgNCf7A/aAgD8DxPMiRhZ78lZ5ARXEID+z/XjIX08SvwzKvZ68lVk8ZmnlHcc1QTIIxZZTW8ZCRTlb1wmSvQY54jvYpRc44tLZjPZxPyx8YAZDOJit1pghf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 644D21A9A;
	Tue, 14 Oct 2025 08:11:13 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90A3D3F66E;
	Tue, 14 Oct 2025 08:11:19 -0700 (PDT)
Message-ID: <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
Date: Tue, 14 Oct 2025 16:11:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 12:55, Sergey Senozhatsky wrote:
> On (25/10/14 11:25), Christian Loehle wrote:
>> On 10/14/25 11:23, Sergey Senozhatsky wrote:
>>> On (25/10/14 10:50), Christian Loehle wrote:
>>>>> Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
>>>>> invalid recent intervals data") doesn't address the problems we are
>>>>> observing.  Revert seems to be bringing performance metrics back to
>>>>> pre-regression levels.
>>>>
>>>> Any details would be much appreciated.
>>>> How do the idle state usages differ with and without
>>>> "cpuidle: menu: Avoid discarding useful information"?
>>>> What do the idle states look like in your platform?
>>>
>>> Sure, I can run tests.  How do I get the numbers/stats
>>> that you are asking for?
>>
>> Ideally just dump
>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
>> before and after the test.
> 
> OK, got some data for you.  The terminology being used here is as follows:
> 
> - 6.1-base
>   is 6.1 stable with a9edb700846 "cpuidle: menu: Avoid discarding useful information"
> 
> - 6.1-base-fixup
>   is 6.1 stable with a9edb700846 and fa3fa55de0d6 "cpuidle: governors:
>   menu: Avoid using invalid recent intervals data" cherry-pick
> 
> - 6.1-revert
>   is 6.1 stable with a9edb700846 reverted (and no fixup commit, obviously)
> 
> Just to show the scale of regression, results of some of the benchmarks:
> 
>   6.1-base:		84.5
>   6.1-base-fixup:	76.5
>   6.1-revert:		59.5
> 
>   (lower is better, 6.1-revert has the same results as previous stable
>   kernels).
This immediately threw me off.
The fixup was written for a specific system which had completely broken
cpuidle. It shouldn't affect any sane system significantly.
I double checked the numbers and your system looks fine, in fact none of
the tests had any rejected cpuidle occurrences. So functionally base and
base-fixup are identical for you. The cpuidle numbers are also reasonably
'in the noise', so just for the future some stats would be helpful on those
scores.

I can see a huge difference between base and revert in terms of cpuidle,
so that's enough for me to take a look, I'll do that now.
(6.1-revert has more C3_ACPI in favor of C1_ACPI.)

(Also I can't send this email without at least recommending teo instead of menu
for your platform / use-cases, if you deemed it unfit I'd love to know what
didn't work for you!)

