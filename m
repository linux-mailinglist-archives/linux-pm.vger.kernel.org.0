Return-Path: <linux-pm+bounces-31864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774C7B19EAC
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 11:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AFF3A8BEB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E25B2417D9;
	Mon,  4 Aug 2025 09:19:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9C31DDC1E;
	Mon,  4 Aug 2025 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299162; cv=none; b=MRfh5xo931f4Y/QCN1qc7XG7N235bkqIXBkfY8E/B8184hX0ikHZF95GBA9e7x9WXY0MCn9MWMWbmZGwE8Z2oMD+ul5tOiaLQnbbWEIWTQDdzqwjMFCU0aONBpJmpWcBgF0ejjxT97cwIVfUuP0CkUS8WVji3TBrLLv3nanes+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299162; c=relaxed/simple;
	bh=f89soe1tWcJWlj9nKeYQYQNz90r+oVX/YBCtfmZK0ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ahx0g+WHqf2rgZggKK8hFH0vIQjBSiEup7w9uEEfdoVW3Zg477n6CNBCymEQRvkP0vEhKcJPLqdwkp/zCgAsX4Bxu3Ixta2kEEO2TaobWE9CdMIBiZI6dITsYJrafEwJzJ9ySIp4/R9DwylKk5v9bKUZ0OcxrPloSBuLOuiByRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-88db7a27cdcso560320241.1;
        Mon, 04 Aug 2025 02:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299158; x=1754903958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3R0MwzTtyzGqGjBOQSRXBmPgHP9p4YXhAFmXsT8hO5g=;
        b=Nhf9C/XY+5gfpXElaJ5LC/Q2mAuaFQHjxv+brByRtveph8raxGmhSxCPi/Q4NGIA7A
         yzOI2RgqvxwRtE/9F0+xVbwMbH/t76FJYNmSqHi/om9FWHyHG4Mblr7jVPSR1wdwhFP4
         nLRdDUxWIxHsmYAv0ftjiJX25NOnHWxUwPBD2vQ6gNxEEoKXmntX3AsGTuaI2iNTenlp
         1+osDzKR8opbarUgvS70FIM8ZuLYGOJIP8+nivM/K8ZfUXQl3k3rzITMd3+bTFkUPoaT
         q4NMF5KHMlHdfqYDIk0qlEimu2SFWU2DYyus22oJs2K5mnnTTmj7jlwvUMnV1N0F7h3x
         my7A==
X-Forwarded-Encrypted: i=1; AJvYcCU2uHIRqiG4s4DpbFWEMnbBTijFg87sasgL9IaIkW8I5dwh+wTMgHDtuWHuu3QmhT4xMvJ1jm5PoME=@vger.kernel.org, AJvYcCV+q4lVyzPIyBxTjapk3QCebBkUTwraAjoMblOnlkr1YxACz6+fjoERnfLzYHW7h4c4lEW5AN00HTkmwJYi@vger.kernel.org, AJvYcCVOgKLVtl2eN9i2s2FmwIrnv3QomIk3K/HsnpER83mAP2u95p0k652JyfCwgIaIWoqkJO9Yt8h1fZXEa2NKcsDrBOI=@vger.kernel.org, AJvYcCXPthYgU/GaPyQ+Qd7bezP7fXYsy6TUDyk2+NOcN0de6EVzzbdwU6IBtgI6hFuH5sm8TtbTJq8xk60y@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQxzjd0/ns0OCenambwuKqORTAyu0aan5RLj+vIjsJcIm79gG
	47WMkjagi02aEPqZJdG33pO8odVEBAD6PxnehhktfDJAxf4V1SaVqJ7geW+jXsYR
X-Gm-Gg: ASbGncvxP6Kb6M6LsKoGUPh0O8tp+VSqj6BAVDY93v1XGi4VQxg6i9WoaCyieewDbnG
	XNwS5mt2TI6CzjGAeqG/SxP6UCHnN9izZlWFTToFF6u8KzjEKcgFsEQsLVF2IK2E0/bNBNvr+tE
	+IkiY8yIe4XmoXkf/9sROEbrC2YlABeuEtIwU9R4UfiTsYXXYDz0/J/SeCgNWWOIh3iWap8IWaj
	HrJHyjugJWd+hHmN5SY/K6RfAXNUZYawMMQ1NCLxXA3GIHBmoMIJE+5atliwwQHw/mNW/kyyf3G
	DxGpF4H7mB655lo/WKJoG0lxHdSt5FzD3b66x9eEx3EvRmSwVDtJcQOUhEbXBfCibS8RT4kNgrW
	H8+wTYJ93U1EcSRCnRnbCCLhhqegTiBGVXJYbA1Fp3hkdEOqwDGiy41hYqaCI
