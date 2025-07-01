Return-Path: <linux-pm+bounces-29885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D640AEF3E4
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84631BC2CD6
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB425DAFF;
	Tue,  1 Jul 2025 09:49:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43988221281;
	Tue,  1 Jul 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363391; cv=none; b=VgMTux14ulhr44bJ2C1PqenOc6qhftpovOzFGslkOPhdNUi1Sg16LGKYyfYXu4lD6fTSrmx2byZ/NEOvwPXXxVnxZL2t46dApWZOWkuPIZLQaDfJOnbUjwZcxXpV9yxlZFw9VhHvDuFuY0of6HvX4Y9dI3a3Mq0aQBQ21I4NjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363391; c=relaxed/simple;
	bh=RnXlg8AJ+ernY7eQdJmoxzM3rqTYCMTSE4KMB8mRE2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSrMR3J8m3e+tBlDY223OXx2sL1RuVvVahjqwAENcqkqDrI/i+ail1ba+/fz3cIPgN0EunJAbhnclUQRHfHIhM0EK2V2YaAY8Al8YMrp5pvxkNnc3gY+WlLPA6cx15hLvK4yvusxelsXQVLkVqTBpwgajoQqOM45QOB290nySwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e7fac85892so1447888137.3;
        Tue, 01 Jul 2025 02:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751363387; x=1751968187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hpOzG4bA/3/H3ZPetNO4dpuhh7/G4WIu5rMJYldPpA=;
        b=LG3JDaXNkW05tZrshzryV6Wuxm2SgD+QBnq4kY3ZIBe3DkwTzw+m+Ru0f6zBKOQF1f
         4nFU4uZT8lThZrALFcsQP6J4/7vWgCoigtUQjJxoJ3OZcY8lwB16l83ect3MRXw+SfRI
         UEd+QLHopAKXBNyseLAmj0A5x9W1Itr51ew+1y7XjHYECp/5sbMibHGzYzOUN/ojsoqU
         fZbnAAkfoKQpvtOwtPWMSvCvxUGIaPsOQy/Vd03utsL6xtuTyCkSZJTeVEODxpsKPHm4
         fFNbDc42Zi+QBRmBmCBbSxAdN0Lhs/pYsRjEObVt2YLrhj6fk8kQDQ4UrIqmDq36J26+
         k3bA==
X-Forwarded-Encrypted: i=1; AJvYcCUMJEH+gd0ifpjpa05RhrCgReOJ5D3SioVlOxl/RnSyDe4AIbb4YCmmIMYipfeHj06TeqFuoulE9jeATToVR1lh+xU=@vger.kernel.org, AJvYcCX2q+lCpXlacXDV9yle9xldMWluFUTOFzva+H7ANgrHlg2fFNpInds6w/hGVql7rgAT7u0+oe7W/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyCoPdGr+kIEM25RAGUAvFZjjz560qe8JdFa7IvlL3EwYhGw+0
	x0Vr7EeOsEffPaFLSyMCKIcHoZ34iNSIj4H1sej1Jpq1gYQZQHE6Xfo+Bkh55SO7
X-Gm-Gg: ASbGncsftiO1aICpu5bF2QCw1npIHpMh3lQYnYeYw0LCocUPaPFDT/UiIJprqyU7jsR
	m3IHgyhY4d5oK8KIemgbrr4BmR0h/HBzfiej7iZmW2+WrXPK/9B9gXOZ6c7en2d8UCzdeCStB6u
	Kq9OJHuSuKPBHIdrnsZuT8wiR5Q0IoWc4nGliSbLCa/q0PazfE3bMack6CDOqQtz1kIB1MrT/Vz
	GuQ9FBTeowPiDdbmxU9nOvZKtsKiN+z6pkMhvfcFh+XwrX5oCp2u9w1ON4gG8l6dqx/MarUGrEU
	PpzSwc4aiu7yIJuU7U9Qd3Tuk3nmwRZkQbUKBoVfJDjKQHZz7/aibDc2bAPtLyy+Mu3cIriavbO
	bxdHfaPBC+MpBdqaNZIXS7UhVbw8s
