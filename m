Return-Path: <linux-pm+bounces-25565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEBFA907A6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 17:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673433B057A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD16C189BB5;
	Wed, 16 Apr 2025 15:26:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018CD1C7015;
	Wed, 16 Apr 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817168; cv=none; b=BeHLO/RdVrVQwRX3vSMYJCK0HE1YrtoByd7nuGKS9DdvfYk0HOHAn4XA7on/r+NQURkbAF4PNujbgqKtjLflJ4eqIhRUHSPDal/4qjHAZ/v1nz+rTsL++ORMLAvHvMHF9AdiBzVWiWAEfG2W1kO3eKlwWfw8Eb0ye70j2cRt6MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817168; c=relaxed/simple;
	bh=xuApqJIpg/A6yzMAM3bP2JnbdsNFyPu87tU3HFOJVPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3xKm7R5IO4+lRfEufFI5LJbxphnshFIP4JuYj3ToKlEfyzPZeAv2EkZFg1vqNKszODgtHsLwn7fcU/4U8nAu2mc4yIJvrjittz5Z6v6VigyzD6OSreNuPEkHdzkcYPyUSe26keQrPfrbnSe6L4P/oRo1iHNDuSo36ZiHgbySW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1347A1595;
	Wed, 16 Apr 2025 08:26:04 -0700 (PDT)
Received: from [10.57.71.18] (unknown [10.57.71.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C57C3F66E;
	Wed, 16 Apr 2025 08:26:05 -0700 (PDT)
Message-ID: <df494648-b0c1-402b-8644-b50f20011c5f@arm.com>
Date: Wed, 16 Apr 2025 16:26:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yaxiong Tian <tianyaxiong@kylinos.cn>, Yaxiong Tian <iambestgod@qq.com>
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <tencent_6D2374392DB66C9D23BF6E2546638A42EC08@qq.com>
 <CAJZ5v0iE_iw+pSBppEWnJw=2=DFNa-J2VPDorTNF=Mve+0PNCg@mail.gmail.com>
 <tencent_8E3A87C6D6A193F757BA846F0C41887CC405@qq.com>
 <CAJZ5v0iq4bw3WAk1yQRP=B3zk-rRYwibKNRjSfu=PGqTt6RNYw@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iq4bw3WAk1yQRP=B3zk-rRYwibKNRjSfu=PGqTt6RNYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/16/25 12:58, Rafael J. Wysocki wrote:
> On Wed, Apr 16, 2025 at 4:57 AM Yaxiong Tian <iambestgod@qq.com> wrote:
>>
>> 在 2025/4/16 01:17, Rafael J. Wysocki 写道:
>>> On Mon, Apr 14, 2025 at 11:09 AM Yaxiong Tian <iambestgod@qq.com> wrote:
>>>>
>>>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>>>
>>>> When the device is of a non-CPU type, table[i].performance won't be
>>>> initialized in the previous em_init_performance(), resulting in division
>>>> by zero when calculating costs in em_compute_costs().
>>>>
>>>> Since the 'cost' algorithm is only used for EAS energy efficiency
>>>> calculations and is currently not utilized by other device drivers, we
>>>> should add the _is_cpu_device(dev) check to prevent this division-by-zero
>>>> issue.
>>>>
>>>> Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove division")
>>>
>>> Please look at the Fixes: tags in the kernel git history.  They don't
>>> look like the one above.
>>>
>> Yes, there's an extra '<>' here.
>>
>>>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>>> ---
>>>>    kernel/power/energy_model.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>>>> index d9b7e2b38c7a..fc972cc1fc12 100644
>>>> --- a/kernel/power/energy_model.c
>>>> +++ b/kernel/power/energy_model.c
>>>> @@ -235,7 +235,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>>>>
>>>>           /* Compute the cost of each performance state. */
>>>>           for (i = nr_states - 1; i >= 0; i--) {
>>>> -               unsigned long power_res, cost;
>>>> +               unsigned long power_res, cost = 0;
>>>>
>>>>                   if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
>>>>                           ret = cb->get_cost(dev, table[i].frequency, &cost);
>>>> @@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>>>>                                           cost, ret);
>>>>                                   return -EINVAL;
>>>>                           }
>>>> -               } else {
>>>> +               } else if (_is_cpu_device(dev)) {
>>>
>>> Can't you just check this upfront at the beginning of the function and
>>> make it bail out if dev is not a CPU device?
>>>
>> Sure, But the current implementation applies em_compute_costs() to both
>> non-CPU devices and CPU devices.
> 
> Maybe it shouldn't do that for non-CPU ones?

It shouldn't call this cost computation for non-CPU devices.
Let me check that.

