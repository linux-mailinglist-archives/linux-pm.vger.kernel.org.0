Return-Path: <linux-pm+bounces-26611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB4AA7F85
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 10:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9420E1B641F9
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 08:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD901C84AF;
	Sat,  3 May 2025 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQj9bpdM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1211B4248;
	Sat,  3 May 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746262464; cv=none; b=gmlZ5O2/oqTmQ8bhgiMB7Nl7gPXfJOK3xn4tpnH/RMtvKyC9X+/MVUQyzpDTN27P5zEaZB6f12AAGwI6LpH1Qjh3NQOhSF2NhghJzx1qp8Eio5WrKKZDiMaReUCoDR1WYFJinOaQEARqHWmDTNWXAJ2zzv7qt0FJSP16tRbfukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746262464; c=relaxed/simple;
	bh=KC5wSlC8ldVc/1/ANa0xPfHpqPnMjSq7jhbsZsijn30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJVDUxGrPCfayiClE7TTIsGuEqS9wgvu/g9DFeybxWJsyYxZQAo8LQhrobYYxp57AsFIXQVx/OyA/GytoWVqvcNF2FdonzYfeUDhtniiiw1kxMDEFY0MZaowGVskVGLoYSSUK40tUw+eERewVp8Y/KsKnKABWaeWXXzfSBbvMuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQj9bpdM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3995ff6b066so1186952f8f.3;
        Sat, 03 May 2025 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746262461; x=1746867261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0rajkV8F45MIMG03jHItI8yQSZ0sSq+1qy4v7bWCgY=;
        b=eQj9bpdMgk+ClYFQpMutXIAZGVcknhCHVS5O1/1eLEjVfe8hHCUi0i3Qo/vSniL3CK
         wkaT96rTKz9O5nNqDydPSygpL3Kdoyor/vWrzLmc83nnv543cC9jfuJy9UzXS2SnsooT
         /uLGcXCv/NkAbVKsxILsaHnWCG5e2rHo+pANELUSeNkQZKmlJIsje2bNMu9txe7NOwQw
         8Y+vWninQtMWiuMgk/D8cCoGsduSFU5O/0YQlLt3+i5hHRPu4/MZ3p4B7n7FnEqNUFVq
         mwRy9OZuegwrMjisS1qSyIx8ODi1lzMyHAOYRsLQzBDbKxvkTEFmzOxgNT7lVgmCKVgi
         ZeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746262461; x=1746867261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0rajkV8F45MIMG03jHItI8yQSZ0sSq+1qy4v7bWCgY=;
        b=In0akTQfAZ5p7tisw5H1OWf0bLOvxSu4UA5C5c0wjs4eCK6Z5nWO+p2ECENZtN0o4L
         fqk1WoeB3elSnHqRJ9sZVt/ohE4Twtc9cGDIWZBNtb6QRPMF1kFFzCbxLfZXd1RI6IH1
         rUwNeTN2ACM9nf1AbUrU1tKnfgglnKzyfXcoqAF4i200lRznoD3mi+6ngAqv3sGMOS64
         RU4AzGXZYhGGygW4N1pZuVrnPRhGeYiIH4eVmllU4IzG9DLEasws0hcIOZN86jTfEwb+
         2bWL64LXqtVQEVd5Shj+VXdc+PXraQGcabp5qv3fQGCUUlUecxGIfH8LIkxL3WL5MRF4
         CXFA==
X-Forwarded-Encrypted: i=1; AJvYcCUjGsmX7nsejo01v7Fy+NJ+bdfktDa2xPNXjLIBVeycU8ELQbUTISlFY472UDzxUs2FCX7BooOFUec=@vger.kernel.org, AJvYcCVzqrEZYCMDhrxG6olSPMUtrfTLCJ671E+ic7QOE3l1CB8XnjVOtOlduwg0gPYFBvCW3j0W/bBW1b2X4mdp@vger.kernel.org, AJvYcCX2Rnst+CLzKt7TlxhF3QJMGbRdbrBwndrm456OINm8t8enjTHEcn0Ju1LLXwu4NQKqZVGy0r0hjCiySSU=@vger.kernel.org, AJvYcCX6BN5rURQyrH3tckrL6XEqjmWGGCO2qLlP01P02ILlJvtebBQzcJnfVBH3YtR0KgcZycnnvhsQVm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5ycyHaGKcGh92zi7SqIz4M30vWKN1xTxPrrJnMcMX+u0rQ1F
	DG8PkB+LIQYoNPHkgjVEgG1hAuUajfZsALJ7yrSWpkOCPWNUoEyoa0sjrBr2XUBx1HcgjzHEzi9
	TFxaFfyolKUioYAomj/vObxmVGPU=
X-Gm-Gg: ASbGnctGYevqGVcLZzR3XwKupxjFB8+hSqTOHmn/prstTaXqLZuAmrBKBKsVT4EV2EH
	v+x/m0yzRMPx3e6fpq3oAaYEEQU67aatC1DSVdUFVhygDXrwwb4ht5cQHTS0B6frFGLDlLAQT2O
	yap+jwSz8NNDrXkimkJkqqoxU=
X-Google-Smtp-Source: AGHT+IEiRCFaVbG3AmnYfBsbUy9cwbkVHAHepWoGFC80Dcd4IF6BuhA+RCHqkkE0BQNM9cmujTmkZMccEhI+motAAYA=
X-Received: by 2002:a05:6000:2483:b0:3a0:9dd8:420c with SMTP id
 ffacd0b85a97d-3a09fde626emr355383f8f.50.1746262461006; Sat, 03 May 2025
 01:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321095556.91425-1-clamor95@gmail.com> <20250321095556.91425-3-clamor95@gmail.com>
 <aef4574b-8167-4af3-a29c-8c962b396496@kernel.org>
In-Reply-To: <aef4574b-8167-4af3-a29c-8c962b396496@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 3 May 2025 11:54:09 +0300
X-Gm-Features: ATxdqUFHDuJFidHJr9tx4g91kDWQYsoQui3fjv94FmbPMMiUE8iqHf7-yk1T2Y4
Message-ID: <CAPVz0n2580WLJmqeH-mJGrTQUpADt32qw7pJzuqRuwrpojc5vA@mail.gmail.com>
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

=D0=BF=D1=82, 21 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 22:50 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 21/03/2025 10:55, Svyatoslav Ryhel wrote:
> > Extend the Tegra124 driver to include DFLL configuration settings requi=
red
> > for Tegra114 compatibility.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument, so you will
> not CC people just because they made one commit years ago). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> </form letter>
>
>
>
> > +++ b/include/dt-bindings/reset/tegra114-car.h
>
> Filename based on compatible.
>
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> > +/*
> > + * This header provides Tegra114-specific constants for binding
> > + * nvidia,tegra114-car.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_RESET_TEGRA114_CAR_H
> > +#define _DT_BINDINGS_RESET_TEGRA114_CAR_H
> > +
> > +#define TEGRA114_RESET(x)            (5 * 32 + (x))
>
>
> Does not look like a binding, but some sort of register. Binding IDs
> start from 0 (or 1) and are incremented by 1.
>

Hello there!
This file add same logic for Tegra114 as Tegra124 currently
implements, check here
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/inclu=
de/dt-bindings/reset/tegra124-car.h?h=3Dv6.14.5

I did not re-use Tegra124 value, though it is same, to avoid confusion
in main Tegra114 device tree.

> Best regards,
> Krzysztof

