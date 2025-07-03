Return-Path: <linux-pm+bounces-30009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D727AF6B93
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 09:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821B7167553
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02702AEFE;
	Thu,  3 Jul 2025 07:30:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513EA227BB5;
	Thu,  3 Jul 2025 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527838; cv=none; b=u9XWhBhfhGnsrBgMJT4QHacbs2Nu/K+ivzn7+abe6/ifhwHsQz6sHmXyeX70QtRcISk0zQioYtaEd6XTJ0hz39inYleEImcdqW6w0iCFIt/s8iwnFiP9LgFna1qO67q6MR883YU8mUgZcufsmzjW1fJ0Wd232IlgGBDACRgnHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527838; c=relaxed/simple;
	bh=uLjorcp1wXyjCgvrldvz48SncDOeqlUqja+c23FgOGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0N1TgrANiLJdeJkTEsz+O3czJMkQ27QZU4yyQuoEQdq3PYerCSqcDHHgC3YY1p41ju5gUAbxqh10pklrNeTVgbCxAT7Etmcs1NZybfgulhrVaMYwDk7+vfpoDadysJ23E1jrBK4409Ck8R6gbw0BO+Z+iY/zo5vaYEEyYcKBng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4c9cea30173so1991442137.3;
        Thu, 03 Jul 2025 00:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751527834; x=1752132634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQkd5lggPBWWtyS+JYPjji8BCoMSeibTx7BxcjVLx58=;
        b=f2MzNVVePqATxvhNU2hfT7VO8FxzH26BWBNhewHLzCErdXgU43lvB1EOS+EMpBjJJq
         no6SIp321VkkwDH/fMTfvoTvn+6QspAgfLedvweJdGk4LC8PKuGc3FqebqYVq7K9TlZv
         rA3DTf3KiVOFmOCTaAKMD5nql5XpUL6cQR/wls6BQnMGgEvwM7OtuBsr73nYOsZJRxGn
         ktVX9eyYIhjTzVwzboewF+6hsHbsZJy/TwzrDUIJaSgUbVKyC49jHRPBQ3Jv4nBJ43bS
         RxRwaNsR/xehMlKRa1vfyxyFrejMF3qT3VE6tXQ1nadMNKuX32uMMylg6Q989e+RM5Ie
         KGIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuBsScCtnYMQgOHqn5giafxKsaBMzbbrDwo47+sozEQtXClZ+7amAk8oC2jyofYqPIabAdEPCAVnmIYhSP3eTbkpI=@vger.kernel.org, AJvYcCXqR5RLH2sOdftQvzZKMm10her2vsi+Nlu93UN9wDNdnTpnk292VX1CvKvChwf/xwuRe1wW2CL/XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQij8AGvrp2S5MvbGGyR8nTlr4acAt8xokWqeMGlFMuYR480f
	IFoPJUD+DhF+VNFjxUTmXMU0EjGNyWpMuEWI1VJxI03Bq/p6dvkZg4eawn8LsMbN
X-Gm-Gg: ASbGnctsL60UOeEVVB6x4YP0iWS9A9jGJMzIG4LVCF95doTRHjOx+ADJt+cVdn9c6ov
	lmX3s6DAMgw3Kz7FnOVaIORLy9EWhfBns+JTtxxNAeSc6MGaiXp8vPIpUWQQwqqjse4vksUyDOt
	Svy7vI7oECpEalno9xVIvpiQi5h4RY9FDZ+yGvc1khT4a6Gf0HMMqFxPOSNiUtNJc7afhYpHctI
	zfO9zhKuVaS0kKUT82e3gd3YxThCkSlBVPHA3doDOFDPa5Z8lkF7RUi6cowW4/zR6AhgQbtkT9k
	LvCadFzGSkaBHHsKczS0b7WrFRs1GM8Y21TEj9ze+2tXAen3XNh/3VMiqaYoC3bIEv2xMSVaNYh
	j+E2waLG6KrT1bNh4EiEB7XRw4dux
X-Google-Smtp-Source: AGHT+IETGzbueWL0A4W2Dkm2PPl7As5D9BLxcyGMEj6GHL/sELAonCckbhYVL/yeXU3UIscCnMnNfA==
X-Received: by 2002:a05:6102:4244:b0:4e9:9659:3a5f with SMTP id ada2fe7eead31-4f161118db0mr3937406137.10.1751527834405;
        Thu, 03 Jul 2025 00:30:34 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-884d1c37829sm2714265241.11.2025.07.03.00.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 00:30:34 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-53164bd0df3so2327330e0c.0;
        Thu, 03 Jul 2025 00:30:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzXXLIzhFFp6TbvqscP4Q58RXb1znbRSL6hydWKbOfn/BF4Kc64+ER+wYBFwIBMOaSGEu0YquQWA==@vger.kernel.org, AJvYcCX8Gxtyktm3b7jJPG+FfmpsZMrrSXpA91sCZdxDr0BVFkyBNZBxBbS8lWq6Xwpb96pRf01jyMhWqexACPJBYiBNl3E=@vger.kernel.org
X-Received: by 2002:a05:6122:7d3:b0:531:2906:751e with SMTP id
 71dfb90a1353d-5345842cfadmr4571974e0c.8.1751527833937; Thu, 03 Jul 2025
 00:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldp6cadg.wl-kuninori.morimoto.gx@renesas.com> <87h5zucac8.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h5zucac8.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Jul 2025 09:30:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWzSY1FofgbveAZumuuyE6B=Ub2Zxpd9_ks_d9KmrVYtA@mail.gmail.com>
X-Gm-Features: Ac12FXxEzID7M9TapRsmQDCn9CLMz4bKZVKsQZKsnbBY9o_qPQ2vxLkJcHBCCJU
Message-ID: <CAMuHMdWzSY1FofgbveAZumuuyE6B=Ub2Zxpd9_ks_d9KmrVYtA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pmdomain: renesas: separate R8A7791/R8A7793
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Thu, 3 Jul 2025 at 03:49, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> R8A7791/R8A7793 are sharing same code, but because of it, Kconfig
> settings is a little bit confusable. Let's separete these.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> --- a/drivers/pmdomain/renesas/Kconfig
> +++ b/drivers/pmdomain/renesas/Kconfig
> @@ -54,13 +54,17 @@ config SYSC_R8A7790
>         select SYSC_RCAR
>
>  config SYSC_R8A7791
> -       bool "System Controller support for R8A7791/R8A7793 (R-Car M2-W/N)" if COMPILE_TEST
> +       bool "System Controller support for R8A7791 (R-Car M2-W)" if COMPILE_TEST
>         select SYSC_RCAR
>
>  config SYSC_R8A7792
>         bool "System Controller support for R8A7792 (R-Car V2H)" if COMPILE_TEST
>         select SYSC_RCAR
>
> +config SYSC_R8A7793
> +       bool "System Controller support for R8A7793 (R-Car M2-N)" if COMPILE_TEST
> +       select SYSC_RCAR
> +
>  config SYSC_R8A7794
>         bool "System Controller support for R8A7794 (R-Car E2)" if COMPILE_TEST
>         select SYSC_RCAR

When configuring the kernel for a Renesas platform, all SYSC_* symbols
are invisible symbols, which are auto-selected when needed.  So I see
no need to complicate this internal invisible logic.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

