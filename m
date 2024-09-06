Return-Path: <linux-pm+bounces-13784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8304096F0DE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB221B237E5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 10:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4E51C9DC6;
	Fri,  6 Sep 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9JLdVyy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4D15852E
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617059; cv=none; b=ma8i3zzFee/5DLc9zsO16YS/J57+4gapXtJf2tPD3P0h6KOJmCZHxymWMOic+Fi+r/z6Qkj3n0+5HMLNm9Y/q0EJVNa6E1qh/6iTvJfRQLzYFX9r1mDPePMcU5f7jgndG3rC3MYGQzwzz3wXeA76FaV3mdSEV0BBsuC5XvBQv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617059; c=relaxed/simple;
	bh=2RPun1GvohKXhE5aoSasUbi/UHlKYzrsMqoeCmnres0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RI2/ETg+gJTvvmdCcPRYB0DJMU+LoZ/BGmaU7fi9wTwg7lMESAaRoOW0rdwGSeNIo+w+6+oGW3WYpRBHmsP1Wp6zeczKweIPDuTRsXWxj53TET2f8CRtrrvI/upwDp0FgUNkmHviZ02pAnV7zZDmaRjdnwKlLaC7s0b5D45fqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T9JLdVyy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c1120a32so998142f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725617056; x=1726221856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICGVfQquZxLUdv4qyof+VD005fvK34/ue8aLmEnx0Hs=;
        b=T9JLdVyyDdR/p9VbJxJsA9DEAwURNHXiz8vyIg+hZcRFAo7+0uDcXl44T0XENCWnKN
         uG50KXtGKQCZ8LzCnys4RaxJ0A0Wg0nhFQCatjyPBYMI7q1ibquHCcdonxJ2qxLKqGhM
         dSPG3j0HoAgTmu4xkx5s7X97OrRzycWxYcapsEzzouGJIqroKplMprM6WZ1VBzdaseMk
         2enMtQKMQUwKPdOztI12b5dXXQ1qWWO7fqAUKDoascaboP+2tWniEMEJ0DvWVrMuTfpR
         9y9LM8WVD6MlE13A3s2OxgPUxR+xPn2qYF3c64z1CNzIAb9lJcWs0VhWonzFKe0WvkKU
         oDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725617056; x=1726221856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICGVfQquZxLUdv4qyof+VD005fvK34/ue8aLmEnx0Hs=;
        b=mMvs8MUZ0zFochi5HyudFolnnYF1JIU+a3tpHOfpun3U1+o6mZNOrkZ0Qn/UpFedcH
         bXLLTqKfF3VtyySfO5CrTpdaGZiu8TDkeVExwbcCt7hGIwXGIaTSgmeOFEGQx8tGCxnB
         MQuD/ayH+i97vnZpyxLuhZzT8CPc2kzixYtvVkYbomnBeY02L5bzk4rkMvRy7c4tJ0C1
         1ndb06vVtxHPI6ny071hW+nm48/v5eUGGTmSzeduOXJPQZtvAHaPE5M4mDZTtFhJeNbr
         FIloygeZ1m1rfSNpH3B2gtbTl0N+XkyI1ByVQ3F0mVtSfukwX+oJDu0X+KsrQdi5DV20
         m3gg==
X-Gm-Message-State: AOJu0YyldPLwkbIfSJEVdgDNSHxK9IhVK/TRrte6f83SakA68ZpR1nsQ
	vVlPDFTOasTq9bHilWB8MjqMrLIbVEU/XvON00H//yMTrJaVgwFP0uWpM7sKlbs=
X-Google-Smtp-Source: AGHT+IEa0EFSzTSab9skgszp2VXJgV7bSagVjGqTmtvznhN6ryAHPGAPBLObB1eCrJcsSNSidlyLFQ==
X-Received: by 2002:a05:6000:b92:b0:371:8dcc:7f9e with SMTP id ffacd0b85a97d-378895c6306mr1366536f8f.2.1725617055371;
        Fri, 06 Sep 2024 03:04:15 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-374bd0ce240sm17104161f8f.70.2024.09.06.03.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 03:04:15 -0700 (PDT)
Message-ID: <2c7f43b1-48e7-48f2-bbe2-c0006ac6e0e7@linaro.org>
Date: Fri, 6 Sep 2024 12:04:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] drivers/thermal/exynos: improve
 sanitize_temp_error
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz
 <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Anand Moon <linux.amoon@gmail.com>
