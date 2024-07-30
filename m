Return-Path: <linux-pm+bounces-11647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C85940DFD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 11:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A121C2442B
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B8019645E;
	Tue, 30 Jul 2024 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oe7ULUCa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE435194C76
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332456; cv=none; b=Bjsdzekd/rT2BsD2Nl2trTRf1Wovw20rTVPGk+XoFf27d6JheffYmTNGoqCLOozAq0TuRl5nMrowifR70mWk+dBbjJCysLK/tc5/TcA4T//Ju5FHo5pEoYAyUQ2K8ewpnKOv3GNXa9+SuLmLKZb5Jk/+dhm+nQFLTAQxoJkd9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332456; c=relaxed/simple;
	bh=N481Fef7S0N9/m+9FaoOMhDJ4evTkR6anInQLiuFzBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjDMHMsWDZjqsxZvrXkIShfBjOtQjqU4V18NI57h41PsVLPBrgao64x1ZM1O6V8NQRqHR2tJk/q7aspQArQXWKGRgWFOFqgN+6bbkXhmKkmW+o7whoGPeOcuC00uN4T14K7DexDBaXfyKIvxHJQEdnWrXHSYPND48WhBqezwo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oe7ULUCa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42819654737so19571635e9.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722332453; x=1722937253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tBl8JIQ3F/WVNou28JBRaEkXsP2yFpogw/kNje56otg=;
        b=oe7ULUCa05NNJXhuwkGFBvuIP5/smks8sLYkCBqNUIQpKfl/sGbOIE7D0AXMS9DbVk
         q6hcm1oqdqwo0zGEg9/xsC0qwEfqMwt+ytwCjUcSXF+Gt5CHH1z2tJNfnlC4rjUZ+ZWq
         Oiv06IYRXD2ospAYEMGnFLLtGH+tYuERcOUUyPiexY4v3ySkK/LV8LE9FjChfJ4bRADK
         HScHwTbXOwAvABfc4EjUOcyQj6Pj4WyytvarUJXl76ILQZIG6o45raAMCWQUX/prZdon
         hkNvO+eLS1135X1LkconO2d3o+v7hpbvAYJ+d5ZOIy0DO1DsG1pzlo8ijE4sVpy3kXUe
         wifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332453; x=1722937253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBl8JIQ3F/WVNou28JBRaEkXsP2yFpogw/kNje56otg=;
        b=tcl4nc+bbtJZRRGrEdnWn9C74ethO6Tnw/PNBNlCL4qYyonR/U1vv7gZhWQHWyySig
         tsK5/C/ei+6t8bhjHdbIEO40FR4vKRC3SBXHCj+LpVQh/EC98e1K08TvdwG4cSgec2zj
         5Anoal4bAh/YKSym0zgtnN0Ve++iBxH6WDsBdQbN0feU3qR/GUawouEFYNV/Spzt2Ohh
         mlpGG96b9WoatYPapdLEBMtaD3LGuuBfUA1XZrbFS8/5g73eIyn6xOgxi9RekoYeoaag
         Yk0RqO+eczgWKY4njxys34dChOs899FpLZF4MaF3Fi2LFmwMC9fnpY6soaLyhNGhAdS8
         SiTg==
X-Gm-Message-State: AOJu0Yx7S0j2konGD8pCAF6tZ7Q1Wlvwp1BfyqNEH/o5pY28n3Z+M6rc
	43o56B161xwu6N2QwIL87JjRVSBnFW8hT34QqgIN97FwzlSeedVH0T/32L3Cg/xmyprieOC6bFN
	V
X-Google-Smtp-Source: AGHT+IGdUMP0w0Wck6yNSvXnN37NmBjT8XRcz/ZMCWDRHV4dE5dcgvUQpwlKCIwdENIsbXBVmOJZZw==
X-Received: by 2002:a05:600c:4706:b0:425:5ec3:570b with SMTP id 5b1f17b1804b1-42811df6bf7mr64975455e9.35.1722332453008;
        Tue, 30 Jul 2024 02:40:53 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42824af5410sm11743535e9.1.2024.07.30.02.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 02:40:52 -0700 (PDT)
Message-ID: <97ece7c5-d317-452b-9045-c12940567781@linaro.org>
Date: Tue, 30 Jul 2024 11:40:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] thermal/core: Encapsulate more handle_thermal_trip
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, lukasz.luba@arm.com, quic_manafm@quicinc.com
References: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
 <20240729150259.1089814-2-daniel.lezcano@linaro.org>
 <12507467.O9o76ZdvQC@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12507467.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

On 29/07/2024 18:57, Rafael J. Wysocki wrote:
> On Monday, July 29, 2024 5:02:50 PM CEST Daniel Lezcano wrote:
>> In order to set the scene for the thresholds support which have to
>> manipulate the low and high temperature boundaries for the interrupt
>> support, we must pass the low and high value the incoming thresholds
>> routine.
>>
>> Instead of looping in the trip descriptors in
>> thermal_zone_device_update(), we move the loop in the
>> handle_thermal_trip() function and use it to set the low and high
>> values.
>>
>> As these variables can be set directly in the handle_thermal_trip(),
>> we can get rid of a descriptors loop found in the thermal_set_trips()
>> function as low and high are set in handle_thermal_trip().
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> -	for_each_trip_desc(tz, td)
>> -		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
>> +	handle_thermal_trip(tz, &way_up_list, &way_down_list, &low, &high);
>>   

[ ... ]

> Well, why not do the (untested) change below instead, which is way simpler?

Right, I did your proposed changed initially. The patch looks very 
complicated but it is just the result of the difference between the 
change above and below. It is code reorg, without functional changes 
(except two loops => one loop).

It looked to me more consistent to move the for_each_trip_desc() inside 
handle_thermal_trip() in order to:
  - encapsulate the trip code more and have one line call
  - be consistent with the thermal_threshold_handle() which is also one 
line call

If you prefer, I can split the changes, but it is extra work for little 
benefit. I pushed the changes in the git tree, the resulting code from 
these changes are:

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/thermal_core.c?h=thermal/threshold-patchset#n427

and

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/thermal_core.c?h=thermal/threshold-patchset#n600

Let me know if you prefer to do a smaller change or go forward in the 
code encapsulation

> The thermal_zone_set_trips() kerneldoc needs to be either updated or dropped
> because it is not applicable any more after this and I think it's better to
> just drop it.

Sure

> -	for_each_trip_desc(tz, td)
> +	for_each_trip_desc(tz, td) {
>   		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


