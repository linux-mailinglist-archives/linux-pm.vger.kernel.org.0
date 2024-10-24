Return-Path: <linux-pm+bounces-16385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B97B9AE679
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E751F268F4
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F0D1F5845;
	Thu, 24 Oct 2024 13:26:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7FE1F5840;
	Thu, 24 Oct 2024 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776372; cv=none; b=Wo0uzSE9qQCVbHVJIUueQpbH5UPqar0B3r8crZb/9wiiRvmuRraFeACm4NEl9AqWXO2UteEyxYPByVRJWNDQmas653PhgWZc1htXa6EwpCc5GxcTPyGfsMzgDE1YaZPW6+X7NP/CpCk2XlxsLoZL+FCS+DWE9Nk7m4mH3tlXhPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776372; c=relaxed/simple;
	bh=pwiq/eaNUvB2cYRIsPcxJhyT0FH4o9oUMMHH4lSg6oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t55xmfdPS0jw/FB4SV0ABTqqn2DWuigI3JBB+pZYDyIo2cIxwqy7nZ+lnZ+r3aEg3fzTGuz+tjWHDsi9bvXEP1HGGH/b3Kue3QOtNxM4nYsKyskjxdN1yK1WiNyIk6omxNQ7APVYM8VGUO9ojWrJPleEnQ2nGeqZr/Usl4J1pfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB71F339;
	Thu, 24 Oct 2024 06:26:38 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 169863F71E;
	Thu, 24 Oct 2024 06:26:07 -0700 (PDT)
Message-ID: <f6ad24c8-0065-4d73-98f1-dc4246ca70ea@arm.com>
Date: Thu, 24 Oct 2024 14:27:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/lib: Fix memory leak on error in
 thermal_genl_auto()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
References: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
 <45265aca-7371-455f-819f-c4d68cbb089b@web.de>
 <9ba3fa17-57c3-41e9-9e19-33fa105a179e@linaro.org>
 <CAJZ5v0jWGdzakj8ob2otAO6auwGBvVsewujG-d9b1Z5nnO7Vkw@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jWGdzakj8ob2otAO6auwGBvVsewujG-d9b1Z5nnO7Vkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/24/24 14:18, Rafael J. Wysocki wrote:
> On Thu, Oct 24, 2024 at 2:57 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 24/10/2024 14:02, Markus Elfring wrote:
>>>> The function thermal_genl_auto() does not free the allocated message
>>>> in the error path. Fix that by putting a out label and jump to it
>>>> which will free the message instead of directly returning an error.
>>>
>>> Would you like to add any tags (like “Fixes” and “Cc”) accordingly?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12-rc4#n145
>>>
>>>
>>> …
>>>> +++ b/tools/lib/thermal/commands.c
>>>> @@ -375,27 +375,30 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cm
>>>>                                        struct cmd_param *param,
>>>>                                        int cmd, int flags, void *arg)
>>>>    {
>>>> +    thermal_error_t ret = THERMAL_ERROR;
>>>>       struct nl_msg *msg;
>>>>       void *hdr;
>>>>
>>>>       msg = nlmsg_alloc();
>>>>       if (!msg)
>>>> -            return THERMAL_ERROR;
>>>> +            goto out;
>>> …
>>>
>>> Is it really reasonable to pass a null pointer (from a failed function call)
>>> to a subsequent nlmsg_free() call?
>>
>> You are right, I should return here :S
> 
> Do you want to respin it?
> 
> Alternatively, I can fix it up when applying the patch.

The nlmskg_free() function should handle that similar to kfree().
Under the hood there is a check in skb_unref():
if (unlikely(!skb))

AFAIK the kfree() is used similar way and NULL is part of generic
case sometimes, not handles with extra code.

Up to you. You can keep my review tag in both cases.

