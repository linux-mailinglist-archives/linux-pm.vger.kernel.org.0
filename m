Return-Path: <linux-pm+bounces-31239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C633CB0CB69
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 22:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EAB189F3EA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 20:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84A239E94;
	Mon, 21 Jul 2025 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RhyPiRo9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F902376EC
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128868; cv=none; b=Wq6i5/hJHp5CTH57th9e2Ipr/0KYDUv1sCAmyOxuUQqf/D8n+rDYB3jFMVeDSaEJ4VhLZW+7ZakLeePZUGa3WPVGw8MXQqQNwmQmfWI8cvmGk+HowyUpjCitor+kY+g4lppH/ZVkBUEB6LK/kQkpx2RO13mgRiwytzTt41H/JXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128868; c=relaxed/simple;
	bh=epa7+wp0cEoPPmYR6nZaRCp733cFnLPdm5t/iaHxLAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fUFAaW47laxvhyprpJlPIeNGCQfv9KIWtvy1szhHaX3gD6wWtMp4K4zeRrE76RSbyM4/ImeP4/nSTNxPMh6P92q5kXCYoM619zxM+H8lF2BkPcRQuvpED/rnc2vgTlY5EQvGO94VWITk/vXICYHByvzuF0fAEot23jDDuBei2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RhyPiRo9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so27180815e9.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753128865; x=1753733665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+NLeKkmFfS3FdjQ1rDekiaYo9KOrt0849XuRcwwgxk=;
        b=RhyPiRo9yKEwXsfsDVyCuj6wjW/CNdfv0000rHg0QDcxMTmc2kVtADsP60jUyWQu+I
         3RYx1TiVym4MvNI8Z70tan+5RkHxBrw5Alx03bDgJb02aFbAUcLrCnr1Ief2lnNkgAhQ
         YWUOC5WKw4OaNRShm8l7VV6pPrRD+Z5USKfaayzieRVHpDfHSIHeiNqRpenBXbEDQ4u7
         Ey0uOhkIBLETpFYWaIFsNw/1BAb7n+uqkLpsrEYQW21V4mQXc152xLS6wWlIpcUbfVw3
         1Bfj2pfchOx3MGacn3QtwoIoiLd3Ro4QKWmLFDl7VEAU3hSmSI0Qj14dPHcyituPnOiL
         TMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128865; x=1753733665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+NLeKkmFfS3FdjQ1rDekiaYo9KOrt0849XuRcwwgxk=;
        b=CsQB+PfqHvKUHSkV8r0vlGag5fIVfytr4ip+YUaJfo1maLuSEpQak81s4NLxFL37GT
         eWsg0eGh+txDE9jr4XIbfG+Ohal4EmYxIMunzGky0AgvFcYvqoyd+CrtTnXbxK4YBuRS
         Dvnex0MxnQFy8p5FRb3JS9w5nrUMRqvoQwbXkSAdqQTPyvjuSegdEs/TAh05c++S1EDC
         RdimsyaU/Lo1dN4PStqy0iVKwNjLJellmzBbm/CVHe7UmWDiFC5KSFt8bY+hhFRSRKRS
         lDq7GqbxcHBrxTrDtHGIpDDM07S8tUHUasmm8MH5x9yRqyJdpSDORJ+U8PeFzGrmw4Hb
         pdKw==
X-Forwarded-Encrypted: i=1; AJvYcCW6QhgRe9QeMgqdF/yyUwZlQX6QnQzC727SvM2RNUc3kTgXvXuk2vI/8LL3D8j0j1hjJ+n25+s06A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CbgXh2KQnccwrDY/7S4iTCbpAlZGFuS67Dbe9kTGuSGv0wqf
	l2cJcK7yzxL4BhD5UjEHzECS4EV4bO1T1GEobVMSXxJLLj8vRgzwL9g0lSSW8ZPK7XpY81NxH09
	tXDsE
X-Gm-Gg: ASbGnctLuPSJCDECR8K/5wA7MYsjDMSxVpwIehBl6akqjS4RHbwiCdOzGE+GyhsQepb
	mzl6ol+gghcQvQacEyV5dTNutPBrhI3aICDKmt8NGcL6MfO3MpnNKzRoLm7mCK0uDtuuBdvaYYB
	5VfnJOuwxj/qiqhecAc88BooeLGHmQK6ouqZ1lPcnfCaagTwRNQE4YoYSeRzMkebAheBqlya3pw
	eayb+9kCv5hUmehHjKWS69OB5EnqDA3FTwUVHT5MdgSElZUqKrEMRoSv7AvFIrMwFrpQ0PeMegU
	VydvZwv4aK9o+P/gdtFlm6Wkj3bvcpcExP6VCo+JL8eQP97T7EZCZwX3QYB+xXFNhJE74yGHmTb
	YCsghsUlPnEOLcl4Ex6qDSrQWiJwsKuiukpbpXC1Yj2ukU9RQdB/GI1B73F53iOavrWfsa/HePI
	zlGII=
X-Google-Smtp-Source: AGHT+IF2K0d0bKG4VD7/lCdy/OhzmE3w6YgPLQSQDJFH+YKC0cK0MI2AOW58kLCdtZuimtB0pT85RA==
X-Received: by 2002:a05:600c:870e:b0:456:285b:db3c with SMTP id 5b1f17b1804b1-456352d2ab1mr153619675e9.3.1753128864772;
        Mon, 21 Jul 2025 13:14:24 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:135f:abd:1f99:991c:5b07:cd28? ([2a0d:e487:135f:abd:1f99:991c:5b07:cd28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45862cd7143sm1464855e9.1.2025.07.21.13.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 13:14:24 -0700 (PDT)
Message-ID: <23b3cd9e-50e2-4888-81a3-c6d340bb9583@linaro.org>
Date: Mon, 21 Jul 2025 22:14:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add thermal sensors support for MT7981
To: Aleksander Jan Bajkowski <olek2@wp.pl>, rafael@kernel.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, s.hauer@pengutronix.de,
 rafal@milecki.pl, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250712195904.6988-1-olek2@wp.pl>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250712195904.6988-1-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/12/25 21:59, Aleksander Jan Bajkowski wrote:
> This patch adds support for the temperature sensor in the MT7981 SoC.
> This sensor is exactly the same as the one in the MT7986.
> 
> Changes in v4:
>   - sorted bindings by fallback names
>   - dropped accepted patch
> 
> Changes in v3:
>   - added fallback in bindings
> 
> Changes in v2:
>   - added fallback to an existing compatible string
>   - removed second patch as obsolete
> 
> Aleksander Jan Bajkowski (2):
>    dt-bindings: thermal: mediatek: add falback compatible string for
>      MT7981 and MT8516
>    arm64: dts: mediatek: add thermal sensor support on mt7981
> 
>   .../bindings/thermal/mediatek,thermal.yaml    | 27 ++++++++++------
>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 31 ++++++++++++++++++-
>   2 files changed, 47 insertions(+), 11 deletions(-)

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

