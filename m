Return-Path: <linux-pm+bounces-41588-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOhHAoOBeWmexQEAu9opvQ
	(envelope-from <linux-pm+bounces-41588-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 04:24:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED49CA2A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 04:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 522D33014114
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 03:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CA232C94D;
	Wed, 28 Jan 2026 03:24:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81B32D42D;
	Wed, 28 Jan 2026 03:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570686; cv=none; b=cwoHgnARdTRsARWhlaa5PAI9NI/PrfgWCcQJRuKzp775CQ9lOKdaKWSCJauSQbxNUAia0nDflaho93psEKnvk+UdVbG0A3cl0WooLSse5YV2uIPkn3VggjLc0hiV+EwTy1GZi6Edc95WZicBU05JScAoPO78VSH95rkRsP6bihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570686; c=relaxed/simple;
	bh=QaT7htJr+9VmJyq6NseJNsxJ2azrkBpw71yK7bius1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4KQoHISK4QnFhSMEL8kFo3OATq1ipYyLcLSG6YkGtUjFU34rgwhfmjArs381t5t1EM5Yq8NqZ64Eo2PTKmVGDPVHC2c4+K2z/JQYb6Zk6jv5us63DvrlXsuXnukbXny1nv3xyXabk0KDEj5RUS93lgtfqZ+NXfTNQyrR9GsRks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: df87dbbcfbf811f0b0f03b4cfa9209d1-20260128
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a00aa690-bf49-4cf7-a03f-fc7669119800,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:56ebb311393504d36e73f6f8b8b62f60,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: df87dbbcfbf811f0b0f03b4cfa9209d1-20260128
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1834778679; Wed, 28 Jan 2026 11:24:36 +0800
Message-ID: <c937664d-f961-4056-b8c3-f0dd3b8fe03b@kylinos.cn>
Date: Wed, 28 Jan 2026 11:24:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: intel_pstate: Disable SMT when hybrid systems
 are enabled
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260119074118.835922-1-tianyaxiong@kylinos.cn>
 <20260122155549.GA18021@ranerica-svr.sc.intel.com>
 <7cc76b59-964d-4ce2-b3c4-e1337dbe0c67@kylinos.cn>
 <CAJZ5v0ipPwmBe0bxKBJc203ug6ENzT6OEaOruyL=vUw6NWMZfQ@mail.gmail.com>
 <b9c9eb84-04a9-4a16-9a31-df8216f3460b@kylinos.cn>
 <CAJZ5v0h-Kw8WLJZO5s5NsHTdGC5gomxeXDcbRLFhFoVmm43s9A@mail.gmail.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <CAJZ5v0h-Kw8WLJZO5s5NsHTdGC5gomxeXDcbRLFhFoVmm43s9A@mail.gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
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
	TAGGED_FROM(0.00)[bounces-41588-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 68ED49CA2A
X-Rspamd-Action: no action


在 2026/1/28 00:08, Rafael J. Wysocki 写道:
> On Mon, Jan 26, 2026 at 3:15 AM Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>>
>> 在 2026/1/24 04:12, Rafael J. Wysocki 写道:
>>> On Fri, Jan 23, 2026 at 2:20 AM Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>>>> 在 2026/1/22 23:55, Ricardo Neri 写道:
>>>>> On Mon, Jan 19, 2026 at 03:41:18PM +0800, Yaxiong Tian wrote:
>>>>>> When hwp_is_hybrid && !sched_smt_active(), the driver enables
>>>>>> hybrid_capacity_scale and disables ITMT. According to the original code
>>>>>> logic, these related actions are one-time operations; therefore, I
>>>>>> believe the original design intent did not support dynamic runtime
>>>>>> switching.
>>>>>>
>>>>>> However, SMT can be toggled via related interfaces in /sys. When SMT is
>>>>>> enabled, the system is no longer hybrid, and the original settings become
>>>>>> incorrect.
>>>>> Indeed I was able to enable SMT siblings:
>>>>>
>>>>>         $ echo on > /sys/devices/system/cpu/smt
>>>>>         $ echo 1 > /sys/devices/system/cpu/cpu1/online
>>>>>
>>>>>> To resolve this confusion, permanently disable SMT by calling
>>>>>> cpuhp_smt_disable().
>>>>> IMHO, the user should be able to enable SMT back if she or he chooses to. Instead,
>>>>> the sched domains should be rebuilt with asym packing and without asymmetric
>>>>> capacity.
>>>> Yes, I also agree with this viewpoint.
>>> I don't agree though.
>>>
>>>> I think a better solution is to
>>>> place it within cpufreq online for heterogeneous judgment and to clearly
>>>> address sched domain rebuilt and asymmetry issues.
>>> Maybe in theory, but in practice the EAS-related code in intel_pstate
>>> really only targets systems with no SMT.
>>>
>>> While it is possible to use it on SMT systems with SMT disabled, I
>>> really wouldn't recommend doing that beyond debug/diagnostics and no,
>>> it is not sufficient to disable stuff when SMT is re-enabled, you'd
>>> basically need to unregister the driver and register it from scratch
>>> in that case.
>> Thank you for your explanation. It seems I didn’t read the document
>> carefully enough before.
>>
>>>> I ran some tests the
>>>> day before yesterday and encountered a few locking problems. I will
>>>> publish the patch a bit later.
>>> Given the complexity involved, I don't think it is worth the effort.
>>>
>>> I can apply this patch though.
>> Um, although I've already done it, I agree with your point.
>>
>> Besides, I don't think this patch is very suitable either, because I
>> supposethat on a n system without SMT, the SMT-related|/sys|interface
>> should indicate unsupported (though I don't have such a machine).
>>
>> Moreover, based on the previous discussion, would it be more appropriate
>> to use !cpu_smt_possible() instead of !sched_smt_active()? After all,
>> the original design was intended for systems without SMT. If you also
>> agree with this perspective, I can test it on a machine with SMT.
> Yes, please!
>
> Using cpu_smt_possible() instead of sched_smt_active() would be the
> most straightforward way to address this, provided that it works.


Okay, I've tested after making the modifications, and everything works fine.

On a machine with SMT (Simultaneous Multithreading):

 1.

    With|nosmt|added to grub, CAS and EAS are not enabled.

 2.

    With|nosmt=force|added to grub, CAS and EAS are enabled, and users
    cannot change the SMT setting.

Since I don't have access to a machine that does not support SMT, I 
analyzed the scenario for non-SMT machines. There should be no issues at 
all—when SMT is not supported, CAS and EAS will be enabled, and users 
cannot switch to SMT. If any problems arise, they likely need to be 
addressed by fixing the|cpu_smt_possible()|function.

I’ve already released the relevant patch:

  https://lore.kernel.org/all/20260128031521.389765-1-tianyaxiong@kylinos.cn/


