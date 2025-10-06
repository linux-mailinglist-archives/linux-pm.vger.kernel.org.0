Return-Path: <linux-pm+bounces-35732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2764EBBE04A
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 14:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D653D3AA2F1
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2727080D;
	Mon,  6 Oct 2025 12:24:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644B27EC80;
	Mon,  6 Oct 2025 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753456; cv=none; b=MFuFmoU8trYDOJFcSr6r9F5WVN927ONB2/zuMSmw/cLaDv+OpSZ+TqytgyJR74xDg0sigRRqACQM14GY3a5kXYPVKUriPmnLqnusEMZF2VYXj+c7R0rJmwAZd2o7/xHf2vdcPmFep4TeN3+KwYPMZiqumU4OCsj0mqQO9xoXfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753456; c=relaxed/simple;
	bh=ZxPfTv0fnaN4V5KhBZ1r0G9OQ8Lc8OiDEJ0PtReoHQE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oHqUDGRmbN0AkW+wLd+wcScWQb65isZh9pVa/tpF6b82X4MwaVNQtmN7eoMt8JrongDwf4covxOuAVsNWDRCR333zDKFNOOx4n83ou/95e94SrKS8QO530cOGtzNPqJeb8cbAa6EVidhoFHdBLJMfXxxMVNh3tAw2tM/l9UMaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63DF21515;
	Mon,  6 Oct 2025 05:24:06 -0700 (PDT)
Received: from [10.57.81.187] (unknown [10.57.81.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92D703F738;
	Mon,  6 Oct 2025 05:24:12 -0700 (PDT)
Message-ID: <affa03ed-f859-4e11-9de2-59702b9d5ea4@arm.com>
Date: Mon, 6 Oct 2025 13:24:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 01/10] PM: EM: Assign a unique ID when creating
 a performance domain
From: Lukasz Luba <lukasz.luba@arm.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-2-changwoo@igalia.com>
 <05359260-336f-4047-bc3a-003ace5ad7c4@arm.com>
Content-Language: en-US
In-Reply-To: <05359260-336f-4047-bc3a-003ace5ad7c4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/6/25 09:17, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> My apologies to delay on this topic.
> 
> On 9/21/25 04:19, Changwoo Min wrote:
>> It is necessary to refer to a specific performance domain from a
>> userspace. For example, the energy model of a particular performance
>> domain is updated.
>>
>> To this end, assign a unique ID to each performance domain to address it,
> 
> Is this related to the sched_ext view on the EM that we cannot re-use
> the allocated ID for the given domain?

Ignore that comment, I know the need now.

Although, there is a small code sneak below...



[..]

>> @@ -660,6 +678,13 @@ int em_dev_register_pd_no_update(struct device 
>> *dev, unsigned int nr_states,
>>   unlock:
>>       mutex_unlock(&em_pd_mutex);
>> +    if (_is_cpu_device(dev))
>> +        em_check_capacity_update();
>> +

It doesn't below to this $subject at all. It looks like
it was left from some your local changes, isn't it?


