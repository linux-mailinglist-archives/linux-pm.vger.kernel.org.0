Return-Path: <linux-pm+bounces-16559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 223339B2BBD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 10:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4E1B22BB5
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4568A193060;
	Mon, 28 Oct 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfe+evnj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463F193404
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108695; cv=none; b=kurIk8SgDw+rupJ1vUdH+8B8+K2B8hYUnl1WJH02hhfybvmnDP7Z16cKVNOykM97CWeY2TsN9PyF7anpiijuXwm5dI54yFY1SRjetMMIhP++KVUTRjzoI07BHa5z8DzA8xMfFAuGFbex9TnbyEMsowHohWzv27o6Y6Y3emNUpn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108695; c=relaxed/simple;
	bh=i8WNTcaN5PWAzcehUDptB8suCbaVFwo9puUW+aLUTH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfCG7B4FfeJka+o1LednX/xQdFYLeVUauHr5rC04d/SBYChKo6BO/0t2oK4DD/WalBqxFSTkv0Zpaiz/9nq8DcdnDiNIg2z1Bh1agIrZwCZsx3Cuxz2li9Gr7I6t6hpb4Z6BLAKnIAhPD5MWS+FsS4PzcsxQfm/2Z4pRRqkXPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfe+evnj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431616c23b5so28698295e9.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730108691; x=1730713491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYW2nBqpOT7rpdJAt6yBdXzUTt5ThWvwR8AKSh6PMWk=;
        b=zfe+evnj40bBnwMyBnXsFxPwpa0OWtoI3CI5d1hT9AMT5cR+JFMGuMXD8Occ/WpI+V
         DJeQpp4O/7vKtdMi85M+H6tWsZImU8vkixKx9TB6rZylEeIa6PY8BG5FDxVZ6W8obDFl
         rXY5bdSxOh/uXJLKEJvgO0hBOFuiLqo31Mvi4upsicY/KyBRtkA9pXoySb/JDmHO4iZ1
         8T4fTU8LEXUnJKSi1LXN+ck6HG6MShwQb3Ok+QvLoIWQTiHWLdUEWGreVnt708NWIq44
         6T61/ZEOvZ1fNSs6QYwGxaZuyk1WEXL46LE+WkJPxzqLLP4AGKOjg1xclkuAXQVhJtvT
         zMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730108691; x=1730713491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYW2nBqpOT7rpdJAt6yBdXzUTt5ThWvwR8AKSh6PMWk=;
        b=j9CGFqLRkigSA7K68d/HtI/HB7uG96+p9V3jGAHW70fqHVEoqhxXkhM1+C2LScHr2B
         30HDRAauF17Jp4FuGUex6HWptEuzGfEpS5092ollxCsnOhMIQvKtb0XgeXcK27F71Imu
         qSmamUuaZliXALAuIHY8NNAYh9srQhwJy8wEtiBtnMWxZxewdU7c6s7Op6PDdcVtPgLx
         9NHIEaehNPoeNW2i/m8S0GMwaU80nNlnI7bkiYRopMHqPIpovYvoEox97eO7i8rWam3q
         PcFZd8BIuAA/W+P87gpZlUZSstJR5qZjpntfExdrYMGzsh+B7P1Vj1JJg9GewwCa4O69
         QTTw==
X-Forwarded-Encrypted: i=1; AJvYcCXheN6OAZa2ybvZklma1i2JL/LZhRgC9y0ZefJGWzxc0Cw3qq6UcKaUfRDbhX9vKHDTEr5jEXtfaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIw/9DAiJ/CxnIsPJK9ObjN0ONS95EKpI0z6fEusjmP8kMa5j
	5fZqN7x701P7tk9qsKO3UzLYAeVmyMi/oRTCqtCj7aEQ9Fqw+jcE+f6yjXYC3sM=
X-Google-Smtp-Source: AGHT+IEGI3A08qAUBhd5v0Oc5FZbvghNJQAwXWa8dsiUdujloWteFAWUVUDMhuvgj34CSetfJervcg==
X-Received: by 2002:a05:600c:4e8c:b0:431:7c25:8600 with SMTP id 5b1f17b1804b1-4318b587dd1mr99781975e9.2.1730108691401;
        Mon, 28 Oct 2024 02:44:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b70c44sm8958669f8f.80.2024.10.28.02.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 02:44:51 -0700 (PDT)
Message-ID: <5f7179ec-e4ce-4644-8a60-ce407a4d2f11@linaro.org>
Date: Mon, 28 Oct 2024 10:44:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] clocksource/drivers/timer-riscv: Stop stimecmp
 when cpu hotplug
To: Nick Hu <nick.hu@sifive.com>, greentime.hu@sifive.com,
 zong.li@sifive.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Gleixner <tglx@linutronix.de>, Andrew Jones
 <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Sunil V L <sunilvl@ventanamicro.com>, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Anup Patel <anup@brainfault.org>
References: <20241028033928.223218-1-nick.hu@sifive.com>
 <20241028033928.223218-3-nick.hu@sifive.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241028033928.223218-3-nick.hu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/10/2024 04:39, Nick Hu wrote:
> Stop the timer when the cpu is going to be offline otherwise the
> timer interrupt may be pending while performing power-down.
> 
> Suggested-by: Anup Patel <anup@brainfault.org>
> Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>   drivers/clocksource/timer-riscv.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 48ce50c5f5e6..166dee14e46b 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -127,6 +127,12 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>   static int riscv_timer_dying_cpu(unsigned int cpu)
>   {
>   	disable_percpu_irq(riscv_clock_event_irq);
> +	/*
> +	 * Stop the timer when the cpu is going to be offline otherwise
> +	 * the timer interrupt may be pending while performing power-down.
> +	 */
> +	riscv_clock_event_stop();
> +
>   	return 0;
>   }

Should it not be the opposite?

First stop the clock which clears the interrupt and then disable the irq?





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

