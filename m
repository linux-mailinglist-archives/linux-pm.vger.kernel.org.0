Return-Path: <linux-pm+bounces-34034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFAAB4666A
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 00:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E24E7C3C2E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341932877DB;
	Fri,  5 Sep 2025 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SyTHqxeO"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F125DB0D;
	Fri,  5 Sep 2025 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110054; cv=none; b=TEXLVWrcPCbC1LcXNhoj2hQw9qewJIRJSwsIHnaiYcNuVbA2xnN70V6Vti3zI9n+HJSY4Ma099Kgnr40mHau7qY1gBwU/WtizXPD94999qHf/RpHX6gy2In4xp6/LE36h6mVkKsEljNWQGnLbxtJkzOnDa0wS2l0egLhsgMQRKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110054; c=relaxed/simple;
	bh=qabVDCAerk3jm2UbasgcN/y7pUQHMuhEfsL/6QAlt7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHn9RcohFKukQpzsNQljMczWCYqlmcfcxX10T44g+3Y374z2vIN70UCfwVqIGZTTsNCgNWol2wYvpwmBaeGrERhxvWXiD+qzA3tcgnle7wr6LTx2CtQJm067GnGE+J+uZWo4BkyJnEttU+vgNbyafffe638uEMJHSaQ9FnEna2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SyTHqxeO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=fQd68/uOkmvzwh4WQpDH5bQFAN9vRGtlSDE2//znmz0=; b=SyTHqxeOyTERtbb8NPhFJFLxhA
	GQdA9w6SFdU/pTuMAbUjAQQ64g0zaXpCEUYlA2z5xHcxdcdpPg35MtJxt6XEFpF8SSfnbXXKj8YSm
	0bX+pI/+EYDHHLWzUOeb2LjxiLDhUoIrGZbNRsGGTDeBUfhIMOTw16b962cVGTLYtQQBTV12qKrpJ
	Z4JTKmKo3jOgyIo31HnOw9scls6pOD9dceYs15z8o0vief4Yz4351uh1wZtBxxyW9t1y5Vz+EpJdt
	RiRNFt2ZEcAPc3WMofsVOl7qRCq4R/LAMnqnGm3uvdG4oV8AdqqYz99+xRFb7t6ZmNvuosDbYVnwt
	EhOnS4/A==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uueai-00000004vCq-0Gah;
	Fri, 05 Sep 2025 22:07:32 +0000
Message-ID: <2aad4540-ccdd-4519-9bed-7d8c7ccd009d@infradead.org>
Date: Fri, 5 Sep 2025 15:07:31 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek
 <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
References: <20250904063631.2364995-1-rdunlap@infradead.org>
 <6089e22ddfdc135040cdeb69329d817846026728@intel.com>
 <20250905140104.42418fba@foz.lan>
 <34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
 <atj2koasbiuf67rzr7bbdwpu4kcgkdsqt6rhz5vwpbryfqxm7z@mfmts3tnsasf>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <atj2koasbiuf67rzr7bbdwpu4kcgkdsqt6rhz5vwpbryfqxm7z@mfmts3tnsasf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/5/25 6:38 AM, Mauro Carvalho Chehab wrote:
> On Fri, Sep 05, 2025 at 04:06:31PM +0300, Jani Nikula wrote:
>> On Fri, 05 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>>> Em Fri, 05 Sep 2025 12:02:37 +0300
>>> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
>>>
>>>> On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>> Provide some basic comments about the system_states and what they imply.
>>>>> Also convert the comments to kernel-doc format.
>>>>>
>>>>> However, kernel-doc does not support kernel-doc notation on extern
>>>>> struct/union/typedef/enum/etc. So I made this a DOC: block so that
>>>>> I can use (insert) it into a Documentation (.rst) file and have it
>>>>> look decent.  
>>>>
>>>> The simple workaround is to separate the enum type and the variable:
>>>>
>>>> /**
>>>>  * kernel-doc for the enum
>>>>  */
>>>> enum system_states {
>>>> 	...
>>>> };
>>>>
>>>> /**
>>>>  * kernel-doc for the variable
>>>>  */
>>>> extern enum system_states system_state;
>>>>
>>>> BR,
>>>> Jani.
>>>>
>>>>>
>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>>> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
>>>>> ---

[snip]
>>> If the problem is with "extern" before enum, fixing kdoc be
>>> fairly trivial.
>>
>> The non-trivial part is deciding whether you're documenting the enum
>> type or the variable. Both are equally valid options.
> 
> True.
> 
> I'd say that, if the variable is under EXPORT_SYMBOL macros, it
> should be documented.

Do you mean documented with kernel-doc? How do we do that?
I was under the impression that we don't currently have a way to
use kernel-doc for variables (definitions, only for declarations).


> The same applies to the enum: if it is used by kAPI, it should
> also be documented.
> 
> So, yeah, I suspect that on most kAPI cases, the best is to split,
> having documentation for both.
> 
>>
>> BR,
>> Jani.
>>
>>>
>>> If you see:
>>>
>>> 	def dump_function(self, ln, prototype):
>>> 	
>>>      	# Prefixes that would be removed
>>>         sub_prefixes = [
>>> 	    ...
>>> 	    (r"^extern +", "", 0),	
>>> 	    ...
>>> 	}
>>>
>>>         for search, sub, flags in sub_prefixes:
>>>             prototype = KernRe(search, flags).sub(sub, prototype)
>>>
>>>
>>> we need something similar to that at:
>>> 	def dump_enum(self, ln, proto):
>>>
>>> alternatively, we could use a simpler approach modifying adding a
>>> non-group optional match for "extern". E.g:
>>>
>>> -	r = KernRe(r'enum\s+(\w*)\s*\{(.*)\}')
>>> +       r = KernRe(r'(?:extern\s+)?enum\s+(\w*)\s*\{(.*)\}')
>>>
>>> (untested)

Yes, this might work. It might also lead to documenting more than
was intended. It seems safer just to do the enum declaration and
variable definition split light Jani suggested.


Thanks.
-- 
~Randy


