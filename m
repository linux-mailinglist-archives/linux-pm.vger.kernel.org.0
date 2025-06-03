Return-Path: <linux-pm+bounces-28022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C66ACC7F4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 15:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4733A31C8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420B4231854;
	Tue,  3 Jun 2025 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cZJH5KR6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D1B2253EC
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957732; cv=none; b=AF1M6NgASdnpgB1JlLEdOf/6IZwh+WXoB/sKKyLZ5CA62GOMhloP+Zzt9LyHuZQcT2NvkPRndkf57+WvQTgEg6BIuFaKRCWdLAvlv4TIUwkN3Vb42evw+bNzhlX4F8HrjjMQXGtsquJ2tqma5gOEH8YPSxlq8xDaWLO3W3GXOB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957732; c=relaxed/simple;
	bh=JMbOtPLP2HGwreQOwlEuUKoWxualvBCdLUGJQB6ESDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V97oJ3Ea9CGk4dmlbUr4DRaHyuSnoLP8zFX1zq9YWJ5g3MeswVfTauy5IHT2QI1jxCq9mvd+ChWftJfcrmWfcK88A/UWmCPDpLEYkLre2VBgBO2sVBZqkJXBbPEsMZao6IF6OLphLrAXH7iTC+LeXJl1SLCQnPBpVtULhU56j0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cZJH5KR6; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54e7967cf67so6601330e87.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1748957728; x=1749562528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIOXxCHtKeBYGzNsgywd50i1FC81LtsnP0F3u2yP/Ow=;
        b=cZJH5KR6Y9hzkOsx1b6pnSWo8RRQ+AJdWlM7X/1DAwp2nCTMG6O6gRuUa+XFp1mgl9
         YcU/l2WjPEYoQDNL88gDIaiCrWthMNv2CvPZIJfzBkirSAMqW8r5i5EaXDlGoaIcYSMr
         bKC3xJe49hNUhdnsKPyH6a3PbxzZ7h96JxolQtG0b6QViQkIlQqK/v77//jOBl4OrxrE
         dCFkiZ+1vuVcWyKaAF9PFgTRyw80q7x/asVhx8gk9rrtK1r9hmLWVWmsayj8cDqp8kj5
         GBERjhmgQ2pvdjtLfHwqWod7BFAOe2wcGWoXPHrkPp+gTQ5yxeTrcHbf6RLRGXzhzFAI
         6fQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957728; x=1749562528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIOXxCHtKeBYGzNsgywd50i1FC81LtsnP0F3u2yP/Ow=;
        b=BK8C/Dnj4Ki8wHb3JqwQRrSAu+JitN+5uzCeTRsZyQh0pOqESEb7Js7Vb6Epgb9xbf
         LBIsV4Hrh852lP+G6HUpR7YUa7iHDAN4bNmCRWAlCJ1SIstfMOtD5GXbRBmiFgN40NQY
         T41SUZwJBNnHN257+Z8cC/pIjndULT+/1XIHNAid9Nl23itK8tvlcQJyocHIkc5DRvmz
         hmPIA29XCG0IpTdcCjFznckFmwXjOV2xN6ujtDZeQzis1jW+c6k8dYk3307VKrRTDLrO
         MX5whKDVnMZ0Yaxzh+O1Zo7DEm2LAc7nNfXltDDUDjpXcLvzjOgVamKyoEEzII42r8Lm
         klZA==
X-Forwarded-Encrypted: i=1; AJvYcCWBrnhKgM+Y+uU0ysjX0F+GUVE0nRlG3EFoAQ7uOqG1DQGyTF/AO+oLHpy3YXSqJMZOMR0hfSsdOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzylISpXwxixAtQ+48MzNEgmatwnYIqyMoxHyI6WsQPv73GuNq6
	f6VThyqHQvBJvkNbzIPzCVft24TOcnN4zgKiuWiPjOyjIf7ls5Fez6vN9z9o0GG7M8M4kHDixpW
	ljRgPIMFyXx8iXFCIii5HBHE4vXZCi1KFw6njmVK5iQ==
