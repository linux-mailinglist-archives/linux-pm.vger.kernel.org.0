Return-Path: <linux-pm+bounces-38985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E99C982A5
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 17:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC04E13B6
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536112F60D8;
	Mon,  1 Dec 2025 16:04:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F270284889
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764605082; cv=none; b=UavSZGVwF8Y917jlHap+xPGhdckUioYJb5Im5//ScKWEoh4x+ybC6y5UodwJ21RZO9Xak1Kv85OKcI0qjCwedSaA+w6aOsfajTbxv/M26uQocXVlw8X5Rfz5ru/FXHNrPiWMNwctmUF2GjmMNKgJ0VAmmU1rEWSfq2PoL0SCeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764605082; c=relaxed/simple;
	bh=qr4cn87Fz/lj/NJPX9SO15DI5zruqL8p9qauqxw6SZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R99HVNv8Ku2L5MBIULquCgfD3Dgyjhc2zdQtw7DUkmhaMEelC91C6AnzZ+rl/PnF9Jb8cQbhyDvFcG0IGDCtN3/LC9HxNs20ai/BCaDqAwFmfJ3w7wuRaBd6eXtSBTyRYS7nnXn9fRysC4ivkv35BWFUC2oVFeZOT7V+Rhs6z7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78a7af9ff1dso40749807b3.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 08:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764605079; x=1765209879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/iRHv+BjA8MLgniIITmScghWKuz/LFnH9jJv/CINxso=;
        b=Y6tM405zxE9KQUOXQqy2GwnHMGTeKwm2YP9HO8373GdAfkTLtHnajksWj4UIBsM3bF
         +WZUiC7IKhZYb1JEiOz8ZKepvx2I9OKJRj8fABKIWC1/ICYkTKq58ofV0KLLrM27Gtnr
         YlaO8dBhtCJShpkvjEIFomq3Toj9S6M3bl3JC2d3u5Aoc8UOrjjYg68EouQzjiiDvtTl
         9i6fRtYFYf7Ocm5yg+jybw8iPxXUTys3TvT1P1c86Xhz8OkqEGnXO2huYx7SUBJSILe6
         WeTFTnG3p9/bzQ9ZecjHJzNmiPzdypuEDQ75WDj8BO+H6muZiqYIUOpjRwFPu2r2JhA+
         7Eqw==
X-Forwarded-Encrypted: i=1; AJvYcCW57gZwDLelJyxPthAF/tQLqW8W9qAU+A3ehKpCN2CTFGPYxz57gglTcbjlG97J/H4z92LLT3aFdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6I7YIBFcAGOK6qhGUG/WSpPZSEAsRBNpfjEBtuNUepvoQcCAM
	f79/+KGA78dvxOOzZrtxSd802jDaF4sKoLcYHuCfh9d+rOlYh4sCFArWuCJoI7lc
X-Gm-Gg: ASbGnctnvgk5iI9cdbvNfKSdIaQSqwrgZgjGjF1wSTND2RuEAav4Mrs7xb4ZOTVKeNR
	1Yvd5TW2X96ap8cu59OgXmj3MyRVF87EY1cf2b38twFV6LOmF8WxJFiUQXrQsJ48A7acQsgU2hW
	wfyRvJE4Pf0Um6KTvsW2uF+qyrfCKxOk59xe3T72cVC4H9DSYVkbmU5DA8VcKGYUF5PaneGZWWN
	UnqDqvPj8AU0PShXP1CaThJrBprPJnZ12TBi/1msfgstgsO0Kff97pjbug5vJiA6n/3WjCmXcRa
	mWdrjsOM/KWM0R5QR+Rkmo0BmGAmMG+ZiNslFAhBdfc+m1u+QR7KaLK+1p7weR4GkZ4LOwqjdDx
	FWBtHbaV7dg9v0UKjBhq5U8Z8m97GKe85kgkKLIAZhPwFXwXTgXZZ0I8N8QzR3kNN8x/VuaTUt2
	cYkBqvwDbPoKtEDAlV582Qgt4hCz+xipMEYimEsdWk9l32R5KSIW6F
