Return-Path: <linux-pm+bounces-15265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382C992F01
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 16:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BB81F2486D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E0E1D54DC;
	Mon,  7 Oct 2024 14:24:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8FB1D1F76;
	Mon,  7 Oct 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311066; cv=none; b=bzF1LsBmkQtSFIp02vE+P33zq3idWTma3I0eji3x4cd+xDgxTPeBq5eXZbAwvkKxa/1e+KghdmLrnCseDxk/0fC8ACwsvLjxFC78+3kjTULiJrF3owXBEQyLgXkqDIwLw4g3O4KEgRRxeEUk1ei57lBllRaGPA/iklrRu/y39DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311066; c=relaxed/simple;
	bh=pUkxm7fUjQb+qhIjXOnhhDQzI8el+VmCmHg9towfPkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmaKhX1aC2mVesCRQVj5qCtjMjI36r+HX4iTxXKbMhBQDS+TaqVVco4E4l+IWe3k30YIu+wOgexNcUa3dfTDRcofVSFAg7+ecqxKzHSPrpdVe7SYQ3s7JlNYDmtQfd+8P68OsNwuwODjghohKh9CMSMhyCQn/IiP6dk+qOKLB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6dfff346a83so35230017b3.2;
        Mon, 07 Oct 2024 07:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311063; x=1728915863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWyFdDeOFlTqc1lEh/TqJsuBT5ch4B8N3OptpFlGGhU=;
        b=PL0vph7o4zb+C5ENVHmIgZTYmr3PyZ45rz78YgX3Ma88/lEFnb6P530mvlkIBuB42V
         CHaq2mDuU4Yb+paQ/6BDbBZ7XZrYF+fe2VQwty03Q04+pmRFJlK0pUMTQKsjnKwW6f2W
         /n1GUz6+CtWM3rb0D2QTduIbxcRE2jaTMnjVirm9O4j8KDOHQ1ykeHH+OjzP053ZFVXz
         Y+upahkqtpgBqPlEltHEFKvfEOgUoM2mq5Ow2ktRiRhna4sbNf7UfeDRb4OEyMwwtvoX
         bDjycCygCdsDg6aIcemxG36jEEy3VLezjK+ejEroU7C7EWMwGFeLuIwNDcWVfK9IBZvO
         Vweg==
X-Forwarded-Encrypted: i=1; AJvYcCUBOIxK8E1ZsV6dyAtny9vHe7dR5usR6lK64h7/y67ZQuNm/LTqmSE+SW96WWmVmVUdm01s1s5NI9A=@vger.kernel.org, AJvYcCVCQQ6MvGlBIfBj1ChDXfrREx6K1Z6y9jaJqUmXbxymf3fKxeCq6WbjBNuQx0bCOeSypHV/7m+SUqJ/0W97dwO4+/A=@vger.kernel.org, AJvYcCVMvOrNVEWlmANVmTjNhb05ZI3e50tCbSTZ5VER1Gqk5pzBH4De/1YZP7x2veJ5dSoN68TJMzn6F+I=@vger.kernel.org, AJvYcCW4ku83d24Qh+EUPFzfZNwAZz8l17Z1rcNb/bpnUggxHI8RxPggeweimBi4mPuWZuBwQWhPANJSLzQEXA67@vger.kernel.org, AJvYcCW5OSIih1Fk6CsgXr2DS2+Tsqdd+Ip2O/ic/KCdod0EnSK0rnj2kP6Bg1bDM0cgE2+rLZcDcx6B17iq0M9DA6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoKa3dhBZWAGi3eptDeowoA2j21v+OQOwdlBYSe0rXaa4LirBb
	Cye9OYxgTT7dAB9Yani66aG04W4dF0/4iKARKhYoOpONBYfrouJLNjQ2I828
X-Google-Smtp-Source: AGHT+IFPPLfANMk7NXldywQygfW8TiqhBdu+grYqWs3Ma16O8n508/qPSDP0h3hCmecWzh+tvHgbCw==
X-Received: by 2002:a05:690c:eca:b0:6b3:a6ff:7676 with SMTP id 00721157ae682-6e2c6fcbc5fmr99664707b3.3.1728311063384;
        Mon, 07 Oct 2024 07:24:23 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93f79ffsm10392307b3.134.2024.10.07.07.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:24:22 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6dbc9a60480so37003767b3.0;
        Mon, 07 Oct 2024 07:24:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTL6NFaMwKetdLKVRvknhieM5TKsyySHHsHvy6e/p3u8lDcnE7fgUWAoB3kescevB3PI7SNqzEoAw=@vger.kernel.org, AJvYcCUwyDT/uw+t1SFqZ51nrsC6F6v/93ntHJ4tfOOLF88r6ee+TgWtb5EwKCylYTS/8O0uvmLHfTp4EfUGeL+F@vger.kernel.org, AJvYcCW1x1I6U/M0OGlUW1sGf1Jvm/ftwbOykgjeS3gT7EP9YVnZPNRq1HP2wAzKPzv7s/00yaevAtOV8tlReUXI7hw=@vger.kernel.org, AJvYcCWYc4Gs150STiiBePayN9cWCb9SBEsBIW63oduvGc8kBMPQ3j18VB9DQDUQQxAxyAHuBBTvuMR7HbbQc2OCepdiV2c=@vger.kernel.org, AJvYcCXqm4Nja9CYkJj4f03duy+aE/pxV/iHamcj2L5Dx5aZGN5L2SxfdSfTXz3Du4t9zvJjsOnB7lS7VgI=@vger.kernel.org
X-Received: by 2002:a05:690c:f8f:b0:6dd:cdd7:ce5a with SMTP id
 00721157ae682-6e2c7036ae1mr99280457b3.18.1728311062554; Mon, 07 Oct 2024
 07:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902132402.2628900-1-claudiu.beznea.uj@bp.renesas.com> <20240902132402.2628900-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240902132402.2628900-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Oct 2024 16:24:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXD59-EeW7Z0Etzv_OWMjR0n6Q+zD1v4s0gg0U71qFsOg@mail.gmail.com>
Message-ID: <CAMuHMdXD59-EeW7Z0Etzv_OWMjR0n6Q+zD1v4s0gg0U71qFsOg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] clk: renesas: rzg2l-cpg: Use GENPD_FLAG_* flags
 instead of local ones
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, wim@linux-watchdog.org, 
	linux@roeck-us.net, ulf.hansson@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:24=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> For watchdog PM domain it is necessary to provide GENPD_FLAG_IRQ_SAFE fla=
g
> to be able to power on the watchdog PM domain from atomic context. For
> this, adjust the current infrastructure to be able to provide GENPD_FLAG_=
*
> for individual PM domains.
>
> With this, remove the always_on flag from rzg2l_cpg_add_pm_domains() as
> it is not necessary anymore.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v3:
> - update patch description
> - diff in rzg2l_cpg_add_pm_domains() is now simplified as a result
>   of adding patch 01/04 from this series

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

