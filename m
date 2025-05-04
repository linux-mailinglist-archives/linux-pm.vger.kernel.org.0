Return-Path: <linux-pm+bounces-26627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E536AA880C
	for <lists+linux-pm@lfdr.de>; Sun,  4 May 2025 18:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6FE1891CB5
	for <lists+linux-pm@lfdr.de>; Sun,  4 May 2025 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04EA1DBB3A;
	Sun,  4 May 2025 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcIIfyX6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6E1991CB;
	Sun,  4 May 2025 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746375969; cv=none; b=myPMUbbkjNQqxocvZZEOCb/QnLnL5HTOiKKzZLu7VUKZUZumRxDiyWaZotWOxH/BY+OZL6uQDiE+GlPHsP3tVV8m2rYVSXOA46o/UYEvC3EKqez86iuZVlmTZmVfWDadJ8LaNxBkc26NBGwa7pSeh5V8pE1IyD6jbLyRkhug6QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746375969; c=relaxed/simple;
	bh=xgVZjcXHKjhFV2e0Sha9yDaCb8x5ozTGmTZNI3OywOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHrsoKlszZ+RZ53Mr+sXR7pDSVqTpfbjURnMVeIK+BobvSDp18+557Mu3g9RrL4Vp/akMVI9KXpMGEb+YRA5+/tM/Nik0mhKbTILbNsdMhAcwsOJWXziPFdEqLkeRGG+fe2hfGlVcOG1TkXJa/AeOn2ucn8LdtfWgpaccMqqDVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcIIfyX6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so2682665f8f.0;
        Sun, 04 May 2025 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746375966; x=1746980766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTYsUL5nQ0HFKrtoPkMLnrVmwCuz+f0XxK2SKfbaVEw=;
        b=FcIIfyX6y4ilMGT20qH3Hy7wjfHXlSxdz2mrfPYqVSy6zC4BPZBC3TmRRWVXJMGZnp
         8srcEC24O/NGmnIlWaoJCUOp8yJyzpjVRm+F+QJ8+IPwY4biN0X/Ou2IszzVSBZWHtBf
         hzdRl7XvEYq8ZZuBccyVVWAc/DhAKoZqAB6QaK+FjPPs9ER+FOiIbGsF1mume2h8NquV
         9rjHAhfotY+V/GfD/SLIaJUfLtr2mkx9TZJtUhLIaTSttH+fDWpzkCiZfIXH4A5djoHt
         ahUPsuVUxXJ2Huz6ITZX3rUlDVpS2TbVre0oQfVmiIj6I2nj9ciEE8pB3pB6BXNla7Nr
         w1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746375966; x=1746980766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTYsUL5nQ0HFKrtoPkMLnrVmwCuz+f0XxK2SKfbaVEw=;
        b=PoM2TI/INZ9Gj8QaHe0Y1IVDBEt4Kl6A+eYDIJwf30tIG0cWu6+rLVZ/TytaviKXUX
         J7H1HPJybxvZkZbLQ6HDJSgjSM2lupAXS3FUCWKRUQR9tp9w+hHD0wb9akGW0yc2rmug
         hrFOCaMVteCHBYSlacMmWW0wnldo9fwUIsuFyaA22Bc6gbjz86YSFKll5HCEgzvfkmZJ
         J/AbQ7dD3n344Pz4YJNAHx3EFKS+u888BGbHjLyEr2ve/MqhNo2TugOpVFA4WCdNe/Jr
         /lZuDZk995ABsFzkXfWlhQSQ/bSfqTnBtqfKvsV1qe/hGxOx7hlRK9mOZR0nT88ljtve
         IKJg==
