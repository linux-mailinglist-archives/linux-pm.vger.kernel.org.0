Return-Path: <linux-pm+bounces-16553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 713789B23C4
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 05:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242391F215E4
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 04:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F061558BB;
	Mon, 28 Oct 2024 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="fzXyhj4i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA780B
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730088124; cv=none; b=XQWRrsLeiqNPGsrjqP/BUab8wQQvIF2hEFal7CSgbL2YXa40R2QyhIakw23/GnabYbq5oYqttiPI3yeqsnOLwXVMbk5OaYtaSR4JG5s8Izu8hZOJP10Gu6HMueZs3LkH3uvDh6yoDM8HzRtQFXtj1e1rB2Ywp2vmNTIuOOFWhsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730088124; c=relaxed/simple;
	bh=psagsNYH98WauCnOVMkpjCJ+weoMGD1z6i2lBdwupgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vi7N4hFVgacDyjEtARI7S9+sGS7iIlUllg22E2MYyQcYJSfcSGCb1S4bp059Cn07Ru6OS39RgNis8rYUEepHWWZPU+QJAUBCfDZt1KFYiQnnP+5uptTpfGaw3UaaNhn9YlM+ciH+DAZwolK1vDvSlECfyvsnvyrMto0H57dIwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=fzXyhj4i; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a4e474983fso10006705ab.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 21:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1730088121; x=1730692921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTkrMIwVXtDibKqC0zJplXVw97dLp3stcJak0OUNlGQ=;
        b=fzXyhj4i+utg/FI1u2iBocrhxpXCaPc/j/G3887F8UkkTUnWXd2CSGMSEFTtH8T/o0
         wSMpKpOT9orkm9G3jzFOU+sy1+oMTKinGV/yS6grLGndg5tyjGDapYORSypUohVo6FH3
         1CAi2R9GfteV/Mb7srTC5TGoK5lSD36n05HMKk/fNa2O+rvflO76oTSpUResPOm4iSQM
         COle50zNtKRZ5D6wMffJma66sAEwC8LCcO98zFvy6eDxkGNFoINm5ey5jupassAAMAEe
         2gkMGm/nxJx98VPOP/mGJ0gemU3pXyTsNGGHnhzvc9JBIFrgyYVRrkJJazBVPkLw9WRY
         39Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730088121; x=1730692921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTkrMIwVXtDibKqC0zJplXVw97dLp3stcJak0OUNlGQ=;
        b=Myme6LGLVeQ8jyWjUjaXJNKgzvQnsS37CqtULdBgD/I6NRfDae3QQ5HrLPAVrHkLmC
         wqzJu86ERxX1klquRGhk02+4m8weetglxGf5GWr16Lc8jxs3P/DdbqvXJ7WWRRz77WDd
         O8ya/0o2DWZZPslrQ7PusAh2AqPAdom7Vkh5RhJi4BWMZHiO+xSBHyN4qIJ6xMWVfL9u
         WkJ6FLW8BVcDfecmmRFJOg2qiVrJqwrZIrnqYRI2B/zeSfHVw7rDMuvpf4vlP8+c3MH1
         natPV3kCHlttWG2A+2MzouNfyHSnB2Q0MDW3q831YnQu7URSMIK7DNy8EshQjG+iGNeA
         JtVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYM93SF29xjUztwWB1rNWBDHY3gIzO+XubJSIcN7/Ffsj8SD7YD8u9AYf+FO96OVNNm6ehhf70PA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+eBejJJGviF7ZfxtUJ3660BCvgD1R5EGppfnrX4GL3ggqdjv
	e8OfnXIE5LKqBOdG6ytp7GSLz1iMVoK3emflZbZac3pruv8n1bzhLC9Z6dfQcSQ522GpRAvW4+K
	mdOf9JPIGhNij50cKRTrCBcGy0bVHGlRyzBDKRQ==
X-Google-Smtp-Source: AGHT+IEW3RMxsb+OkLSwXzoPgDRun4PeWtdHYycalmOdPki2HQ/g+qJQULY+edvSYHMAhxM7DrjE17H2RyAh5VkTZ8A=
X-Received: by 2002:a05:6e02:16cf:b0:3a0:8d60:8b7d with SMTP id
 e9e14a558f8ab-3a4ed2aaddfmr68350065ab.11.1730088121508; Sun, 27 Oct 2024
 21:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028033928.223218-1-nick.hu@sifive.com> <20241028033928.223218-2-nick.hu@sifive.com>
In-Reply-To: <20241028033928.223218-2-nick.hu@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 28 Oct 2024 09:31:49 +0530
Message-ID: <CAAhSdy1AmSmnGV6GbHgcWe2pXuS4sF8wat_po05Mpiho2hD4SQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] riscv: Add stimecmp save and restore
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Jones <ajones@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 9:09=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote:
>
> If the HW support the SSTC extension, we should save and restore the
> stimecmp register while cpu non retention suspend.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/suspend.h |  4 ++++
>  arch/riscv/kernel/suspend.c      | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/su=
spend.h
> index 4ffb022b097f..dc5782b5fbad 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -18,6 +18,10 @@ struct suspend_context {
>         unsigned long ie;
>  #ifdef CONFIG_MMU
>         unsigned long satp;
> +       unsigned long stimecmp;
> +#if __riscv_xlen < 64
> +       unsigned long stimecmph;
> +#endif
>  #endif
>  };
>
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index 9a8a0dc035b2..24b3f57d467f 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -30,6 +30,13 @@ void suspend_save_csrs(struct suspend_context *context=
)
>          */
>
>  #ifdef CONFIG_MMU
> +       if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> +               context->stimecmp =3D csr_read(CSR_STIMECMP);
> +#if __riscv_xlen < 64
> +               context->stimecmph =3D csr_read(CSR_STIMECMPH);
> +#endif
> +       }
> +
>         context->satp =3D csr_read(CSR_SATP);
>  #endif
>  }
> @@ -43,6 +50,13 @@ void suspend_restore_csrs(struct suspend_context *cont=
ext)
>         csr_write(CSR_IE, context->ie);
>
>  #ifdef CONFIG_MMU
> +       if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> +               csr_write(CSR_STIMECMP, context->stimecmp);
> +#if __riscv_xlen < 64
> +               csr_write(CSR_STIMECMPH, context->stimecmph);
> +#endif
> +       }
> +
>         csr_write(CSR_SATP, context->satp);
>  #endif
>  }
> --
> 2.34.1
>
>

