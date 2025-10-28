Return-Path: <linux-pm+bounces-36961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D0C13FAD
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 11:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C5619C2FC5
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB652F39B1;
	Tue, 28 Oct 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="J3k8HRJC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC9302773
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645535; cv=none; b=p/7MmI64h8103j0ZFTDRh2+vt4YJN1pCCaywpg2KJjQzEET2W6eWa+4uqEqdiT256vT4ChriXL+A8ItCrh8XhA6rBhAmCBg8vwfoaFshA7L/PllC1WHl+idOTseAhqjUsS2I85ln43qikMRurOMJqCSgUpsWwG+rlxQEADll/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645535; c=relaxed/simple;
	bh=Udw4Kac4IPS7oanBQ6UJdyxqv8+zAPZHZclswaCqs0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gxl3lLeM974XQb8huOIDCy0ZKtFaU95VdgOdNpE6To0ZWRtOTT5t0WlUGTbMu5wf3e7Q09ef2WSQqKUZT7kYNgGErtQnurATGBec/zFVVCuYRGXAEA8w7bmwab9g2U6YsL1xCNOjPdpXqc2IcL+YdH/+wueyKaalt6JGaLET8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=J3k8HRJC; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430c180d829so25365585ab.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1761645533; x=1762250333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PY8mCSuKOhJf2Q+W5FTads5NFbSblIDSqg2ZyPdi2M=;
        b=J3k8HRJClO8sGnJrBPVRqmAHzuXoyZ6O9JTTC2GCDLv6qcXuPnG/EGHkXxgTzPYrGc
         qi7ZOqLlExHdvLpw6d3ka/tZ/ExTCFt6AASgtoVEdogoK1BWKQKqvRqJldMsxkUVzEuB
         yTrJM7VAzgrPRKgiPzWKjPxZGpVQOVLXUDkHYZMmNNWkLOLfB+/KHJe+3U8EkE8jC4Qu
         GCujq28zK1Ria5s/hj2xEijJ+NJfDs9GeJrvETHt5vqTZicirOT8FIY25SgMqekfMlq1
         gP0ARg7SHv5MCMg6nhmVseYR1dmTF+DdYM6nzfbmfc6HpRBHKX5LkUXUzNSqjxCQca2r
         WKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645533; x=1762250333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PY8mCSuKOhJf2Q+W5FTads5NFbSblIDSqg2ZyPdi2M=;
        b=VLoPFS/UptBLWEtZRV3O/vFgoq3jeSI21NKAFL6E/G6Nm5w3oXxNkrVxzKW0ukTq0G
         /rKbvT6ryEMxU48ZUZR+iozIlhZe9uNfBNFH6GY13IwCebCrJWjguXJSmFhmFNTc+j6U
         FunTpIVrcOmT53uueGb1P3GC73elodorjt4VF8GfVC/Ft2uCJ9FJPlskSE4/Pu2YQtM8
         rw/J+xssh2a/cN7xYLY7AJGa5rmVXVM6LqaPNgfAgRNtfuVVHjivasqN805LRXbC49OL
         gtQ0dDnRgtYV2iy8yLycZPvaI6RzvYG7NSlfaLLWDZza37LzRXqWtM/Jll6KHHbx/Gum
         N3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO1OXZPipBR1ljMc/I/aZovg7gNoQ38bKYSb/Dbl41JH/3R/fU8ICFkUXd40x3HbRGVCVaSXpnPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpd3iKGRZTUZfVV7YLx7s48FyWQELULIWzSTJ0UpWYv7cwbL6A
	dlXt6We1MYCSnJyvRrI3HwOKIDsw/qvbtceKusOFrh0I213zvIr0r6UUp2iqnPWaMUMruSaacdo
	gTAAA5TLkG9AjQDK9YCKoeNInQZ1o9paE4+hM0evExw==
X-Gm-Gg: ASbGncvwxGVhl9284hbxWzvlsq6LnO+auNOWomcjpdJOZZQ75bYiwPzXXjAv1VzoEAg
	gqzrc2Lgp0mMRHzal5qz/fEuyMu0BSsq0oLmcb8j9ICCZARHS3D3PTDPYrLXuWGdCnfBv25/43L
	+BZnEbQPDyunOOARR7HnAU2Gaw8YjKn5XH01MQRTJWq1BxzBwXxGqscfuxEhh+OreYSsyoSUY8O
	rFvNyH55lKja+K2zD+bxwnKWolyPXBwFuTymlUk9OX00IODzTJjAkAHmhhxuQuTOCLSAUUljBLg
	btvQ2Uh9+7mMuIkwHA==
X-Google-Smtp-Source: AGHT+IEg0a1CT3cJ1oaHQ17yWX2472MdL2RHimICjHVP34ZQDjWMsWJJoe7Ni16kwKdyIqohFYWx2NwOzODq5cmzegw=
X-Received: by 2002:a05:6e02:d:b0:431:d73b:ea9c with SMTP id
 e9e14a558f8ab-4320f6b1237mr44673025ab.6.1761645533137; Tue, 28 Oct 2025
 02:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021135155.1409-1-thorsten.blum@linux.dev> <20251021135155.1409-2-thorsten.blum@linux.dev>
In-Reply-To: <20251021135155.1409-2-thorsten.blum@linux.dev>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 28 Oct 2025 15:28:41 +0530
X-Gm-Features: AWmQ_bmouff25xtnvPr1URYNqHRT10uCqQrPn__6ZXy4Z26vl234qADpGcUh16E
Message-ID: <CAAhSdy2Y25TXjZNmaMMKhwZBi-T-UzXjQGuVfqy-ThTuJ4rmNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpuidle: riscv-sbi: Replace deprecated strcpy in sbi_cpuidle_init_cpu
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:22=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index a360bc4d20b7..19be6475d356 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -303,8 +304,8 @@ static int sbi_cpuidle_init_cpu(struct device *dev, i=
nt cpu)
>         drv->states[0].exit_latency =3D 1;
>         drv->states[0].target_residency =3D 1;
>         drv->states[0].power_usage =3D UINT_MAX;
> -       strcpy(drv->states[0].name, "WFI");
> -       strcpy(drv->states[0].desc, "RISC-V WFI");
> +       strscpy(drv->states[0].name, "WFI");
> +       strscpy(drv->states[0].desc, "RISC-V WFI");
>
>         /*
>          * If no DT idle states are detected (ret =3D=3D 0) let the drive=
r
> --
> 2.51.0
>

