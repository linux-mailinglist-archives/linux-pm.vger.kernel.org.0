Return-Path: <linux-pm+bounces-28973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA85FADEE34
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AF64A1F56
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999002E9EC7;
	Wed, 18 Jun 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kKh2KMHo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A3D27E
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254217; cv=none; b=tlYin/9mUmc81jDJK3qRNpHEk/AczoT+aibnZJDZOWO4FxJYB4E1NBHKe8cBMJd+PXl0u1ErfbaUQRTDaDNuWtA54zVa1ZJ75nJ2sheKNkuduzXi315r/j4llBz6HW4HI66BgLiPcZ8hH/EMbgDrYUePrvv34wNV07cR+qog9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254217; c=relaxed/simple;
	bh=DH2TdO4qlgMmdVZuOlcVSevdsjnZbtIfQYEMA25f/cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyxIby4lsN3WY7td2RSwsQC/QLFBukhrZzSgXXDLjBCBvCMa9hAqWSLD+3I6Ir53tJ+q+nS1TlTRDURXo63QTsHtuKRHAYwcbo6jSUFijXB4lsjnX7p0c8cslyRI9HNigbxbFj6nSg4w2QxtDaPlObK+jHUm7nqeLLHfHLIo3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kKh2KMHo; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553644b8f56so7140224e87.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750254214; x=1750859014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH2TdO4qlgMmdVZuOlcVSevdsjnZbtIfQYEMA25f/cg=;
        b=kKh2KMHo994rHvJocvWhAeLiVF/fGmSnZRvhA0NWsBYFYfx1GceR/YW5C7UTkojr5p
         XlBAVToAiws+V5ge57oA21cVcb6NUtpyL9HI/RNfdMl1//ol+/3QURhaielWZI2ugGEh
         JQp9VUezFzbbDkHzEfX7scfR5c3rDUYBIQAGbXZFYjBtk7LPiIHvr0lWGN1pbY4puv5V
         ixT1Smfd34bS3DA8WWn1S2Q5XW9+pGLCSvN1JuHIh1bpiK8kQPwwLuKnXCYDo360GWti
         D0teN6Z0SoGXh/XK1cVzx55XU7SVLKMYgEYgZKoxhO3TC0TffSELGA5mGeoQSgO5PZrR
         abnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254214; x=1750859014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH2TdO4qlgMmdVZuOlcVSevdsjnZbtIfQYEMA25f/cg=;
        b=gtiRo8RL9wFBK2o3NCaICbHE5HjKSLRI6ymx9YOWRy6iG+3EZZP+ZB+0vyt2BHqKMU
         Au/QzY/F6le6g1S395SkMhNZJF0RlAoHXwL9t84jxbxhdyN/wKnOKvUCXwwFKRzvor56
         2ULSzratfDiju+Tg2BSTNk/nPOsPj6/3PwgJxBZh/DmZ/A4J4gZZzszeW+rj6XeBMCOp
         ikAzbza6DLnnsD8h6nVona2v9uHXhCH/KyivJpyX3HvRjWe1J1gfGlLUdeN+q+yVdM/c
         8gu1pWcZ8AT+1i131rEdLKnGLpd6EsXQlVpJ9+NDO9JEhaCxZlJc84AMZ5Ia8Hbc1iVT
         yFfw==
X-Forwarded-Encrypted: i=1; AJvYcCWS/lPFDiBhBDepxLDdbpwWukQxxwg5Q1v7CERtKDCge5RmU5LVliJX2PfV+9zmlkN/sX4sTr3G9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0S1qasVp5T2uRvmTspX6huT7EpHSaHas6gGvatQ17JF08n8e0
	5xDddv4HhV08HIH8p4611vgf8746k7W4E/EVA2mbyWbFvIeGHFmFEZ0cS824c3VoSSATxd3KwSW
	EUEkttrux9tUP1Fl97Yk2FNOUYawcPQ5tl6ORphkc7w==
X-Gm-Gg: ASbGnctpbXgTFBV9qbrWwqosfzISWc/piYSgk6GZHk5Fx3dywKg0kZdWAO6kRHVumFQ
	01OdD8wakPvYD0iqf2irTStQcIzC7ravmdCwLICAjthye2S2HPx9jkgcYzU3fIcP4kgZDWc4UjZ
	K/UwjOY1vTZdOguCoHiWRgwlD4zMcIslZolN9woCXXc2Zcc2RacynXlCM86aNH5pRUuiFnf8TeN
	w==
X-Google-Smtp-Source: AGHT+IHftNw+Eih04FWqkzxlxHZa0pUq9QbEcwUOmlySQIbB01O/3QL4rt3xwi2A6yMgr8Es7P1LaWGFLlQxbE/YI0U=
X-Received: by 2002:a05:6512:39cc:b0:553:3770:c912 with SMTP id
 2adb3069b0e04-553b6f42a3fmr4662087e87.47.1750254213943; Wed, 18 Jun 2025
 06:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618102233eucas1p228b24f58e4cb3d15b0f273530b582cea@eucas1p2.samsung.com>
 <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com> <20250618-apr_14_for_sending-v5-7-27ed33ea5c6f@samsung.com>
In-Reply-To: <20250618-apr_14_for_sending-v5-7-27ed33ea5c6f@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jun 2025 15:43:23 +0200
X-Gm-Features: AX0GCFsy7p_bfVyodl4lMK_1wlqkCV9i-ffK-YbNgbQ1QgrzZEcf4YhKpp98eDM
Message-ID: <CAMRc=McvK2Og1kxDmN-5YW0UHxe-EEXPg88zh=oVEvSvCZ+-EA@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node
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
> Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
> TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
> the GPU using the drm/imagination driver.
>
> By adding this node, the kernel can recognize and initialize the GPU,
> providing graphics acceleration capabilities on the Lichee Pi 4A and
> other boards based on the TH1520 SoC.
>
> Add fixed clock gpu_mem_clk, as the MEM clock on the T-HEAD SoC can't be
> controlled programatically.
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

