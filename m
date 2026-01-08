Return-Path: <linux-pm+bounces-40496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F2D056E8
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 19:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7194D3017C7F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B120B30E856;
	Thu,  8 Jan 2026 18:16:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1146930C624
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896189; cv=none; b=a35uS8g/eO0aea9Bamq3Pyk+0yrLvoA9JAZVYfM1KjdnvBHaB9h3geM/kbTIbl7VOuCHGlIauLRsdMHpmprDptZ58Yei7fHsKTNMWdk2Y8n0XeFWv93oMPLEpCRgmzVjGYshiiOr1N+llhmdY7vH8sb24TXIVXaWV13HUxJJFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896189; c=relaxed/simple;
	bh=K6Z6o40ihTPpiR+Kr8j0TVVtfNVmsUN/rw5oBiuRevE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmwdouGSIX+Xw87JDIRp8ssrKp52jW2f6cUu3uQJf9RyV4a1o1z9mt6zHMkQevR6WX+tgeXvbAKepOTShU1LiBD2lZkR8EsB3q6thedY7e6LwLjl+TXSfKgj0hM2E1VASOl6HD9O4gdayzxGNJBW5bP2hGAHnKwVZaRFjUaz1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5eea31b5cb7so232332137.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 10:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767896183; x=1768500983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt3wBCEAoEDXtzh+lfzJmSPYLZ4A0fGF3pcV2qxjAOs=;
        b=sVDTXnMtslFrlJ8NGS/gzMnPakFuVKfhIg383wRJkWEZgBY3uoDkKvjP+KzA1IsbLS
         eTR3fx4Vl/APdB3uO9GDIjRma5ycAtHafRRRDN2tn9PTiyxTsLZx+c6VXHSvjePOlP/J
         1YNm1v+VX6xFQWSCmaP5weorEYcQDZNE3snv7By46DDXx2+kxdCzycXUALa9wRL7vvpv
         I49Qc+Pc3IjpqykN7PPs36YWPszczQ2qOX9jdx2VV3FolKM4QLgOF3wscECXfiLgd+n1
         PgjjPoQYbs8DrFdEoFasP/hemW3vrj2Q41q3H451eUczrAtmNTE9JcPldF3YErSAck2A
         upaA==
X-Forwarded-Encrypted: i=1; AJvYcCVksH2Id4eWgoM/zunNvxXD9w1lDBArlBjOCKhd0Jm14KmuE8diTzngolBaPhJTLIHUmUDjjPlTOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNlWuAww8cW3pR/Pq80FZ13Y18YeOO2QIniwqh+pflgoN/XFQ
	FC2HP1Njb7XL3ddHIH78Xr5pkVAigVJTlx9VMLPuFesR971fAMtg7t0X2F8ql9vq
X-Gm-Gg: AY/fxX6KYV7SjCWa+x4vAvv02K3NHu0I7jfGur56LC9IMs991/a5xHXdgt+6+7U8nSD
	K6cdh73PtgN3jwzIl/zAO7wBvHHDlId6I2/VVbpxa74M+3de+DExj0I7Tkih8P2bsEfglftVKb6
	op2IDPRd5WZRqQT8LwZpE+JkyPifIfNZIus8gx47ShXbdo1aoCRrAIgJUDlkC6H9A4bhc2d1muM
	T9cBVKla3DesYmSumraCKqwot73Sr5upoXZSNkw6UKazFpUjzm0dLNzegWI2xul5cP09SRI9khh
	S0ZS7WBL+UNRRxiMabwdV5ZnNZgz3B07b2+dxy8m6zh9fMhSENNLKL0eOKfafOr0reFmMR2JijO
	mKzUtojpf2/mgHv2xhv7pVCkM9PMnoplF8ZBJJhOgRbicTniuWXq0Kmiqg/sU0pgGTRPe96SNvJ
	SidhFBQqrHoq2VpDU9c1A55BCOLc592hxTpxIul4xdhzkOZbZ6sr+oxPfBRVw=
