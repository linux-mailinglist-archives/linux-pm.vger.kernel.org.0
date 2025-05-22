Return-Path: <linux-pm+bounces-27495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D271FAC0787
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 10:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB791686EB
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426A2857FB;
	Thu, 22 May 2025 08:43:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663B1221DB3;
	Thu, 22 May 2025 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903389; cv=none; b=Qhsa8fpMiiOAcpWv5FbG+IQEJwt3P/i6r6M806snf6+FBM8tOQ8oZUIu3ESUJh5mlj8P7/yGebG1IK+MwHBTIheAtH3Rfw8yP4ldONIuERuYyJ2Ugoz2Ey2odLnW2fl41H38gg1Kvju0so/VfMK1BGMnFnUwsHau8ALaA/N2g3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903389; c=relaxed/simple;
	bh=MLgJr4DqWEmGJovEN1mYiASzZcP9xU2E8Kh3tstQ6V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGpRecZPB9cFipvafVFggC1XXAypn21CvF4jj5hXxUVsZmZ6CVccgZGLtw1PE4Qtd8jYkMKw7EpZ5AdVlrHUPhbsPY5F7NUbkm3B5t4RmNyuUGpTrQkreLyb9y+//tzYJOFqSvtVR/pdCbHkVgPcDsYU3UnFugIS/piQaOIz/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CC0A1D13;
	Thu, 22 May 2025 01:42:51 -0700 (PDT)
Received: from [10.57.46.113] (unknown [10.57.46.113])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D9443F5A1;
	Thu, 22 May 2025 01:43:03 -0700 (PDT)
Message-ID: <040a0850-a686-42c3-832c-07494cac8ef0@arm.com>
Date: Thu, 22 May 2025 09:43:08 +0100
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
 <96b4ae67-b9a8-47d3-a951-a880848e6719@arm.com>
 <c85cbb96-8c0f-4f91-a568-20c9de65b10b@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <c85cbb96-8c0f-4f91-a568-20c9de65b10b@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/22/25 09:35, Changwoo Min wrote:
> 
> 
> On 5/22/25 17:19, Lukasz Luba wrote:
>>
>>
>> On 5/10/25 12:34, Rafael J. Wysocki wrote:
>>> On Sat, May 10, 2025 at 7:07 AM Changwoo Min <changwoo@igalia.com> 
>>> wrote:
> 
>>>> I am curious about whether the energy mode is likely to be updated more
>>>> often with this change. How often the energy model is likely to be
>>>> updated is the factor to be considered for the interface and the model
>>>> to post-processing the eneergy model (in the BPF schedulers).
>>>
>>> It really is hard to say precisely because eventually this will depend
>>> on the platform firmware.  Hopefully, this is not going to happen too
>>> often, but if the thermal envelope of the platform is tight, for
>>> instance, it may not be the case.
>>
>> It's hard to say for all use cases, but there are some easy to measure
>> and understand:
>>
>> 1. Long scenarios with heavy GPU usage (e.g. gaming). Power on CPUs
>>     built from High-Performance cells can be affected by +20% and after
>>     ~1min
>> 2. Longer recording with heavy ISP usage, similar to above
>>
>> In those two, it's sufficient to update the EM every 1-3sec to reach
>> this +20% after 60sec. Although, at the beginning when the GPU starts
>> heating the updates should happen a bit more often.
>>
>> There are some more complex cases, e.g. when more than 1 Big CPU does
>> heavy computations and the heat is higher than normal EM model of
>> single CPU (even for that scenario profile). Then the updates to EM
>> can go a bit more often (it depends what the platform would like
>> to leverage and achieve w/ SW).
> 
> Thank you for the further clarification. I think the netlink 
> notification should be fast and efficient enough to cover these scenarios.

Yes, I agree

