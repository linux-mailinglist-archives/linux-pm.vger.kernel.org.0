Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E9F507DE4
	for <lists+linux-pm@lfdr.de>; Wed, 20 Apr 2022 03:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351511AbiDTBKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 21:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348181AbiDTBKS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 21:10:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23891D0FB
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 18:07:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id n43so421753pfv.10
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 18:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=uh+zqoa0RmF45pIO3fKwJcIuuOmmQqr7ZHT+lq3wkxM=;
        b=c+RLqjbokVzeFTNw9hc8x+ovEmdLmAVh+jAijGNIU2aP2z9Kn/2M5CVbWFQbp3uaYa
         G2yJ7RQXUcZiR97mRMuENoPfBv/t0NyC1qNrxT7PvouX4a7uAeH/Z5NeKzncDrWGTu6i
         TrenHavLMjhVjxXVbMPKEpnK76ncrbU5kyYp5qX7wLMhWx0rkgqxNEHn+4bZc+GlTcv8
         +mkx3DmZVeCVa5ER8W4GHlhgYsPWVAXzqalQefy8VLihg0JRzIq+nfHyjd67REslJVKb
         fOvAOnsTclyZdrMiN15qZ4vmRxI7slVgDYrjxfOPLCEIO+9GrAwgv4WnKl/Q4ba+WZeS
         9qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=uh+zqoa0RmF45pIO3fKwJcIuuOmmQqr7ZHT+lq3wkxM=;
        b=WnWwFQEevJzv9FjlQU40eNOoPcoZQJjKfEHVW2kTL0Hpyx58mINn5JUZCyEGWh1dLv
         ox4MgJTHvCnBkp86hYv+jvCJE8NsIV3ie+C+FMiZpDXIqpYHXW5CakcboyzT6hUyRoBo
         hiwIZfgiSTUCWDvuwHKcL2p3Y+y3EjycYH1rYtt+O8NEeoIDYfrKK5UmI+os/wrdemAR
         mQho9rqQ9umtBDuqotmsJ+LwbuSIOHajgB+NPLZk5ZeX/5xsZkbYuRvGspEeQpTZKQZB
         u8TakPeGswKwlXPbxhh0xCazhtMVInR5tfHnNqMOqICmyKck9yl72wrBmkWwQZyCCZrm
         Nmow==
X-Gm-Message-State: AOAM533U7PAu+DwIAfVnl+Z6rHiSZH+fSEMsQ6pFIYbGRKIwF901zXq9
        IjxgX6jMY4XBw9Uftw7zK43yZA==
X-Google-Smtp-Source: ABdhPJyBw5NXF/715OeKg6IgA5qyU6RYVd0hslcVhCUZywZ8kfoHLoOdaHJGPyf4uS10BVIJ569zzA==
X-Received: by 2002:a63:4945:0:b0:398:efe8:3b7a with SMTP id y5-20020a634945000000b00398efe83b7amr17202310pgk.106.1650416853229;
        Tue, 19 Apr 2022 18:07:33 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id x36-20020a634a24000000b0039cc6fff510sm17693532pga.58.2022.04.19.18.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 18:07:32 -0700 (PDT)
Date:   Tue, 19 Apr 2022 18:07:32 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Apr 2022 18:04:50 PDT (-0700)
Subject:     Re: [PATCH -next] cpuidle: riscv: support non-SMP config
In-Reply-To: <20220403031355.20894-1-rdunlap@infradead.org>
CC:     linux-kernel@vger.kernel.org, rdunlap@infradead.org, lkp@intel.com,
        anup@brainfault.org, anup@brainfault.org, apatel@ventanamicro.com,
        Atish Patra <atishp@rivosinc.com>, daniel.lezcano@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-d1fe9967-3f64-4ec7-aa82-72571e03bef4@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 02 Apr 2022 20:13:55 PDT (-0700), rdunlap@infradead.org wrote:
> Add <asm/smp.h> for cpuid_to_hartid_map etc.
> This is needed for both SMP and non-SMP builds, but not having it
> causes a build error for non-SMP:
>
> drivers/cpuidle/cpuidle-riscv-sbi.c: In function 'sbi_cpuidle_init_cpu':
> drivers/cpuidle/cpuidle-riscv-sbi.c:350:26: error: implicit declaration of function 'cpuid_to_hartid_map' [-Werror=implicit-function-declaration]
>
> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Atish Patra <atishp@rivosinc.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20220401.orig/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ linux-next-20220401/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -22,6 +22,7 @@
>  #include <linux/pm_runtime.h>
>  #include <asm/cpuidle.h>
>  #include <asm/sbi.h>
> +#include <asm/smp.h>
>  #include <asm/suspend.h>
>
>  #include "dt_idle_states.h"

Thanks, this is on fixes.
