Return-Path: <linux-pm+bounces-15267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71FB992F7E
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517B41F23838
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 14:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AA81D54CD;
	Mon,  7 Oct 2024 14:34:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9718F2E8;
	Mon,  7 Oct 2024 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311698; cv=none; b=I7izdoIAQnkwvXbosryVqZQK0WQEtQfeJ8dv/gIeDEXuoGVpzKnLGiRjkzYl71yPHL8JP366V7O40LI4YCssZMeU4uX1jjKF+8n2JtWUP4AAcn8/s6ejdu2DFvPpe+OejF12Lh8Nm+AtE0LvXyyPn/RgOf2oEvLR43hbw/p80RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311698; c=relaxed/simple;
	bh=qzQoRyW/Wfplz4M1jSRnf4ZwcMpTMBFYjANqbRji0Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krZiV/z2wSI0QtPH+BhDiIhuegp+zQfLIxo8cxAI7wP/Q/yRCOctnIe/CFJ7l8MxHjSZn6PuYfHyjwG1yO+xDqsnd1WznbcvS+I4KTdqxDXrEmU7zRpJJKuOa3WaGfhHCb12XQTuDlSzvVoAeaQ3dDumzMf4XLYBGVbWB7+7rBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e0465e6bd5so1890804b6e.2;
        Mon, 07 Oct 2024 07:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311696; x=1728916496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgfRvfIw2hrPqxojAtVAfwakpPvb5MuSIuzV952AQV4=;
        b=B31Loz/5xdadb6+cyrznSIbMKDZ+zASdpyTvW0YwY/M441e+dkRyJRzq3Jik/BktJK
         +1xOYSjt714fPK7MxREFhqs4RotpupNsV2fOVGPbf6pKyltRt98Lb1L51s34Ny7Txm2n
         eDp7mWVc0iCUkQgK8QmtIxGQYlAR80gv2F2FZeZRQ5lyrNqhrkIRVbsjwBgYFH0ej2lV
         DuBRrLbTYkt10k0W6xnFI7OpY1gjNIbdFxF4bEvaBKFuar8htnaZ/6FdiAdpef3s980C
         32MzKAzO6hP4wC4fbm18zdK/CFM39xl0LAXUNFZPbPT34GbzaErahdJ2+D7jv6zM/ODc
         2oxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsxqTkOBFu1L5tP3Fi0/nAO63j46QqHLgGn4TzObfZUQiIe3cfNKiqbU5G6UmYnk7Xt2Tlf4UEol5mQYZ2@vger.kernel.org, AJvYcCXDWAWsNYkHCw9gK3vNw1FewHIDPOYZsDZQV+iPznZ5Hb3XBAojJuMpkFrlnB4+k2RvvMoJjHB0Uc8NTGtdYhY=@vger.kernel.org, AJvYcCXJ2fZp+VFnB1BudVKs48nI1clArlB0Ke+Wv1tSHB1w7Vf6hNpF76T0XbxNd9GH71JTEJqcd5u6yvmwoJMUeXc5EeQ=@vger.kernel.org, AJvYcCXX5dPCrpPO4Vb0m4lB0qDT8Na73ycmiyHME6UHKaL/1dLuYkL2Iz5rYjeFvsaYgt1uktSipmNE484=@vger.kernel.org, AJvYcCXhiwOWBJap2CdBTZmwjuukM53qUNuQsBHwVQ6VswRJgVMp4XR9sUXiv4hZP8maym9oDSA2x/6jc/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSUGjs9DQKz2W1mSiYfJOSl8/tSKOGRX7bRWFR4DW7R7ATihO
	p/nPc5ccOYF2ww6HgBNllS7CCtt/w89hFxQLO3X5XzqFD2oSOQAL7IkQc+AH
