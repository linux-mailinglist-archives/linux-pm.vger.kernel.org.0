Return-Path: <linux-pm+bounces-42123-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCuuMbZDhGm/2AMAu9opvQ
	(envelope-from <linux-pm+bounces-42123-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 08:16:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22729EF5D3
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 08:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E89A23012260
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 07:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5373557ED;
	Thu,  5 Feb 2026 07:15:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26376333752;
	Thu,  5 Feb 2026 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770275727; cv=none; b=YaaAExK31sMddKsGyVzyuyKxHv9LJGqK+rNQqyE0pXgB+xQrt0rzlTq9mXWMYxahZ7J/LXvTRCB5DFTO3zN20rTyfgS/9ddiua8XGWq2mHGW1aKxUDYT8/u/waV/YXbv/tKOyJSCkPot4ZNPFDLQUc88XrULb/+b6RkS7W02OHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770275727; c=relaxed/simple;
	bh=QY29ciufELzeFfuZMGuEPNUze18iJI/TvdOQEqqW+Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmeoqMg9IRNW5m+6tsIyTg0D3ghZaC/f14dATsH3HFquwoa66gRvKJXEuW7ZNEje3qUzJX6Vt+Cw9WFrwktoQoPkdd4mSxQHAG7KNv30jlAK/GtGSL7CMFdxPktLcMRI0hLFYTfVvp3j7thZw1ctg5IXTehnMZbqAGx+jHEA8Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BD78339;
	Wed,  4 Feb 2026 23:15:19 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7B8A3F778;
	Wed,  4 Feb 2026 23:15:22 -0800 (PST)
Message-ID: <29b3287e-0a08-4648-9e54-32889c99b1e3@arm.com>
Date: Thu, 5 Feb 2026 07:15:19 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
 'Harshvardhan Jha' <harshvardhan.j.jha@oracle.com>,
 'Sasha Levin' <sashal@kernel.org>,
 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
 stable@vger.kernel.org, 'Daniel Lezcano' <daniel.lezcano@linaro.org>
References: <004e01dc90b1$4b28f9e0$e17aeda0$@telus.net>
 <002601dc916e$6acbe650$4063b2f0$@telus.net>
 <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
 <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com>
 <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com>
 <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com>
 <3395ad0b-425e-40f5-844c-627cff471353@oracle.com>
 <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com>
 <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com>
 <005401dc9638$b3e2ea40$1ba8bec0$@telus.net>
 <m7pzdjfjcm2gr4gpru3rk26o2wn5iarihff6kz3o7n3slsvonx@k6jkyemuywgk>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <m7pzdjfjcm2gr4gpru3rk26o2wn5iarihff6kz3o7n3slsvonx@k6jkyemuywgk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.982];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-42123-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 22729EF5D3
X-Rspamd-Action: no action

On 2/5/26 02:37, Sergey Senozhatsky wrote:
> On (26/02/04 16:45), Doug Smythies wrote:
>>>> What is "established" and "newer" for a stable kernel is quite handwavy
>>>> IMO but even here Sergey's regression report is a clear data point...
>>>
>>> Which wasn't known at the time commit 85975daeaa4d went in.
>>>
>>>> Your report is only restoring 5.15 (and others) performance to 5.15
>>>> upstream-ish levels which is within the expectations of running a stable
>>>> kernel. No doubt it's frustrating either way!
>>>
>>> That is a consequence of the time it takes for mainline changes to
>>> propagate to distributions (Chrome OS in this particular case) at
>>> which point they get tested on a wider range of systems.  Until that
>>> happens, it is not really guaranteed that the given change will stay
>>> in.
>>>
>>> In this particular case, restoring commit 85975daeaa4d would cause the
>>> same problems on the systems adversely affected by it to become
>>> visible again and I don't think it would be fair to say "Too bad" to
>>> the users of those systems.  IMV, it cannot be restored without a way
>>> to at least limit the adverse effect on performance.
>>
>> I have been going over the old emails and the turbostat data again and again
>> and again.
>>
>> I still do not understand how to breakdown Sergey's results into its
>> component contributions. I am certain there is power limit throttling
>> during the test, but have no idea to much or how little it contributes to the
>> differing results.
>>
>> I think more work is needed to fully understand Sergey's test results from October.
>> I struggle with the dramatic test results difference of base=84.5 and revert=59.5
>> as being due to only the idle code changes.
>>
>> That is why I keep asking for a test to be done with the CPU clock frequency limited
>> such that power limit throttling can not occur. I don't know what limit to use, but suggest
>> 2.2 GHZ to start with. Capture turbostat data with the tests. And record the test results.
> 
> 
>> @Sergey: are you willing to do the test?
> 
> I can run tests, not immediately, though, but within some reasonable
> time frame.
> 
> (I'll need some help with instructions/etc.)
> 

@Doug given this is on Chromebooks base=84.5 and revert=59.5 doesn't necessarily mean
29.6% decrease in system performance in a traditional throughput sense.
The "benchmark" might me measuring dropped frames, user input latency or what have you.
Nonetheless @Sergey do feel free to expand.

