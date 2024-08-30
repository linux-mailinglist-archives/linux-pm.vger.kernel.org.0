Return-Path: <linux-pm+bounces-13199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA308965723
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 07:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098851C22AF3
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 05:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065514F11D;
	Fri, 30 Aug 2024 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IYhvq1pa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CEC1487F1
	for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2024 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997205; cv=none; b=JuV0El8SKPrEulWVDAYt5rjnC6bOCvnZlqRIDhy1cNsWnckHdwuQkBZciVLD3RLYOBmslHkqkv2rvc9ZA98Zd94TKdwLuZqTy876HRB7NZrhyi9p687H8RTe8ygbTiatX4MK4/3qH4+gXHpdAAGhSBSrp0bToIprYOBjJf0pFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997205; c=relaxed/simple;
	bh=0KJsWXgafS+B8UIQCLLWs5s8Q+F/hXdfLnoVDgs5X94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoBHwB8eNk4bHqVGusAyhqGOF9DZrT9dcpjQizyLvIPLv1eisKZPglst2jUiDOXVFZz7ohCLzjaqWuad/1XjzasxQCOD9+tY3llG9cy6GG6GwkzCL8FbLNUFu/Yq4ZNtjf+DCg/KsBI560VvX+d5XiF8BbjeilIilb76e7MPVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IYhvq1pa; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70f44b88bf0so1201655a34.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 22:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724997202; x=1725602002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3Jt+xqdS9PmDCVfg7T2ZaIXSXLuqHnsCyhxBsg/hkk=;
        b=IYhvq1pa8Gy3FSHxSQTaI8BbOkGSjvPCz5sm1tBYayWjRZvo9KFmbnwK7tUWvaCetY
         vX1LzMAyvmGtw23SDL0/+yhdIthOTjvKkZxCh2g7tWr2VmXr7K66D98pFBqs3pqCEBmv
         nnsPuDY4wo78WvdvX/D8HMya33buIuwp29doWqQEEMB+dBkzPRKW4/dGH/Kab/32NjQM
         Q8ULeqHqYqACGc4YbpiStyjh+Et6iEJA+D6aw0mq2MQLA0yVIj/xFJgzSzvjGxJS+Flq
         7jqEXN+93BceXgOWbBXaWeZftDLee1zn2aP2PANvQt5Tzcup7FjWrNj7+/Eal0BriQ26
         42mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724997202; x=1725602002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3Jt+xqdS9PmDCVfg7T2ZaIXSXLuqHnsCyhxBsg/hkk=;
        b=HlsKBm7AEYqje7gx0GrRV0BXLH7uY28BaKdpGBxFxh/OlCHwvav2xV3hVeSl1+3oRN
         0lzxC2y+iPvw1rDlCFzngaCzjfuw3zpuZu9OfIGDZYGmEI672KOhREtYCvLHLynqKqY6
         xiECLYZrXKid3Qu8e83vJguBVDIg5AkcVeZjwh++ATiF4n11l8ywfTToUTxWf9FJg2hX
         oTKYKjn5I9SGDO6OhiD6XDXgRocXHR4Tz8z/cJu4yDc1V8LqjaDP8XdWTfWVlz0Bn6Ar
         ElbqTuCpn/4hBCkxku5+GjPENXot3TLWZP7WuoihQP4c74Hc3APvu1sK/2IEktXTeocH
         56SA==
X-Forwarded-Encrypted: i=1; AJvYcCWHolVNAwLjF11nYkEjrbpHTWMezmYQChWXMqfqInKekNh5ljzG3lhpyZCoN8EG7RSBWv1WBhdvHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9UkShrjaP882Xvuu6JF6bWvv5zbdOgUvfMamOXSmB7Sar1c3O
	o1smSFZYLZBx+W2hwiRKM7B9Pjil7zMhTbnX6OvZu8rNie97PvX8dBX+jc4rvS24KS3maO6XyXi
	cIbsFPPgGje8ehyDEEkKqElBM3fgNzTOKaybzyg==
