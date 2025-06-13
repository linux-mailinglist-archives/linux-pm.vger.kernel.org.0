Return-Path: <linux-pm+bounces-28669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B1EAD89B6
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 12:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2229189E925
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0CE2D4B59;
	Fri, 13 Jun 2025 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rqNryHBH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92825A320
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811279; cv=none; b=hfqSPjs6XNTZVcvTZIFxysuOhNhEt5r1hHWSejL2nZOkE9ZEZL4kTQ9ne755IcPMDjRKvGbViCTZw78ChG+y1mOjjZuAf4uozca2qAXCbn9M8WIFhXZ+6qFpcKS1x3iqIB43ircEmrJRZGXzbcE1w15B6s9XJukXAsT9tbe11mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811279; c=relaxed/simple;
	bh=gfKzLlzdg8/hxOQ/sfQWUfeF7cK8hBoGCPK1f9nwKuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6w1l5HOZ1Pie2aPcN1S/J2fCtuLQfHF6OzOZUjoZvZQXNbagcp+8D4onzMdOFrkKx1yqRYEVFHj+9xSbWxee/y41z4MwLY9pG4ktXtsWTE8eadw5g6gcGW/5Mwlm2L6jhGfYbAPOrdfvAVy2vP04r/X/DnMaIfOiCtEH1BiROo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rqNryHBH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553b165c80cso531124e87.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749811275; x=1750416075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfKzLlzdg8/hxOQ/sfQWUfeF7cK8hBoGCPK1f9nwKuY=;
        b=rqNryHBHsZhtX0K4Z86+8QeNhWrTqu149PAxzQ9Dc3NGc64v0UDezLt4/0lxB2QBe3
         BH4xIYQAYSvV/J/OSmfrzc9IUeqgPzRjin2PrMK358R05rat5KrcuLvACjd7CYfWaYDB
         R/N0LmGl8MFvqdiukoiEz5TEA4cTDQSKIJQL8X9OzbQXnh9D4zeY6+u4q3OSuRFG2uRg
         mn+7uKyyyJzZOTL6MzGJ3G46FsLobIrBUD8mToeP7Lz7IxkWagHignuqc17Y/MkN9I9I
         yF/hhXUma8jAZbW1UB0ZgZ3lqhduGzE8VsDqkUsnHETiFjjHV6Y7Dxqx+gxDNTKJuRxf
         9uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749811275; x=1750416075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfKzLlzdg8/hxOQ/sfQWUfeF7cK8hBoGCPK1f9nwKuY=;
        b=e5Brpuq2DHVrZHvAIQQ0ZEs1nLx28tedoMLZJP32llQoO5frYCL5wDwu8z2j9od15t
         IhdiaiwcO4v8amxNHVlzy/oIqJXTAf7Q7tvhTVnMOJQv5kg60HM5h1XZTNNOdhxEJHK5
         gGjc9nPs/S9KP/p5WZmQpVNwBVagywjH5o11+tG2hfHxjiZFu0NJzWh3q/QjeohjWuxD
         Mr+HyqXs8i5CbSHryaU4DjN2XtK+Z11bxN7U84w/0BS5nkc5KTb1n+IU6Ob1LOWz3A9G
         qqN95E/wBuGMC7PMDq+F0GLC2jw9pDtaRIeRsBGD2oIQ8y6e5qXCBWovDAqxmOF99nty
         8mnA==
X-Forwarded-Encrypted: i=1; AJvYcCWoScY30oqlCSLnlryi2xwDDdhzyWQMUaNLfsZXfSntfet+24IKm5UWZYo+e7rtaWq1TDUz+WFleg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6Wz5X2IBxE1/+n0+02hUdk4pvlqlY3ujSU1qSDaQArQXS/yo
	nceYen8TNxDcGX3FEXX+4oxyJFCI8LHCuHS7n0+tbvRyh1BvP5OL/coC5Xl09a72E0y6XbZ+cg9
	CN8M7+yskJ24ds9oZog+ulnvup6XdHYzi7EPI8TjjvQ==
