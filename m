Return-Path: <linux-pm+bounces-18153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A04C39DA84A
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DE8281372
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5E1FC119;
	Wed, 27 Nov 2024 13:14:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AEA1F943C;
	Wed, 27 Nov 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713262; cv=none; b=gVRFXgdASVf6nJ52VebGtH9EWEVC4t50PsgkLTeSVj1SryhmrVNq6hlqhM4Djw4x9B5LaeyS5YVr/PRpWEH7Mxcye+TuTSP4Yk9zP7LeLvmZCA1FgMNh0RNgHKb+40Un5UV+DS+yDw7g/M48aOWwEB2unGHyEI/gB0khv+x9AOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713262; c=relaxed/simple;
	bh=/+8i36jXa2Ejuwzr9kyN4gfGmnCNBj1LofG1MlJFOTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3VH28Z1+xvbebS3up35fdwq6fugZ9xBBw//rRLyrlUj6UMVDobT6YrLazMh4zRZkMTNQtVn7VPXJkZG6t1+/UfA+Gu7o55pPT4YOW2hHNlOPAJBE8HJ0eyCiEIQyxeilBnrqj0ERKKJ36jUclouPWqVy1YzEcb7+338f5gL+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71d4ba17cd2so1706254a34.3;
        Wed, 27 Nov 2024 05:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732713258; x=1733318058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5N5TeqIz8Hih/q2oo/F5dFMUP3Erj9K850b0DJCwPQ=;
        b=lcdaBL4b6nx4YErpiAn/vkzjqFXDG+/nWq8cXns4S62f4/p0R2exkFPTZesKOYH9Db
         m4d6UwR6dNeUe7AwsdgkoGDeDeDBZT89vnQvEmjENhwu4PXz0YXDjVqW7JUXMpft14Vy
         CxFe6YUPNm3Q0+jV3ywdWK5qjPldq8xdJyWlHFn9HVCRwyH2W34sUnI6PIeSXR1oJkHB
         r0fPHOSFndl24Yw5mxsAEXxB9pbUpQAwZSx5WA81qh723eIOCdi5wdCcMQ+e+m06rTV3
         FTje8dxbOkCQ85LQJ/Hmwt16QNH91LQeXQi5SHVrBxWaf+hNmytmCH5XXIUPc/3WBTwi
         aWOw==
X-Forwarded-Encrypted: i=1; AJvYcCWVOARKIYcJaEiJTj8ggocntarTpXeNM29mBb82t9G0ECM3/pyM49D7U86+w32xhIqKxHIoBlwCggjsIGPd@vger.kernel.org, AJvYcCWgHcRKbrEx43NwsFAA3kHzvpeX28+0Gk2LJc5HZh74SmZKq8V1Zbg3pUpIqlvIiyoyIAMDH5SNSUi7NO0uiedy7nA=@vger.kernel.org, AJvYcCWp8Mf/pT1IyRpkbCgNsGei+FM7CCCJanXkZbmQ6duc5XiUceqoR6Nadg+DZrstpiW81hK9P8gThWQ=@vger.kernel.org, AJvYcCXstM28ZkaUlfotlcEik7gihCuxDx8pZFNufvwjuCrNWNgM5n0Vum0gS14PNYnQczQdJAypUn9/zOITKkGz@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmk9o+amlvm4/3kAUMe7CqPav9BZyWyyhIyapS6OHF3zzJFF0
	kmTEG5RrrwpvdfVOSzuHoVk5syui2bhHzNYCmFrh0EMbsNrtusRVPG/WWyekej0=
X-Gm-Gg: ASbGncv4hg0zs+O4KrbfmpPpCb83ZMPdfrxijxzX1Ymn90pSTcMDtIx6j2z/GV7yaTO
	WE5G+8Mu7h//LPTXAjHQkby0tEiOSOxVJRoYzEuBVMw8OfGDrBjOBWWBHm3kXrTsoFK6Xu1Z3xM
	rhLR5CLrmGHb2rs3PacDZRzpNOp8p7HfCpfZ31rPSJx4mMY9D3KR0pk7zOwm0Z/eulIDNzieoFq
	7auHBz6y9C6QyHcVFmgBDnHcyZGX5G9aCBpIt2Vk/8DW5fdxPbGN0sDidbUeea3WUjmVrVzT4u+
	I89BbloGWc4B
