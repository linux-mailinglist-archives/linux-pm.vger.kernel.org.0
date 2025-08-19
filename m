Return-Path: <linux-pm+bounces-32607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029ACB2BB28
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 09:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5C77A52CA
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA163101C7;
	Tue, 19 Aug 2025 07:54:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF23451DB;
	Tue, 19 Aug 2025 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590097; cv=none; b=EHrOClk+TAuGgVebTJitpAcArx3t8LS/BLV+m3DBoDmW8QGtggkQUZdw2Yib1QvHDiG6RLXsiop24Fceq0G3/QY07Ah0F3Q7Ew2VOPxLxsVdMYPWfFvZGv2OIsOekz47+YsHkA1U05isQDTY4OvNHr2EEEh73xIB/R32QcWE7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590097; c=relaxed/simple;
	bh=6GyLlS9SQW6qIDLFLwSXoVZibFLEpz06wk2RxTft+hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9cUSOALAwQw7qL4SB1ETTqzwXvX/U7reo8h2PIu6zh/sP2dBDduS5p9o5KW0jpvqHqCyrem6jniIjoYMfB1RRu1qqMGho4HJ33M2PeXoe10/9O+xO52ggBdZCzTHjWaD0lhUCrXx92JxMLQuHusXWzB8T7sReODFVlO0k0TyFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-50f88cd722bso1470835137.1;
        Tue, 19 Aug 2025 00:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755590094; x=1756194894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4yI0xKDh/Dea2okbvkBvUlDWnDM+bOQUmQtln3xRsI=;
        b=qK7rCo6PLNR0wogdNc7CVj4hSPEmfa/HgDM3Or4kTwyLfv6Ku4UOD8Htza6sCRWGGL
         rXqc5dquZWTXfaEtH9BZcAIGcEpYpiRvD1BrV+i4NKuXa7bsCKWbRvNMaDGcOaBOW2XN
         ojlMN8dDaXz08a5hSuDs7ovJm6GyEAv/bdKGjxSRiQa9b1Hw1FiLCHBLnHJ9CECSvo0K
         ZSGDUmv9kvNIHHQMQGwdPVxjcyZNekzkKgkzuEtb22z8IPcKasnd67eCIDZsEhHi1rhi
         JM3ffXZ/P+cfjlfWghEssxl52ObmcQNH1/5nZ0k2ghUq3T8LdM8Tho+HpuwcJJM55NRP
         XHBw==
X-Forwarded-Encrypted: i=1; AJvYcCU8wLeHjVxmzBWZDpAa8cIzTD5GxXNP3XTxJjFdoqIEw9G6Thhq0W6YLDFSekqsug0c6n22EP+eX5FyuZlJWk3HXKU=@vger.kernel.org, AJvYcCVE9YBhd1btY/WJ7g2Ekun7BGt2dQ+XdP/yQLcTYSNZTp3pfDpOwevrNlEFM2A1fjYSkxhM3XnQB4QNhOaq@vger.kernel.org, AJvYcCX+iqgwphYsFIxm7zMACGtRaR0nHmxtwNElciRPkUSefkGAxjrq8hqAR02Ss6FWwT7su1jxMNMablEw@vger.kernel.org, AJvYcCXLBWHVrsNqeWRneW3OUA63IC9op/wfrOwrX1m6DXxwlzy40tpUTNkw81DjkT6BcaZI0z2A6DYogXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdeemoYtOtyhjY5eO8eJCYIXk3/mP4Vxl4m4Zb9Ch+DCBWRw4
	YjP4dvlNBTSSKG65NABTzfDlhP+X+wsi3JWe5eGd6ZNR9fFsYTRwQ2LjIpSrvoWx
