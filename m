Return-Path: <linux-pm+bounces-34070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34562B47569
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 19:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA37458629D
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C625C254AEB;
	Sat,  6 Sep 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gMQThJKC"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352641F2BAB;
	Sat,  6 Sep 2025 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757178867; cv=none; b=VRdCjAnjQp/dB5ZczS/8CdalpQYOxiZEOr7/Mkyp56JNps8v40272cRoVnpZfu/fGFlsUATdpQyC5j9q+7JuxpEkHEPOTSk2eVe0OTCEkqGQni3Hf7JfTeFAQr9Q1Nx2EVh0DMuK5qc5XIfj7HOqHJH8DoJgT3DTc3yKDSKdR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757178867; c=relaxed/simple;
	bh=nHu5RmYUUZ+sZ9Iev1PQgVNgPU78+FGi7HBcvjkzy2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSGYM7xn5Qf9e2mrTR97xr2rGlJMj9rr1MKzBhFos83tCvVLhNTWvQvEzxIRzCZp1rrDrdOFM7KCxKPUA4Bj84wo8lOvMYIbagnkYisETcGOa21lzJoXobOOTRCLojc703RPM1ncbqv1GU2XhQyIyzZx+qF9iorEpfXhsLDy3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gMQThJKC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tZBrUhB1zHWC8DFTre0nso3bGi4XXNiikJylJq2Ari4=; b=gMQThJKCxvM/WcgP9+UGvq9qPk
	zyGCcN2sLT6Gf1e8du5k4a3RRaQzOO2piFaNEPDu8u/uQ18R31b2nLptXR8U5yfhLoI4p6fAL2mTF
	f0an5WLhvhar1+7ZkZVfWmNHVO8BI4GUay4nTgfyukXl2bRuSuRj1b7t2zF3xI2fqZxng4m3m2V7+
	ucR3WE1Q3HPbxFlmGA6P4NfjXxx3Eyg5biR4zmO7amMn4qY62YJ4JjbL3yPBv/pNJPO1qNB9cF1k+
	hNFjl2i9WTgWyie+DA+vcCYC7F087LzyojNadYYDfhpeBGuVlGYUQWnIoocwxX4/DPSEG8i+M6J4L
	PZZGStJQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuwUb-00000008Azf-2or2;
	Sat, 06 Sep 2025 17:14:25 +0000
Message-ID: <4ce38a55-fb12-4dd7-9754-4fb394e4df80@infradead.org>
Date: Sat, 6 Sep 2025 10:14:24 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] kernel.h: add comments for enum system_states
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek
 <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Jani Nikula <jani.nikula@linux.intel.com>,
 linux-doc@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20250906052758.2767832-1-rdunlap@infradead.org>
 <20250906105851.7c28416c@foz.lan>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250906105851.7c28416c@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/25 1:58 AM, Mauro Carvalho Chehab wrote:
> Em Fri,  5 Sep 2025 22:27:58 -0700
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
>> Provide some basic comments about the system_states and what they imply.
>> Also convert the comments to kernel-doc format.
>>
>> Split the enum declaration from the definition of the system_state
>> variable so that kernel-doc notation works cleanly with it.
>> This is picked up by Documentation/driver-api/basics.rst so it
>> does not need further inclusion in the kernel docbooks.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
>> ---
>> v2: add Rafael's Ack.
>> v3: add Andrew
>> v4: add DOC: so that this DOC: block can be used in Documentation/
>>     add Greg K-H
>>     add Jon Corbet, Mauro Chehab, & linux-doc
>> v5: split enum declaration and definition (Jani Nikula)
>>     drop the DOC: block since it is no longer needed
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Len Brown <len.brown@intel.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> Cc: linux-doc@vger.kernel.org
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> ---
>>  include/linux/kernel.h |   21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> --- linux-next-20250819.orig/include/linux/kernel.h
>> +++ linux-next-20250819/include/linux/kernel.h
>> @@ -164,11 +164,23 @@ extern int root_mountflags;
>>  
>>  extern bool early_boot_irqs_disabled;
>>  
>> -/*
>> - * Values used for system_state. Ordering of the states must not be changed
>> +/**
>> + * enum system_states - Values used for system_state.
>> + *
> 
>> + * * @SYSTEM_BOOTING:	%0, no init needed
>> + * * @SYSTEM_SCHEDULING: system is ready for scheduling; OK to use RCU
>> + * * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost running
>> + * * @SYSTEM_RUNNING:	system is up and running
>> + * * @SYSTEM_HALT:	system entered clean system halt state
>> + * * @SYSTEM_POWER_OFF:	system entered shutdown/clean power off state
>> + * * @SYSTEM_RESTART:	system entered emergency power off or normal restart
>> + * * @SYSTEM_SUSPEND:	system entered suspend or hibernate state
> 
> You forgot to drop the extra asterisk at the above. definitions.

Oops, thanks for catching that. Will fix.

-- 
~Randy


