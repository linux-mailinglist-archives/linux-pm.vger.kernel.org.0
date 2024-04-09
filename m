Return-Path: <linux-pm+bounces-6126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E7A89E3DB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 21:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32DF284E52
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 19:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824F1157A60;
	Tue,  9 Apr 2024 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="ZbvEcdaq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E591E89E
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691835; cv=none; b=eUhvoDNLYTl4whfnIHIQZ6m7aBdnnMR4jqItEo602Ei2+wS4JTP+PGcJL20GltaUJ+87QRVOUIXKlBTPI/1QphvEzTyeWwPXrasugbx9jaEfRLyymTkPu5VAHpD3gu/chTfHd52SZ/vg4aJTo7U/AIjFsqz6uuqHlYaruOuIqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691835; c=relaxed/simple;
	bh=ACQcM30tSW2SL5zP4ycccQREhmMc4+KanOtj6bG1ZDQ=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=TJ2tIAQBsaAMo8irTiYE22csO93kOtNqcX560h62raCjJ8RhGan6/fE6l4/mkZ53q02ElojQXXcolxFytFZfCiQP6qPh6vZEu3tJRIVOkyBvQSrCxSnP3E4eCYIW6KzwTZIrOx+7LTIwVJ2vJfFKrw2C53oEcp1LCWe6IX2ElO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=ZbvEcdaq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecf3f001c5so4931016b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2024 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1712691832; x=1713296632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h53B27ecNHID1eXdf2FDHGt3AvdzJKoL8em24LSk0zk=;
        b=ZbvEcdaqUPQxI09RNQvCDr9EtwLlg4uwXWETl5zVtR2SPYZJt74XGHRDSU4MU+1iSf
         zfOBJhTHPuyqp+/MmkaqgPfkMAgpStrExjZiP/pVPG7BBQw/cXCLV1J2Tja/nS6giG/c
         qHkTjOayRfg7iOGeY2QFvXupYOzHHJFP18M53MriGYyrTqQPHDg5TPmr5ksdgfCwAkqL
         LT5Za9vPRNqpRfP2G+/8rv/ZJ/p9/p+hXK4qxWrcVD8927WH2gRxOshwJLWHC/B1+prW
         gZNSp1xxFI3/Py3StBvbBSyvV3VH99mLfQbjGYi31y6BUmEp5gqx/+dfvNVyVVc8b8aK
         5rwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712691832; x=1713296632;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h53B27ecNHID1eXdf2FDHGt3AvdzJKoL8em24LSk0zk=;
        b=LfRmiyYIKue3imiqPYLFNcE5F1U5QOM33CcWUh19lGgkAD0+FlX2AapsVB+Vy3gssf
         S1rHr2UlB5amTX5OuzC6ITj2NVltR/QvwqIqFCpMTgfKltdLi9HxZhcDGlJLxIdjxaLp
         +WQnTM8zvwYJ6b+T3PWpQEkCgnjfU2RshMmEuuMMBQBLmBPFxWJK127+sbiz1c+Y2Snm
         GgyHuMVZityAXEeitkuwzk8MDr/guIGPdTYJ1uFCx4vKXxl3deQz8dph/SrutxxCLgt2
         0T2cNnBCMoKKn27WhZpJ3XdV5DwpbUEIU6qKDgKb+g3pC6rAj+sO6XCNy8a2sBsMBF94
         iTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqtrL82pZ2LUCPsZDnCgLRxqLV+eZlvrUj3AEG7birGGVGYKSozyfo3Ll2O2FcX1FIRF3hDPLT+JsHa9XTW2xy14fgBrOh9vQ=
X-Gm-Message-State: AOJu0YyyYPqQudhJkAP/kQA1K45bwkxoYU03xgD/gerYvvOFDlNFVpCx
	6b/DgHFjbe2BsVQ2TLc85Tscyj9+yDp1+n/xa0y7fo+RwuHE46JosNHrL0MdBPo=
X-Google-Smtp-Source: AGHT+IFBDhalit5CBUtLdP+oCW6gPaGZXDYApBZDPMr2GixfOhzhLUtkHUNZ/dpRhZzvWQ/JDO1haw==
X-Received: by 2002:a05:6a00:22c3:b0:6ed:1c7:8c6b with SMTP id f3-20020a056a0022c300b006ed01c78c6bmr588864pfj.1.1712691832230;
        Tue, 09 Apr 2024 12:43:52 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id y10-20020aa79e0a000000b006ecf217a5e1sm8655966pfq.189.2024.04.09.12.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 12:43:51 -0700 (PDT)
