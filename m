Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D855742D14
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jun 2023 21:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjF2TMG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 29 Jun 2023 15:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbjF2TLW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2023 15:11:22 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955D259EB
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2023 12:03:27 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-98dfd15aae1so29730866b.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2023 12:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688065406; x=1690657406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R9kSAgaZYmHgiyvxUGAUXjOTjIm3tdUzpLvFa67Y/A=;
        b=SuwcHIR7i/4x+A5VOMAoc4+bsIdz6W1fdqBKLOr+0qBqtTd6fPgyd0YxbvmdHY8Dkw
         dnXiI9ePOD9tvJYY3xHHsIfMnjel0D974BLPOxYvxCp5DeIxzMvWuV5Lv7lGCcqzYIW1
         WU3nB1zFNkHXdZh9JVLVxqBokmjjIJ7wxe6R2FMNumkhokbbS1Jm3X+POsohzYROXvlq
         2uzg3wcADWTWVNr59jXdsIo97g/NBCxLcncI9c3kCKY4gMOICIDEGLTUilzkP/9YSGCs
         mLlBfA95fG8Sr952Ks/OejkJTNHBSJHKVemlyswM717SMoTHMGdfqsav3LDEiVBK9m5q
         dBvQ==
X-Gm-Message-State: ABy/qLZHkjZ5iE/JNXvFYYN/bHsN2i44YaouuRsZPX87Q33PfZH0/TyN
        DLO/8/WuJVldtx3rozVqQtUCAljlfoqnNlb8qrJIHvIv
X-Google-Smtp-Source: APBJJlH+LpLLAnf+zEA3KT/yrQ7kjqPce9nDkvCH/aoe6ZODwQ3paRI2zr9BsiXnQYn5G9AenZe7e08/3BeRBsW4dX0=
X-Received: by 2002:a17:907:119a:b0:987:6960:36c5 with SMTP id
 uz26-20020a170907119a00b00987696036c5mr257825ejb.6.1688065405448; Thu, 29 Jun
 2023 12:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230610183518.4061159-1-dedekind1@gmail.com> <20230610183518.4061159-2-dedekind1@gmail.com>
In-Reply-To: <20230610183518.4061159-2-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 21:03:14 +0200
Message-ID: <CAJZ5v0jiuenEnLjeZg+rksLT5D1f0-0Xad98rumR+vJReCXx7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mwait: Add support for idle via umwait
To:     Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 10, 2023 at 8:35 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> On Intel platforms, C-states are requested using the 'monitor/mwait'
> instructions pair, as implemented in 'mwait_idle_with_hints()'. This
> mechanism allows for entering C1 and deeper C-states.
>
> Sapphire Rapids Xeon supports new idle states - C0.1 and C0.2 (later C0.x).
> These idle states have lower latency comparing to C1, and can be requested
> with either 'tpause' and 'umwait' instructions.
>
> Linux already uses the 'tpause' instruction in delay functions like
> 'udelay()'. This patch adds 'umwait' and 'umonitor' instructions support.
>
> 'umwait' and 'tpause' instructions are very similar - both send the CPU to
> C0.x and have the same break out rules. But unlike 'tpause', 'umwait' works
> together with 'umonitor' and exits the C0.x when the monitored memory
> address is modified (similar idea as with 'monitor/mwait').
>
> This patch implements the 'umwait_idle()' function, which works very
> similarly to existing 'mwait_idle_with_hints()', but requests C0.x. The
> intention is to use it from the 'intel_idle' driver.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

x86 folks, any comments on this?

Barring any concerns, I would like to queue it up for 6.6 when the
merge is over.

> ---
>  arch/x86/include/asm/mwait.h | 65 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index 778df05f8539..681c281eeaa7 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -141,4 +141,69 @@ static inline void __tpause(u32 ecx, u32 edx, u32 eax)
>         #endif
>  }
>
> +#ifdef CONFIG_X86_64
> +/*
> + * Monitor a memory address at 'rcx' using the 'umonitor' instruction.
> + */
> +static inline void __umonitor(const void *rcx)
> +{
> +       /* "umonitor %rcx" */
> +#ifdef CONFIG_AS_TPAUSE
> +       asm volatile("umonitor %%rcx\n"
> +                    :
> +                    : "c"(rcx));
> +#else
> +       asm volatile(".byte 0xf3, 0x0f, 0xae, 0xf1\t\n"
> +                    :
> +                    : "c"(rcx));
> +#endif
> +}
> +
> +/*
> + * Same as '__tpause()', but uses the 'umwait' instruction. It is very
> + * similar to 'tpause', but also breaks out if the data at the address
> + * monitored with 'umonitor' is modified.
> + */
> +static inline void __umwait(u32 ecx, u32 edx, u32 eax)
> +{
> +       /* "umwait %ecx, %edx, %eax;" */
> +#ifdef CONFIG_AS_TPAUSE
> +       asm volatile("umwait %%ecx\n"
> +                    :
> +                    : "c"(ecx), "d"(edx), "a"(eax));
> +#else
> +       asm volatile(".byte 0xf2, 0x0f, 0xae, 0xf1\t\n"
> +                    :
> +                    : "c"(ecx), "d"(edx), "a"(eax));
> +#endif
> +}
> +
> +/*
> + * Enter C0.1 or C0.2 state and stay there until an event happens (an interrupt
> + * or the 'need_resched()'), the explicit deadline is reached, or the implicit
> + * global limit is reached.
> + *
> + * The deadline is the absolute TSC value to exit the idle state at. If it
> + * exceeds the global limit in the 'IA32_UMWAIT_CONTROL' register, the global
> + * limit prevails, and the idle state is exited earlier than the deadline.
> + */
> +static inline void umwait_idle(u64 deadline, u32 state)
> +{
> +       if (!current_set_polling_and_test()) {
> +               u32 eax, edx;
> +
> +               eax = lower_32_bits(deadline);
> +               edx = upper_32_bits(deadline);
> +
> +               __umonitor(&current_thread_info()->flags);
> +               if (!need_resched())
> +                       __umwait(state, edx, eax);
> +       }
> +       current_clr_polling();
> +}
> +#else
> +#define umwait_idle(deadline, state) \
> +               WARN_ONCE(1, "umwait CPU instruction is not supported")
> +#endif /* CONFIG_X86_64 */
> +
>  #endif /* _ASM_X86_MWAIT_H */
> --
> 2.40.1
>
