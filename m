Return-Path: <linux-pm+bounces-32675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992F8B2D3BA
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 07:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A7416D104
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 05:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F5829B8C7;
	Wed, 20 Aug 2025 05:42:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D221C18E;
	Wed, 20 Aug 2025 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668555; cv=none; b=UmQBNd28PxrgLkwCPeOrh9AxCR4Y3kDrXAaad3Y2fqsdxr/QJTC8eLsdgGPULA11kqB8Z8petq1AzLBFlbrSCHC0RDPsTWxcv4gQH1Vcgyl1G2n26sNWctQDvmXAOX9RspxKE2mKKwipRPRN935R1U1KgLxyAdqJVcvyUCokB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668555; c=relaxed/simple;
	bh=ebvnygw/n9riSKGs3brN0qOEfvzkCQbrCSPg8SWnUQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fr95VHDLIy9lIJfl14hPlscBhF4U6wW5MkniTl2UcTbZNOR5yMSIs05zLBzJK8kbTYb3v4jAnxen6jjqD148p5YZ+VWp9hP8ptVy/3gdeWiju6l/ahcWUrTnRnP/DZXfCM363a1KZZ8FP9ja8puCNRLZ/W5rlSY+41GZN1L2RBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 723da54e7d8811f0b29709d653e92f7d-20250820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1eff894f-f567-4815-9398-2176bde908bd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b53c3dcd636209bd0edfe60b3616c205,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 723da54e7d8811f0b29709d653e92f7d-20250820
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1968329055; Wed, 20 Aug 2025 13:42:23 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1D8CDE008FA3;
	Wed, 20 Aug 2025 13:42:23 +0800 (CST)
X-ns-mid: postfix-68A5603F-3015255
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 77B49E008FA2;
	Wed, 20 Aug 2025 13:42:21 +0800 (CST)
Message-ID: <ffe2344d-e825-44c0-ad2b-9544b123079f@kylinos.cn>
Date: Wed, 20 Aug 2025 13:42:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq: simplify cpufreq_set_policy() interface
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
 zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250819103940.342774-1-zhangzihuan@kylinos.cn>
 <20250819103940.342774-3-zhangzihuan@kylinos.cn>
 <20250819105925.34o5f5attd5rboh7@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250819105925.34o5f5attd5rboh7@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/19 18:59, Viresh Kumar =E5=86=99=E9=81=93:
> On 19-08-25, 18:39, Zihuan Zhang wrote:
>>   static int cpufreq_set_policy(struct cpufreq_policy *policy,
>> -			      struct cpufreq_governor *new_gov,
>> -			      unsigned int new_pol);
>> +			      struct cpufreq_governor *new_gov);
> A driver will either support the policy or the governor. If we are
> keeping `new_gov` around, I don't see why `new_pol` should be dropped.

Thanks for the reminder.

If we remove new_pol, then new_gov should indeed be removed as well.

> And changing the policy for a `setpolicy` driver should happen from
> within cpufreq_set_policy() instead of the caller. Also there is at
> least one case (verify()) where we may end up returning early, before
> changing the policy.
>
You=E2=80=99re right, we didn=E2=80=99t really consider that case before.

The interface of cpufreq_set_policy() does look a bit odd:

- drivers using governors don=E2=80=99t really need the new_pol parameter

- while drivers using the setpolicy method don=E2=80=99t need the new_gov=
 one.


I guess this might be due to some historical reasons.

The question is whether it=E2=80=99s worth modifying this function, or if=
 we=20
should just keep it as it is.


