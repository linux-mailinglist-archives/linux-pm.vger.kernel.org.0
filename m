Return-Path: <linux-pm+bounces-13105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7C963B1C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149571F23C48
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD99B145341;
	Thu, 29 Aug 2024 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ak6SdMF1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E734C62
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912180; cv=none; b=sSEZbQK7zeAFpvufXziAKEZXsOkKw0scgZ6wmzBU8GffIHm/sQMVo/b3SkVVxa+xJwllAcXgE0fwABXdMIKY2ZmMHtbNGAhiMoI/1aBfShdCRvyVl16kZqqX5ps0UjjUtH3Ncavh2iqCt8tOZDFO6BVnOAKMt14323TaTdKftMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912180; c=relaxed/simple;
	bh=TD/d27Q2fNPvJ6OBiRM0NjLejuEOHNoymox6NIv2/N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctBzIP1UCMCewdZ7jx9u3bDCJ3BUvn/JU3ysHOn777HSeD8GDAdFJGLNfSiJ0WWE4mFVYmrH+pQew8nFWcs/ipuoamPokko9qElgstc52PWSMVKCVYSbx7MXfs9CFewMKUnynx/bJAkuB/A/MkE4qQlPCVLMACYi+sJnnbWu22Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ak6SdMF1; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3deedfa3a5aso168151b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724912178; x=1725516978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y4ddcKIVUQCa1/ea3XcOqcG2GLAb+NeoR2FFMnflVY=;
        b=ak6SdMF1oo2wvYIyEJTeje80H9Ld5YHkAzrKiHZthDpdEhjX7RaBsekhBf22SqPRsA
         nxR12KOBlXOyUQL6KvXiMNApBg2FZcRegmEFPlbK24FSlr2Ve8h81E1x86/6M522YKm/
         f0KVMXXKM5qQ5NX6lUHpNPLqcP0IBDnQtatqZcv2ezPpC+/uA8AFFTXFBHuL0EOqfW3i
         mBjfFN9Fh4Z4FUh0AVtv3fXCJ5XbU2RvPjv99yYJI9FGbEkXDEQcXo57k0NYKJjBynMc
         lSe9OXNuZRvHElBwLBHzIX+9qr2OKHutj/36ux9ZkIYpGn3KRacWy+VooVdLivpvtnuZ
         Kdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724912178; x=1725516978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9y4ddcKIVUQCa1/ea3XcOqcG2GLAb+NeoR2FFMnflVY=;
        b=JkYJ3F49iQljgOrjHUQin+s3IAwu/rDF3A/zOD0fr++zcPDVE+ga5dbkrbqBKgPWSI
         xMtDSU/fCA8fDDjVWAFCIxzAdhLfIEXq4NBX7uCL3g4a7DmoQ5NJXdJgtznYTplBXaY+
         oYpyE0CoekmB0o1SyZGTcFm7Sd90Putvo8OBGGBxoAtd2oQ7AbLbewUwlajX8PqB6gY8
         EfPYLQEIxkuLFwTRkcXCxlvkixPErPzKoGbZuI61GnLUeCQZmavgqgRrTkiRgr8l2fo3
         kxMNNttM+H6YCVV4c8Wonou520LpIFXkRg2iFTJ01IiYJmIiA7/16I6sEEAPqZJT90wX
         flCA==
X-Forwarded-Encrypted: i=1; AJvYcCWf7Ub5dCjwd9Q7lZCeCk0QHNvBIk0kIZqP0WIBDsFqNTMd8MJtMOuZq621AUgGl+Lz8mn6eVIltw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cB/mBS5+h9AOMqsXh4fCE9PWNLR+C32PfEv2YAJPmGRys51w
	Ou7KhHfxo0cZMeiiY109xALxkiV1ARyyd7eTQr48ao1843nue1yfNmWOprR7TtyzPf30c0f5A5B
	af6SzYa20XGc1O7AaK8Vgktikg3fDK/lC0hctIg==
