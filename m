Return-Path: <linux-pm+bounces-8187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5D8D0692
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 17:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D071F227C3
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE17561FDB;
	Mon, 27 May 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlCrMjwQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51317E8EC
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825012; cv=none; b=erDyqLiRlN30fzOzSkGXewfjsefgdajBYFKQgRtiMAqqlFXK4q2fMByDZRDWDdlRXDpgObCd/yhQKJrVA7zEwmavmScRKL0JT7Js4JUNne6vTLXP6KgWg/Zlb8oOvGg9IkgST7lXqpo9H4JYvAtNmp5fDQNpHK6V8kaW1WvYAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825012; c=relaxed/simple;
	bh=QEVBEBeoLu1qRUKBYjQiNumSKenUDGegDS+c+15cKuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uppgxhv4is5j7jLwRUmjOYFzL7CBrleR2R5zJqqkkQ292UAZnOswmeoqk7D0Z9i/OPwonKfvZgy6d8vguYQjk775Z1MQLfTbG9MFHMvW6f55MDLaI+UnxlGowdTMjBfaQnwOv3T0u+5IwG3ssbEf9voBtmVdsSiQYVknuP7ZOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NlCrMjwQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4201986d60aso45885355e9.3
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716825008; x=1717429808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRTFXuzZ+rWg2zq6mq+6BNpvfeAhX7RSk5XZvpGlJNY=;
        b=NlCrMjwQq5KMbFS4LmvgEVmBke5G6rQ8h0yIxUouBiEthXluSXbUIj57k2fdlom9kU
         +RDZG0Z5L3WC050QFJuicQOdSE6jMJpD+9htgt0+gD9Xf9bCXI/v+b0AYNUwfnNYBiSI
         QibXDDMYQGW0YmP2vvFsMXQXlxMNt2qXMO+pl0+Bogtfg0LfwhOX0AIACFvzkGeTrNzM
         Be89/IZzxDt7M8VaK84ci5J9eUwe5QHZl4Ur723Z4Hm3DyUPmD63SqvJrMM/KiNFmiC9
         Bk/BG60Wet0DUTXBiLZUhz7DC6cvqwqTL7RHj48Lmhv1JPibVV4392kTNcqaz4Am9fEh
         x6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716825008; x=1717429808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRTFXuzZ+rWg2zq6mq+6BNpvfeAhX7RSk5XZvpGlJNY=;
        b=YqRMRY65gQtBeVIaMKQT7rxW5jWkA6EhZp4RvMZ5LyVHlOuc/gt9uk6tj9NGHeA0rA
         vfgiDPXta7jwy3FIe3XoL1R828NfiKfWpDIB875w0lXj1qRwDD5z5apsvbTHLYDr7Xsw
         gvcqmusKVFayY6UEHPx/26dYdii+S0aODCR92fpVAWdLdxiUdx9EebhhYjX7N5/IYSq9
         WdmDp7t/j1DET/h3cORcBEBzncxmSXPpLTz5Uwn9tGFjgnmuRdMeaYs3xyGbekVjsmEC
         cgW+KU6fdOiQNuAypn0/9QG2YCkm9BioKtIKPRkta63s2Hv7Xb+i/ziNDxvHbyw/2aKV
         P/Fw==
X-Gm-Message-State: AOJu0Yx3szXOTlAJ59foBX6wjhWYN0A8Um424sDBV8yBOQazn6VHblXj
	7CMCfWlMMatksGkPhk6VcxTOIA1BI5zKEAoYo+HFVU4B7CSL1elvgXq5jnv53zRE3xXVoeHCBsJ
	CnFI=
X-Google-Smtp-Source: AGHT+IHXRGef1ol9MvY7YSEgTiE7wg0hIRGUYCN1bP2hyXZkM/8YaLQoqonMAkN25HJi5u4F8XX9yw==
X-Received: by 2002:a05:600c:6a82:b0:41b:fad8:45de with SMTP id 5b1f17b1804b1-42108a0032dmr69821095e9.30.1716825008413;
        Mon, 27 May 2024 08:50:08 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-421089707b7sm113154715e9.15.2024.05.27.08.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 08:50:08 -0700 (PDT)
Message-ID: <084eb643-f410-4e66-9561-4dcf5924dab7@linaro.org>
Date: Mon, 27 May 2024 17:50:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: powercap ABI clarification
Content-Language: en-US
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <59e5a949-ef20-4f11-a0a7-247c457f1dd3@linaro.org>
 <9c97e4f8549744b1e2464a3b632f0716514ff55c.camel@intel.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9c97e4f8549744b1e2464a3b632f0716514ff55c.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/05/2024 16:19, Zhang, Rui wrote:
> On Mon, 2024-05-27 at 14:55 +0200, Daniel Lezcano wrote:
>>
>> Hi Srinivas,
>>
>> the powercap ABI exports some constraint files. Even if I suspect
>> their
>> semantic it is not really clear how they should behave.
>>
>>         │   ├──constraint_0_name
>>         │   ├──constraint_0_power_limit_uw
>>         │   ├──constraint_0_time_window_us
>>         │   ├──constraint_1_name
>>         │   ├──constraint_1_power_limit_uw
>>         │   ├──constraint_1_time_window_us
>>
>> Are the constraints controller specific? I mean, each controller
>> defines
>> their constraints? Or is it supposed to behave the same way whatever
>> the
>> controller?
> 
> Currently we have three controllers, MSR RAPL, MMIO RAPL and TPMI RAPL.
> They are actually the same feature (RAPL) via different register
> Interfaces.
> So their behaviors are consistent.

They are consistent because they are RAPL based but there are more 
controllers, like DTPM and SCMI.

Are the constraints semantic defined or is it up to the backend to 
decide the behavior ?

>> Is the time window giving the duration of the power_limit_uw
>> constraint?
>> Or is it an average power during this time window?
> 
> The average power during this time window.
> The constraint is always effective after we set it.

Thanks for confirming.

>> What is the purpose of min|max_time_window_us?
> 
> It is the upper/lower limit for users to set a meaningful time window.

I'm not sure to get it.

For example, on my laptop, there is:

constraint_0_max_power_uw = 15000000
constraint_0_power_limit_uw = 200000000
constraint_0_time_windows_us = 31981569
constraint_0_name = long_term

There is no constraint_0_max_time_window_us

How to interpret this constraint 0 ?

What means "long_term" ?

Is it possible to give an example ?


>> Can we set several constraints or are they mutually exclusive?
> 
> My understanding is that they can both take effect.
> "Two power limits can be specified, corresponding to time windows of
> different sizes. Each power limit provides inde-
> pendent clamping control that would permit the processor cores to go
> below OS-requested state to meet the power
> limits."
> 
>>
>> Is there any documentation describing with more details the ABIs?
>>
> Interesting, I just found this one,
> Documentation/ABI/testing/sysfs-class-powercap, should we move it to
> stable? Other than that, I don't know.

Yes, I've seen this documentation but it does not really help. It 
describes the ABI but fails to give some details. May I refer to the 
RAPL documentation to understand the powercap framework ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


