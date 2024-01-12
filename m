Return-Path: <linux-pm+bounces-2140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F93582BA96
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 06:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E88B1F26BAD
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 05:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53C45B5C1;
	Fri, 12 Jan 2024 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="LEsYPTBR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749955B5BD
	for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3606e211e5cso34329585ab.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 21:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1705035918; x=1705640718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8rappFKRLNOmh48iN1mvyDH+G2PtYqO6EungDZP0OA=;
        b=LEsYPTBRSt/FFR8y4cYlxuEQMUORzDfznVf2G+z3upMhR6M4NLs/6dHaWCmF1tFxPP
         P43ubGgrArnxnZjB7rOpi4c693BATZkpiQPGfJt6d7sBg62RtkA23uubGirVhr+lOzSI
         bRlk0sr6u0eOlpFm/xjYCam1ju7hPPRWA1hSuFQ/t57vWorUqUX8HGD3jl+MWcRm70Ie
         2VOY58niALvv4nQ0wFhb9Ve57j+TFFfQ1quYOyy/8446O6WgS/rT2PvxlJoAK5v3fEsy
         uedY16XFzEm42AKOZBme9TbnYYS1yTRRn8lKH+x9+2QPAEE6NRw+ZXXmYGH/So6EK0nC
         s15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705035918; x=1705640718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8rappFKRLNOmh48iN1mvyDH+G2PtYqO6EungDZP0OA=;
        b=gUjYCNOtQe2iFXC+Oze5NZDQeA3OXVafDZjEdh7KHlk8PvAopw39uKJq4/Cq2Ig2xe
         8ss/bljSj4vNkblBPM3h34puIGhehal2CJH5jSpGvTp5fnksIrpu92sg9JaV53lemg/N
         y1DJcdvIh6mTiJusYnxUJpE7IhhhvPR7FRrNJWKTH8+QtXM6xW7vTWg7MPqbmZP5BLxu
         vLn+kK1zXLmj6q08IMDw0SGOFV73AFtQmO4hXP2aYlUkKvYm9Y3oIRMovJc6sEY0ZEZj
         v9jcCUOJ+tdyb7Joz+e0jrBjao+dTk1Rf0N/7O0ycFEr3hSv7LN3TiQCu6oph8jDoxhw
         hlsQ==
X-Gm-Message-State: AOJu0Yz773CXEQJuY5HUPa9wDu5AJX+MyEbBt5DZfDXBfoyeSkCzTa9K
	M5PJ5eaRfzw3y83fHnfpqC859LsC9orlGJYJwCgthvc0DKSWiA==
X-Google-Smtp-Source: AGHT+IGCR28IRbastME/z+5U6vMfxuvFQ4GIlL0eywubg6xedGxnSa839M5nymwISZxw5wbZTYlIBpblsPmMoFP5VFI=
X-Received: by 2002:a05:6e02:20e8:b0:360:a0fc:cbdb with SMTP id
 q8-20020a056e0220e800b00360a0fccbdbmr582188ilv.66.1705035918451; Thu, 11 Jan
 2024 21:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111093058.121838-1-sunilvl@ventanamicro.com> <20240111093058.121838-3-sunilvl@ventanamicro.com>
In-Reply-To: <20240111093058.121838-3-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 12 Jan 2024 10:35:07 +0530
Message-ID: <CAAhSdy22JrFOS8V-FC=ZCQiybhcJCszxy_TsnGAzuzYA06Mw7Q@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] cpuidle: RISC-V: Add ACPI LPI support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Kumar Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 3:01=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Add required callbacks to support Low Power Idle (LPI) on ACPI based
> RISC-V platforms.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 78 +++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index e8094fc92491..cea67a54ab39 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -632,3 +632,81 @@ static int __init sbi_cpuidle_init(void)
>         return 0;
>  }
>  device_initcall(sbi_cpuidle_init);
> +
> +#ifdef CONFIG_ACPI_PROCESSOR_IDLE
> +
> +#include <linux/acpi.h>
> +#include <acpi/processor.h>
> +
> +#define RISCV_FFH_LPI_TYPE_MASK                0x1000000000000000ULL
> +#define RISCV_FFH_LPI_RSVD_MASK                0x0FFFFFFF00000000ULL
> +
> +static int acpi_cpu_init_idle(unsigned int cpu)
> +{
> +       int i;
> +       struct acpi_lpi_state *lpi;
> +       struct acpi_processor *pr =3D per_cpu(processors, cpu);
> +
> +       if (unlikely(!pr || !pr->flags.has_lpi))
> +               return -EINVAL;
> +
> +       /*
> +        * The SBI HSM suspend function is only available when:
> +        * 1) SBI version is 0.3 or higher
> +        * 2) SBI HSM extension is available
> +        */
> +       if (sbi_spec_version < sbi_mk_version(0, 3) ||
> +           !sbi_probe_extension(SBI_EXT_HSM)) {
> +               pr_warn("HSM suspend not available\n");
> +               return -EINVAL;
> +       }
> +
> +       if (pr->power.count <=3D 1)
> +               return -ENODEV;
> +
> +       for (i =3D 1; i < pr->power.count; i++) {
> +               u32 state;
> +
> +               lpi =3D &pr->power.lpi_states[i];
> +
> +               /* Validate Entry Method as per FFH spec.
> +                * bits[63:60] should be 0x1
> +                * bits[59:32] should be 0x0
> +                * bits[31:0] represent a SBI power_state
> +                */
> +               if (!(lpi->address & RISCV_FFH_LPI_TYPE_MASK) ||
> +                   (lpi->address & RISCV_FFH_LPI_RSVD_MASK)) {
> +                       pr_warn("Invalid LPI entry method %#llx\n", lpi->=
address);
> +                       return -EINVAL;
> +               }
> +
> +               state =3D lpi->address;
> +               if (!sbi_suspend_state_is_valid(state)) {
> +                       pr_warn("Invalid SBI power state %#x\n", state);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +int acpi_processor_ffh_lpi_probe(unsigned int cpu)
> +{
> +       return acpi_cpu_init_idle(cpu);
> +}
> +
> +int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
> +{
> +       u32 state =3D lpi->address;
> +
> +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
> +               return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend,
> +                                                  lpi->index,
> +                                                  state);
> +       else
> +               return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
> +                                                            lpi->index,
> +                                                            state);
> +}
> +
> +#endif

Lets keep the cpuidle-riscv-sbi.c driver focused on DT only. Instead,
I would suggest moving the required function from cpuidle-riscv-sbi.c
to arch/riscv and have a separate driver under driver/acpi/riscv for
LPI states.

Regards,
Anup

