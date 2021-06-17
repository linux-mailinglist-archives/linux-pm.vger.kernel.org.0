Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1E93AB353
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 14:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhFQMOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 08:14:46 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41775 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhFQMOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 08:14:45 -0400
Received: by mail-ot1-f47.google.com with SMTP id w23-20020a0568301117b029044c37262dadso526214otq.8;
        Thu, 17 Jun 2021 05:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXLDf/zBwxcg6JRYUw5vSzsqMPchC5DDa1UwTpdQ4zI=;
        b=E+CLePaPKn1GH4E6We1Jk3yr3W0IGBRFyiQuxnsxRJ0luFqNCpsuZEECqXFXKC9+Kw
         Dffxp7QC1XnoRvrkemDDhVwlKEzQKQeCDoQcnXLmN4AtxV0y8xQoUYI3kFs3Dxvp78fs
         T3QEUkEdOMZtpi3pn03FzK7mY+YfOmdqZc/kDXNkqTti3m0WcHSyN8DRAikP3ipTDfrH
         Za+rMtTt+eFSmRKTbLqhNyq46qJ1NgOcu/4ZHbSQBCq4Fj8jhsTLh7LmhiabnuiklsFN
         dIORzKF+jCSPvhbU81fmjT842ew/+eodDPfXr9roWs1BeA4CMYuGB/ULb4W0f/COuQG7
         9ckQ==
X-Gm-Message-State: AOAM532t0mszGwP11zMCjNJqq/E701hdy1cCKQfRb8mkwI1gLMU42afm
        pTGXW7IcCzMY+OGqs9QYvvrg7JWD7WIzWCIgI8c=
X-Google-Smtp-Source: ABdhPJwMdnLsLMcBrvB0YymtXaieQXS5htbXgFwOQnTNfWI0shOnas+luLylAychSWsQ/79xgLH1q25lk9rEMz0PTNE=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr4306429otg.260.1623931958133;
 Thu, 17 Jun 2021 05:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210615033535.2907295-1-libaokun1@huawei.com>
In-Reply-To: <20210615033535.2907295-1-libaokun1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 14:12:27 +0200
Message-ID: <CAJZ5v0iajoHXbJO-HgOMZkDo1GfRNEgDoNaSmFcOpeJGhgrYdA@mail.gmail.com>
Subject: Re: [PATCH -next v2] x86/power: fix doc warnings in cpu.c
To:     Baokun Li <libaokun1@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yue Haibing <yuehaibing@huawei.com>, yangjihong1@huawei.com,
        yu kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 15, 2021 at 5:26 AM Baokun Li <libaokun1@huawei.com> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  arch/x86/power/cpu.c:76: warning: Function parameter or
>   member 'ctxt' not described in '__save_processor_state'
>  arch/x86/power/cpu.c:192: warning: Function parameter or
>   member 'ctxt' not described in '__restore_processor_state'
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
>         Fix the formatting of this kerneldoc comment
>
>  arch/x86/power/cpu.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 3a070e7cdb8b..54b530db5ed0 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -58,19 +58,20 @@ static void msr_restore_context(struct saved_context *ctxt)
>  }
>
>  /**
> - *     __save_processor_state - save CPU registers before creating a
> - *             hibernation image and before restoring the memory state from it
> - *     @ctxt - structure to store the registers contents in
> + * __save_processor_statei() - Save CPU registers before creating a
> + *                             hibernation image and before restoring
> + *                             the memory state from it
> + * @ctxt: Structure to store the registers contents in.
>   *
> - *     NOTE: If there is a CPU register the modification of which by the
> - *     boot kernel (ie. the kernel used for loading the hibernation image)
> - *     might affect the operations of the restored target kernel (ie. the one
> - *     saved in the hibernation image), then its contents must be saved by this
> - *     function.  In other words, if kernel A is hibernated and different
> - *     kernel B is used for loading the hibernation image into memory, the
> - *     kernel A's __save_processor_state() function must save all registers
> - *     needed by kernel A, so that it can operate correctly after the resume
> - *     regardless of what kernel B does in the meantime.
> + * NOTE: If there is a CPU register the modification of which by the
> + * boot kernel (ie. the kernel used for loading the hibernation image)
> + * might affect the operations of the restored target kernel (ie. the one
> + * saved in the hibernation image), then its contents must be saved by this
> + * function.  In other words, if kernel A is hibernated and different
> + * kernel B is used for loading the hibernation image into memory, the
> + * kernel A's __save_processor_state() function must save all registers
> + * needed by kernel A, so that it can operate correctly after the resume
> + * regardless of what kernel B does in the meantime.
>   */
>  static void __save_processor_state(struct saved_context *ctxt)
>  {
> @@ -181,9 +182,9 @@ static void fix_processor_context(void)
>  }
>
>  /**
> - * __restore_processor_state - restore the contents of CPU registers saved
> - *                             by __save_processor_state()
> - * @ctxt - structure to load the registers contents from
> + * __restore_processor_state() - Restore the contents of CPU registers saved
> + *                               by __save_processor_state()
> + * @ctxt: Structure to load the registers contents from.
>   *
>   * The asm code that gets us here will have restored a usable GDT, although
>   * it will be pointing to the wrong alias.
> --

Applied as 5.14 material, thanks!
