Return-Path: <linux-pm+bounces-29077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0426AAE0839
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 16:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C42C1893A46
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBC52701DF;
	Thu, 19 Jun 2025 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EurY3DvU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E2263F4A
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341943; cv=none; b=nJ/lDGPWQTgmDL613+SU6D8b0b4XTvJRg+VSueeLXpK7lVbqD4z//+B7yvn8iGLxLW6LMJWUkiwACysafOYaGxwerW3ThMePGP5kBrKajmw6viosASJHuq8fFiwP+CEPAOqGwbWUIi/V7J5r6lR1pRvk/MO+3WOiKpgr0D0Lz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341943; c=relaxed/simple;
	bh=RKg0ba0YiDbucRJJP0q5rGzXl3UtGTSrIi2K7UJJiDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k83jQZ/kXgio3VJCIK/zeGtOwghno26Zy1SStMivsj14O/36oWqPvdfd1886WOBdJzULm8mMXL876qT04aXCfuBzXo9zeiuSFg7zC/e3O6Zik7Vs15cVaqM9gXZ1kNjAMHiUSOeeF61nTokKZeqvo5Rwc6N7KPqYLzXhqJZi/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EurY3DvU; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso745739276.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750341941; x=1750946741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKg0ba0YiDbucRJJP0q5rGzXl3UtGTSrIi2K7UJJiDI=;
        b=EurY3DvUsdfBOAQsumNXRbw24qBG5plNeQhFnD4AvMl5e3w2Zrir0VEIzPLdhIBuw0
         +3nKnJ9UtgY/iUtUYGS1G7LaXIzZHyZFiy4R3+2pMpv0MvHbUdtMBbAvVyEZMdpGKMq8
         kZ6vjFw4N5cIy9JgUkUV1gv4aqfNzhrjTi02KeCekAFptw2LZq5W5Xb1sYC0eTkivPI+
         fpm6zJ9je/cBsNcFwzLHyJ2pnMi0It0evjWm6ChDL4jfSqGGiJ9KKpSO6XcGq2MDi1Oy
         LWqBJIpyt/BImGtqGFPufOqklqSXE9uccOMlJk7Tmw2tZNGElsca6Lu9HRbFreXrGUVX
         DcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750341941; x=1750946741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKg0ba0YiDbucRJJP0q5rGzXl3UtGTSrIi2K7UJJiDI=;
        b=jGxvgU0k0f4nwAEnh4XfApca2Rm0FealELZzNjapCaO55tgotkWT3C8wlVBu5AW++q
         0MD59TBbiEBM1iE7L6+A8rln73bxlmVdugi2AU3M8rZxUd7/0NfRApFCas6pbxVf8aQj
         RHJB7FyXatSNHKltNZvWEv+LyErLy8s7IZlPKwRTEIa15ULkmSPkWJ0veQXJ0I4Bugue
         lZFBMds33jNA6oMEAy01teCogM4k8LV47BW+8eUZlqAE4o060IvWhqrz+5r1ugCTzxn6
         gxrJ6d66gNic3V4cRb8ZqEPhyDpfpcu9NfX9bbRTnTCASw8Aa9uxj4Gffk5UFFA4a3fH
         8NyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjYRo7HXBsy29z9j+gs47qzP4GrylQNZ8S0B+0nhe75hEf5ikvgHmEs50nMaeB0MeARTbl0ixD2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4gInm5TmTS1HTP+M4Smh9gX+AojNWMYfRYjtxtQE7ScoI7Cr
	M6woOxiJEWl6xli4hB7jZK/V4UDe66R5DuRFBwVZ6LV7YxE+bk1ijEXCm3AR1rMh+aC1PZXhvQR
	bu+RxC+BdeURgK/rT2mP/EPSAupw911kih7ZmelwxuQ==
X-Gm-Gg: ASbGncvYx/lNuNY5Nn6yfHquc2izXV4HzBb/K22qgRSZ4EqAS+Za0rpFDwj1nu3VhXH
	vgtP8qA8eW4geIejKzqlmQwoDPW+t4Ox0gAxD4Dc7aokNIhcsw2d79ZqcKs6FhGUmQzsXP/i+UV
	Ix1L+x+vbk+goJmNN5x95J3VQt3km7oeAJpFBGYH7PB1Zh
X-Google-Smtp-Source: AGHT+IH0AH5eQCmkoaKuxJOOgz4lFGdC1+XDKcfPC3cVk26SzauKoptzIDMdTxuXWb+pjp6Y/soe1VeW59yNxFQhyjU=
X-Received: by 2002:a05:6902:1a49:b0:e7d:a4a7:439b with SMTP id
 3f1490d57ef6-e822ad08e62mr28105508276.48.1750341940771; Thu, 19 Jun 2025
 07:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618102228eucas1p1906803f73cc004e68f281b2bdf871da3@eucas1p1.samsung.com>
 <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>
 <20250618-apr_14_for_sending-v5-3-27ed33ea5c6f@samsung.com>
 <CAPDyKFq_4W7bPr1NiuEGzMDoY6tQuHbw5uOXrkJagbEbtmqMWg@mail.gmail.com> <CAMRc=Mf+o524rewPrtZGJhE11Gwp6v8A2V6zjGr3e1PmQq7aJw@mail.gmail.com>
In-Reply-To: <CAMRc=Mf+o524rewPrtZGJhE11Gwp6v8A2V6zjGr3e1PmQq7aJw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 16:05:03 +0200
X-Gm-Features: AX0GCFv2RIICzft_XZewOUAZZhSSWv8Je60KaQi8kC_SyLtOZnxRamWoHqyfp3U
Message-ID: <CAPDyKFpsq6qaRaP4YDMkB=JrW+o3obKoirfHrdmost-kV4ct0Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] pmdomain: thead: Instantiate GPU power sequencer
 via auxiliary bus
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Jun 2025 at 14:31, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Thu, Jun 19, 2025 at 12:25=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Wed, 18 Jun 2025 at 12:22, Michal Wilczynski
> > <m.wilczynski@samsung.com> wrote:
> > >
> > > In order to support the complex power sequencing required by the TH15=
20
> > > GPU, the AON power domain driver must be responsible for initiating t=
he
> > > corresponding sequencer driver. This functionality is specific to
> > > platforms where the GPU power sequencing hardware is controlled by th=
e
> > > AON block.
> > >
> > > Extend the AON power domain driver to check for the presence of the
> > > "gpu-clkgen" reset in its own device tree node.
> > >
> > > If the property is found, create and register a new auxiliary device.
> > > This device acts as a proxy that allows the dedicated `pwrseq-thead-g=
pu`
> > > auxiliary driver to bind and take control of the sequencing logic.
> > >
> > > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> >
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > It looks like there is another re-spin needed, but thinking of the
> > merge-strategy I could potentially take patch1->patch3 via my pmdomain
> > tree, as it seems reasonable to keep those changes together. Unless
> > Bartosz sees any problem with that, of course.
> >
>
> I have another change planned for the pwrseq API for this cycle.
> Nothing major but it still will require patch 1/8 to be in my tree so
> if you don't mind, I'll take it hrough the pwrseq tree and provide you
> an immutable tag to pull before you apply the rest?

Right, that works perfectly fine too. I will wait for you to give me
the branch then, before applying anything.

Kind regards
Uffe

