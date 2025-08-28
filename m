Return-Path: <linux-pm+bounces-33339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 992FCB3ACDE
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 23:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54481A00B9C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 21:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7512C11F5;
	Thu, 28 Aug 2025 21:44:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A44A2C08A8;
	Thu, 28 Aug 2025 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417487; cv=none; b=STkKXhhqKBtj/NxfmBxik/33bp0nIL9vfSu5YgnnZx3XCPAalzlGwqf8ITS2RHJ+qNleDs01mFmC4mf6GnvyM+zT8aVh9xSuhRMy/EmYo7IG9ZJGH3chWMIcFBPgZmlQDxXiYxCVwBJW2KMznXGPbJpFLbZJ15uoREB7moTij58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417487; c=relaxed/simple;
	bh=D0Iy2kssQWepKr3rrvAwXGm8QXT4WEE6XtWLMJ/4ooU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3OHY2sHQMUvwLhcF8K4zpz8S3s1PAhBIEfCZiaXkKGDMKqX/y9dbTjkH9+258hk4IHxlta5Z3T43qKg7Gp21lr/oJMETxZg92+LXTlHvnsSa/dN/BlKEOtUqCXtDWegw7t920Ijgzu8tEmIX500lZaYKY1ZKvbgOLw+OCXamuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B0461655;
	Thu, 28 Aug 2025 14:44:35 -0700 (PDT)
Received: from [10.57.58.232] (unknown [10.57.58.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB5A53F738;
	Thu, 28 Aug 2025 14:44:42 -0700 (PDT)
Message-ID: <39dccf98-41da-4c54-a200-50f367cd0147@arm.com>
Date: Thu, 28 Aug 2025 22:44:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "intel_idle: Rescan "dead" SMT siblings during,
 initialization"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <724616a2-6374-4ba3-8ce3-ea9c45e2ae3b@arm.com>
 <CAJZ5v0gGchbaQWRq39JbrX8chca7uefef763coJeup+vUOfyCw@mail.gmail.com>
 <CAJZ5v0h=OG-wgcZBD8mZ51+kb7j3yeDZQt9XfO=fdasLRgQkEg@mail.gmail.com>
 <CAJZ5v0jdMHd7cRktE8xsQZMTkSK44LZCyFdWzDVLcasvfhJP-g@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0jdMHd7cRktE8xsQZMTkSK44LZCyFdWzDVLcasvfhJP-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/28/25 20:06, Rafael J. Wysocki wrote:
> On Thu, Aug 28, 2025 at 6:13 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thu, Aug 28, 2025 at 4:44 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Thu, Aug 28, 2025 at 4:26 PM Christian Loehle
>>> <christian.loehle@arm.com> wrote:
>>>>
>>>> This reverts commit a430c11f401589a0f4f57fd398271a5d85142c7a.
>>>>
>>>> Calling arch_cpu_rescan_dead_smt_siblings() in intel_idle_init with
>>>> boot parameter nosmt and maxcpus active hotplugged boot-offline CPUs
>>>> in (and leave them online) which weren't supposed to be online.
>>>>
>>>> With the revert and nosmt and maxcpus=12 on a raptor lake:
>>>> cpu     online  capacity
>>>> cpu0    1       1009
>>>> cpu1    0       -
>>>> cpu2    1       1009
>>>> cpu3    0       -
>>>> cpu4    1       1009
>>>> cpu5    0       -
>>>> cpu6    1       1009
>>>> cpu7    0       -
>>>> cpu8    1       1024
>>>> cpu9    0       -
>>>> cpu10   1       1024
>>>> cpu11   0       -
>>>> cpu12   1       1009
>>>> cpu13   0       -
>>>> cpu14   1       1009
>>>> cpu15   0       -
>>>> cpu16   1       623
>>>> cpu17   1       623
>>>> cpu18   1       623
>>>> cpu19   1       623
>>>> cpu20   0       -
>>>> cpu21   0       -
>>>> cpu22   0       -
>>>> cpu23   0       -
>>>>
>>>> Previously:
>>>> cpu     online  capacity
>>>> cpu0    1       1009
>>>> cpu1    0       -
>>>> cpu2    1       1009
>>>> cpu3    0       -
>>>> cpu4    1       1009
>>>> cpu5    0       -
>>>> cpu6    1       1009
>>>> cpu7    0       -
>>>> cpu8    1       1024
>>>> cpu9    0       -
>>>> cpu10   1       1024
>>>> cpu11   0       -
>>>> cpu12   1       1009
>>>> cpu13   0       -
>>>> cpu14   1       1009
>>>> cpu15   0       -
>>>> cpu16   1       623
>>>> cpu17   1       623
>>>> cpu18   1       623
>>>> cpu19   1       623
>>>> cpu20   1       623
>>>> cpu21   1       623
>>>> cpu22   1       623
>>>> cpu23   1       623
>>>>
>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>>> ---
>>>> Rafael, I don't immediately see how to fix this properly so I won't
>>>> try to, feel free to treat this as a bug report.
>>>
>>> Sure, thanks for reporting this!
>>>
>>> Well, I think that cpuhp_smt_enable() is missing a check.  It looks to
>>> me like it should do the topology_is_primary_thread(cpu) check like
>>> cpuhp_smt_disable().
>>>
>>> I'll cut a test patch for this later.
>>
>> Something like the attached one, perhaps.  I haven't tested it yet,
>> but I'll do that later.
> 
> Works here AFAICS, but my test system is not hybrid.

Yep, on my end as well, thanks!
Tested-by: Christian Loehle <christian.loehle@arm.com>

