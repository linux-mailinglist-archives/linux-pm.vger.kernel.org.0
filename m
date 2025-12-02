Return-Path: <linux-pm+bounces-39078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD7C9BAEA
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 14:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34D744E2298
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154A31D36D;
	Tue,  2 Dec 2025 13:57:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CCA31B836
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683828; cv=none; b=NK4KsiR8wYt1nXic1kCiMMB8vcvB0QbKdUNfp5iRFKJQf27xa6LNrMCWlP9yEWmnC5Q7ygB+dZUeZQ+MVTWMfWJeN+ZbkAQC8JYL0815SIN5zjJg0iuf73xMPWOaoTRmH9pJ3J28wUrUAIA5mtFAGgXNslKAApbSX3PBuUZWjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683828; c=relaxed/simple;
	bh=ak/Rt6uWiX+MT4pBJfZ+PD2Fezju7a0RibofMkxgxGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/Qox0FWmiieSS33+eZhNiXHtcGVoS4TxK734ArXuPg8AmYGA81lNCVEgdClSSgf4xwOkJwTE+bsEf1LxEN9UMbdJRBywrH2cNPnoBNOePmic07Q2zR70GW5JOLQ3ZwBqygchvei6CNhBFWjTn/nQntRhoeuCpNyKIAY2a779ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dfc6be7df3so1870493137.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 05:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764683825; x=1765288625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcG/XQXLp9HYcvharszf8uW0YuqvJnIwjKHOdBnLhz4=;
        b=L8dQwmgAWqlTkKM0cHeQ2b/HkJ/IZwHy5pVlI5l1chd0sJFyngSKQo9VoqrkdVbMFU
         F8HJ55rqqC7HnkiVCRM5o16m3rL0IR4wVHdgiYBuZs6/6+Ktsp3lRn9ZLaeLxuxxFC2D
         8B0K3P+jqRkhF/pGvEQsbtak42Ewh9v1cJ+SBbnBMdaIRYPTB3KUjXeh3k39a0q+vNTV
         DxAojVeSSMQuEOPSalDMtPsGCWNY26PSunyKJ3tF9pjwPiPpDLMhvXIT23I3s2VNfJfZ
         RYRkBkl0TY+Vazpktl4rTZICMnPvo0mbLEyTvvfp9dLr9loHC5XDJWGSU6gxnZkXgS8a
         OjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlQHHGJzoGtf8e4JvtedC6cnUkdKvuC0f7z0W79j7rPP/sBNPv9f1hrgsSbV/n8XEY/K76+jJySw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5+FEos40L29g/Zno6PzY0klLPoXbf2aGiadTjmRKNi/Tj14Bg
	0Imz8x/Ge1EPggggP8mJvkUavWBoeH73Cl6JNyyGdtiq00HqTJQRsYmCZsZ8JidR
X-Gm-Gg: ASbGncvwPYl2OJeKSlDrryDsk7ECRL/Yp1pP2B3QNNQlufivA6U6Ufj5RYrzs/5ulpY
	LiRLoaLYo1hUgzHmAcyyxfIrrbTa+6455A2NiZ3U3Su7IsHh+Vh9/YIxSIerOQmayRTmKKuHZMN
	NqOY0dcoInKd1nLbSI5qW7AwCc2VhSgBEJgm90+XldoKzRsFfMEAVmHvefO85HquhoF5I9qDBAu
	Jrt0sA1kZlD68UXfG5efkIHpfYIyDNFOTEiQE0u7eJela/7w6NlHK21NTHhgm5RA6NDnThw11SP
	kCTwrA2jvWqYiIk7g6EaoJXtMdPhxowBQT4+EFTnFkbCTypaMquu8lJZPZfh0VwAIa1Ggvn6DoM
	+RA2Uk8/OHELdl6mCZC81ednORTyBymBxamnOxMAHASd6vvYRxkVahRJQI79uuI0u4lkY3SwgBx
	D2Fp7osqxrX1WlMpJg3DuUpCeXgpvzlNloR1y+OZoYWTRaxiPD
X-Google-Smtp-Source: AGHT+IFYuO7iSHZ9ZhKUijIwKDSfRB5c2JndbIB0QN6dQoxPswC1/qlBHnQr2XmP0o+MAdKZ+E1kuw==
X-Received: by 2002:a05:6102:3e1a:b0:5db:cf38:f4f3 with SMTP id ada2fe7eead31-5e1de3444bbmr17185387137.28.1764683824732;
        Tue, 02 Dec 2025 05:57:04 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd6cef362sm6756317241.6.2025.12.02.05.57.03
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 05:57:04 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93719360f9cso1402095241.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 05:57:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVY/Ps2Qw5GwTbnJDCe+ckg74/UNvwGTpps3FP40leNt9klo2ClDBWuO5Ln17OGkZFjudQ8Mjsn7w==@vger.kernel.org
X-Received: by 2002:a05:6102:26c9:b0:5dd:89c1:eb77 with SMTP id
 ada2fe7eead31-5e1de39d9cemr17004298137.29.1764683823416; Tue, 02 Dec 2025
 05:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org> <20251112-b4-of-match-matchine-data-v2-2-d46b72003fd6@linaro.org>
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-2-d46b72003fd6@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Dec 2025 14:56:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVJD4+J9QpUUs-sX0feKfuPD72CO0dcqN7shvF_UYpZ3Q@mail.gmail.com>
X-Gm-Features: AWmQ_bnP_BfEGwKLqJN8UevZeVXg10-IsXC-lVqCY3H9e2HFkqZ11liOD_Kw768
Message-ID: <CAMuHMdVJD4+J9QpUUs-sX0feKfuPD72CO0dcqN7shvF_UYpZ3Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] cpufreq: dt-platdev: Simplify with of_machine_get_match_data()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzystof,

On Wed, 12 Nov 2025 at 11:37, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Replace open-coded getting root OF node, matching against it and getting
> the match data with two new helpers: of_machine_get_match_data() and
> of_machine_device_match().
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for your patch, which is now commit 6ea891a6dd370ab2
("cpufreq: dt-platdev: Simplify with of_machine_get_match_data()")
in dt-rh/for-next.

> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -219,20 +219,13 @@ static bool __init cpu0_node_has_opp_v2_prop(void)
>
>  static int __init cpufreq_dt_platdev_init(void)
>  {
> -       struct device_node *np __free(device_node) = of_find_node_by_path("/");
> -       const struct of_device_id *match;
> -       const void *data = NULL;
> +       const void *data;
>
> -       if (!np)
> -               return -ENODEV;
> -
> -       match = of_match_node(allowlist, np);
> -       if (match) {
> -               data = match->data;
> +       data = of_machine_get_match_data(allowlist);
> +       if (data)
>                 goto create_pdev;
> -       }

I think this is a change in behavior:
Before, the pdev was created immediately if the node's compatible
value is found in allowlist, regardless of the value of data (which
is always NULL, except on RK3399),
After, the pdev is created immediately if the node's compatible value
is found in allowlist, AND data is non-NULL.

>
> -       if (cpu0_node_has_opp_v2_prop() && !of_match_node(blocklist, np))
> +       if (cpu0_node_has_opp_v2_prop() && !of_machine_device_match(blocklist))
>                 goto create_pdev;
>
>         return -ENODEV;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

