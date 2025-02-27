Return-Path: <linux-pm+bounces-23079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111CCA481E6
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020FE42308F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB492356A5;
	Thu, 27 Feb 2025 14:28:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3BE22FACE;
	Thu, 27 Feb 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666491; cv=none; b=oKJq2zkwQBW9T4xNn4N2cPCKkkMRFdLZao0861qZlbAO5aaMVk36Id9EnrSD8Lm5FeZuSJNTbJXjxvSzEyQg1JkrYzf41FdZh6zZNzRDo0FmMOgff0RAi3LEJET7z00G1tmBUuVbCZeoI71la2avyKZHx16CNCtXE0GBUQ3h2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666491; c=relaxed/simple;
	bh=ysub6CJYhJGfEwC76WIxoXPaF+SmuMoo948tl6inDJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPs5E02IXLrA4GuELHwgfZ5PdUSLaeuKpbxgXv/WkJH7kEhe7nJ/oz9BVRy14cNfaU2TcNUFlXHXuJE1Yz3h4OA3I/qhZP88UmxxqEEaFQXnBOM7JmIqbDiYeGikbv+S7mRbdlumD6erMgKwxZ3xfVRkGUJDGoIIL+JN3uHmO5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51F532BCA;
	Thu, 27 Feb 2025 06:28:24 -0800 (PST)
Received: from [10.57.78.204] (unknown [10.57.78.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7306C3F673;
	Thu, 27 Feb 2025 06:28:07 -0800 (PST)
Message-ID: <89e0f700-26a8-4d0f-a533-aba7ddac521e@arm.com>
Date: Thu, 27 Feb 2025 14:28:10 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: gov_power_allocator: Update total_weight on
 bind and cdev updates
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Yu-Che Cheng <giver@chromium.org>, Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
References: <20250222-fix-power-allocator-weight-v2-1-a94de86b685a@chromium.org>
 <CAJZ5v0jgRXoqx4g=iHSUteXs99ageQmcQDQfjp6eSqnVo9Ty8Q@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jgRXoqx4g=iHSUteXs99ageQmcQDQfjp6eSqnVo9Ty8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/25/25 11:35, Rafael J. Wysocki wrote:
> On Sat, Feb 22, 2025 at 4:20 AM Yu-Che Cheng <giver@chromium.org> wrote:
>>
>> params->total_weight is not initialized during bind and not updated when
>> the bound cdev changes. The cooling device weight will not be used due
>> to the uninitialized total_weight, until we trigger an update via sysfs.
>>
>> The bound cdev update will be triggered during thermal zone registration,
>> where each cooling device will be bound to the thermal zone one by one.
>>
>> The power_allocator_bind can be called without additional cdev update
>> when manually changing the policy of a thermal zone via sysfs.
>>
>> Add a new function to handle weight update logic, including updating
>> total_weight, and call it when bind, weight changes, and cdev updates to
>> ensure total_weight is always correct.
>>
>> Fixes: a3cd6db4cc2e ("thermal: gov_power_allocator: Support new update callback of weights")
>> Signed-off-by: Yu-Che Cheng <giver@chromium.org>
> 
> Applied as 6.14-rc material with some minor edits in the changelog.
> 
> Lukasz, if you have any objections, please let me know.

My apologies for the delay. Thanks Rafael for taking this into your
tree.

No objections, thanks Yu-Che for the fix.

The code looks good and if it's not too late then:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz


