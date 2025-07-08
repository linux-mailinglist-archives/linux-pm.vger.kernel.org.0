Return-Path: <linux-pm+bounces-30388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DF8AFD120
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 18:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E27F1C21AE2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3DD1BEF7E;
	Tue,  8 Jul 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lzA7tdJk"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B093B2E3701;
	Tue,  8 Jul 2025 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992285; cv=none; b=rRUpF3cntcMdhYfT0C1akFP3N6Bc1+itOF7kNzMEebgPHfjQXzEribTSdPb0eAJAO82aVDCTK5Z+1YIBn50Qi1fRUOvNoxq7Ec0ijDMMVREFfkFMQhS2Q3hkyj9ufS5ljYazgDhSEDEUvEkWWpBh8QzTS8QMvhmIm4iHmzhQDSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992285; c=relaxed/simple;
	bh=qpwh2epvYMa/vP9RS2AG1z0uRbcPXLoNOGq6aDBDMbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VT3rIuKlsPRXrAlXNn3GvjcD8tfw1GhgNRMte2ARCmmfEbIyyN37FPiTqYEshv9++OO+dy+mlKiBaYAZcx0VWaOfbZ1h4p1HgUqDshMW6b3iyNy7Ap1VMYVzaFtsqYAhO2JLAunkDa+KfJndwH25NJlv05NYRnFKpZucwsxAJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lzA7tdJk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=kOk7XbwChRWqxUdyqJOIG4vdU1iZr66s7LOpGxHw2Z8=; b=lzA7tdJkNNQY45J8AEw2iCoXM7
	o8ijnMS3Rec59Ajg9zr/ZZ3/TECxlEHWzrZTBu9eWZQuQq3NKw7om8WUI8WPrddcoi1vOWOn2Cs/o
	sboxJPwdulBED+GrbJnknPmlswZHjFYK4DD2rF1/o/aERs9ZjIanK70E2gP5BH0AAKwLAfhs4AenD
	yZPs53AZaSjS8JQj+YKzcu6QelROmSx5DkS41BVJBhcy4UmV/FBfIaA7GXfI09/nKoVrWRZGwyXaC
	frOBszBN4cBdc2Famdt0hr92XPFwU3EDdoU/+Q8KDsO+Z342L/k8qNXjN9QV5xIMHk+M45m4fImkI
	r4jAyeLw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZBDy-00000000MKz-3qil;
	Tue, 08 Jul 2025 16:31:19 +0000
Message-ID: <d3d1e2be-6b9b-40d4-bd9a-49ff38c451f0@infradead.org>
Date: Tue, 8 Jul 2025 09:31:14 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: add kernel parameter to disable asynchronous
 suspend/resume
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Jonathan Corbet
 <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com
References: <20250708-pm-async-off-v2-1-7fada54f01c0@linaro.org>
 <18c12f92-2194-4244-8793-5d916edfd4e8@infradead.org>
 <cabab318-95a4-4e81-a931-458ee6023f3a@linaro.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cabab318-95a4-4e81-a931-458ee6023f3a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/25 8:58 AM, Tudor Ambarus wrote:
> 
> 
> On 7/8/25 4:36 PM, Randy Dunlap wrote:
>> Hi,
>>
> 
> Hi, Randy!
> 
>> On 7/8/25 8:16 AM, Tudor Ambarus wrote:
>>
>>> ---
>>>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
>>>  kernel/power/main.c                             |  9 +++++++++
>>>  2 files changed, 20 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index f1f2c0874da9ddfc95058c464fdf5dabaf0de713..33ca6b881b1d77bdeea765b19291a90b2a82e8a3 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -5000,6 +5000,17 @@
>>>  			that number, otherwise (e.g., 'pmu_override=on'), MMCR1
>>>  			remains 0.
>>>  
>>
>> This should be more like:
>>
>>
>> 	pm_async=off	[PM]
>>
>> or
>>
>>> +	pm_async	[PM]
>>
>> 	pm_async=	[PM]
>> 			Format: off
> 
> Indeed. I see this second description, "kernel_param=", largely used in
> the existing kernel parameters, so maybe that's what I shall follow.
> However, I don't really know which format to choose, I see:
> 
> Format: <string>
> Format: { off }
> Format: {off}
> Format: { "off" }
> Format: {"off"}
> Format: off
> 
> Any idea if there's an already agreed string format?

Hi,
AFAIK there isn't one. Just choose one. :)

I would go with the first choice that I listed
but it's up to you.

-- 
~Randy