X-Google-Smtp-Source: AGHT+IHqESHLBGJ1I4l6vKdVDE4Zn5SH3RV6UphFPZfQmzIYJ6JbtPuV73ydvgdxz4LO9uhJswWStA==
X-Received: by 2002:a05:6102:6101:20b0:4e5:9426:f9e6 with SMTP id ada2fe7eead31-4eead771486mr6213045137.23.1751363387090;
        Tue, 01 Jul 2025 02:49:47 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4ee4cc5f0e6sm1498589137.30.2025.07.01.02.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:49:46 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-52b2290e28eso1245049e0c.3;
        Tue, 01 Jul 2025 02:49:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBIAeKYW61CLH2s5ruoTis/HI74XKb+xrNtCGTz5zQ83PPGDMfLOJRCm1l32cI7BnyZTixEEBB4A==@vger.kernel.org, AJvYcCVfQSbeffy4Bu0JX3NMpQcC4IbzrZTBTA+2T6TQUm2S591tH9esL/FZBLGpdDgdsAM+Wj9RX8DBMtl3VmxLcpifWD8=@vger.kernel.org
X-Received: by 2002:a05:6102:e0d:b0:4e1:52fa:748d with SMTP id
 ada2fe7eead31-4ee4f774e46mr9862697137.15.1751363386437; Tue, 01 Jul 2025
 02:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qlagmrq.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878qlagmrq.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 1 Jul 2025 11:49:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVqqCX1=2j740xnU6C=C8x=K-ayQ-uSbmafPVaa-nGtMA@mail.gmail.com>
X-Gm-Features: Ac12FXxx2fEEmHjOdGwvXVeE_pFneiFDpCS5yRUBYJfKgWs1i5G42mN_PEnt1xA
Message-ID: <CAMuHMdVqqCX1=2j740xnU6C=C8x=K-ayQ-uSbmafPVaa-nGtMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: renesas: sort Renesas Kconfig configs
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Mon, 30 Jun 2025 at 01:18, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Renesas Kconfig is using "SoC serial number" for CONFIG symbol, but is
> using "SoC chip name" for menu description. Because of it, it looks
> random order when we run "make menuconfig".
>
> commit 6d5aded8d57f ("soc: renesas: Sort driver description title")
> sorted Renesas Kconfig is by menu description title order, but it makes
> confusable to add new config.
>
> Let's unify "System Controller support for ${CHIP_NUMBER} (${CHIP_NAME}).
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> --- a/drivers/pmdomain/renesas/Kconfig
> +++ b/drivers/pmdomain/renesas/Kconfig
> @@ -2,114 +2,116 @@
>  if SOC_RENESAS
>  menu "Renesas PM Domains"
>
> +# SoC Type

"# Family"?

>  config SYSC_RCAR
>         bool "System Controller support for R-Car" if COMPILE_TEST
>
>  config SYSC_RCAR_GEN4
>         bool "System Controller support for R-Car Gen4" if COMPILE_TEST
>
> -config SYSC_R8A77995
> -       bool "System Controller support for R-Car D3" if COMPILE_TEST
> +config SYSC_RMOBILE
> +       bool "System Controller support for R-Mobile" if COMPILE_TEST
> +
> +# SoC
> +config SYSC_R8A7742
> +       bool "System Controller support for R8A7742 (RZ/G1H)" if COMPILE_TEST
>         select SYSC_RCAR

[...]

> -config SYSC_R8A779F0
> -       bool "System Controller support for R-Car S4-8" if COMPILE_TEST
> -       select SYSC_RCAR_GEN4
> +config SYSC_R8A7791
> +       bool "System Controller support for R8A7791 (R-Car M2-W/N)" if COMPILE_TEST

"R8A7791/R8A7793"?

> +       select SYSC_RCAR
>

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

