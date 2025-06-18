Return-Path: <linux-pm+bounces-28970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A55ADEE22
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3E14A1306
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ED827E1C3;
	Wed, 18 Jun 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Gvqj5sC1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013272E9EAB
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254160; cv=none; b=OXznUuFUpYuymS43aMp0b7P1FyqeX/06gC99RtGbmlXMBrg8nJCOOIRQkhEitmAsv2iTOHJcfzKxqY87kJds8txcCL8LgPOIq6PKyXYh/g69mEWblVHAY6KbvaAG24QTeMSYGQWtQFtLKyNrCl8FVTBsOzQkiZXUsrjt3DQV23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254160; c=relaxed/simple;
	bh=eEO+Aw2g4Ye3zeBEqfCg7cLkZgwkmnjuAHAb/18yzBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7SFhGBV0LSgdMdaFJ3a7YsspokpI2yQ2/bScrWE0gcz+JXdaJexIxnwzLRzICZe6Xng/xpMic2DcPS+8joXvWyz8dP6FKHLjHcg6AM8F/crJZvYKtkG/DtdPUBaoLwOMhba41FMY/RF7qn9mwXJzdtwqa3Zy+lar5IT08IxTJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Gvqj5sC1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235f9ea8d08so67661415ad.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 06:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750254158; x=1750858958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEO+Aw2g4Ye3zeBEqfCg7cLkZgwkmnjuAHAb/18yzBw=;
        b=Gvqj5sC1Fy0ke6h07ca6fdZDgXIrjDt+D0nDoWyhlXssNHKYtvdcuoeTxXh26WW/uV
         cq4ibyei8wFpWd9/AJRSDOl2VsQV5evLANN5JjCdhbH5NNo5L8MuvRfAxGQqMG2fNixW
         GcmSHwUr5oaVgvWQ0dlml+SW8mWAkn8wY6GNnNnzV7WNuvQHBSTwFQeRvGuqmjl5fyG8
         LjT0hINFaFOSv8Gj7ha4o3sNQf2M2OA3d/b/AA5jd1wn/FLOdhtyYPh6oVXIgQiES33L
         0C/zNe7ZsV2Nq/VJVudFJKykHsi8MIvbmEFXiuu5R7YFyCXAmAHmod8Onpf4Su8TGzB5
         Z0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254158; x=1750858958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEO+Aw2g4Ye3zeBEqfCg7cLkZgwkmnjuAHAb/18yzBw=;
        b=M70x+fFOYgVqIBYl/y9/lHhDetKJLLPTuQ6eb8LNqHee5BWsB6cgIz4qGNDKFlhJNE
         F1JkV4zKyc+/6g5JtnaNwDZ5SIK3Q0Rau2ssKwnm4D+yRK0ba/jlE4qTaly5n1O4se1y
         xUyMtcenwtm6SIG731pKla/JOr7LfWkQtJt21eSIeZswh0bzkLCt3aQsWx43dwbGwJBN
         VBSsugz6aD4YwOv6ZEb0n10/5PpxV2ZBVng8v8GeZLEEVWeZMRuz8AeLZqXMDMxyTEkw
         X20KEODix2ZHk4mRT5H7QDBenJgRNtggUDNO4Tf7IoBsUIAKOK/OMgcc/OHClgiaPiyv
         CsXg==
X-Forwarded-Encrypted: i=1; AJvYcCVb5GPKs123mxTYyK5El1lIwQkEPNDSlNYTf0LZ/ylfASvu7VpIWTNbYd7hhwBCiwxFu79dthiH9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3eN+sAdlBgUFofRqayJRMAqauxkzCCH0NnUy4IH26h8xxwzxW
	c8K5xE+rh+vG2px1nBMDo//9gFu+DKnE0eYR5ZeF+pexB8oR93xpVMrDwIekRI1QeOsl52bj6hl
	Bka0DnFHyoPEO357ivOcW82sKNDvIJ5wPsomqp1EFfA==
X-Gm-Gg: ASbGncvyufMb58eRynZ+awdSmPCDaEicSswmJFUz0Sr6rtJB0EJC0rAlTbG4KVQR2MT
	FPaKOiKbYxVi8XwBsHGLHpuGmygjoTQfrS/OYbwSJ2llBNyOJ8ZrLF6q8U0w1+SG8tcS22TQj6e
	a7sm/WsUsXiXZMJK8Zd4GfVZuvjsO0sfFFOx/r3pluQGFpC3IHugFm4YQUsozpoN/3zTAvmlDaz
	w==
X-Google-Smtp-Source: AGHT+IE9RRF0iBcbNFXcUb8SkJRKabvVWjmiE253LTqxfYGXwndQn6/QT3ohHBsxRY1SrMjuBvVMrN/uQK3qBsQXw3o=
X-Received: by 2002:a17:902:cf0e:b0:234:d7b2:2aa9 with SMTP id
 d9443c01a7336-2366b1221femr273087145ad.29.1750254158312; Wed, 18 Jun 2025
 06:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618102229eucas1p2a5d38013ee52a8a4a10d43449073e79e@eucas1p2.samsung.com>
 <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com> <20250618-apr_14_for_sending-v5-4-27ed33ea5c6f@samsung.com>
In-Reply-To: <20250618-apr_14_for_sending-v5-4-27ed33ea5c6f@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jun 2025 15:42:23 +0200
X-Gm-Features: AX0GCFtH0tHQpQVePKw4GRZe0_n4DXj2kfns9aQPVtqgBIhjJI4B39bCzPcceGU
Message-ID: <CAMRc=Mcv6KJOCypOHF-KtFk6N-Z=eoMCqH0KuuUND=8J1YvrEw@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] drm/imagination: Use pwrseq for TH1520 GPU power management
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
> Update the Imagination PVR DRM driver to leverage the pwrseq framework
> for managing the power sequence of the GPU on the T-HEAD TH1520 SoC.
>
> To cleanly handle the TH1520's specific power requirements in the
> generic driver, this patch implements the "driver match data" pattern.
> The pvr_soc_data struct, associated with a compatible string in the
> of_device_id table, now holds pointers to platform-specific power_on and
> power_off functions.
>
> At probe time, the driver inspects the assigned power_on function
> pointer. If it points to the pwrseq variant, the driver calls
> devm_pwrseq_get("gpu-power"), requiring a valid sequencer and deferring
> probe on failure. Otherwise, it falls back to its standard manual reset
> initialization.
>
> The runtime PM callbacks, pvr_power_device_resume() and
> pvr_power_device_suspend(), call the power_on and power_off function
> pointers. Helper functions for both manual and pwrseq-based sequences
> are introduced to support this.
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

IMO it's much better this way, thanks.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

