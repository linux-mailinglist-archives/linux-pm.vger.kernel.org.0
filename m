Return-Path: <linux-pm+bounces-35066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B837B8A9E3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 18:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AB35828E6
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 16:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E387220F34;
	Fri, 19 Sep 2025 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWvQ4BAp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D574253954
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300171; cv=none; b=n+D0mhKQFniTK1kAfHSVbxTqc5Dq0Eprlx52yZppHXqJrF8RV4Pr3lwMfbdG0PRlQ7uu7rzH+QBRUnp3OWftil/1/jFl1C1VjzYKfMXGhNDegrzDqmopvV8IayGCEX1CGmhJFGsU0lecJeV0kbVMZ6LDCHxSsfFxfFIFtuG0KS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300171; c=relaxed/simple;
	bh=IVmeYFEt5n78kowyzbALJ2qR43obCrrnzs3YepyioWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnB3I74eD+p2F9SXV828+2M2cMivEnnVKXiNYc9JvZ/jkjah2f/IkCfdTubtEA6xpOZgNyBWBsiF+uXEBAaveIob9Gigebd/b40Ck+HdnBULWwPCg5ExgPsvJjJULpCcHYEOykyRfoKJD4rgh5QoyI3yLvPjiFNFJ4i2BKaE740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wWvQ4BAp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee1317b1f7so1200505f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758300167; x=1758904967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QkHj6yxNHqV86xD9f9rRMp4RmegxtrG2NNsn/fkhknU=;
        b=wWvQ4BApGTAQVOMBo0lK4TT/Nhb0Y5f8AgIcULgKprpvJCRm7k2pTlThkLrwReFHyO
         k8ZP99TIfvSqR78QxCHtkP7ZND3r4HFrjgseKLq07VP0rLOu1MDaZE/FKcdKjqkDRxF+
         sh4TyWnsw6LP6XbE9tB4Vp6Z1FkYPYvpbJDqPsahfnL/4D2hMyiH/9swzuUGycNsdBOF
         Bwcbg6yanXYammhI7ra42uLBVlUa4jRKopXXQp65boFUxrTpxnJYnFV+EP5qbgBwOyKH
         QPdCxeNsc2rZUcVnFxVb9Wh7qW5Y93eATOulq6JTqXoaonlAGeOjl+LLiM5gUhVbIPQ7
         N7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758300167; x=1758904967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkHj6yxNHqV86xD9f9rRMp4RmegxtrG2NNsn/fkhknU=;
        b=Q8sC5rdtji++iJdoIUYkEmcLgPHfE8wORkbQshXB/YOxcMdVMApGpVAE4idJ5eH2hb
         TbspjdV/tryth+JOg3m2JT7c6vf5SlrlzFhhXY0XSD54QdsfOyXh1w+9xTIZU01sGPZU
         ggUbIQ281NiKR/cbpfi8Kquj5RJ0YRTOxuiwcL3zlO4xz8AqliHLpjU/rD5AxmAqpTHh
         l7czr7VKBHUqDSnafD9V2CHKiqZsy33cYZLr5hBaaL++y+ybrORpTL2CeXHBN+gPaCFQ
         Q7/sy6fNEG4wIVoAMECJD0nSSQHNQKiG0FlqPXw0yyUc+26mLJxo+eqvCOq8BrXecDt/
         oqAw==
X-Forwarded-Encrypted: i=1; AJvYcCWBBF8+qFCCWCHx2npYzX9qLo4zp8TJ8a3eH9uV/Q5r5Z6u3zLEXdcXNFIlS6jxVhJbReD8xMa8jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxN73ASB8loNrO5RUfqI1G6GK3zFzqCE7S5zg9rjAT64zp7EV
	U/xsnGzj4mJZWmYbg/eQghXfiK2cTnuam4okO5HHkZpTqHo39x0rTmrE9hHwIhlqybY=
X-Gm-Gg: ASbGncuxzUUxmIOyLlxxXjN50yADndLQqJuuFwXvo3+uNMQTt4r+LqW5hS1bfpzMa2e
	3lRm/teXeLdOeGBmmEf8IN1UV+U1XKjHONGdS7+U2VqqAr2ZEAAMo9d9vTmS0ZBS7hI7uA23jev
	Niq94t1UmVve/zIb4oUFVgYO5INa+3IdLdRlRoTQIlsUJlgoJoFLV1hbeSBXbuovD8GDYlCwKIf
	W2I/iV++InlMsoTTaaya/J/LLU8qzxh1iBNyw35xLenOsXBbmZhrMlsCl4wRq8/SJ81SQ5qr6tR
	9NpytPwnmdJUWbmBi7u2j2Y12QK1cRSrM+A4QPQjuCcdQzIc8M/NLdFgW8smaj2DYmE8ikJB3Lx
	WWEG/Knz6U+TWRvIFuCKRTfPU9C3v2Rqm5e3M+E5zFlcX9Nv6VRjjqs5oJ9LVPWXaaVynGuAItC
	kevQatyTi4lJ94
