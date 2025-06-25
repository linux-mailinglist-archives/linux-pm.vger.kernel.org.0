Return-Path: <linux-pm+bounces-29492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F04AE7E7B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E2B07AB55E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 10:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867272877F9;
	Wed, 25 Jun 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bCPsYZkz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F031DF755
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845922; cv=none; b=RsTx9o/+Xyxx8gtiRHv4/EaPfmjKb+X63zWJq6UvK/sWzD7Q3G+fo8lpbxR5DjPxe914d5PZxzfeTfgcosaXawH7Lm1wWBjbWqiFcrb9UwynH0ykto6RDQzbyVi2oYHljnORpUjv1hztghNVXr1D+d1Y8hKWsY+DHA4DqErv+5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845922; c=relaxed/simple;
	bh=6xKfQLYxQrQT0vEeA6XiT41ZdovNWLUZMpAYKaRFfyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vuc96cqFQHQP34zh0baKuQ91evW0zbNDfsgO4V5mAY4uZ9nhSLPIB3rBgUj28Cq55gref298UlxpijFKhWbKHgNTaN1rP4yW1btrgtNuBPF6jEK+z+bPFBRvQR2MwtKEdOFfuI893ghu8zVNsdEk1lMtE1FyUXwHbXqMH3qGF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bCPsYZkz; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e740a09eb00so5004112276.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 03:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750845920; x=1751450720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xKfQLYxQrQT0vEeA6XiT41ZdovNWLUZMpAYKaRFfyA=;
        b=bCPsYZkzDxKCP0SSRmbgL5TySayRYaZ0pIkGeg0Tw7azGM/gcF8xhqoyQvZqpfqzCw
         YkSiBdU5LkMVU2vnvz1EhTWNP4XI0f9XtohuwlX7Dmaa5bListw1nrfFjPwn//SnPnUd
         Cx3jZ+5aWPRWsod4iWsiwXSBh9tRsWmNPufWWeQYS5mdh/wiZHPs7YLYWqZgQBIGAkjb
         GoKKlmrKGg6JTK9zJIz4uGrzP2dUZKEqKRk1qa7taimmDDz1ibKbM+iR9RHYyxC/jCKq
         1XqZNElkCUib93l2JmEnC5heQFF8ahvrxl4hJZCyho/+saNpIhzKliWEi57MRR6Pp7on
         IlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845920; x=1751450720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xKfQLYxQrQT0vEeA6XiT41ZdovNWLUZMpAYKaRFfyA=;
        b=t/BzPS5aUhXH/s0NrRM6HWH++Eet2RMQUoTy8JhOWLF5KARkaeJjVtW5QsC9PCIuN6
         ZiIjf5P1u1sIpXlACqLSzHcQjWc9EYosvCkqWrVcR4fRz/fxFcMSOZg9p3x97sstb/lx
         sleaHQ7myUamweNtNxm3/TlQr0rraGXIOIFrbZ3N/FAuqDvI10CLuw+lKNCljDq2JwqQ
         ntr45Y32OxB6KHqRyezijoXVHB3t0tFdfFxjEPeXZSlBqHdKCQSbtJnjf65pcMx2LG+V
         xI/LoMV32MSTQ3odq3cwkSUZkyfbG9iiqnF7qTkHvaHkmk4+s3RCX0ZpY64Ua88OqeIU
         gwOg==
X-Forwarded-Encrypted: i=1; AJvYcCVtoH8s39Fi4yP1EvY1Hske+d/amLaS6uO4rLEDCnxc4yFt7lu/K/3apdOQM+S2zXJ/PJwu2Iatlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9jDDxsdFhErpcavd5s4EPk+AH/QnllrGDJhs6Z6XX4Wl7COO
	2rtiLzwSE0/h8bTbgcrAMWjZAW9DB3hIPABm4PjJ5bDc+kAFLwknc2kA2sLZF6MPiiqPiqgquei
	ZyqQCjFZFFKvKrnT5KrzsciRczFqYaPp7SrTjrSi0DA==
X-Gm-Gg: ASbGncsecP3ErrEb6wZQJC6W8uMfl/NdBeZbKRnc+Lpm2hnTBw6rwPdXYbm/XfuWKxI
	7uVB1nIi/F0NuIpppXZkpjTEJ1BjHi6QMCzfdgaEoQ4hNgTkc4dVs4+cLqBsPLdGvAgD6Pu8w8S
	t+ib/I9ixxmldvID7U5nahkECq17vPho6xahajigmMkSM=
X-Google-Smtp-Source: AGHT+IEJrS2tphZ7UMREypIClsxlSmABIBla9pP6cK7b0bEY7VGBFV8Zh4V9DmKzTV5zBXNgMqCqlhwI6mHWvsv490U=
X-Received: by 2002:a05:6902:1703:b0:e81:9aa9:88d0 with SMTP id
 3f1490d57ef6-e86018ef2f7mr2643332276.40.1750845919338; Wed, 25 Jun 2025
 03:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624141013.81358-1-brgl@bgdev.pl> <CAMRc=MeKfWsf8T1tJLdj=+7aq0zGpQ07pHd2Mz-Y=Bwae0sAbw@mail.gmail.com>
In-Reply-To: <CAMRc=MeKfWsf8T1tJLdj=+7aq0zGpQ07pHd2Mz-Y=Bwae0sAbw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 25 Jun 2025 12:04:42 +0200
X-Gm-Features: AX0GCFtiYC7fRWb7mfaCIbLmQje2hb4McQcP0uGJDzj7bHa1BymRJdIDLbPQ_rE
Message-ID: <CAPDyKFq5G1CDL+VJxuzWZahZwUM0mVQJwU_WYYqNuDMDE3H5TA@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable tag between the pwrseq, drm and pmdomain
 trees for v6.17-rc1
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
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jun 2025 at 16:40, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Jun 24, 2025 at 4:10=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Here's an immutable tag containing the thead 1520 power sequencing driv=
er
> > for the drm and pmdomain trees to pull from.
> >
> > Best Regards,
> > Bartosz Golaszewski
>
> Just an FYI - there don't seem to be any actual build-time
> dependencies between this driver and the rest of the code that uses it
> (thanks to the aux bus usage etc.) so Michal, Ulf et al: you can
> probably skip the pull if you can rely on this being available in
> linux-next for run-time testing.

Good point, I am not pulling the tag then!

Kind regards
Uffe

