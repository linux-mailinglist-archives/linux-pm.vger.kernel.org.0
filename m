Return-Path: <linux-pm+bounces-15316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38B9994471
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920E31F2582F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 09:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5E5183CB8;
	Tue,  8 Oct 2024 09:38:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E842A9F;
	Tue,  8 Oct 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380288; cv=none; b=g9jHWxIfnt37Gm0/FOXIYvmUAiurWKkCzzChi/FyXEojPzhzVgaUIg57SCWdqzeIOAcINNwYy+ugIMZ6vaCTjts00NdRRH5EPnsiaE217CBnADFzzRI0cpLjL1OIhMnaScWbxfaf/ZmGxq8dsC+Kh/h5EhpPaZy8aFfHBPT8a/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380288; c=relaxed/simple;
	bh=VDfSHUBnR4JM/dSLLvi2ecdeTE5LK1dl9tRDC+jjD+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hb0zBdQ9fIU2XDeQikXjMzYk1yyGuqflIRHUtP9cF8TAqKZanAq2mw8xtHmD1ngBAcWWWeh/2gG5XRHSR5VcDBBVaRMnVnBgQWfTmQjCUnVYZ5z91dByHzB44m2MYBCl5tOHCZl1rgygWZ4aO+T+A64AM9wQo3y/GMboFiPgQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6db836c6bd7so50729777b3.3;
        Tue, 08 Oct 2024 02:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380285; x=1728985085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amLheK7FGC0Xs86wdxaUhSr4nQtNCziEIoueb643aqc=;
        b=BLAHLjt+gFF5vDZI6D6bfXF1GnhueCjYmJmeik/G2yzNpoTSzNXUB1wmgggbGjWdFV
         Yak+ly5JKQgPSHlgAGc6YJJIbLtdLQTbdDTQGrNSk0l+oLns9xfo1Dd9AD3S0mC69cDx
         D6Ugk3cZ+FweegO47F2lBV/JgzHixScqXsns2laXNyukzPXrF6gQT0LZozkGHA7uEXun
         gn2NmaeaiI+OOZvCQbzgSHgy/XPYOiATCqq92cLjWJFPv/DIarpU4UUJU+RF8BrOwwky
         /LY4Gk7wx/F/tkeusMtid53XijkcxB7e6/HOkFwm4RosK/J3UdLQVp03qoi9DseLHVw9
         ZC0A==
X-Forwarded-Encrypted: i=1; AJvYcCWuLLxKOkD9ceyjzvdPZVVoDvfzzwoSOkc0yi/3e86u55z6Kn1kOAr0MtPc0jdN9cm8SFcHc2Wb4C0RFWmdsuaAS2c=@vger.kernel.org, AJvYcCXKuapoTgObCD5kd8BLJxT51u9X83Tc4DP93j6vdi9zgtsdjN0PM/udb8fvuW9hmuD/AC7M6VfePKM=@vger.kernel.org, AJvYcCXj+YUuu5hiFFzPgknMXb38io2WG1TEYIZssY/umxlzrfyoHsKZeAGmzHSpgE3eCE85QQVKjcrtGSK2@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbhgUPK93TcKviyXt/cIFUNagxfftruaNDRFFWpTKUGlaln+9
	G6yGv7+EOR8Defzge2ssP1N5So/t5uPtteSR47UCpM2N9R2i47uhzXPN+FtR
X-Google-Smtp-Source: AGHT+IFHHwU11wIPKGAWdpJmn2TN8RmZeVtoydI0Cb2R2NGasKfAv+IBiuRry314o28LpXaLZXBJDQ==
X-Received: by 2002:a05:690c:2510:b0:6e3:fb4:9333 with SMTP id 00721157ae682-6e30fb49398mr11738227b3.28.1728380285454;
        Tue, 08 Oct 2024 02:38:05 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d927f546sm13683537b3.40.2024.10.08.02.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 02:38:05 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e305c2987bso14870817b3.0;
        Tue, 08 Oct 2024 02:38:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdC22imHNac1D885N+c+c5Yg1B5s4duPFILAQfAwCGf3zVMm1ewy2o49jkirv51wG9vR64tmBdM6s92adotGLgj5s=@vger.kernel.org, AJvYcCVL+qObIGmrOOBHSk4NO3WaOG/PVI56TnP0etaDYWgR/0Wg7jiZuNTA3cEBekxVORIXBhaSs0WQOj6m@vger.kernel.org, AJvYcCVmXZxDl0C2xoXlI+UDJ9suqwoARljvkW+aNp7EEXLo563ojCCdzTmHa6M6Af3IFF/BIU7SgkuqB5U=@vger.kernel.org
X-Received: by 2002:a05:690c:eca:b0:6e2:ad08:4914 with SMTP id
 00721157ae682-6e2c6fc3638mr135606787b3.9.1728380284911; Tue, 08 Oct 2024
 02:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728377971.git.geert+renesas@glider.be> <TY3PR01MB113460E688CC3689D94C85F6E867E2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113460E688CC3689D94C85F6E867E2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 11:37:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVyRcjzaxTB=LqPFtt3Jn5Afrkpp67a5HWThPEXNy47A@mail.gmail.com>
Message-ID: <CAMuHMdUVyRcjzaxTB=LqPFtt3Jn5Afrkpp67a5HWThPEXNy47A@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP tables
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Tue, Oct 8, 2024 at 11:30=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > Subject: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP ta=
bles
> >
> > When CONFIG_ENERGY_MODEL=3Dy, an error is printed on RZ/G2E and R-Car E=
3:
> >
> >     cpu cpu0: EM: invalid perf. state: -22
> >
> > This happens because the Operating Points Parameters tables do not list=
 voltages, as they are all
> > identical.  Previously, it was assumed they were optional, and unused, =
when none of the CPU nodes is
> > tied to a regulator using the "cpu-supply" property.  This assumption t=
urned out to be incorrect,
> > causing the reported error message.
> >
> > This RFC patch series fixes this by adding the missing voltages.
> >
> > Note that the Energy Model calculates energy efficiency by dividing the
> > (estimated) CPU power consumption by CPU core clock frequency.  When al=
l voltages have the same value,
> > the former is proportional to clock frequency, and energy efficiency be=
comes a constant.  Hence all
> > operating points are considered to have the same efficiency, and the En=
ergy Model always picks the one
> > with the highest clock rate (see also [1]).
> >
> > Alternatively, the Energy Model could be changed to silently ignore OPP=
 tables with missing
> > frequencies.  IMHO this is not an unusual case.
>
> I guess cooling uses OPP table for frequency down scaling at higher temp.=
 So, we need
> OPP tables for thermal governors??

Yes, you still need OPP tables for thermal governance.
But the Energy Model cannot really use it when the voltages are identical.

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