X-Google-Smtp-Source: AGHT+IEE4wRUW1rNC4WHXpmToVacLhp7JtdVm9GWj68DauHvAo1uUeyA1+SsT9HZgMVr7s8RUG+CLOtF61Epupbl4tY=
X-Received: by 2002:a05:6808:1241:b0:3de:218f:b60 with SMTP id
 5614622812f47-3df05c480afmr1690639b6e.17.1724912177961; Wed, 28 Aug 2024
 23:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033904.477200-1-nick.hu@sifive.com> <20240829033904.477200-2-nick.hu@sifive.com>
 <CAK9=C2XSrxXGB-PKKi0sLQq7L1Ovucb73Bc9tOnxwWTxux_D7g@mail.gmail.com>
In-Reply-To: <CAK9=C2XSrxXGB-PKKi0sLQq7L1Ovucb73Bc9tOnxwWTxux_D7g@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 29 Aug 2024 14:16:07 +0800
Message-ID: <CAKddAkBwL+n7fK6ugCpNeCv3dryaPJTS1qAM9E6VHb1QkSKd=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Add stimecmp save and restore
To: Anup Patel <apatel@ventanamicro.com>
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

Hi Anup,

On Thu, Aug 29, 2024 at 1:18=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Thu, Aug 29, 2024 at 9:09=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrot=
e:
> >
> > If the HW support the SSTC extension, we should save and restore the
> > stimecmp register while cpu non retention suspend.
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > ---
> >  arch/riscv/include/asm/suspend.h |  4 ++++
> >  arch/riscv/kernel/suspend.c      | 13 +++++++++++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/=
suspend.h
> > index 4ffb022b097f..ffaac2efabb5 100644
> > --- a/arch/riscv/include/asm/suspend.h
> > +++ b/arch/riscv/include/asm/suspend.h
> > @@ -16,6 +16,10 @@ struct suspend_context {
> >         unsigned long envcfg;
> >         unsigned long tvec;
> >         unsigned long ie;
> > +#if __riscv_xlen < 64
> > +       unsigned long stimecmph;
> > +#endif
> > +       unsigned long stimecmp;
> >  #ifdef CONFIG_MMU
> >         unsigned long satp;
> >  #endif
> > diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> > index c8cec0cc5833..3afd86e1abf7 100644
> > --- a/arch/riscv/kernel/suspend.c
> > +++ b/arch/riscv/kernel/suspend.c
> > @@ -19,6 +19,12 @@ void suspend_save_csrs(struct suspend_context *conte=
xt)
> >         context->tvec =3D csr_read(CSR_TVEC);
> >         context->ie =3D csr_read(CSR_IE);
> >
> > +       if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> > +               context->stimecmp =3D csr_read(CSR_STIMECMP);
> > +#if __riscv_xlen < 64
> > +               context->stimecmph =3D csr_read(CSR_STIMECMPH);
> > +#endif
> > +       }
>
> The suspend save/restore is enabled for the NoMMU kernel as well
> (which runs in M-mode) so it is better to save/restore stimecmp CSR
> only for MMU enabled kernels (just like satp CSR).
>
Good point. Will update that in the next version.
Thanks for the feedback.

> >         /*
> >          * No need to save/restore IP CSR (i.e. MIP or SIP) because:
> >          *
> > @@ -42,6 +48,13 @@ void suspend_restore_csrs(struct suspend_context *co=
ntext)
> >         csr_write(CSR_TVEC, context->tvec);
> >         csr_write(CSR_IE, context->ie);
> >
> > +       if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> > +               csr_write(CSR_STIMECMP, context->stimecmp);
> > +#if __riscv_xlen < 64
> > +               csr_write(CSR_STIMECMPH, context->stimecmph);
> > +#endif
> > +       }
> > +
> >  #ifdef CONFIG_MMU
> >         csr_write(CSR_SATP, context->satp);
> >  #endif
> > --
> > 2.34.1
> >
> >
>
> Regards,
> Anup

Regards,
Nick

