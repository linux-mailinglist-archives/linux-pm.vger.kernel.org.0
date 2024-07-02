Return-Path: <linux-pm+bounces-10319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 590549237CF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 10:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042501F22EDF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 08:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841514B97A;
	Tue,  2 Jul 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DRT4Rtqy"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF2A4963F;
	Tue,  2 Jul 2024 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908804; cv=none; b=H5surHV3sBGCmf88iTH2c6tRVQ6Pid5QShxsMvUPOHejuYMi2GnYty1nqp2Ii11luAunEhek28seE5rTOw+pjgzcJ6Hk0n1oJ0aOfRmKMs9zcSC3E8UpAaVyp6cEpWxlRxLIl+E+weDbctaoYAdekm2vTDQwelxBYncmEmIRP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908804; c=relaxed/simple;
	bh=9FwEaOQA++z+nzTFYiEdwJkSDvstWDNDDPc4AmAA/CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATYDV4WltENXvMaIex/vpzYJ+58TSyon6VDFOltPa62v3Bq988xFaIBD0sT+A+6xYuFuUWY4TgpFXdpwWT+KXn7UdfZC42pJ7oTOxRVeSKhzyQ6us9ymnr0P+lGV5kUib99XVx2yQCXg9BFXPqkzsZpYHuWUh95LzbU9krFOJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DRT4Rtqy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719908801;
	bh=9FwEaOQA++z+nzTFYiEdwJkSDvstWDNDDPc4AmAA/CM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DRT4Rtqy3WwkuWVEMML54c2TKfkvKimEiAyPGpYpqVAR8rXvTJboLUC/zfWR9B5dj
	 5696A5C3U205/koH71zlXLBYHCUdqE6aAW0GjMj58KMtO6XEKwHuHpNRbCq+EhF2hC
	 p67hBkOmq+yG7KT2QvG7hob+9evuXwqS4sqZrieOsVC9eBgmLIMXwi39CKkKxobOou
	 7XaRozvB3tEMqC5sp5LjoKg2fBRMeSXash3jFX9xv3r4ER77bO9EMNqTT4Vy4KVuQX
	 NPWYx8q+wbxLrHwQGg18RsEvaZr5xP+fwP2fFh+PG+X1cefWk4IJFTvdj0UWE8Nnht
	 uN/5ipDqGiPew==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7AF8F37820DE;
	Tue,  2 Jul 2024 08:26:40 +0000 (UTC)
Message-ID: <aa6e93bd-aba2-4e4d-bce9-04e818ac25ed@collabora.com>
Date: Tue, 2 Jul 2024 10:26:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
To: Viresh Kumar <viresh.kumar@linaro.org>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
 <20240702055703.obendyy2ykbbutrz@vireshk-i7>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240702055703.obendyy2ykbbutrz@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/07/24 07:57, Viresh Kumar ha scritto:
> On 28-06-24, 15:48, Nícolas F. R. A. Prado wrote:
>> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
>> @@ -629,11 +630,9 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>>   	int cpu, ret;
>>   
>>   	data = dev_get_platdata(&pdev->dev);
>> -	if (!data) {
>> -		dev_err(&pdev->dev,
>> -			"failed to get mtk cpufreq platform data\n");
>> -		return -ENODEV;
>> -	}
>> +	if (!data)
>> +		return dev_err_probe(&pdev->dev, -ENODEV,
> 
> What's the point of calling dev_err_probe() when we know for sure that
> the error isn't EPROBE_DEFER ?
> 

Logging consistency, that's all; the alternative would be to rewrite the dev_err()
messages to be consistent with what dev_err_probe() says, so that'd be
dev_err("error %pe: (message)");

>> +				     "failed to get mtk cpufreq platform data\n");
>>   
>>   	for_each_possible_cpu(cpu) {
>>   		info = mtk_cpu_dvfs_info_lookup(cpu);
>> @@ -643,24 +642,21 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>>   		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>>   		if (!info) {
>>   			ret = -ENOMEM;
>> +			dev_err_probe(&pdev->dev, ret, "Failed to allocate dvfs_info\n");
> 

By the way, forgot to point that out in my former review: to make it shorter,
instead of "ret = -ENOMEM; dev_err_probe()" you can write it as...

ret = dev_err_probe(&pdev->dev, -ENOMEM, ".... message");

Cheers,
Angelo

> Same here.
> 



