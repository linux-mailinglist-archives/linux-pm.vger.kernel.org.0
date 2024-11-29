Return-Path: <linux-pm+bounces-18261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D049DEC92
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 21:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF12281D40
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACB61A0AE1;
	Fri, 29 Nov 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1s8HmIY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1F154C04
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732910445; cv=none; b=lSSmiFV8bjZzpy3io96IGru8hiNKrs4Hq0mKzUxvdLLRBFMwzVbx2zC+2WPxwNZXq3Ud67afHOtbR2Xa2GOh3nDj+KWakZiZ1zsjhMpxKy/fqQY9r7ZURorlVNRBCFY/Xckp+XFcj98+68I76W3jmu7NKfkN73a9KsH+vWLxOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732910445; c=relaxed/simple;
	bh=I6vhUfkKB8L2+0ZseqkvOp9WgX+MEIh0yWn2aYb0khM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ga7ZXp6/wpjf+miAgZRt5hcdjn+nKU4VORm2+jyqTMqWpWkmJqMR3yJdbHMswWQQzkXl15smcDbnk13KpLRLZXz0FIIl4vuWD679FdxudWtTT6uLvmmEPmJVUSdY+eHIE8jbAFsv+kP1SDQnHpRXyBAyU0YGyQuVfWX9eXqGPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V1s8HmIY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so13947285e9.0
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 12:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732910441; x=1733515241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXMhlKyNUyXAehCvYmXtBGlWlyuXZ6rNCKB5eusJ9ok=;
        b=V1s8HmIYRyEM9tsFI7IyM23vAUitjHwPNrT4JW8qSFf7hWAkH/dCn9vfCnzpeGhyNC
         mhgkLsuI52EJRCjl37E4I1ju+GFdQM68g9RruVjqI9QesKCheVb1mO5FxPQUwvyTyUdi
         8dmOCJ00GshE8BYyh68x1LzvNFgE8CGT4yNzYt7xleK15e1nQdKsLmgvGFYi669EF5RL
         IZ0PLdwl/GZ6vAOHx+pvYMSwXPhu3LcF1DH3ef7YxCiooPa+LOiJBzgKY7mVBQ0guYzm
         2ctJbW4EzZr48TcdGN7q8FIXyixXW6pWEoXtpyOqwj398xWJYV2osXFaiDFZau//ibBq
         A20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732910441; x=1733515241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXMhlKyNUyXAehCvYmXtBGlWlyuXZ6rNCKB5eusJ9ok=;
        b=tUjxWAzW6ntr7FcmKEpxhrHiwvWaziiow287UhyiaKwYpoUmIn3U0r36kyQ33Mgmn0
         vYseLStYLyKeq+NRZ0jVFc0Pza9fUz85bDUrhwWkNGO2bSNCWJL5Xq3Cxrvkm99yuewT
         Rr1rSl7qZpmghxAd+W/g+O8pEGpQbJdwJ6iEzhg1GTuK7pd+rZONgnQCgf1G21AeM41X
         88CjoTWBXyMQueI0cLKJFjMbZ0PgPpTNCKIm8H25RjKKPgjZsuCMWjNu0WnsZB9+qu/C
         iQPV+djLQw85Yt7CmHD+6fUkIidtEh6qGBSlxQwxcE/mwmgbGBNR8b9S/ORtGGM7OovK
         +INQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf54P+n6zbS3V5kX0qmvqhDFj9n+GPlXWJsCXNhyBbZuz4zB77RnmfZdIFGh2i8I3bk0jimXv8oA==@vger.kernel.org
X-Gm-Message-State: AOJu0YylPfMsxXkjL1onOkNdef0C8nf1+TH3j+rk/TCH8GeqQ8zjjkSH
	bnO3UV4bBAjFNMR6iXFo7Jah1rCrtrrJWsdwBGtJ1YNFZNVgQxUM7Dkn+a6X0RY=
X-Gm-Gg: ASbGncvolFdAFg+m+TFgCkI676nnwxBmj7qzj6qOPqvarzOiK/3I+qlNboZsB1L7tQM
	Bm7ya+qgaKBF6cojLtgxyN4iGHL6F0r4+M6XG5f9p88dCRTohDSWVBzvCuVZymRoVOnOAf4sXaa
	4a/NtaI1ObHUNfhMFBacfGmNf/M52Jm2KaJ2vU7WrVPHIlrvmeTafMPgooR4zcgufqhC0DgTYdO
	qsyqNgPE2ff+SqnDSnTNIEclPuFFqTnILlZGntG2bbgYlYrNZBmA5Symfc/8xDWBAodNC+yCfKS
	ncYVerREFt2hgA==
X-Google-Smtp-Source: AGHT+IERDYwDGnHxt4PkrEbc7nYmk1O9LCWEyDw4b8b+mn5ibUuFnpDyTpQ+9yD3eVcYFhLRJEKXzA==
X-Received: by 2002:a05:600c:3b16:b0:434:92f8:54a8 with SMTP id 5b1f17b1804b1-434afb29148mr77259745e9.0.1732910441500;
        Fri, 29 Nov 2024 12:00:41 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434b0f325fdsm63936945e9.30.2024.11.29.12.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 12:00:40 -0800 (PST)
Message-ID: <20d3a0be-ba5f-439f-80ff-2e2bda3bb144@linaro.org>
Date: Fri, 29 Nov 2024 21:00:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] thermal: multi-sensor aggregation support
To: Nicolas Pitre <nico@fluxnic.net>, "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Nicolas Pitre <npitre@baylibre.com>,
 Alexandre Bailon <abailon@baylibre.com>
References: <20241112052211.3087348-1-nico@fluxnic.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241112052211.3087348-1-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2024 06:19, Nicolas Pitre wrote:
> This series provides support for thermal aggregation of multiple sensors.
> The "one sensor per zone" model is preserved for all its advantages.
> Aggregation is performed via the creation of a special zone whose purpose
> consists in aggregating its associated primary zones using a weighted
> average.
> 
> Motivation for this work stems from use cases where multiple sensors are
> contained within the same performance domain. In such case it is preferable
> to apply thermal mitigation while considering all such sensors as a whole.

Do we have a real use case where we can compare the per sensor vs 
aggregated sensors approach ?



> Previous incarnation by Alexandre Bailon can be found here:
> https://patchwork.kernel.org/project/linux-pm/cover/20240613132410.161663-1-abailon@baylibre.com/
> 
> diffstat:
>   .../bindings/thermal/thermal-zones.yaml       |   5 +-
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 210 +-----
>   drivers/thermal/Kconfig                       |  27 +
>   drivers/thermal/thermal_core.c                | 643 ++++++++++++++++++
>   drivers/thermal/thermal_core.h                |  14 +
>   drivers/thermal/thermal_of.c                  |  86 ++-
>   6 files changed, 780 insertions(+), 205 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