X-Google-Smtp-Source: AGHT+IGKXfhagjxGC9GSb9habokJFXPtLKtqwtzmBGtnu4J07Jqy1EMb+OR/43pnYxseANkzh6TtvA==
X-Received: by 2002:a05:6102:2914:b0:4fb:f6ea:cf88 with SMTP id ada2fe7eead31-4fdc24463ddmr2795769137.10.1754299158546;
        Mon, 04 Aug 2025 02:19:18 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fc0d229c37sm2345306137.9.2025.08.04.02.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 02:19:18 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-88dc7abaf5cso237659241.3;
        Mon, 04 Aug 2025 02:19:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPnm/Duy3M3CAire5KVg4mz/53bycLime72fo9dcIQondmWvREpEaJvvOI6Ur/BBWP4PSPmhaGoIqaHuLzZ/kb3L0=@vger.kernel.org, AJvYcCVXYd5hL1TsZY/qz1wXcRIx3X4Q8AU7tltsCfg33MnWmsSb7CGgVfLcf9rLzQFAd3j62s+kX5rmxxmBJXik@vger.kernel.org, AJvYcCWU4sgf9QjN/W08Jzag+fQhWZZC8InyEW1eBJ3p2gCSS+z5kDKFi6UV+7hSkAYtPRXIqH3r9eXrLxM=@vger.kernel.org, AJvYcCWhZVZ1kPdZxZ4s30R/YH7DrGYElvqX5/YtwfXb8PkHUD8+Igkgi7xC+Vlk5gMCkfTwEW+m5n/HPGOr@vger.kernel.org
X-Received: by 2002:a05:6102:3a0c:b0:4f9:6a91:cc95 with SMTP id
 ada2fe7eead31-4fdc4908436mr3061626137.27.1754299156951; Mon, 04 Aug 2025
 02:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com> <20250522182252.1593159-2-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250522182252.1593159-2-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Aug 2025 11:19:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVyf3Xtpw=LWHrnD2CVQX4xYm=FBHvY_dx9OesHDz5zNg@mail.gmail.com>
X-Gm-Features: Ac12FXwHScgQqxb8jp9Bi-4OprqVlMn-h0o34YuqFCKjhIYkG7o2nMt4nEhunAs
Message-ID: <CAMuHMdVyf3Xtpw=LWHrnD2CVQX4xYm=FBHvY_dx9OesHDz5zNg@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] soc: renesas: rz-sysc: Add syscon/regmap support
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: conor+dt@kernel.org, daniel.lezcano@linaro.org, krzk+dt@kernel.org, 
	rafael@kernel.org, biju.das.jz@bp.renesas.com, devicetree@vger.kernel.org, 
	john.madieu@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, lukasz.luba@arm.com, magnus.damm@gmail.com, 
	robh@kernel.org, rui.zhang@intel.com, sboyd@kernel.org, 
	niklas.soderlund+renesas@ragnatech.se, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Thu, 22 May 2025 at 20:23, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> The RZ/G3E system controller has various registers that control or report
> some properties specific to individual IPs. The regmap is registered as a
> syscon device to allow these IP drivers to access the registers through the
> regmap API.
>
> As other RZ SoCs might have custom read/write callbacks or max-offsets,
> add register a custom regmap configuration.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> [claudiu.beznea:
>  - s/rzg3e_sysc_regmap/rzv2h_sysc_regmap in RZ/V2H sysc
>    file
>  - do not check the match->data validity in rz_sysc_probe() as it is
>    always valid
>  - register the regmap if data->regmap_cfg is valid]
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

As you probably noticed, I am not a big fan of syscon, so I try
to avoid getting involved with syscon patches as much as possible.
But this patch has appeared in multiple series, so I am afraid I cannot
avoid it anymore ;-)

> --- a/drivers/soc/renesas/r9a08g045-sysc.c
> +++ b/drivers/soc/renesas/r9a08g045-sysc.c
> @@ -18,6 +18,16 @@ static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initc
>         .specific_id_mask = GENMASK(27, 0),
>  };
>
> +static const struct regmap_config rzg3s_sysc_regmap __initconst = {
> +       .name = "rzg3s_sysc_regs",
> +       .reg_bits = 32,
> +       .reg_stride = 4,
> +       .val_bits = 32,
> +       .fast_io = true,
> +       .max_register = 0xe20,
> +};

Struct regmap_config is a rather large structure, and the only
SoC-specific members are the .name (which doesn't really matter) and
.max_register members.  Hence please move .max_register back to struct
rz_sysc_init_data (like in v5), and allocate struct regmap_config
dynamically (by embedding it into struct rz_sysc).

> +
>  const struct rz_sysc_init_data rzg3s_sysc_init_data __initconst = {
>         .soc_id_init_data = &rzg3s_sysc_soc_id_init_data,
> +       .regmap_cfg = &rzg3s_sysc_regmap,
>  };

> --- a/drivers/soc/renesas/rz-sysc.c
> +++ b/drivers/soc/renesas/rz-sysc.c
> @@ -117,7 +124,15 @@ static int rz_sysc_probe(struct platform_device *pdev)
>                 return PTR_ERR(sysc->base);
>
>         sysc->dev = dev;
> -       return rz_sysc_soc_init(sysc, match);
> +       ret = rz_sysc_soc_init(sysc, match);
> +       if (ret || !data->regmap_cfg)

data->regmap_cfg should never be NULL (but this doesn't matter anymore,
in the context of my request above).

> +               return ret;
> +
> +       regmap = devm_regmap_init_mmio(dev, sysc->base, data->regmap_cfg);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       return of_syscon_register_regmap(dev->of_node, regmap);
>  }

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

