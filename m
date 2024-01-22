Return-Path: <linux-pm+bounces-2494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CCB836CB9
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 18:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A011CB269E0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2E6311B;
	Mon, 22 Jan 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="docyaTbG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A84D58D
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939431; cv=none; b=EP8WuDqMtLDrUpNJyqYLKn3YpApJaXLlV8FpnISe5WBvXIR9yk4bHYtN+lj3vrr19m+nLLMcD5Z/bYrvChKY139Xazsug1xjDwB7C/mVn7Qz3Ksb2WBRjbm6WIjIVr8PLfzJy63qbl+o3YxzYuyf9sv7+ZFFxcI9mRL6xNVlszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939431; c=relaxed/simple;
	bh=HyoM+ZYpwj5Nk/gzMMs6XaXC5IB7F464xo7VUVlVbzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETxteYPYQblvWHdVgY97QCMnTjqlKyD8GBzcEXLoT106AqO/CYvMHw8GSci9+j7SvGBDrDtLvZP9Lu1qQhQLQCX4pEVWqu3sj83N9wjuQ8z2eJsAdtrOvCYWYFtbA1wk33+OGD1/kFPajwJz3RizudJ/cIYZL4KFOuMCk3YTZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=docyaTbG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40eb2f3935eso539785e9.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 08:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705939428; x=1706544228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBHDZSNC4QBj4r9mOtBAKpoDeDWTwxL96dYkAXkUF2Y=;
        b=docyaTbGLx7KCgwC1ZMMJZxo89jvfiE+UDnsKxJycjYbKj1NPOGh26FviJpLBfMwbw
         h0/fjkmdJtUWhSrecuxbILLHek5EqZroLWQ9dhl3kC0Hm6E53LAoGbQFQe8Qab7cQNbZ
         WfO5rQY8L/KjCmu4ztDIWa1yBzsbQ+aEYgfZLNLdb86ZdAhqghm1GOQJ9fJIGJ+wh8pd
         hM2XyNivca8NsKgaDp1NUO6cRMGGzTsV1NtVnOyl96UyASQmUO2BAvgeulOIHizOTesx
         wGNlOM5v4MTfYosQpQYrRu9KmP1TYZVJY644GMld7exbHnmhUgVLGBsoOUFJRQnPmxKB
         LI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705939428; x=1706544228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBHDZSNC4QBj4r9mOtBAKpoDeDWTwxL96dYkAXkUF2Y=;
        b=a2I5fLhghSb90jfk1bGSnGtPNP1MPtc9zVci6kg2TB1MbNLLbQLy81g2toorOagWC9
         0VANdrOCemu7AhkZEY2pdq8qu2i20pzxMso/ZpPyalzbhbhjWDfd+gkpTAD3D2gjDIGm
         INI5ZrjOoefsP9YJAhlEQULB3p4G0smVTJB1FfwVL8fADxllF5f7hJyFvOmuSPZEF2iU
         K74kRmJxvuFhGfzZkfAaFoA8/LHMCrcDXghg1SMzVocvTaEPju/UeoleNsK0Qv+ftYiS
         8WcLIIwvpRrP0dFMAeyVibSLBGDFBkhIMxnHbk7oxsENNjcMIFA70GPOK4jwu0EYNBIG
         zjZw==
X-Gm-Message-State: AOJu0YypuRUL/n5h5djzGF0PaY8+vFDW9Zfw4LG8EhPySx38P17I+Oke
	qzPJUGW+mJpHknv2z7OiVOmDSOn07pWp+V1HQKQnvzHsbw2YTqMfL0l5IZsAMAPbxflUTZW83dC
	F
X-Google-Smtp-Source: AGHT+IFCiziNzsopVPmkB3svZZE0u+ncVKH4YWZZuvFK3QzISLgL4kzZx1Ve3LJomTK9S8Hpp2+Unw==
X-Received: by 2002:a05:600c:3ac3:b0:40e:a44c:bff4 with SMTP id d3-20020a05600c3ac300b0040ea44cbff4mr2200456wms.28.1705939428128;
        Mon, 22 Jan 2024 08:03:48 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n5-20020a05600c294500b0040e63226f6dsm3772421wmd.1.2024.01.22.08.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 08:03:47 -0800 (PST)
Message-ID: <152d56e7-9d98-4d7e-b3f8-d29c8dae0a8a@linaro.org>
Date: Mon, 22 Jan 2024 17:03:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] thermal/drivers/mediatek/lvts_thermal: allow early
 empty sensor slots
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-pm@vger.kernel.org
References: <20240111223020.3593558-1-nico@fluxnic.net>
 <20240111223020.3593558-9-nico@fluxnic.net>
 <9d8100dd-11a8-482f-83a1-85bfc34f1746@linaro.org>
 <3047p728-p0pp-9qs5-qnn4-95s23qo2735n@syhkavp.arg>
 <f0805135-6b4b-4691-ae97-d3f995e52e88@linaro.org>
 <36665522-1225-n119-6ns4-2n3p0086orp7@syhkavp.arg>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <36665522-1225-n119-6ns4-2n3p0086orp7@syhkavp.arg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/01/2024 16:23, Nicolas Pitre wrote:
> On Mon, 22 Jan 2024, Daniel Lezcano wrote:
> 
>>
>> Hi Nico,
>>
>> On 19/01/2024 17:53, Nicolas Pitre wrote:
>>
>> [ ... ]
>>
>>>>> +		skip = lvts_ctrl_data->skipped_sensors;
>>>>>     		lvts_sensor[i].msr = lvts_ctrl_data->mode ==
>>>>> LVTS_MSR_IMMEDIATE_MODE ?
>>>>> -			imm_regs[i] : msr_regs[i];
>>>>> +			imm_regs[i + skip] : msr_regs[i + skip];
>>>>
>>>> Overall the series look ok but this changes is hard to understand.
>>>>
>>>> Could you propose a different approach to have the resulting code easier to
>>>> understand ?
>>>
>>> I'm not sure how I could make it simpler. Maybe a comment is in order
>>> though?
>>>
>>> The sensor controller has 4 slots. Those slots are accessible either
>>> through imm_regs[<slot_number>] oe msr_regs[<slot_number>].  If, say,
>>> slot 0 is unpopulated then sensor 0 (i = 0) needs to address slot 1 (i =
>>> 0, skip = 1), sensor 1 is in slot 2 (i = 1, skip = 1), etc. Does this
>>> make sense?
>>
>> Why not keep the sensor id = slot id and declare the ones which are disabled
>> with a mask?
> 
> Then what do you do with the empty sensor 0? Do we want to present dead
> sensor IDs to users?

You can skip it somehow in lvts_ctrl_start(), right?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


