Return-Path: <linux-pm+bounces-34069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123CFB47565
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C937C6AB6
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E54F2571AD;
	Sat,  6 Sep 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z2cA/dn9"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A89A2571B9;
	Sat,  6 Sep 2025 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757178809; cv=none; b=pP0zVkYzO4Q2nVu0Vz9sEtibb11K9k+hg4zCcxxfXNu920zDowM2RqQYYlaEBIc8958CTASgP227EW0jjBd80/P4WhpRhPlSu+cadPO5ik85MidyXIhZq9bO8v2aZNPg3oSBJ2rAk7H2lCjx/BFLc88bfR53/3K1You08i+fxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757178809; c=relaxed/simple;
	bh=jQk2+Ao1/8bkGI5Gh91oA7s6rgJE5/ZoIUtpvCEnlU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAI1cbgbZPVnFNAiK8av3Nh1W6KTUbNyhyF7Od0nfwXb29H57IfVJrbd4TeO+yew9o4WGfvEZEelQlcFzgQrB0350ryQ+b+WQfnVpwZXwIoK/UpQlCBz80KL/S2Ac3jaiH0YnUitmCKhUngtVMXClQEsLgcKDdTx9Oo8xuqZx9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z2cA/dn9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PiCYhf0GA5hlOqjF2YlJlELelLhPn3kZ/kkMz3bcAI4=; b=Z2cA/dn9Kj1xQuxkF1OAjSTIRl
	C8FRhPM/pfWVO6/jzkL46HcsrL1O5mEOW327RY3HHtzpfBpDgWo0xbZoo7UdqKrgvagdsQC5Sk77B
	pyiy56xyD4AlSxEVNPZegB1r3AWmeZahSwouay4NmDY+xQagbHkAxtlDMu7dLdD2TMfdo9jsywxyJ
	HAX0FsGzKe9lhUSwJpJq1+R97GpalxNltcY9XkBwIqZL0d/Lbx5j1ppuyImr4pUniE3ps69IqPtCl
	Jf18TJiCt85hz9R1AJcPU/VeLHnJMwkHhidK+YAxejbLJYws8GrH/cyXPf709BIyvIO7u7TGIs70l
	WylgflEQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuwTb-00000008Asq-31FF;
	Sat, 06 Sep 2025 17:13:23 +0000
Message-ID: <d815f5c3-6e15-4758-8bf4-601d5543cab9@infradead.org>
Date: Sat, 6 Sep 2025 10:13:23 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek
 <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
References: <20250904063631.2364995-1-rdunlap@infradead.org>
 <6089e22ddfdc135040cdeb69329d817846026728@intel.com>
 <20250905140104.42418fba@foz.lan>
 <34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
 <atj2koasbiuf67rzr7bbdwpu4kcgkdsqt6rhz5vwpbryfqxm7z@mfmts3tnsasf>
 <2aad4540-ccdd-4519-9bed-7d8c7ccd009d@infradead.org>
 <20250906105627.2c0cd0d9@foz.lan>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250906105627.2c0cd0d9@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/25 1:56 AM, Mauro Carvalho Chehab wrote:
> Em Fri, 5 Sep 2025 15:07:31 -0700
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
>> Hi,
>>
>> On 9/5/25 6:38 AM, Mauro Carvalho Chehab wrote:
>>> On Fri, Sep 05, 2025 at 04:06:31PM +0300, Jani Nikula wrote:  
>>>> On Fri, 05 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:  
>>>>> Em Fri, 05 Sep 2025 12:02:37 +0300
>>>>> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
>>>>>  
>>>>>> On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:  
>>>>>>> Provide some basic comments about the system_states and what they imply.
>>>>>>> Also convert the comments to kernel-doc format.
>>>>>>>
>>>>>>> However, kernel-doc does not support kernel-doc notation on extern
>>>>>>> struct/union/typedef/enum/etc. So I made this a DOC: block so that
>>>>>>> I can use (insert) it into a Documentation (.rst) file and have it
>>>>>>> look decent.    
>>>>>>
>>>>>> The simple workaround is to separate the enum type and the variable:
>>>>>>
>>>>>> /**
>>>>>>  * kernel-doc for the enum
>>>>>>  */
>>>>>> enum system_states {
>>>>>> 	...
>>>>>> };
>>>>>>
>>>>>> /**
>>>>>>  * kernel-doc for the variable
>>>>>>  */
>>>>>> extern enum system_states system_state;
>>>>>>
>>>>>> BR,
>>>>>> Jani.
>>>>>>  
>>>>>>>
>>>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>>>>> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
>>>>>>> ---  
>>
>> [snip]
>>>>> If the problem is with "extern" before enum, fixing kdoc be
>>>>> fairly trivial.  
>>>>
>>>> The non-trivial part is deciding whether you're documenting the enum
>>>> type or the variable. Both are equally valid options.  
>>>
>>> True.
>>>
>>> I'd say that, if the variable is under EXPORT_SYMBOL macros, it
>>> should be documented.  
>>
>> Do you mean documented with kernel-doc? How do we do that?
>> I was under the impression that we don't currently have a way to
>> use kernel-doc for variables (definitions, only for declarations).
> 
> No, but it shouldn't be hard to add something like:
> 
> 	/**
> 	 * global system_state - stores system state
> 	 * <some description>
> 	 */
> 	extern enum system_states system_state;  
> 
> and place a dump_global() function at kdoc parser. Ok, one might use
> DOC:, but IMHO the best is to have a proper handler for it that would
> automatically pick the type.

Nitpick, I would s/global/var/. But I won't complain about "global".

More importantly, I have seen several patches where people try to document a
variable, so it seems like something that we should support at some point.

thanks.
-- 
~Randy


