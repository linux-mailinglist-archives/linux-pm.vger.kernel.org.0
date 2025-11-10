Return-Path: <linux-pm+bounces-37745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2413EC475F7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 15:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C4B3A52E0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C4D3054F0;
	Mon, 10 Nov 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxJkC/Kd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C630FC31
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786632; cv=none; b=bb3WbwKHBUktZqag7QCK38amKLeytELOEuA/AH1yTWuq9COu1RZq7fxY6w+ORG0bWfumZ5RMYQBzHIwlMkNgXpQHENCtVB2RWr9J9SOW/AiYfs80v+6yTx4cQUQkCpLkh+7DfvSEbu03DRIgP2njPloLZ+ylu526iRiS+/GxOnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786632; c=relaxed/simple;
	bh=2oEllj8dCqSulcZQGg19BVaDJTGOlU6ELfe5iEnMGKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUkAHo061kwqzVTGafwHwm4MWo5S7IP9qDGlyYJ2qn6ZV2Q3Z1D7HS/TCrO75Iz30G+hb6bYVf0CvVJbkvgQaCBpcjrYEqG/LK+4TF9BVS3xiReAqp0DIoiF08+Zx4f8EnVongPE9bWnR3YnGhxRZnUxbNcjnJSY8bgiXHs+CnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HxJkC/Kd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47755de027eso21427555e9.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 06:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762786627; x=1763391427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1/BWFGaFccj6j3mKB3uRrF8HvHq/NnGS57+1bortLI=;
        b=HxJkC/KdDfqoIcRff/PiUN+Ap1G8VRv4+xfUPg6fe+j7f+e/C3/QYbQxGSP3xkB+vj
         DzdOsWjkmXO+36hCc9ROscSgODRF93vKku1IRfcDfIpb/1I9tbjCwZuEvEbPwe4jYBeV
         bRhTx/qZ7gQIcdVB9vO8nUDHGx9gI6q9hCY3CeQWv8ukjpIFIsrk5QBKSSDYl2bJJB1P
         XYBTz/86Be2yMYYBOp6toNAawysya2ig3WRrbf6WtLlhSskuJrmQLkjSyls0q4Z7X6wX
         NZD9HULiPwL3gBmPCFGJ9k31k9p934E9taqcSmwlkNGtQTiJMIXm07EdlZvmImFT80oF
         1dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786627; x=1763391427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1/BWFGaFccj6j3mKB3uRrF8HvHq/NnGS57+1bortLI=;
        b=NdqLES9EEiLt/Y9pCEKrZCv8wiJTq6eOyAPdonJJhVtmVIenLAnlFq1hYGyhiLb64g
         TftVZrlf0kviizZX4n1Y3/bUO3WxSmMUFycCbtcVyOlhyRw5a0PHiiOFPDIJb2Fc5ZyK
         dsNHiliQTxe1Xtq0IrsJONHS1ZcbEFtOF1/2lpn5m2zypZO0xUg+RkQ1DWjt+CC1WROk
         GBP7oY3TF0snoctm1FSDqzbYIPfD/TyFVjQ0KumbQrhXVCHVaDf9y+Adv3htJQmsFa68
         yG3A4OU1mo7UCs0ijRtV4tL8oC/A1gS9HwoGqLpf2h9kUf5OKdRLlaARTQWFTS9b848t
         1r8w==
X-Forwarded-Encrypted: i=1; AJvYcCUGaYp1jxazNvC9FSuFTJUWn88zh2YtqXzJcD8Sa4e/k9FJHqw0vUcWv5i1R0tj/NecDbmPmCgXyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrXeaYREY5RcHoQBLUaLp7NIapeUAwuOnRjpRyBCb2ytzQm9nt
	mdoMqT9nOXF8dw0+cd+djZLvoD55y8K7WZjOUG18u78oK0ZEbRkSOq5DrRu5v1Wmn+tfGzVMW5Y
	ML1PRXWU=
X-Gm-Gg: ASbGnctusNFHV6jGc1oOVXuYCE46vQFsD23+NHsrLyeUv2I9XtMqN00O5VqNgiFLw5l
	wO7Y+lSxjsk2Qck9mzv572rXknChL3QCZNkl40tsFoR7XzH0cuAbHN+xb3VdxiRpFp38K0lQ3mi
	LdNtUQmCMIckJZCooTNC5cwKpQ+9EsscoZcdkYoDqPR0B1aGqEDHuWWKBgZslOf8LGmq1ldz9wB
	+Z5zSZLQBC9CbItKFfURFJS3PhxKdluyif3/uXk+2dOo/6rn5SpKhKdViQUUGXTJC4xTWfToTua
	o+OfnAQK21DnXWVnjbdohYhQaSfxH0YLREc6qB7qCfWNM+VvRAlviBVlc8N8Nz1Ihb4xGh/gHLm
	hhv4iZA95cDOKvYVBBVG277gmWSUVIGcEuHnjisMaOsaE8I1hBGUj8l02c2ZzSc7DMC8Wz0cpwp
	IDaXvfRKfTZgfMSQE20pK0bX8lDzpW99LRdAC/ffiHNGT4uJIqY29KUd0=
X-Google-Smtp-Source: AGHT+IEayVbH+dmDV7pA2KCjknsoPD0TJ3FV8XjsLtb/y0nHMpmVN3MvBoYUGIMEhfNvtTengSgh/Q==
X-Received: by 2002:a05:600c:1c1c:b0:475:dac3:699f with SMTP id 5b1f17b1804b1-4777322f0c4mr78450325e9.9.1762786627312;
        Mon, 10 Nov 2025 06:57:07 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:2b20:d700:6e9c:533c? ([2a05:6e02:1041:c10:2b20:d700:6e9c:533c])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac675caecsm22731109f8f.30.2025.11.10.06.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:57:06 -0800 (PST)
Message-ID: <12704dfa-864d-407d-b567-8687d1365739@linaro.org>
Date: Mon, 10 Nov 2025 15:57:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Magnus Damm <magnus.damm@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
 linux-renesas-soc@vger.kernel.org
References: <20251110143029.10940-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251110143029.10940-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/25 15:30, Marek Vasut wrote:
> The R-Car Gen3 thermal driver supports both R-Car Gen3 and Gen4 SoCs
> as well as RZ/G2. Update the driver comment. No functional change.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

