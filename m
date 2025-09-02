Return-Path: <linux-pm+bounces-33602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A842B3F4DF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 07:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C38E17E0B6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 05:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F372D5945;
	Tue,  2 Sep 2025 05:54:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E970155A4E;
	Tue,  2 Sep 2025 05:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792481; cv=none; b=SvGwGO46oeEH0lcqSqDnxcIxJIkPnjFw/nqYwV1zbIFzpVy46GnycFElKeOT9pIF7F14jnDhcPKI7EVQaYW6FLSVeWYE+tOrKdX29MVcpvjnueNls51ho5vGbwzrX4i8s93iu1tXM+MvkCnZVVjkc3H18F7Rpn/AWdNQXdNn3m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792481; c=relaxed/simple;
	bh=5k4Pf0S95BYVV6TxbTYRd0U91VaIZdGIHUN+s3ul00c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHUpmhxqwGZEoOJO4VODGyyzCofF2gb1nQ12zTgOYx+e9dyF7jiHOGCG1KJis0ofdwQQ2RlA8W1URPDXs9oR/hVUMdlDqTpLRkqu/W740jI13MX/CiCX8ymaJbKBFLw1inARmQgiucV7gDCmBBsbioAPNpsSL+cZOOAC6suCUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4c7b2d7a87c111f0b29709d653e92f7d-20250902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a776418d-9bf0-42b2-ad91-acbccc124229,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:51ae38d66cd7331b4ada42ace9655337,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4c7b2d7a87c111f0b29709d653e92f7d-20250902
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1587702374; Tue, 02 Sep 2025 13:54:33 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C2450E008FA3;
	Tue,  2 Sep 2025 13:54:32 +0800 (CST)
X-ns-mid: postfix-68B68698-70541356
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 2F0B2E008FA2;
	Tue,  2 Sep 2025 13:54:32 +0800 (CST)
Message-ID: <180ab822-16d3-4d08-974c-5f8109dc8c82@kylinos.cn>
Date: Tue, 2 Sep 2025 13:54:31 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] cpufreq: drop redundant freq_table argument in
 helpers
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
 zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
 <20250902054207.zke5xg3su2vpdob3@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250902054207.zke5xg3su2vpdob3@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/2 13:42, Viresh Kumar =E5=86=99=E9=81=93:
> On 01-09-25, 19:25, Zihuan Zhang wrote:
>> This patchset updates the cpufreq core and drivers to fully adopt
>> the new policy->freq_table approach introduced in commit
>> e0b3165ba521 ("cpufreq: add 'freq_table' in struct cpufreq_policy").
>>
>> Motivation:
>> - The frequency table is per-policy, not per-CPU, so redundant
>>    freq_table arguments in core helpers and drivers are no longer need=
ed.
>> - Removing the extra argument reduces confusion and potential mistakes=
.
>>
>> Patch details:
>>
>> 1. cpufreq: core: drop redundant freq_table argument in helpers
>>     - Remove freq_table parameters in core helper functions.
>>     - All helper functions now use policy directly.
>>
>> 2. cpufreq: drivers: remove redundant freq_table argument
>>     - Update cpufreq drivers to match the new core API.
>>     - Calls that previously passed a separate freq_table argument
>>     - No behavior changes, only API consistency.
>>
>> Zihuan Zhang (3):
>>    cpufreq: Drop redundant freq_table parameter
>>    cpufreq: sh: drop redundant freq_table argument
>>    cpufreq: virtual: drop redundant freq_table argument
> Individual patches must not break kernel compilation, but compilation
> breaks after the first patch itself in your series as you have not
> updated all the users.
>
> Merge all three into a single patch.
>
Got it. I wasn=E2=80=99t sure if core and driver changes should be split,=
 but=20
yes, merging them into a single patch is better.

