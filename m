Return-Path: <linux-pm+bounces-14784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4140986E66
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 09:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2611F22015
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F3C1925AC;
	Thu, 26 Sep 2024 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="M1YLduvK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8B192586
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337579; cv=none; b=B0ZbWmr/g5WgVBbM3Tw6KPd1mhCG3wGWHtc2Xa6gye8vPkZ004OC00B1dODjiCX6Nj8Ekn+GK1NoHM+5ivmIA3+nsDugqYPKh3M/q/XF3ODQa8uV31KgHsZY6PeP97Ztgn/ddVUvsALHNOPFs9UWjI4xQp2NBOIS+t1KkURGwXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337579; c=relaxed/simple;
	bh=PYpD0W40WiTPGYYolxMwxzjtPuxE2bqs82HjAE2I/Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4jhZsurtIJEQQeWSad8EBu5uoBFi/LPlzjffy8cK6VSvldShPIslf/yXZNSRtgR+P3ZwPbz2FcnQ0rAa1hfqFGLeKFGwKMp1P9Tg9IXGKNZSoObY9MasiK2/F35xg7cmV52tZI3xusSG7uXoMNAXCxverQX29hXalcn0k+//OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=M1YLduvK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso6172995e9.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 00:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1727337576; x=1727942376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PpCiGEBlNu0mNZ7okeDi8cYacva/g1Cbr0GdHobTz6g=;
        b=M1YLduvKvEyYp+Y46od5eQP3WFtaxXqvfCYew7xjs9qqwIAS476yXzvDw6ZL/yMRSb
         guO3G/PGQjI7ANW/tp7QvCrhs7brvt2k9jcMYGr23WdV6L+gtl5ksAL61ie0Z5/TiGAd
         CzIeEMIaNoJrOqEDedQazcxpRq5gsikDwqgMAp53f4axofQUeVJ+uQQxckPHTTmKxDuH
         TM7Cbq2CDvI+qYmfmvl8ER/KkeoT95cnZzv4yaTmCG3+ui7ODMWGkPFfB3ueiAd8xcyH
         llv5qLn5Aj/i3P4tc6XsCNebVopKOljjbznM9hJfBxCK7eqt2Ukazd+oWLmkR5HRdhiX
         5u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337576; x=1727942376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpCiGEBlNu0mNZ7okeDi8cYacva/g1Cbr0GdHobTz6g=;
        b=gn9esNUNpCOtqzgdK/d/RPF3OaIHAQfSLrwUwGETjJrCFsWDVZXCQwLp0NId+s5qeB
         15shR+vsoV5Sn/r0NiqeLAyimQzDhpmF9DLRyPhcpVybHxVYwPTCSIht7yl0vz4ZbmRx
         wYAx5EJQALKRfXT+GzqULDLw1KMVVXWZhTSujBKqGIVVcgAlS3WZkMPGVOGYT8zjhJWi
         cfgC87xqIuEusdzsuY+EndNejaipHs60DDfmSvvDvaa6mGaPu2WhNJAqfAecW7KX2jdt
         FQwrhgSILiuUmLIkgbv5DOjtT0a6ZjWBMEeN1ADsyXUxjuNFagi5tOQ2zk1TSIU/tWBj
         wXDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpxdRQEc0xqaSh2++YxP4mxNsiOqdgn2u/PEykaHB3xrretQRYa4C4RprwE9yTTxgUOpJVU6eBnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPo+ThUyj8+nKK8vf9ts9jhM6CHiGmYVJxGJxUub12Ndjh6oi
	mk4iU/mGTRQi4plhxrFGfF9HOuEqHevMAfOmvoRqQfGfMPxR/rzHk6dUHTY9Oj8=
X-Google-Smtp-Source: AGHT+IH7ivAeF8lcHIJrAIXadm6iyognSZRY/aTKpYZz3gkdQWtorWwQDRTmTAf88fh/VevbkacKBg==
X-Received: by 2002:adf:f64f:0:b0:37c:cbca:fd7c with SMTP id ffacd0b85a97d-37ccbcafe16mr2698906f8f.41.1727337576104;
        Thu, 26 Sep 2024 00:59:36 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd21129e6sm179018f8f.47.2024.09.26.00.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:59:35 -0700 (PDT)
Date: Thu, 26 Sep 2024 09:59:32 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Atish Patra <atishp@rivosinc.com>, Samuel Ortiz <sameo@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] riscv: Add csr_read/write_hi_lo support
Message-ID: <20240926-b96b7164b51b0be0c732235b@orel>
References: <20240926065422.226518-1-nick.hu@sifive.com>
 <20240926065422.226518-2-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926065422.226518-2-nick.hu@sifive.com>

On Thu, Sep 26, 2024 at 02:54:16PM GMT, Nick Hu wrote:
> In RV32, we may have the need to read both low 32 bit and high 32 bit of
> the CSR. Therefore adding the csr_read_hi_lo() and csr_write_hi_lo() to
> support such case.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Suggested-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---
>  arch/riscv/include/asm/csr.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 25966995da04..54198284eb22 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -501,6 +501,17 @@
>  	__v;							\
>  })
>  
> +#if __riscv_xlen < 64
> +#define csr_read_hi_lo(csr)					\
> +({								\
> +	u32 hi = csr_read(csr##H);				\
> +	u32 lo = csr_read(csr);					\
> +	lo | ((u64)hi << 32);					\
> +})
> +#else
> +#define csr_read_hi_lo	csr_read
> +#endif
> +
>  #define csr_write(csr, val)					\
>  ({								\
>  	unsigned long __v = (unsigned long)(val);		\
> @@ -509,6 +520,17 @@
>  			      : "memory");			\
>  })
>  
> +#if __riscv_xlen < 64
> +#define csr_write_hi_lo(csr, val)				\
> +({								\
> +	u64 _v = (u64)(val);					\
> +	csr_write(csr##H, (_v) >> 32);				\
> +	csr_write(csr, (_v));					\
> +})
> +#else
> +#define csr_write_hi_lo	csr_write
> +#endif
> +
>  #define csr_read_set(csr, val)					\
>  ({								\
>  	unsigned long __v = (unsigned long)(val);		\
> -- 
> 2.34.1
>

I know I suggested this, but I'm having second thoughts. The nice thing
about the

 csr_write(CSR, ...);
 if (__riscv_xlen < 64)
    csr_write(CSRH, ...);

pattern is that it matches the spec. With this helper we'll have

 csr_write_hi_lo(CSR, ...);

for both rv32 and rv64. That looks odd for rv64 and hides the hi register
access for rv32.

We could avoid the oddness of the helper's name for rv64 if we instead
added csr_write32 and csr_write64 which do the right things, but that
still hides the hi register access for rv32. Hiding the hi register
access is probably fine, though, since we can be pretty certain that
the spec will rarely, if ever, deviate from naming high registers with
the H suffix and/or not keep the upper bits compatible.

In summary, I think I'm in favor of just dropping this patch, keeping
the noisy, but explicit, pattern. Or, if the consensus is to add
helpers, then I'd rather have all csr_<op>32/64 helpers. Then, code
would match the spec by choosing the right helper based on the width
of the CSR being accessed, when the CSR has an explicit width, or still
use the current helpers for xlen-wide CSRs.

Thanks,
drew

