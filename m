Return-Path: <linux-pm+bounces-14645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18065985488
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 09:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497C81C20EF3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9483C1581F0;
	Wed, 25 Sep 2024 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qTaOKFwu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A913C83D
	for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250633; cv=none; b=d4q9TJdjQ+nIaCSNedlnr2a93aI/s6BHuoj4rxw8ELZ3ME7m+u7fOzlDfOQMVOS52t6g0dZ0/XUe/ds2KoWtGeOfmdzZpzO1LmD+P8s/i22rth3zR1iQ+wQUa7dvtAQMJVP61uNgMp6eL+OSEAFnkQjxuS1TszlqopZ2HQL2QnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250633; c=relaxed/simple;
	bh=LQJL9XnZ7aqpWYvsQHqnHYPGaY781b2/pcH4k8tMXf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6YkkGDXk4Ijlupf4UL1vZSQWTo3Mn7w+/zBM8ejqDpOCUbXdvwEb+YztvCSjJVezVJ8bWwy4orkE0gAwG3cMAzEduHRfLhyD4AyFuFynuPHvMDB1xAgMx0/A5BTqJysQt0BMMfQYtD7z5jhfSk0jIOFViGZjje4kb+8OJ+G7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qTaOKFwu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so3701180f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1727250629; x=1727855429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFiXClqbPRW4CJclRDKGkw40xsL++a9HxAmJhaouAR4=;
        b=qTaOKFwur8NWzwTTOKUrLm2/lHaFRxfR3ELJKonQIhw+faVILbQrhWbbHFlQgiRd+4
         o6pLBn+8gKElH5zchy3DKzfCY7waSwihtH1rOyWFkOv1i7Bl8MqLzaIKwaBHS4Mok+/m
         SBTcQF6DT1edztz9ppNB8L4bTaem7rhnL5ooU6NV/39Oz+21dGxY2om7OhSlqzK+7VHu
         qUBtovz2P508UiV0Odjs+yNPwKRYCWp7oaAXMC+txQ/Jzxvn5aDDC0R4dXetWNV+F+Ns
         OhYMZLEpKunfm6ct24sL3wHb7Ud/u9ql5C98gadYlpIQO95GLGJCkTq99XI1FCm9f+70
         9Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727250629; x=1727855429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFiXClqbPRW4CJclRDKGkw40xsL++a9HxAmJhaouAR4=;
        b=CfIRfiPr0esqS5dgDBstUGpb0LRP7tstUXYm2Mthpsg8JQchTRwGgsdpCcD8uLhbPq
         tkD+Be3WcmaM6KzDe/qdwn4i/6ey/sP4DkR9GQ+9+Oz3nQBntljj1azkyxXc8ap0JndY
         biuP3a8nWza5Mmu+Vf0mwUqGsE/EyrJfyb6t9WpEa68Zp3rR2mTE6PljbH+q7uPG9szu
         KS20dvmbwszNTC5xHF/SYpcJqh9ULI3TPPA/B+XngJ1szvKEiRnctfhhzQXNjc7tEjW6
         jd+i2ly9DtM2c7tkgL/5Wcb4IPRCWBWGyPQA8S2cnUI1aBQrdfoCtZzT7Vye6A3+Vlr6
         vqnw==
X-Forwarded-Encrypted: i=1; AJvYcCVGUHLnCoNX6ICLKW1AD8eeBeBwP2A5fJWpY7SHxIteydv9eUlWrhhtmOC6FAh0VgKcrrK0kMv+5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyAyqCv5mjO6D6TLWxJZ50t9BJTwPMXCaNqQL3XQ3D7GsBHqf6
	0jinbbB5KqtP1zLdI5nVayJdxzXiDz/Z6LejWTUAVal266aJ+TfVBWlpK+hW//Q=
X-Google-Smtp-Source: AGHT+IFSqrWOgvLYloNvVXm1vEQkjP+JD1QteKQEPhT8fVsIjwexzPr+xFJfYUTXmrkXaAxZ4I2zWw==
X-Received: by 2002:adf:f58e:0:b0:36d:2984:ef6b with SMTP id ffacd0b85a97d-37cc2466ff9mr1203849f8f.11.1727250629008;
        Wed, 25 Sep 2024 00:50:29 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969feb45sm10046135e9.20.2024.09.25.00.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 00:50:27 -0700 (PDT)
Message-ID: <23531a70-cf50-4b32-a9fd-81e6cfcbcf9d@tuxon.dev>
Date: Wed, 25 Sep 2024 10:50:24 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] soc: renesas: Add SYSC driver for Renesas RZ/G3S
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, gregkh@linuxfoundation.org, mturquette@baylibre.com,
 sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com,
 biju.das.jz@bp.renesas.com, ulf.hansson@linaro.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVQsHx0nC3xwQWVRWyWMnbXd1=RokNn8rkJv3bfG_0p-A@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdVQsHx0nC3xwQWVRWyWMnbXd1=RokNn8rkJv3bfG_0p-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 24.09.2024 14:32, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, Aug 22, 2024 at 5:28 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The RZ/G3S SYS Controller has 2 registers (one for PCIE one for USB) that
>> need to be configured before/after powering off/on the PCI or USB
>> ares. The bits in these registers control signals to PCIE and USB that
>> need to be de-asserted/asserted after/before power on/off event. For this
>> add SYSC controller driver that registers a reset controller driver on
>> auxiliary bus which allows USB, PCIE drivers to control these signals.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/drivers/reset/reset-rzg3s-sysc.c
>> @@ -0,0 +1,140 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Renesas RZ/G3S SYSC reset driver
>> + *
>> + * Copyright (C) 2024 Renesas Electronics Corp.
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
> 
> Using the Auxiliary Bus requires selecting AUXILIARY_BUS.

Thank you for pointing it. I'll adjust it in the next version, if it will
be one.


> Elsse you might run into build failures:
> 
> aarch64-linux-gnu-ld: drivers/soc/renesas/rzg3s-sysc.o: in function
> `rzg3s_sysc_probe':
> rzg3s-sysc.c:(.text+0x21c): undefined reference to `auxiliary_device_init'
> aarch64-linux-gnu-ld: rzg3s-sysc.c:(.text+0x264): undefined reference
> to `__auxiliary_device_add'
> aarch64-linux-gnu-ld: drivers/reset/reset-rzg3s-sysc.o: in function
> `rzg3s_sysc_reset_driver_init':
> reset-rzg3s-sysc.c:(.init.text+0x1c): undefined reference to
> `__auxiliary_driver_register'
> aarch64-linux-gnu-ld: drivers/reset/reset-rzg3s-sysc.o: in function
> `rzg3s_sysc_reset_driver_exit':
> reset-rzg3s-sysc.c:(.exit.text+0x10): undefined reference to
> `auxiliary_driver_unregister'
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