Date: Tue, 09 Apr 2024 12:43:51 -0700 (PDT)
X-Google-Original-Date: Tue, 09 Apr 2024 12:43:49 PDT (-0700)
Subject:     Re: [PATCH] riscv: Do not save the scratch CSR during suspend
In-Reply-To: <3010bb57-c13f-494a-9e8c-0ae6393b1eee@sifive.com>
CC: jeeheng.sia@starfivetech.com, linux-riscv@lists.infradead.org,
  aou@eecs.berkeley.edu, ajones@ventanamicro.com, Conor Dooley <conor.dooley@microchip.com>,
  leyfoon.tan@starfivetech.com, Paul Walmsley <paul.walmsley@sifive.com>, pavel@ucw.cz, rafael@kernel.org,
  linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: samuel.holland@sifive.com
Message-ID: <mhng-fa663ef4-be7b-455b-b467-f4d331a269ea@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 21 Mar 2024 16:51:31 PDT (-0700), samuel.holland@sifive.com wrote:
> On 2024-03-14 11:55 PM, JeeHeng Sia wrote:
>>
>>
>>> -----Original Message-----
>>> From: Samuel Holland <samuel.holland@sifive.com>
>>> Sent: Wednesday, March 13, 2024 3:57 AM
>>> To: Palmer Dabbelt <palmer@dabbelt.com>; linux-riscv@lists.infradead.org
>>> Cc: Samuel Holland <samuel.holland@sifive.com>; Albert Ou <aou@eecs.berkeley.edu>; Andrew Jones <ajones@ventanamicro.com>;
>>> Conor Dooley <conor.dooley@microchip.com>; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Paul Walmsley
>>> <paul.walmsley@sifive.com>; Pavel Machek <pavel@ucw.cz>; Rafael J. Wysocki <rafael@kernel.org>; JeeHeng Sia
>>> <jeeheng.sia@starfivetech.com>; linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org
>>> Subject: [PATCH] riscv: Do not save the scratch CSR during suspend
>>>
>>> While the processor is executing kernel code, the value of the scratch
>>> CSR is always zero, so there is no need to save the value. Continue to
>>> write the CSR during the resume flow, so we do not rely on firmware to
>>> initialize it.
>>>
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>> ---
>>>
>>>  arch/riscv/include/asm/suspend.h | 1 -
>>>  arch/riscv/kernel/suspend.c      | 3 +--
>>>  2 files changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
>>> index 491296a335d0..6569eefacf38 100644
>>> --- a/arch/riscv/include/asm/suspend.h
>>> +++ b/arch/riscv/include/asm/suspend.h
>>> @@ -13,7 +13,6 @@ struct suspend_context {
>>>  	/* Saved and restored by low-level functions */
>>>  	struct pt_regs regs;
>>>  	/* Saved and restored by high-level functions */
>>> -	unsigned long scratch;
>>>  	unsigned long envcfg;
>>>  	unsigned long tvec;
>>>  	unsigned long ie;
>>> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
>>> index 299795341e8a..3d306d8a253d 100644
>>> --- a/arch/riscv/kernel/suspend.c
>>> +++ b/arch/riscv/kernel/suspend.c
>>> @@ -14,7 +14,6 @@
>>>
>>>  void suspend_save_csrs(struct suspend_context *context)
>>>  {
>>> -	context->scratch = csr_read(CSR_SCRATCH);
>>>  	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
>>>  		context->envcfg = csr_read(CSR_ENVCFG);
>>>  	context->tvec = csr_read(CSR_TVEC);
>>> @@ -37,7 +36,7 @@ void suspend_save_csrs(struct suspend_context *context)
>>>
>>>  void suspend_restore_csrs(struct suspend_context *context)
>>>  {
>>> -	csr_write(CSR_SCRATCH, context->scratch);
>>> +	csr_write(CSR_SCRATCH, 0);
>> If the register is always zero, do we need to explicitly write zero to the register during resume?
>
> The register contains zero while executing in the kernel. While executing in
> userspace, the value is nonzero. The value is checked at the beginning of
> handle_exception(). We must ensure the value is zero before enabling interrupts,
> or we might incorrectly think the interrupt was entered from userspace.
>
> We don't know what the value will be when the hart comes out of non-retentive
> suspend. Per the SBI HSM specification, Table 6: "All other registers remain in
> an undefined state."

We're also not setting it at all in `.macro suspend_restore_csrs`, which 
I think is just a bug?

That said, I'm kind of seeing bugs everywhere I look in this now -- what 
about all the other registers we can poke, like timers/counters or the 
V/F state (or anything from M-mode, though maybe that's just someone 
else's problem)?

I also think we'd break on medlow kernels, as a bunch of this relies on 
medany-as-PIC for the SATP-off transition.

Maybe I'm going crazy here, though...

> Regards,
> Samuel

