Return-Path: <linux-pm+bounces-38463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5144C80724
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 13:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE553A1BB5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C4729B228;
	Mon, 24 Nov 2025 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCbDuoun"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA0226CFE
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763987060; cv=none; b=EqgHXZsjN7yWvyuRjn0uWZj94ZsHxlFbAy9E0jUWCcsO1J0e+sBRGOMXwU49WVR7taA+cpBW6LN+Ywh1sFKhRfXGMLxMrzxJ7mpAf4cgS/ulUmyR75cRm3Em6VBszWUagptshksfCmz7ZS3YaBiT5CVATP47mhxd42/IXPXY+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763987060; c=relaxed/simple;
	bh=CdkSoOGkYCWxizMuG3oTq6c8mgAr5aYWC1EmHLuCzoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDmyE2/iSyhaw8WLGoJQE5EKZ4md20AtoLT0hIHbs+G0iRl49PWmb4i3IZB3w04K/V9vRXXpZKFY5qgO5eXFxz4dLIQF+4EYNXI1p0CSjAVd0gd8eI0SKZ+sSbfXCIeXSn42HPiDiK5+LHn1pfEXCZe9JqjQqqqG0aNJ/R+Ms4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UCbDuoun; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47789cd2083so24607655e9.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 04:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763987056; x=1764591856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuDHMylOaR8g/JvAKh/yVTJ3Yy9MU0h2/4AVh9Q0YsE=;
        b=UCbDuounVqSiqmDAXoLXRE5I9dFcU6DpDr2x69zGYpPXZTkRElRWo+DyCpkiECPoI1
         clywfWeE5GNOrOjh/TlCuYeW/HItONNXzU1QZY8lVv1+JJz/U9VNUIrMWilDMPmh8DGN
         hwk1Jfgzxi12C4OLttLoZNycimvbAMXfAQxVlon4j3D6YjONXKFiOCBvfh2mi2WPCRfU
         nf2oLcSvfMNdjsroFZx6ojdeMU2RTyaCO/VmKL/yRcj2s7OAc5pN9gmtUbpAGNeBFsUn
         mIWOT++SrBMaUqXnWP/xoa/wCiOtxjIawOUWM65dJ3/N7h+B9CPdg+vXFPfw8/oLXubn
         Owvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763987056; x=1764591856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuDHMylOaR8g/JvAKh/yVTJ3Yy9MU0h2/4AVh9Q0YsE=;
        b=i8oY9b1geetvfmJfQx/db1AHvHsTlSjbTnLYh86PWMhN/DY8dHefRyhG+dhEhsNOAN
         Cjq7Q4TynO0pZRPZhVfNgyi3jRehxbgSIzMsTrF95tazmh9pebBatStgSXfe6Ku2GCRG
         IxKi0C0YlGRoY/60aXfFWiU4twOW+zUwqwNCJCRXdTseqm0ljKWXmVcczJmPAQ6eRgsc
         Rq6Zo9g1RJsAJeIDDTq+B82j1/7TbbMTRf9nfZZ6vVw8+4n0p5yM3V73N3tUVr/hSMRz
         /DyldnT6Qr6od2rWO3McJhyelsy5O0J4LMizzAa4k9yHrO0+Vr06y+nXy14UkRX0jLsg
         1eMA==
X-Forwarded-Encrypted: i=1; AJvYcCV8LAMTumk33g3vj2vXFYngnrkZeGU4Yvgl1motIdHkt1Do9cP9NjgzcwwaA10DHGlV525PFpborg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjhOntaX7+B9DY9VOR88bqbcEYMBBCKc5CanpBPiRSO8vpvpX0
	3VmZn0pUKAtJKspgi8MXiTjFDqQ5CuJbtFT3bb3Zrw2apjrpipu8iFJDAClKjTUwZVM=
