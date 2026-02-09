Return-Path: <linux-pm+bounces-42353-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CLhEJLUiWmCCAAAu9opvQ
	(envelope-from <linux-pm+bounces-42353-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 13:35:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA77110EB3F
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 13:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 234C9300E611
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2B431B825;
	Mon,  9 Feb 2026 12:35:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346FC19F137;
	Mon,  9 Feb 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640526; cv=none; b=Etz7E3Dn3UbCg1W7W4NI1mvx7pFA5FkAJ0IFBdIgSVNKzDMUZXu5R/FQUfQq862NTxNPgkaT4Rh5fT1xIVOvOJ44hopFSlzhGFBthongzIB4dbcRXIKI2fZXHcvHsh6Imkxn7TGIOWMKfWHHEWG41kD/ZwkFPeE7PtxAsOY432A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640526; c=relaxed/simple;
	bh=sj7mQANebDT/iscz/tLf4MSoGTfOlNTid7jYxLX9dmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClJ08ZceUH5kIU3X1AFFdikl/gLkXOKlctA8ifrBwjEGn5af20J8C4UR2o59jo3atdI4KtMq/8xYE+2Vpit/BGb65dG9PeCi9+pkTxsvTGdUrWmXJTssHXDGLqiBzItkeaRn2C1wi2GQYvlZoCYHV/pEWaqZY+2iqc9SaXcjfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48D55339;
	Mon,  9 Feb 2026 04:35:19 -0800 (PST)
Received: from [10.57.16.28] (unknown [10.57.16.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A71C73F63F;
	Mon,  9 Feb 2026 04:35:23 -0800 (PST)
Message-ID: <3aec2667-a62d-4a68-ba7d-bad7487dd0f7@arm.com>
Date: Mon, 9 Feb 2026 12:35:26 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] thermal: power_allocator: Ignore cutoff when integral
 is less than zero
To: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
 jeson.gao@unisoc.com, di.shen@unisoc.com
References: <20260119015803.183-1-xuewen.yan@unisoc.com>
 <CAB8ipk93vxpuSF3msuryedefJ8v_4ZMrk56MFaGp8+Mh-EqnSA@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk93vxpuSF3msuryedefJ8v_4ZMrk56MFaGp8+Mh-EqnSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42353-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,unisoc.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.luba@arm.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA77110EB3F
X-Rspamd-Action: no action

Hi Xuewen,

On 1/26/26 03:24, Xuewen Yan wrote:
> Hi lukasz,
> 
> Do you have any comments on this patch?

I missed that patch, my apologies.

> 
> Thanks!
> 
> On Mon, Jan 19, 2026 at 10:00 AM Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>>
>> From: Jeson Gao <jeson.gao@unisoc.com>
>>
>> The cutoff means threshold below which the error is no longer accumulated.
>> However, in some scenarios, this may cause performance degradation.
>>
>> For example:
>> the control-temp is 85, the cutoff is 0 or other small value:
>>
>> If the current temperature frequently exceeds the set temperature,
>> the negative integral will continuously accumulate.
>> Over an extended period, this will result in a significantly
>> large negative integral value, the positive integral can’t build up
>> because of the cutoff. This makes the power_range very low,
>> even if the temperature is already under the control target.
>>
>> So, if the err_integral is negative, ignore the cutoff to force
>> add the positive integral.

The accumulated Integral in the PID works like that, so no surprise
here (the math is correct). The Integral part tires to 'compensate'
the previous 'mistakes', e.g. slow down the rapid change which
has been seen and caused the overshoot.

>>
>> Co-developed-by: Di Shen <di.shen@unisoc.com>
>> Signed-off-by: Di Shen <di.shen@unisoc.com>
>> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>> ---
>>   drivers/thermal/gov_power_allocator.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>> index 0d9f636c80f4..404ae1d75612 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -263,7 +263,8 @@ static u32 pid_controller(struct thermal_zone_device *tz,
>>           */
>>          i = mul_frac(tz->tzp->k_i, params->err_integral);
>>
>> -       if (err < int_to_frac(tz->tzp->integral_cutoff)) {
>> +       if (err < int_to_frac(tz->tzp->integral_cutoff) ||
>> +           (err > 0 && params->err_integral < 0)) {
>>                  s64 i_next = i + mul_frac(tz->tzp->k_i, err);
>>
>>                  if (abs(i_next) < max_power_frac) {
>> --
>> 2.25.1
>>

Although, I might probably know where you're coming from and what you 
are trying to achieve (what is your platform's situation). Let me do
some simulations based on what you've described. I will look into
those signals in those conditions.

At the moment, I'm a bit afraid about your proposed simple change
and possible impact to other platforms.
Let me do my research and come back.

Thank you for reporting this issue!

Regards,
Lukasz

