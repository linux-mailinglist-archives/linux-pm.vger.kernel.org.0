Return-Path: <linux-pm+bounces-22322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C16A3A646
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86011188BB3A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E47280A3A;
	Tue, 18 Feb 2025 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ot2Z+cxe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E6E26FA77
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904670; cv=none; b=dNPyH7cki/HRdLA42vYXsebh9DNVtnzusJoOGJX5fiCDQViis4IN6bf8mW1zEsy2M7pTBU19MUkE4QPbSJn7sd89PB5cPq13n8b9EiNDHa2SMP1yMtqzNqawb6nV1KAx4fK5IVxf13CYfN0XIQaimRVBPy2FgCf3hxGjB2kuR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904670; c=relaxed/simple;
	bh=MoO/m337yGrtN/rDuUa+yPCfHoVc7loFFqayxFZslPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aveUNP6vFvpV2bZJFzbJDiE9bM5U+fc7TaxCASIFlAeMyMc2LivUX4ArfEIPIfR6WCn/T3f83P0t5/iJ3MGZI3WgmbI21NI6arQxfodgrfvPE8P0gf8faCOXR8TatdRw5addQKWFe85pMMmjiCb1mCugLFKXUXR09Dgwr2XbJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ot2Z+cxe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso65403925e9.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 10:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739904667; x=1740509467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2kLFupIIGJ1/RHSRRNvz/y3ILtkw1UuLgcN/irDm3o=;
        b=Ot2Z+cxe2KPTWucxmt9j5VoLNgsLicyCTipf+BIfC/4vRWQV9X7spfF8A9G9qLez2K
         x3SoKf+BWNdIWLENBXTu/LK6bJKb6w3pVXyU206iFtyl4vLde9wKLKMly2zjLVi03O72
         voAIjx7hJGIenJLEvs/2e5xcnOsjlFsqZVngj3pU+1spSsavKwBBNFTxCG/Sd0Hm9gG/
         ZyxfmV3u2YyPtD2gOKxl6t5M2usxAKyElt7x/cCHcTw8CkYYhhnFn1ZT8qG7tiwumrED
         PRI5+qDW8ps6IYKoNpg06P4lp8Dr8wbT7YeSr/n3esLeS+BjGYsGzQp+bxmtzqNODBp2
         9g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739904667; x=1740509467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2kLFupIIGJ1/RHSRRNvz/y3ILtkw1UuLgcN/irDm3o=;
        b=f6PMqAi43oxJXDIlrtl9nPGTDMbc45tkf8O+auqgHoXBAYzwxkEEd9RUQdfgYWgADf
         XnmCtUgYJUG7F5g8yjQ+OCwvCNnMtUyQpEvfE3ZcnoJcsIA/Lgx1VBWV6XM7Ly7VURLi
         20v69qpelpGbl94b9kWhoHyoGsMXZDhvOKolLlDvhwNEQ3QrOyxb1V2zqPsxyZ6Vv9+B
         Uh1hgWjzx8fyQmtnlm1hzUC5dV5Mckw/BHwLfq7f0eEFYDPQUF3pytmbbQZp9G8r8Ixi
         pE/mwVQKjCHVSuftheYyb6+UKtzB5b6g82CIZxNyFRvnKVlCTZbMa9BPnAMp50v7VYoB
         AlFw==
X-Forwarded-Encrypted: i=1; AJvYcCVm96yO/TKMuvCjVjmHCDVUNHty3gAW9rM8mNRSUVd/Tueq2Rb3a3R4HNzvGtqzbVWlU98I7su50w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3RMIobWc3R46Eo/Or6/Bi34lBJhEDdkRav4oRbAWOmnvcIVr
	q8CEOEF/xMhYyut16GbLjML3S7xSWtI/U4mmStVk1rjYDfkSc8CjInIO0kRs7Oc=
X-Gm-Gg: ASbGnctsli0fGl63agMNqwYXjf7LYcU+yqJuED+pLwE0hxj+Kkiz1h4p5ZOsFVliqFp
	DiZ+WN0AgT9L1n62Ywu+aiy/UMgH+Ck1XS6U6gOFJ/SobMtPRSYafFanFLqtfL9sl257xADqLJJ
	/vrlgNeKvwHcPv1tpzE5NsJfrIXmPO+fh+rGPxzCosl1DptKS6GJsjCasADXQh5aKGzcIk/K+T+
	m9Iu4mZGdC74YXJTZQQinCdxnIkkqhYR3lXV8ACo92QGWBrY5G0zSHHoiOlYjritdYJoLrGtVda
	LXhdtJsf7yqcTHIuukCKz7RV5swXaf1fJGXCTEZ+F4y1Ay6lLq2Jfjg=
X-Google-Smtp-Source: AGHT+IGWiGnjxl9amPWMtpBg/TTVGWv0w0/3DeUvonXPRwth4gPx2Sx4xPYck/WL22fVGRawD9RD9A==
X-Received: by 2002:a5d:6d01:0:b0:38f:4e30:6bbb with SMTP id ffacd0b85a97d-38f4e30bc4amr8481365f8f.25.1739904666800;
        Tue, 18 Feb 2025 10:51:06 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm15924221f8f.66.2025.02.18.10.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 10:51:06 -0800 (PST)
Message-ID: <5f7f39b9-5cf8-4ebe-816f-d56e52bc7408@linaro.org>
Date: Tue, 18 Feb 2025 19:51:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal/drivers/qoriq: Use dev_err_probe()
 simplify the code
To: Frank Li <Frank.li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
References: <20241209164859.3758906-1-Frank.Li@nxp.com>
 <Z5EULLr7hsk1RIZy@lizhi-Precision-Tower-5810>
 <8693bf83-9878-404e-b609-dcaf758d485c@linaro.org>
 <Z7TEGQQ/JM/q454F@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Z7TEGQQ/JM/q454F@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/02/2025 18:32, Frank Li wrote:
> On Wed, Jan 22, 2025 at 06:41:22PM +0100, Daniel Lezcano wrote:
>> Hi Frank,
>>
>> On 22/01/2025 16:52, Frank Li wrote:
>>> On Mon, Dec 09, 2024 at 11:48:58AM -0500, Frank Li wrote:
>>>> Use dev_err_probe() and devm_clk_get_optional_enabled() to simplify the
>>>> code.
>>>>
>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>
>> I applied the patches, thanks
>>
> 
> Thanks, I have not seen at linux-next/master. Anything missed?

No, it is in the thermal/bleeding-edge ATM and will go through 
thermal/linux-next tomorrow.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

