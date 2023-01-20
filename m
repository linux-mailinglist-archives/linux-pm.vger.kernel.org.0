Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A7B675A1C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jan 2023 17:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjATQhL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Jan 2023 11:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjATQhK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2023 11:37:10 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F6B917FD
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 08:36:45 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id v13so7391264eda.11
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 08:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iaP2n+2TIZGge3mAGXKH7LVHdnPOiBike7dAvPfw4Y=;
        b=qPc6UfIY3dfXlEd1DMlpux5rOsiTnMVkC/HOVJqA7MBCehbN8JIwRbrspZssU7DX7F
         y5lwBX9SoMu0tLkjBgolMOVlR2zzzyok2HK6n+f2eC0EoFmqbYwY5DtGbfAYDX7RuzFe
         CHqcJnZDoKhQ33qru1IYSxAT6ESNVCoNKj5XzN9ZrDK/v7QCobf8/17g9nLpjPDLTOah
         2I8lV2IxgrOzjZTjrJ2klBWHnEfkXxMdlWgYXmHGfzH/Vmoopfi2oIfVBTXvgO9U2Oq1
         2WTt8pN+hQ0SDsg8tfJJE4sai7urtfTUspNEZ4TKQMkFSjgBB5q3baC34ig7dQpBXol4
         Ghfw==
X-Gm-Message-State: AFqh2krd0NsXBLw5waI9a7H/iI4CrvXvFcFqc2LJ321C/wfGxMB47B3H
        +SkzUOf6RXwXWAdg/Wzcy3ftyWFSX47VeSCr2/M=
X-Google-Smtp-Source: AMrXdXtYWz2BY25jBil4cx7L4ekjWQ8gUeTXU4ybnBegkdeg2NhJ3t1uXLKCKep5OAxVpq77Uod0Sgy0ChD+b5sYJtc=
X-Received: by 2002:aa7:cd47:0:b0:49d:f700:b1ee with SMTP id
 v7-20020aa7cd47000000b0049df700b1eemr1780339edw.49.1674232543099; Fri, 20 Jan
 2023 08:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20230106040342.46570-1-lirongqing@baidu.com>
In-Reply-To: <20230106040342.46570-1-lirongqing@baidu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 17:35:32 +0100
Message-ID: <CAJZ5v0g6cEizy-xxNEX4OfRby7qDMG9WVCrZPPntzR71MQ0GRw@mail.gmail.com>
Subject: Re: [PATCH][v3] cpuidle-haltpoll: Replace default_idle with arch_cpu_idle
To:     Li RongQing <lirongqing@baidu.com>
Cc:     linux-pm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        rafael@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 6, 2023 at 5:03 AM Li RongQing <lirongqing@baidu.com> wrote:
>
> When KVM guest has MWAIT and mwait_idle is used as default idle function,
> but once cpuidle-haltpoll is loaded, default_idle in default_enter_idle is
> used, which is using HLT, and maybe cause a performance regression, as the
> commit aebef63cf7ff ("x86: Remove vendor checks from prefer_mwait_c1_over_halt")
> explains that mwait is preferred
>
> so replace default_idle with arch_cpu_idle which can using MWAIT
> optimization.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> v3: using EXPORT_SYMBOL_GPL
> v2: not disable haltpoll, using arch_cpu_idle when guest has mwait
>
>  arch/x86/kernel/process.c          | 1 +
>  drivers/cpuidle/cpuidle-haltpoll.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 40d156a..00a831d 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -721,6 +721,7 @@ void arch_cpu_idle(void)
>  {
>         x86_idle();
>  }
> +EXPORT_SYMBOL_GPL(arch_cpu_idle);
>
>  /*
>   * We use this if we don't have any better idle routine..
> diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
> index 3a39a7f..e66df22 100644
> --- a/drivers/cpuidle/cpuidle-haltpoll.c
> +++ b/drivers/cpuidle/cpuidle-haltpoll.c
> @@ -32,7 +32,7 @@ static int default_enter_idle(struct cpuidle_device *dev,
>                 local_irq_enable();
>                 return index;
>         }
> -       default_idle();
> +       arch_cpu_idle();
>         return index;
>  }
>
> --

The patch is not objectionable IMO, so I've applied it as 6.3
material, but I have rewritten its changelog.

Thanks!
