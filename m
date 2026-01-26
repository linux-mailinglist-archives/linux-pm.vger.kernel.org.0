Return-Path: <linux-pm+bounces-41468-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDrCCpVYd2lneQEAu9opvQ
	(envelope-from <linux-pm+bounces-41468-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 13:05:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A7D87FC1
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 13:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD1C930055E7
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE70334688;
	Mon, 26 Jan 2026 12:05:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4818733064F;
	Mon, 26 Jan 2026 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429133; cv=none; b=q2DYxR4o0pGclbSfegR7ERGBVyrqBtrOZL8db2TTglgIOsMCMV2xEB593NuNgEw/oR26LojvxCv8I7TGQv5DNAcZqLtpDAixYs232lK/GEXCxExfUDupvcxGtsFryJMJ2JnEzkbEinsrSxMW+IJ2OuiGwOjpoLjZu1r8qs5Tzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429133; c=relaxed/simple;
	bh=w+DZaiOQglryutq4Nj31FjTYBuaCZboGEfvTlv6WGoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSQU19NWokDfUcXoR5prQt6sTzTQM49CGB7yZ4/ZaXBBUngg7k3Hoh1Fq49YjqZ0lGVll3GlJRl6iezVvFipbv7CyFpOVS530QWUD7c69ouglGWfzIPSWE5aEnePnpj7qVjqOSrzPCL+0Xil/p9CQc0Klgz5JWc3PfSNDiHshsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB487339;
	Mon, 26 Jan 2026 04:05:24 -0800 (PST)
Received: from [10.1.32.17] (e127648.arm.com [10.1.32.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A53313F5CA;
	Mon, 26 Jan 2026 04:05:30 -0800 (PST)
Message-ID: <02693dc9-e6f7-4683-8bba-4de5e8854689@arm.com>
Date: Mon, 26 Jan 2026 12:05:28 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] cpuidle: governors: teo: Avoid selecting states
 with zero-size bins
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Doug Smythies <dsmythies@telus.net>
References: <2257365.irdbgypaU6@rafael.j.wysocki>
 <3033265.e9J7NaK4W3@rafael.j.wysocki>
 <0d066ce0-b0bf-43f2-a1c4-56e5ac47cce1@arm.com>
 <CAJZ5v0iVPDY5wvz0KY7aHJXnX=7ZCMbqi1G5mWTYdYsi2xf9+g@mail.gmail.com>
 <401cbcab-5a41-4aa2-97f8-3dccc069e836@arm.com>
 <CAJZ5v0iygK59hvYKfNy0AYXe4Nyn-kM3dnY-9ongeGWc_jZ+3Q@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0iygK59hvYKfNy0AYXe4Nyn-kM3dnY-9ongeGWc_jZ+3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41468-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 47A7D87FC1
X-Rspamd-Action: no action

On 1/26/26 11:40, Rafael J. Wysocki wrote:
> On Mon, Jan 26, 2026 at 10:18 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 1/23/26 20:46, Rafael J. Wysocki wrote:
>>> On Wed, Jan 21, 2026 at 2:10 PM Christian Loehle
>>> <christian.loehle@arm.com> wrote:
>>>>
>>>> On 1/14/26 19:44, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> If the last two enabled idle states have the same target residency which
>>>>> is at least equal to TICK_NSET, teo may select the next-to-last one even
>>>>
>>>> s/TICK_NSET/TICK_NSEC
>>>
>>> Yup, thanks!
>>>
>>>>> though the size of that state's bin is 0, which is confusing.
>>>>>
>>>>> Prevent that from happening by adding a target residency check to the
>>>>> relevant code path.
>>>>>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>>  drivers/cpuidle/governors/teo.c |   10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>> @@ -388,6 +388,15 @@ static int teo_select(struct cpuidle_dri
>>>>>                       while (min_idx < idx &&
>>>>>                              drv->states[min_idx].target_residency_ns < TICK_NSEC)
>>>>>                               min_idx++;
>>>>> +
>>>>> +                     /*
>>>>> +                      * Avoid selecting a state with a lower index, but with
>>>>> +                      * the same target residency as the current candidate
>>>>> +                      * one.
>>>>> +                      */
>>>>> +                     if (drv->states[min_idx].target_residency_ns ==
>>>>> +                                     drv->states[idx].target_residency_ns)
>>>>
>>>> We need to check that min_idx isn't disabled though, otherwise we now skip a
>>>> potential (enabled) idx==1 if min_idx==2 and min_idx is disabled.
>>>
>>> Not really because idx is the current candidate state and it is
>>> enabled.  We'll use idx if this check is true, not min_idx.
>>>
>>
>> Are you sure?
> 
> Yeah, pretty much.
> 
>> I meant initially:
>>
>>                 for (i = intercept_max_idx; i >= min_idx; i--) {
>>                         intercept_sum += cpu_data->state_bins[i].intercepts;
>>
>>                         if (dev->states_usage[i].disable)
>>                                 continue;
>>
>>                         idx = i;
>>                         if (2 * intercept_sum > idx_intercept_sum)
>>                                 break;
>>                 }
>> might skip an idx==3 if it enters with min_idx==2 (sorry, messed up the +-1 in the initial mail)
>> even though idx==3 might have the same residency as idx==2.
>> So if idx==2 is disabled we could've selected idx==3, but now won't and will go for idx==1 or
>> whatever is the next shallower enabled state.
> 
> But that's after patch [5/5] that has problems (I have a new version
> of it ready to send, will do that later today).
> 
> Look at the original 6.19-rc code and patch [1/1] by itself and you'll
> see what I mean.
> 
Duh you're right, sorry about the noise :/

