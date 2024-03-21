Return-Path: <linux-pm+bounces-5203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A288641C
	for <lists+linux-pm@lfdr.de>; Fri, 22 Mar 2024 00:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CDA284217
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 23:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED11DFD2;
	Thu, 21 Mar 2024 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DP54qrRT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74881DFCF
	for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065097; cv=none; b=gi5G+61W6LvrbqNPmjSMHTD1D37Jfnjx4SLKTYyl3gInHukiPkKH+Qen1iq/9MhGQA86rfuJfP+xcusvmJmUpr1NQ78p5lrvigI86bsB+F4tjTfKRY0npM28kUwgm5s0X9KBA/irUkxo+NTNOqt2A/BR+pHJ9SZcxatVA4Bp1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065097; c=relaxed/simple;
	bh=xW80rWOlFHvVSoFt0FE2CMnMtCrSafEX4MbK88/mY5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/73YEXOKsT5/tOcDWA3hMBn5pJsQDdKpQQbCsrnESqdgAkyc8+gBW8WaDDR0jstl22N7OCd7oXSVaYAoaMUctI+Twqz8Z5vwgbx0HxWEQggQjNbe/0eGfxwhARtsM3LADmtD4P7sLnETfoA/0l0G3+xcgKap2BRl9YqQF8m5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DP54qrRT; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cf01066448so61102039f.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 16:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711065093; x=1711669893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNqlzzs3C3okF1Ihs4S4kvN5WrFgjE+GlyvdPE0dOGo=;
        b=DP54qrRTYYqyASdalC9kq72lU1wWtpzCs0Ru7p2AHu1ONctSNu140YEjzlXpuGOnuI
         D1zDB17CJXnYj6A+WEcunVteD1yJHvk8HWstDZ3ZU/u3jhLJnkE7rU2ZkuxpB+6EcX8O
         AQGon8LDmL3+iO54Z85lNqRzZVMUbyu6Zz/2OsQYp60Ex/8TUCDPf+kFIEa5stLAvRWG
         OxrcMw4NCAEtwAYHcOnjmwD+FcyhDXx1RQMt9RYhSY7pRrfc3jblIjmVvsxZr9sj2mTE
         kyWH9a/wlYrFivg5+IyRnw/4er9qQZqFB3T1nxeO2EiERw0hP+Gf7o256gW7LmshCoAL
         fHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711065093; x=1711669893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNqlzzs3C3okF1Ihs4S4kvN5WrFgjE+GlyvdPE0dOGo=;
        b=WgNLNTOKEY5bDx4I4ZKJfPb6SrWNOSwW1mbaQSBjjILHCFkhQ5nZqOZ5121D+CVwTf
         h0Nv4PavNUpE+PYHcJuXh5GO9jmD9qg3oVO12iaVX41jsq4tY7Ty072c7VFxwen4DSEs
         44OPBbQ/PwKtWYcZqv2nMXgT+FtxK12TK930SR5YCdmup3qheC+j8PyaduMW3iL1axf4
         tV+Zi3R2wvWI2reezGHjCVaP9pS6Y+sOUKwhtIf33qbd+I6C1F6gfyk+cUJxX7xdU6ir
         HY0wyxqyXX9RQ9hWFHLhnTljIu3BUOJ6kwxqLzmgs/25PqDWY0o8hJlTTM1kTDZMmja6
         5qjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3Pd8PII/rgAevjkmjiYy20kRmP1mXcCeUvS7i2YrfD/6bf8ANDNJ9K+gHBtVLRDFny2It59a6SbWYVD82uZLaO+j/Wn24Xw0=
X-Gm-Message-State: AOJu0Yxm/Gw2beGSkdGnYmsVdtHy3BX9MWziQACDdJ8WZu1yoFJct+cL
	4oCfLLf1oTXbxQiJu8np73qLNvs8BhQ2JquxKqpNXD6b03xb+NwdFfO93NouoF8=
