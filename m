Return-Path: <linux-pm+bounces-39079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B11C9BBD3
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 15:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931103A7424
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 14:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E2322C78;
	Tue,  2 Dec 2025 14:14:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C316322C7D
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684882; cv=none; b=hLZ8+2QGKoWGDkHtCEWMT0oh/GzG3ZrZAU6itCk7q24QRKjD8tCQ3OyQZMzVy862QtkcA3HBhIZEGmmZA2RFrfFbKoF0jyx8VHraU15tUmR9jt49Ucfi5g9W/OGL+9n1ORD15JjwvnXIuUfNIK8U08xQMcdY/ojcGyiqPNM23M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684882; c=relaxed/simple;
	bh=vHUrQ6w324fYnCNxiHl4mdFInNGEkkrZLMojf3dBXGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Va+YQ4QHnd09ktAtKXlwOwUIwnhFdig0mYZv1rtxwtNZahXds1Xy0P4t0BYBka/94YoHfndB2BMN2uU2gE7g1IbrOsh80YbOfh5WbNschZ0AYl7eDqKhHZfpX6KZ75eLsy/yuDYArR0mSYmHwp8B6gEAv6uy9y+reROWtLKXYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c76f65feb5so3992153a34.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 06:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764684880; x=1765289680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P35uIC8+DPfTCMfHgmdtX7Glr2h/6n9nJWKZMAhyHf0=;
        b=bemnfZFzvJbh+J7jYTg5FfIx18HW1fUQWdSsoFojjFGkg55N/cVK+WBLLsfXcjILsB
         AWUscjZp01AE2vsLoMdVeoXcu/8T21m3OxKIDdilOpneCJBbyEzS+Q+wavUntw8M654e
         n73eoMdoszVpFlBSN+WuBY/ExqIsKSvag3FvSL3yQzlnKYo3imTeAeB7WeDWYbJOj2WW
         IS1LOMQuHAvAQW4f+Xlk1TAquCU69CAyze8EyorLgvGTE8VSxUvrEs0NMYzQ3ymEvxxk
         gseYNqy2rOX3Po6AY+vR8D36VL67wXEGll28aIxGX1mO/HiQzomz4209h9EBqPoJqpjW
         OADw==
X-Forwarded-Encrypted: i=1; AJvYcCWfVYRxCABPE6x2zyGMqXQGXqVZ/3qVCwdYLTXEhNjywKG8yxKazuIgN1uTDmZ5WOuoRPlGjtmwJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQuHzR7DZDhNfyEVEkpM6B/Q/hPuDI7OSR5NocGA7dfUml5wE
	2cGpP5xLEQyiAzIm0By8ncC5ixTYDlcwb2DkceGKOPQ82SayfzQuTC96gAPLk83u
X-Gm-Gg: ASbGnctN9pSciRIoVwEze/ZgAJQemlBG6opdaiJJXpuB/p20kw1tus62M58zVF1rUVQ
	0c/NIFF+rg5pClhYlrIx5jqbZJ22qIq+liEmGaG99NBShuxGUz0iKcbV2qEFK5wZHgqWweNU3fp
	j76tUboBKMlWSfc7x1A0koEk5InT0AdF89/i6wHeXRBct2mzZm/MDG8Z9THr+UCsHhQ/zWe8A12
	3kPiEH9NetO0osnLY+79xst3Sp9/zaqDoxok7Rd6T6S+bTwlHiVe61GtEVRYWBjvkmsq3yC6jyg
	fQw2LD7TMaansHBiYa3wm77W0bIMvwVrHH8qphr68blYHlRRCru0jL/l8TEZdrFTMeHDcMgYJ1+
	w3nb/mr3seIwvfFNUB1K4r8XqZPu/U8pGQlM5DcmOSYvND0lEQF3ViqouO/gZP3BHpxtymYuMma
	qAvz5jFsz0CSlDV/0XrmGavQg0T9dwMB/5Bb3UZQX1pA1HkdJi
