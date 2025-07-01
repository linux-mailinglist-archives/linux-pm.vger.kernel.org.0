Return-Path: <linux-pm+bounces-29884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5329AEF374
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406757A7BE5
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2102125CC64;
	Tue,  1 Jul 2025 09:35:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491B130A73;
	Tue,  1 Jul 2025 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362549; cv=none; b=sPqFAX18wSIqjexCAA3qars4pZ6f+KaTRP3Gq8FiRE5BFbQKtyjcIq9+qR2pjbz3AJqkaA7Fa+jFAoP9Cvx7sTt1Y9JOLaUPzYDHi6e8Rs1ViDWcCYRXkEZLRxtve3C3Et9IaGNoXNvo+ZotpYTuGWVpyxIoaDwL2QZ0if5+EwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362549; c=relaxed/simple;
	bh=4/yZRVhckkkdnIhk42y14ft4PKjDzeXsk8J1u4zFlxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCzYOE7TobAaZ2sngCM73WjPDKF+wbUruYIpUC92tiMRLv4wljjVNT8xS7AZZ922sVSE4avwLLZ5Pbrrug8b3AcIV54rOb2fUeDhq1YtPVTQswk2A7K9+JP6MpsbW1Ashw3jitmWdiTOF8dUQc/37enVh02BKIE/oXXsmI2HaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e8088896b7so4236319137.1;
        Tue, 01 Jul 2025 02:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751362544; x=1751967344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkC7eZA+uDX58TZWGGsjh/Z3xk06FWPrdqdvUqT03SQ=;
        b=ZaYzJ5kQJVNwxiUVxUKEzrWJgxUDy7LqEZAzzU3sxvi2k8wZbu5545+4+TgZUfjvik
         krh9vBuwBMk3R3w4SuKYrGQZiK/H2jRJZPlpzBLRijm9XmIrkBg/xQyhZMzsxJm2e0Z6
         7leFOeMp/FgAGuhFhFWW6poHSYjm4s5M0UB095hwusu2zXCPGVFrm3E6kUTiv3zpk+0S
         T5g7a2KJzMZYQXTIe/Bpq63vYip4EvDmS08H9lWCHkAnE3OpcQrxnXS41Vf6PJ/fxoLj
         +fVLE92j7XUH9tphECH/UPK+6wQnAT5i8hWzn0xkRZZX8HIoQBbvzeXUEz0WoVGroHcx
         4MAg==
X-Forwarded-Encrypted: i=1; AJvYcCUTiINld3MnAEzx9XPwMncMmNTRgSLp7Rum9MFhftkIln4Zex13K/RRyy4+EidDq4P20f5yItWKy4Oy07ouKLucAmI=@vger.kernel.org, AJvYcCVw4LuD0ym/ML5ZlcwS6QOLMGgMqZzvX6NK4i39kf/0Hs23CGRfniZM+/W4cjBArQJ4XTCoHp+vWd9jrTJ9yhAVpAQ=@vger.kernel.org, AJvYcCVzwnqDRsoCUAxqc6DFcy2DeTYwshY9Y5ustBwtRJGMk3aNef0F8C16BVh2TEIIL591WcXRIUMeP80=@vger.kernel.org, AJvYcCXqjAvZNQ72KkJaGKdftz/lk1ItXvE2u+BQI2cngbS2u6T/XF6tUzt1wGELyzMLRX0j/FKxMDKsU8MjdSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAUlEPZbSQbEr2d/Ut5iN2/tzJdJx0SHJ3G/xxPS3OPYpC2a3t
	QZjZUoPkIe/ZF6m/lKwdrqqxTuSFLv4aZUdKpdrIh55xJVGEi+oUqAdqsy8eyS3N
X-Gm-Gg: ASbGncsRLE56fAd0ALgklIrSCiePCRphnCkuVRCOv1I+fZlnXe+/EbwgQLf7p7bG8BT
	3n9+cBBUDMFI855s8XayxscRWJT8cQuVQgmYEGpL0T7/kKboIw6JoV31y5lfIclcghzvDOVGj3o
	HIFsf9sKD1NkKVTfIaqi/aoufqQ0yus4O6Dqc26mJSBWJfVbwAGqrnB2Xx8tVXTKZ6ZZRssTItp
	Er927C5DpUFYhSsyDd2xzNbSKqtGLEThHvifDvDRcCnVlDJkGJgTstnCu6pFtKgqIZGuRVztCqz
	ETmUD06t6UkLUzjTRvQ2ebu6BGHI7n+GH2Qqqjpvrz6Tq4Mo6dWMxiKaHEkc5Tfw/LFmIthVSMY
	3BkfJeVHbg6qwwul1ayW2frjryj5m
