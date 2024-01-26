Return-Path: <linux-pm+bounces-2795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AD883D5BF
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 10:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A75EB27164
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F976DCF6;
	Fri, 26 Jan 2024 08:13:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD76D1A8;
	Fri, 26 Jan 2024 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256801; cv=none; b=FO24g7rnSGZ0/hK74YNzuqLG4WZRA8asZcD/cfoMW+MiLdgKG8jF9dXhqb6STRcdWCIh0KPhwt3NjKmUNkxAgKDWjmfnZUZRY5fea/cL+WDTFjOOjfzsJUmEVcj7QYusM8XONjTBRi/w0KrQkBQf+YGRpqmHVQ0P1OFO0F6DNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256801; c=relaxed/simple;
	bh=weH33ky7oNm3EiJ3aEacbbdeg0oNvXbtDaN1/TiAS3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQ2Tw+JzdL7xLFSD8sAFY3mTGObKH0qKvKNesj5qQ3OQyTzC98jkCndzfZINFXjM6BWvkTAymWthr3Eyg5OQz7DxYhbkf/yHGP9xmlfZISbm4F0cTJIusEDGWkUmFbFZ+pX5qC2NXy2SUpk7k1iOgKegEVksxGLB2+ivczyUb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-602cf7dfeb1so1005567b3.0;
        Fri, 26 Jan 2024 00:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256798; x=1706861598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QB6xsdYCRXR/22GDHbqNHIS69HRzW17anUq6GjF6Pw=;
        b=Q1EwLQCZG+xzSYkzIp7oPz8fwgG7LYxPU7qFoBX9adZVs1r0PmqkqPwz9u6yZK53iH
         B88Gbc1oMUV5o2EaYA4+/XTDx+echv/elIH7hdB3ctj1Uxx1TJTwjVixqkborctAdfD+
         NAa+8cQFcF+s4KfpFAkLCmKirFLiE4UfznDf/zbgBUUeFlc3spIEISDdQikCzccCyt4Y
         oQT+6mhPYMVF2FusHTkgKr6sQqIv7+LjWQHvM7smqB4210ZKonuv4AW12Ncbif6HGbJF
         G3bMiMObE7JXKa4UoKWER5kDl5AnY32ChCCxpit90w8ITuPqmBB2GbTFTJhhLHGYeMwK
         vCeQ==
X-Gm-Message-State: AOJu0YytcwvQ4Qa5JpmMdwOwB+q4MkVg9c3XZZcIvciHmeo2QIe/Tv5R
	K9DXD+N5Egtxp4j00WLHUHAgb0ez9pBPq9X9sV2239Nk1+ZQiZ+Ds4BMMtvOxj8=
X-Google-Smtp-Source: AGHT+IHKaJLdjj9r7u/sJwswtl4eZOWoFKnImF7c4zcTQAewRfjU7c4ipSYXiUnGTRyh5TXG5Py26A==
X-Received: by 2002:a0d:d489:0:b0:5ff:529c:504d with SMTP id w131-20020a0dd489000000b005ff529c504dmr1021098ywd.79.1706256798157;
        Fri, 26 Jan 2024 00:13:18 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y192-20020a81a1c9000000b00602ab11425csm228055ywg.81.2024.01.26.00.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 00:13:17 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5ff7a8b5e61so1065777b3.2;
        Fri, 26 Jan 2024 00:13:17 -0800 (PST)
X-Received: by 2002:a0d:ea82:0:b0:5ff:30d2:a63c with SMTP id
 t124-20020a0dea82000000b005ff30d2a63cmr960276ywe.14.1706256796983; Fri, 26
 Jan 2024 00:13:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706194617.git.geert+renesas@glider.be> <eed6faa02c628d32676ab8ea0eee636b4ffd6c47.1706194617.git.geert+renesas@glider.be>
 <20240125184650.GO4126432@ragnatech.se>
In-Reply-To: <20240125184650.GO4126432@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2024 09:13:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBPdiSqgkZOs2nddvk_xEVe3m7sZ51XC20Optcp+pVLg@mail.gmail.com>
Message-ID: <CAMuHMdUBPdiSqgkZOs2nddvk_xEVe3m7sZ51XC20Optcp+pVLg@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] pmdomain: renesas: r8a779h0-sysc: Add r8a779h0 support
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Magnus Damm <magnus.damm@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Cong Dang <cong.dang.xn@renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>, 
	Linh Phung <linh.phung.jy@renesas.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Thu, Jan 25, 2024 at 7:46=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2024-01-25 16:34:37 +0100, Geert Uytterhoeven wrote:
> > From: Duy Nguyen <duy.nguyen.rh@renesas.com>
> >
> > Add support for R-Car V4M (R8A779H0) SoC power areas to the R-Car SYSC
> > driver.
> >
> > Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v2:
> >   - Add vendor-prefix to DT binding definition header file.

> > --- /dev/null
> > +++ b/drivers/pmdomain/renesas/r8a779h0-sysc.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas R-Car V4M System Controller
> > + *
> > + * Copyright (C) 2016-2017 Glider bvba
>
> Is 2016-2017 correct? With or without that fixed,

That must have been copied from r8a7795-sysc.c...
As the layout of R-Car V4M is completely different from R-Car H3,
I will drop that line (with or without reposting).

> Acked-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>

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

