Return-Path: <linux-pm+bounces-35981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C557BD562C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 19:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B4DA4F5E54
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE329B8DC;
	Mon, 13 Oct 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M74mFQ9H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788229B78F
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374696; cv=none; b=oBRf+lWEmWh2q7e+ruXTkKxJ+phMTPnAvDl19rg19eDeXmTNh2R/G13yiJ2ATrKK8rAs2v5m7KJ1htW9nAr69unchwHRBUKh16WzqwDKVd/s5PhKjdHhUj9Ny6I4zVq1PmKD8wYQLBidmlIWdqcEXEvQedlhrN0aqpGqBc+5z4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374696; c=relaxed/simple;
	bh=aVbLx3zzuiItcIq6jkvMD/Zgek8sd/MbjhMghYBE0P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnM4EH7TeztpJJ1E0XQH761qbg2WsJ7jxtfhdANHNPZRmnpgjZIMP5/0gJancP5vygGECldomX0jnah5wIf2xP2Ov6WLv5N0gPOh/7sO9OryUU0nNyzzfKb4DUDe4jH8xUP+vkIgrnVYmvvdtnPgpSa0eLYzW8MHoiWRjFa0nl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M74mFQ9H; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5797c8612b4so5420408e87.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760374693; x=1760979493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yugt4TFzKOWVtrp9PcwweappLEqjwwN8AAVbBJj3x48=;
        b=M74mFQ9HvKukuAyHkZgSoarVInq8g6SVHkIHPYSCFvcdFOtBbcbcTV9eKbDReyG/pp
         KdIx6qukevvbll49LnzS9pFeCJSWi+xCmLRCDcwb9prvjP4bSnd4UDwzB5srbExk1lxL
         x6Ink1cLNayjEKBYzdYAvrdxEESaNMvkmRQgDFN5GY4B1rf+KiaiI7A+kHVonyFWCVez
         +Fpk4WA7G+wwikLP4z49RnQZhQXIcTlo/oQWxlwL3mrXM/6O7MIKLIo5tdZ51Y6vk48v
         md0bC4aHTnBmdFu6yKm5I9WdA3qqt9bcLHJCcFXERn3shL8P7hWNvhx1xuE8BsHxIom4
         z1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760374693; x=1760979493;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yugt4TFzKOWVtrp9PcwweappLEqjwwN8AAVbBJj3x48=;
        b=XeHQPo/1Ss4xSPBo8+7TCQxWDIxxV7/GSp95TC83k9F3250kaG0ezHj4A1EXvNZ2M1
         uZaphk3hNmo/q+HmUBPht7ylDrQosD4lKAYPukT7zRsf0OtY48D/u5pCiwH5iVOfmr2e
         XRSg3xOqPW1nU4vaaR/D4Vnoa23mQBaPDmZ8Tfv52HQW/rXazTw+KaqCdW4KHj3F2tsR
         XtcLQJIccLuipzP5EVi4V5f3rLMq7sZJSyE6BJ+P4CWJ21m0vo13ehQfTm2OOyIqb5sR
         /rtFp7AJFQVPd7EMNMZyqPqrMqh2ypEunngx3uahpXPuNQGHsWq37rcc0/wRF1XuZz/7
         klPg==
X-Gm-Message-State: AOJu0Yw9GlrG+yl3IInlyPieYBTt5yCFR576GnGuaFKoTlWK07JZj1Ty
	IctQFIwyqYGC9mFOEC/aK2WjXQ4ToRV+oZCFjkaBpijfPho+QL+CJF0I
X-Gm-Gg: ASbGncuRJFodKkrhHkkvzCd7LOM7EBqaLAUiic/QO6Mvzg2qX1n9SSwREKurBhZXBqK
	GhKtO72zWdV2SWWzWkZP2wPjZHqXJqoYYDTzo+0CMhvgnUUqTqCrtE4KdUMYdEa9+4Ei0BFmblD
	PbFHDgdouFnS9PQkAixWnFct+7ve2bDhIt+9A/JZ6l90Ric+ZKjMEmZ6UtsEaeWrLUEzNY1CLXe
	3/M+IW+B0aEIb1hUBbpNlXpBeBBNA4dlhQ0TbhFddCDaOI2loPakiltSZ7QXcNvZ1P+9F19u5Uf
	3Mt+qFFHen9TgqaDTwwDaajWTh/Ulhuu34OoEqy8LmVlmv/ImdfINVA5EsFSU+r5Fh2i0XzAZAH
	YFwSgOxJaR5neTZGLZ3mFQPxDr0lZleG2IHTFzCyb6YrGaMXoXqV7ouoU0ujl4Al7wQ3Nq+zclV
	cO4bSCwD2cEMEjjkJM
X-Google-Smtp-Source: AGHT+IEh5FEGdLJk3FY3nXjUAjtDIVpFAFgTlMg4hJ6GlsiA7ZQHpqXBQCJHQ9JSVuB42SxmUqwjGg==
X-Received: by 2002:a05:6512:39c3:b0:577:494e:ca63 with SMTP id 2adb3069b0e04-5906d896d59mr5638965e87.12.1760374692389;
        Mon, 13 Oct 2025 09:58:12 -0700 (PDT)
Received: from [192.168.2.19] (109-252-159-193.dynamic.spd-mgts.ru. [109.252.159.193])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5909413ec6csm3376197e87.48.2025.10.13.09.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:58:11 -0700 (PDT)
Message-ID: <590984a2-633d-4e68-9601-f379bdc2b8fd@gmail.com>
Date: Mon, 13 Oct 2025 19:58:10 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] PM / devfreq: tegra30: use min to simplify
 actmon_cpu_to_emc_rate
To: Thorsten Blum <thorsten.blum@linux.dev>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013131825.31400-2-thorsten.blum@linux.dev>
From: Dmitry Osipenko <digetx@gmail.com>
Content-Language: en-US
In-Reply-To: <20251013131825.31400-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

13.10.2025 16:18, Thorsten Blum пишет:
> Use min() to improve the readability of actmon_cpu_to_emc_rate() and
> remove any unnecessary curly braces.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 4a4f0106ab9d..2c9813bd697e 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -12,6 +12,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -326,14 +327,9 @@ static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
>  	unsigned int i;
>  	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
>  
> -	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
> -		if (cpu_freq >= ratio->cpu_freq) {
> -			if (ratio->emc_freq >= tegra->max_freq)
> -				return tegra->max_freq;
> -			else
> -				return ratio->emc_freq;
> -		}
> -	}
> +	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++)
> +		if (cpu_freq >= ratio->cpu_freq)
> +			return min(ratio->emc_freq, tegra->max_freq);
>  
>  	return 0;
>  }

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