X-Google-Smtp-Source: AGHT+IG8c+yACk8/X3Es/Xp0PMdBsSuZwh0qwYwidFyL/zRGltJfSOCF3y2cOWM1wkvDI9gGTrG31A==
X-Received: by 2002:a92:dcce:0:b0:366:40dc:4d99 with SMTP id b14-20020a92dcce000000b0036640dc4d99mr986208ilr.30.1711065092945;
        Thu, 21 Mar 2024 16:51:32 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id t5-20020a92cc45000000b00366b66af14asm237709ilq.17.2024.03.21.16.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 16:51:32 -0700 (PDT)
Message-ID: <3010bb57-c13f-494a-9e8c-0ae6393b1eee@sifive.com>
Date: Thu, 21 Mar 2024 18:51:31 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Do not save the scratch CSR during suspend
Content-Language: en-US
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Andrew Jones
 <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>,
 Leyfoon Tan <leyfoon.tan@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Pavel Machek <pavel@ucw.cz>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20240312195641.1830521-1-samuel.holland@sifive.com>
 <BJSPR01MB0561EC63D6654543D1266AD79C28A@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <BJSPR01MB0561EC63D6654543D1266AD79C28A@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-14 11:55 PM, JeeHeng Sia wrote:
> 
> 
>> -----Original Message-----
>> From: Samuel Holland <samuel.holland@sifive.com>
>> Sent: Wednesday, March 13, 2024 3:57 AM
>> To: Palmer Dabbelt <palmer@dabbelt.com>; linux-riscv@lists.infradead.org
>> Cc: Samuel Holland <samuel.holland@sifive.com>; Albert Ou <aou@eecs.berkeley.edu>; Andrew Jones <ajones@ventanamicro.com>;
>> Conor Dooley <conor.dooley@microchip.com>; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Paul Walmsley
>> <paul.walmsley@sifive.com>; Pavel Machek <pavel@ucw.cz>; Rafael J. Wysocki <rafael@kernel.org>; JeeHeng Sia
>> <jeeheng.sia@starfivetech.com>; linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org
>> Subject: [PATCH] riscv: Do not save the scratch CSR during suspend
>>
>> While the processor is executing kernel code, the value of the scratch
>> CSR is always zero, so there is no need to save the value. Continue to
>> write the CSR during the resume flow, so we do not rely on firmware to
>> initialize it.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  arch/riscv/include/asm/suspend.h | 1 -
>>  arch/riscv/kernel/suspend.c      | 3 +--
>>  2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
>> index 491296a335d0..6569eefacf38 100644
>> --- a/arch/riscv/include/asm/suspend.h
>> +++ b/arch/riscv/include/asm/suspend.h
>> @@ -13,7 +13,6 @@ struct suspend_context {
>>  	/* Saved and restored by low-level functions */
>>  	struct pt_regs regs;
>>  	/* Saved and restored by high-level functions */
>> -	unsigned long scratch;
>>  	unsigned long envcfg;
>>  	unsigned long tvec;
>>  	unsigned long ie;
>> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
>> index 299795341e8a..3d306d8a253d 100644
>> --- a/arch/riscv/kernel/suspend.c
>> +++ b/arch/riscv/kernel/suspend.c
>> @@ -14,7 +14,6 @@
>>
>>  void suspend_save_csrs(struct suspend_context *context)
>>  {
>> -	context->scratch = csr_read(CSR_SCRATCH);
>>  	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
>>  		context->envcfg = csr_read(CSR_ENVCFG);
>>  	context->tvec = csr_read(CSR_TVEC);
>> @@ -37,7 +36,7 @@ void suspend_save_csrs(struct suspend_context *context)
>>
>>  void suspend_restore_csrs(struct suspend_context *context)
>>  {
>> -	csr_write(CSR_SCRATCH, context->scratch);
>> +	csr_write(CSR_SCRATCH, 0);
> If the register is always zero, do we need to explicitly write zero to the register during resume?

The register contains zero while executing in the kernel. While executing in
userspace, the value is nonzero. The value is checked at the beginning of
handle_exception(). We must ensure the value is zero before enabling interrupts,
or we might incorrectly think the interrupt was entered from userspace.

We don't know what the value will be when the hart comes out of non-retentive
suspend. Per the SBI HSM specification, Table 6: "All other registers remain in
an undefined state."

Regards,
Samuel


