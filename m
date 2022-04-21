Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE6650AB81
	for <lists+linux-pm@lfdr.de>; Fri, 22 Apr 2022 00:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiDUWbS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Apr 2022 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiDUWbS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2022 18:31:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E524B42C
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 15:28:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q12so5784114pgj.13
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/WL4sEfilsdTNMCzpQ4AUYKUU/6fA7UgWxPOldA7e0=;
        b=DCXNDtgEIbQlslJM2sme6aHreWG5byjxFkM19clb/BPTLe3LO+1bN8luGxz7gcFLH2
         V8TxBt5zvjxtLWo6QtqGc5jeNy0BsSR5R0xNy7AKvReXzahuYaLSPkLjTf+Ue/17I5wx
         81dsfmAdQFC3P71z0Hb0cx1qBab0qVQ1xwNEVrEENevqHC9SLaPohX4yodxTix65LSOl
         7yS8Ug1GH6K7lJA9I6nbv9VQ3sst2BzrsWmk6t61DZfbBJaKHohxxlxgehgkJfsXuvCo
         nytHu38tVwNI+SN18mZjCgcA3niWmlGT1Ly3o9boYquSP/NMt820jyG6cGjK8q6VheRE
         vdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Z/WL4sEfilsdTNMCzpQ4AUYKUU/6fA7UgWxPOldA7e0=;
        b=IIo/XcjpZCPQMBJNC+Xl+SOnsKDRWIMSn2xqSMxk4DhoBQqQGxu8i0f65v6noAXevJ
         fEbnDbLrMkqm5DluTwUcFezqkH3ykBbljLp6VqXUTS+7hhwDOEhoKRawNqARXqbuRp8f
         ifaI3bdHqKr/9tdp7umeA5zyA8SOYijGEim22cOsoDYpSqjIIFd1146OJRBwGffkdyN3
         1BvxOa/Cb9VW2OJmfD8Ov3GmD8Yght1G5qNoCNCKOSrOnaUdhd/oTYrmw8x55zxMKUTz
         f6d5X6aYUc/NkXusQ0Af1StQm8d4TOOccbXEBL9YDOTMbdenYWqfWjHJGRopn8JeHJhk
         H/HA==
X-Gm-Message-State: AOAM532DyAlskPh4ygFZHptll9cTuPu2bjUC3d5X+8rrZOEc6srsrCpl
        Mab9Wfin5gf4UrGHHl4tGUKQ+g==
X-Google-Smtp-Source: ABdhPJx+f1tHcxxGqTCOCPo1VxA+zauf4INXX/UghwWOO8s1oRB78YRFQkcmGmPLG7UJfs2EKJR2JA==
X-Received: by 2002:a05:6a00:2343:b0:50a:7852:902f with SMTP id j3-20020a056a00234300b0050a7852902fmr1657232pfj.5.1650580106441;
        Thu, 21 Apr 2022 15:28:26 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004fae885424dsm131962pfx.72.2022.04.21.15.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 15:28:25 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:28:25 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Apr 2022 15:28:23 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: cpuidle: fix Kconfig select for RISCV_SBI_CPUIDLE
In-Reply-To: <20220409225317.14332-1-rdunlap@infradead.org>
CC:     linux-kernel@vger.kernel.org, rdunlap@infradead.org, lkp@intel.com,
        anup@brainfault.org, apatel@ventanamicro.com, anup@brainfault.org,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-2811736b-27d0-4312-ba68-ef99947a9372@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 09 Apr 2022 15:53:17 PDT (-0700), rdunlap@infradead.org wrote:
> There can be lots of build errors when building cpuidle-riscv-sbi.o.
> They are all caused by a kconfig problem with this warning:
>
> WARNING: unmet direct dependencies detected for RISCV_SBI_CPUIDLE
>   Depends on [n]: CPU_IDLE [=y] && RISCV [=y] && RISCV_SBI [=n]
>   Selected by [y]:
>   - SOC_VIRT [=y] && CPU_IDLE [=y]
>
> so make the 'select' of RISCV_SBI_CPUIDLE also depend on RISCV_SBI.
>
> Fixes: c5179ef1ca0c ("RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> ---
>  arch/riscv/Kconfig.socs |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -38,7 +38,7 @@ config SOC_VIRT
>  	select SIFIVE_PLIC
>  	select PM_GENERIC_DOMAINS if PM
>  	select PM_GENERIC_DOMAINS_OF if PM && OF
> -	select RISCV_SBI_CPUIDLE if CPU_IDLE
> +	select RISCV_SBI_CPUIDLE if CPU_IDLE && RISCV_SBI
>  	help
>  	  This enables support for QEMU Virt Machine.

Sorry to be slow here, I seem to remember having written this before but 
I must have just gotted pulled into something else.

IMO the real bug here is that Kconfig.socs is poorly designed: I 
misunderstood how select works at the time, we should really clean all 
this up (or maybe just remove it entirely?) so we don't have to 
duplicate all these dependencies.

That's a bigger project, though so this is on fixes -- it's way better 
to have the build work.

Thanks!
