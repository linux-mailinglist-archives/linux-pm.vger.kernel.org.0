Return-Path: <linux-pm+bounces-36671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E704DBFDED2
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 20:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5EC3A6C71
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CA9337B99;
	Wed, 22 Oct 2025 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieBdq8pv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99F2C21E5
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158914; cv=none; b=XHqCCawK9f1/KFg5m+XbbDpuH6hwzv3yjmyl8Dk4EYCoSoYrVKuGi6OmO8ZLhgNRe5LMhBVv3Sfb/iCCnjw/nBcNFWgkjH77zLtQUu8/28uLMI2VnD/AY5ZBkRzVniaqsWTokbWlAOLkic7tliDaAJnd07qPKIgM1t8oGl4o5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158914; c=relaxed/simple;
	bh=GpNEmyRbzMvBuaISP7zxvW4d3Uw7r6CczLNzpvoENOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vB5TvEZFFpe6Ov/STOCJaTM21x7cSp4gPVkUxbCZUr7atBVJhNxXOauMv282nmzL8WU59UnGWCd/gEYkdix9A6OPGGjNYlnLRrRoKH6ePY7vPXUIdkugNX53YIpg7h6cS0HUQyfOlX2SmKfUe54JZ2yofHPqGnVgNSZomraAzaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieBdq8pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB249C4CEFD
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 18:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761158913;
	bh=GpNEmyRbzMvBuaISP7zxvW4d3Uw7r6CczLNzpvoENOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ieBdq8pvRE1nS0SFFCIsHN92gPwfbSwH/Amo26X++Tb9LkQz0NN70HArBDdzn+CAl
	 8KVPMtoBwvuGPPxogfTi/5u0mgfS5LMdjh5hWHTaYNm8MzYmLFrXwEhTlTgx+lR9XP
	 Ye6WWDlzit8x/N5c48Bjf6Xuk15TdcuMFHZM7q/i32kZ2IR8wba1NyUZf31ZhK+gnB
	 KLl0HIhDg7eLOkQ65ChbGX0JzRqzRh0oyv8dDd3qLQOj3RWgKcFBrVHEBvZZN0Kf6m
	 MgFj4sJ5LPvA7CtWmbSdw6mjEI8zI5JsitKmuRYpX5GZeEpfH3wHfpTPdfqrypzKMP
	 IDOWm4vLkqIyA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c2823c3475so3425a34.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 11:48:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9gfKT6tDJ/DSNA4e60jBK1gP1Jt++NypFKcm1Kw2zXrEGi/7zWHEPExBdvWKcV42F6evm4K9jUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4aKQnlYGZGeYvqhx6ikV/8sP/Czb0E3HItyGO5MpYACfxaDPD
	RWPTFq7n1GhR16iNThuziYWOLEAdmeLWpyWEBk/kbE5UBIo3Tm7y6XdwTtYU5b8AvWp7QNQxk83
	BoK6feqlxxXCGUamneuikaH5PMqwdxQg=
X-Google-Smtp-Source: AGHT+IFqreKa1ZRFVdxF7caUZpo0pSQwSz81KqtRYCr1VGigoVlVUuU2IKHvLBA2pCUDAGqxLCUuuvBzaLTivXn3vzA=
X-Received: by 2002:a05:6808:2393:b0:441:8f74:fd1 with SMTP id
 5614622812f47-443a30c3cefmr9662939b6e.62.1761158913177; Wed, 22 Oct 2025
 11:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-5-srosek@google.com>
In-Reply-To: <20251002113404.3117429-5-srosek@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Oct 2025 20:48:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0is66vO05fbxooRxkn_wAZr_g9Wr-D-RtFH32gNzE726A@mail.gmail.com>
X-Gm-Features: AS18NWBLo5Jfp_0yFmHsKnzWV51EDyEI5dqSfFHYso33h42GmmMhizVcmb9rZYE
Message-ID: <CAJZ5v0is66vO05fbxooRxkn_wAZr_g9Wr-D-RtFH32gNzE726A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] ACPI: DPTF: Remove not supported INT340X IDs
To: Slawomir Rosek <srosek@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.com> w=
rote:
>
> Remove not supported INT340X and Wildcat Lake ACPI device IDs
> from scan handler.

I guess "not supported" means "no driver binds to them".

> Fixes: 3230bbfce8a9 ("ACPI: introduce ACPI int340x thermal scan handler")
> Fixes: 9cf45756a4b9 ("ACPI: DPTF: Support for Wildcat Lake")
> Signed-off-by: Slawomir Rosek <srosek@google.com>
> ---
>  drivers/acpi/dptf/int340x_thermal.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int3=
40x_thermal.c
> index 26522ddfcbaa..7d1308b1f513 100644
> --- a/drivers/acpi/dptf/int340x_thermal.c
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -21,12 +21,6 @@ static const struct acpi_device_id int340x_thermal_dev=
ice_ids[] =3D {
>         ACPI_INT3406_DEVICE_IDS,
>         ACPI_INT3407_DEVICE_IDS,
>         ACPI_PCH_FIVR_DEVICE_IDS,
> -       {"INT3408"},
> -       {"INT3409"},
> -       {"INT340A"},
> -       {"INT340B"},
> -       {"INTC10FF"},
> -       {"INTC1102"},
>         {""},
>  };
>
> --
> 2.51.0.618.g983fd99d29-goog
>

