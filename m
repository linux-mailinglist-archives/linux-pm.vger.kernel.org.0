Return-Path: <linux-pm+bounces-6312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974488A2BE7
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 12:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6F228904C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8A53819;
	Fri, 12 Apr 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Z7HYXTPb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1545381B
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916306; cv=none; b=mIOvh7BY1YS7v7PCLfbU/eEN5Ii0iF/SlWlBBRs+QsgoaipdLMqCXit66PAQYwVg1sFAi/gZBYOMJhVwPrCzDs+JsCtqjHHDUN8fc75J6Wkiw2R4n06A3RZJJnjO5NeujT4Bo0eqFRiluh85vl9xiR6y/svkYE6Jq7X2C7MjZNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916306; c=relaxed/simple;
	bh=m7SZnyJBVQZSm3/ZMgPP8KmAohN82QOdxqDUo61ETQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6+inFhryAlOPT9G9Jji212CxRslMblEc7ESeppgOb2eZWIB/78DOQdopc8Is5kS5L7slpVwp95oEzYrmsc/iQnxia8JQJK8+GL1asA7DMvoS23p6BuO5NsGRcTTnBWesZjoPyqExYY6HkKJ0y3r6OKbclmTZWQ8LYBZY6ccRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Z7HYXTPb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a520410b7c0so82416066b.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712916302; x=1713521102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmvVpGqH/YnUJn3EKn9NCfL9fG7zsGqsH7iqYTHHqXM=;
        b=Z7HYXTPbEgHcFEGia5f3Cjw4XQFfFdF11UzWrXfj5n/Cr013pUpChNuVE3Gfi2LXBZ
         z4MTf+vkcVMv/ixTP04YBHG9LKgTqvq6OqAHs+IuL0l5uDdN4EDadc0x36a8d9OcB/g6
         K43uquGDN8TlGSmwvb2pk8Ltv4YCTTHny3ZbtWRIPJu5GUX3Fk65V8abkN/385fonp3N
         FSH17u0IAOZ7rRTg4R6O+hivA7sErjQHtQht5ccslYOAaSCe6RFyxjPrjdgthWUTaF+Y
         qdw10Cy83XX+CPOc9JdLjLH5FLYZl0F8bI+KSxnAKLRbBban0ytnVIXTOWCwV2wLZY+i
         tzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712916302; x=1713521102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmvVpGqH/YnUJn3EKn9NCfL9fG7zsGqsH7iqYTHHqXM=;
        b=LZQNLtNNNea8bN8rB8jViyBs7c3QyMJL/+R0cdHd8wNrKsMGDHcuLwGN/8GogayFRJ
         pQfkdaHa29A0iQm1/pEibVmUuUk6NKgG6xDd1loifDVp9XyijMcAHs7HrrvjAk0aSU84
         gydj/k3iIcuKmvFQdECbLFT4Ny2acPD+0vZmOUtYpLiv9OHYptmIb18NWuP1qWXj1Wlh
         RhVTTF7z0SODTHaUdMZ4VvLCSDHuSCwJBHKXoMq1nYL3eF8MN5x98vf/mmytJsG3GrSo
         5D1e4NqY42BfHjppvSsKynyNOg6bpdOZaq3nCPIzKzILeL3omqBbXbrmhEMwuQh12wKF
         zBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUhpzPV0PZLub3usnGejoVm2jK6IzFNa2Hd2sGwlRseSLTaSSagRmJBHrvzmbwnXYFKLNEFiP7MOGtzitDRxliP6mzEw8sduU=
X-Gm-Message-State: AOJu0YwEm1aQn3uISy82JmA8fY0hHX4LItN/DKjVio/3w6FVwhLHty8T
	b7TEL3R+M1qCKrv1+Ypvx0pfffMAMdTZLQmbd6Xr95++9Rhi4ItCqAvuKhKc7NY=
X-Google-Smtp-Source: AGHT+IHQMQDAmt/KUMiRX2jfsv9Ugd19LQKa3XJw1aZ7aEKYJ1UBxTCpp3X0iWhacATHBs5n4+le0A==
X-Received: by 2002:a17:906:36d6:b0:a51:d7f3:324b with SMTP id b22-20020a17090636d600b00a51d7f3324bmr1290933ejc.66.1712916301420;
        Fri, 12 Apr 2024 03:05:01 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709063b1600b00a4e533085aesm1637200ejf.129.2024.04.12.03.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 03:05:00 -0700 (PDT)
Message-ID: <2a07d159-fdd4-48d4-b351-01f5e2579c3a@tuxon.dev>
Date: Fri, 12 Apr 2024 13:04:58 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] clk: renesas: rzg2l: Add support for power domains
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linux PM list <linux-pm@vger.kernel.org>, Guenter Roeck
 <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
