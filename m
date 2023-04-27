Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835006F0405
	for <lists+linux-pm@lfdr.de>; Thu, 27 Apr 2023 12:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbjD0KRH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Apr 2023 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbjD0KRG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2023 06:17:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546B892
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 03:17:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f199696149so40235755e9.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682590624; x=1685182624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fCr7nxgZdtNgoZF3nwDaoR8EhaDUD1018YOuyMDPn0M=;
        b=nb8Q8tD1nIJFKBRaeqZgFGy1lZJlY0qdoheP8R6kS3cggDhpwtqqOCEa9kF2ESL6Mm
         CMOPLp3YmsrbjTTWQCmqEkBqnE0Cko+vanfvRsU1GpABlmltLHLdY3hg3hx1QLDePeeY
         CIOM0vNHV2JoK9c/jw7vJ/6H6xF+mOYTy+D0vHFRCzd94eWHFd/gL/0sb57vdAciXnjx
         0fkpjXbK5QhRiryMydeIJBDvqmIa5leb1kF7ZN5cbh4wk4NDuGnx+N6Y7VyL0i324kWJ
         6y8hg50AOLykRR5OmMCfxDmzN+Tp+Pkjfm/uPbfH0R6vV1LlRgFXA4jxrQkQCOkj3tSG
         ULiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590624; x=1685182624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCr7nxgZdtNgoZF3nwDaoR8EhaDUD1018YOuyMDPn0M=;
        b=DLh3a64RufH55LMs8xozHxsckKk7pZ8oN7qyk9p0aWC5MxXpSKKXa3A8MF649THNxv
         QHRD02nyE9pJ9CABQDpIJWR4UCMQ+v8fiSnjCZNc/8JlxvLKgaLozNlpjQoNuL4sv3mO
         3ZUDMvNcSOWA+DzItSXEexP8/ASar0qlABLHS+/caXiqIdDFhQFWJt+3qVYCI2ZcFP5H
         E5TTEfDfhHhG44pVtTWqEjXZmOOnmajOqCWXG0aeSqVDvhbaGt2446Uy4RgcqrGJIjLt
         +Eszia/SPbhR60FFF6mBOvYZQUhGjh2z9uk/qfvRGyzAuOZGiKSTNIJPZjcZPJQwUeTY
         oWVw==
X-Gm-Message-State: AC+VfDxHi2vdSXOi61k/EBm2NozUBzGurPJrP3IdPgnPy3QkbOt5m2tZ
        cI9c05jZ0+uc6otWmjYHF07AVA==
X-Google-Smtp-Source: ACHHUZ6rCA7RMC27lWLkLmHmUzbmL++yuI4efJgiJ/la+yAMoCft0kvm8nOs+UwFRahE78kBJ3vEdA==
X-Received: by 2002:a05:600c:2285:b0:3f1:7123:5f82 with SMTP id 5-20020a05600c228500b003f171235f82mr1021868wmf.12.1682590623728;
        Thu, 27 Apr 2023 03:17:03 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ip29-20020a05600ca69d00b003f1712b1402sm24107405wmb.30.2023.04.27.03.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:17:03 -0700 (PDT)
Date:   Thu, 27 Apr 2023 12:17:02 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm-riscv@lists.infradead.org,
        "'Rafael J . Wysocki '" <rafael@kernel.org>,
        'Will Deacon ' <will@kernel.org>,
        'Daniel Lezcano ' <daniel.lezcano@linaro.org>,
        'Mark Rutland ' <mark.rutland@arm.com>,
        'Atish Patra ' <atishp@atishpatra.org>,
        'Palmer Dabbelt ' <palmer@dabbelt.com>,
        'Anup Patel ' <anup@brainfault.org>,
        'Albert Ou ' <aou@eecs.berkeley.edu>,
        'Paul Walmsley ' <paul.walmsley@sifive.com>
Subject: Re: [PATCH] RISC-V: Align SBI probe implementation with spec
Message-ID: <ryknbllu75eliur7v6tzei6jvqgwayuhej5icobxxrqwabymhz@lnnqmlrqxvex>
References: <20230426172254.70342-1-ajones@ventanamicro.com>
 <20230427-property-barracuda-631a14371df0@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427-property-barracuda-631a14371df0@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 27, 2023 at 10:42:11AM +0100, Conor Dooley wrote:
