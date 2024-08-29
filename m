Return-Path: <linux-pm+bounces-13103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 089F09639CF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 07:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3A3B21B3D
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 05:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530713B592;
	Thu, 29 Aug 2024 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mH7901zs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B327E796
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 05:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908703; cv=none; b=FKZhysDGr+KEOQvAMFHtaeCzXPrBJRyjRUuIht6qKEeRvaOMMp0M/Ho8eH99yDKzLLVt+cVHs0WEkHL6RobgKDU36hlS1h1d1I7kfedEeaU+uJkd/7qC47iP4Lep6Muj9DK+J4CE6O8ixL7TM8sboKnRuWSo/oThHoV6k6asN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908703; c=relaxed/simple;
	bh=ELYjjQ+mJUOkuJUvz8UtgGVXCzr7Wuicbv+a1pSuFKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws5459mT1sMOphIp3l380WUTkYYg4pPU10VzZGae6jpAQXUtN82wgYVruoGYuGZZcO/uaZKZF0O6HvSdMofe+OYnotfiqMrZj5z1JpoCcY3Dx2nrD7Z2okqhEZd5nxUHgFuj+clJw2lT/lStoJiaZYPWLAGFc3WwhA/QGLfENVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mH7901zs; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5334a8a1b07so266967e87.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 22:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724908700; x=1725513500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3IB0lNCEhV9enuNzk+VnTluaGKoDtr4uKJKrcnidUw=;
        b=mH7901zsZfHwyW9MPb+2brItPfYbrb0b5ZSw/i2MnOwDv792675/vhpwJa6ocohvCI
         TdrkyMrPWz/aVNUC5L5FMROlODXA4727EusJLI86BiNKPj+fvgkcZ9BzlfXnbv/KC7B8
         8/LADwqTZdmAnpZxx3FUxT0JoDIdTuMlvDvcwdAOLRPm4XDSjuGZNxue1gpCVHcdmBwe
         Qsl4XX5XNfKRd1G2cfYvTEZHAtU3jwJ+fgdD3KPMp/+iIh+pifLCbNm0OXJ4KLJ6jewm
         Os0jStPIIw4G4tRMAdZ1Y8BNM80n+TdndRxcdx7fV1bONVejuYLEnIUOD9yJp/7w6Mwl
         Dn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724908700; x=1725513500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3IB0lNCEhV9enuNzk+VnTluaGKoDtr4uKJKrcnidUw=;
        b=pSr1b4FxBbjuTAACPvJ3tXqDnFDmcmbxkWlPbNFT2Y3jZQIV5xWyOzjYp9tK8VNmXU
         VZZgWk2u0ZKuxKk7OhlPL+w40Q/CyK1siyRiHYFD3GH5x2ci7esiye68oWeQygVzFgex
         UPC651kv+PBtmYODkliDE6ksu68v9GubMW95YdRHzTj0A4KL6n0avmBHLFkBN7wC76G6
         omxlmkiDe2p6gbCz16Q0zL0nVqwApJHd2r2/GNbk5HPsMEIv0V7QK1Ke7b/1mBIkbSO1
         oy/JRs+NUxhToC+wfKssdEvQ8oraBudkCC15dO3uLNG3vqIDydvpYf8UpXHWXRgamUNe
         m2UA==
X-Forwarded-Encrypted: i=1; AJvYcCUZNPkPmufVyJvOzBCDow+q5bnHjwHp5NC8UuLeW3G4uSsd1RrWEFJPyNGJasyqPL2pScjNOLBpVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVosGWFuXv6ftnlTz2d0HZPeyiKQOKLttf/tQRlY6ngHTNjbe6
	Gk3kxOHVr3qgrLpiBxieD3gIS0iyAsfziCmrEsZq6dC1xXVrW40tAa+Ucb27MJFU3HpSnM9f8iZ
	T7YNGoxnx5WQjf+SHGZNc+l50F5/nbKZ/dL1uQw==
X-Google-Smtp-Source: AGHT+IF5qM5Tv33jrhTxPQuB7QcGegW/B0kYwW+2dXW1R9ibKz60sWm56wn4RINz3pCrSIub6yb7ue9n11Ee4xuIvkE=
X-Received: by 2002:a05:6512:2245:b0:52b:8ef7:bf1f with SMTP id
 2adb3069b0e04-5353e56680fmr723799e87.17.1724908699186; Wed, 28 Aug 2024
 22:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033904.477200-1-nick.hu@sifive.com> <20240829033904.477200-2-nick.hu@sifive.com>
In-Reply-To: <20240829033904.477200-2-nick.hu@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 29 Aug 2024 10:48:07 +0530
Message-ID: <CAK9=C2XSrxXGB-PKKi0sLQq7L1Ovucb73Bc9tOnxwWTxux_D7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Add stimecmp save and restore
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:09=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote:
>
> If the HW support the SSTC extension, we should save and restore the
> stimecmp register while cpu non retention suspend.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---
>  arch/riscv/include/asm/suspend.h |  4 ++++
>  arch/riscv/kernel/suspend.c      | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/su=
spend.h
> index 4ffb022b097f..ffaac2efabb5 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -16,6 +16,10 @@ struct suspend_context {
>         unsigned long envcfg;
>         unsigned long tvec;
>         unsigned long ie;
> +#if __riscv_xlen < 64
> +       unsigned long stimecmph;
> +#endif
> +       unsigned long stimecmp;
>  #ifdef CONFIG_MMU
>         unsigned long satp;
>  #endif
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index c8cec0cc5833..3afd86e1abf7 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -19,6 +19,12 @@ void suspend_save_csrs(struct suspend_context *context=
)
>         context->tvec =3D csr_read(CSR_TVEC);
>         context->ie =3D csr_read(CSR_IE);
>
> +       if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> +               context->stimecmp =3D csr_read(CSR_STIMECMP);
> +#if __riscv_xlen < 64
> +               context->stimecmph =3D csr_read(CSR_STIMECMPH);
> +#endif
> +       }

The suspend save/restore is enabled for the NoMMU kernel as well
(which runs in M-mode) so it is better to save/restore stimecmp CSR
only for MMU enabled kernels (just like satp CSR).

>         /*
>          * No need to save/restore IP CSR (i.e. MIP or SIP) because:
>          *
> @@ -42,6 +48,13 @@ void suspend_restore_csrs(struct suspend_context *cont=
ext)
>         csr_write(CSR_TVEC, context->tvec);
>         csr_write(CSR_IE, context->ie);
>
> +       if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> +               csr_write(CSR_STIMECMP, context->stimecmp);
> +#if __riscv_xlen < 64
> +               csr_write(CSR_STIMECMPH, context->stimecmph);
> +#endif
> +       }
> +
>  #ifdef CONFIG_MMU
>         csr_write(CSR_SATP, context->satp);
>  #endif
> --
> 2.34.1
>
>

Regards,
Anup