References: <CGME20240903072005eucas1p20eec517c32d39e7aef17e6a2c2ad4b6e@eucas1p2.samsung.com>
 <20240903071957.2577486-1-m.majewski2@samsung.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240903071957.2577486-1-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/09/2024 09:19, Mateusz Majewski wrote:
> Hello :)
> 
>> May I suggest to convert this function to a specific soc ops to be put
>> in the struct exynos_tmu_data ?
> 
> Like this?
> 
> static void exynos4210_sanitize_temp_error(struct exynos_tmu_data *data,
> 					   u32 trim_info)
> {
> 	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
> 	if (!data->temp_error1 ||
> 	    (data->min_efuse_value > data->temp_error1) ||
> 	    (data->temp_error1 > data->max_efuse_value))
> 		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
> 	WARN_ON_ONCE(data->cal_type == TYPE_TWO_POINT_TRIMMING);
> }
> 
> static void exynos5433_sanitize_temp_error(struct exynos_tmu_data *data,
> 					   u32 trim_info)
> {
> 	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
> 	if (!data->temp_error1 ||
> 	    (data->min_efuse_value > data->temp_error1) ||
> 	    (data->temp_error1 > data->max_efuse_value))
> 		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
> 
> 	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> 		data->temp_error2 = (trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
> 				    EXYNOS_TMU_TEMP_MASK;
> 		if (!data->temp_error2)
> 			data->temp_error2 = (data->efuse_value >>
> 					     EXYNOS_TRIMINFO_85_SHIFT) &
> 					    EXYNOS_TMU_TEMP_MASK;
> 	}
> }
> 
> static void exynos7_sanitize_temp_error(struct exynos_tmu_data *data,
> 					u32 trim_info)
> {
> 	data->temp_error1 = trim_info & EXYNOS7_TMU_TEMP_MASK;
> 	if (!data->temp_error1 ||
> 	    (data->min_efuse_value > data->temp_error1) ||
> 	    (data->temp_error1 > data->max_efuse_value))
> 		data->temp_error1 = data->efuse_value & EXYNOS7_TMU_TEMP_MASK;
> 	WARN_ON_ONCE(data->cal_type == TYPE_TWO_POINT_TRIMMING);
> }
> 
> static void exynos850_sanitize_temp_error(struct exynos_tmu_data *data,
> 					   u32 trim_info)
> {
> 	data->temp_error1 = trim_info & EXYNOS7_TMU_TEMP_MASK;
> 	if (!data->temp_error1 ||
> 	    (data->min_efuse_value > data->temp_error1) ||
> 	    (data->temp_error1 > data->max_efuse_value))
> 		data->temp_error1 = data->efuse_value & EXYNOS7_TMU_TEMP_MASK;
> 
> 	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> 		data->temp_error2 = (trim_info >> EXYNOS7_TMU_TEMP_SHIFT) &
> 				    EXYNOS7_TMU_TEMP_MASK;
> 		if (!data->temp_error2)
> 			data->temp_error2 = (data->efuse_value >>
> 					     EXYNOS7_TMU_TEMP_SHIFT) &
> 					    EXYNOS_TMU_TEMP_MASK;
> 	}
> }

Yes, something like that but may be with more code factoring, like a 
common routine to pass the temp_mask and the specific chunk of code.

> Or maybe we could put tmu_temp_mask and tmu_85_shift in data instead,
> and have one function like this:

Either way

It would be nice if the code can be commented to explain how the sensor 
works in order to understand what means "sanitize the temp error"

> static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
> {
> 	data->temp_error1 = trim_info & data->tmu_temp_mask;
> 	if (!data->temp_error1 || (data->min_efuse_value > data->temp_error1) ||
> 	    (data->temp_error1 > data->max_efuse_value))
> 		data->temp_error1 = data->efuse_value & data->tmu_temp_mask;
> 
> 	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> 		data->temp_error2 = (trim_info >> data->tmu_85_shift) &
> 				    data->tmu_temp_mask;
> 		if (!data->temp_error2)
> 			data->temp_error2 =
> 				(data->efuse_value >> data->tmu_85_shift) &
> 				data->tmu_temp_mask;
> 	}
> }
> 
> Thank you,
> Mateusz


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