X-Gm-Gg: ASbGnctK8LZ8Qxccy/1ydwaBVamhwcLgf3kOOm3OAnJ8/QhWsav3eB4pGtXaB1lTEcx
	xyfFWs6EAVZQ3FSeobgd+/49N7hqLyLjTTyXlTiT0Y6UXHoO83ViI5fz5prboxyL/GAAVyQLxdN
	AeVhBEycgbW6XPO75WN0iLlHMZgN3ZmB3PrFamZ6C0u326XhmochLL17HngJonKt1q9WlE+QFif
	nFO1QPPdrH3q1Njk85fBx9FWJNd7bPKENVq2KMDNETDT3aBVWlOE/kfdOQLz+en9/0uSER4eu1p
	7muHy6BdkmzdiozUCm++zJtXE7C5P+6gUW/jvF8/sYGdouR8FpbI3QAs1jiCidEzVHe2745A0rE
	S4GjzazcFGYU2iSxr7SNMGwzH1g/UV9YItWIWLcunDW4XRYA6zE0qQdIZYSCWXtDcdBYsS3q6G8
	uZZl62qpJ8jEUCE9L9
X-Google-Smtp-Source: AGHT+IG2uTxmSnqi9HaFJ7zlbUKITzVAUKbFdsMO7ekXsieDrVZoHZ7vGzCkFpr4leaIfxrvJJzZUQ==
X-Received: by 2002:a05:600c:1c25:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-477c114ed70mr173574695e9.24.1763987056305;
        Mon, 24 Nov 2025 04:24:16 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1f365fsm195163025e9.8.2025.11.24.04.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 04:24:15 -0800 (PST)
Message-ID: <1baaae91-f712-4965-9105-4358a59ff1d1@linaro.org>
Date: Mon, 24 Nov 2025 14:24:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
To: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>,
 'Daniel Lezcano' <daniel.lezcano@linaro.org>,
 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>,
 'Krzysztof Kozlowski' <krzk@kernel.org>,
 "'Rafael J . Wysocki'" <rafael@kernel.org>, 'Zhang Rui'
 <rui.zhang@intel.com>, 'Lukasz Luba' <lukasz.luba@arm.com>,
 'Rob Herring' <robh@kernel.org>, 'Conor Dooley' <conor+dt@kernel.org>,
 'Alim Akhtar' <alim.akhtar@samsung.com>
Cc: 'Henrik Grimler' <henrik@grimler.se>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 'Peter Griffin' <peter.griffin@linaro.org>,
 =?UTF-8?Q?=27Andr=C3=A9_Draszik=27?= <andre.draszik@linaro.org>,
 'William McVicker' <willmcvicker@google.com>, jyescas@google.com
References: <20251113064022.2701578-1-shin.son@samsung.com>
 <CGME20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237@epcas2p1.samsung.com>
 <20251113064022.2701578-3-shin.son@samsung.com>
 <2180a854-8ba6-4424-add2-eb34637530c1@linaro.org>
 <000001dc5d2a$0697bf10$13c73d30$@samsung.com>
 <12346382-7718-4942-a497-4de278b1d5a0@linaro.org>
 <000b01dc5d37$3f6f5e80$be4e1b80$@samsung.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <000b01dc5d37$3f6f5e80$be4e1b80$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Shin Son,

On 11/24/25 1:41 PM, 손신 wrote:
>> Shin, a bit unrelated with the patch, but I wanted to let you know that I
>> started looking at the GS101 TMU. I assume it's very similar with the TMU
>> on exynosautov920. Do you know if they share the same IP version?

I guess you omitted this question.

>>
>> I noticed GS101 uses ACPM calls to communicate with the TMU. Why did you
>> choose to not use ACPM for exynosautov920 TMU?

cut

> Regarding ACPM, I did not introduce it earlier because I was trying to align the implementation with the existing framework.
> However, if we move toward a separate driver, I will reconsider whether ACPM integration makes sense there.
> Would it be possible to get your feedback again when I prepare the next revision of the driver?

Yes, I'll try to review it. Add me to cc please.

> 
> Plus, the GS101 TMU driver isn't upstream yet, right?

It isn't. I started getting familiar with it, and will try to upstream it.
Given exynosautov9 and gs101 already share lots of IPs, I assume TMU is similar.
I will likely follow the ACPM route because that's what the downstream code does.

> Could you share where I can find the example code you mentioned? Thank you in advance.

Are you referring to the GS101 TMU driver code? Here it is:
https://android.googlesource.com/kernel/google-modules/raviole-device/+/refs/heads/android-gs-raviole-mainline/drivers/thermal/samsung/gs_tmu_v2.c

DT at:
https://android.googlesource.com/kernel/google-modules/raviole-device/+/refs/heads/android-gs-raviole-mainline/arch/arm64/boot/dts/google/gs101.dtsi#1453

Is the downstream exynosautov9 code publicly available? Can you provide some links?

Thanks!
ta