X-Forwarded-Encrypted: i=1; AJvYcCU4H4xTIPwXhQXOK9hS6QIN2eDxEfC/E2IJtMJVuTWsO3WJgz99cDEWS2wNOVfjvC7tKVIaEtWkT50ocYI=@vger.kernel.org, AJvYcCV/ktQyE2tn9/fIUTs3n1W3NU+HjV5WFLPip+hOcNrALX4C4WtoRV7e5raw54zCtSBEHQTHCCPyluw=@vger.kernel.org, AJvYcCWMdGiGwylCjxjnV/E1mxWrWaXKxv1WSpzHNde68L858Cz3r9MBydU75aVA3uCdaBNaz+m/OjSu4Kk=@vger.kernel.org, AJvYcCXK5QH8zc1lnWHjZkPzlRpePkodJWWeVlFuW7Zyc1UXNXCyjZpuP4Imsuq7zdgjEKykReuKep04HxAQvjc2@vger.kernel.org
X-Gm-Message-State: AOJu0YwK52XCkgkrePjuj0vdVp1Wnzz8wr/5cgJoA8yY6fUZ6dlVeYcq
	o5yLKshac369QOP2r5uQL8tQw9vRkEhS+OUCZZ1k/Pp1noqyPhaYelS7qsJUYAMbXx/EAWgydIH
	Vn/GwTl6LRPHUlweWLjqc175S2RNOnuoq
X-Gm-Gg: ASbGnctI1kDekpZcdHSJ6ajzAbogc2Vt4UhIV9rsy28KVvKuJBPK1kbYafzjnB3scLM
	86ljGGDq95tY5ssEDy6JffGH1VYu7b4qEb1elxaitTvaZGlPhyvQJbrQG0FA2mSn3KDuB9g/baF
	OfLrBe9oEgWarRgrHiMaH5i+Q=
X-Google-Smtp-Source: AGHT+IHrv4vJAVIBXmTVN1mUoHZxvmGDNbWGcVAvv2QR3nGoOm0HQhXozJ9+T2QgXuyowv7TY51pLytNW+0nkZCIiWE=
X-Received: by 2002:a05:6000:2284:b0:39c:c64e:cf58 with SMTP id
 ffacd0b85a97d-3a09fdd9844mr3492275f8f.55.1746375966134; Sun, 04 May 2025
 09:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321095556.91425-1-clamor95@gmail.com> <20250321095556.91425-3-clamor95@gmail.com>
 <aef4574b-8167-4af3-a29c-8c962b396496@kernel.org> <CAPVz0n2580WLJmqeH-mJGrTQUpADt32qw7pJzuqRuwrpojc5vA@mail.gmail.com>
 <bd60283a-500a-4ed4-bb8b-c019d33f94cf@kernel.org>
In-Reply-To: <bd60283a-500a-4ed4-bb8b-c019d33f94cf@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 4 May 2025 19:25:54 +0300
X-Gm-Features: ATxdqUF1jwYwrTJT6CTtljhYneY2-STjeRk-YxsWwq96KjOmyUA6y_gtSvV0Fbw
Message-ID: <CAPVz0n0Ty3QAg_9rSvV7c7EBGDigHtTAOAfkRFBcTR9fziEvQQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drivers: clk: tegra: add DFLL support for Tegra 4
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 4 =D1=82=D1=80=D0=B0=D0=B2. 2025=E2=80=AF=D1=80. =D0=BE 19:23=
 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 03/05/2025 10:54, Svyatoslav Ryhel wrote:
> >>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> >>> +/*
> >>> + * This header provides Tegra114-specific constants for binding
> >>> + * nvidia,tegra114-car.
> >>> + */
> >>> +
> >>> +#ifndef _DT_BINDINGS_RESET_TEGRA114_CAR_H
> >>> +#define _DT_BINDINGS_RESET_TEGRA114_CAR_H
> >>> +
> >>> +#define TEGRA114_RESET(x)            (5 * 32 + (x))
> >>
> >>
> >> Does not look like a binding, but some sort of register. Binding IDs
> >> start from 0 (or 1) and are incremented by 1.
> >>
> >
> > Hello there!
> > This file add same logic for Tegra114 as Tegra124 currently
> > implements, check here
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/i=
nclude/dt-bindings/reset/tegra124-car.h?h=3Dv6.14.5
> >
> > I did not re-use Tegra124 value, though it is same, to avoid confusion
> > in main Tegra114 device tree.
>
> What confusion? Why would anyone be interested in comparing numbers thus
> getting confused by different number? These are abstract IDs.
>

By using TEGRA124_RESET in Tegra114 device tree

> Best regards,
> Krzysztof

