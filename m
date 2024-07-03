Return-Path: <linux-pm+bounces-10544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8CD9260B9
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 14:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4CD28A664
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71513178360;
	Wed,  3 Jul 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vpyTAyzV"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9A13DDA6;
	Wed,  3 Jul 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010632; cv=none; b=MxpnoJXG+XDBqjmndN4EWyJF0qYE2KkdkkaY8nuWnSzIt7ZmfX8CgMOsTHtTzlEaVLuTCXA8hRh8OwlF1+FT7AjzvD9oFRP03y/22bANCh4Y9qyg4S7U8BMVaZnspdqmkR7zSjcaNZlsyzg4bs55bc3e2y3eLhpLt+Oc8XoDDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010632; c=relaxed/simple;
	bh=0hT2eBMLYcPqqROd/WvlLs1uHHji+IItZ+Y2HiWD7EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjKGfOoGAqTE5kMIfG0FqsTnLE3+gE6VVsOZfMmVnhGQ2HqGrSdA5WNTKgrouuzmUg44XB388xQbKRW2V+rMjo0BB8U6uUoviwHWsKL6pRt4bSttsATYqjN4fwvXlHSfxMzAFZuGBep4M2PLYsnUd6dX7imj/oEaHOgHEUZ3LvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vpyTAyzV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720010628;
	bh=0hT2eBMLYcPqqROd/WvlLs1uHHji+IItZ+Y2HiWD7EM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vpyTAyzVvZcXrUQDu55aZ5lWuhGpW4uijv+sbPSaeqbGMwwYeACv6KaoKv44HEczt
	 tKg9kZqp9at06MUQRiA7+7+nUPD9AwqNmxuswUc68pbX8U/1TiTupFCy71pNaj945s
	 5GjaYwEd8wespQXynvZIK4dWHkvo1v5Cj0++oeqzzIaQzk++MRJyY3rlhsvrv7PIrE
	 5fSDUkn02A6mpQlSpq8iYjEkM8xlHXkPzY4eoNwfoZ1yKpt8oTiz/eSz8mftCURTyZ
	 bfdsV21R+sU1G2WDiCshZ2HM3OuwAYyNJ8UVHU37P3AhNuEZxhYznhSnkePA9o2oEA
	 RzKGz4GXBe9KQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 532DA3782194;
	Wed,  3 Jul 2024 12:43:48 +0000 (UTC)
Message-ID: <d6994f56-57dc-4a66-ad7d-1daa04788b22@collabora.com>
Date: Wed, 3 Jul 2024 14:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
 <20240702055703.obendyy2ykbbutrz@vireshk-i7>
 <aa6e93bd-aba2-4e4d-bce9-04e818ac25ed@collabora.com>
 <20240702084307.wwvl5dchxa4frif3@vireshk-i7>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240702084307.wwvl5dchxa4frif3@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/07/24 10:43, Viresh Kumar ha scritto:
> On 02-07-24, 10:26, AngeloGioacchino Del Regno wrote:
>> Il 02/07/24 07:57, Viresh Kumar ha scritto:
>>> On 28-06-24, 15:48, Nícolas F. R. A. Prado wrote:
>>>> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
>>>> @@ -629,11 +630,9 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>>>>    	int cpu, ret;
>>>>    	data = dev_get_platdata(&pdev->dev);
>>>> -	if (!data) {
>>>> -		dev_err(&pdev->dev,
>>>> -			"failed to get mtk cpufreq platform data\n");
>>>> -		return -ENODEV;
>>>> -	}
>>>> +	if (!data)
>>>> +		return dev_err_probe(&pdev->dev, -ENODEV,
>>>
>>> What's the point of calling dev_err_probe() when we know for sure that
>>> the error isn't EPROBE_DEFER ?
>>>
>>
>> Logging consistency, that's all; the alternative would be to rewrite the dev_err()
>> messages to be consistent with what dev_err_probe() says, so that'd be
>> dev_err("error %pe: (message)");
> 
> That would be better I guess. There is no point adding inefficient
> code.
> 
>>>> +				     "failed to get mtk cpufreq platform data\n");
>>>>    	for_each_possible_cpu(cpu) {
>>>>    		info = mtk_cpu_dvfs_info_lookup(cpu);
>>>> @@ -643,24 +642,21 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>>>>    		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>>>>    		if (!info) {
>>>>    			ret = -ENOMEM;
>>>> +			dev_err_probe(&pdev->dev, ret, "Failed to allocate dvfs_info\n");
>>>
>>
>> By the way, forgot to point that out in my former review: to make it shorter,
>> instead of "ret = -ENOMEM; dev_err_probe()" you can write it as...
>>
>> ret = dev_err_probe(&pdev->dev, -ENOMEM, ".... message");
> 
> `ret` will be  be used I guess with the `goto` statement to return
> error and so the change was like this.
> 

Yes it will, but `ret = dev_err_probe(dev, -ENOMEM, "...")` is still kind of a
shortcut, as that will effectively assign -ENOMEM to ret, so that the error is
still returned like before ;-)

Cheers

