Return-Path: <linux-pm+bounces-38459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DB8C80282
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE3754E10BA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050E2F5473;
	Mon, 24 Nov 2025 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oG5NnK/O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7326F467
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982996; cv=none; b=H7lsvIThy1iNjID7lF4AEQ0l4JLH+tL3X1Hnaw5xlRimiJ9zBTUommY9DDjMx+2UGMCTwJ44j5fcRek+kr4ZF92jxFut6qC7l7QKtJy31Rg522ogES1dtrUI3cpq6pfaoxrYZ37UmHlge6aRuQQpLFxA0iupgYPfckzc4/l4jX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982996; c=relaxed/simple;
	bh=PkrzqQiN/qcj/0t3ahO3DxqiRf/xvfoXnTu2D4FlPMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzIJLfLeb8vHlE0j5CITO3gwBfKq+GHbXvlryMrwq8JdgFr2dLeAZ13zHQ9K8+sJIHM3lCmOOMIw9g8KFkTKeiQOFY7Wzvl2lDKoV5HlPY3WAOWqGW3/gVS3cyTavxS1zITzMdHbTnKXOOFqgHWrTHTozPfoOlAFZgAeInGjYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oG5NnK/O; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso45007855e9.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 03:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763982993; x=1764587793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UuRrMhunT9TDWnZHLII8BIXNolS7BUSymKB5ka4d4O0=;
        b=oG5NnK/O0Dwjxg6PFUKLHtTVLys9LDlAWbhAZjHzdzxU+KnlIY+tvhiEbgQo8z6IhM
         +qNJLswUiuAafz0F5c6h43ky2YawIcfM+wk6mzjVnpTkvCEcxGCF4RR/5qvb1zwzdx7O
         N+Wbdc1U91nrrIfIuZVcdmVQRFBTqCiuiJ9E91TxDm3J0XNuVAKy/YVmQEhvmcmTbd+n
         gUvWqUlmRqrm765g2hxlHk8EYg6MQ2uQX1UB4gHsjk47vMrpHwDDNjVRVTdl57WONLdP
         cNh0GLoWclbhLpvY7TORQ7cHw+iUeVEHk7AP/7J/Axkwkka4Z4oCiArkn2KJ8RI4QExW
         ivCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763982993; x=1764587793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UuRrMhunT9TDWnZHLII8BIXNolS7BUSymKB5ka4d4O0=;
        b=fErksXDPrZIZfDtOc+Jsd9IAnvGti90jxjMVAKWCPJTFFUBwwA2nia4yHrfHNaPKjQ
         aEFFN+B21S8u1f5F6D9J30JIM3SVK+0OHpVrFThtvgk2pYTlzDWPiD9v1+uv/jlD9Phh
         x5xAci6FGwpVnKyw3uXgMn/mLy7lcL/brTTp2s01z+H2fN5Q3fLrJ+KoWUOpaed8Bkzc
         AVKMMfG/Hv6a9xNToKyIhtDtVVG29w1IiyEC1S1Wqd3zoUltAYmux69ZSHCsHkSfWNN6
         Uk6heMOIMsm6J5VOgyoyg6FvONDIyr8bJCsVpml01bLIeL6kFbvYirsVdz1C24UgvoBB
         avLA==
X-Forwarded-Encrypted: i=1; AJvYcCX2NCRqodPLbjRvkgiO2gmDeAH0IoPc5k9EjCdpFgTwB3KVcCON6TefDFezfQr/gu4SOPlL+zOO3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6ZY0DvFDQ6G7IIcZiPOt+uIJ0Bzqdg8p0OUh62jKxYTbfvAd
	M+JC9ur62FWriMCjapuvLP3lVHYgrXQmZbEWBfiI0kexDFMudrK8faza3hEUsgO6wfM=
X-Gm-Gg: ASbGncuBYH7JOcKaW1fyEyLnG5E2bVvFq9uspYoxsNDQiNB2W+W9fTyLuarAAcoau3Q
	Y2dt7JihUCwmhFxarJdUKm2TnFVbBNFYRiJdcI4HoCs26hIWthZD1lvUg38EXPFVGLO8jG7qtvH
	PukG4wtC/SNHNuhWkULs66O5XtvM+HJy0jFM75yt2B2VL957eI039TPlOqNql/CNEB+nMq3HyOe
	C6McHFSeLpY8JROOUm8uX69q8Kcwl4PDLF71CDsI7XGNH6s6YbtVHwiMv2mSKnC0jL/hSNOm7VG
	HO1d4i6Th0lPdqoH1GcdiBgllF5/zj9857FT9A8hNalhYj01RFYkw39iqxtK04kDAMH76K2jxTA
	KLA80Y0lRz9XRUOklY7KxOuCc1rjaQ/y91mbH1D/1rCCq/8riYvCm+ix+tyFDb70/cua+PlMXB2
	dY4+Fx9sWUBolxb8Z/DTHaziIdWRG7C0qFZTPezzaBKWMD03j21XhbRCuyqNTiWsn/Pg==
