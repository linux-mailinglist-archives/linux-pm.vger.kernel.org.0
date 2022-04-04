Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD6A4F0DA1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 05:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357055AbiDDDH3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Apr 2022 23:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346821AbiDDDH2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Apr 2022 23:07:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CF324BDB
        for <linux-pm@vger.kernel.org>; Sun,  3 Apr 2022 20:05:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so12456222wrg.3
        for <linux-pm@vger.kernel.org>; Sun, 03 Apr 2022 20:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zd1t2Pkuz698pTtgUjJwnowpfooSne/24mXVqKShj+c=;
        b=NWiwe7Qw5ka9+CSZ1/qW67wTbrDFP0cDPbwGe/J6FWhHkb5Sxt4n4xmacvf/7NvIH8
         3w6RbfIRqVnT0UVbdtZeYqpV++c6S7BJnbyeh3/r9cnceCAZ9bWsutuz1HNLVXV+B8uo
         WhUgw+dUJeLh2DaqquPfW5OTuHBZzGhP/etJ8eNt/CBog7GE5wgIna9JPIVP12BBtc9a
         j7hLtaTWSsgqX/RtFKbXHtAuOSFuiYC7ZkffF+ba1HIzMvzzjjKqxoxGTvAOU77ohyFv
         ccKHaokZjQ8KLKN9m4xBNPzefa9WxtUlnoU6N9iFI2xzCtFbZ767HuPX9Hv2vykF46/q
         YduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zd1t2Pkuz698pTtgUjJwnowpfooSne/24mXVqKShj+c=;
        b=s2/BdP1d1IBUlsDDBgB6ph7fcZQg0erTP9HTKSUvkKRMFo6EZrH0J6bEKSdTS7kkB8
         yw7xg52qcPfy29Uicqi8s3nW18hec3JPAaiB3d3i6/NaXzOLy6WUzViQY20+Sb98WWcM
         g7Cl44OubVGZxnkjuRS4MI2Mtn/3r34K/uSNgnQwlbDSn8GSjo1QtVyNCh6PR6vWCwuG
         PMPiCS04+iZ1Y/TnzWwe8SJFwuvF4jLN+em5T3iyOJzVzeoqD35VESD1r60DLafMdM4l
         4N883PiwuTueHN3yW1SQwI8gA4rE0wpbJ0qZKNhZaLgBM2veoZxl2cO4BR4P6GaaQETE
         uvbw==
X-Gm-Message-State: AOAM533UYAOBiIK2B9pgnsGzd3Sq4b7v7lG25O65VHKtMkDchN0mZZc0
        LBvkxIRwEoed5NmtOdf5R1aZo0oyfxFI4f89L9QMGA==
X-Google-Smtp-Source: ABdhPJyGYpZSUqo724IzShlVtF1ee3pTpacTkhreTLjXWB9AK2Sv6hBJilqv9BLYZ4/IwHSaMW2EmCu5gefIZKnIk60=
X-Received: by 2002:a5d:6e54:0:b0:204:635:42ba with SMTP id
 j20-20020a5d6e54000000b00204063542bamr15548840wrz.214.1649041531815; Sun, 03
 Apr 2022 20:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220403031355.20894-1-rdunlap@infradead.org>
In-Reply-To: <20220403031355.20894-1-rdunlap@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 4 Apr 2022 08:35:19 +0530
Message-ID: <CAAhSdy2CJMeD_JhvwkEKShtYxyLGVRme8rE4cmCcDFfO90_D-Q@mail.gmail.com>
Subject: Re: [PATCH -next] cpuidle: riscv: support non-SMP config
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

(Removed my WDC email because it does not exist anymore)

On Sun, Apr 3, 2022 at 8:44 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
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

I suggest include linux/smp.h here instead of asm/smp.h

Otherwise it looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

>  #include <asm/suspend.h>
>
>  #include "dt_idle_states.h"