X-Gm-Gg: ASbGncsnAMBglzvaMzCxrpUfkvnBqcy1KqXt9g4JVM/hk6zhJdoFJN6KODd9Nx3Ulj4
	f/ksh964pzZ/ZLrhj2aJHRD75nRHSDBNlc04C83DMx34pC717TzMVtWCzoDL3FdFRYAxjsTQ2GZ
	fwT5eUlkVtIhuKomTjbBwgXT5J56dKwVNy98gaF7FkgDkHyNSJ5LrX5NtqfhD6x8j5HPe25s5rd
	jEr/A==
X-Google-Smtp-Source: AGHT+IEI5iVUc0DEPqOvU7NFkvOz7nMKRic8C5LUBBmjPtqE1B4qvCBRzNWQvX+CVfpF9MF2KnGVP2FIuyqsGVeSles=
X-Received: by 2002:a05:6512:2250:b0:553:23f9:bb37 with SMTP id
 2adb3069b0e04-553af9a5b4cmr656368e87.40.1749811275263; Fri, 13 Jun 2025
 03:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <CGME20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1@eucas1p1.samsung.com>
 <20250530-apr_14_for_sending-v3-3-83d5744d997c@samsung.com>
 <20250603-whispering-jaybird-of-thunder-f87867@kuoka> <d42a8c49-7ad2-49ef-bd9c-1e3d9981b58e@samsung.com>
 <e5a0bee2-ff74-47cf-ad2c-0c78b57ae6cf@kernel.org> <a6a29e58-8613-47f0-9e5c-d125da7ddb49@samsung.com>
 <cc4dbf7c-e023-403c-88be-4691f97a0ff0@kernel.org> <c7774790-07c3-469d-a994-9e84108ad21d@samsung.com>
 <CAMRc=Mexq9ThfG6jZUbs3wYDA9UZN-+pHnX_Y-7WO4ubXvEuCw@mail.gmail.com>
 <ad6981eb-f53a-4a7b-90bd-2e2705bd0297@samsung.com> <59cc6827-1602-402a-9279-96ad6285cff4@kernel.org>
 <e5d3d3b3-7ada-476f-9558-328d3d316088@samsung.com>
In-Reply-To: <e5d3d3b3-7ada-476f-9558-328d3d316088@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 13 Jun 2025 12:41:02 +0200
X-Gm-Features: AX0GCFuR8VJK4btiZ7nnnlSFNivWr2LgUYbi6S3FuFypHNtbVFAa-18d5mDtat4
Message-ID: <CAMRc=MeVopfshe02MmYQQ5jS9oUKif4nR97WU68-nsVgCLG36A@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] drm/imagination: Use pwrseq for TH1520 GPU power management
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Matt Coster <matt.coster@imgtec.com>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
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

On Fri, Jun 13, 2025 at 10:25=E2=80=AFAM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> > Why? You have specific compatible for executing such quirks only for
> > given platform.
>
> This is due to how the pwrseq API works; it constructs a bus on which
> provider devices may appear at any time. With the current API, there is
> no way to express that a provider for a specific target will never
> appear. ('gpu-power' is the generic target name, and of course, more
> specific binding is handled in the provider's .match callback - based on
> the compatible and the node phandle like discussed previously).
>

This is by design and also the reason why we don't expose a
pwrseq_get_optional(). If the driver calls pwrseq_get() at all then it
expects the provider to eventually appear or will fail to initialize.

That still doesn't answer the question: why can't you have a callback
in your match data which - for this mode only - would call
pwrseq_get()/power_on()/power_off()?

> For all other supported SoCs, no such provider will ever appear on the
> bus, and the current pwrseq API doesn't allow a generic consumer to know
> this.
>
> However, your suggestion of handling this with a platform specific
> driver is a good path forward. It would still require a minimal addition
> to the pwrseq API to work. For example, a new SoC specific driver for
> "thead,th1520" could call a new function like
> pwrseq_enable_optional_target("gpu-power") during its probe. This would
> signal to the pwrseq core that this target is expected on the platform.
> Therefore, when the Imagination driver later calls pwrseq_get() on a
> TH1520, it would correctly result in either a match or a deferral.
>

I don't want to use the word optional. I think what you're thinking of
is a kind of "deferred" get where you get a valid handle, use it and
then, the provider eventually arrives it will get attached and its
state aligned with the current state of all the existing handles. I'm
not against it, it sounds quite elegant but there's an issue of error
reporting in this case. We'd need a notifier of some kind so that
consumers could subscribe and be notified about errors happening
behind the scenes.

Bart

