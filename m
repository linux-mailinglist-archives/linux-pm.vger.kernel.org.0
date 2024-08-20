Return-Path: <linux-pm+bounces-12561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9FE958546
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 12:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A4E2B20BDF
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 10:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF2818C018;
	Tue, 20 Aug 2024 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="0dvXp3s6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FD618E375
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151424; cv=none; b=LebTZGtEA2L1+O88enJUk6LRlXLqNlTwIETnrN2LZnRc9L99+cAoOFidtRkrNcQxDNwevgIyjt8hZpExG9ugkXoZOuG6D04u9YZh8WnovrjVmTkRITgZCfcRu4nSS1+kEtDR1Nn5RffL6+KLEPtNq2ZNMu/WOC3aEN9ZM0ojIOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151424; c=relaxed/simple;
	bh=wJ/EB1HWMzhF4m0C7qiWLBhs6DSBzQo5Xmg8Fm+BOng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEkm6GgEbw7/CN5wLuGRaYm3/wgIf4W5fyR89zAFU33CpyjGQFaNpWTxeELN+Etsrkt81CBfGaQbPt8SDe2lVzK71JjzahabB+q8qL9/vaZhBobHzzCerXO3GZQo8v2mECjJ+jApcrKPEM0FeLJ51En2W+rQZ8DrWlX9UvxvgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=0dvXp3s6; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d2256ee11so17379985ab.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 03:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1724151421; x=1724756221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9KVEQdhyyAo4Un7hmmWmcdbUoZrm1lWEAKevA08iqI=;
        b=0dvXp3s6oXijujqOcHnrNGxDOsx8amo8H9HPaqcVCa7AcMPqLcMSyNkg4Mw2F+i7h2
         BMOI1oiivYvbzqsfCrDhM5udaW5iB8JLY5E/mApkJx0FnuJYQhGnyARkbfS6YReDbDk+
         /x4RptYPriJmYKj3XMgNYxineYvyi4oc6QoISxw04oP9wrCSN3DpR6AYXJev+bc/0JZR
         LhrUxXQnV2kHunPU8UYsdTgYH9BhXV7R5ng8hLURZ/ITWa23qHgEaJH2Bc19I2fG84Hm
         0PUZbIQ2wgLPuC+N7Jyskpp6A42Jgb8O85kiU2kOyRZ6r+L7KQK/e9K4nhKwah3Dz53I
         DQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724151421; x=1724756221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9KVEQdhyyAo4Un7hmmWmcdbUoZrm1lWEAKevA08iqI=;
        b=Eyq/g1zLR4b59mbhRooHBe9uqkSZwZt9LEb+VMw6O6EqaU9p65bpWooouqm2ZrC+zW
         zL8bHwdS916x5uH2kBRse3ICg/f6FfkrZVbhyqSbdD47DvGnWhIiZwUZM2bG8zwpKaZA
         cgy9HRyA6As+jPeBkCkTtWRymb+gY26cTBxaLbYGCyKLUc2FiSJXk07CN+mIm7nrkrFz
         QZtQ/NVaArGDqQetWjLTMaAWnk9t07PN106mjrbhUDJIlo9LDbPfGeVm1dIOJEOW/Ube
         wyDvIx7GoTSw9aasopDquRiTSws6DOEwCtl521rcrN+TV6+R3GueRWZ7JDTCPnNilO4A
         9wsw==
X-Forwarded-Encrypted: i=1; AJvYcCUfXOklosXS6w2bLfrj/eR4hhZd7hztKK9VGN671zrLELa6T6TiCYfShkY7q8zlLXC1js2dc5wlaFM+5YTEIEO3bIkbDUHCflU=
X-Gm-Message-State: AOJu0YxXOWepPBxhYlv9WamqliOA9W9/Z7XMaqtFmSZxJpL0q41LDeLb
	EEafl0RsSZD71DZOtMGwVyvvKqBskswbkHLX3b8uI69Fa6qBwwvhkqUQHDiwi255DmigK/ON0OP
	Ztu6fUkSe3AbuCpamIwDqGkfNkD6bFY3RE7t0mg==
X-Google-Smtp-Source: AGHT+IF2qDXSD4GVokjV6QN9az33dHDjsKXPFgDYvoXoazydu4xSf7m7DCbKo2VqzmL8osOIuRjyhQlDzHCItoRiOOw=
X-Received: by 2002:a05:6e02:1986:b0:39d:637f:97cd with SMTP id
 e9e14a558f8ab-39d637f9a2cmr5860365ab.0.1724151421518; Tue, 20 Aug 2024
 03:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820094023.61155-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240820094023.61155-1-krzysztof.kozlowski@linaro.org>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 20 Aug 2024 16:26:49 +0530
Message-ID: <CAAhSdy3S_QTBzCNtj8kKDpzxtoeyKWvGLtjgSTViieWimpP-JA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle: riscv-sbi: Use scoped device node
 handling to fix missing of_node_put
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@rivosinc.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:10=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Two return statements in sbi_cpuidle_dt_init_states() did not drop the
> OF node reference count.  Solve the issue and simplify entire error
> handling with scoped/cleanup.h.
>
> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

>
> ---
>
> Changes in v2:
> 1. Re-write commit msg, because this is actually a fix.
> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index a6e123dfe394..5bb3401220d2 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -8,6 +8,7 @@
>
>  #define pr_fmt(fmt) "cpuidle-riscv-sbi: " fmt
>
> +#include <linux/cleanup.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
> @@ -236,19 +237,16 @@ static int sbi_cpuidle_dt_init_states(struct device=
 *dev,
>  {
>         struct sbi_cpuidle_data *data =3D per_cpu_ptr(&sbi_cpuidle_data, =
cpu);
>         struct device_node *state_node;
> -       struct device_node *cpu_node;
>         u32 *states;
>         int i, ret;
>
> -       cpu_node =3D of_cpu_device_node_get(cpu);
> +       struct device_node *cpu_node __free(device_node) =3D of_cpu_devic=
e_node_get(cpu);
>         if (!cpu_node)
>                 return -ENODEV;
>
>         states =3D devm_kcalloc(dev, state_count, sizeof(*states), GFP_KE=
RNEL);
> -       if (!states) {
> -               ret =3D -ENOMEM;
> -               goto fail;
> -       }
> +       if (!states)
> +               return -ENOMEM;
>
>         /* Parse SBI specific details from state DT nodes */
>         for (i =3D 1; i < state_count; i++) {
> @@ -264,10 +262,8 @@ static int sbi_cpuidle_dt_init_states(struct device =
*dev,
>
>                 pr_debug("sbi-state %#x index %d\n", states[i], i);
>         }
> -       if (i !=3D state_count) {
> -               ret =3D -ENODEV;
> -               goto fail;
> -       }
> +       if (i !=3D state_count)
> +               return -ENODEV;
>
>         /* Initialize optional data, used for the hierarchical topology. =
*/
>         ret =3D sbi_dt_cpu_init_topology(drv, data, state_count, cpu);
> @@ -277,10 +273,7 @@ static int sbi_cpuidle_dt_init_states(struct device =
*dev,
>         /* Store states in the per-cpu struct. */
>         data->states =3D states;
>
> -fail:
> -       of_node_put(cpu_node);
> -
> -       return ret;
> +       return 0;
>  }
>
>  static void sbi_cpuidle_deinit_cpu(int cpu)
> --
> 2.43.0
>

