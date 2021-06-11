Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42493A46F4
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 18:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhFKQtl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 12:49:41 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:35440 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhFKQtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 12:49:13 -0400
Received: by mail-ot1-f47.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so3766272otg.2;
        Fri, 11 Jun 2021 09:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyxLEXh/TeBpOGT4HbU2trqOosLmsNMbx1D8aYLqPns=;
        b=qebnbQZJwyEtpLLbvogIeQ4tFK0X0HKb5O5bu7xVUmaOEDy4lcZnU1SUsMg8iX9jDI
         YFOL06yN8wzANtPQOKYBM8W3EIaKmQDGDaPX3JCsG6RWRpmlIT3Xz+ukPOXyUChz3jYY
         0C6AvOHP+tDrVHthnTAcbM0sLyV7QvD6qN1dn7eO0hDI5dovI0eSySpoHSgB+HyS5uLc
         iy/dMDnCxynFnrVwLAv2CSEGv3gA1ezUos8uSM0avjQjiFS3M0F+qVNQ5J2aNCTEFvhx
         8YBE5hTuQ9LwyN4Ue+eZgthI/hnVUaWtizDUWgV1ngHWlrSZZX6SoALn7ZjNzcpnL2i5
         QaAw==
X-Gm-Message-State: AOAM533o1MVgBIe1nBiU1IzNHnFD32pAS7EEfxGbKngyWCiyJbU1Yf4H
        BbWzF1CpL3NTbW8ZiKAoiqAS3+IrR1PdXZh1x2I=
X-Google-Smtp-Source: ABdhPJxd4tRRtlaTouCUTJKzu6H9z7DzttA24A1vsvGvlnrhqTlvWcV5YAOnG9/Zr3sIn+JB0eOkzw1Ro1P2pYM1IVc=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr3938217otq.321.1623430034726;
 Fri, 11 Jun 2021 09:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210608025427.2781445-1-libaokun1@huawei.com>
In-Reply-To: <20210608025427.2781445-1-libaokun1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jun 2021 18:47:03 +0200
Message-ID: <CAJZ5v0iZwwkKznqxzbkrDK8+gF1todJvg6Yy4DzvZ8enN5khnQ@mail.gmail.com>
Subject: Re: [PATCH -next] x86/power: fix doc warnings in cpu.c
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

On Tue, Jun 8, 2021 at 4:45 AM Baokun Li <libaokun1@huawei.com> wrote:
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
>  arch/x86/power/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 3a070e7cdb8b..2640b9128479 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -60,7 +60,7 @@ static void msr_restore_context(struct saved_context *ctxt)
>  /**
>   *     __save_processor_state - save CPU registers before creating a
>   *             hibernation image and before restoring the memory state from it
> - *     @ctxt - structure to store the registers contents in
> + *     @ctxt: structure to store the registers contents in

Any chance to fix the formatting of this kerneldoc comment too in this patch?

>   *
>   *     NOTE: If there is a CPU register the modification of which by the
>   *     boot kernel (ie. the kernel used for loading the hibernation image)
> @@ -183,7 +183,7 @@ static void fix_processor_context(void)
>  /**
>   * __restore_processor_state - restore the contents of CPU registers saved
>   *                             by __save_processor_state()
> - * @ctxt - structure to load the registers contents from
> + * @ctxt: structure to load the registers contents from
>   *
>   * The asm code that gets us here will have restored a usable GDT, although
>   * it will be pointing to the wrong alias.
> --
> 2.31.1
>