X-Google-Smtp-Source: AGHT+IGoaXb9zqkluRUTXSsxY7Elb/IIHiZ+I4IVLxjc5bpkpHjrfyygfT2RwN8BHb50RMQMY1Fuxg==
X-Received: by 2002:a05:600c:1ca5:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-477c1115ff6mr126002295e9.17.1763982992722;
        Mon, 24 Nov 2025 03:16:32 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:a756:bb6c:7b35:af9b? ([2a05:6e02:1041:c10:a756:bb6c:7b35:af9b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e5b6sm27447425f8f.1.2025.11.24.03.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 03:16:32 -0800 (PST)
Message-ID: <ec51f257-e961-4e21-94d9-68825cbfe287@linaro.org>
Date: Mon, 24 Nov 2025 12:16:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
To: Tudor Ambarus <tudor.ambarus@linaro.org>, =?UTF-8?B?7IaQ7Iug?=
 <shin.son@samsung.com>, 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>,
 'Krzysztof Kozlowski' <krzk@kernel.org>,
 "'Rafael J . Wysocki'" <rafael@kernel.org>, 'Zhang Rui'
 <rui.zhang@intel.com>, 'Lukasz Luba' <lukasz.luba@arm.com>,
 'Rob Herring' <robh@kernel.org>, 'Conor Dooley' <conor+dt@kernel.org>,
 'Alim Akhtar' <alim.akhtar@samsung.com>
Cc: 'Henrik Grimler' <henrik@grimler.se>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 William McVicker <willmcvicker@google.com>, jyescas@google.com
References: <20251113064022.2701578-1-shin.son@samsung.com>
 <CGME20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237@epcas2p1.samsung.com>
 <20251113064022.2701578-3-shin.son@samsung.com>
 <2180a854-8ba6-4424-add2-eb34637530c1@linaro.org>
 <000001dc5d2a$0697bf10$13c73d30$@samsung.com>
 <12346382-7718-4942-a497-4de278b1d5a0@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12346382-7718-4942-a497-4de278b1d5a0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tudor,

On 11/24/25 11:43, Tudor Ambarus wrote:
> Hi, Shin,
> 
> On 11/24/25 12:06 PM, 손신 wrote:
>>>> +static void update_con_reg(struct exynos_tmu_data *data) {
>>>> +	u32 val, t_buf_vref_sel, t_buf_slope_sel;
>>>> +
>>>> +	val = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
>>>> +	t_buf_vref_sel = (val >> EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_SHIFT)
>>>> +				& EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_MASK;
>>>> +	t_buf_slope_sel = (val >> EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_SHIFT)
>>>> +				& EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_MASK;
>>>> +
>>>> +	val = readl(data->base +  EXYNOSAUTOV920_TMU_REG_CONTROL);
>>>> +	val &= ~(EXYNOS_TMU_REF_VOLTAGE_MASK <<
>>> EXYNOS_TMU_REF_VOLTAGE_SHIFT);
>>>> +	val |= (t_buf_vref_sel << EXYNOS_TMU_REF_VOLTAGE_SHIFT);
>>>> +	val &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK <<
>>> EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
>>>> +	val |= (t_buf_slope_sel << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
>>>> +	writel(val, data->base + EXYNOSAUTOV920_TMU_REG_CONTROL);
>>>> +
>>>> +	val = readl(data->base + EXYNOSAUTOV920_TMU_REG_CONTROL1);
>>>> +	val &= ~(EXYNOSAUTOV920_TMU_NUM_PROBE_MASK <<
>>> EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT);
>>>> +	val &= ~(EXYNOSAUTOV920_TMU_LPI_MODE_MASK <<
>>> EXYNOSAUTOV920_TMU_LPI_MODE_SHIFT);
>>>> +	val |= (data->sensor_count << EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT);
>>>> +	writel(val, data->base + EXYNOSAUTOV920_TMU_REG_CONTROL1);
>>>> +
>>>> +	writel(1, data->base + EXYNOSAUTOV920_TMU_SAMPLING_INTERVAL);
>>>> +	writel(EXYNOSAUTOV920_TMU_AVG_CON_UPDATE, data->base +
>>> EXYNOSAUTOV920_TMU_REG_AVG_CONTROL);
>>>> +	writel(EXYNOSAUTOV920_TMU_COUNTER_VALUE0_UPDATE,
>>>> +	       data->base + EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE0);
>>>> +	writel(EXYNOSAUTOV920_TMU_COUNTER_VALUE1_UPDATE,
>>>> +	       data->base + EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE1);
>>>> +}
>>>> +
>>> This is unreadable; please make it understandable for those who don’t have
>>> the documentation (explicit static inline functions, comments, etc ...).
>> I'll restructure this code by introducing explicit static inline helper functions and proper comments to improve readability.
> 
> We likely shouldn't use inlines here, see Linus's reply from 2006:
> https://lore.kernel.org/all/Pine.LNX.4.64.0601021105000.3668@g5.osdl.org/T/#u

We should not use inline functions when they can be called from 
different places and if they contain a significant amount of code inside.

But for one line functions, inside a driver it may help for the 
readability when the function name is self-explanatory.


> I guess you can make this easier to read if you use FIELD_GET/SET from
> bitfield.h. Other improvement would be using the regmap api.

regmap would be too overkill to write unshared registers.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

