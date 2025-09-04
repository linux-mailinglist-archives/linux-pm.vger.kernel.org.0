Return-Path: <linux-pm+bounces-33878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53CBB4455A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 20:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33975A43BBC
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB353093DE;
	Thu,  4 Sep 2025 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="VhHomcl9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53D2F8BE6
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010474; cv=none; b=iwncQfiIDixVzHTHGmFbDqEuNL4D4auG7oQjZ8H7QY1jySc3n5nlQi8bHWELcDB8yTqNZXtpCAWF5vPxOqW9v5ZKcPDTBI+WIdwOJfkdnleKBF3do1PQjwhJg+5h77v01cgs8G4qSFhDfioN4SQhCeGgMcdOcQi+8XlTFY3FcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010474; c=relaxed/simple;
	bh=x9EZ/kV0i/zHJDqGm3CQ4ZDC/UWJVf/mcnmIunFj6Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0SSPiKN7+VorNSdVc/ZXrzNih/QE74sVymCUToKE2Jxclx19GoLHogqOP0mnF3L2h7CGXpSidDltkl9+/CNHLwNLn05WREW4k4c/z2CPQsymfO8PDJlTgpnP6RXUMHsM30INbgiuA4SKcuUnJ7GqVDBnzP6JRQ22ujTCgccjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=VhHomcl9; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.8.212] (kenny-tx.gotdns.com [162.196.229.233])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cHnym23d9zSnV;
	Thu,  4 Sep 2025 14:27:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1757010464; bh=x9EZ/kV0i/zHJDqGm3CQ4ZDC/UWJVf/mcnmIunFj6Kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VhHomcl9AciyMEfmUeuo4RPZGi18yMfKN1zIw9rRBMINLGhmJmj5kCsr1BbyHs1F8
	 FsUpTRWVwLQQI/Wod2WiG4H9EXRKqho1lYfYN56UZWxeT59JWhZNg4rbCRCMygiZZ5
	 iepIr90MNOEVS1Nt0miJ/jxuqMacAyPGtZuyZugo=
Message-ID: <0233464f-af55-4e98-b925-cc83506058fc@panix.com>
Date: Thu, 4 Sep 2025 11:27:42 -0700
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
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, lukasz.luba@arm.com,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Me <kenny@panix.com>
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com>
 <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
 <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com>
 <03d67820-1e21-4361-b539-10b3ad346155@panix.com>
 <fbf349ec-f200-4eff-9a5b-6674a1eef52a@arm.com>
 <d9e8f92f-08d1-4006-accd-7a2b65b0bc6c@panix.com>
 <CAJZ5v0jmMbWjFZUZe56ZYzjsHYE1=fSb+5MWNLMN_K4ZCJPu+Q@mail.gmail.com>
 <e08a1424-6873-4c61-b97b-94c4e9a9077c@panix.com>
 <CAJZ5v0iw0SZAZd9HvwZdT=kqPq0AUJp_8LjWA6byOX3K4BVjrg@mail.gmail.com>
 <CAJZ5v0j8PGqHYN-XR=pkBCyvhN9kwUDupeU6MJTJoCbiJv8F7Q@mail.gmail.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <CAJZ5v0j8PGqHYN-XR=pkBCyvhN9kwUDupeU6MJTJoCbiJv8F7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


I'll test this today and get back to you.

-K

On 9/4/25 10:40, Rafael J. Wysocki wrote:
> On Wed, Sep 3, 2025 at 8:53 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, Sep 3, 2025 at 8:43 PM Kenneth Crudup <kenny@panix.com> wrote:
>>>
>>>
>>> Is there a way to distinguish between "offline cores" and
>>> "'non-'existent" cores?
>>>
>>> This way we could just skip the ones that "aren't" there, right?
>>
>> I'm not quite sure about the underlying use case TBH.
>>
>> The em_check_capacity_update() call may not be necessary on x86 at
>> all, but I need to double check.
> 
> So AFAICS, this can be addressed by something like the attached patch
> (the majority of changes in it is just moving kerneldoc comments
> around and function renaming).
> 
> Since intel_pstate handles capacity updates itself, it can do without
> em_check_capacity_update().

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


