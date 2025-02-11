Return-Path: <linux-pm+bounces-21783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE4DA30518
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 09:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D813A6549
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6819F1EE7B9;
	Tue, 11 Feb 2025 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rybCBnv2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD81E5B96
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260918; cv=none; b=jfy7I3aFhIzrCXj3ZmVTfE82AyXMF7ixDXwML7q6FHAoUUVcjvAfak7LfEFQDj5168AzT4eJOrnqTIOOV/Upu9VSasQiz3xkJnW0UDX/VKn/jvVziU78Hgj7U5IyRQ1IxgCzlB1U4/jCvO0ft5c3Wzi5NuiFa6/Dvp6iL3503f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260918; c=relaxed/simple;
	bh=Sw0h0ERtzCmxJJ3TxQyw6/L/aOVV1cHpVOm3kFwUlRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=br6D0/UjXOVWVs4mcFqj7NZ0mBfwFpmRXhuR9gicAGlcxuok4yPyhERQlyCFbinao4kHGWhMV5+2CcE6e28XI8YQbKvKkNmrP25J3dc+shLRsxXHrdFwq9Mn7WGMPXuPF02QOozP/wsawmyEQxv1sYuOAO7LvtjgFMc7Rr6he8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rybCBnv2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38dc0cd94a6so2410527f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 00:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739260915; x=1739865715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1ZHsSsY3ITF+AirWxhJUBVeYzgF2p0gvSmDICW/VDI=;
        b=rybCBnv2pu7ItiVUbpaW1Bdnl/fgigd0fsqN3H9CXS1VMU2J6YNoNTAdeD/2rQwXp7
         XTFGS+ewWQ5t1ZVLqsaPpXAwwmk6HKMcg6O7aP2xINvTc9ioVoX97skkJ6Hi+W8bY9LU
         QkF5jQySeBD4xLfCKwoCIRjRpaDMHC1j/h/YUTUsUwY1l7gdUaTng4SGquaguD/6J/q6
         Zu002iZ6MBfGjkJ/ZepibixQ3OSZGEYV9hDucKk5XZ+5tLGoFDs2SenG6C6qYOSmA7Rr
         R4CVczXTBfS4/+NBwlIebRGti04X953fdd+NRqeKEstbxjJpvvG0yuiBunRe4uZhgx8U
         3Agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739260915; x=1739865715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1ZHsSsY3ITF+AirWxhJUBVeYzgF2p0gvSmDICW/VDI=;
        b=sbvmWoGLoufuFYRVGH05eBD6VdoF4xqRuTMgCkx4N5ucfM+nbHqJwWrsp8frE8bHb5
         yzSEOn7HM3rSGGTpGePML3cjmxvlLaYT9IByudRv2qPc8+sMtrCrce7UoFSLqqNA1W83
         OYVMJq45JyidK1aD3TqqxoqZrBKcdAcbHtwuQSZ1J5WKsc4mRCmKMVPZYU6HS8qQ8NFh
         /NWvDPKruo+qtwz8L1vdtA6tQcUq8R8GMP1AlGRxt2W91lJOGs0mFkUIjC/1b4GYCrkz
         P+Q+tX+50rl9IbP4vST32iQ1YTtfNuRYBhzunTG9F7jYogTyXRcPBW5kSofyuEH3fYWK
         vL+w==
X-Forwarded-Encrypted: i=1; AJvYcCUWUQ6dNMulNJJS9rHJ2lKqC/Jt+NBZhO2z5LjHVb7Tg4KNBO92mCMLWq58ZnVGkGyscsP4ix+PTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDLjKC91HRKcUkVaJfxb7l6ekJrKJuavxDed16AH/IU4/A/lm
	klvqvDnkC3rEth5V0c+g5teqVy1OqZ/H6H+cXX+0rc7NKHaphA/npn9q1YAs6kn5a1p+SbilqZp
	y
X-Gm-Gg: ASbGncs2EdTHrFVXnG0FhYUY5NC2V3TSSCwsbyWZkk3Q3MJbVvIBNk0nMbLxVtOkqHn
	kOV4WxOJcFR4zY1K424a4iWpfLGu2+jEoZ7zFT7vVTwkeCowK28WPY0O3ImAvU8q4nBDQxHs4VB
	WO1qfhiIdj0v4bYf+KGKyfxYILPTvIK9UQf2BDBTM/YjTjgR+YylnACCv0Fc20ZqaQju3ly0MZ6
	c2OBgY5Jkbp/EPacsEDr7D7cva7D0kB53YYf4qA+yAeyarWYcFuXXL1uNF77MTtmwA4TfpkalqV
	9sXoQSQFSaxwAl7eQhyGteA/ykaZ9w4FtyPu/DXZC7rpMpYakm1r6Ro=
X-Google-Smtp-Source: AGHT+IG9fJqG7RvHCIV9bGkDY2+Kx+4Q02p4YuSEX8d5F3gH89SWSF5+LvjbXgxGduKOkfBEcOeJPw==
X-Received: by 2002:a05:6000:1846:b0:38d:e411:98c2 with SMTP id ffacd0b85a97d-38de41198dfmr2152183f8f.32.1739260914725;
        Tue, 11 Feb 2025 00:01:54 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38dd49d2cafsm8698353f8f.16.2025.02.11.00.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 00:01:54 -0800 (PST)
Message-ID: <15de0ea2-eae6-4f23-9ca1-15836ec95cca@linaro.org>
Date: Tue, 11 Feb 2025 09:01:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/netlink: Prevent Userspace Segmentation Fault by
 Adjusting UAPI Header
To: Zhang Rui <rui.zhang@intel.com>, rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 lukasz.luba@arm.com, srinivas.pandruvada@intel.com
References: <20250208074907.5679-1-rui.zhang@intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250208074907.5679-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/02/2025 08:49, Zhang Rui wrote:
> The intel-lpmd tool [1], which uses the THERMAL_GENL_ATTR_CPU_CAPABILITY
> attribute to receive HFI events from kernel space, encounters a
> segmentation fault after commit 1773572863c4 ("thermal: netlink: Add the
> commands and the events for the thresholds").
> 
> The issue arises because the THERMAL_GENL_ATTR_CPU_CAPABILITY raw value
> was changed while intel_lpmd still uses the old value.
> 
> Although intel_lpmd can be updated to check the THERMAL_GENL_VERSION and
> use the appropriate THERMAL_GENL_ATTR_CPU_CAPABILITY value, the commit
> itself is questionable. The commit introduced a new element in the
> middle of enum thermal_genl_attr, which affects many existing attributes
> and introduces potential risks and unnecessary maintenance burdens for
> userspace thermal netlink event users.
> 
> Solve the issue by moving the newly introduced
> THERMAL_GENL_ATTR_TZ_PREV_TEMP attribute to the end of the
> enum thermal_genl_attr. This ensures that all existing thermal generic
> netlink attributes remain unaffected.
> 
> Link: https://github.com/intel/intel-lpmd [1]
> Fixes: 1773572863c4 ("thermal: netlink: Add the commands and the events for the thresholds")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---

Right, thanks for the fix

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

