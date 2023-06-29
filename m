Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D1974301D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jun 2023 00:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjF2WEH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jun 2023 18:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjF2WEG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2023 18:04:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D6130EE
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2023 15:04:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688076243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v16OiA3G+oTS1qrr0KArc4sjT3TYfOCUouVZkj+xNPg=;
        b=O/vvC0hqy6J8GSXl9nfRCCEs7IcWClah0Ps9ZzMC3CTArnB7xBtx/nY2Ueq2B1XznBXLZ7
        WgFBgsS3XvDlZr16S0/FK3ENlaNly6LOvPuVVax3Exu7s4y6GkYx5gD2yAchlM+C8ms+Bn
        YiU4zOI0LEdkCd4nc39Eb27M6SL3jXIASR4JJj22ASInGRiv9KJoHXTfgJb2oqenGPHmHC
        09fPyutlKfk7Gyv48WQ27raV8FhjDOt9fS9o2W1zRcXwMEWSxEmDfWPTxhon1wiatbT/Wy
        VMSl+wDtSSS6LVz2yJXBRoRm/ld5uI48o/VD111rMBD0ljYu/1l686AQ2Tj5DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688076243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v16OiA3G+oTS1qrr0KArc4sjT3TYfOCUouVZkj+xNPg=;
        b=1FlhPp22R5EV4VGFQPst1XCV552pZGO3gssRkLvDEESUKZVgu1yhYTFCoKJh92FD0/f9jN
        Fia+rWLPxQx96+Aw==
To:     Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mwait: Add support for idle via umwait
In-Reply-To: <20230610183518.4061159-2-dedekind1@gmail.com>
References: <20230610183518.4061159-1-dedekind1@gmail.com>
 <20230610183518.4061159-2-dedekind1@gmail.com>
Date:   Fri, 30 Jun 2023 00:04:03 +0200
Message-ID: <87352a0vu4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 10 2023 at 21:35, Artem Bityutskiy wrote:
> On Intel platforms, C-states are requested using the 'monitor/mwait'
> instructions pair, as implemented in 'mwait_idle_with_hints()'. This
> mechanism allows for entering C1 and deeper C-states.
>
> Sapphire Rapids Xeon supports new idle states - C0.1 and C0.2 (later C0.x).
> These idle states have lower latency comparing to C1, and can be requested
> with either 'tpause' and 'umwait' instructions.

s/and/or/

>
> Linux already uses the 'tpause' instruction in delay functions like
> 'udelay()'. This patch adds 'umwait' and 'umonitor' instructions
> support.

# git grep 'This patch' Documentation/process/

Please fix it all over the place.

> +#ifdef CONFIG_X86_64
> +/*
> + * Monitor a memory address at 'rcx' using the 'umonitor' instruction.
> + */
> +static inline void __umonitor(const void *rcx)
> +{
> +	/* "umonitor %rcx" */
> +#ifdef CONFIG_AS_TPAUSE

Are you sure that the instruction check for TPAUSE is sufficient to also
include UMONITOR on all toolchains which support TPAUSE?

Also:

          if (IS_ENABLED(CONFIG_AS_TPAUSE) {

> +	asm volatile("umonitor %%rcx\n"
> +		     :
> +		     : "c"(rcx));
          } else {

> +#else
> +	asm volatile(".byte 0xf3, 0x0f, 0xae, 0xf1\t\n"
> +		     :
> +		     : "c"(rcx));

        }

please.

> +/*
> + * Same as '__tpause()', but uses the 'umwait' instruction. It is very
> + * similar to 'tpause', but also breaks out if the data at the address
> + * monitored with 'umonitor' is modified.
> + */
> +static inline void __umwait(u32 ecx, u32 edx, u32 eax)
> +{
> +	/* "umwait %ecx, %edx, %eax;" */
> +#ifdef CONFIG_AS_TPAUSE
> +	asm volatile("umwait %%ecx\n"
> +		     :
> +		     : "c"(ecx), "d"(edx), "a"(eax));
> +#else
> +	asm volatile(".byte 0xf2, 0x0f, 0xae, 0xf1\t\n"
> +		     :
> +		     : "c"(ecx), "d"(edx), "a"(eax));
> +#endif

Ditto.

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
> +	if (!current_set_polling_and_test()) {
> +		u32 eax, edx;
> +
> +		eax = lower_32_bits(deadline);
> +		edx = upper_32_bits(deadline);
> +
> +		__umonitor(&current_thread_info()->flags);
> +		if (!need_resched())
> +			__umwait(state, edx, eax);
> +	}
> +	current_clr_polling();
> +}
> +#else
> +#define umwait_idle(deadline, state) \
> +		WARN_ONCE(1, "umwait CPU instruction is not supported")

Please implement the stub as a proper inline.

> +#endif /* CONFIG_X86_64 */

This comment is wrong.

#ifdef CONFIG_X86_64
       ....
#else /* CONFIG_X86_64 */

#endif /* !CONFIG_X86_64 */

makes it clear what the scope is.

Thanks,

        tglx
