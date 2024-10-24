Return-Path: <linux-pm+bounces-16352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB679AE1F7
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D123B23208
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66C41B4F1E;
	Thu, 24 Oct 2024 10:03:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4301ABEB1;
	Thu, 24 Oct 2024 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764185; cv=none; b=D1AWUU41zg4J84C81kFUQ/nz+9zvSPBc3K3xKRXykJpfSU/Bsu40iSwTDW8iMMROucjmGUDzGdYLIXXpjD5QkKfWXyTe7Z696WMsC6hjHEhBoyAKkm0DvsPglKlN2xdYr5L+eY/PrnHWQHfmEumYyGDfvf2T2zO8khGkV62C+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764185; c=relaxed/simple;
	bh=J+rigs84cEOrSeUP5HUWVUqYvxRgBWl/JIbGBFrI0LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIyVaTfPa3xtPg/O+G6lBAjjPvtjkkqCM0yU1KeG/Wu0JdQas36zSU91i+a1s+k8QvXNmAZWcpXm3U6OPx1BLEUR9cA4rPu/K/oQ7anf1JMiLB2KPD9nFoNh4OEGPgPX7UCPMtAiKzaXBKfIsgQ7NG9uoNyfqLkYsLPyx8DMxS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2915f00c12so844810276.0;
        Thu, 24 Oct 2024 03:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729764180; x=1730368980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wR+ReAFqlw5wQ/dQbssFh1mp4/XMUn5+HZryu+kjyw=;
        b=dBdFjwIn4ineaapRnLelfINegvCUmzWgdiL4+HU4k55SlBiOySCZxVJ59m+xJ0frAI
         Si3vK2iR8RJlvZAKSYS65C3AT6rbmXcoL9OVRFjMeGuKkn+fVCprbWREX5TJ4FKPJZOG
         Q24oI1zDBjBqEg2UHe2/b7NklQ4EWGMGejzIR3MSW8SMC0kx3CpLIjGDVSbMBXFp0fKU
         IbdLPg+mY63SaSu+AKVKz2hoxHt7E9XZ7HBNtzEmbNLCZ2dRXr5ZDOapyJfusgiIIMq8
         ytHnWYmJWZO4W0dpwY0TnQuE7PfJtbX6jvFsFEeUgMe7Kg4cBn7hlz877Iqt0q0wVeT3
         4a4w==
X-Forwarded-Encrypted: i=1; AJvYcCUbJv8rZdnnjubmGvRtsU1yH9mfYYZkm0O+3MKQ5TO2yLs1NCsxCLzu5AQRnBSzupWV9fxkFyO4DMg=@vger.kernel.org, AJvYcCUwST+vgqHA/x5scy6Jkcsp7V0SwyK0JbYiQGfvH2EIlui+93IUzxP7LJNyyqhzzRQKe/KN12h3ge3bpX75@vger.kernel.org, AJvYcCV1R/CD6Gyhhu6Ut8clFICZPXjyKy6KhBQRPJcY5QHxNCUh/KDGEMW28LqbKGWS53uOzDqMTQReloTLbTCzRUo61kA=@vger.kernel.org, AJvYcCWfrfx31F3QeDdDfJh2Bil4pgUpCet/TBZNL7hR9xY/TH2PTOTO9UBvFoiRu9if+8+L2OrEB5rJ6Ug=@vger.kernel.org, AJvYcCWuM8/Sa1Yx3+U33uLBZ0fPbLNVMYi6n6DigKRMZ5FOzz4Op+Xwr7v94GOAbQzlBjENpAhEfT8U1odugqlD1QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCDGHrcmWhpsT++3Ej548wRYtlhhRr3ElEy6/w0sKtUe3HgP4J
	ksa+v8tIKUThwZJT1zWwc6YF9w286QzgWHbSCFoJeCcfbY1AXvoCFNPnlU2v
