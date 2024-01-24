Return-Path: <linux-pm+bounces-2645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61F83A2D9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 08:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354811F21F2D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD7816429;
	Wed, 24 Jan 2024 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2IRNoet"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE091642B
	for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081123; cv=none; b=oDSJqSjLktsrp0699OxY56lD2KrdBSVfygtKNH+StKwowO+56x5d5fpu+IX3j4JEDsyrNO8D9DNi42IKrJC25zrPGajuhoQUKmlCmbpIRAsdXmecQCc9iTSU7LT0UUjGHfznPHx5Ce7M3mHB2xLVIvyeonqNgyY+jFlsdaU+tgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081123; c=relaxed/simple;
	bh=AIukQQBJ/4XCF8WoHZk5ydLR6nAbk7M0ObWxjTdjOes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoxwM+cwiR0f7cppy8PbdY6EOFVGAwklF7ROJk2Jcd73oOx07/SsBJ3e+M5XGfxJ42EJlBGP9mAPT56JMPr6aOxl7p4gUk/LBcTP40cc56+SlvhBb1e4lujRU52/u/JRG+xWQf8aNsVdLDS+R3SPmMO3MRmAQa/EPhstgHxW4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e2IRNoet; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so866268966b.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 23:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706081120; x=1706685920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8jrcqPgI/3vhSKgHemTJgRZzsqVydzJRui6v8D9poY=;
        b=e2IRNoetKtfZztuGrvgjwYXPvlQLeLsjSENFgIs1ffUOKEPmwVzox4Z5pqYRNAoAbu
         UC3FI9WLt/YbGyyS4wYx71KGJKFkgj8WX+m8eMpvt0P3lsAq2CT+JN/Ey+iZe/6Xi+pM
         bDWSyT2QBRYTm3WVAitx1Ys0OsSDKVUJ+yc8YKFGkQ3DYTdLMjdQZRuULdI/jGaLEtCq
         109/amc0Y01SJ1YS2jJKiPKiyxWFabPn325WDVBr83NBL2k+BcCExv/F7WO0HRtIeiRl
         M94h+HN3gEa7AHTgHrRo5ewLZ3hG0O+nJIcdmDgzB7khlySMyjQws3qnnIW+T/9Sj39N
         b5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081120; x=1706685920;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8jrcqPgI/3vhSKgHemTJgRZzsqVydzJRui6v8D9poY=;
        b=uOw+635Mis7ooCnQecqiOtdOYXGq/da1wfDhNf2FT48uBL1zwtMZc7R/TDMo7zrsKn
         y336Xpy78BteE5aXIU8DPc5duZCaNLcLOckALa3QYgw7XDztDPrWCW+osCyRvYjxOV3d
         xwi5ObrjoxhimVLXGtGHYFdvlrK868QOCZCzb8YPCQhApJfcZ/vEcxcr3+LZV2OopURs
         qRxt67AKdih+ifrBeci6QfAd9nopwKkG1wzOv29WdPUMu/xb6EjtE289SCWuaKcSwREX
         0Z6pJ3h9tGNtcARlnqGqAz4BWVJBneeU1PPp363INufAMZch7UGPe01dhciHI3xrIQGs
         werw==
X-Gm-Message-State: AOJu0YxFxRh9fMksXX/qKN2pSmsAJPWCW8QEltO1jFZ+xk1eBoGq3O1M
	K68iCoyoB5wSwJu1qnzkK5FD91/HHgw3LUn9TLowsO81cw0pmICdgJ89t8B+pZc=
X-Google-Smtp-Source: AGHT+IF2w0IOR+JXC8jt+izTDTWD09ku7STu4bgoty/Dh+g0U34bBf+smbNWdjyx6BtSeavBr7MNzw==
X-Received: by 2002:a17:906:251b:b0:a30:dd59:858e with SMTP id i27-20020a170906251b00b00a30dd59858emr680795ejb.60.1706081119968;
        Tue, 23 Jan 2024 23:25:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906c00400b00a298adde5a1sm15092803ejz.189.2024.01.23.23.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 23:25:18 -0800 (PST)
Message-ID: <71290f34-f3e6-4190-af8a-5fea61faedda@linaro.org>
Date: Wed, 24 Jan 2024 08:25:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] reset: gpio: ASoC: shared GPIO resets
Content-Language: en-US
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
 Sean Anderson <sean.anderson@seco.com>
References: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
 <6c3e4b71-c92f-4f1e-8435-b5cfb7f47117@alliedtelesis.co.nz>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6c3e4b71-c92f-4f1e-8435-b5cfb7f47117@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 20:28, Chris Packham wrote:
> 
> On 24/01/24 03:13, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> Patch #2 (cpufreq: do not open-code of_phandle_args_equal()) and patch #4
>> (reset: Instantiate reset GPIO controller for shared reset-gpios) depend on OF
>> change (patch #1).
>>
>> Changes in v4
>> =============
>> 1. New patches:
>>     of: add of_phandle_args_equal() helper
>>     cpufreq: do not open-code of_phandle_args_equal()
>>
>> 2. reset-gpio.c:
>>     - Drop unneeded comment (Bartosz), add Rb tag.
>>     - Do not assign of_node.
>>
>> 3. reset/core.c:
>>     - Implement most of Bartosz feedback (I responded to one which I did not
>>       implement) and comments from Philipp.
>>     - Expect either rcdev->of_args or rcdev->of_node.
>>     - Drop __reset_gpios_args_match() and use common helper (Philipp).
>>     - Move declarations of automatic-cleanup variables in
>>       __reset_add_reset_gpio_lookup() to place of use (Bartosz).
>>     - Separate gpio_device_get_label() and kstrdup() (Philipp).
>>     - Correct doc for __reset_add_reset_gpio_device(), rewrite few comments.
>>     - Drop unneeded "r" variable in __reset_find_rcdev() (Philipp).
>>     - Drop of_phandle_args initialization in __of_reset_control_get (Philipp).
>>     - Check if CONFIG_RESET_GPIO is enabled before trying to look up reset-gpios.
>>
>> 4. Drop Chris' patch: "i2c: muxes: pca954x: Allow sharing reset GPIO", because
>>     discussion is on going.
> 
> I actually think it would have been OK as-is with your latest change to 
> return NULL when CONFIG_RESET_GPIO is not enabled. But I'm happy to 
> submit it independently after this series lands. It'll give me a chance 
> to do a bit more testing.

Yeah, I wasn't sure if the concerns are really resolved. I think you can
send your patch separately because there is no clear dependency, so also
no clear benefits of me taking your patch into this patchset.

Best regards,
Krzysztof


