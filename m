Return-Path: <linux-pm+bounces-3898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C7854419
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 09:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FD11C26CC3
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA3864D;
	Wed, 14 Feb 2024 08:35:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6F1FB4;
	Wed, 14 Feb 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899757; cv=none; b=UbFnK8Vi0f5jWtlJEbkEr9DfffSkwpZn4u3oiGmjmb6CA+0j8SHwx6aEvKdiof+f2f2xv2ioGzljcrxu+mhdmrnLOhLr3wZoGBSdC2jmCqyz83CWROp+EAp7T0p0Dm0gvodY5t6TRwUll9Dov9l2z/XZvir96ykV4MzRnjSc8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899757; c=relaxed/simple;
	bh=G80kAQT7MwVwK+q1TP/+PTGwSsJM0oWNxYt1TUSDTHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oF/tTNCVkuinR2elC5/4Ia3A9XIOWXf9w2sIDsePWYG00FGIq4+PZnJQSL3tcmqNUq0ZPBo6arl2LShG74t+ChvI+mWRShkHoGfaP/NjdrE7TIKgB7xemV2HcTCw8qCZULnGriN8LKJWtzu38Y71Y+mfBEFzFQZ2IjAR36IIHP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6002317a427so47028387b3.2;
        Wed, 14 Feb 2024 00:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707899752; x=1708504552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhJlZCcRgqTba1suffIYy/S2Gadkij2N+hd17VddZnM=;
        b=jJsXIHH49ymdhbGiJixJ1GSrgia1NrYlyFYPK9YnoFrhsKCJugbGNHQ3Ql3iXmld+S
         ngRbnr4tsfF6C4uUVrdIZFu3Ca5r7i3RmK6sYYXpBbsggDp/0QiUIYF2V5sIyOBBizzo
         otgOsDuR/ZDJjl5C7H2QA3heL0i5k0YjkkkphbmAsUi3kTRXS6r1ntGWbKV5Pn3vCUWL
         zqM8GCuyN1X4olwQogNCxH3HTckv++deQqSppuXOotvo2eHzgsdLd1qmWwlK8QhbckcD
         xp19ANDgL7vycqVnnBT2vPfBkQprOzzk6CB092rpIU0qDKUUVoWZS5kfgOB5L5QZvJvn
         bqew==
X-Forwarded-Encrypted: i=1; AJvYcCUzyaCqxu5lUt17dZpJCUa9VkbcB/gdvOQncj89xLJwmha6S8pS5v4Lx8XCtGnBebzAUqIpWSHUu7gRnDVPgzT9luxjKNIDJIXSy9avPwbBEv8QgGaygvL+aW2GNc4gULufQ9CWoeSzHsFzolxKB1N5gZ1yaikBsDqwnvVLdW80aobXcL0tfIzHeU/PCWGdWpt5vPTwrkHDxErSELj+AI4ym74=
X-Gm-Message-State: AOJu0Yyg34SrO+qm85Ro3xhFkxJgcd27pLXqne+y0o0IquabArU+4v/s
	IyR5gYhQIB4yBqbQBhhcMWhzIlibZw9/tOvoaM3LwfDm1Z+4V8wKo/zO07RtPIo=
X-Google-Smtp-Source: AGHT+IH7w6QLIfgNrszxlKE78XNWCSjjYGNraAZ+ea8wcrBoeplhrbDLb1PeWFSNcChTQ9MtT6UNyQ==
X-Received: by 2002:a81:84c9:0:b0:604:b08c:348d with SMTP id u192-20020a8184c9000000b00604b08c348dmr1615046ywf.1.1707899752108;
        Wed, 14 Feb 2024 00:35:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3kB/B5WZaBOwFU458Gbikm7YLFToDCMZIMHGgWLNsYimJ2f7WNBDN7+QBURGuTfpBmRxmZn2Zimovo5ZG/7tI4vByX0m3jJ8oP7M2OBERHad12czrvX2DOBLkCRrHqaX1eyTYDSDCp9je9LhimRIAfQ3ONgzN1Cpml6Aeaoy7WWg+4iglDTG2OGKT/SMctbwacGPoAgVAwnXyoD6Ss3sfb3g=
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id b81-20020a0dd954000000b006078ad0243csm689386ywe.59.2024.02.14.00.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 00:35:51 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so1484144276.0;
        Wed, 14 Feb 2024 00:35:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqaqHeHdPWCke88qqVKNUCTowy6wOKw/w0Pk0Bsd4JbzaUNGvC5rtcqvpCVJImgluMjXM6TS+bEEgjgAf9hty/YhFGjly7qP19Fw0ajUq3zfsErADyyyvaSCOZUHM7+XCBm+iZ/flNlTQa/VMLhFHKxwvgKAPiHa3fka3XhMv2rIY96bax4SPzciAFnE+lhmMU1Cz4NY4KlKP3GbFTdNWl/mo=
X-Received: by 2002:a25:c7c9:0:b0:dc6:ff12:1a21 with SMTP id
 w192-20020a25c7c9000000b00dc6ff121a21mr1674869ybe.31.1707899751143; Wed, 14
 Feb 2024 00:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706194617.git.geert+renesas@glider.be> <CAPDyKFpxaEUHvKKb+spxV6HG2P2gLx5qM1mLPxJie+PdkmTL4w@mail.gmail.com>
 <CAMuHMdUswhJ3BQLnOQZC7X7qc7SFCqsr9Uy65LfBT_BNWfyhFQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUswhJ3BQLnOQZC7X7qc7SFCqsr9Uy65LfBT_BNWfyhFQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 09:35:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX1tjgPJ8t+XoASuMvzvSognu7q2=aGfBO8r77JsbR82w@mail.gmail.com>
Message-ID: <CAMuHMdX1tjgPJ8t+XoASuMvzvSognu7q2=aGfBO8r77JsbR82w@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] arm64: renesas: Add R-Car V4M and Gray Hawk
 Single support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Magnus Damm <magnus.damm@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Cong Dang <cong.dang.xn@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	Hai Pham <hai.pham.ud@renesas.com>, Linh Phung <linh.phung.jy@renesas.com>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Wed, Jan 31, 2024 at 3:56=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Jan 30, 2024 at 2:11=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > On Thu, 25 Jan 2024 at 16:34, Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > This patch series adds initial support for the Renesas R-Car V4M
> > > (R8A779G0) SoC and the Renesas Gray Hawk Single development board.
> > >
> > > As both driver code and DTS have hard dependencies on DT binding
> > > definitions, most patches in this series are supposed to go in throug=
h
> > > the renesas-devel and/or renesas-clk trees, using a shared branch for=
 DT
> > > binding definitions, as usual.  For the PM domain patches (03, 04, 09=
),
> > > Ulf already offered to apply these to his pmdomain tree, and provide =
an
> > > immutable "dt" branch, to be pulled in my renesas-devel tree.
> >
> > Patch 3,4 and 9 (I dropped the copyright line in patch9, as pointed
> > out by Niklas) applied for next, thanks!
> >
> > Patch 3,4 are also available at the immutable dt branch for you to pull=
 in.
>
> Thank you!
>
> I have pulled the immutable branch, added the remaining DT binding
> definitions, and queued all remaining patches.

It looks like you have applied copies of all commits on the "dt"
branch to the "next"
branch, so now there are two copies?

See the output of "git range-diff v6.8-rc1..pmdomain/dt
v6.8-rc4..pmdomain/next".

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

