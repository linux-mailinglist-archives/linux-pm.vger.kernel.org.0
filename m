Return-Path: <linux-pm+bounces-18995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E248E9ECA53
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE129188C0C5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 10:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59031AA1C0;
	Wed, 11 Dec 2024 10:32:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E27080E;
	Wed, 11 Dec 2024 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913123; cv=none; b=bx6LGFKvZuivONK8doms0R2m7AZ/hUiFCcMFEqNn8Bm9rlnFihOW4MjIntCUJcuUsYYIEWOSfe//ryu2grV5a8zh86mN+D2mEp2lEmdMcYj1Jc5Dcko0mj0G6NgWBW/e1MioCUwQriKvmGmoftcuKni/aKxddSBTy7NBaqpg+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913123; c=relaxed/simple;
	bh=vvbIMsKFGRouwxwNL2xJ+YwuGu1qOdxwhUKtu12VLrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ecfm3YIYJWpCncl/6G20d4/3aLg0SB2GNYNe8RUxDme6dsSUKGHzugNhSmq/er1U+1RW+Zsx/H8R0tWG7b3Zvtg+M1t2bVSGQDvuHhTFSfcyDbBflG+kmeVNyrI81xk9bZlVx55LTw0LlZR9fSlIG62EqtwyDpZSQZR4Xf8AjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-518802a1e7eso1421401e0c.3;
        Wed, 11 Dec 2024 02:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913119; x=1734517919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+MDsr8huyTLqyUVeHOpEDXmsDH5QVNclrAtaTfv2Zc=;
        b=neOZK7QIENptQukYjhi/ol8odcrIYiDePYaWCvQIX4uH6ch6ICMoRb6K6bmyuX3snx
         xtQUo/F0r8gQkGwPUBPaynXyooVE0GqrFdStmn3g+b+186IiSSii167UC2igUNqgTjJv
         VBkQaFw+vbDeauwnF9/DFdMOh8ZN3Q3fLK+1CBAvwQIv5PDG3APwJRysgbF2bti4XPfW
         zYbZwn/Io6Lyj3X7q+mDhS/tIH9U++VFehonSWUGKrR7WRQy5NyVxHZvC41+NuuMFhWj
         Jagq8AoW9wefZ2Z42aGJb5+dVLDLaZzvDlHLct7hADfLAHi55x0IjkbqSYQuH2WyTVGN
         WKUg==
X-Forwarded-Encrypted: i=1; AJvYcCUfeT9rCGiYxAiy1zKxLe40K/6ltUey4aKWemv+9cvYPyhQLV2yC0utu3gBftoeYufFrQRgus+3VF0=@vger.kernel.org, AJvYcCVZyVJC4pMKEhiEueRBg5CldRpZ+iLUsjGVWnb71p9JP0Wx8Y0Y2uwogdCLwELRBIgmxDwbVGwoliTXxuVX3SuxjJs=@vger.kernel.org, AJvYcCW/rJ6bTibsMjlau6t2BcHT9dkQmHKdBleCSYLTJ4G/BLJr/i6opjuULVBDAYvR55Rflgr8QGxCx7dx@vger.kernel.org, AJvYcCWoPOjt/+NeT7DZR4HSAafpIVCOd1ciKKFSbfxcJHvqGTjz7DPvLxpfOBtakAQeq7wEj0qbXCpev97rKatD@vger.kernel.org, AJvYcCXmM/MLFZzIJsZk2jYPWK3TnzsK1a07ZcW+qNqfIw8iVJvUBLEQ64sEaGnvQoWpbngQnczVRHIRDrJm@vger.kernel.org
X-Gm-Message-State: AOJu0YxAd3nqNi69xhKqQySKof92PWd9kjeMrmUFdWwyC8Txg1ca4Ajg
	AvT05w1jz+9fdMT0AyYk+T2o8JTb+Nl+d1heDP4PPIo6HpkVmAiGSs892ufy
X-Gm-Gg: ASbGncvVJAPQvcNUn6aUM8L3TGl3zUQ/Xe4PRHf5BWjvdrdyciAD7w013qpw7mn14Lo
	eiHa3Y9b6aouWJh59TiCiakSOLXCl0KXTFE9WizJak6KmOrcma8qClQD3odXAI546lSC/7U7RJ5
	jsoolGwthLr3TfGgjGXfESIH/HD76rPHVW6p27LGnEV/ZsPiqu4s6eq01NjMR0vy8HzfAeaH4N5
	UaT5u9LE5b2WbCXkA9FPO2y7gEikgo29GQywjEzHn/YjVFOuWOzb7UeC41faCTFTawoRCBpW1Vg
	dI6JG1PVG4G0Kyy6
