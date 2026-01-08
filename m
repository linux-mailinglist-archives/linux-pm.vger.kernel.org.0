Return-Path: <linux-pm+bounces-40475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F84D04021
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 16:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 123E530378A5
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614D7405A;
	Thu,  8 Jan 2026 15:40:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976025CC79
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886825; cv=none; b=WJSOlEgcW7TlydlOHRNFmC8kKuuo1XJMrZ+XmIlRCfEX8zOWNw81Kv/IuhgWEAnNctiEOW5b+VVKu7IbqgNfA0Ruanp77dDZpXBPHN37hlyiGoKMGHwBxj7fzdfPVDXFiylY8/VIPPTdztmWSzBLhwXbTXUydphfb7blD1pTBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886825; c=relaxed/simple;
	bh=G7JSDJeyfhq10WIyx1yxqUoIHN0VScyPB72n/Phi9m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7DL7UIsyaWJ8o0jGGg7wyzv7Oos6iwolS1mDdmK+fqdUouCPlcxQya7mZymh+8+0re7LGuUHAquu1vNZKS8Y4yp/2uUnDPyl/2n4j7GGVAkXX1+7xy9ZPyZyhKi986MWr//Ok89IEI+OQRspQUWKC3uG6NfYxUVIWzqgAdFe+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ed09471ab9so587201137.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767886823; x=1768491623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPCEMds3NUNJIzMjaHhQoyBDppqgLalAn8n+Qce6geo=;
        b=Z1PcgE9yE1w3whTv+BoYWfvdMnj1pT69EjRUbtOm4dG+ZF/3WkMsMgNu0hT788dg3m
         twicVYYNXC3Q7awAUGcTPaqw6zfGl3TqpHXD6hJ8jyXzJPdRSZ9L1j5ClQCgT+hk2sjW
         qe0iC3AjIbscwi/Oq6p2HxIOceHBv0gcpfOLZV/DYb1C7LpDgs8ATw5tssPYNRSYLhyH
         AIGSTh6bENcpklGb42bYmz77WBR6D0qEsuOjp0FAbrkTv1RWSY8xAIxfkZR8U9H9YbLe
         +SowQYq6O+QgybQhLJDbxCX59kPKHLV3qepJQVxuXsLW/iNCqahFJYqgVwJ6OY2HBcs4
         /VQw==
X-Forwarded-Encrypted: i=1; AJvYcCU9MokNCbZ9xGm24iS8qUEbxXX3RGdc7uCN753/Sjx3PEX/oTjlMt2Gn4zPj6S9dI7ctL9EUNwuMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYA7LiG7rQOahkylnxMI4rts4AdLlD6itSe6tzOHcW2hGvHdm
	XMT2KKhLzJ91ANo0FmW4WgrALVshBE3DkrMM3L3IM8Ggd0Nhj+q/jEZWqOjVtEeL
X-Gm-Gg: AY/fxX6p7/g5epNn482veCixVmMTek5gSkuTk+Q4CFcPhdIN6Du/k/YFW8iDFRLF0fp
	AVUVCBAPzqsfXfBczs3WDMmClETqVHfuefb1jF9TBzlJznQIZCApLwl9VAdRgSjtHv85M/1SqCr
	dayBmshh4cOyJ2hLvRJS0E3APnvm8wwQMwVF3WnBsfNtFufJUKTO/wEjcPaYwoFYAXy3wWq/vY9
	lmte4X8F3ER2yOOV12wHxa9eJtmsEu04wozPHM2GUen2zW4UcZY1cnYQwzjJTG9QX3xlK6jPP/n
	e7HrJwt1HGJXzSqFIJRg7Dp3CEebj4vPFE0jo9cUFHTmEQJVtPqwvIo8yfggllkgthV5Co6kc6d
	rC/UV5lh9O0cr36cgyf4yPjmWIRuk5o9P1VkDUjrXOg35fsxWHRBHh7eN9dTTZfD+UqDSOGcVQD
	NAzLde7Q0oTQFBtiOc57KzxuPhcw53/9OCGEG8IS+ipqwaf3DuS4tkXtJTnDqF8RY=
X-Google-Smtp-Source: AGHT+IGOLGg7shKST7oiASxs7P3sEiU7I3IO9zG5ZG2wxMW3OM/v7nU62p6W+DC8wyZN/z+YTP5ElA==
X-Received: by 2002:a05:6102:605c:b0:5ed:c98:37d6 with SMTP id ada2fe7eead31-5ed0c983b74mr1853532137.2.1767886822890;
        Thu, 08 Jan 2026 07:40:22 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124c452asm6130659241.13.2026.01.08.07.40.22
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:40:22 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55b2a09ff61so1048857e0c.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:40:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyWXn99T4USoWgqXlz4r0c51JGLZhLWZTTDAStaA7DHVIjZEFGWkw+qZigGi+sV9krT8Z6FXKvzw==@vger.kernel.org
X-Received: by 2002:a05:6122:8c8a:b0:539:2a2c:6efe with SMTP id
 71dfb90a1353d-56347d53d51mr1984301e0c.4.1767886821868; Thu, 08 Jan 2026
 07:40:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251126130356.2768625-6-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-6-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 16:40:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWY1+xo0sLs_OxLNf0ES0pZy+Q-u309gRXuTsZ3cf2ACQ@mail.gmail.com>
X-Gm-Features: AQt7F2q4mnTwj4mP8-vYCbbynRSDudO3B41aJiCWB2w7nQNsSq50R88G--5ck-E
Message-ID: <CAMuHMdWY1+xo0sLs_OxLNf0ES0pZy+Q-u309gRXuTsZ3cf2ACQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 26 Nov 2025 at 14:05, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
> temperature calibration via SMC SIP and do not have a reset for the
> TSU peripheral, and use different minimum and maximum temperature values
> compared to the already supported RZ/G3E.
>
> Although the calibration data is stored in an OTP memory, the OTP itself
> is not memory-mapped, access to it is done through an OTP controller.
>
> The OTP controller is only accessible from the secure world,
> but the temperature calibration data stored in the OTP is exposed via
> SMC.
>
> Add support for retrieving the calibration data using arm_smcc_smc().
>
> Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

> --- a/drivers/thermal/renesas/rzg3e_thermal.c
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c

> @@ -381,6 +385,21 @@ static int rzg3e_thermal_get_syscon_trim(struct rzg3e_thermal_priv *priv)
>         return 0;
>  }
>
> +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv *priv)
> +{
> +       struct arm_smccc_res local_res;

Missing #include <linux/arm-smccc.h>.

> +
> +       arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> +                     0, 0, 0, 0, 0, 0, &local_res);

Can this crash? E.g. if this SMC call is not supported by the firmware?

> +       priv->trmval0 = local_res.a0 & TSU_TEMP_MASK;
> +
> +       arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPHI,
> +                     0, 0, 0, 0, 0, 0, &local_res);
> +       priv->trmval1 = local_res.a0 & TSU_TEMP_MASK;
> +
> +       return 0;
> +}
> +
>  static int rzg3e_thermal_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

