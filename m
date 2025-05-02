Return-Path: <linux-pm+bounces-26529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD22AA685D
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 03:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891D01BC6010
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 01:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339E2E403;
	Fri,  2 May 2025 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EvZmyMp+"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968D1EA90;
	Fri,  2 May 2025 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746149342; cv=none; b=WY+QYqDu8gylSgrlSLKgv4eoLRpC1nyWP+AnZiDMCZQRcHcbLep+KEpVMJt99Pv1gAOV6ya+Vs9L+2EpMOSr5MBxGRFk0nFe6LO8v6/QvTcUuzoEWk3zVDKGft+1Hi6EYKSVscVFhRim7qMUNM2Su4paVu6pE6ozL+N4mHQqNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746149342; c=relaxed/simple;
	bh=fJWJT35IUWPGEYm2Dlk1TyNhqD36PQtGiuKeHvfRaOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOIVIIwe9mfXcUEs5bB7TwVK3kpWKCXVrkWJpKAAsjLaIBXNYKZIrAwIaSIWJ9f67xnevzvXsd0S7C6tSyQgsZrfJflHqFbnlNB3EKVMb2fmZOSJunNpnHg0xote33Pu8+PcBIvsngvzllX+Mw6qjYp2rn9j0KzFuYWZtmPQ4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EvZmyMp+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=tUavYtvPrR+gGbX3pyNVUrqdQnleNkRAQhp8GoXCfO8=; b=EvZmyMp+Jl+5exMXUwDkmx9wSc
	UUJbyF4hnk9i/8PkzoaNkvpLbx4EKKrmDeup+SQV8+FZUbSLKV1nNq05+lNh4qZac148O4ZXwSlXA
	cxvOQB2SlosTJSuohzuINJ4/W+kuOlchCEYRy45BjILhBa0wZqyXziCryPgEsd01dJYHHi9rOkZ/w
	dyzOkffINlo80in+ft5jmNlEpU15L8VFagTi1aSEISc66i36R76J7/ngBoe44VJ9ME0Hys6D0zO/Q
	XYYhoW4WqTQWg9ktYa6xa6qEboiLIDVFMkkRFUF/qFJxEIt3HaG8sXv56E71Qa5cymNmaGOC5y4OB
	cKMY2now==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAfCe-0000000GgWT-1u0u;
	Fri, 02 May 2025 01:28:38 +0000
Message-ID: <f5402d7e-78d0-4efe-bc35-c30dcdf9f98a@infradead.org>
Date: Thu, 1 May 2025 18:28:15 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel.h: add comments for system_states
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
References: <20241129045750.456251-1-rdunlap@infradead.org>
 <CAJZ5v0gnsFM7YcBqO8Mbkr72ipQxT8nJ=i94z74Q0XM1csnTYw@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJZ5v0gnsFM7YcBqO8Mbkr72ipQxT8nJ=i94z74Q0XM1csnTYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/10/24 10:55 AM, Rafael J. Wysocki wrote:
> On Fri, Nov 29, 2024 at 5:57 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Provide some basic comments about the system_states and what they imply.
>> Also convert the comments to kernel-doc format.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Len Brown <len.brown@intel.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> 
> Fine by me.
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 

Please merge...
Thanks.

>> ---
>>  include/linux/kernel.h |   14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> --- linux-next-20241125.orig/include/linux/kernel.h
>> +++ linux-next-20241125/include/linux/kernel.h
>> @@ -176,9 +176,19 @@ extern int root_mountflags;
>>
>>  extern bool early_boot_irqs_disabled;
>>
>> -/*
>> - * Values used for system_state. Ordering of the states must not be changed
>> +/**
>> + * enum system_states - Values used for system_state.
>> + * Ordering of the states must not be changed
>>   * as code checks for <, <=, >, >= STATE.
>> + *
>> + * @SYSTEM_BOOTING:    %0, no init needed
>> + * @SYSTEM_SCHEDULING: system is ready for scheduling; OK to use RCU
>> + * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost running
>> + * @SYSTEM_RUNNING:    system is up and running
>> + * @SYSTEM_HALT:       system entered clean system halt state
>> + * @SYSTEM_POWER_OFF:  system entered shutdown/clean power off state
>> + * @SYSTEM_RESTART:    system entered emergency power off or normal restart
>> + * @SYSTEM_SUSPEND:    system entered suspend or hibernate state
>>   */
>>  extern enum system_states {
>>         SYSTEM_BOOTING,
>>

-- 
~Randy


