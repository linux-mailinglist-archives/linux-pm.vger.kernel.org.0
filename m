Return-Path: <linux-pm+bounces-2218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A566D82DE14
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 17:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352D4B21990
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F09C17C62;
	Mon, 15 Jan 2024 16:59:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90D18021;
	Mon, 15 Jan 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e54d40cca2so67389197b3.3;
        Mon, 15 Jan 2024 08:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705337964; x=1705942764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTTYbhFYpBwHX0wKOJ+oWprTegK07QidRl5wy0SlVyo=;
        b=BJbZxluJjBUqN9kkK1IHLpzxX6DYgC6f1gBLRc5exNmiSwiQkTFWAVeZEwh7jsBldu
         ekf867Kkaln2E3lWSJngSr3ty2pXBQNgCJi5arFAtV3gvyzRMzgSnNxXYbaTM1Oeognc
         YtpF8O7RjSbviHbEDD0kIb/HL5/56HxrAK7XAQ6JLoe0XVlPQYyQX3GLMfKoZiAkyD7h
         FgQ5s4FliQR/W/GcOV8Mr+OHTybDiGSIMWBv2IOAF/EXS7xIspsyYWds+1zdSyHdn/XD
         s3cLQR1wonaRLqpTbnIyuM+srx3g5LvoEIhEkA/zyGWOjEsL9R2nUwngJc4417BokTBe
         99Xg==
X-Gm-Message-State: AOJu0YzuTE5+nJ10CUEvB22Lk+nBCgDfF4J6HsATqBZiTGQTFEVqv1I/
	amB4C5XfNtVkbDjzx5J4Etb8JKFQgsOCpQ==
X-Google-Smtp-Source: AGHT+IGCFEhjMFTQ73ACCqn+2YxEfktP5HCEJzBnreIVgZ20IWZ/a6LIMr3mWULHOEmHRWnv8e+zvA==
X-Received: by 2002:a81:4cd6:0:b0:5eb:6c37:6b46 with SMTP id z205-20020a814cd6000000b005eb6c376b46mr2678304ywa.22.1705337964399;
        Mon, 15 Jan 2024 08:59:24 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id y68-20020a81a147000000b005fa95a2f418sm4069173ywg.103.2024.01.15.08.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 08:59:24 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso6075709276.2;
        Mon, 15 Jan 2024 08:59:24 -0800 (PST)
X-Received: by 2002:a25:d502:0:b0:dbe:2063:72b9 with SMTP id
 r2-20020a25d502000000b00dbe206372b9mr1905510ybe.50.1705337963803; Mon, 15 Jan
 2024 08:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704726960.git.geert+renesas@glider.be> <ee3e57bafef123194b9779dbf5b9c181dc3b37ed.1704726960.git.geert+renesas@glider.be>
 <CAPDyKFpc1ZsVhFM22zum=54LQ3Tiow7kG0nnt3WD3DBTGY6KFg@mail.gmail.com>
In-Reply-To: <CAPDyKFpc1ZsVhFM22zum=54LQ3Tiow7kG0nnt3WD3DBTGY6KFg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jan 2024 17:59:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0aQR4qki0Yqd0WGPf=hRR4UqWxY0C=ctAnV0oWxbmxw@mail.gmail.com>
Message-ID: <CAMuHMdU0aQR4qki0Yqd0WGPf=hRR4UqWxY0C=ctAnV0oWxbmxw@mail.gmail.com>
Subject: Re: [PATCH 09/15] pmdomain: renesas: r8a779h0-sysc: Add r8a779h0 support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Mon, Jan 15, 2024 at 5:39=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> - trimmed cc-list

CC krzk ;-)

> On Mon, 8 Jan 2024 at 16:34, Geert Uytterhoeven <geert+renesas@glider.be>=
 wrote:
> > From: Duy Nguyen <duy.nguyen.rh@renesas.com>
> >
> > Add support for R-Car V4M (R8A779H0) SoC power areas to the R-Car SYSC
> > driver.
> >
> > Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> To make sure we agree on the merge strategy; should I pick up $subject
> patch, patch3 and patch4 through my pmdomain tree? DT patches, like
> patch3 and patch4, I should share as usual via my immutable "dt"
> branch, so you can pull it into your renesas tree?

Thanks, that would be great!

However, please note that Krzysztof wants me to add a vendor-prefix
to DT binding definition files[1], so there will be a v2.

[1] include/dt-bindings/power/r8a779h0-sysc.h

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

