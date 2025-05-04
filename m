Return-Path: <linux-pm+bounces-26629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DF8AA8882
	for <lists+linux-pm@lfdr.de>; Sun,  4 May 2025 19:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A613B9E0F
	for <lists+linux-pm@lfdr.de>; Sun,  4 May 2025 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5EE1E0DD8;
	Sun,  4 May 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWyACLc3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5391CD1F;
	Sun,  4 May 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379834; cv=none; b=OiRsztuAnNk2X6rCvk8QJ12qR6uY7Ensx8lB9bako1g4xXLa+ZSIDKhkD9Y8Chsb8X/2FYWQmTaXJd5kXRp5eCenrxiv76V6l9PdZzn+GAa3pIOH5LrjD6HhiAdKqGNFdF9U65N2ttK2B/FpLDTbxIApOOoULIDrjrpz47FccJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379834; c=relaxed/simple;
	bh=qN94OWEW7oAU1BPWolOFwRzK3GlFBD5rwHjcYgDw3ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBQ1AVNmJR74hq8WxyPRDsMSttYQlp+fDW7jM5mLAcQ8TqvDlz6jwSIcyAlTzKswXZNPlxQVlRbEGOEbRnXj7GO1eS/qP/8kuqp+1rFGDPKG2xkrSgWipoLP40oCT7F1H3EOHfs892IOt1abO5iFnuiy7CEKIvqvT3jXy3wOHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWyACLc3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c14016868so4219925f8f.1;
        Sun, 04 May 2025 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746379831; x=1746984631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXz9x4R6odLWtZ/1SlKRLZrfeZhkWvyXiyW0Kzx3a/o=;
        b=IWyACLc3c/HXacmmscCtNGUCd4zVVV3v3TiSJ+ul5sJAsgjoGU+k9nZHQuyAHltlka
         5jwSmO0fLUwji0PJNcj4u+CBxho0eYxMdAAmCZwnRddY+HCd4iPxQTshHOzf7ypJm4E+
         uSgT9E6qHkFjenZgGQcpK63ramJu38soyAzqVYic3uTWWdCnbe1HrRHPPhU/PnCcdnRQ
         OmbSQx75R/a5TTdFjmekwkseSdoAYIP0x1SVo94ZR1PUfZgYOn/wGFS4GBd/NkYyMOgs
         2HlosKsH2kDsab1KEif7hNKgQD0xPL1vml9WgpdMAd7LwaTodp34PVOa5TGtjpyWh8Ml
         +xYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746379831; x=1746984631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXz9x4R6odLWtZ/1SlKRLZrfeZhkWvyXiyW0Kzx3a/o=;
        b=Ovs+8o59gsbB+FAbaH3XbXkVXTvvQky5HSnrzKqCgvctMz1E4L7m6xYK0ebxDW8sRW
         MSaKkP9zcBr88pQtwJIjSwYeKvxr0N2KAkZzg3+kNcQeJnHG1pKuTtCUDqgN+OTIHsmg
         qWe8U2qlnsVNCwHCtvxilK2V3l290IJ1w06fw9nmJcaVTLMxEgbcQuXZZkfxuTJHUH4q
         csvn2aj6J6HTB95B3JxNFIUXNg8bbWd95/kuP3WeOUQjjfabNgRVlKQ7QukyHdHMnyye
         x3V87MzSsKIt2s504brG8+hc4FjwjXFagmojVcRERWPXLOXQbjVRTkl7lJIuAAPn3nOZ
         qbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+XyvFxxqkQ/k9uQsBr3VqhUWDx4bQ7AnpAgsxVxAEDrqqjUtX8CjBDKZ/RV3rSYH/iHp3k37Dv34=@vger.kernel.org, AJvYcCV0HN7V6dO5T092tytU33swWWSSKDlqKkYvApjZKEDNBBaYLWRZoGrCpkZADg3e/CTXbYn7XqyJ+ck=@vger.kernel.org, AJvYcCVO08WReJPYv4MGi1ch7/k2exdm4a7qsglNHeL6miHdnmW7aBKLu0e54e/SqddqPkNppj4/xbG7RP1798k=@vger.kernel.org, AJvYcCXx1Z+hrKl08GLOCzeai1GHA3mqbHFEZBtymLwgIW7vJuP6xaZ8jICT5QCpVSmqmGMVaDQj2nRex08fjghB@vger.kernel.org
