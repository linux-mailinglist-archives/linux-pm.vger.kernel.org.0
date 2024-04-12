Return-Path: <linux-pm+bounces-6343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C71348A36DB
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 22:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D2E1C2150F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 20:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B01509B9;
	Fri, 12 Apr 2024 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxUqjrxy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846714F9DF
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712952951; cv=none; b=SOjdiML6/UyacTo2c0k+uPRAL164KUr+mKQE8Tb6tt1O9aQMIkSpKWpEUFl7CNY+9x8R24HOY1fO1ngZKA+XUn9dBN/EOzdFGIZTRUQjGPwvJTFZD8XiSoJ+HDMx0Gohkm/zJNsn7J/fxJKAdRGerTboLbyZuk7fc9s7uHvTMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712952951; c=relaxed/simple;
	bh=I8mYRiMTwYIuYH0sx3PH+V1h5Zoz0qzEcn9x/5NP0Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcNR8B3OoAhrE9KQF/UpDt2Azu3Ots0eKuBgfZRZ0kkOZRXLG0k5R+RelEc53XsjYgkMs1HhpfguMmlFxx/MVltLz7JBIKfjXSRQ+sL1G57AiZnJ7tHXefU3m21TH3MKOIOYktcV+nTiAvkfCmAyeLpDZPj3wkW8eb1xMAIjaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xxUqjrxy; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51beae2f13so150293666b.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712952948; x=1713557748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AZGnnSq5y2YjviTAKNxk/PkgHCUA3kk34GMmkI9ABc8=;
        b=xxUqjrxy3Amgnq1uxdLiIOVIr6Do5arNNWv3DtnxMYvTOIawAoO/2P5yh1qCUmme6L
         knxoOc7gv4Mo6kSsCzdmll064XZ4ncfyMSwWtI23giPhVZH7XQl7dOTGg0b7CHezXHRU
         mybiu3qy49na63FcMmGe4fdGwvRQYn25fmXlPnCGICgg4cJMmqkVM81MQMTXa5S8CXdW
         5cDiLBakhzsLwJbcKIIVtWQNF1hJ1yqCgeusmcpJ4va9J45jCw61OUNM4SWeeMD37txb
         h4wDgAoEuZQmMaXAA/qQ1UiYxp1TySD7CfUJHK0uX+TMe1IcHEQte2w0Fh3TSJcK6uWW
         beMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712952948; x=1713557748;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZGnnSq5y2YjviTAKNxk/PkgHCUA3kk34GMmkI9ABc8=;
        b=HGBs7Ju+neDvNR/rKJ16bX1UCO6hyfVHNXmkH+q8od4CRj0/8B0DcMtFGN2LOoVlQF
         uGYa3qQuYXMtQERSi3hauBXWUXh5cvsp9i4hOG7gtww295u4KXn8uttmO44dP/N5pyG9
         vIL7MG0u4xwMvqoP6Ux+VBNVJkPI5h1m9U5fiNEtWpVGxh72vhJFNMuMluDTeZBRpGgf
         Qx2Fht+UmSxskGrKuNrj0nf1s7C/8jrlz75DE6igWuLiV8mLuJkPW+ikOnGY2TH2snyq
         C8UMrp7cyicvq9ilG2StG0FpB7bVCM0ePosy4XdKGq6wxINzH6mctZN8a7HRv0uvb4OJ
         r0mw==
X-Forwarded-Encrypted: i=1; AJvYcCVitZFE7YD5dpERUv6Cd+DI2wmy+DvvmMWq+8CkGT2c2N1JhygAwMrqhegQJ+zrQEMgnDzEJ+rzeNMfyt0UhKXmpkF8gwylUOE=
X-Gm-Message-State: AOJu0YwpwDkkgDw18W9p7EOJcIJDz4Ke3BODiJ11YAKROznztnmlqpJW
	hq9nCeHUQcuzL6nPSwsWcxjE3F5zFc/ikgaC+3KVgcDkWtTarxJk2iYJbTF6Uz4=
X-Google-Smtp-Source: AGHT+IErE7H/QNWnJ7SH0rP/IEm8DMZbf06sr8x0A/7pRq1VladppOXqPBHoRNpeoUU1S6E6rscBeQ==
X-Received: by 2002:a17:906:fb87:b0:a52:408f:8575 with SMTP id lr7-20020a170906fb8700b00a52408f8575mr857891ejb.12.1712952948336;
        Fri, 12 Apr 2024 13:15:48 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id dm3-20020a170907948300b00a523b03a1edsm876114ejc.20.2024.04.12.13.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 13:15:47 -0700 (PDT)
Message-ID: <d1474567-2aef-4c7f-9b2b-11d7f61af2e6@linaro.org>
Date: Fri, 12 Apr 2024 22:15:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: thermal: tsens: Fix null pointer dereference
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Christian Marangi <ansuelsmth@gmail.com>
Cc: Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240411114021.12203-1-amishin@t-argos.ru>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240411114021.12203-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.04.2024 1:40 PM, Aleksandr Mishin wrote:
> compute_intercept_slope() is called from calibrate_8960() (in tsens-8960.c)
> as compute_intercept_slope(priv, p1, NULL, ONE_PT_CALIB) which lead to null
> pointer dereference (if DEBUG or DYNAMIC_DEBUG set).
> Fix this bug by adding null pointer check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: dfc1193d4dbd ("thermal/drivers/tsens: Replace custom 8960 apis with generic apis")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

