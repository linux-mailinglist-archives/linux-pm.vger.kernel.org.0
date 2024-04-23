Return-Path: <linux-pm+bounces-6888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0118ADE2D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 09:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7931F23925
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026A53378;
	Tue, 23 Apr 2024 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UbJ5Z1Gt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8447F64
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856948; cv=none; b=K2vdEbaoRV2nE4jNn0+/92Z2qw+0xiEgiSq5STUi6WAL8wWEannfgS4K+JpODpOQUnBiFyzedzkAp+oe6NUDtvSdfoQnaHhC89XVVhSqg3gCFYKTBQqhb69egxxGl4GDOpHO/neUbBzQps5AoLcDbXuAYbqGdxqJvvQy5l72Pg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856948; c=relaxed/simple;
	bh=TBerHdNcd/VaASBcrY0w9ZfZal4wjbWMeedPNUSWFT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4K0TSNs8U2oyITVmWGJCo0FefpLjUzSOylTluMRChR1XqnmZ4By2ODAAUX36EpCjgVaE/SJQjrN1nmnfwiytBA+lkQWLv9UFQOGgQsOrkACUienMUevVugttAizNx+m/ENoF5k23Tg0emc2PPq1LrqBDNaakZToZOR9Kkgl65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UbJ5Z1Gt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4155819f710so43496605e9.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 00:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713856945; x=1714461745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5JDwEM0S+y8m3kJjVaTErVxuzPV5GK/2cL9D2vmiaQ=;
        b=UbJ5Z1Gtyt8ydfbXku7hag+Hn7/Ivj8orb7LgJm9dN3mRsiGC6269pBnn9ZQvTCC6L
         x6PsWLjq4zSKiz/5uW6AiJMwJmEH5tTWmgrtTUdUlcSUENRT9+fZMYQ/hdBVo+ADkAg+
         woOgi0znTx13UERfjyIwCxK02g/k3g8NzsfppjyUvlLVevWZV5YL/WlRn+t52tmVv5cg
         ELVKvoyHxPydVu9Qy8lcvcCaIR2NlcObOOI16/pEBV1tkfGYBb/I4ee9zrlmx/vc1wP9
         juogFmrKoetJ0fTLrPIKuWqwCQ33mA942uNLLesXGUpueMpB+HDNLvbV9xwTrq8rXl3/
         3ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856945; x=1714461745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5JDwEM0S+y8m3kJjVaTErVxuzPV5GK/2cL9D2vmiaQ=;
        b=xL3BKbuXV5AywgY/A8g+WKhweQep39igiLkK0SAW+wrx6HbgOqzTBcgZCl2KVpQ/ow
         MVO5u2fYjQZZ8GvdspCCBJTxGdEwXGAfdKfJRbCEK/vvCwQDbDzxlxermlYfGJ+ClEN7
         9oLRXpHwCwbH/UVcgrG0rcm/kBeTwwcce9P0u0YQocLkCPr953KQROqUqOibk2gQDZxG
         pS6xeyUvx/t9xbn8wcsUlvAp8RiDdqh2RPtib93CbwnnvZ5b4sMoIuoibtBeJ7h0Mkwg
         i/c0lhY0aDcqiFzv9Ceg2lwQ13n4QYNbSV9qxb//TpU1D2O3493WZEHykpIveiDwa8O9
         b/XA==
X-Forwarded-Encrypted: i=1; AJvYcCVB1xtntW311t/IQ5igUNmP2xlzfOXh/A/4HW6m0FcGYqSPICUdC/4jD1Xgao4c0nZJSD8hJZq145JpinQlq8pTtkc4Y+S9t7g=
X-Gm-Message-State: AOJu0YzzAg5l3RcqaQN9TDdeuS2Ik9VEcuurGgI4DFGEg5PkI7wu3y8v
	ZUyAdRk1Bz7c15Kyc1ZKOsPF8x+Rae7K92paIlqJHMMFPqpzyGS/uoi2ovt+py8=
X-Google-Smtp-Source: AGHT+IGxE63ul961rmdayPpwfWtYcPyASuIixgCszvjaulRux0YGT/IzWKGo6KnTBv1DRd8c/eNyMw==
X-Received: by 2002:a05:600c:a11:b0:418:f86a:5468 with SMTP id z17-20020a05600c0a1100b00418f86a5468mr10608692wmp.21.1713856944782;
        Tue, 23 Apr 2024 00:22:24 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id fj3-20020a05600c0c8300b00416b2cbad06sm23034393wmb.41.2024.04.23.00.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 00:22:24 -0700 (PDT)
Message-ID: <8fd3faf9-0179-425e-a68e-d0dc0a2d7da9@linaro.org>
Date: Tue, 23 Apr 2024 09:22:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: kirkwood: Convert to platform remove callback
 returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230712094014.41787-1-frank.li@vivo.com>
 <20231204115517.zxjgi6ateobjj52d@pengutronix.de>
 <h2sjdrgs7hwmbucr3rxlpusnkpj5tgq2fx27gijtrglr5ffhs6@s63cp4isu4mx>
 <fgmvwuzy34cruggah2z7fau4nnfzopuylsgjs6zzdypp26boya@ekrj5myjef5f>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <fgmvwuzy34cruggah2z7fau4nnfzopuylsgjs6zzdypp26boya@ekrj5myjef5f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/04/2024 18:32, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Mar 06, 2024 at 10:33:06PM +0100, Uwe Kleine-König wrote:
>> On Mon, Dec 04, 2023 at 12:55:17PM +0100, Uwe Kleine-König wrote:
>>> On Wed, Jul 12, 2023 at 05:40:13PM +0800, Yangtao Li wrote:
>>>> The .remove() callback for a platform driver returns an int which makes
>>>> many driver authors wrongly assume it's possible to do error handling by
>>>> returning an error code. However the value returned is (mostly) ignored
>>>> and this typically results in resource leaks. To improve here there is a
>>>> quest to make the remove callback return void. In the first step of this
>>>> quest all drivers are converted to .remove_new() which already returns
>>>> void.
>>>>
>>>> Trivially convert this driver from always returning zero in the remove
>>>> callback to the void returning variant.
>>>>
>>>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>>
>>> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>
>>> Can you pick this up?
>>
>> This patch isn't in next yet. Is this still on someone's radar for
>> application? Would be great if this patch made it into the mainline
>> during the upcomming merge window.
> 
> It didn't made it into the merge window leading to 6.9-rc1. What are
> the chances to get it into v6.10-rc1?
> 
> I just checked, the patch was submitted when Linus's tree was just after
> v6.5-rc1. So it already missed four merge windows without any maintainer
> feedback :-\

Sorry, it is applied now.

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


