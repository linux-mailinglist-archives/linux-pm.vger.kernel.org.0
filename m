Return-Path: <linux-pm+bounces-32554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D4DB2AC88
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF2C188BE02
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009F22517B9;
	Mon, 18 Aug 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ky0zabez"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDDF2512FC
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530246; cv=none; b=pHwZrr0lKYxsuiVMqTCGgWau9Xz64rvBg7+W15j2ioWH7839RCKpxB2Uh45EXK3J5s6Fv5Lth4oF/hTxhH81RrZwOm9Jhz08E9x10WcGj4fAJVocFW5o1UMFWptK/Vm5eynkpX7K+iys+Hgk+XuafQPd/2v0g2IJcUi1DV6COIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530246; c=relaxed/simple;
	bh=57TgCTUzq2WeMoiCZcm+8XUFjfrW9B/gu5wfo9wb4QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DI5RPJd4oTb7loO5H1RQDXRfA6iZlvoj4qgABxdyGTO/6DzY4OMIzTnAPoFIgFnyifkQiOI8hcbt3ibq8I4QQajTqvVvtGtXESiCMWhFiCUDFUx84VSmd7uUDXje22GjCbO9+aW/aF5+PaGMWcz2xuorPcONDZ6HD8ZBppwHY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ky0zabez; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a25ce7978so10351655e9.3
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755530243; x=1756135043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruLwnYHr/tBzoBul3RZxZxSWPFtDBWMLZzMZDWq7rDU=;
        b=Ky0zabezibiUhlGoPyxGYX9+ryKC4iqNLppKLCz5DHvL/f0KYpHTtfkyuO7W/K6m/4
         uXiuxInsbLhgmurSi04hUGyI8TEPiE4hcR+Nkee1UhB+LoGPEBoJFC+U3nQsvzxmGWTN
         IiY0xV4dJSDqlqkzRuVUZGSSSVbEvaoWrKkpgethdcshEBRlxPBA6IVh16KrxboOO3Qv
         uFOyuD/oGx6Ivi3oBaXzY/90B6vlUW9A53YwaCuCcgTuJNjteWopekUXBumUM7Xwu9Y7
         9XTBLTn0F61M1/PP77LzQ97VaydDPZgvPAh8vT+waqUtXE6qVsRcGiOEmWTDis4F/ySZ
         A7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530243; x=1756135043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruLwnYHr/tBzoBul3RZxZxSWPFtDBWMLZzMZDWq7rDU=;
        b=NNXZLkxVpbB+yFqTd+j3waSnuNjqElfWJLTpiW12MdYFUB+4vgO+tj+RcVd3a/9fH5
         1ShKoX0SVBflYnvGGcR6CcZShwIrb9/cGkRd9Jp1vExjlmj6tw6Gns65V2cuRyN4iBpR
         BwVi6CGyo12TnmPdB1iFYv2zLZJ+Q2OkhWO/RBG6zOISp3+9OBqDZlGCiM9J2EqbPyH1
         Qk5Uknp24r/tB1moWDBqphAmR0RapOTEGIoN/C1YnJDIl9GZzVvnVPlV1chDFk7XBimx
         7T7z1vv3do3jMZuoW08JoqCXGZ9ke1D01EXEb9/4iezgWUKXEtSuSc6wLcHFLN7GAJX1
         t4sw==
X-Forwarded-Encrypted: i=1; AJvYcCWCX41EMVf3bnO0Y5INDR0KcAAChpCo4HYb4YwEL6qmjOzQ8jRYXimO/uRaXE+HDVtxHzKgv8LLXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YygnGbQKxq029TnBwkDmbKi/BFJrlDDskz0OO4FTo8fmlDxKbSk
	xmdcLXYt8XIcA4q/EZYkCvT3jr3ickXCiSEWBjaagSUgwQf5pvVN1+rYpjOP0d/jnhk=
X-Gm-Gg: ASbGncu83Lw0vbfeI9xQ4jnxESVzfqn6Llh04jBRwu2nWtuuzeRYlix4pc3+OAdrxeL
	ha+1gLRmIGl/tHU8OIUZ+8cqt2d8f6txYq4CMv6up3hKnBevHc7FHWe6B8X9TaMjA31oXVMlmHx
	GRvaKVUNHKUZBGeUNPie5VRKtuEk0wiLnaMjbtdX3WZJuAqcYsNJujTkRzdLVDtKojq+IrA/ydI
	fxb+z+QZSC4PKnf0KCyt0oo0IH+Y1M5qNQdeUNJyzANTwoUrQ1OGDaZpjNWKpawqwWWbWTxQCzv
	Jg910tQXZnSSe+sMUQW4g/2bC/29Wvrqqq//7SWEPDTH9JSL/Ey4adJLB4avk8Z6+pKRnmA/GYj
	AV/9+MuTn6+UTkTOLXFp/mAfyaxIsLRT6Dy7+qPsE6slopM+yDHbEJrTJfYZnqbVOd94QEtWonF
	7oIQ==
X-Google-Smtp-Source: AGHT+IHZilA2/hfOmnugF7xNO2vU8LKQeJJYan3o2cZZIRQ3JL1zMo3LM0oL19y1UKFY669tejoA6g==
X-Received: by 2002:a05:600c:4ecd:b0:456:1846:6566 with SMTP id 5b1f17b1804b1-45a218573e1mr102634755e9.29.1755530243510;
        Mon, 18 Aug 2025 08:17:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7c42:c1e9:a3ae:dfdb? ([2a05:6e02:1041:c10:7c42:c1e9:a3ae:dfdb])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cfed5sm172006265e9.7.2025.08.18.08.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:17:22 -0700 (PDT)
Message-ID: <0e40af2f-bf57-48cd-9485-5321a05c909e@linaro.org>
Date: Mon, 18 Aug 2025 17:17:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/thermal/qcom/lmh: Fix incorrect error message
To: Sumeet Pawnikar <sumeet4linux@gmail.com>, amitk@kernel.org,
 thara.gopinath@gmail.com, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250710175426.5789-1-sumeet4linux@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250710175426.5789-1-sumeet4linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/07/2025 19:54, Sumeet Pawnikar wrote:
> It was showing wrong error message as ARM threshold
> thremal trip for setting LOW threshold thermal trip.
> Fix this incorrect error message for setting LOW
> threshold thermal trip.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

