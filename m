Return-Path: <linux-pm+bounces-13131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E485963DE2
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 09:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EC11F24053
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 07:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0BF189B9D;
	Thu, 29 Aug 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CZtfE2m1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2A14B96F
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918350; cv=none; b=tkDYU9mnYNb3st1cKAWRRtIAi5XZg4OrQUL1qxJorSxJT0WKuqv3r6lL77Df9nPD/w/gqT3UtWDk6Q6ZOglkVRmoTbaM3mBHDbpR98GSb7zdrEGx/ateFIqr9gbDIEQSfjB1wM6gC8oiDZVUTaEzJns9GVRR4Pst+6SCXWzIfOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918350; c=relaxed/simple;
	bh=ISm5ntBSyRBtS44vfURV3RiQumBNWuZaV6guM8smmW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFcmMDrb7+CA9sEdwZotoae91hhplyjytsEce2sfaszZz9xwDXpIHrw5TTstd1FNCbn1ej/KyMticcec0VpN++2jlnddMt5S3atiRJ+9X6Bx5EJUW0oisLCZ27YICqauzs51Ai3YwFdGUFWq41AJ3PrpAcRCBJH563KM4Cb6f4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CZtfE2m1; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3eabcd293so3975641fa.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724918347; x=1725523147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6elqEmMP4Fqdb/aWp7gByX3m8OcBQtHxRmlqmcr7txg=;
        b=CZtfE2m1jwNh6+FsnH+oZnpR2Ya96oguOsWuPl2SBenkV2wTFqD5Bb2oevEylbbD9+
         k0BbHfTG7XmhUdQ6CEeFf72IgYxwWgx6MmSLLxIvtgsK61QpcLA/E5diX17E6IYBlD4K
         PXNCn5T+tm9YN5Smc5gSJCpjUPF7i8oEp+Jkqv7zaoBq9gvJPV4RKXdGvOSE/+ZWAvtT
         c7gZgSn0x/9QoG1f11tcGgTAmZ+9+HHU8BV9MWKyUv+oFdRvUj+XX1Xv2kZgCNsIqPZc
         lr/KrAKBwipmCvq7wFPBn37kkeeXyFMyCYTEPWlgIv2yC2I4l49NBpGXMC9KB05uQmCp
         tyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724918347; x=1725523147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6elqEmMP4Fqdb/aWp7gByX3m8OcBQtHxRmlqmcr7txg=;
        b=oQ6McYyV64J5NgLR6G5oQaUJcEidMpikZ1catH2O/y/4mWFYoAauZYv6lAiWDS1j8z
         XJrTFrKXYVxEAU3DRR8tBBEOJLqLfOCUlFYZbDQB3p1aT8RGv9v8du0YwWBSQSylJN1X
         2hRWaJwjx/XkMzxCrwza4c/ev/ITEnwkgDm/fdonrRjj1XpUn/0X4k/tDCzm+JWlvl6r
         ol4pXu8wHvEpWO0WPOKFGHgI3Z/94ThYDS+wVtjpiDatkW7AZ0m2bmTqVrnv29TCGfbv
         pU7yg4x6Rad3kR8IDQetm5Z15hEZu0lq6IefQsV0NX6bvzzc4J7TJAVYYOhsrK5vMmEq
         bDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4u66mOYrINUnsSzSJjuUUeOpla/Xqvq6sLqyNl+sYfi+pNVvYoIr2+oAwv8KvFWT+Uu9o/PVgzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2MyPcHSbDtlDp4JDaFWwr6G6MNmpo4ieLzR1Az0T8sBiqOkHd
	3kuWRLqaGGxJ7zmMvjg4h+8/CeqCv40yegl9ngeLClnZnZOIuawD0RQplrmEPpU=
X-Google-Smtp-Source: AGHT+IEknpoiPwNIZCUWqC5wlzEu9yh+Rxh2v4jcs1wvi/j58/8VhBs0RUuviEJZYalHd8CSAHV62w==
X-Received: by 2002:a05:651c:1990:b0:2ef:2b05:2ab3 with SMTP id 38308e7fff4ca-2f610392703mr13785621fa.10.1724918346154;
        Thu, 29 Aug 2024 00:59:06 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7c2aesm382119a12.51.2024.08.29.00.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:59:05 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:59:04 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Conor Dooley <conor.dooley@microchip.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Sunil V L <sunilvl@ventanamicro.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Add stimecmp save and restore
Message-ID: <20240829-fb7bda6b46302b65b2f89d20@orel>
References: <20240829033904.477200-1-nick.hu@sifive.com>
 <20240829033904.477200-2-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829033904.477200-2-nick.hu@sifive.com>

On Thu, Aug 29, 2024 at 11:38:59AM GMT, Nick Hu wrote:
> If the HW support the SSTC extension, we should save and restore the
> stimecmp register while cpu non retention suspend.
> 
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---
>  arch/riscv/include/asm/suspend.h |  4 ++++
>  arch/riscv/kernel/suspend.c      | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> index 4ffb022b097f..ffaac2efabb5 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -16,6 +16,10 @@ struct suspend_context {
>  	unsigned long envcfg;
>  	unsigned long tvec;
>  	unsigned long ie;
> +#if __riscv_xlen < 64
> +	unsigned long stimecmph;
> +#endif

I'm not sure the reduction in struct size is worth the #ifdeffery. If we
just always add stimecmph, then we can also change the #ifdef's below to
if's, i.e. if (__riscv_xlen < 64), which should still remove the code from
64-bit builds.

Or maybe we need something like

#if __riscv_xlen < 64
#define csrh_write(r, v) csr_write(r, v)
#else
#define csrh_write(r, v)
#endif

in asm/csr.h and then use it for all the *h csrs, but keep the #if in
the struct.

Thanks,
drew

> +	unsigned long stimecmp;
>  #ifdef CONFIG_MMU
>  	unsigned long satp;
>  #endif
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index c8cec0cc5833..3afd86e1abf7 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -19,6 +19,12 @@ void suspend_save_csrs(struct suspend_context *context)
>  	context->tvec = csr_read(CSR_TVEC);
>  	context->ie = csr_read(CSR_IE);
>  
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> +		context->stimecmp = csr_read(CSR_STIMECMP);
> +#if __riscv_xlen < 64
> +		context->stimecmph = csr_read(CSR_STIMECMPH);
> +#endif
> +	}
>  	/*
>  	 * No need to save/restore IP CSR (i.e. MIP or SIP) because:
>  	 *
> @@ -42,6 +48,13 @@ void suspend_restore_csrs(struct suspend_context *context)
>  	csr_write(CSR_TVEC, context->tvec);
>  	csr_write(CSR_IE, context->ie);
>  
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> +		csr_write(CSR_STIMECMP, context->stimecmp);
> +#if __riscv_xlen < 64
> +		csr_write(CSR_STIMECMPH, context->stimecmph);
> +#endif
> +	}
> +
>  #ifdef CONFIG_MMU
>  	csr_write(CSR_SATP, context->satp);
>  #endif
> -- 
> 2.34.1
> 

