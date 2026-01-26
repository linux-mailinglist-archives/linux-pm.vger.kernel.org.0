Return-Path: <linux-pm+bounces-41444-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAFNCzrOdmktWwEAu9opvQ
	(envelope-from <linux-pm+bounces-41444-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 03:15:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA283786
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 03:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33361300423B
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 02:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830DD271457;
	Mon, 26 Jan 2026 02:15:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1591EB5CE;
	Mon, 26 Jan 2026 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769393719; cv=none; b=gXW0ZFHLp5uiSdvJx2b/44roq02Plp29NXuq9CTC1WVStZJoCyU/jhzGMWxNvaV8v0jAQE7Sik7VCsIjCFd1Ao2a+OwkgzlJl6/n6JRdpEygWETadOMDidq29qusr4aHeXJxJ9T0JUMpM8HeWFKyT+0FlMDO59AREGTbC5GBwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769393719; c=relaxed/simple;
	bh=2xonHilkglJLDpJtl+zt0s9P4O9/Ufhle9VG7FlFWPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxwO9lhjLWAxVuQgyAUTZYng+1GWJY27+RCubQF2eV5bb46bLRJAUmCtR7Dn/17+ADhyDRrXzJ8rIOKReWbLD7Q6qOb96x4D3AZkcMpEcG8PiVWfsW1l5JgNKqsHzvOxW0UWio1Wr9AcaSgPGiilx05mxDpKc6g0r5cqXe/W5Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d8050ef2fa5c11f0b0f03b4cfa9209d1-20260126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c0f6efe4-0e63-43ae-ac9e-67f3ae7f1642,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:7e547d82792cc2dc309ead04742bf7ae,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d8050ef2fa5c11f0b0f03b4cfa9209d1-20260126
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1287277219; Mon, 26 Jan 2026 10:15:11 +0800
Message-ID: <b9c9eb84-04a9-4a16-9a31-df8216f3460b@kylinos.cn>
Date: Mon, 26 Jan 2026 10:15:09 +0800
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
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <CAJZ5v0ipPwmBe0bxKBJc203ug6ENzT6OEaOruyL=vUw6NWMZfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_NEQ_ENVFROM(0.00)[tianyaxiong@kylinos.cn,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-41444-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 7DAA283786
X-Rspamd-Action: no action


在 2026/1/24 04:12, Rafael J. Wysocki 写道:
> On Fri, Jan 23, 2026 at 2:20 AM Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>>
>> 在 2026/1/22 23:55, Ricardo Neri 写道:
>>> On Mon, Jan 19, 2026 at 03:41:18PM +0800, Yaxiong Tian wrote:
>>>> When hwp_is_hybrid && !sched_smt_active(), the driver enables
>>>> hybrid_capacity_scale and disables ITMT. According to the original code
>>>> logic, these related actions are one-time operations; therefore, I
>>>> believe the original design intent did not support dynamic runtime
>>>> switching.
>>>>
>>>> However, SMT can be toggled via related interfaces in /sys. When SMT is
>>>> enabled, the system is no longer hybrid, and the original settings become
>>>> incorrect.
>>> Indeed I was able to enable SMT siblings:
>>>
>>>        $ echo on > /sys/devices/system/cpu/smt
>>>        $ echo 1 > /sys/devices/system/cpu/cpu1/online
>>>
>>>> To resolve this confusion, permanently disable SMT by calling
>>>> cpuhp_smt_disable().
>>> IMHO, the user should be able to enable SMT back if she or he chooses to. Instead,
>>> the sched domains should be rebuilt with asym packing and without asymmetric
>>> capacity.
>> Yes, I also agree with this viewpoint.
> I don't agree though.
>
>> I think a better solution is to
>> place it within cpufreq online for heterogeneous judgment and to clearly
>> address sched domain rebuilt and asymmetry issues.
> Maybe in theory, but in practice the EAS-related code in intel_pstate
> really only targets systems with no SMT.
>
> While it is possible to use it on SMT systems with SMT disabled, I
> really wouldn't recommend doing that beyond debug/diagnostics and no,
> it is not sufficient to disable stuff when SMT is re-enabled, you'd
> basically need to unregister the driver and register it from scratch
> in that case.
Thank you for your explanation. It seems I didn’t read the document 
carefully enough before.

>
>> I ran some tests the
>> day before yesterday and encountered a few locking problems. I will
>> publish the patch a bit later.
> Given the complexity involved, I don't think it is worth the effort.
>
> I can apply this patch though.

Um, although I've already done it, I agree with your point.

Besides, I don't think this patch is very suitable either, because I 
supposethat on a n system without SMT, the SMT-related|/sys|interface 
should indicate unsupported (though I don't have such a machine).

Moreover, based on the previous discussion, would it be more appropriate 
to use !cpu_smt_possible() instead of !sched_smt_active()? After all, 
the original design was intended for systems without SMT. If you also 
agree with this perspective, I can test it on a machine with SMT.