X-Google-Smtp-Source: AGHT+IGCdRm3Qn/TkTQsKsjqIDjfTnwpGIqyLAkXY/btY333yUZ7vnUHD9x1hW2a0LTe4+/lyOzaUQ==
X-Received: by 2002:a05:6902:2209:b0:e28:f558:ae4c with SMTP id 3f1490d57ef6-e2f22f1ece3mr1135291276.1.1729764179074;
        Thu, 24 Oct 2024 03:02:59 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc96b309sm1810198276.7.2024.10.24.03.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 03:02:58 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e33c65d104so6501137b3.3;
        Thu, 24 Oct 2024 03:02:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUquUITd+aa+p1LokdQMV7bNusqdqKjSmi3hCexXYHX7mN6rvG/8TxDE9BiDl8RhDyky2pZMtmG/iDuycZs7MM=@vger.kernel.org, AJvYcCUsFiXb1OEqa9qZ/Fj9Bg9i7dbH9D9IfePOi1dLpZ6b6DjDkx9BsEHo2YSxM6JW1gx8gF1pYyEZq2A=@vger.kernel.org, AJvYcCVCR/xVrJY5Ljlum2uu1kfgUuc8wHpe7HNzCooi6zaLF1XumK2dfj8IKSsfD+AOnOYCmooZPLgDDtQ9oFL25vO8Zy8=@vger.kernel.org, AJvYcCXkrIUeDy4YDeCJrOyCtxEZgkomE2RFozwdT9p5ur7rhTwnM+o7DmnC5C9aHobgz3GhXcrsK0J5q2PJ0HzS@vger.kernel.org, AJvYcCXnet0DXH/Pj/3Bv53DaszhrVnRnPaQ1/hTWnknGhrdmBLMSEJDbcPXS0XRBx5R7Lonpqf4yNFdo/g=@vger.kernel.org
X-Received: by 2002:a05:690c:6f85:b0:6de:a3:a7ca with SMTP id
 00721157ae682-6e866324961mr16610797b3.32.1729764178161; Thu, 24 Oct 2024
 03:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015164732.4085249-1-claudiu.beznea.uj@bp.renesas.com> <20241015164732.4085249-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241015164732.4085249-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Oct 2024 12:02:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWKSDDvOciYTMdH=ZU2j9G3nyrXdSmf6UpqkBP31vV=VA@mail.gmail.com>
Message-ID: <CAMuHMdWKSDDvOciYTMdH=ZU2j9G3nyrXdSmf6UpqkBP31vV=VA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] clk: renesas: rzg2l-cpg: Move PM domain power on
 in rzg2l_cpg_pd_setup()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, wim@linux-watchdog.org, 
	linux@roeck-us.net, ulf.hansson@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:48=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Move the PM domain power on in rzg2l_cpg_pd_setup(). With this the
> previously always-on power domains got
> struct generic_pm_domain::{power_on, power_off} populated (and
> registered with simple_qos_governor if #power-domain-cells =3D <1> and
> with pm_domain_always_on_gov if #power-domain-cells =3D <0>). The values =
for
> struct generic_pm_domain::{power_on, power_off} are now populated for
> all registered domains but used by core only for the domains that can
> use them (the PM domain should be non always-on and registered with
> simple_qos_governor). Moreover, the power on/off functions check if the
> mstop support is valid. The mstop is populated only by the RZ/G3S
> initialization code at the moment.
>
> This approach was chosen to keep the code simple and use the same code
> across different implementations. There should be no issues with this
> approach as the always on domains are registered with GENPD_FLAG_ALWAYS_O=
N
> and the PM domain core takes care of it.
>
> This approach allows doing further cleanups on the rzg2l_cpg power domain
> registering code that will be handled by the next commit.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - call rzg2l_cpg_power_on() unconditionally
> - drop the governor parameter of rzg2l_cpg_pd_setup() and decide the
>   governor based on always_on flag
> - collected tags

Thanks, will queue in renesas-clk for v6.13.

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

