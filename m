Return-Path: <linux-pm+bounces-22290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E691EA39565
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 09:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C13B8B6A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC4D22F145;
	Tue, 18 Feb 2025 08:23:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F341F868F;
	Tue, 18 Feb 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867036; cv=none; b=gZADomN24Im9czzqV9oQpGJQb837rPmXZ0f5YcvruS6I6PHj8zjO99g0F8JxeyN60HMPlFbsDdxTg7tdbD3j8YhigM+v5U26MO9q8EYEGiE923kZTGRa4TfyeMBeIZStJBhbDbtBQPx7QdP3cFXQ/KjWlYOtyNcwSb2ORlyqoPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867036; c=relaxed/simple;
	bh=J0psMn/hUzFqXL5igr/0AomEPJEjCYMIuzfWe9JFT+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3M5AaPsmvfrFLV9vCqVB0UuiPop8/F/P7BQ76VS43rYbN2fEk8b4r+C+B+jMW8DR68yM2sN+SdALGfwft2yL1uyRuixR36KqhEtkShbvxnEAWztkLGg///hwZzuH+5xiAkeIKMPfEbdewzq7To3PkAXLDvqATSHn/MWn+lTxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4be625c5365so496069137.2;
        Tue, 18 Feb 2025 00:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867033; x=1740471833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqa/u/fDXeabC6KILPhi6Lri/V9r68feo+ZyPSFlFa8=;
        b=S3XRnsg8bsEHnR1b8lWfHC2JXkO9XEnJYdh2V7a3BBJY2ORIaPa4z6KPUx5iX6eAxt
         rJ5S73dAo3/aXQq+170qAsG+zlWce8etrYn1r+V8BCjKzD6KoKI5JVxV1nM6APSc7bp1
         1o8WHQySuG6l7IzQ9XVdaydBjIkhDlXJozwzpugi216T7zn+aArhlkwVWlfE+qT53bgl
         vBXa4G/O1l9N9ezEYLyntDSVgDly5kitd1/fSiu0jRryxK0AXghdAC6VMND7h2QrXo3G
         5p0VO+rHJ1ux8WQ9mcmlOASlQCMAytGs2blPuZVdp00F2cYAtGGcaarMg/XGIsSaJ9xR
         Bo/g==
X-Forwarded-Encrypted: i=1; AJvYcCUeZHLIagqPoYQp75xRkBwXrGaC3SyOlwRAIsSFY+hGTlY3M4ZyjBpAJBLuMLxzCwMxM+wnJFT5/94I7kAz9tzNQB4=@vger.kernel.org, AJvYcCUl9UxWc0FKaQqdMjc6+jiDSVSslO7fmoK5zZHTf/kbBcMtnjDi0JH4b4ckp6bgmNsS8GL59lMh7Uh6jcd4@vger.kernel.org, AJvYcCUxDu5IIW2NjkjI/v5zIbSsTh/bdDAY7bRrVqsl1nnWDSBbP6p+OlKblq5rrBp35xDoeUKxkzZpJDk=@vger.kernel.org, AJvYcCV5xcc8h8ucfFVcVu+SKfErgMUNUkFe0B4GO4bnzcvBMVIPktBzd1svDUgTfU1Jf4pzuBWV1JfE3Cjo@vger.kernel.org
X-Gm-Message-State: AOJu0YzTntbQ52jJ6aA45eM/A0qdsEoriOxpWR2jwQo04ysCksIdA6Sj
	BP3/XTNOLjIUiRpYAogSRyrn8g151HH77e9yB65y8QIBLahlThLkWo1VU5aNQ4E=
X-Gm-Gg: ASbGncsihfEba/hseEsicg8EPjtj3S+xkTO3dM8Cb5HWyd6kUF2Glug4yBisazdGM89
	kjUicC6y1tuehmbe27Iqq2L1LJnuYxr4dPDX574qWfX/A3hxf5xhL78PzJ0q80aI8yXrEAymhkE
	CPm8X086pmUpJ95eO/FSDQRhsUGqwq0mbnDxKXxsUa3J5LWiPHQlSAqEONs/yQL8dtPOMFEdVIU
	zV/isuV427LhdPJKb9F7MqMB8fgq/S4ZiYfK5RJYoN6+My52TYedCL0S/bquRNRDE/x2mzrWq4/
	KbiyKKA47FIs6fZ6H0PIcZdU+p3MiQmLR7SfT0CcpZIsCSRavK+MGQ==