> On Wed, Apr 26, 2023 at 07:22:54PM +0200, Andrew Jones wrote:
> > sbi_probe_extension() is specified with "Returns 0 if the given SBI
> > extension ID (EID) is not available, or 1 if it is available unless
> > defined as any other non-zero value by the implementation."
> > Additionally, sbiret.value is a long. Fix the implementation to
> > ensure any nonzero long value is considered a success, rather
> > than only positive int values.
> 
> Does this need a fixes tag (or tags) then, since we could easily return
> a negative value as things stand if the SBI implementation decides to
> return 0b1...1 for success?

Nothing is getting fixed when only considering the current generic opensbi
platform, but there could be other SBI implementations Linux isn't
handling correctly by only considering success to be greater than zero
or by truncating the return value from long to int. I suppose that
possibility does warrant a fix tag, which would be

Fixes: b9dcd9e41587 ("RISC-V: Add basic support for SBI v0.2")

> 
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/sbi.h        |  2 +-
> >  arch/riscv/kernel/cpu_ops.c         |  2 +-
> >  arch/riscv/kernel/sbi.c             | 17 ++++++++---------
> >  arch/riscv/kvm/main.c               |  2 +-
> >  drivers/cpuidle/cpuidle-riscv-sbi.c |  2 +-
> >  drivers/perf/riscv_pmu_sbi.c        |  2 +-
> >  6 files changed, 13 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index 945b7be249c1..119355485703 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -296,7 +296,7 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
> >  				unsigned long start,
> >  				unsigned long size,
> >  				unsigned long asid);
> > -int sbi_probe_extension(int ext);
> > +long sbi_probe_extension(int ext);
> >  
> >  /* Check if current SBI specification version is 0.1 or not */
> >  static inline int sbi_spec_is_0_1(void)
> > diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> > index 8275f237a59d..eb479a88a954 100644
> > --- a/arch/riscv/kernel/cpu_ops.c
> > +++ b/arch/riscv/kernel/cpu_ops.c
> > @@ -27,7 +27,7 @@ const struct cpu_operations cpu_ops_spinwait = {
> >  void __init cpu_set_ops(int cpuid)
> >  {
> >  #if IS_ENABLED(CONFIG_RISCV_SBI)
> > -	if (sbi_probe_extension(SBI_EXT_HSM) > 0) {
> > +	if (sbi_probe_extension(SBI_EXT_HSM)) {
> >  		if (!cpuid)
> >  			pr_info("SBI HSM extension detected\n");
> >  		cpu_ops[cpuid] = &cpu_ops_sbi;
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 5c87db8fdff2..015ce8eef2de 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -581,19 +581,18 @@ static void sbi_srst_power_off(void)
> >   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
> >   * @extid: The extension ID to be probed.
> >   *
> > - * Return: Extension specific nonzero value f yes, -ENOTSUPP otherwise.
> > + * Return: 1 or an extension specific nonzero value if yes, 0 otherwise.
> >   */
> > -int sbi_probe_extension(int extid)
> > +long sbi_probe_extension(int extid)
> >  {
> >  	struct sbiret ret;
> >  
> >  	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, extid,
> >  			0, 0, 0, 0, 0);
> >  	if (!ret.error)
> > -		if (ret.value)
> > -			return ret.value;
> > +		return ret.value;
> >  
> > -	return -ENOTSUPP;
> > +	return 0;
> 
> Why not make it return -ENOTSUPP for failures and 0 for success instead,
> as it does not appear that any users actually care what the return value
> is, once it is not an error?

Just to prepare for theoretical new uses.

> Concerned that it'll look weird to have
> 	if(!sbi_probe_extension(foo))
> 		print(foo is available!)
> since it looks a bit weird that the !case is success?

No, that's pretty par for the course in the kernel. I'd just prefer
that sbi_probe_extension() be a simple wrapper around the SBI call,
one that doesn't change the SBI call's return value semantics.

> 
> If so, perhaps it could just return a bool instead, unless of course I
> am missing some pending user that make some decision on the actual value
> returned here is.

No pending user that I'm aware of, but it's not too awkward, IMO, to
implement this as the spec says, so any pending user that comes along
will be happy from the start. If a boolean function seems better for
everyone, then I'd probably extend this patch to also rename this
sbi_probe_extension to __sbi_probe_extension, make it static, and
then add

 bool sbi_probe_extension(int extid)
 {
   return __sbi_probe_extension(extid);
 }

just to feel good about the wrapper!

Thanks,
drew
