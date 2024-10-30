Return-Path: <linux-pm+bounces-16715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876D9B5FA0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 11:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF33284288
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376521E47DE;
	Wed, 30 Oct 2024 10:00:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACBA1E3DC3;
	Wed, 30 Oct 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282414; cv=none; b=ZMMsj/DBvoFqqHLgKnkE61EkXcjIa/gN7SX5QgbeRF45WVbOZYRa2SMBzSIIr7D0Qmkw7GCSdZCDUusFpWMp5MXOITskqTCxLBJqhZWZty8z1vpJ42dg83pq8uMNJSo1s0z/bAGoDjj3Cafd7/PhIeDArjuOK/mINiUY3D0W2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282414; c=relaxed/simple;
	bh=cT1HIf1YbClumj3MmyRbLJzzCzvYht5YKjzQ1fwh+WU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CYDt3EzfzKOn9WIUMJKHIgAbu/3wfsbwDf8aSlGQfn1giQqAbGZ7rt6MamUgAHCGS+/d+dlnMpAOAkMJZ1DTehrf1ZQMhKcM45bBTAx9wwGKcZCXqifjsdXaELgu/LA9Fno3XUELnhHcV7jPuqdZmJy5EId9R3KHxRVa6yKmBrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AFCD113E;
	Wed, 30 Oct 2024 03:00:41 -0700 (PDT)
Received: from [10.57.58.72] (unknown [10.57.58.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7DD23F73B;
	Wed, 30 Oct 2024 03:00:10 -0700 (PDT)
Message-ID: <61afac10-b434-4e39-8c49-c220add4bd8e@arm.com>
Date: Wed, 30 Oct 2024 10:01:24 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] PM: EM: Add min/max available performance state
 limits
From: Lukasz Luba <lukasz.luba@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com
References: <20241029094452.495439-1-lukasz.luba@arm.com>
 <20241029094452.495439-2-lukasz.luba@arm.com>
 <CAJZ5v0gzQhw3wkRVFTEx-y4pawknJqC2JPrN6_dqd77vTVuSOw@mail.gmail.com>
 <6cdb2f8b-62e0-455c-a3a5-ed5359a2e941@arm.com>
Content-Language: en-US
In-Reply-To: <6cdb2f8b-62e0-455c-a3a5-ed5359a2e941@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/30/24 08:48, Lukasz Luba wrote:
> Hi Rafael,
> 
> On 10/29/24 18:29, Rafael J. Wysocki wrote:
>> On Tue, Oct 29, 2024 at 10:43 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>

[snip]

>>> +EXPORT_SYMBOL_GPL(em_update_performance_limits);
>>
>> It would be good to have at least one caller of this function in the 
>> tree.
> 
> Yes, I know, but we had delays with the SCMI cpufreq to get the
> notifications support, which are sent from FW...
> 
> The patch using this API was part of v1 but with assumption that
> those SCMI notifications are merged.
> 
> The patch v1 for the SCMI cpufreq driver [1].
> 
> In that v1 cover letter I mentioned that the 2nd patch depends
> on notifications [2].
> 
> I will have to work with Cristian on that notification in SCMI
> then this API will be used. I can see that it stuck for a while
> in v5. Let me sort that out (probably not in this merge window
> though).

Just to link the effort which has been started into that direction:

https://lore.kernel.org/lkml/ab36709d-a181-4621-a8e5-0ef38b80186b@arm.com/


> 
> Can we do it this way?
> 
> Regards,
> Lukasz
> 
> [1] 
> https://lore.kernel.org/lkml/20240403162315.1458337-3-lukasz.luba@arm.com/
> [2] 
> https://lore.kernel.org/lkml/20240403162315.1458337-1-lukasz.luba@arm.com/
> [3] 
> https://lore.kernel.org/lkml/20240603192654.2167620-1-quic_sibis@quicinc.com/
> 

