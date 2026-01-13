Return-Path: <linux-pm+bounces-40733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F257D18B80
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 13:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78A30302FBE4
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4838F937;
	Tue, 13 Jan 2026 12:30:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C713238F257;
	Tue, 13 Jan 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307433; cv=none; b=ZQCAn5PCqFb13pz/Kc0TbhPQDqUe7FYmCFLgUhSi6jD3hH/FP3+Rrkjycn1AE/x6RvhVUWcvq8Re5CRIxIij/VlmZlySIIXUWoEsLZh9s/b3aMAZwKfm2AeWUMMe3grHWquGAYgwHiNwCmQgulqIb40qe0OAwiDbkQc7Ehcwxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307433; c=relaxed/simple;
	bh=+1r5JpINxGkRuotYJBXcmYZ2M+ajJ3igP7WUfZN9ZGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3b3TQU3p9PoiUJmL7klvtCoyQrbtm8nRfMvRNhx7aGrOdpBa6a0lSTSqrR2nea6Z/RcFp0NFtBa2nRScKAKctllssOYxD3Zcdb1G9ZkaZ+lSzT7fwc6zGekzBU0OH8Q7x0ofUqsyb7zZ0ovJzrDUP6VrMZqsK08A8llsxuuuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B47A0497;
	Tue, 13 Jan 2026 04:30:16 -0800 (PST)
Received: from [10.57.12.230] (unknown [10.57.12.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 740343F59E;
	Tue, 13 Jan 2026 04:30:22 -0800 (PST)
Message-ID: <12ba1c1d-fb20-476c-ae24-3e1007afb199@arm.com>
Date: Tue, 13 Jan 2026 12:30:22 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: max77620: fix kernel-doc for
 max77620_thermal_read_temp
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20251201054036.2143455-1-vivek.balachandhar@gmail.com>
 <2a3dc51e-ead2-4612-bf7f-6cdb49bf9570@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2a3dc51e-ead2-4612-bf7f-6cdb49bf9570@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vivek,

On 1/13/26 01:54, Vivek BalachandharTN wrote:
> Hi Rafael, Daniel,
> 
> Just a gentle follow-up on this patch — I wanted to check if there are 
> any concerns or if any changes are needed from my side.
> 
> Happy to revise or resend if required.

I think it was just missed.

> 
> Thanks for your time.
> 
> Best,
> Vivek
> 
> 
> On 2025-12-01 1:40 a.m., Vivek BalachandharTN wrote:
>> Building with W=1 reports a kernel-doc warning in
>> drivers/thermal/max77620_thermal.c:
>>
>>    Warning: max77620_thermal.c:47 function parameter 'tz'
>>    not described in 'max77620_thermal_read_temp'
>>
>> Update the kernel-doc comment for max77620_thermal_read_temp() to match
>> the current function prototype. Replace the stale @data entry with @tz
>> and describe the thermal zone device argument so that all parameters are
>> documented.
>>
>> This fixes the W=1 kernel-doc warning and keeps the documentation in
>> sync with the code.
>>
>> Signed-off-by: Vivek BalachandharTN<vivek.balachandhar@gmail.com>
>> ---
>>   drivers/thermal/max77620_thermal.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
>> index 85a12e98d6dc..8d37a04eb5a8 100644
>> --- a/drivers/thermal/max77620_thermal.c
>> +++ b/drivers/thermal/max77620_thermal.c
>> @@ -32,7 +32,7 @@ struct max77620_therm_info {
>>   
>>   /**
>>    * max77620_thermal_read_temp: Read PMIC die temperatue.
>> - * @data:	Device specific data.
>> + * @tz:	Thermal zone device
>>    * @temp:	Temperature in millidegrees Celsius
>>    *
>>    * The actual temperature of PMIC die is not available from PMIC.


The patch looks good. Although, I'm not sure if such change
should go through the stable tree.
Usually we would ask you to add 'Fixes:' line with the
hash of the commit which left that stale comment in this case.
If we were strict to the processes that should be there.
If we judge the effort and traffic for stable-linux folks
I would say, not needed.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz


