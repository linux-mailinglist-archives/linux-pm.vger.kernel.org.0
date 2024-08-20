Return-Path: <linux-pm+bounces-12589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F81958F51
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 22:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C21283E7D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 20:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE41C3F08;
	Tue, 20 Aug 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGIjS5jV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D50125D5;
	Tue, 20 Aug 2024 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186900; cv=none; b=bHRZAoMEcKqLQ1w7kRl0Yu0SJv4U2wslBeXRA2mU0DRJTeyR+Aubm2uRP99ZekwAzqlQ53nNswrVTxGJrdHA9LJbgiodPwp/NaTH0KtRKjV+/0cj9U4r0SawMPvnWPh+85IEXHPMIErS4oQlSIBOrjHSvjdr3YTH5laLqIfedsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186900; c=relaxed/simple;
	bh=YHZKIU/By4p6MXtfCFWkiNIv/NvyHyQzbsI9IEvKDas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIfrSKs92rhlx4KXRnJcVDyWcaZVysJuaTmCygXNYXCP/Lgu35wSVtK+cMoQsTgvs5Kk4vCjLea0Wl15fG9F5q7nQ8sZTgSBSTLJFCLOEWTHl+IbJYmyJA0MmfUtnyE/MwvgN1RNiQR4QOR3unnci3cQK4nPC6uJ2jOf3lvBGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGIjS5jV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so2642622a12.3;
        Tue, 20 Aug 2024 13:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724186897; x=1724791697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=so5U4dRsxPkkX00TiAViSu+tVxm9yDMG95NIiH1QnPs=;
        b=QGIjS5jV/f+wmBC5DzBtoRLDl9cOOPuPu2ZZe2ReBWXXh/wmIke2zPp8mMqwaOqSyZ
         ez5wyfpDDMRHhJ2q83Cr8/9GTnZTRsQl87yimi9d/rnRXos5MfvlxTWAxkTurmGqGQuZ
         arqfaesgl4aqdYp3UtJVF1CVm/63gieynRwjMZ7HO3Zrsq9u1OfwjdX7BpuuneH2ileQ
         g2Kxmkaqq9gw10UP6OXd4NKvAzQjo65mXbIwfoVaLoqeWVv/njaQkFB1FZ33222/wpge
         rRANw8WqqoCpJDw9DDkZ4bZ4qFD4dJ0PydWmUgfNFqte50eKIM5wpaYieV49yqeAdu24
         02Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724186897; x=1724791697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=so5U4dRsxPkkX00TiAViSu+tVxm9yDMG95NIiH1QnPs=;
        b=G2mwD5T6S2D7G9Kueo1NT6jFfjNsLX6dnOtUqHJ3SSgRSApLyMpLsqCLJXJYxckV/L
         oCRp8zbxJOMQiHi5SHvG5UqqLRN9EcbAVK5S9aSzomOz8as0kGMpdq8mHnp0pw2Q7d6S
         y1x3BSiKu/adzBj8K7L0A0BotrPDpW/nK+y9wP+WhQjrDWlybHneHhHvNAGFLOPCv+o+
         Tjwp+q1ScsRm0RZWd8xEexwvddb1mQ5j01GPWlRlyGGEc9SGMpHQPTX5nESARhWta3ng
         6tLC8ont898nKr/gJVD6t/1s9BvXF8HwGhH561X13H9hEk325FZ0OhdbPp8k/2+7WnCN
         rBjw==
X-Forwarded-Encrypted: i=1; AJvYcCVDnND9fgqg4To9BeHAhYsFeUOfAofm75qlxQOiyofckpfxaJdwqU0Pz33eRfE0yEcIBcvBZMBCMLC2tTQ=@vger.kernel.org, AJvYcCVM+2Myxt7Disy52x/83bGKfnVr488Oen+/tFtM7rozbHDkF19TfyDP9QOk8RXGFlaCReVEZyScWULET66D@vger.kernel.org, AJvYcCVuPsknWYA6g8FARe8qa0OU/uljLwWynxjmB7bFsoWXzeuHalBdG0GtfFlX0y6eWLeP4ZYYo/DDr2s=@vger.kernel.org, AJvYcCW6WwXqiiJ+c0T9Lb5aC61xDdeR2xbtbVHtbTPgkSlHujVaSTFQqwbZ0jwdXKHGM4mHVyLXO5lqDlz/wmq1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe7HUzX/7+5+aRcSdeuMCvNHCYfMtb++sK42AJ1XsVPOmk0/Bb
	MWcZGO8gfL8LIamrTtPoxbRVh34oMJtxorQU8ywkvdZ4ajlV3eLZ
X-Google-Smtp-Source: AGHT+IE8OvIlzyLozb80N9u9uEvUjTzp8MzB6n+B3MKdIYKYNHYOwSrQchP3hlfbZVtxOUrw/Y3N1g==
X-Received: by 2002:a17:907:e6c3:b0:a7a:8e0f:aaed with SMTP id a640c23a62f3a-a866f7308d6mr19603266b.50.1724186896605;
        Tue, 20 Aug 2024 13:48:16 -0700 (PDT)
Received: from [192.168.1.19] (79-100-234-73.ip.btc-net.bg. [79.100.234.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838393457asm799398366b.117.2024.08.20.13.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 13:48:16 -0700 (PDT)
Message-ID: <0af670ae-8c8f-4e78-b1e0-e9ccb4fba2c9@gmail.com>
Date: Tue, 20 Aug 2024 23:48:14 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] media: venus: Use dev_pm_domain_attach|detach_list()
 for OPP PM domain
To: Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vikash Garodia <quic_vgarodia@quicinc.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
 <20240723144610.564273-3-ulf.hansson@linaro.org>
Content-Language: en-US, bg-BG
From: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <20240723144610.564273-3-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ulf,

Thank you for the patch!

On 23.07.24 г. 17:46 ч., Ulf Hansson wrote:
> Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
> and manage the device-link, let's avoid the boilerplate-code by converting
> into dev_pm_domain_attach|detach_list.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/core.c      |  8 ++---
>   drivers/media/platform/qcom/venus/core.h      |  6 +---
>   .../media/platform/qcom/venus/pm_helpers.c    | 31 ++++++-------------
>   3 files changed, 14 insertions(+), 31 deletions(-)
> 

Acked-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>

I'll pick it through linux-media.

-- 
regards,
Stan