X-Google-Smtp-Source: AGHT+IHbCadFczJqamkCG5jIhlCgob/iESAp8i5Opd67B2m0NofkHGIedww+1h5b42gyXkoZyFRkZQ==
X-Received: by 2002:a05:6830:264a:b0:7c7:e29:70ca with SMTP id 46e09a7af769-7c798ccd9a4mr20124188a34.22.1764684879588;
        Tue, 02 Dec 2025 06:14:39 -0800 (PST)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com. [209.85.160.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fceddf6sm6570518a34.14.2025.12.02.06.14.39
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 06:14:39 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3ed15120e55so3290681fac.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 06:14:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURGRXxo/EicAuFTfkRNUT9yMvUcwinxGuUUkdfp1UcHapB4mOovfwMC5erYX+VQhGiqH48sgywQg==@vger.kernel.org
X-Received: by 2002:a53:dd48:0:b0:63e:17d8:d977 with SMTP id
 956f58d0204a3-64302abbb9cmr22209916d50.41.1764684434875; Tue, 02 Dec 2025
 06:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org> <20251112-b4-of-match-matchine-data-v2-1-d46b72003fd6@linaro.org>
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-1-d46b72003fd6@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Dec 2025 15:07:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVAZpp7M+pp27+kHZwoet2Q8Rm-Y4ePu7=W_1oXhebLmQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnQtK_C28o8ts-DX6QMHSfgR5FWBqGmuyp3cjxdu41cx4XkoPs5W_lQhYE
Message-ID: <CAMuHMdVAZpp7M+pp27+kHZwoet2Q8Rm-Y4ePu7=W_1oXhebLmQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] of: Add wrappers to match root node with OF
 device ID tables
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

Hi Krzysztof,

Thanks for your patch, which is now commit 4a93adcbd201aad5
("of: Add wrappers to match root node with OF device ID tables")
in dt-rh/for-next.

On Wed, 12 Nov 2025 at 11:30, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Several drivers duplicate same code for getting reference to the root
> node, matching it against 'struct of_device_id' table and getting out
> the match data from the table entry.
>
> There is a of_machine_compatible_match() wrapper but it takes array of
> strings, which is not suitable for many drivers since they want the
> driver data associated with each compatible.
>
> Add two wrappers, similar to existing of_device_get_match_data():
> 1. of_machine_device_match() doing only matching against 'struct
>    of_device_id' and returning bool.
> 2. of_machine_get_match_data() doing the matching and returning
>    associated driver data for found compatible.

Shouldn't the first function be called of_match_machine(), and return
a const struct of_device_id *, cfr. of_match_device()?

>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -434,6 +434,53 @@ bool of_machine_compatible_match(const char *const *compats)
>  }
>  EXPORT_SYMBOL(of_machine_compatible_match);
>
> +/**
> + * of_machine_device_match - Test root of device tree against a of_device_id array
> + * @matches:   NULL terminated array of of_device_id match structures to search in
> + *
> + * Returns true if the root node has any of the given compatible values in its
> + * compatible property.
> + */
> +bool of_machine_device_match(const struct of_device_id *matches)
> +{
> +       struct device_node *root;
> +       const struct of_device_id *match = NULL;
> +
> +       root = of_find_node_by_path("/");
> +       if (root) {
> +               match = of_match_node(matches, root);
> +               of_node_put(root);
> +       }
> +
> +       return match != NULL;
> +}
> +EXPORT_SYMBOL(of_machine_device_match);
> +
> +/**
> + * of_machine_get_match_data - Tell if root of device tree has a matching of_match structure
> + * @matches:   NULL terminated array of of_device_id match structures to search in
> + *
> + * Returns data associated with matched entry or NULL
> + */
> +const void *of_machine_get_match_data(const struct of_device_id *matches)
> +{
> +       const struct of_device_id *match;
> +       struct device_node *root;
> +
> +       root = of_find_node_by_path("/");
> +       if (!root)
> +               return NULL;
> +
> +       match = of_match_node(matches, root);
> +       of_node_put(root);
> +
> +       if (!match)
> +               return NULL;
> +
> +       return match->data;
> +}
> +EXPORT_SYMBOL(of_machine_get_match_data);

These two functions are very similar, but look different.  If the
former would return a pointer instead of a bool, the latter could be
built on top.

Even if you still prefer returning a bool, they could share a common
private helper returning a pointer.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

