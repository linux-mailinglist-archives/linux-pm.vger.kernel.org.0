Return-Path: <linux-pm+bounces-36200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141E6BDF2CC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 16:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C78A19A2EEB
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC052D543A;
	Wed, 15 Oct 2025 14:54:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77542D3ECA
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540049; cv=none; b=AjkhQ6+TjqOWbWMVPOHBG1LaduR8qSUNVZYuC6FYcDZ/VWXEigBcTwunZlilb1FKsa1lnOgEuTNor31e95t+mVVcKIF8d6fYMgPgI5T58o46rBKy2HlPfM6S/VSXw9yCcb2GHeqSaczcoa06o43rjcTrJTb2JHHcx7rVeEv0f/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540049; c=relaxed/simple;
	bh=6OUsLxRkye/V5CLq7E3pRBp04R4Pl/s8hSmjTBcuHj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V657lssw/fwIkkfGrsxATG1FS0t+60CRwTW5a1OLWA4d4COed1MBL7Tm8txS0EYShrjFuRTaFyahvIEPnLbr5yk6fmQeq23tD+noPqv3WcRMIjZKutcVXMv0nHsL6Ny62m5gtG7IJRybAh0ZTFVbllGCKt65yNAswCPdsmQZnms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-90f6d66e96dso1720294241.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 07:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760540045; x=1761144845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buS4UytUzJOTO4hyhwviAO+sxk7bCqxVtv+iDQgoWO0=;
        b=GRnfSp1K7RBPxywvorTuD1bvFz+wrHgaicgsKidGl/bpkldKM8MAEURy+0yXFl88+v
         U38u+xqsV1DtzXkOB3gNGJRO9CVZ62Gbv0ytzcK84lgkGRPVCqqJVAwHkv1FBeyP85hP
         j/81udYNvJO4Hx4o4QvdfOIWSpsHuaa6IyqeH81r50FC6qIOYUGC3R+jLqwB37MyBkRj
         IyT9veYwHIHn5b0TW4ZSOkqpl6Q0gt+pyxRxnu5ho89Qtpi2G9wDTxak8/QpTJRLg2Jd
         9gldxNAkaI0ZDN26ClMaz+QVtPRkhv6P2TsDGoZ6bprqDl6+4CyFoaHSAtUXfcYsB60a
         2z0w==
X-Gm-Message-State: AOJu0Yzr/nLQ0d9U4vxtXCnEH8pnpACU83fW7Qcukg0L9WhPEMvl2zqh
	1IqNYGICmQJijNKmjBwp1JRV/n7AveQgTdw/vySsUiTRH5LoVogHxPWSWg6eFfa3
X-Gm-Gg: ASbGncsnm+MeBzYjjDPH/2wCsM30yfOei6TjGOJwZTjO0DEqAIuQQt60Gxeva56s7Fx
	0LMZlNqk8YrL2w5bgxXemjTLAiuLokfhqFw02URZtYoT6mPVx+H+MS8elXbvF1FtjqFwci52wSt
	5KG0KCJB281Zn3lx8vo7Eygxe29FFbW5mAvEa+CjACV4Gb5ROe3wZ3Mgya+fiU3txy7HoOnPPA3
	l3zJKwZKM7/kmkzs+77+RhcBwg8ZgQikrKv+w/+iTjxvimFLZOVbF3pjNZb5qSwNM8JFDaqRfPX
	CUl1L6KZRjFVm/F+eZJ55gVe8AZXUWnHEabW2dN6FY9k5UUaSCLMw8OGzBAfDsQawldK3MOMLnM
	974Jdb9qr3/ZEt/RpCwJ5z1LaQO25Nu7reBc0H9ruySzrOD6F9jQUs269KAEjjXUE/zb6Ifvm90
	A4EkE=
X-Google-Smtp-Source: AGHT+IGdlnYB7FK3fGVmhyZd68ot9swjBTAB6u2fl211IL0PKyz+c6GzSuUWhK9yudIrdNpT8n0FAg==
X-Received: by 2002:a05:6102:c09:b0:5d3:ff03:8f6a with SMTP id ada2fe7eead31-5d5e23d364fmr9694243137.30.1760540045125;
        Wed, 15 Oct 2025 07:54:05 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-930bf6cec14sm4517007241.8.2025.10.15.07.54.04
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 07:54:04 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8fea25727a9so1803792241.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 07:54:04 -0700 (PDT)
X-Received: by 2002:a05:6102:390b:b0:5d6:fce:4443 with SMTP id
 ada2fe7eead31-5d60fce44d4mr4420342137.43.1760540044664; Wed, 15 Oct 2025
 07:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015141014.156437-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251015141014.156437-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Oct 2025 16:53:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWq4dbpsRYBVeQLpAVZ0Zk44vwPJTShMi8jZpuH0miYgQ@mail.gmail.com>
X-Gm-Features: AS18NWCxkT4sRPfN_bOCrKffa15VtUEJklYqD4ElIKofei39YrIIER48YuJxXBM
Message-ID: <CAMuHMdWq4dbpsRYBVeQLpAVZ0Zk44vwPJTShMi8jZpuH0miYgQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/rcar_gen3: Document Gen4 support in
 driver comment
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pm@vger.kernel.org, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

Thanks for your patch!

On Wed, 15 Oct 2025 at 16:10, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The R-Car Gen3 thermal driver supports both R-Car Gen3 and Gen4 SoCs.

And RZ/G2 (the ones that do not fall under "RZ/G2L"), cfr. what you
actually added in the comment.

> Update the driver comment. No functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - *  R-Car Gen3 THS thermal sensor driver
> + *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver
>   *  Based on rcar_thermal.c and work from Hien Dang and Khiem Nguyen.
>   *
>   * Copyright (C) 2016 Renesas Electronics Corporation.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