X-Gm-Gg: ASbGnctQuqsqcarbxFIMHF7REq8DqA0zYmpTIIUmEC3CG8B/GHNwfcVUpqmzPjkOXqc
	ksCIWJ7ZlOxFvc9YkM9K20rhEUXMiGr0JpMfGK5uEeh08usDn6v31SqvWoFtZ0GXp73s0IxZJX8
	DNpU5RQl4Ki7cXQ2g3Mz3fDeml/nqm+wDa1qYHk5wDDU2wdlltyS5+yeBJDZH1nI0=
X-Google-Smtp-Source: AGHT+IG+4ruICaQP9WjnJtvSTT9EmK06oaor1STRsfEcgxfGLSMohUV22g53UcbTlMgO8PAYrxi/zYRyt6cxM4CKTj0=
X-Received: by 2002:a05:6512:3a89:b0:553:2ce6:c749 with SMTP id
 2adb3069b0e04-55342f5f525mr4032820e87.24.1748957728189; Tue, 03 Jun 2025
 06:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250529222403eucas1p1923fe09240be34e3bbadf16822574d75@eucas1p1.samsung.com>
 <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <20250530-apr_14_for_sending-v3-1-83d5744d997c@samsung.com>
 <CAMRc=Me9cWfe2mL=Q6JQbAFjpd55MOBZuAWC793Us0criiQr4Q@mail.gmail.com>
 <4519844e-b1c0-40a7-b856-a6e4a80c6334@samsung.com> <20250603-cuddly-certain-mussel-4fbe96@kuoka>
In-Reply-To: <20250603-cuddly-certain-mussel-4fbe96@kuoka>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 3 Jun 2025 15:35:16 +0200
X-Gm-Features: AX0GCFuDYKD0oEvnMgBkM50gIAPDgZLFL7Iyce01c_hFdppjyHLpA9k0Aap5-Uk
Message-ID: <CAMRc=MfXashaEscE1vF_P6cs9iOCBerfNFiB4yC+TX76fZ87nA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: power: Add T-HEAD TH1520 GPU power sequencer
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:19=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Mon, Jun 02, 2025 at 10:29:13PM GMT, Michal Wilczynski wrote:
> > >> +description: |
> > >> +  This binding describes the power sequencer for the T-HEAD TH1520 =
GPU.
> > >> +  This sequencer handles the specific power-up and power-down seque=
nces
> > >> +  required by the GPU, including managing clocks and resets from bo=
th the
> > >> +  sequencer and the GPU device itself.
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    const: thead,th1520-gpu-pwrseq
> > >> +
> > >
> > > Before I review the rest: is this actually a physical device that
> > > takes care of the power sequencing? Some kind of a power management
> > > unit for the GPU? If so, I bet it's not called "power sequencer" so
> > > let's use its actual name as per the datasheet?
> >
> > Hi Bart,
> > Thanks for your feedback.
> >
> > The hardware block responsible for powering up the components in the
> > TH1520 SoC datasheet is called AON (Always On). However, we already hav=
e
> > a DT node named aon that serves as a power domain provider
> > (Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml).
>
> So no. One device, one device node (sometimes with cildren nodes). You
> do not get another device node just because someone wrote incomplete
> binding or because driver looks differently.
>
> >
> > Following the discussion [1] about needing a separate DT node for the
> > power sequencing capabilities of this AON block, and thinking further
> > about it, I think the binding should be more generic. The AON block can
> > manage power sequences for more than just the GPU (e.g. NPU, AUDIO,
> > DSP).
> >
> > The compatible string could be updated like so:
> > "thead,th1520-aon-pwrseq"
>
> Should not be separate node, you already have one for AON.
>

Agreed. And as far as implementation goes, you can have the same
driver be a PM domain AND pwrseq provider. It just has to bind to the
device node that represents an actual component, not a made-up
"convenience" node.

Bartosz