X-Google-Smtp-Source: AGHT+IHN0HIvXUUXf6jV1T2+PNT+34EOQs+EDUxlGDFe64weAado3IEqoGBw3DS+TSkmuNovDGFDKA==
X-Received: by 2002:a05:6102:548f:b0:4ec:e1fa:ed7b with SMTP id ada2fe7eead31-4f143bec2fdmr1604920137.9.1751362539179;
        Tue, 01 Jul 2025 02:35:39 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4ee4cbbad44sm1463629137.24.2025.07.01.02.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:35:38 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5315ebfd92cso3354139e0c.0;
        Tue, 01 Jul 2025 02:35:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkK8gWl0ez8IEUuAM6L9k6hdXryAQ3cdS3wUR4WxeoN4TyJpww9nhpOS9zQThaBMDEMfB+nnNrpTNUruo=@vger.kernel.org, AJvYcCUrN+PVrwZvFdiAY3LYuEsaagXEg6MNSDaBivjld2193yiuIN7cyXJ3KaBmiwJ/hYj/p5KBC1wjrZ/MlDK4X+NvXdQ=@vger.kernel.org, AJvYcCWMVK9fdFJQ6K+r1IO8S6/h4OK7XB2EBOaaLxtuZHDwPJK5wJCmEO/JTZkn1hbTUjIlYuIZ5KRxt16aHYA6jzgnHaE=@vger.kernel.org, AJvYcCWmXnjbOQ4i9bQXoD2im1dxD0xnQqYFAz0ENRNRD6QZl4s414xK6wvaCHqLxHaASxhifAWjPmR/2Rs=@vger.kernel.org
X-Received: by 2002:a05:6122:811b:20b0:531:bb45:18b1 with SMTP id
 71dfb90a1353d-53425617336mr1027771e0c.7.1751362537889; Tue, 01 Jul 2025
 02:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620160834242DDgecL4HF8b1OBLiZnnrl@zte.com.cn>
In-Reply-To: <20250620160834242DDgecL4HF8b1OBLiZnnrl@zte.com.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 1 Jul 2025 11:35:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVEkq_W99XuKA9KJW5Bm156ZBZowH2gmg2iY27y2fDFug@mail.gmail.com>
X-Gm-Features: Ac12FXxtXuRYLmTpc7TJbisFnd7Fe3xZafLHlyEUkNhw-qkfFhNc1GHH1T18Cpo
Message-ID: <CAMuHMdVEkq_W99XuKA9KJW5Bm156ZBZowH2gmg2iY27y2fDFug@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: Use str_enable_disable() and str_on_off() helpers
To: shao.mingyin@zte.com.cn
Cc: geert+renesas@glider.be, changhuang.liang@starfivetech.com, 
	magnus.damm@gmail.com, heiko@sntech.de, alim.akhtar@samsung.com, 
	walker.chen@starfivetech.com, sebastian.reichel@collabora.com, 
	detlev.casanova@collabora.com, finley.xiao@rock-chips.com, 
	shawn.lin@rock-chips.com, pgwipeout@gmail.com, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, yang.yang29@zte.com.cn, 
	xu.xin16@zte.com.cn, yang.tao172@zte.com.cn, ye.xingchen@zte.com.cn
Content-Type: text/plain; charset="UTF-8"

Hi Shao,

On Fri, 20 Jun 2025 at 10:09, <shao.mingyin@zte.com.cn> wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> Use str_enable_disable() and str_on_off() helper instead of open
> coding the same.
>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
> v3:
> preserve the original patch format to avoid whitespace-damaged
>  drivers/pmdomain/renesas/rcar-gen4-sysc.c    | 3 ++-
>  drivers/pmdomain/renesas/rcar-sysc.c         | 3 ++-
>  drivers/pmdomain/rockchip/pm-domains.c       | 3 ++-
>  drivers/pmdomain/samsung/exynos-pm-domains.c | 6 +++---
>  drivers/pmdomain/starfive/jh71xx-pmu.c       | 7 ++++---
>  5 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> index e001b5c25bed..c8aa7538e95f 100644
> --- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> +#include <linux/string_choices.h>

Please insert new includes alphabetically, like in Krzysztof's original [1],
for which I already provided my Rb-tag.

[1] https://lore.kernel.org/all/CAMuHMdXJ57mATWW4AnBedn+D7TQ4PadkJ642daquFtAo=wZFrQ@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

