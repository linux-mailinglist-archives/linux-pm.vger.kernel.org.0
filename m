Return-Path: <linux-pm+bounces-27491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1F2AC06DD
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 10:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2170A7A6444
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E0A2620F1;
	Thu, 22 May 2025 08:19:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF2D17A2E1;
	Thu, 22 May 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747901991; cv=none; b=OSmUWm304gVvceoJO/SFJt6WnIHT6OYzTgV7ViUy54B2VXYE1IMjZCVjjPSCjVgGz0YHBvOK+/eb9PMHdtP42HnD2Tq5EyEI2Nh3yhlX1CaQHh6P1V9w6ZreXFOyl8hVxha8858MBtcQZXXhy5EPUCB0Iz/yg1jOd91XxXs39/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747901991; c=relaxed/simple;
	bh=c/iwD65h6KHaqI/Yxo+GId26LdbQ9yJq+PIvnjY5tdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+F8cTo3OQejXGU53Dd1c6Y3etGguCrBahiAJZ8R68DKmmw7r7PiRIr1SzmoFpv4DutBREe9Uv4X3aYMWL1gvANCRr4wnda5MdevHfBrctF1jebMfCFXFC+WZc4YX+oue5YswUIKxHDbEz3AKPZi5I46sM8xhd0/Q+VioBA7zSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06D6E1A32;
	Thu, 22 May 2025 01:19:35 -0700 (PDT)
Received: from [10.57.46.113] (unknown [10.57.46.113])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78F073F5A1;
	Thu, 22 May 2025 01:19:47 -0700 (PDT)
Message-ID: <96b4ae67-b9a8-47d3-a951-a880848e6719@arm.com>
Date: Thu, 22 May 2025 09:19:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Add inotify support when the energy model is
 updated.
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 kernel-dev@igalia.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, len.brown@intel.com,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250507014728.6094-1-changwoo@igalia.com>
 <a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com>
 <CAJZ5v0ixh=ra-TDbC59rpZoGn0pRWmAMchHqoOb_XwB2XUzA7Q@mail.gmail.com>
 <90834b07-9261-4be6-a10b-88d3f5308e1e@igalia.com>
 <CAJZ5v0jiAHHLP2O_0ZkXPPCXq9tFTxqrap1mFXOJtKuBo-gJfw@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jiAHHLP2O_0ZkXPPCXq9tFTxqrap1mFXOJtKuBo-gJfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/10/25 12:34, Rafael J. Wysocki wrote:
> On Sat, May 10, 2025 at 7:07 AM Changwoo Min <changwoo@igalia.com> wrote:
>>
>> Thank you, Rafael, for the pointer.
>>
>> On 5/10/25 01:41, Rafael J. Wysocki wrote:
>>>>
>>>> I have discussed that with Rafael and we have similar view.
>>>> The EM debugfs is not the right interface for this purpose.
>>>>
>>>> A better design and mechanism for your purpose would be the netlink
>>>> notification. It is present in the kernel in thermal framework
>>>> and e.g. is used by Intel HFI
>>>> - drivers/thermal/intel/intel_hfi.c
>>>> - drivers/thermal/thermal_netlink.c
>>>> It's able to send to the user space the information from FW about
>>>> the CPUs' efficiency changes, which is similar to this EM modification.
>>>
>>> In addition, after this patch
>>>
>>> https://lore.kernel.org/linux-pm/3637203.iIbC2pHGDl@rjwysocki.net/
>>>
>>> which is about to get into linux-next, em_dev_update_perf_domain()
>>> will not be the only place where the Energy Model can be updated.
>>
>> I am curious about whether the energy mode is likely to be updated more
>> often with this change. How often the energy model is likely to be
>> updated is the factor to be considered for the interface and the model
>> to post-processing the eneergy model (in the BPF schedulers).
> 
> It really is hard to say precisely because eventually this will depend
> on the platform firmware.  Hopefully, this is not going to happen too
> often, but if the thermal envelope of the platform is tight, for
> instance, it may not be the case.

It's hard to say for all use cases, but there are some easy to measure
and understand:

1. Long scenarios with heavy GPU usage (e.g. gaming). Power on CPUs
    built from High-Performance cells can be affected by +20% and after
    ~1min
2. Longer recording with heavy ISP usage, similar to above

In those two, it's sufficient to update the EM every 1-3sec to reach
this +20% after 60sec. Although, at the beginning when the GPU starts
heating the updates should happen a bit more often.

There are some more complex cases, e.g. when more than 1 Big CPU does
heavy computations and the heat is higher than normal EM model of
single CPU (even for that scenario profile). Then the updates to EM
can go a bit more often (it depends what the platform would like
to leverage and achieve w/ SW).

