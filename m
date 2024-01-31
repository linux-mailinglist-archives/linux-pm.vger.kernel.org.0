Return-Path: <linux-pm+bounces-3087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E2484427D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 16:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C188D1F21C3A
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F0112FF68;
	Wed, 31 Jan 2024 14:56:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1954912F5BF;
	Wed, 31 Jan 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713011; cv=none; b=eQGFATUEBs4Vj1rjPyi3O0zg46rD5npeEl+hWxCJO5wtvVxAU0za1FZeWob7oqaBJAenv+w/LR9J15rtVNkHkNzIRh18q8gU9S34PUiheMB6NgEkLMb3yqFMBMo1l1F8LiToNr8tW2D69Nu3z4JfVLxA8wytbnW9vO4s6wNOq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713011; c=relaxed/simple;
	bh=5xXgKjjwswzHov9slieCEtQPAKF5OMnVbk7lR2026l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxDUobZHf97MXQf6yDw8jBGJF7VeKSzmsdBmoAXekdwVsF5pYKogCsT8Lo62LWV+G62zbpHBoioatz7hkjgdyZ/OWf+9Jo5ZbARuTguT801R+BGdb/JMo5segolLKowWluiyxnxuMORtBDW4cCd/cgded/rHlofIAc5URJFfpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-603c5d7997aso39584357b3.1;
        Wed, 31 Jan 2024 06:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706713005; x=1707317805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpKdMjyzizQdBL1+BwnYNIUR7N8c1tbrrD6RLX3dXvU=;
        b=dTbeBBeeSyuj0o+K5IKfgLJ3jr6a5C4RuLdAlvFGO1gbqwel4ru2YxOJoqnbQ8DogQ
         2cabcUh+FdJInED/bOK4JgMSaEf9ILIa5srFM2u0jPHs9eXERcyovRWdDbof5eWkt7EI
         eLHKt9tOjpt/3G52CHFJuGaDMImVh0nOcjnO8QhMnWJ/iZ6hkAUP5YEhX8hPqJoMP4mJ
         cCecXlfyz1UBpzLgTpF5bEtwlFZZkj2hIpASy9493CWl4trCFi3xqeJ8YXAt9TUt7iFz
         wUbmSIrg5jlqZFuDHVjGioqX3ASp+4Rzdn3L1j0lbMd1+hVV9E0z/FYrJGd6gvBGpZ/M
         h+Dg==
X-Gm-Message-State: AOJu0Ywlo2H8NR4+kXLrF+vxmjqd6/vNaeBiPo/IQKXp0uPqBPioQM+h
	EqdUC/1MhQSk+oMNrq3uFscVtj0nZbw8OJ1XjBRJ3nX5hePOHU/0oWl58Qc6++Y=
X-Google-Smtp-Source: AGHT+IF/TambxL5fDs1immlNAVTHs6ZR7UaqSfVfLrHF3n/t9eHtvP6U2XD2JpvU0LExSshj+3SBjw==
X-Received: by 2002:a0d:d715:0:b0:5e9:fa4a:fd56 with SMTP id z21-20020a0dd715000000b005e9fa4afd56mr1613182ywd.13.1706713004775;
        Wed, 31 Jan 2024 06:56:44 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id cb8-20020a05690c090800b005ff3fdb8bf8sm3817435ywb.2.2024.01.31.06.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:56:43 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc61fd6ba8cso3949096276.3;
        Wed, 31 Jan 2024 06:56:43 -0800 (PST)
X-Received: by 2002:a25:8243:0:b0:dc2:3427:f0f3 with SMTP id
 d3-20020a258243000000b00dc23427f0f3mr1822274ybn.35.1706713003619; Wed, 31 Jan
 2024 06:56:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706194617.git.geert+renesas@glider.be> <CAPDyKFpxaEUHvKKb+spxV6HG2P2gLx5qM1mLPxJie+PdkmTL4w@mail.gmail.com>
In-Reply-To: <CAPDyKFpxaEUHvKKb+spxV6HG2P2gLx5qM1mLPxJie+PdkmTL4w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 31 Jan 2024 15:56:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUswhJ3BQLnOQZC7X7qc7SFCqsr9Uy65LfBT_BNWfyhFQ@mail.gmail.com>
Message-ID: <CAMuHMdUswhJ3BQLnOQZC7X7qc7SFCqsr9Uy65LfBT_BNWfyhFQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] arm64: renesas: Add R-Car V4M and Gray Hawk
 Single support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
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

On Tue, Jan 30, 2024 at 2:11=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> On Thu, 25 Jan 2024 at 16:34, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > This patch series adds initial support for the Renesas R-Car V4M
> > (R8A779G0) SoC and the Renesas Gray Hawk Single development board.
> >
> > As both driver code and DTS have hard dependencies on DT binding
> > definitions, most patches in this series are supposed to go in through
> > the renesas-devel and/or renesas-clk trees, using a shared branch for D=
T
> > binding definitions, as usual.  For the PM domain patches (03, 04, 09),
> > Ulf already offered to apply these to his pmdomain tree, and provide an
> > immutable "dt" branch, to be pulled in my renesas-devel tree.
>
> Patch 3,4 and 9 (I dropped the copyright line in patch9, as pointed
> out by Niklas) applied for next, thanks!
>
> Patch 3,4 are also available at the immutable dt branch for you to pull i=
n.

Thank you!

I have pulled the immutable branch, added the remaining DT binding
definitions, and queued all remaining patches.

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

