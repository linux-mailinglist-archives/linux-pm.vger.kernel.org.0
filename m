Return-Path: <linux-pm+bounces-2475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A14283657B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 15:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0C91C239F7
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480653D963;
	Mon, 22 Jan 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dd4yie9m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1983D572
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933971; cv=none; b=PgucSsZbll/MV+aqvv3pnZHphjRIXZiI5byoTT/3Ru9THFC0y5ob7JZyoWAPaUira6rJ4LvcIw48r26sc3wXEBSbGOWSpCdyiDRrg0zQV0OUw/hj//e2SE6eIhnuKjhr3vJPo1/aMOs9ckBLOiy1uHMotd++UUerrPVS234joQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933971; c=relaxed/simple;
	bh=P1NuWwg0ehuf+T8vDagxKBny0SgDrfNwIdh6z8AQNDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rw0Mm9xht94eEXnESCSneyQktXFe27jGJFoMMjFvVCvditn5yR+WtYWVMaPHBeDuYoZYUdfEwpRjlZDnFMj4JXRlLH8M2ivVYCmtSh4rfUYwqOlStM4sXId9npBe+mKedbkfTlJsGv3ao7Pd+zCsAtqKXGcrPGLhYX1r8Lq43ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dd4yie9m; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55c1ac8d2f2so1559435a12.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 06:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705933967; x=1706538767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=57hHxLCu6iEEROEwucBeUB8JIMVHa7C+K5VoPIscvfw=;
        b=Dd4yie9moxOcNIUfNxjBHarBvCCLP6oUw3cvFYwlsb2GppWuAafpJ5JICmcDFnfpJP
         xwqlyMQZRten4P85zu2SIp9K+WPpLtGI84iiO0fXLZbdCnFVwdON3rTTJNfILluWyfX1
         d7Yn/P+FW8i8tr1lqxfbpMIhzZmrJS5/QxcjXpu6Kip0lSRQiaKDFw0ZzzOUCnao76sz
         Vqy8gj0TaNRN6865WMjdMgopaSJqafrIakqFRJxvW20b3m1mvk99VyONB0w/hFeIcHog
         hOYEZ0LikpKGUYTAdHJoaV2Rm7zTp13wDFvXu6d8m3wHNyIp1ErbRAhDpwS/M5CIOFRn
         VaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705933967; x=1706538767;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57hHxLCu6iEEROEwucBeUB8JIMVHa7C+K5VoPIscvfw=;
        b=F/d6g3ZJAdvIMlyka1l4Uqcyt2QK9F35NuQpIz8YapB0sgCto7DVIszvPOHGOFT6vi
         xEz5BqSyXD0ocoj5UwD2/OUBznJGaHZpst9cmm/ZxAGf+rG3M9ZEdD9lkgxZ8T7eb/wX
         7spzuvB8ZNztLJMTSz2dLc6hraBuJVrLlaHEaVnoupNFVQWswuKxBoQTOhg33nykVn8I
         7hLT067P95rWi7gU/n8vLDAcjGJh/cTqBT5bMzFyAYCY47I3MZ9kSpJ+gRWCFSATsjyk
         rlQl2JoHPVLjFMKqtarIko4YBx6EGoShqcfnPw4dbHrJ5QepqFW8e4QgJjuZK1n9Y2Gi
         EmIQ==
X-Gm-Message-State: AOJu0YzHzYB5M7hSSfO8Wuqo2rQYEMdzHfhDOv5VIqB6hrpoEVXkNjk+
	vvQ94wBrShUjDbUtXIgtdXcJUFq2wmsN654w5/3GCEfj1/pChw8nE1/m9Fi5AXs=
X-Google-Smtp-Source: AGHT+IHXnR7VO4ZsjYPbwRylj6GzKSqKjx7Pe/tHHzMmNRyMjKhVQNqj220Us6olAwcvZKe/xJMX0w==
X-Received: by 2002:aa7:c68f:0:b0:55a:399d:e93e with SMTP id n15-20020aa7c68f000000b0055a399de93emr2064390edq.72.1705933967590;
        Mon, 22 Jan 2024 06:32:47 -0800 (PST)
Received: from [192.168.231.132] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id c15-20020a0564021f8f00b005598e3d6d23sm8124302edc.16.2024.01.22.06.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 06:32:46 -0800 (PST)
Message-ID: <548e2f24-a51e-4593-9463-09506488c70e@linaro.org>
Date: Mon, 22 Jan 2024 15:32:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
To: Priyansh Jain <quic_priyjain@quicinc.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_manafm@quicinc.com
References: <20240122100726.16993-1-quic_priyjain@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240122100726.16993-1-quic_priyjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.01.2024 11:07, Priyansh Jain wrote:
> Add suspend callback support for tsens which disables tsens interrupts
> in suspend to RAM callback.

Would it not be preferrable to have the "critical overheat", wakeup-
capable interrupts be enabled, even if the system is suspended?

> Add resume callback support for tsens which reinitializes tsens hardware
> and enables back tsens interrupts in resume callback.
> 
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> ---

[...]


> +
> +int tsens_suspend_common(struct tsens_priv *priv)
> +{
> +	switch (pm_suspend_target_state) {
> +	case PM_SUSPEND_MEM:
> +		if (priv->combo_irq > 0) {
> +			disable_irq_nosync(priv->combo_irq);
> +			disable_irq_wake(priv->combo_irq);
> +		}
> +
> +		if (priv->uplow_irq > 0) {
> +			disable_irq_nosync(priv->uplow_irq);
> +			disable_irq_wake(priv->uplow_irq);
> +		}
> +
> +		if (priv->crit_irq > 0) {
> +			disable_irq_nosync(priv->crit_irq);
> +			disable_irq_wake(priv->crit_irq);
> +		}
> +		break;
> +	default:
> +		break;
> +	}

if (pm_suspend_target_state != PM_SUSPEND_MEM)
	return 0;

<rest of the code>

[...]

>  
> +	/* For saving irq number to re-use later */

This is rather self-explanatory

Konrad