X-Google-Smtp-Source: AGHT+IG5FHloBAL9ywBH1OEsZOrroULr9vN1E0X6NC35zTAaMnQ6fowufnyv5EEWoflyldg12kIyIg==
X-Received: by 2002:a53:d049:0:10b0:63f:af79:e4d7 with SMTP id 956f58d0204a3-64302a62257mr22054890d50.9.1764605078928;
        Mon, 01 Dec 2025 08:04:38 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad1011de6sm50847197b3.34.2025.12.01.08.04.38
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 08:04:38 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-787e84ceaf7so40686897b3.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 08:04:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKH/tPYEuo7ZQtw23KY9eBqXG5wDWTPI6KzCBhX079KBUrxdGOyCCAjTknh0zI4EXbndn5QA7ehw==@vger.kernel.org
X-Received: by 2002:a05:690c:88f:b0:786:5712:46c0 with SMTP id
 00721157ae682-78a8b4719bcmr328332247b3.17.1764605077800; Mon, 01 Dec 2025
 08:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-7-biju.das.jz@bp.renesas.com> <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
 <TY3PR01MB1134692D7D9F5B67116D2BC7786DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <pilx2etxezmr6rhbwculwjqcxotzkxus5bqdpjrt5na5c7fqhj@mdfm2yh2aptp>
 <TY3PR01MB11346DE28875EFD9B9D86DE5186DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113464F283A3ED4A8AAC813D886DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ydqyvme43ul6ui7bl37kv3kuhn7js7tvkje2u4a3vasiw4kgdv@w2govkhaa3xz> <TY3PR01MB11346F105FD6CCE1167F9095686DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346F105FD6CCE1167F9095686DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Dec 2025 17:04:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWCGFWfvRDi3HWvrZWzgum8dFFf5cUVKjpjMy8mybh1Uw@mail.gmail.com>
X-Gm-Features: AWmQ_bndbNr1Oz4wHbRg3QVNBImgi5ShCGh8UUwh_sLrY_x12jOdQyzxqyweK_I
Message-ID: <CAMuHMdWCGFWfvRDi3HWvrZWzgum8dFFf5cUVKjpjMy8mybh1Uw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"biju.das.au" <biju.das.au@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Mon, 1 Dec 2025 at 16:50, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> > On Mon, Dec 01, 2025 at 03:04:08PM +0000, Biju Das wrote:
> > > You mean to avoid unbalance between suspend()/resume(), we should not
> > > do error handling in resume()??
> >
> > Consider the following resume function:
> >
> >       static int myresume(...)
> >       {
> >               ret =3D enable_some_resource(...);
> >               if (ret)
> >                       return ret;
> >
> >               ret =3D enable_some_other_resource(...)
> >               if (ret) {
> >                       disable_some_resource();
> >                       return ret;
> >
> >               }
> >
> >               return 0;
> >       }
> >
> > If disable_some_resource() can fail it might happen that the first call=
 to myresume() is left with
> > some_resource enabled and some_other_resource disabled (i.e. if both en=
able_some_other_resource() and
> > disable_some_resource() fail). Now if the resume is retried some_resour=
ce is enabled a second time
> > without being tracked and a later suspend (or remove) won't bring the e=
nable count to 0 and thus leak
> > a resource.
>
> OK, what about for making balanced usage count for suspend()/resume() to =
avoid resource
> like below
>
> static int myresume(...)
> {
>         ret =3D enable_some_resource(...);
>         ret |=3D enable_some_other_resource(...);
>
>         return ret;
> }
>
> static int mysuspend(...)
> {
>         disable_some_resource(...);
>         disable_some_other_resource(...)

What do you do when one of the disabling fails? See also
https://lore.kernel.org/CAMuHMdWDGpqdhCsA0MJqoL1JAiyVR-TA2YqDe+-S9Xf6c5O-gA=
@mail.gmail.com

>         return 0;

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

