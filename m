Return-Path: <linux-pm+bounces-12357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EF29548A9
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 14:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97A11C22612
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91561B32AA;
	Fri, 16 Aug 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcD8lH/0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911F13AA2B
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810922; cv=none; b=HI2AEgno7fRt9LhvBoabEDyklDxYootE5Ow9bgT+MXvhZkrN28wdxS52n42//q4jlWVCbBxOlXLM9sNrpc2a5xSKFCUvgXMhMMLaqUCs03+eUZKknweKnKMxN6i5DeT7dbxJUAX1CME0rgYy01kmtffseGTFzLRNH8D13o1BJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810922; c=relaxed/simple;
	bh=1dqD0dtTcUNg9RO7E2uwpZIgtvaNNmK0XfxDHrpuWTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnLQUTGWaVNm38qcnC8E8NvmdNV9kcBJ8MSs8x4MAEQHXf5WNWDoUJlqIlr2KFwfogrN4rmC/1SMyLDwf7J+/ycsUJkWhk/ZWMc4HrzHYQOvjOs6PFXCMOCxG5IZRw12HmdrRG2lDOJaoC22X5LCU8meIRKN3rwLFwFhACivGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rcD8lH/0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so14996685e9.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 05:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723810918; x=1724415718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fjFP4C61WocPjkajJuVaho6oIV1iErl+yoVXsVqET1o=;
        b=rcD8lH/0EPsGRx3N7yPJSecWnVbtKV5txVVbgm9GSV6dCvmH+ZIpuTtRau3pqh/f1r
         D3iatIQiGtOLoQlmPXygPvBRhowo9o4U9h40idE0iw3lVshxjH365eOm0zy5QYpgL2Y3
         9bo7eUpAUQRvOI8XiMP4pHKvEPrtOGh9LMdEF4JvYket1iaqOAmcieJWdHdjhu1k1hgh
         2XqzG57wps43nJdxrZ1fkOlZevgl+8J6skEkuC1RpE2ui+arcKxvCeQQgUQtgwwH5G3C
         tFRIhTgo8phKsHuTDGSdxdyF2psJvJB/78IPie7tezU77JEfDcWhxDD2qbMpaQUmxhqb
         CH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723810918; x=1724415718;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjFP4C61WocPjkajJuVaho6oIV1iErl+yoVXsVqET1o=;
        b=LisMusjRGAkNsUc9yz9gL+imq+Xnpd7dqx3ygfzCRmNRCRZGomfU3yriF6pjJcmf7G
         IVScA905xxbUFkwTuBsgu9TiuwmBn8xYhe62bj4IKydWnYxWfYdbMH9xjb+PV+rZhpyZ
         mbvtaZ94vQwLQKJ1HSVLoVLBF+nMLE4D8K0KjS2fNDUnQI9SqGM9OdC4kjvXl4IL4BcJ
         XqNDaqmlZE9QuxsAIAmBaMgoBLMYFlAGnLPmvzFcyjzN47DXJ2Hm6dhsWaozAo3OV8wf
         c9NTQSKJ7WD+t9bhu3OnOtf4l5nJ/RkqtKjVSgG/OYtblL39xGXDNSWv4+4MktainA+z
         msmg==
X-Forwarded-Encrypted: i=1; AJvYcCXojRhhPUpk/kNWPqbuDyfPipRRpDSlPe8bTLPPP8Gh29oq3foASXHERaFGEqa4VECIbCbEI0l6Rns6oQyHhnI+6/uhkVi536E=
X-Gm-Message-State: AOJu0YzK1SCE4jI4avgF3iUhsM1bY7HH/7CSEuHKBjlk8OVhu0q1NMHq
	5O6Ee6KW97BRmHLybh/D68V5A4Q7gGLvP03HL5CFzfDWRiilfaI9T30JyTAYIoU=
X-Google-Smtp-Source: AGHT+IE2TLLs/9Zl6ejokD58XO7erF76l7ktGamO60Z5JhzKy25TCvycKd91UaHRAfCQqDkf3zYh1A==
X-Received: by 2002:a05:600c:3547:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-429ed7da283mr18773555e9.31.1723810917679;
        Fri, 16 Aug 2024 05:21:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm75064915e9.21.2024.08.16.05.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 05:21:57 -0700 (PDT)
Message-ID: <3b33d0b0-ae9f-4afe-af2f-9596394bcc4f@linaro.org>
Date: Fri, 16 Aug 2024 14:21:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] thermal: of: Simplify
 thermal_of_for_each_cooling_maps() with scoped for each OF child loop
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>
References: <20240816-b4-cleanup-h-of-node-put-thermal-v2-0-cee9fc490478@linaro.org>
 <20240816-b4-cleanup-h-of-node-put-thermal-v2-4-cee9fc490478@linaro.org>
 <CAJZ5v0j9WTzd5qg3bLLB6Y41xu1zoJMy7TV1xhFxEzW-x=b5=w@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAJZ5v0j9WTzd5qg3bLLB6Y41xu1zoJMy7TV1xhFxEzW-x=b5=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/08/2024 13:30, Rafael J. Wysocki wrote:
> On Fri, Aug 16, 2024 at 9:40 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Use scoped for_each_child_of_node_scoped() when iterating over device
>> nodes to make code a bit simpler.
>>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/thermal/thermal_of.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>> index 94cc077ab3a1..ce398fde48bb 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -373,7 +373,7 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
>>                                             int (*action)(struct device_node *, int, int,
>>                                                           struct thermal_zone_device *, struct thermal_cooling_device *))
>>  {
>> -       struct device_node *tz_np, *cm_np, *child;
>> +       struct device_node *tz_np, *cm_np;
>>         int ret = 0;
>>
>>         tz_np = thermal_of_zone_get_by_name(tz);
>> @@ -386,12 +386,10 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
>>         if (!cm_np)
>>                 goto out;
>>
>> -       for_each_child_of_node(cm_np, child) {
>> +       for_each_child_of_node_scoped(cm_np, child) {
>>                 ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
>> -               if (ret) {
>> -                       of_node_put(child);
>> +               if (ret)
>>                         break;
>> -               }
>>         }
>>
>>         of_node_put(cm_np);
>>
>> --
> 
> This clashes with
> 
> https://lore.kernel.org/linux-pm/1758256.QkHrqEjB74@rjwysocki.net/
> 
> which I would prefer to go in first if you don't mind.

My other patchset which fixes bugs here, could go in before:
https://lore.kernel.org/all/20240814195823.437597-1-krzysztof.kozlowski@linaro.org/

so it will be backported. Other than that, I am fine with rebasing my
changes. There is no point in refactoring the code if it is being
removed/reshuffled :)

Best regards,
Krzysztof


