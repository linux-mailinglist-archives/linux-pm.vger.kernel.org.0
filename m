Return-Path: <linux-pm+bounces-41227-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIg8LqTFcGkNZwAAu9opvQ
	(envelope-from <linux-pm+bounces-41227-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:25:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 540D756B6D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F8194C70A9
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A8647A0C3;
	Wed, 21 Jan 2026 12:22:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02C45105A;
	Wed, 21 Jan 2026 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998152; cv=none; b=AS4bowQM43odL5VUllhwybjmL6sutKMy0tsWeyNcrasFWsktSkYQ0laPyY3mWs5h77Bc958ETD/HGwy0yuVGHnbSahFM6jEHuRksi+5LnOs55feRpZKdHQoMZIHRWs+j05xWivBRKBlZu2iRUPAZ3xRn+b73Jw2S4p5y8TipceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998152; c=relaxed/simple;
	bh=LxUmvxsnpcwSlSn7ItM6ojZF/+ZFwsB85f0eYFRld2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e22KqhHeD1iLyV9tqHC9Hka92cPesGe3yTo5INcBEKbZIZO0W1q3PjnpnWswvmd24hh8uhkDkQ7nzggbKFHIIQZv0f5HJJoiPHOYxik60EHW4Dud079k0Ih6RMv0ZL4ZPLbStKeNgMjkcJd1mLvUO19DvjTuwyRS/7EhzVfxeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74B471476;
	Wed, 21 Jan 2026 04:22:22 -0800 (PST)
Received: from [10.57.6.84] (unknown [10.57.6.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 415A93F740;
	Wed, 21 Jan 2026 04:22:28 -0800 (PST)
Message-ID: <50460dd0-1ed3-4976-ad9d-d9111c0147b8@arm.com>
Date: Wed, 21 Jan 2026 12:22:30 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: Fix NULL pointer dereference in em_create_pd()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Malaya Kumar Rout <mrout@redhat.com>
Cc: malayarout91@gmail.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260115103700.177997-1-mrout@redhat.com>
 <CAJZ5v0iB2fqiab2Uj7Et_+qztx208cFKHuS7e_Y9ATmgr09jyw@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iB2fqiab2Uj7Et_+qztx208cFKHuS7e_Y9ATmgr09jyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-41227-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.luba@arm.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,arm.com:mid]
X-Rspamd-Queue-Id: 540D756B6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/15/26 20:30, Rafael J. Wysocki wrote:
> On Thu, Jan 15, 2026 at 11:37 AM Malaya Kumar Rout <mrout@redhat.com> wrote:
>>
>> The get_cpu_device() function can return NULL if the CPU device is
>> not registered. However, the code in em_create_pd() dereferences the
>> returned pointer without checking for NULL, which can lead to a kernel
>> panic during energy model initialization.
>>
>> Add a NULL check before dereferencing cpu_dev. If get_cpu_device()
>> returns NULL, return -ENODEV and properly clean up allocated resources
>> through the existing error path.
>>
>> This issue was found by code inspection. The same function is correctly
>> handled with NULL checking in em_cpu_get() at line 555-557.
>>
>> Fixes: 1bc138c62295 ("PM / EM: add support for other devices than CPUs in Energy Model")
>> Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
>> ---
>>   kernel/power/energy_model.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 11af9f64aa82..3971743d7e67 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -466,6 +466,10 @@ static int em_create_pd(struct device *dev, int nr_states,
>>          if (_is_cpu_device(dev))
>>                  for_each_cpu(cpu, cpus) {
>>                          cpu_dev = get_cpu_device(cpu);
>> +                       if (!cpu_dev) {
>> +                               ret = -ENODEV;
>> +                               goto free_pd_table;
> 
> No, you need to clear em_pd for the CPUs for which it has been set already.
> 
> Maybe it would be better to do this check upfront for all CPUs in the
> mask.  Lukasz?
> 

Right, let me study this and come back with the recommendation...