X-Google-Smtp-Source: AGHT+IF7igENfARG5Qrea2bLos2Hlw9OzVV5f3kV7lr+f8L2LVVQmRxbaB9SoCarIC+cY63gcWg7oA==
X-Received: by 2002:a05:6102:2c81:b0:4be:68fe:e698 with SMTP id ada2fe7eead31-4be68fee7e4mr3311895137.10.1739867033284;
        Tue, 18 Feb 2025 00:23:53 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bc2f7b9b70sm2146050137.7.2025.02.18.00.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:23:53 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8641c7574a5so2005395241.1;
        Tue, 18 Feb 2025 00:23:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU32gfjVsx6S/+ZwNxriVS5iDxKkNZIUuauXS5aO9CYGekaBElHNgPx7wFaPOfnXctLIAQJgDW8Ar2+pglY@vger.kernel.org, AJvYcCX+UlMvdbeTQBq3DcsUw4R+8tsb9PcyJiOIQELXIKI0oYBEyTnmjV2QhxjrCEHCpWXV4kfjICTapeXf@vger.kernel.org, AJvYcCXTKo9pPJ/+214OZogwGv05YZamk0aI3JKTnOH+h4y7D0RSN65T0conemYqrn9gme3O4IH7gfOFkzw=@vger.kernel.org, AJvYcCXicFAJT6dmKgOdDpVSVVAP6ZY1+LwDgsK6DVQAU1pHx8oT9pm49/Yfm3Y+z55TEEmeiCKIlgI4qtnZvFaprCkDOgA=@vger.kernel.org
X-Received: by 2002:a05:6102:290a:b0:4b9:bc52:e050 with SMTP id
 ada2fe7eead31-4bd3fc66f5cmr6915350137.2.1739867032856; Tue, 18 Feb 2025
 00:23:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128145616.2691841-1-claudiu.beznea.uj@bp.renesas.com> <CAMuHMdUQm0Mk3C7YC+kquXP6qR3-uEYbvhzfJJfL2EZeDosz7g@mail.gmail.com>
In-Reply-To: <CAMuHMdUQm0Mk3C7YC+kquXP6qR3-uEYbvhzfJJfL2EZeDosz7g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Feb 2025 09:23:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXrkb4rZr1HZ0p1d1u7+NTcE9J6PVEnhrq9iHVzho1daw@mail.gmail.com>
X-Gm-Features: AWEUYZlot72NkL3g5QnTHdFAtzkllUzfIQa1sn2O9zZYnTzs_wcZEAj0N1LYxAY
Message-ID: <CAMuHMdXrkb4rZr1HZ0p1d1u7+NTcE9J6PVEnhrq9iHVzho1daw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a08g045: Add OPP table
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Feb 2025 at 09:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> CC Energy Model
>
> On Tue, 28 Jan 2025 at 15:56, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Add OPP table for the Renesas RZ/G3S SoC.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> > @@ -28,6 +28,33 @@ audio_clk2: audio2-clk {
> >                 clock-frequency = <0>;
> >         };
> >
> > +       cluster0_opp: opp-table-0 {
> > +               compatible = "operating-points-v2";
> > +               opp-shared;
> > +
> > +               opp-137500000 {
> > +                       opp-hz = /bits/ 64 <137500000>;
> > +                       opp-microvolt = <940000>;
> > +                       clock-latency-ns = <300000>;
> > +               };
> > +               opp-275000000 {
> > +                       opp-hz = /bits/ 64 <275000000>;
> > +                       opp-microvolt = <940000>;
> > +                       clock-latency-ns = <300000>;
> > +               };
> > +               opp-550000000 {
> > +                       opp-hz = /bits/ 64 <550000000>;
> > +                       opp-microvolt = <940000>;
> > +                       clock-latency-ns = <300000>;
> > +               };
> > +               opp-1100000000 {
> > +                       opp-hz = /bits/ 64 <1100000000>;
> > +                       opp-microvolt = <940000>;
> > +                       clock-latency-ns = <300000>;
> > +                       opp-suspend;
> > +               };
>
> So all voltages are the same.  This means the Energy Model (if enabled)
> will always pick the operating point with the highest clock rate, just
> like on R-Car E3 and RZ/G2E.  Apparently that can be fixed by using
> "opp-microwatt" instead, but I am still waiting for feedback about
> some practical points[1] (yes, the Ebisu-4D is still on my desk for
> this reason, and thus unavailable for remote access).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.15.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

