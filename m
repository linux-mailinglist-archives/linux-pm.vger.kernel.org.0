Return-Path: <linux-pm+bounces-29347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB1AE4714
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E35E1656CC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A183525D200;
	Mon, 23 Jun 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VAIC1AEG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0B225D1E0
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689188; cv=none; b=tywX5F+OGtedLk7uYylDeQfac/D+UGD+ncRTTQOAoJH/km87hCVO+5Z5AuF5bI+jxUWwkse8EIjJXNuaEVqOYlKOM4VWDPYICFRoZvko5Eb1wUBz/GkMaGL9yCBC9HVvSrazNKnHjLlelINsux92wutE6Vag0BSGTRqUHnD3YQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689188; c=relaxed/simple;
	bh=x5KqFZXgElR9++LB0VjgJyofXv4fHihwvsOF6Nt7N04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWf6W0UCxBJlHPBF4pAgv45sWJc5L9aSyTcpyQKK3taltEOPuDo89BDUaIHGtqvnLl3JHdOkz0v8O4wHzpGvwkzcvVVB+FsQZSMMBTGorWfHQ94RwF1OZB9/2j9UyGcToP+UsE04T1AMsvfhubUnQdU6FDLnMFGSrnAZoGlc0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VAIC1AEG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so5869317e87.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750689185; x=1751293985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9kmviqp5IY6ttItDCr2Op9/HvBDwWl4i3kTfEm4FXc=;
        b=VAIC1AEG8pF4R3esDtb+tbTYQEDx6E7lmH3uOjhL/oZibdgk45ASnQu5loRGzGghL9
         bZ296/ard/dE1dGCopcnZ+G2TPUdkRBw5ALMUOQAygGXcYzYpELG3rdFKRQcdomi9heR
         uGePPDXaXWWX36xKs/sEG80LZh0QTPVuwOX4+7ZIBmgvMdO6ZCGAUiRpFy36/V7T48nU
         VSFewVyDmuFZUFoLtPK77AfqZGmYccB2clGYz9OEkekoV1arIOgn6g/x+Xs5Q1wmbKCJ
         cSVSHwt3gUDwMuHFA5lVvuGyim0cE0FiNSbe47PtHOniwzHJv6x3uQNyKc5wD2l1QWtr
         8UYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750689185; x=1751293985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9kmviqp5IY6ttItDCr2Op9/HvBDwWl4i3kTfEm4FXc=;
        b=joqXMaQFfwfUUT/0HVap7jqreVq6yVtonFEaYwD9zmTzHJ4iS6tt/D4gwxgINqYl5M
         yCYSVux3FhGtySZWAOcz05FjlOSqNTTO0aq5d7aDdVdt7oyKJcBx/Bu6lJu+XZ+4VBDS
         vdZg0vJFzdplKyEz2Sx1at74t4JdqN8HJF7K+xXNFX0x9lBETFHblLxE3WG0v4dnyvT3
         dpaqJc0sg4RRbKYlx5ft9IlkMCQq3OHQChFAVY7nmEKBDprymfsS+07EZE6tgkig+1pC
         ObEHf2rGNHL3lot5E49EyDsKB5oJyXfieeNwj2Z6I1VlBNoRNCLpd/LBWmIoIUNAF7Vq
         rMdA==
X-Forwarded-Encrypted: i=1; AJvYcCVd55TnHWDWGPb5eIpXr9BkJUyYjzUsNUzLVimRRdUP+98U4d3ZkMwcQ1eOZScipxUI+9KfbCbBGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcxhhRfB9ahv1EWZ2XTigqAgCQaMlquQnDE57jgPerZGsT1qVI
	G2hEXnODEgKIU/tszYxJKgtk+LQBqjfUIXZGMyAyGNNjKwfPyG9KT3NO/mdul65I3SpnzxmYeH1
	Y+lG9fVH5/lb++vYPaAjNMoAt6+4QjwTbTatltUHI+Q==