X-Google-Smtp-Source: AGHT+IHDrEKqRQ7HBnxB+9E1S+9qL8bR9Zuavnqa3POu31iBs34Ymxxd0cLMTdgg+ykuHW2uM7EMzQ==
X-Received: by 2002:a05:6830:6e90:b0:71d:4fea:e800 with SMTP id 46e09a7af769-71d65c93a0emr2726228a34.9.1732713258498;
        Wed, 27 Nov 2024 05:14:18 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d4b702697sm2135887a34.53.2024.11.27.05.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 05:14:17 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d5ecf9556so639652a34.0;
        Wed, 27 Nov 2024 05:14:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVLcNK/KWCCb9F+/wffaioPDyeOYCzTkwnTyx4HgVvDcMU6oQtRE41JYyvVjp/tvqBV3lYDy6n74xVvhfHCk5c5V8=@vger.kernel.org, AJvYcCVtKMXQ1NrVrUV77Z0OSIr+iVauYjTz8xRZEhs1iUpzuohTtGw384z06XnY8Z/SHHiZfCdx2vr6Vok=@vger.kernel.org, AJvYcCWn+BuoUnXc3aTE1ecy2qm1yLD0LuFsX66oNtFK3c4zTIso+7Zd5zYPHUhpiuCeZMHsUljEFkrHBMoBv17S@vger.kernel.org, AJvYcCXFuH3jYFLYd1E/qhjSmkyYknKjFly7eF1Vvgb0L/+qxEqaLVN4V98nJZTRSj1cJ2cHcoa713SMPZ4Uh2kh@vger.kernel.org
X-Received: by 2002:a05:6358:7e95:b0:1ca:a1d1:65d2 with SMTP id
 e5c5f4694b2df-1cab15dbb24mr152078355d.15.1732713256919; Wed, 27 Nov 2024
 05:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org> <20240823-cleanup-h-guard-pm-domain-v1-9-8320722eaf39@linaro.org>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-9-8320722eaf39@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Nov 2024 14:14:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWXUyLbypvgTrtx0mY5vF6abW8bab2poso=xn88gNqEmA@mail.gmail.com>
Message-ID: <CAMuHMdWXUyLbypvgTrtx0mY5vF6abW8bab2poso=xn88gNqEmA@mail.gmail.com>
Subject: Re: [PATCH 09/10] pmdomain: renesas: rcar-gen4-sysc: Use scoped
 device node handling to simplify error paths
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Fri, Aug 23, 2024 at 2:51=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Obtain the device node reference with scoped/cleanup.h to reduce error
> handling and make the code a bit simpler.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Revisiting an old patch (the same applies to 10/10)...

> --- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk/renesas.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -303,12 +304,12 @@ static int __init rcar_gen4_sysc_pd_init(void)
>         const struct rcar_gen4_sysc_info *info;
>         const struct of_device_id *match;
>         struct rcar_gen4_pm_domains *domains;
> -       struct device_node *np;
>         void __iomem *base;
>         unsigned int i;
>         int error;
>
> -       np =3D of_find_matching_node_and_match(NULL, rcar_gen4_sysc_match=
es, &match);
> +       struct device_node *np __free(device_node) =3D
> +               of_find_matching_node_and_match(NULL, rcar_gen4_sysc_matc=
hes, &match);
>         if (!np)
>                 return -ENODEV;

[...]

> @@ -369,14 +365,12 @@ static int __init rcar_gen4_sysc_pd_init(void)
>                 if (error) {
>                         pr_warn("Failed to add PM subdomain %s to parent =
%u\n",
>                                 area->name, area->parent);
> -                       goto out_put;
> +                       return error;
>                 }
>         }
>
>         error =3D of_genpd_add_provider_onecell(np, &domains->onecell_dat=
a);

np is passed to of_genpd_add_provider_onecell(), which stores a copy
for later use, so I think it must not be released in case of success?
I.e. both the old and the new code are wrong?

>
> -out_put:
> -       of_node_put(np);
>         return error;
>  }
>  early_initcall(rcar_gen4_sysc_pd_init);

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

