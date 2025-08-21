Return-Path: <linux-pm+bounces-32783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E0EB2F193
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 10:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90473AA2D9E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C75F2ED854;
	Thu, 21 Aug 2025 08:18:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A742EAB6B;
	Thu, 21 Aug 2025 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764288; cv=none; b=MQ1roURPAZBZ4oFInKTxZ752hRi4lvVljEYgsV/QzHDt4JHHNTiozmczqeLUQi/eTvqGwzx89Df5OjQZ32Ob2MvpmIdGK6N8DxjlrIWwd2BtdRiZKoEPNiDbVDuX9tU6aLtQKUOc2Y0cr/P5aDVmckaTyprDNmlSWeOapmSIK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764288; c=relaxed/simple;
	bh=mA0ONfpw1F+gxk+g3fGykAuqRfDBYyHXHdqHWVHe6qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FP0VbmGhDpqOjBVOKNa3hiCl28F4dfkZOK/nCrKMxH5RthpfGrXBISY7XY/OcgF6aQ/KQAt4vZy8gBNZPRw5bE6usHz4oNlYxtLFV5v0rrLTZe1kbpQAkiFFTv3a/Qwu9EnJdBf4ImFCkgLKt7MKkJDrY0CjMAGodYsnCrIWkG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 572d6b387e6711f0b29709d653e92f7d-20250821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:250f3dba-f5f6-4945-bb60-2ce1b002ba57,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ae85289acdd7b7245c8ea70d5f6ee5e5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 572d6b387e6711f0b29709d653e92f7d-20250821
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1941211202; Thu, 21 Aug 2025 16:17:55 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 96E96E008FA3;
	Thu, 21 Aug 2025 16:17:55 +0800 (CST)
X-ns-mid: postfix-68A6D633-366430551
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id CBB77E008FA2;
	Thu, 21 Aug 2025 16:17:54 +0800 (CST)
Message-ID: <5a805200-5990-4b8c-abd7-f6f8d1481d67@kylinos.cn>
Date: Thu, 21 Aug 2025 16:17:53 +0800
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
 <ffe2344d-e825-44c0-ad2b-9544b123079f@kylinos.cn>
 <20250820054759.iewwi6uvsvowc422@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250820054759.iewwi6uvsvowc422@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/20 13:47, Viresh Kumar =E5=86=99=E9=81=93:
> On 20-08-25, 13:42, Zihuan Zhang wrote:
>> You=E2=80=99re right, we didn=E2=80=99t really consider that case befo=
re.
>>
>> The interface of cpufreq_set_policy() does look a bit odd:
>>
>> - drivers using governors don=E2=80=99t really need the new_pol parame=
ter
>>
>> - while drivers using the setpolicy method don=E2=80=99t need the new_=
gov one.
> Right, one argument is _always_ unused. If we could have handled that v=
ia a
> single argument, it would have been nice.
Sounds great.
>> I guess this might be due to some historical reasons.
>>
>> The question is whether it=E2=80=99s worth modifying this function, or=
 if we should
>> just keep it as it is.
> Unless there is a better way :)

If we change cpufreq_set_policy() to only take one parameter, then we=20
would need to add extra fields into struct cpufreq_policy to hold=20
temporary values,

in order to avoid the issue where verify may return early and leave the=20
policy in a partially updated state.


So maybe it is better not to modify it.
>