References: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUesJe0396MsH9PSUMEq=sWx3BYc=QrAFzR2EVcLhm03Q@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdUesJe0396MsH9PSUMEq=sWx3BYc=QrAFzR2EVcLhm03Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 11.04.2024 18:30, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> CC pmdomain, watchdog
> 
> On Wed, Apr 10, 2024 at 2:27 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> Series adds support for power domains on rzg2l driver.
>>
>> RZ/G2L kind of devices support a functionality called MSTOP (module
>> stop/standby). According to hardware manual the module could be switch
>> to standby after its clocks are disabled. The reverse order of operation
>> should be done when enabling a module (get the module out of standby,
>> enable its clocks etc).
>>
>> In [1] the MSTOP settings were implemented by adding code in driver
>> to attach the MSTOP state to the IP clocks. But it has been proposed
>> to implement it as power domain. The result is this series.
>>
>> Along with MSTOP functionality there is also module power down
>> functionality (which is currently available only on RZ/G3S). This has
>> been also implemented through power domains.
>>
>> The DT bindings were updated with power domain IDs (plain integers
>> that matches the DT with driver data structures). The current DT
>> bindings were updated with module IDs for the modules listed in tables
>> with name "Registers for Module Standby Mode" (see HW manual) exception
>> being RZ/G3S where, due to the power down functionality, the DDR,
>> TZCDDR, OTFDE_DDR were also added, to avoid system being blocked due
>> to the following lines of code from patch 6/9.
>>
>> +       /* Prepare for power down the BUSes in power down mode. */
>> +       if (info->pm_domain_pwrdn_mstop)
>> +               writel(CPG_PWRDN_MSTOP_ENABLE, priv->base + CPG_PWRDN_MSTOP);
>>
>> Domain IDs were added to all SoC specific bindings.
>>
>> Thank you,
>> Claudiu Beznea
>>
>> Changes in v3:
>> - collected tags
>> - dinamically detect if a SCIF is serial console and populate
>>   pd->suspend_check
>> - dropped patch 09/10 from v2
> 
> Thanks for the update!
> 
> I have provided my R-b for all patches, and the usual path for these
> patches would be for me to queue patches 1-8 in renesas-clk for v6.10,
> and to queue 9 in renesas-devel.
> 
> However:
>   1. I had missed before the pmdomain people weren't CCed before,
>      they still might have some comments,

My bad here, I missed it too.

>   2. Patch 9 has a hard dependency on the rest of the series, so
>      it has to wait one more cycle,

I think 5/9 should also wait to avoid binding validation failures.

>   3. Adding the watchdog domain has a dependency on [1].

Adding the code for it in patch 7/9 w/o passing it as reference to watchdog
node (as in patch 9/9) is harmless. The previous behavior will be in place.

At the moment the watchdog domain initialization code is not in patch 7/9
and the patch 9/9 has reference to watchdog domain to pass the DT binding
validation. The probe will fail though, as I wasn't sure what should be
better to drop: device probe or reset functionality. I mentioned it in
patch for suggestions.

> 
> 2 and 2 may be resolved using an immutable branch.

2 and 3?

Immutable branch should be good, AFAICT. If that would be the strategy I
can send an update to also add the initialization data for watchdog domain
in 7/9. Or I can send an update afterwards. Please let me know how would
you prefer.

Thank you,
Claudiu Beznea

> Are my assumptions correct?
> 
> Thanks!
> 
> [1] "[PATCH RESEND v8 09/10] watchdog: rzg2l_wdt: Power on the PM
>     domain in rzg2l_wdt_restart()"
>     https://lore.kernel.org/all/20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com
> 
>> Changes in v2:
>> - addressed review comments
>> - dropped:
>>     - dt-bindings: clock: r9a09g011-cpg: Add always-on power domain IDs
>>     - clk: renesas: r9a07g043: Add initial support for power domains
>>     - clk: renesas: r9a07g044: Add initial support for power domains
>>     - clk: renesas: r9a09g011: Add initial support for power domains
>>     - clk: renesas: r9a09g011: Add initial support for power domains
>>     - arm64: dts: renesas: r9a07g043: Update #power-domain-cells = <1>
>>     - arm64: dts: renesas: r9a07g044: Update #power-domain-cells = <1>
>>     - arm64: dts: renesas: r9a07g054: Update #power-domain-cells = <1>
>>     - arm64: dts: renesas: r9a09g011: Update #power-domain-cells = <1>
>>   as suggested in the review process
>> - dropped "arm64: dts: renesas: rzg3s-smarc-som: Guard the ethernet IRQ
>>   GPIOs with proper flags" patch as it was integrated
>> - added suspend to RAM support
>> - collected tag
>>
>> [1] https://lore.kernel.org/all/20231120070024.4079344-4-claudiu.beznea.uj@bp.renesas.com/
>>
>>
>> Claudiu Beznea (9):
>>   dt-bindings: clock: r9a07g043-cpg: Add power domain IDs
>>   dt-bindings: clock: r9a07g044-cpg: Add power domain IDs
>>   dt-bindings: clock: r9a07g054-cpg: Add power domain IDs
>>   dt-bindings: clock: r9a08g045-cpg: Add power domain IDs
>>   dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells =
>>     <1> for RZ/G3S
>>   clk: renesas: rzg2l: Extend power domain support
>>   clk: renesas: r9a08g045: Add support for power domains
>>   clk: renesas: rzg2l-cpg: Add suspend/resume support for power domains
>>   arm64: dts: renesas: r9a08g045: Update #power-domain-cells = <1>
>>
>>  .../bindings/clock/renesas,rzg2l-cpg.yaml     |  18 +-
>>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  20 +-
>>  drivers/clk/renesas/r9a08g045-cpg.c           |  61 ++++
>>  drivers/clk/renesas/rzg2l-cpg.c               | 269 +++++++++++++++++-
>>  drivers/clk/renesas/rzg2l-cpg.h               |  77 +++++
>>  include/dt-bindings/clock/r9a07g043-cpg.h     |  52 ++++
>>  include/dt-bindings/clock/r9a07g044-cpg.h     |  58 ++++
>>  include/dt-bindings/clock/r9a07g054-cpg.h     |  58 ++++
>>  include/dt-bindings/clock/r9a08g045-cpg.h     |  70 +++++
>>  9 files changed, 659 insertions(+), 24 deletions(-)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

