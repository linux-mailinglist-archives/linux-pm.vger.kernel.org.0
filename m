Return-Path: <linux-pm+bounces-28974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9937EADEE3B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D975F1895720
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5B22EA147;
	Wed, 18 Jun 2025 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ycs0YwPw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B52E9EC7
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254290; cv=none; b=B5qVfK4asbCN6chC1SdW09wykJyCPPodrCVJkMoiKWituSGPgFYO+mCkQXz6QFso2JY+ptMI28Q/nXu0DvskxvuSuJMqrMlH3ITZLwfT9nIg2frVL2Hx0u97/AMS4mXOtTO8Nkp7zzCQi5biBCdhgsuqmETvy6IAC7vtQ19i/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254290; c=relaxed/simple;
	bh=9Pn5+pieU9S6yQFIfZFNE3Sm0wbJoEWVjuv8ZUiurXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGa4oqurE3hd8DtvYhpnJEUaLm5EovI4XpsMe/t70qSOCP7ynTztX+K5bIhrLMOpPHe/avkfRJKc1LaoNHs99k1YyzVKRClHlp/RzDe71D4opIheZ86HUV3dI8/mkoJuRmvVmcpKJVrhGNPyC+KaUwuQVjXyIBjfA2ShPWBbdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ycs0YwPw; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso4199297e87.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750254287; x=1750859087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOnqA9glXHMp+wjKPZ26EK/2be4ewo0aSocx50Gz+sQ=;
        b=ycs0YwPwmoUCCg6YrRaZicxvoDp1R+QK1yYapHRstVkUcfRI6u9whQOUnbDu4SWN52
         j351ysMD2+kNQcgeW6qtMDXvMG7sEhfJ6Apfoc7AtMxTNXOgk5DbfGHdgNHzVc4HxkYf
         ZDemfyB+RBkmMBY2Tcpj6o9SELDk4ADlTq1q8mj7oEgew2Bmpia9FVpCUxrXF1h45mIP
         Eb22DFO8P3OULz0uOsBZNxTiCs+I83kVXELiUmpxegeSAdbbsQUxWmkFeSQYp8egL2W+
         tuz+iAcZfZqVhUrXQZ7m8t+RxcZzsiFp1NpP0rDGyWRhVzie/du1/XSWQSbxpeqRu8kA
         FNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254287; x=1750859087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOnqA9glXHMp+wjKPZ26EK/2be4ewo0aSocx50Gz+sQ=;
        b=l0GZhlmvGa7eIZ6ToUcuhTar1i2vEtxfXd3cZFoiW2xbya2MXPB74D9OD6koSK7nfv
         Uu6F2+7oZeR0uWea2o25psCFk8RmFIadmqrkX2+UmAELSHAHe6wPhGR5VyKHAzgRUhlC
         CUmjhf5F1h40NIZ8K8HIBX+w7Sk64/MfAAkCdQQOjQSPdrIcUZBvgQ3byrkdzYLGbNbO
         dEh3/ofQ/iJDuaojAbhJDSi9dS8pdBSCQGXv/x5NL9pvtD0t98HjaSSQN02TnRi92bCy
         sfITjvMfkoqhwHL1Q2q82Tc0tPix0L4GpaVJBqxTVgbUbCPlq+1wmSrCTkz/O7KnoeQb
         wd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVxLE0YN924jFmCCHX+wDU0oLruXBlDm//J/nbl9Kx0aIXQ/Ux/uxNbJ2yzHTIezRZ21bDvJWylQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5foc6c1jKfgPXhaqLq3GYj4SQ4hK3v4nmQ8H951z0NDAWQ707
	So89yDmtU2g0YGHJhzumZOgaYE2/5MpyqmLQN5tfU12g0j/SYVtMtAufn9xLvVHqJ0+uot3xbcB
	+Kt2pbtPo4SsEMZRYYnza+p/k/aEdWWQ1BnU+HGfxWQ==
X-Gm-Gg: ASbGncvzpl0U/w82Q2R2QxlacDYUiPQhnkeZgMBq+h/xJ0fe7FZ2blZNUTKDuwA6se3
	lfvL1mFjNiTn/OzNG0f2W7Cs3PVgnXWz7NLv7RD8vpmYCabqYwDVVsW57fRZMcFw5q3ASJ9MDmF
	VFN4VlvVoxEe3OK6tQ3vQ6PWbl6pAXbZeTZUQ+FG0juPdKLasdK0GPtrxrJ90p+Nin9qkOaoHsz
	w==
X-Google-Smtp-Source: AGHT+IH6Ld+eVfdvk23fMVj2Sr97EjUVBPbCt4xJwvj5ob6oDsk8hpgZs7OsgvSQaNDiPWolo67AHI2eB2C2BKgawwc=
X-Received: by 2002:a05:6512:3ba5:b0:553:25f4:695c with SMTP id
 2adb3069b0e04-553b6f4470cmr4999420e87.50.1750254287228; Wed, 18 Jun 2025
 06:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618102234eucas1p2a1899b494c5ed75e0f39ea517d81c81d@eucas1p2.samsung.com>
 <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com> <20250618-apr_14_for_sending-v5-8-27ed33ea5c6f@samsung.com>
In-Reply-To: <20250618-apr_14_for_sending-v5-8-27ed33ea5c6f@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jun 2025 15:44:35 +0200
X-Gm-Features: AX0GCFuxF3RhQHueJgJf3bU829GFZMlCkCu1kP_wz3N4DTe6r8qi2RcA-BS33s4
Message-ID: <CAMRc=MdXmtZ3EbPDSGQeVaH40oZS7yc8MSMO2TbHza+F2HnBng@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] drm/imagination: Enable PowerVR driver for RISC-V
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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

On Wed, Jun 18, 2025 at 12:22=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> Several RISC-V boards feature Imagination GPUs that are compatible with
> the PowerVR driver. An example is the IMG BXM-4-64 GPU on the Lichee Pi
> 4A board. This commit adjusts the driver's Kconfig dependencies to allow
> the PowerVR driver to be compiled on the RISC-V architecture.
>
> By enabling compilation on RISC-V, we expand support for these GPUs,
> providing graphics acceleration capabilities and enhancing hardware
> compatibility on RISC-V platforms.
>
> Add a dependency on MMU to fix a build warning on RISC-V configurations
> without an MMU and enable COMPILE_TEST to improve build coverage.
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/gpu/drm/imagination/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagin=
ation/Kconfig
> index 5f9fff43d6baadc42ebf48d91729bfbf27e06caa..48fd31c031628c70b1e095227=
1baccf7f4694810 100644
> --- a/drivers/gpu/drm/imagination/Kconfig
> +++ b/drivers/gpu/drm/imagination/Kconfig
> @@ -3,9 +3,10 @@
>
>  config DRM_POWERVR
>         tristate "Imagination Technologies PowerVR (Series 6 and later) &=
 IMG Graphics"
> -       depends on ARM64
> +       depends on (ARM64 || RISCV) || COMPILE_TEST

Some maintainers could say that the COMPILE_TEST bit should be a
separate commit but it's typically fine with me.

>         depends on DRM
>         depends on PM
> +       depends on MMU
>         select DRM_EXEC
>         select DRM_GEM_SHMEM_HELPER
>         select DRM_SCHED
>
> --
> 2.34.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

