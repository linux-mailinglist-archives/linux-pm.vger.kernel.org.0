Return-Path: <linux-pm+bounces-18765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6579E8523
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C60B164064
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A16146A7A;
	Sun,  8 Dec 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="WBrGrfgt"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3D80BFF;
	Sun,  8 Dec 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662860; cv=none; b=mw6Er2R+KLyBY01l247QKF/bqpDaAHLa2mNT/rtPVsNR19r/6bBWMEQ5GomsEzY4yqe7NZFt8JeKnxi0npwpFkXa132xJs78ADdBEH1kqTvquxlWG+eUicW2oygxcmY+VI8ZLseKCwUqNd1wsUWfIT8XQPhEDzfbTx6wyuem33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662860; c=relaxed/simple;
	bh=+aPB+YlkJlsHizTK+0IOYjfWrhg9jBu9ryfLATLQtNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c/2svpOw2CsvbW3SJ24Lxbo97BsuCdseGQav3FMWEXDlrIg707DQ4yKkv0KmhEepE4o/+X9RNqg955VRbT81msAJlg822gniYqSnFIoe/bwft3qWyC+esskHyLGcWvU+X1XWL1mMOumK6WkEVczNmaDc4i16+PL699Y1IL8vpaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=WBrGrfgt; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9530FA1039;
	Sun,  8 Dec 2024 14:00:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=KIsdPwZwMzoULAharfGI
	5X61H/X1wnWEEF757phQrFk=; b=WBrGrfgtgK354XS1BhVu2v/T3psxnGkpf/yF
	2zdd1Hc2uh/RyDvAK/xld2Sj0vHQrG8QlFUmeDQ1DY383Mn7QoZWH8lOklZxeeKB
	KNALTvMI/Wo2AFG67wAxCnTU1MYveFS9KU6RiYRXZobS+e8jR4KCZmlLMxhhu2IW
	+ZTASCPs02tMrppQMyVxat+gsVkhAa04OKMv/7YLR7A98mgiq7gsTDZAKhnFqQCK
	iIBpebfgaoMO5tzmIoYYGnrlv+oWZJKfxPOjF1dGsOi+4DhUY7Du5Ny1NiaaMt1f
	D6ckodfXTWWUr9FY7KaGRrnDID1d/CNAN0NhJ8dzEpciMUduUedAX6BNNl4ommfQ
	Ly0pRToKzRYrJqWTjazwUwwnXf1ICZV1KQticWfQ1MImQKiJeHTedZz1Np/rL17e
	10jhHGBI/GqxAsXsOrsScHUSJXcE6BJZt+bQ+d+mutOiN3VwCkvAOC9KIOkA6XvL
	oA637ej7JjrapM1H8TQ4bJOFXT40tC/+YosfHxU0qGKxH5zrROQfP9hsp5K+dsSC
	7muzSXmQVNiogi9aS3+XnYyfR89FU8OGY+2DqqAANzgqtdC6oqaIPtXhsIhzmxt1
	zCJRf2JVo1cA3tok0LlkWUadyzli2dvvanzQdjCcD/xoqviUWmKh8J3/LSlKk4MR
	cwFiGQ4=
Message-ID: <f042fea0-3977-40cb-a3b1-129ceee5b3bd@prolan.hu>
Date: Sun, 8 Dec 2024 14:00:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] power: ip5xxx_power: Allow for more parameters to
 be configured
To: Kees Bakker <kees@ijzerbout.nl>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Samuel Holland <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
References: <20241119180741.2237692-1-csokas.bence@prolan.hu>
 <20241119180741.2237692-3-csokas.bence@prolan.hu>
 <b547c228-df70-4137-9e96-175923f62404@ijzerbout.nl>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <b547c228-df70-4137-9e96-175923f62404@ijzerbout.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485562766B

Hi,

On 2024. 12. 06. 20:51, Kees Bakker wrote:
> Op 19-11-2024 om 19:07 schreef Csókás, Bence:
>> Other parts such as IP5306 may support other battery voltages and
>> have different constants for input voltage regulation. Allow these
>> to be passed from `struct ip5xxx_regfield_config`.
>>
>> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
>> ---
>>   drivers/power/supply/ip5xxx_power.c | 43 ++++++++++++++++++++++++++---
>>   1 file changed, 39 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/power/supply/ip5xxx_power.c 
>> b/drivers/power/supply/ip5xxx_power.c
>> index 41d91504eb32..a939dbfe8d23 100644
>> --- a/drivers/power/supply/ip5xxx_power.c
>> +++ b/drivers/power/supply/ip5xxx_power.c
>> [...]
>>   /*
>> @@ -328,6 +348,9 @@ static int ip5xxx_battery_get_voltage_max(struct 
>> ip5xxx *ip5xxx, int *val)
>>       if (ret)
>>           return ret;
>> +    if (*val > ip5xxx->vbat_max)
>> +        return -EINVAL;
> This is introducing the read of an uninitialized variable.
> You have to check all the callers of ip5xxx_battery_get_voltage_max()
> and what variable *val is pointing to. For example in
> ip5xxx_battery_get_property() the variable vmax is not initialized,
> while its address is passed to ip5xxx_battery_get_voltage_max()
> 
> But maybe the intention was to check rval instead of *val?
> [...]

That was supposed to go in set_voltage_max()... I'll send a fix shortly.

Bence