X-Google-Smtp-Source: AGHT+IG56zIs+Mq/vyKIbE0CBfsz8UdllP5xm6WEivv+px76KHM+M78FEfhgBNVSfS6u8mIIWiyJbA==
X-Received: by 2002:a05:6808:3196:b0:3e3:9e8b:8cef with SMTP id 5614622812f47-3e3c131e167mr6383486b6e.4.1728311696205;
        Mon, 07 Oct 2024 07:34:56 -0700 (PDT)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com. [209.85.160.51])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e3c902a502sm1464885b6e.23.2024.10.07.07.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:34:55 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-287c5745a9bso755092fac.0;
        Mon, 07 Oct 2024 07:34:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhAJ/AsZXZybEes7Pa0H3UfyDfwzoMgmg/Y0F23QO+E0mJYHOZBY9T/8lHMinmfoyVZ6geNa0NJ/ftzxPGaTXJdX8=@vger.kernel.org, AJvYcCUo9rnRAQlcZXCynkCFjHMWxD6hyS2KQ/HxZfz+RqIqpocCou92GML9IjW/0KajgZuZse6GdoZmd8U=@vger.kernel.org, AJvYcCW/WltbZd9lCutF/Xna8Vy3Jwd9ZTkcs9EW4qHTGAS50gbpluTFfw2GKGLa14KMaKuB6/Ux3MiohhA=@vger.kernel.org, AJvYcCWGAowGKtxaadHhwmw3JkfiNfMug3e4cX9ZVk1BuvCoA8mzL8Sk3QWtVlWMaY6+QFHdrAZHD6kbQiofiRg73xA=@vger.kernel.org, AJvYcCWx05/D6UIZaZWbUTwkqdkP7sxIdiuzEQSOrwjPl+LpnZwogYdzWdbPZxhfBNJtlKwasoEOasfwZ2pOcm7Z@vger.kernel.org
X-Received: by 2002:a05:6870:6589:b0:270:1eca:e9fd with SMTP id
 586e51a60fabf-287c1d3fbe5mr7231243fac.3.1728311695064; Mon, 07 Oct 2024
 07:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902132402.2628900-1-claudiu.beznea.uj@bp.renesas.com> <20240902132402.2628900-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240902132402.2628900-5-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Oct 2024 16:34:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVU2CRfN0Qpk0QH1qJXV9ohGfY_maybWYsjEi7A8ggpBw@mail.gmail.com>
Message-ID: <CAMuHMdVU2CRfN0Qpk0QH1qJXV9ohGfY_maybWYsjEi7A8ggpBw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] watchdog: rzg2l_wdt: Power on the watchdog domain
 in the restart handler
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
> On RZ/G3S the watchdog can be part of a software-controlled PM domain. In
> this case, the watchdog device need to be powered on in
> struct watchdog_ops::restart API. This can be done though
> pm_runtime_resume_and_get() API if the watchdog PM domain and watchdog
> device are marked as IRQ safe. We mark the watchdog PM domain as IRQ safe
> with GENPD_FLAG_IRQ_SAFE when the watchdog PM domain is registered and th=
e
> watchdog device though pm_runtime_irq_safe().
>
> Before commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
> context'") pm_runtime_get_sync() was used in watchdog restart handler
> (which is similar to pm_runtime_resume_and_get() except the later one
> handles the runtime resume errors).
>
> Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
> context'") dropped the pm_runtime_get_sync() and replaced it with
> clk_prepare_enable() to avoid invalid wait context due to genpd_lock()
> in genpd_runtime_resume() being called from atomic context. But
> clk_prepare_enable() doesn't fit for this either (as reported by
> Ulf Hansson) as clk_prepare() can also sleep (it just not throw invalid
> wait context warning as it is not written for this).
>
> Because the watchdog device is marked now as IRQ safe (though this patch)
> the irq_safe_dev_in_sleep_domain() call from genpd_runtime_resume() retur=
ns
> 1 for devices not registering an IRQ safe PM domain for watchdog (as the
> watchdog device is IRQ safe, PM domain is not and watchdog PM domain is
> always-on), this being the case for RZ/G3S with old device trees and
> the rest of the SoCs that use this driver, we can now drop also the
> clk_prepare_enable() calls in restart handler and rely on
> pm_runtime_resume_and_get().
>
> Thus, drop clk_prepare_enable() and use pm_runtime_resume_and_get() in
> watchdog restart handler.
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - collected Ulf's tag

LGTM, so
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