X-Gm-Gg: ASbGnctzfbQsIlY90fdagGl3ZLBjtXJa5MyE6H5fdZNqpix4lFtUQ3m5/3zKXDvJK+9
	i119gD/tpPi5RF2J0b9NyxuzukQsUnHC2bpc5xrlEkEmo29+bGzEL0qqlvLyJnrjCgWdAfA46B5
	fZW77j+4lrXep6dIO2gj5aWt3cR/6kCfs2SCcQqJflmoFjg3AZdSnwi0KeomIwW3DM1DdvpEeyp
	g==
X-Google-Smtp-Source: AGHT+IHy7lPbB51UgKZbeAiEHWJjzs4pV8mJk0NbuirPhDOStHcXQ3Z+f7X+tD5fIjGZbRD5DTCBFLexuzsXjZ0eBBQ=
X-Received: by 2002:a05:6512:3b25:b0:549:8ff1:e0f3 with SMTP id
 2adb3069b0e04-553e4fdf72dmr3670967e87.5.1750689183720; Mon, 23 Jun 2025
 07:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250623114430eucas1p2a5bb2bbc0049186ff25e1b3e1a131ca2@eucas1p2.samsung.com>
 <20250623-apr_14_for_sending-v6-0-6583ce0f6c25@samsung.com> <20250623-apr_14_for_sending-v6-1-6583ce0f6c25@samsung.com>
In-Reply-To: <20250623-apr_14_for_sending-v6-1-6583ce0f6c25@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 23 Jun 2025 16:32:52 +0200
X-Gm-Features: AX0GCFtTbdiml00OQLqQ03QSeuySTknlMk23hbdQ1cT1QnS7KP2eYmI1IjWfLlA
Message-ID: <CAMRc=MfPLZ7oMVjLv+_GMoC8X+O=k+mMrQKxELho0=+Z7=HApQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] power: sequencing: Add T-HEAD TH1520 GPU power
 sequencer driver
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

On Mon, Jun 23, 2025 at 1:44=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> Introduce the pwrseq-thead-gpu driver, a power sequencer provider for
> the Imagination BXM-4-64 GPU on the T-HEAD TH1520 SoC. This driver
> controls an auxiliary device instantiated by the AON power domain.
>
> The TH1520 GPU requires a specific sequence to correctly initialize and
> power down its resources:
>  - Enable GPU clocks (core and sys).
>  - De-assert the GPU clock generator reset (clkgen_reset).
>  - Introduce a short hardware-required delay.
>  - De-assert the GPU core reset. The power-down sequence performs these
>    steps in reverse.
>
> Implement this sequence via the pwrseq_power_on and pwrseq_power_off
> callbacks.
>
> Crucially, the driver's match function is called when a consumer (the
> Imagination GPU driver) requests the "gpu-power" target. During this
> match, the sequencer uses clk_bulk_get() and
> reset_control_get_exclusive() on the consumer's device to obtain handles
> to the GPU's "core" and "sys" clocks, and the GPU core reset.  These,
> along with clkgen_reset obtained from parent aon node, allow it to
> perform the complete sequence.
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

[snip]

> +
> +       /* Additionally verify consumer device has AON as power-domain */
> +       if (pwr_spec.np !=3D ctx->aon_node || pwr_spec.args[0] !=3D TH152=
0_GPU_PD) {
> +               of_node_put(pwr_spec.np);
> +               return 0;
> +       }
> +
> +       of_node_put(pwr_spec.np);
> +
> +       /* If a consumer is already bound, only allow a re-match from it =
*/
> +       if (ctx->consumer_node)
> +               return ctx->consumer_node =3D=3D dev->of_node;
> +

That should be `!!(ctx->consumer_node =3D=3D dev->of_node)` or preferably
`ctx->consumer_node =3D=3D dev->of_node ? 1 : 0`. I can amend it when
applying if you have no objections. The rest looks good to me and I'd
like to pick it up into pwrseq/for-next in the next two days.

Bart

[snip]