X-Gm-Message-State: AOJu0YxRLzCqJ4SCoss525t/fHUmIL7HXa/iZ6txy2lzRQh79LkOyRC8
	lFWxJ2x+GRFhLikwwvCr3UBy8JNN6PWeVOzV3NL1MbVtiDaM5YVPJBY3RnnrMRoWZjnJUZt950n
	BbcILZU9skMr5J03lRds1pi54ALI=
X-Gm-Gg: ASbGncuYreZwjKqDthFut2NUhQyUeU58CqhJqMy1SpdcVDSPhiJcSn09XWTj0+dd6Ki
	ZnRHxLe9YYJhUyLUNJVWtWEXJE4unhQg5YOg14/sPX5RmwpCxxax2sNZGomUu7zXgzE0GD7q6LZ
	JWlFl61He0kYepwVWKyy1jfWg=
X-Google-Smtp-Source: AGHT+IEgBmAQOSDRawFPRNPqlVa1uDHMOx4ibl03Op0ZZ4yWCk3RTWb5OgASZglrY/Ox52q9TBmhTHgkradNQZsOdbQ=
X-Received: by 2002:a05:6000:4310:b0:39c:1257:cd40 with SMTP id
 ffacd0b85a97d-3a09fddfc6bmr2810912f8f.58.1746379830849; Sun, 04 May 2025
 10:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321095556.91425-1-clamor95@gmail.com> <20250321095556.91425-3-clamor95@gmail.com>
 <aef4574b-8167-4af3-a29c-8c962b396496@kernel.org> <CAPVz0n2580WLJmqeH-mJGrTQUpADt32qw7pJzuqRuwrpojc5vA@mail.gmail.com>
 <bd60283a-500a-4ed4-bb8b-c019d33f94cf@kernel.org> <CAPVz0n0Ty3QAg_9rSvV7c7EBGDigHtTAOAfkRFBcTR9fziEvQQ@mail.gmail.com>
 <aa8bdf4f-feb9-4355-b629-a5d7c6a43d25@kernel.org>
In-Reply-To: <aa8bdf4f-feb9-4355-b629-a5d7c6a43d25@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 4 May 2025 20:30:19 +0300
X-Gm-Features: ATxdqUG74o4E1VfxvQDlDPvQVG-IwU5jeZaPk-ZrrnvmG9CciPCvKQEnb-iGPH0
Message-ID: <CAPVz0n1y4oF9MJkOJ+XTyDDe2u6mOXHsnAaJfLSM6tpcWTW7BQ@mail.gmail.com>
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

=D0=BD=D0=B4, 4 =D1=82=D1=80=D0=B0=D0=B2. 2025=E2=80=AF=D1=80. =D0=BE 20:11=
 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 04/05/2025 18:25, Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 4 =D1=82=D1=80=D0=B0=D0=B2. 2025=E2=80=AF=D1=80. =D0=BE 1=
9:23 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On 03/05/2025 10:54, Svyatoslav Ryhel wrote:
> >>>>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> >>>>> +/*
> >>>>> + * This header provides Tegra114-specific constants for binding
> >>>>> + * nvidia,tegra114-car.
> >>>>> + */
> >>>>> +
> >>>>> +#ifndef _DT_BINDINGS_RESET_TEGRA114_CAR_H
> >>>>> +#define _DT_BINDINGS_RESET_TEGRA114_CAR_H
> >>>>> +
> >>>>> +#define TEGRA114_RESET(x)            (5 * 32 + (x))
> >>>>
> >>>>
> >>>> Does not look like a binding, but some sort of register. Binding IDs
> >>>> start from 0 (or 1) and are incremented by 1.
> >>>>
> >>>
> >>> Hello there!
> >>> This file add same logic for Tegra114 as Tegra124 currently
> >>> implements, check here
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree=
/include/dt-bindings/reset/tegra124-car.h?h=3Dv6.14.5
> >>>
> >>> I did not re-use Tegra124 value, though it is same, to avoid confusio=
n
> >>> in main Tegra114 device tree.
> >>
> >> What confusion? Why would anyone be interested in comparing numbers th=
us
> >> getting confused by different number? These are abstract IDs.
> >>
> >
> > By using TEGRA124_RESET in Tegra114 device tree
>
> Why would you use define from other SoC... and how is it related to my
> comment in the first place?
>

You did not even bother to check link that I have provided, did you?

You cut the actual device tree compatible definition,
TEGRA114_RESET(x) is a macro used further to define device tree
compatibles.

Like this:

#define TEGRA114_RST_DFLL_DVCO         TEGRA114_RESET(0)

>
> Best regards,
> Krzysztof

