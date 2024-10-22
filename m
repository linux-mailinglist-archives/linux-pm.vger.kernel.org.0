Return-Path: <linux-pm+bounces-16275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E4F9AB9AD
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 00:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4146C1C23BA3
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436171CDFD5;
	Tue, 22 Oct 2024 22:51:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8629E1CDFCB;
	Tue, 22 Oct 2024 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637471; cv=none; b=lBqddHZLnbPvsiHGAiIaOT3+guwuSpSwwVuZGCTvcm3lkm+7GuyCsaW1YPCDt1fk2/MAqymwegnwG0Nsv2fx9/06Pq6NZl9EIWbaTpu2+uyWWS48dsp6tOHPXHRLYCuyLV8kRDE9c2y4EfAtolKTKByhxZSSACdmLg8ZmcFzlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637471; c=relaxed/simple;
	bh=phcC3h+yzGKjMLzr4Wapgaq+8TfqvWpOxD6rLamedsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9b6bm2Aqjm+kirhLS0eqDm+h/h0fJV6Ip1UZLH+5ZT/5KLoN9n+VNpeN9M1zaM+a38KPEnhDSRyDEnNuBRDvDVBMOdpbnK/Dn8NmDjyN2JKiqxt2+y4s4prGhscMxLmt3NCCH0WizlZ1pgHnjVXxHxtdc/OPRsRITgqxzYYZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A32E497;
	Tue, 22 Oct 2024 15:51:38 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD6373F73B;
	Tue, 22 Oct 2024 15:51:07 -0700 (PDT)
Message-ID: <b6b42279-bc08-49aa-ac1e-98fe816bf342@arm.com>
Date: Tue, 22 Oct 2024 23:52:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/10] thermal: core: Use lists of trips for trip
 crossing detection and handling
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4958885.31r3eYUQgx@rjwysocki.net>
 <CAJZ5v0g_ALycyT7Y2GwebF_ON-EMP_WGoTn4+1V0ZisK1vwROg@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g_ALycyT7Y2GwebF_ON-EMP_WGoTn4+1V0ZisK1vwROg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 10/21/24 12:16, Rafael J. Wysocki wrote:
> On Wed, Oct 16, 2024 at 1:37 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> Hi Everyone,
>>
>> This is a continuation of
>>
>> https://lore.kernel.org/linux-pm/4985597.31r3eYUQgx@rjwysocki.net/
>>
>> derived from patches [3-7/8] in the following patch series:
>>
>> https://lore.kernel.org/linux-pm/4920970.GXAFRqVoOG@rjwysocki.net/
>>
>> but mostly rewritten.
>>
>> It is based on the observation that putting trip points on sorted lists
>> allows to reduce overhead related to the handling of them in some cases.
>> Namely, it avoids the need to walk all trips in a thermal zone every
>> time the zone temperature is updated (including invalid ones) and
>> generally leads to cleaner code.
>>
>> Patches [01-08/10] are preliminary, patch [09/10] makes the key changes,
>> and patch [10/10] is a super-cosmetic cleanup on top of the rest.
>>
>> Please refer to the individual patch changelogs for details.
> 
> This material is on the thermal-core-experimental branch in
> linux-pm.git along with
> 
> https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/
> 
> and
> 
> https://lore.kernel.org/linux-pm/4985597.31r3eYUQgx@rjwysocki.net/
> 
> which are also present in the thermal-core-testing branch.


If it's not too late, I can review that stuff tomorrow for you.

Regards,
Lukasz

