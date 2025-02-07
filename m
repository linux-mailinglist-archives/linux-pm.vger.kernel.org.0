Return-Path: <linux-pm+bounces-21545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EDAA2C703
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 16:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CDE3B03D7
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C77240611;
	Fri,  7 Feb 2025 15:24:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4123FC71;
	Fri,  7 Feb 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941856; cv=none; b=bU79n2BKkewQWX8y+uSRRF8aKl4/8h8ju8RiKzMxJvUy+xtMAovhKxoU11dSPxmV0Qrn1s3qESoUY5FJzitNmiEMpJISBwy12e2oxYBHYoWa8QPXyH/efWASt8GXVoedPSA+2sxZwp0a/x4VPnIl+L+BnDtLCUP3EAhFcK2ED4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941856; c=relaxed/simple;
	bh=0O9wDWsp53GJ+J1jYjCa4uftsqXMS1U0OT2s84FdpHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPczjUTRDHU1H68JHUnt8TOvmxXGvHC/454yTxpl/W2gztlw5wwKOj0JTNRHl8hII8cJJ+39NRPZc6FriQMjqbM8/ttPH01ANEHoIX7//J9Ym8EgLZmF1bYTwO9WKaWXJddU36y7VSxmmBCBZZljW8itHMcNfHsjnTu4gnmdE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67D18113E;
	Fri,  7 Feb 2025 07:24:35 -0800 (PST)
Received: from [10.1.25.32] (e127648.arm.com [10.1.25.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54C753F58B;
	Fri,  7 Feb 2025 07:24:11 -0800 (PST)
Message-ID: <29daaf17-7711-44b1-baad-86dadcf01666@arm.com>
Date: Fri, 7 Feb 2025 15:24:09 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful
 information when processing recent idle intervals
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
 <4917ca35e5e0c7035f09c02d5080a69ed3e88c44.camel@linux.intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <4917ca35e5e0c7035f09c02d5080a69ed3e88c44.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/25 14:48, Artem Bityutskiy wrote:
> Hi,
> 
> thanks for the patches!
> 
> On Thu, 2025-02-06 at 15:21 +0100, Rafael J. Wysocki wrote:
>> Hi Everyone,
>>
>> This work had been triggered by a report that commit 0611a640e60a ("eventpoll:
>> prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS metric of
>> the SPECjbb 2015 benchmark [1] to drop by around 50% even though it generally
>> reduced kernel overhead.  Indeed, it was found during further investigation
>> that the total interrupt rate while running the SPECjbb workload had fallen as
>> a result of that commit by 55% and the local timer interrupt rate had fallen
>> by
>> almost 80%.
> 
> I ran SPECjbb2015 with and it doubles critical-jOPS and basically makes it
> "normal" again. Thanks!
> 
> Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 

I'll go take a look in-depth, honestly the statistical test of
get_typical_interval() is somewhat black magic to me before and after
4/5, so if that actually works better fine with me.
I'll run some tests, too.

