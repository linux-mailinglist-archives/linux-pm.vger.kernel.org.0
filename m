Return-Path: <linux-pm+bounces-1585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E34D81EB13
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 02:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335B01F22A65
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 01:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5826B1FA3;
	Wed, 27 Dec 2023 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IG5DCc3h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C11C23DE
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so3797645a12.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Dec 2023 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703639238; x=1704244038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t4tMFvEeMgMjXLstJzcFftKZTc5NR15boMM+FQhmp88=;
        b=IG5DCc3hzatQF9Js9Bu7n+sD3kvelDR1mbw/AIuRQ5Sb97dITbBr5/wr+m8LjCWN5u
         9J5P69tvPcArag8hSX9o0A2cLSA5EWiKa90N6rmKZ7RLjzwrtzKjRyd1RsgrlXcG/Kvb
         23MEdm2C5p6xkonVJn4rmDU/ohpF1Gb62QQMDY/2x1uRbuah+XilmC/QYZbj6BkNOdGR
         WLRRfbNsk7FTPVgTdn9selFWSeKv+h/e/eMOL97A+WsNpqDkZeG0Wmajr+HhUbmlQjXz
         xPzLDbcrHKndB15JXXu5uLYutYAnraNG9PltKroKD8FssP/pxRMKMutEFhm8bbIqFlzw
         DKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703639238; x=1704244038;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4tMFvEeMgMjXLstJzcFftKZTc5NR15boMM+FQhmp88=;
        b=T1QRgjNaA6jGVlUOvUUopdiO3tZtw4ewe0BiWQqe4Q5tnYBtckoHxXxCStLts6vATh
         jcqIey2Z4Ih/EKKs3EZP9fDlBjYoZXFjV4T3SLPFqEgV5HyZobQLFbxqsDAOTRm+31L3
         Ts10w+oB1dgLVQymHX+oZL/T13g5d9eELG9b5qd9nGQ+YXBTTrkJL5GuJ91s8IVfm2F0
         5j78E9P+7eeszVoVTWYiDoNX2kgJdPTbSyY3YKBJLXRU70Q6KKn+70eqpHo2BA2fUcE9
         gnZXPokjhbAcEMR4+lqwQcI1jqepR2gdPAThs9nKscipTWiKhRj6XyXTISNziddEHbXx
         DOlA==
X-Gm-Message-State: AOJu0Yx5qGjF5fHJeFt1bkhB3CqM9mLU4Mu4LL3rxYLZkb5kiyT4p0FL
	r5gM46YkTWmz/JzH472ETpOm6V2wxZhxWg==
X-Google-Smtp-Source: AGHT+IGZGUY+ComcdEv3TyZJpAQYnWaCNAV0YpFmNZdDLTG10Crgm8nPIvZHBhDmwODdKfuPMHH2Qg==
X-Received: by 2002:a50:875c:0:b0:553:8226:da72 with SMTP id 28-20020a50875c000000b005538226da72mr5950719edv.16.1703639238415;
        Tue, 26 Dec 2023 17:07:18 -0800 (PST)
Received: from [192.168.199.125] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id ck8-20020a0564021c0800b0055515b40464sm1599865edb.81.2023.12.26.17.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 17:07:17 -0800 (PST)
Message-ID: <43728d36-0d20-4e1e-8671-726c29d09a2d@linaro.org>
Date: Wed, 27 Dec 2023 02:07:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] clk: qcom: gdsc: Enable supply reglator in GPU GX
 handler
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold
 <johan+linaro@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
 <20231220-sa8295p-gpu-v2-2-4763246b72c0@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231220-sa8295p-gpu-v2-2-4763246b72c0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.12.2023 05:39, Bjorn Andersson wrote:
> The GX GDSC is modelled to aid the GMU in powering down the GPU in the
> event that the GPU crashes, so that it can be restarted again. But in
> the event that the power-domain is supplied through a dedicated
> regulator (in contrast to being a subdomin of another power-domain),
> something needs to turn that regulator on, both to make sure things are
> powered and to match the operation in gdsc_disable().
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

