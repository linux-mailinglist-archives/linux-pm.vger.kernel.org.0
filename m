Return-Path: <linux-pm+bounces-9473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BBA90D727
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 17:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3DBB3584A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F6D15357A;
	Tue, 18 Jun 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNSBxOqJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE70153575
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721556; cv=none; b=CJGsJGB6v82tsxHDzKoIr4lzuiAlisa2PFFfXkmfHaLFdzPCbtHOueqFug9VLIDAbAdVVaG+NuvWgnh+CQui4tex58NsOK91RVdP35CIVe0jsHlX2Oj5xI2RB4VoKrACh3hBD5XWhVtSw6T3K1Jc/2FXFsSpEMim+s317NC1j0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721556; c=relaxed/simple;
	bh=zrVZtKOw1wtm34lfpGY8EB2vsDosS6TKH8DIDwhCmGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKWSwPTklTBrIW9AqttNCBsBkah4TDaSRwZQDNSUkXnyc8W8b8ILxeMQ1uEfv6xsYJ0JAOpBC/QMt6W+9xXC+BSgcsENorF0VdG0oizPy0JFBvQ84tEodaQ/F4yOi6gIE4lvcxjg8kJmuOjdriCwzeGKJN4fDPugkHEzaj2CpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RNSBxOqJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e72224c395so56442131fa.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718721553; x=1719326353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdAgFpCSfsBaoK3eiN4GlXTRiQPusSTXTIM+J24lOEM=;
        b=RNSBxOqJIstc+XUQn7OUh9Bzi6stsMnI/6slcpqBKEn7bZUrrQF/20HJ5ivM63PoVV
         NtY4EHFLUMMEkCn+qsNclFFnPPgvCgaIZ4upkeSFBARyTQcTXdtl23DYNoJqRmw1MFki
         /ievN6j5MR9ui71olGFCmpk5WyrzBmK51TNKJV/iMeXQY++kAQK/ibOEI/j/ytGwcHf0
         njFz3XdUhoZrZLaTw/6mBGuOvOJAygSGU3FfGvfG98La7cUsbh54LvLEZznEzcQqemge
         mcJgu2BMrCZc/XZuKn7avqQ+b+Es4SxryLQc+/wet1a4zLbEz85UZLQkLZlr9bNFH207
         f00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721553; x=1719326353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdAgFpCSfsBaoK3eiN4GlXTRiQPusSTXTIM+J24lOEM=;
        b=MhD1nSCCoSyJX4xeYTxKC7WRs96/7LrrJOCxj4I3cbp9Ngcwq8iaGccLlK7B030UIx
         jy+1SXjBf5F28Z+TEzZ+dt6Eg+G5SfGHgxSE+jPhntgPhiyuTDNw+v5VJ97pAlnusRh6
         IxWQJtJqNAI2GN/IrE3WgfK4kx5sDtyyRLHqPhS6T3NhX36cYIjt+kcFoiAZ7hbdkHZ+
         SlhjMyYcdY56TSJxq2Xm27hiOMazHl/FEYZTiJR8bAm02YwU//KaZes9eQ3Cbx8xfRY3
         +MZCoXH/dotFgJVZwKCvsLs6ECYEeaAPXJpz3N72SrEVaDajSb7xRrLvTj9baV6dvvnX
         dP3w==
X-Forwarded-Encrypted: i=1; AJvYcCUMq0L61WpyQBiV0v12dQDrjMfS9U3rUGfSutsXWzZXQHmuF8eMtKwhCTFaFzPqupg2kVTdKsjxW74wi67i5gQrEYc2VMVsuiE=
X-Gm-Message-State: AOJu0Yz9vafnPOGB7r9ehCnQ1o62ls7zB35n7k0fg9GthKvnTzbNaIoX
	tgwmRZUxvspKTjKV9+aF5qh6AV7ILANgoNM8dIrJWo2l48qXlz17jphE2FRZBHiH7qGeCsFR1K+
	5Kw4=
X-Google-Smtp-Source: AGHT+IFpKUjGdBUk/w3QFo4wFb49hKoT3v+xxZtiuL1ieNzPlljX7lEbvTogCzQzGRTD99k7+qiidw==
X-Received: by 2002:a2e:a317:0:b0:2eb:d924:43fb with SMTP id 38308e7fff4ca-2ec3cfe9ee8mr277231fa.41.1718721553229;
        Tue, 18 Jun 2024 07:39:13 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c0605bsm17294671fa.47.2024.06.18.07.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:39:12 -0700 (PDT)
Message-ID: <7395f6ca-31d7-4ebc-b846-6c68e2ae2efe@linaro.org>
Date: Tue, 18 Jun 2024 16:39:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: dts: qcom: x1e80100: Enable bwmon and fastrpc
 support
To: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
 djakov@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org, abel.vesa@linaro.org
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
 <be2dc908-c8d3-4739-9f46-8f8daf0f328e@linaro.org>
 <24d2d3b3-d676-8e86-bae4-c3538b7b9981@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <24d2d3b3-d676-8e86-bae4-c3538b7b9981@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/13/24 19:27, Sibi Sankar wrote:
> 
> 
> On 6/6/24 16:00, Konrad Dybcio wrote:
>> On 4.06.2024 3:11 AM, Sibi Sankar wrote:
>>> This patch series enables bwmon and fastrpc support on X1E80100 SoCs.
>>>
>>> This series applies on:
>>> next-20240603 + https://lore.kernel.org/lkml/20240603205859.2212225-1-quic_sibis@quicinc.com/
>>>
>>
>> Going back to [1], is memlat-over-scmi not enough to give us good numbers
>> without OS intervention? Does probing bwmon and making some decisions in
>> Linux actually help here?
> 
> Memlat and bwmon are meant to cover to different use cases. Though
> they have a big overlap on when they get triggered bwmon is specifically
> meant to address cases where band-width aggregation is required (meaning
> if other peripherals already have a avg bw vote on active LLCC/DDR, the
> vote from bwmon would be an additional request on top of that). However
> to make use of this we should vote for avg-kbps in addition to peak from
> icc-bwmon driver which we don't currently do (Shiv was planning on
> sending a fix for it).

Great, thanks for confirming

Konrad