X-Google-Smtp-Source: AGHT+IFhUncdh/63zODwAY6Eoa8z9GQAGmPnzhNb7b4Y3hgpiTCynPlk24Zvc+GNdq/F+x3+CVBVbA==
X-Received: by 2002:a05:6000:1aca:b0:3b9:148b:e78 with SMTP id ffacd0b85a97d-3ee855812a7mr3683227f8f.53.1758300166902;
        Fri, 19 Sep 2025 09:42:46 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3f1549285c9sm1799412f8f.52.2025.09.19.09.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 09:42:46 -0700 (PDT)
Message-ID: <ffa6fcdd-2b0d-4493-a8b1-961e51d41e6f@linaro.org>
Date: Fri, 19 Sep 2025 18:42:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] thermal: qoriq: add i.MX93 tmu support
To: Frank Li <Frank.li@nxp.com>
Cc: Jacky Bai <ping.bai@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Alice Guo <alice.guo@nxp.com>
References: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
 <20250821-imx93_tmu-v4-2-6cf5688bf016@nxp.com>
 <d9392dbc-806a-41df-8992-28c3d6132309@linaro.org>
 <aM2D+q/XCI38M9sp@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aM2D+q/XCI38M9sp@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/09/2025 18:25, Frank Li wrote:
> On Fri, Sep 19, 2025 at 05:51:20PM +0200, Daniel Lezcano wrote:
>> On 21/08/2025 08:23, Jacky Bai wrote:
>>> For Thermal monitor unit(TMU) used on i.MX93, the HW revision info read
>>> from the ID register is the same the one used on some of the QorIQ
>>> platform, but the config has some slight differance. Add i.MX93 compatible
>>> string and corresponding code for it.
>>>
>>> Signed-off-by: Alice Guo <alice.guo@nxp.com>
>>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>>> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
>>> ---
>>>    - v4 changes:
>>>     - no
>>>
>>>    - v3 changes:
>>>     - use the drv data struct for match data and refine the code
>>>     - update the copyright
>>>
>>>    - v2 changes:
>>>     - use the compatible match data to identify the i.MX93 TMU variant
>>> ---
>>>    drivers/thermal/qoriq_thermal.c | 18 +++++++++++++++++-
>>>    1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
>>> index 01b58be0dcc64d14ca5e4bba654eed8f15e827fc..b2e634547271dcf512c714907baa162921d2d527 100644
>>> --- a/drivers/thermal/qoriq_thermal.c
>>> +++ b/drivers/thermal/qoriq_thermal.c
>>> @@ -1,6 +1,7 @@
>>>    // SPDX-License-Identifier: GPL-2.0
>>>    //
>>>    // Copyright 2016 Freescale Semiconductor, Inc.
>>> +// Copyright 2025 NXP
>>>    #include <linux/clk.h>
>>>    #include <linux/err.h>
>>> @@ -24,6 +25,7 @@
>>>    #define TMTMIR_DEFAULT	0x0000000f
>>>    #define TIER_DISABLE	0x0
>>>    #define TEUMR0_V2		0x51009c00
>>> +#define TEUMR0_V21		0x55000c00
>>>    #define TMSARA_V2		0xe
>>>    #define TMU_VER1		0x1
>>>    #define TMU_VER2		0x2
>>> @@ -66,6 +68,8 @@
>>>    						   */
>>>    #define REGS_V2_TEUMR(n)	(0xf00 + 4 * (n))
>>> +#define GET_TEUMR0(drvdata)	(drvdata && drvdata->teumr0 ? drvdata->teumr0 : TEUMR0_V2)
>>
>> This is not adequate for code which will evolve. Please don't use this
>> macro.
>>
>>>    /*
>>>     * Thermal zone data
>>>     */
>>> @@ -73,12 +77,17 @@ struct qoriq_sensor {
>>>    	int				id;
>>>    };
>>> +struct tmu_drvdata {
>>> +	u32 teumr0;
>>> +};
>>> +
>>>    struct qoriq_tmu_data {
>>>    	int ver;
>>>    	u32 ttrcr[NUM_TTRCR_MAX];
>>>    	struct regmap *regmap;
>>>    	struct clk *clk;
>>>    	struct qoriq_sensor	sensor[SITES_MAX];
>>> +	const struct tmu_drvdata *drvdata;
>>
>> The drvdata pointer is not usually used.
>>
>> 	u32 model;
> 
> I think it is not true.  Copy model here is not extendable if need add
> new field in drvdata in future, especially need ops callback for differece
> variances.
> 
> Just list two examples:
> 
> https://elixir.bootlin.com/linux/v6.17-rc6/source/drivers/pci/controller/dwc/pci-imx6.c#L173
> https://elixir.bootlin.com/linux/v6.17-rc6/source/drivers/pci/controller/dwc/pcie-qcom.c#L286

Yeah may be I'm doing a confusion with a previous comment I had related 
to this approach




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

