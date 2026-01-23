Return-Path: <linux-pm+bounces-41342-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DqkM17PcmnKpgAAu9opvQ
	(envelope-from <linux-pm+bounces-41342-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:31:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3555E6F169
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4E8231A0ACA
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 01:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94C636A01E;
	Fri, 23 Jan 2026 01:20:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3022B8CB;
	Fri, 23 Jan 2026 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131235; cv=none; b=btlspuvx7QS0T8w6EazGGcW/yCZ/zo57kBcOKiomrOII6NqB2X7Pgq0mCV0QTIlLL4vcl1F8M/vYZ6jC3EMfzrp74t3Mn2COrJsYwaQoHZfxxaJ8xyddf58SEkFXMnWEtrLWXg78g7XYWyFuGDoxl1Ecl4EPW9f/NJqEm/iJYVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131235; c=relaxed/simple;
	bh=5NWJpzAtvcHzpvXw6Xc8kvzWN7Jw0uMRNGh87CPPuJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQRpzioXXnV+z2mgSU0DoG71A64gUhazY0rzcu1ltlLWhcPIlEuKH5fLrEXS0EWnmBXNpcsgnuG+QRBnb6IgDZyjfT5TE/KjvjSRKmfPGmhOFIxcZveRcsWBXNn21dWWIWiXhF+jAlH9N1mqaqcCAHdFYo9gA4IsCEhrY4RYCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aa7ae8fef7f911f0b0f03b4cfa9209d1-20260123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7239cebf-f193-455b-bb85-eec51dc3b24c,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:7239cebf-f193-455b-bb85-eec51dc3b24c,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:c82d5eb246c5bc3aab99879673cfa022,BulkI
	D:260122234942EB5AOKR2,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa7ae8fef7f911f0b0f03b4cfa9209d1-20260123
X-User: tianyaxiong@kylinos.cn
Received: from [10.200.43.20] [(223.153.58.254)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1813399291; Fri, 23 Jan 2026 09:20:12 +0800
Message-ID: <7cc76b59-964d-4ce2-b3c4-e1337dbe0c67@kylinos.cn>
Date: Fri, 23 Jan 2026 09:20:09 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: intel_pstate: Disable SMT when hybrid systems
 are enabled
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rafael@kernel.org,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260119074118.835922-1-tianyaxiong@kylinos.cn>
 <20260122155549.GA18021@ranerica-svr.sc.intel.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260122155549.GA18021@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_NEQ_ENVFROM(0.00)[tianyaxiong@kylinos.cn,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-41342-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 3555E6F169
X-Rspamd-Action: no action


在 2026/1/22 23:55, Ricardo Neri 写道:
> On Mon, Jan 19, 2026 at 03:41:18PM +0800, Yaxiong Tian wrote:
>> When hwp_is_hybrid && !sched_smt_active(), the driver enables
>> hybrid_capacity_scale and disables ITMT. According to the original code
>> logic, these related actions are one-time operations; therefore, I
>> believe the original design intent did not support dynamic runtime
>> switching.
>>
>> However, SMT can be toggled via related interfaces in /sys. When SMT is
>> enabled, the system is no longer hybrid, and the original settings become
>> incorrect.
> Indeed I was able to enable SMT siblings:
>
> 	$ echo on > /sys/devices/system/cpu/smt
> 	$ echo 1 > /sys/devices/system/cpu/cpu1/online
>
>> To resolve this confusion, permanently disable SMT by calling
>> cpuhp_smt_disable().
> IMHO, the user should be able to enable SMT back if she or he chooses to. Instead,
> the sched domains should be rebuilt with asym packing and without asymmetric
> capacity.
Yes, I also agree with this viewpoint. I think a better solution is to 
place it within cpufreq online for heterogeneous judgment and to clearly 
address sched domain rebuilt and asymmetry issues. I ran some tests the 
day before yesterday and encountered a few locking problems. I will 
publish the patch a bit later.