X-Google-Smtp-Source: AGHT+IH6bpYCNGGrkPgr+I0PGiNrrtq4i4l0rhoyVcVkBQzkAFDJbUNNEJuggk2fcve7C32y2tW3EhGtZ8PKnDywHKA=
X-Received: by 2002:a05:6808:222a:b0:3df:101c:cc38 with SMTP id
 5614622812f47-3df1285dc3fmr489365b6e.1.1724997201924; Thu, 29 Aug 2024
 22:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033904.477200-1-nick.hu@sifive.com> <20240829033904.477200-2-nick.hu@sifive.com>
 <20240829-fb7bda6b46302b65b2f89d20@orel>
In-Reply-To: <20240829-fb7bda6b46302b65b2f89d20@orel>
From: Nick Hu <nick.hu@sifive.com>
Date: Fri, 30 Aug 2024 13:53:11 +0800
Message-ID: <CAKddAkBks46LEdmFfkDuwoCc-kxcf1KpghiROuh-JeNorHrMRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Add stimecmp save and restore
To: Andrew Jones <ajones@ventanamicro.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Conor Dooley <conor.dooley@microchip.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew

On Thu, Aug 29, 2024 at 3:59=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Aug 29, 2024 at 11:38:59AM GMT, Nick Hu wrote:
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
> >       unsigned long envcfg;
> >       unsigned long tvec;
> >       unsigned long ie;
> > +#if __riscv_xlen < 64
> > +     unsigned long stimecmph;
> > +#endif
>
> I'm not sure the reduction in struct size is worth the #ifdeffery. If we
> just always add stimecmph, then we can also change the #ifdef's below to
> if's, i.e. if (__riscv_xlen < 64), which should still remove the code fro=
m
> 64-bit builds.
>
> Or maybe we need something like
>
> #if __riscv_xlen < 64
> #define csrh_write(r, v) csr_write(r, v)
> #else
> #define csrh_write(r, v)
> #endif
>
> in asm/csr.h and then use it for all the *h csrs, but keep the #if in
> the struct.
>
> Thanks,
> drew
>
If no other comment, I'll choose the csrh_write() because it can save
some memory and update in the next version.
Thanks for the suggestion!

> > +     unsigned long stimecmp;
> >  #ifdef CONFIG_MMU
> >       unsigned long satp;
> >  #endif
> > diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> > index c8cec0cc5833..3afd86e1abf7 100644
> > --- a/arch/riscv/kernel/suspend.c
> > +++ b/arch/riscv/kernel/suspend.c
> > @@ -19,6 +19,12 @@ void suspend_save_csrs(struct suspend_context *conte=
xt)
> >       context->tvec =3D csr_read(CSR_TVEC);
> >       context->ie =3D csr_read(CSR_IE);
> >
> > +     if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> > +             context->stimecmp =3D csr_read(CSR_STIMECMP);
> > +#if __riscv_xlen < 64
> > +             context->stimecmph =3D csr_read(CSR_STIMECMPH);
> > +#endif
> > +     }
> >       /*
> >        * No need to save/restore IP CSR (i.e. MIP or SIP) because:
> >        *
> > @@ -42,6 +48,13 @@ void suspend_restore_csrs(struct suspend_context *co=
ntext)
> >       csr_write(CSR_TVEC, context->tvec);
> >       csr_write(CSR_IE, context->ie);
> >
> > +     if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> > +             csr_write(CSR_STIMECMP, context->stimecmp);
> > +#if __riscv_xlen < 64
> > +             csr_write(CSR_STIMECMPH, context->stimecmph);
> > +#endif
> > +     }
> > +
> >  #ifdef CONFIG_MMU
> >       csr_write(CSR_SATP, context->satp);
> >  #endif
> > --
> > 2.34.1
> >

Regards,
Nick

