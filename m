Return-Path: <linux-pm+bounces-29073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E52EAE05E0
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C137AF929
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1739323F439;
	Thu, 19 Jun 2025 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rxLsQO++"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426C23B630
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336308; cv=none; b=BEAcym/5LJ6/Od3OGT36YW2YUr+uYV3Mjgh/Kuwmz4IYCPExLHKHjg9eCioSnIyX5Hem119hK5uwBkkf4aIDtCvwjvsN4bLxQteH04XAb53eLbLIzeE5IlQhUHE9+x3rdS3gbJSDJdXs4bDpTfJPeoeSE7rRgb5Wi+bdphz2gsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336308; c=relaxed/simple;
	bh=tMcCgVRWuLovCnQmwobA6BOzc9WI8fy/gQWq8E19Azw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LST68Uu0JFB67ZOa9iA+FX9j4k6GXoiBhxkb6U3ZPq4U77K6It+iA2//XbTE4yzX5LcIJypjoLgDSa3OQC7pulQ4wTOn6SF5KIJu40TqNgy4wXXMK90PWPj0vd9T3hRfNjNYA7Bt3xvmceq+u3lP9HeZ2zZOGTzOlN3eYDG6DXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rxLsQO++; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553b82f3767so661535e87.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750336304; x=1750941104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMcCgVRWuLovCnQmwobA6BOzc9WI8fy/gQWq8E19Azw=;
        b=rxLsQO++fccTsKHYsahPMp/y+QWD9zi3pQ+2XWCSXXuteBzBw+2ya49umuskpYOqSL
         Jo6PiejzG3qUhD+Is/s7oMuDiwWSZz3HME4XnWLqQls4ANi+pn7+QJfspHb9U5LoD2Tg
         O7jbt7VnF+YRJBOFKg0kIsfpGHAHHmeIwi/MQdqikQWccY3402ql5e1Iy2XEk3HQtI27
         KRX+GI6cy6fa9vxARXO1xIYVNTei/nCtH2eM4uU9KHJtvhKDCohlDiOCcsRPwZdwsvx8
         lmPdGBpX7IzLrmevorZLQUkyOsNDD2+EvLK1au779QNgphnRUOJ5m9KJTbOMMX6XmT0w
         aucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750336304; x=1750941104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMcCgVRWuLovCnQmwobA6BOzc9WI8fy/gQWq8E19Azw=;
        b=l3PVCGw3uxu8cBAOb2CFLZYriAroMcqXLAnYrXUJ6+vEPwnqtl810u1J87Tcmqx6uO
         d+/EOegxTbAlSfbCgs7eyJdK0qajxyAvZwzgwr8768fGR1U7BuKjXTAe7RaRq62I3+k0
         OAV5tQUkOwvKCTGZM10KI+fRnceMREqX1jldNMIwR07+4MfDFVG867lF6w8PqqwKjbZd
         yRtPj5gvfG9Y5SddBGBZaM6evCVECd/hjdAQbUBcYY+LYKOZzNYkZMSAm50+H8P/J0t2
         aVsJ1PUzpbH3pGTQN6bcZPnab6OfmAKUmdl+jA7Uv7HezhIRsAo2B2YiNYLDPNvb63mW
         tuEA==
X-Forwarded-Encrypted: i=1; AJvYcCVR63gihXc28ssZMk4UUQu7kTHZYZf+E5WaNTAoj5WIROcbx9pgPLJ8Dmu4gSescFssQRSfhyOA0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbifYanDDC0Q/alPS1m7XY7hjDrNcJ0CjXMklo7hqpJvAMHwZK
	30zVCuPaLv9B7IRvmzWVmX8OEdbzI2axr3+g2UyADJ+8mDOQoR1NnrQyV6Rvv+2IEb49VeKooFT
	kZLAHbA0v9WkY3j/pGpSEcZBMRJTFg+N9ZN+9EepeGw==
X-Gm-Gg: ASbGncsRIjPY9CzUwDN/5ab9K0ND9QOfMGqDseuDFD90c6ih9H6Tt8u+sShpAod6fLA
	ViNKJQwpC/M3IXyakkXbnm+P7e7lS4xa8bZU0sKiw69klOvUgByCu7Jc0isQbEec7I377bKpVOy
	0Cc1NN4M45k+6PCBhTTeBPpcC4gouRY+mwZ4wB7fhC/maqrk2jg2WoegAEZiaSBDiYKCY2Mgn9J
	fc=
X-Google-Smtp-Source: AGHT+IHnuVpyxaUGV1/CRhQuo9bKehpcx5lRIL+L/i/s21Xafs+bJVvPVmoWpCvGx60h0BZ9+f65HqFMJzZRubWTK2s=
X-Received: by 2002:a05:6512:3a92:b0:553:26a7:70ec with SMTP id
 2adb3069b0e04-553b6d9eb20mr5867264e87.0.1750336303504; Thu, 19 Jun 2025
 05:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618102228eucas1p1906803f73cc004e68f281b2bdf871da3@eucas1p1.samsung.com>
 <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>
 <20250618-apr_14_for_sending-v5-3-27ed33ea5c6f@samsung.com> <CAPDyKFq_4W7bPr1NiuEGzMDoY6tQuHbw5uOXrkJagbEbtmqMWg@mail.gmail.com>
In-Reply-To: <CAPDyKFq_4W7bPr1NiuEGzMDoY6tQuHbw5uOXrkJagbEbtmqMWg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 19 Jun 2025 14:31:32 +0200
X-Gm-Features: AX0GCFvVV9T1_PzhkFci_vmPMYmYNx0pAplO5ttJMtFBTyUJUhAUxypAYMCTkw8
Message-ID: <CAMRc=Mf+o524rewPrtZGJhE11Gwp6v8A2V6zjGr3e1PmQq7aJw@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] pmdomain: thead: Instantiate GPU power sequencer
 via auxiliary bus
To: Ulf Hansson <ulf.hansson@linaro.org>
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

On Thu, Jun 19, 2025 at 12:25=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Wed, 18 Jun 2025 at 12:22, Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
> >
> > In order to support the complex power sequencing required by the TH1520
> > GPU, the AON power domain driver must be responsible for initiating the
> > corresponding sequencer driver. This functionality is specific to
> > platforms where the GPU power sequencing hardware is controlled by the
> > AON block.
> >
> > Extend the AON power domain driver to check for the presence of the
> > "gpu-clkgen" reset in its own device tree node.
> >
> > If the property is found, create and register a new auxiliary device.
> > This device acts as a proxy that allows the dedicated `pwrseq-thead-gpu=
`
> > auxiliary driver to bind and take control of the sequencing logic.
> >
> > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> It looks like there is another re-spin needed, but thinking of the
> merge-strategy I could potentially take patch1->patch3 via my pmdomain
> tree, as it seems reasonable to keep those changes together. Unless
> Bartosz sees any problem with that, of course.
>

I have another change planned for the pwrseq API for this cycle.
Nothing major but it still will require patch 1/8 to be in my tree so
if you don't mind, I'll take it hrough the pwrseq tree and provide you
an immutable tag to pull before you apply the rest?

Bart