X-Google-Smtp-Source: AGHT+IFhaaTCve1BtENFDB5mGp85ndp5dT1fXvBQP3z302eXnQ+WSfwC7o1J57Y3eE+sWOm5j2KoMA==
X-Received: by 2002:a05:6122:2510:b0:50a:d1e3:82f7 with SMTP id 71dfb90a1353d-518a3cc335dmr1718899e0c.8.1733913118747;
        Wed, 11 Dec 2024 02:31:58 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5161697f966sm761130e0c.22.2024.12.11.02.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 02:31:58 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4afdf300d07so2346855137.3;
        Wed, 11 Dec 2024 02:31:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkClaLpkclzofok/bWdzI0lt/CWEL46IgKex2YF31qXyNH7MJ6OfgAToxQJ88wO/R+WLYjV0HuGco=@vger.kernel.org, AJvYcCV/HGMKcwSno/3G5cO1gqTNcDuOE6gpFPVa85xaN14H0VwOslJtUswnCXNARRCaEIAbdIKwvdIoHKPku/gyiuQkTvY=@vger.kernel.org, AJvYcCV4kQXmmeOHJYrmeX/6VZD0uWCu03t3Hnygho89FaisHa2mkQlMHfSFqNUCb9H9i9YUHSNi9cSB7x8y@vger.kernel.org, AJvYcCWBQOGMKiYCaZAvbuPOt5B1woSpYJ0SC/GTk2GMWw1KYJidHIQgvT9NJb2ugrGAVvlfMwTlQcdlbWOjwC9u@vger.kernel.org, AJvYcCWKwUPo/MXdfkVS6U1Ubo1C/fWk3dwBh+CYFHSJnTRgna7iyB01nHfGxp79uNSbPFPoIUQ3OyQ0gw50@vger.kernel.org
X-Received: by 2002:a05:6102:5114:b0:4b1:102a:5834 with SMTP id
 ada2fe7eead31-4b1290e242emr1983934137.21.1733913117926; Wed, 11 Dec 2024
 02:31:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
 <20240422105355.1622177-9-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWhRRdfoqg_o6bU7jjt5_Di0=z7MJ4fMh=MJ0m8=u4tgg@mail.gmail.com>
 <80d56236-2499-4c89-8044-6a271e47515d@tuxon.dev> <CAMuHMdXOztsoKp=9-TDXirJN8voRy0O5mYXcVy=Uz-GX0B2N_Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXOztsoKp=9-TDXirJN8voRy0O5mYXcVy=Uz-GX0B2N_Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Dec 2024 11:31:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXTRUiToA3r8+xgS0uUrrfOF8iZA58_na0V9+JB6hg6Q@mail.gmail.com>
Message-ID: <CAMuHMdXXTRUiToA3r8+xgS0uUrrfOF8iZA58_na0V9+JB6hg6Q@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] arm64: dts: renesas: r9a08g045: Update
 #power-domain-cells = <1>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, magnus.damm@gmail.com, ulf.hansson@linaro.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Aug 1, 2024 at 7:34=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
> On Thu, Aug 1, 2024 at 7:28=E2=80=AFPM claudiu beznea <claudiu.beznea@tux=
on.dev> wrote:
> > On 01.08.2024 19:13, Geert Uytterhoeven wrote:
> > > On Mon, Apr 22, 2024 at 12:54=E2=80=AFPM Claudiu <claudiu.beznea@tuxo=
n.dev> wrote:
> > >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>
> > >> Update CPG #power-domain-cells =3D <1> and move all the IPs to be pa=
rt of the
> > >> IP specific power domain as the driver has been modified to support
> > >> multiple power domains.
> > >>
> > >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >
> > > Now the watchdog fixes are in v6.11-rc1, I will queue this in
> > > renesas-devel for v6.12.
> >
> > Only the RZ/G3S support has been merged.
> >
> > The watchdog fixes that allows us to use this patch were submitted as R=
FC
> > but got no input from Ulf, yet.
>
> Oops, postponing.

The watchdog fix is now commit bad201b2ac4e238c ("watchdog: rzg2l_wdt:
Power on the watchdog domain in the restart handler") in v6.13-rc2,
so it is time to revisit this (and rebase my renesas-dts-for-v6.1
branch to v6.13-rc2)?

Thanks!

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