X-Google-Smtp-Source: AGHT+IE8+cbjCB6cmaW8Qkmm3ewqB7v7Ur5//s9ZsylZwGlqlw1RjdmNE9rbdShLB/DHY4VQKZ4+0w==
X-Received: by 2002:a05:6102:6f0a:b0:5ed:8e3:b674 with SMTP id ada2fe7eead31-5ed08e3bdbbmr2198710137.20.1767896183127;
        Thu, 08 Jan 2026 10:16:23 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944122d3040sm6560626241.4.2026.01.08.10.16.22
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 10:16:22 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93f5905e698so1038130241.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 10:16:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4EBFHziqSUjLuQdEUnb812tfkw1k0v3mIpEy8MBSHbrRxDSH+KfdTGT3gDYrBSYf8kfGjs1tF6Q==@vger.kernel.org
X-Received: by 2002:a05:6102:3908:b0:5ee:a6f8:f925 with SMTP id
 ada2fe7eead31-5eea6f90e16mr713176137.8.1767896182056; Thu, 08 Jan 2026
 10:16:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108165324.11376-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260108165324.11376-6-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdX0G92JmwneZp1h+AOF-Cit2scVGGWXCBZGwBVmJjUAVg@mail.gmail.com> <TYRPR01MB15619ECA5180E6F630798DDEE8585A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
In-Reply-To: <TYRPR01MB15619ECA5180E6F630798DDEE8585A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 19:16:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUs33Y25xV2ML2hMfi=9oZF_qunf+iBytWoCVK6wB9eXw@mail.gmail.com>
X-Gm-Features: AZwV_QhXsBpAEocXJbizxDMe17TBY897URMAJavkibcXrlE9she2ISf152UrKmI
Message-ID: <CAMuHMdUs33Y25xV2ML2hMfi=9oZF_qunf+iBytWoCVK6wB9eXw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "magnus.damm" <magnus.damm@gmail.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Thu, 8 Jan 2026 at 19:08, Cosmin-Gabriel Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Thu, 8 Jan 2026 at 17:55, Cosmin Tanislav
> > <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
> > > temperature calibration via SMC SIP and do not have a reset for the
> > > TSU peripheral, and use different minimum and maximum temperature values
> > > compared to the already supported RZ/G3E.
> > >
> > > Although the calibration data is stored in an OTP memory, the OTP itself
> > > is not memory-mapped, access to it is done through an OTP controller.
> > >
> > > The OTP controller is only accessible from the secure world,
> > > but the temperature calibration data stored in the OTP is exposed via
> > > SMC.
> > >
> > > Add support for retrieving the calibration data using arm_smcc_smc().
> > >
> > > Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
> > >
> > > Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

> > > --- a/drivers/thermal/renesas/rzg3e_thermal.c
> > > +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> >
> > > @@ -362,6 +366,21 @@ static int rzg3e_thermal_get_syscon_trim(struct rzg3e_thermal_priv *priv)
> > >         return 0;
> > >  }
> > >
> > > +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv *priv)
> > > +{
> > > +       struct arm_smccc_res local_res;
> >
> > Missing #include <linux/arm-smccc.h> (on e.g. arm and riscv).
>
> Ack.
>
> > > +
> > > +       arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> > > +                     0, 0, 0, 0, 0, 0, &local_res);
> >
> > Can this crash? E.g. if this SMC call is not supported by the firmware?
> >
>
> Default TF-A firmware for RZ/N2H was missing this exact SMC call as it
> was on an older version. All it did was return SMC_UNK, which is -1.
> I checked the code and SMC_UNK is returned in all failure cases.
> So, no crash. And -1 is caught by the 0xFFF check.

OK.

> Oh, maybe I should change the 0xFFF check (the one I just moved into
> rzg3e_thermal_probe()) to use the TSU_CODE_MAX macro too? I just
> noticed it.

Yeah, sounds good.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