X-Gm-Gg: ASbGncvyj2rJRDbqwP6V7c4goEhuzQPYj5CA//K0oqf7lp2wimcMw8qgxxzYF9IeOfB
	j3MItnpg3RBFupNmvJy1GNRIhxqDpgzv41Pw/11sxmGMKvaN1hAAMqEYmnECR+l94gYeaB2Pntg
	qU325NYcrKcYYVZ0RD3H6uyvETOZmQlEYO9ia0onxGqSstp7lUPnxPWWIwkju15Tz8UPOVi6rkd
	ZOHXfUA5iWFoTlPLHPH4ya4ox3B7UYKOL5vOy+xnZww72qb3Z9ugIVcN8sxdZ0GOc7ryjoIL8in
	rohPfcuvb2KUQpu6im4bK0otyWnQHnSzM9xSAylDVVwG7Rn6JgnVWSG2fiFuHHc7s910maMg7Zs
	ZCxxS2/aJLKZm3zsdeGVlGSeX+8P8VsUZIh0NElCyuZpfUBt2mPd9T71wB2kd
X-Google-Smtp-Source: AGHT+IF3rdbhj5R/4LclBAwBIKP1kl9+HPSvZarUwhukinFr9ZHtc0tO4ZYdwc/B2u52MYOw/KklSQ==
X-Received: by 2002:a05:6102:358d:b0:4e7:bf31:2f68 with SMTP id ada2fe7eead31-51924535fc1mr400580137.25.1755590093912;
        Tue, 19 Aug 2025 00:54:53 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-890277bea3esm2239247241.3.2025.08.19.00.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:54:53 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-890190da557so981800241.3;
        Tue, 19 Aug 2025 00:54:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVHzpL7gfF+VgJlPgS/iYBFz8G7DQErejO+QvG79u+KC+zXSQ03XuXYoBE9DFQO4LCuTHjjYa9sLwU@vger.kernel.org, AJvYcCWmGN3jvwfZq1Es9SDsWfcyQ+hbchXFqS/OKTMwqSPk3APxLKf/pA906WHdo8Z4MoqkWt6nfPD49Ro=@vger.kernel.org, AJvYcCXM9Ac0SSrgqRfnCmOQY156j5Op/DpC/jQVaTk8xdIMDoUIPubdZtZ/FfC07eMY8HuVPKN4YjF/+i+e/tbGFbojmQ4=@vger.kernel.org, AJvYcCXQl2lG5U7MFRCsyHTVqmXuxTNYU11t6s7PWc0LOij5ybF+5Sy5QhXLOkmde39UP4/vI3med7z/fn38mXdy@vger.kernel.org
X-Received: by 2002:a05:6102:8014:b0:4eb:f8aa:9c36 with SMTP id
 ada2fe7eead31-51921c12678mr511890137.4.1755590092715; Tue, 19 Aug 2025
 00:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com> <20250818162859.9661-2-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250818162859.9661-2-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Aug 2025 09:54:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUcTXy3fSjviMEFFx_4EuVmVHSCZng5rntS=GGi6Yw+kA@mail.gmail.com>
X-Gm-Features: Ac12FXzL6P-kwtOHmhi_mrIjxX55aKCrGaAQmVprtvtxZM21ON6QFS3Pzxbvqus
Message-ID: <CAMuHMdUcTXy3fSjviMEFFx_4EuVmVHSCZng5rntS=GGi6Yw+kA@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] soc: renesas: rz-sysc: Add syscon/regmap support
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, catalin.marinas@arm.com, will@kernel.org, 
	john.madieu@gmail.com, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, biju.das.jz@bp.renesas.com, 
	linux-arm-kernel@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Mon, 18 Aug 2025 at 18:29, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> The RZ/G3E system controller has various registers that control or report
> some properties specific to individual IPs. The regmap is registered as a
> syscon device to allow these IP drivers to access the registers through the
> regmap API.
>
> As other RZ SoCs might have custom read/write callbacks or max-offsets,
> register a custom regmap configuration.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> [claudiu.beznea:
>  - do not check the match->data validity in rz_sysc_probe() as it is
>    always valid
>  - dinamically allocate regmap_cfg]
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for the update!

> v7: As this is a duplicate of [2], address comment received there, that is,
>     use kzalloc() + kfree() for regmap_cfg.

You use __free() instead of kfree()...

> --- a/drivers/soc/renesas/rz-sysc.c
> +++ b/drivers/soc/renesas/rz-sysc.c
> @@ -6,8 +6,10 @@
>   */
>

... so you need to include <linux/cleanup.h>

>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/sys_soc.h>
>
>  #include "rz-sysc.h"

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.18 with the above fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

