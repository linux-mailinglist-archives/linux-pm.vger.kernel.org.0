Return-Path: <linux-pm+bounces-6412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B528A545E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 16:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039A628468D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6786C7F7FD;
	Mon, 15 Apr 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="OromVV6L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C378691
	for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191617; cv=none; b=cSdsEvAU6EpUEp91DitGT568ykWy3jUIDnaeJsUD/VXPIAAVVtuqIV/tb6s/OO7/dHYnxkaxG/yp6OCP4R9C4wf58QTDFDQTp88m3gaDcWAhRgefVvFRUg9guv2Kb1BWyRgb1HDxzbgwrjChVvRWbeZTtgMQJvVUbirlqRP1SlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191617; c=relaxed/simple;
	bh=Y+WX7fgsfLLrOto/4XAB6/YwQYSsudbvtogdcqpck6Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bWK4fk74rBQNeXCgsP8kJuEcxpsb15Qv1QPkFOYETdDE3dlzYdW76yJUahRQ2RQYkAQR32oLoW4GgxfCgRlmz2mGxJ23r6Y5d5N5+V1kq9DEOGN4kUEpH+Y2opkmFc7QGyTvkwbc1xcYlTMXhlbvlcjExM8lQIW5RC5mKrWN0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=OromVV6L; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.126.122] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4VJ8mK4KJwzS6V;
	Mon, 15 Apr 2024 10:33:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1713191602; bh=Y+WX7fgsfLLrOto/4XAB6/YwQYSsudbvtogdcqpck6Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=OromVV6LsSkk1kDxJOb8sJRQczoZsZsFnUP5VOHLuhgkVHgv3lJpZqMrYWQkbSdBu
	 m3qPPZk8E9bfgTDZraufMCChjVrD5QV4towCj9jcwpwgGnzmgcLTMpoW/yIKRjXaPD
	 lUKWDXYd70Uq0d5x20aU8eST2VIHaB1HPXhNRDes=
Message-ID: <1d09887c-a655-458a-bdb6-9b3128a272fa@panix.com>
Date: Mon, 15 Apr 2024 07:33:19 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernels 6.8+ no longer resume fully after a hibernate
From: Kenneth Crudup <kenny@panix.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
 Kenneth Crudup <kenny@panix.com>
References: <b702c59f-7a5b-48f5-a726-a4840ce05c3f@panix.com>
 <CAJZ5v0j48UTHj1cFNUR=EUuW1zugYxktX_t_tJFhFG5rNExyWA@mail.gmail.com>
 <4548dee1-426f-4183-bf6f-4a62d35b9aa1@panix.com>
Content-Language: en-US
In-Reply-To: <4548dee1-426f-4183-bf6f-4a62d35b9aa1@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


OK, despite looming deadlines I feel compelled to try stuff :)

So, I added a write to /etc/tmpfiles.d to turn off pm_async, then when 
looking at the other sysfs' in /sys/power I turned on "pm_trace" and 
"pm_debug_messages" and turned on "pm_async" again hoping I could maybe 
get more information on a failed resume to send to the list.

But get this- if I have trace and debug_messages turned on, then I can 
successfully resume with pm_async on. Didn't see anything interesting 
looking in the dmesg output on a successful resume, though.

I did see that the "btusb" module was causing the hibernate to throw an 
EBUSY, so I unload/reload that on hibernate/resume, but it doesn't fix 
the pm_async=1 case (when there's no debug/trace set, that is), so 
there's yet some other device that's not resuming properly.

-K

On 4/15/24 06:28, Kenneth Crudup wrote:
> 
> 
> On 4/15/24 06:05, Rafael J. Wysocki wrote:
> 
>> Can you please try
>>
>> # echo 0 > /sys/power/pm_async
>>
>> and hibernate after that?
>>
>> If it resumes correctly (and reproducibly), at least one device is
>> resumed too early in the async case.
> 
> That worked. Nice, I can use that for a short-term fix.
> 
> Later this week I can help figure out which device(s) are the culprit; 
> what method should I use to do that?
> 
> (I need hibernation as my laptop is one of those plagued with s2idle, 
> which drains at ~1%/hr so I have it hibernate after 4 hrs of sleep)
> 
> -K
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

