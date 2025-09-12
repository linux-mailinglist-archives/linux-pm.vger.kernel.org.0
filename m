Return-Path: <linux-pm+bounces-34534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7916B546A6
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 11:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143EF163FD3
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64A22773F3;
	Fri, 12 Sep 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTsSaNu1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F17255F31
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668579; cv=none; b=oFpZUbKy8gC3P3k8HUQRJdtoNRhDehCY6jxga8XgUMCLTWcYDf05Dy8KdWwC+byYR7kSUCf+QPNgUGCZdk6O444bVBauDk0UhSlM73OZRcsz3utTxVHhxF47SOkWybnorrRz0m+XFJRgSe5909oalkuagG48zld37qpksrUWV74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668579; c=relaxed/simple;
	bh=rbS/1vMnW+r9vE3ko/WdtF1tXfqWrp2841CIMEd3PnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+M/CO0IFm7t182WC5qXF/306TPGK/qMDYhXu6cJkFzI6yrAR0e33g/WgYZ4geHs8o6+0Fk8nlEgCVY2QoIHtAkmoE5ppQIYeG/D2kFg99k5Vn93FJ0jOaqiU3Esp9wVav5yhbG/F9rkptVp4zGF3jnFDGVsIEVRHzn2GcRNk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cTsSaNu1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45de8b854b2so635345e9.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757668576; x=1758273376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AakhypBYQL8o+d6jwji8uy7YTM/iJpZSs4ckPqgcd2U=;
        b=cTsSaNu1mALFJ5kaj0JR++tpxC6WvbsNC9z/zZLvIis9kB+m1v+Fs7Kg4oM3+o5+d/
         1S3mjwyhTZ/qzMGFU51n9fRlIcD+CZL/dfcT9WWhSjRIYkNfndv7R9tuqHfEuxhhnIos
         Qyk/utQuX15bG4y7AeCUgPS7aU5c73yKUMZ/2FdeGLUowFL0OC4qKXPv/Jd5pvgm/zaX
         Ugv6thr8HuOgOJdX+kTksWx/qIKpdZ/FK3veQOvmuu4JKcdAtkQTaMY0mcQj5y6WmfGO
         1YsoRZ4H0Ult7BsNu8mUoJfHhhI3nOOSjHBKESPSs1o7UpUYjkvHXINmg04wCiIJA9ps
         TM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668576; x=1758273376;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AakhypBYQL8o+d6jwji8uy7YTM/iJpZSs4ckPqgcd2U=;
        b=ToumruTaimFLwEPNY93n7mgEvftkvg4Tr92ldRt6wMOl8jdFzaToAMGx55nR6OLX+V
         /hPg1Wf91hlQ5Ig5AVyLek7yhsF2gjAn77wsLwRV3RJxEF3NNNRiN7fitYipk/n4cij2
         7HKTlpynQsHKUqxJGsu7Za9l2/ZzPYsoE6i48IOP4O0wXiqp0K2P3mEFtv28h7hmGJZM
         fWPPDZdGjPc2q0B9WX+VzISy7UsgrUP700+ifwHShZtB7WNaSJ/e44/BS/blwMP8aBXb
         JKnoxwuwAsBleHFGipFc7BqnrsDRi09wGPieGPQEbF6Pp1/3bw2I6b6NDqc8mNSzM7jG
         I/ng==
X-Forwarded-Encrypted: i=1; AJvYcCUmJjLe3SCeGXfwM9rUNlw0ETta/fr/qY1tY466NgN0mObUbFsWXU55OyDIcbKWpGl5NcXUZVJ8yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOMUfZvK2njGZASIiVs6Gr1+/DfGWIJ86pXzOVM2en9l72mfP
	HujptaRSWUHGwESoaDv94h3RE2HU6qBSJvzNst+ufoNVYhvDEArioX6kwAkkzcz358s=
X-Gm-Gg: ASbGncuw2qgtZ2o/FkWNrnGJ336bR4ysoi+KaqaK+GWU1Vj/ieElX2byqpKBLYU33c9
	MXbbxc7UYOAnOnFsTdQceCs2TkmjZTjXkHNjqoK8KwzZPVRb5lYUuVBFQdSNPZ4wwujLG0hnFRM
	kRy1YJwEYlT9TvBR5xBmfunDoJqBpjJWEw1W8fjXwVsvNa/Ljvqi4iMlyA9teEVOzGX4PYUAaVc
	+42gVtxbyFXngFL0gg0BzIF1+nKJNojkvfqtlkYhGlvjvBx5W+Hd//Aix8wJ4d0vHtHLb4DgxKX
	sAvmoWfu+D5oFZvBisUbP7Dey67pzwa6pJAQvErWmSjCW4tTndEarURJ0TuMZ9Lj9SOtKsvZn/p
	TYqDWTqsDC2ev50Iv0iS89+y6Na8yuw9ij2MJ5VdAXKOUOe6aRX5zCQ==
X-Google-Smtp-Source: AGHT+IF8vJt3OJv2R8HpQH2zes8jRU5cdpMi8Ohs9bCmtG+T7zKSQBaHZYMDfUi9FSV/gYpCZFu5Ww==
X-Received: by 2002:a05:600c:1c87:b0:45d:d33b:4697 with SMTP id 5b1f17b1804b1-45f2313d499mr6962295e9.3.1757668576008;
        Fri, 12 Sep 2025 02:16:16 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c9d91sm53878945e9.20.2025.09.12.02.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:16:15 -0700 (PDT)
Message-ID: <0aa8bf54-50e4-456d-9f07-a297a34b86c5@linaro.org>
Date: Fri, 12 Sep 2025 11:16:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] dt-bindings: clock: Add required
 "interconnect-cells" property
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
 Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
 Devi Priya <quic_devipriy@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
 quic_linchen@quicinc.com, quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
 quic_suruchia@quicinc.com
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
 <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>
 <20250912-nocturnal-horse-of-acumen-5b2cbd@kuoka>
 <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2025 11:13, Konrad Dybcio wrote:
> On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
>> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>>> The Networking Subsystem (NSS) clock controller acts as both a clock
>>> provider and an interconnect provider. The #interconnect-cells property
>>> is mandatory in the Device Tree Source (DTS) to ensure that client
>>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>>> the NSS ICC provider.
>>>
>>> Although this property is already present in the NSS CC node of the DTS
>>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>>> omitted from the list of required properties in the bindings documentation.
>>> Adding this as a required property is not expected to break the ABI for
>>> currently supported SoC.
>>>
>>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>>> binding requirements for interconnect providers.
>>
>> DT bindings do not require interconnect-cells, so that's not a correct
>> reason. Drop them from required properties.
> 
> "Mark #interconnect-cells as required to allow consuming the provided
> interconnect endpoints"?


The point is they do not have to be required.

Best regards,
Krzysztof

