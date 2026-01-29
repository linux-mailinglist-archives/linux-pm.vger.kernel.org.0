Return-Path: <linux-pm+bounces-41663-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GzFOsW3emmo9gEAu9opvQ
	(envelope-from <linux-pm+bounces-41663-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 02:28:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49053AABFA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 02:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52D0C3064933
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 01:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4810A3370FF;
	Thu, 29 Jan 2026 01:21:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A709331A53;
	Thu, 29 Jan 2026 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649704; cv=none; b=PX8TwH+3iEWd6yumEefzJ5JyeESw4Z9it61vdwTKoEsg5oBQN9VYwDVMaOwRV9GVLkah7U8ke+NqSn7n5qhc0Auov0aBmPxDspwwUkqcgU3C+nR+V5aqlJKk9AhtxcnnKUoDZNHtug5jtBIXFVnJm/PIda0R53IibaBULqjU3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649704; c=relaxed/simple;
	bh=O6A0/fKaEF2zJtOtRw1Iv45SbfdspD4XHGsK4RQkoPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQfCwIvRieGCWPKZt+XOmWXUTCkPBKXzAPUXJ5oo3O/Zx6ByHr4exiUi99WA0jVzvStvL6oLVayuqQqitOLiFEHfBZ8mi/Oky64KdfoMFaRVgXFy1abZj+xv7AW0eOecN/Y20DGkNfRhTdTqPZetXKzZ5dqweK5zJOoaulbR5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d9954538fcb011f0b0f03b4cfa9209d1-20260129
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b6a432e9-2c91-4b01-8afb-eb2c3b8be0a2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:90950a44424b4f0cc98c464794b1aebd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d9954538fcb011f0b0f03b4cfa9209d1-20260129
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1457484038; Thu, 29 Jan 2026 09:21:34 +0800
Message-ID: <2fe6e22c-aa8d-4514-9f10-91265facedd4@kylinos.cn>
Date: Thu, 29 Jan 2026 09:21:31 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: intel_pstate: Enable asym capacity only when cpu
 smt is not possible
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
 viresh.kumar@linaro.org, ricardo.neri-calderon@linux.intel.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260128031521.389765-1-tianyaxiong@kylinos.cn>
 <CAJZ5v0g8xM62_882WP8__x_RjCN_yeLUg=itXVTXsL=0T_mUsw@mail.gmail.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <CAJZ5v0g8xM62_882WP8__x_RjCN_yeLUg=itXVTXsL=0T_mUsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_NEQ_ENVFROM(0.00)[tianyaxiong@kylinos.cn,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-41663-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 49053AABFA
X-Rspamd-Action: no action


在 2026/1/29 05:21, Rafael J. Wysocki 写道:
> On Wed, Jan 28, 2026 at 4:15 AM Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>> According to the description in the intel_pstate.rst documentation,
>> Capacity-Aware Scheduling and Energy-Aware Scheduling are only
>> supported on a hybrid processor without SMT. Previously, the system
>> used sched_smt_active() for judgment, which is not a strict condition
>> because users can switch it on or off via /sys at any time.
>>
>> This could lead to incorrect driver settings in certain scenarios.
>>   For example, on a CPU that supports SMT, a user can disable SMT
>> via the nosmt parameter to enable asym capacity, and then re-enable
>> SMT via /sys. In such cases, some settings in the driver would no
>> longer be correct.
>>
>> To address this issue, replace sched_smt_active() with cpu_smt_possible(),
>> and only enable asym capacity when cpu smt is not possible.
>>
>> Fixes: 929ebc93ccaa ("cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems")
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   drivers/cpufreq/intel_pstate.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index ec4abe374573..8105c41861a3 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -1142,8 +1142,11 @@ static void hybrid_refresh_cpu_capacity_scaling(void)
>>
>>   static void hybrid_init_cpu_capacity_scaling(bool refresh)
>>   {
>> -       /* Bail out if enabling capacity-aware scheduling is prohibited. */
>> -       if (no_cas)
>> +       /*
>> +        * Bail out if capacity-aware scheduling is prohibited, or if SMT is
>> +        * possible, as the capacity of SMT threads cannot be determined reliably.
>> +        */
>> +       if (no_cas || cpu_smt_possible())
>>                  return;
>>
>>          /*
>> @@ -1156,12 +1159,8 @@ static void hybrid_init_cpu_capacity_scaling(bool refresh)
>>                  return;
>>          }
>>
>> -       /*
>> -        * On hybrid systems, use asym capacity instead of ITMT, but because
>> -        * the capacity of SMT threads is not deterministic even approximately,
>> -        * do not do that when SMT is in use.
>> -        */
>> -       if (hwp_is_hybrid && !sched_smt_active() && arch_enable_hybrid_capacity_scale()) {
> Why don't you replace sched_smt_active() here with cpu_smt_possible()?
>
> There's no point calling arch_enable_hybrid_capacity_scale() if the
> latter is true.
Because I think cpu_smt_possible() becomes fixed after kernel startup. 
Placing this check earlier can also prevent calling 
arch_enable_hybrid_capacity_scale(). Additionally, when users switch the 
cpufreq driver via /sys/devices/system/cpu/intel_pstate/status, it's 
unnecessary to proceed with further checks.
>> +       /* On hybrid systems, use asym capacity instead of ITMT */
>> +       if (hwp_is_hybrid && arch_enable_hybrid_capacity_scale()) {
>>                  hybrid_refresh_cpu_capacity_scaling();
>>                  /*
>>                   * Disabling ITMT causes sched domains to be rebuilt to disable asym
>> --

