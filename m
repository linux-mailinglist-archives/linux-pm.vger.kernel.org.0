Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D882F6AC514
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 16:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCFPco (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Mar 2023 10:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCFPcn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2023 10:32:43 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4366A33446
        for <linux-pm@vger.kernel.org>; Mon,  6 Mar 2023 07:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=euq9/yoxHfknPvvW6WFWDqIGuLSUw/oa0lybLKu7uwA=; b=SRuoVeBCvqCrbeBlKy+N6L3P5V
        vEqMg+sSM0tDiJJEhmL0BHj8CaClKUg0mYZtSX1o1e4kaGICWhStI3074CH4QHvMB7by2Kc7UJuPO
        QctRdoOF50Yh0Bf8IIIUkSc9ic3kLpTXl6KwcVGn8tdinnAYLnFeDwrbkMEEHMffomr5xNjcnNV/y
        rHinc6ojxT8+kEImcGV32q8KTwjmerItJmn3dlVzu7QLowBubypBg+G+1HZh8Fr10Lk+YCZcI2HOQ
        ZkMvPKA9De7oyCFOIHuv03CiZ4UqENA970FT0FRSOjupV8eqZnhfp630mPdmbWuHkLGvtycpZfN50
        gVzOl4Pg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pZCoz-00Gj7b-1H;
        Mon, 06 Mar 2023 15:32:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFBCE300328;
        Mon,  6 Mar 2023 16:32:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2E2C20F05D4C; Mon,  6 Mar 2023 16:32:15 +0100 (CET)
Date:   Mon, 6 Mar 2023 16:32:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     x86@kernel.org, Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/3] intel_idle: add C0.2 state for Sapphire Rapids Xeon
Message-ID: <20230306153215.GG1267364@hirez.programming.kicks-ass.net>
References: <20230306123418.720679-1-dedekind1@gmail.com>
 <20230306123418.720679-4-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306123418.720679-4-dedekind1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 06, 2023 at 02:34:18PM +0200, Artem Bityutskiy wrote:
> @@ -225,6 +229,27 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
>  	return 0;
>  }
>  
> +/**
> + * intel_idle_umwait_irq - Request C0.x using the 'umwait' instruction.
> + * @dev: cpuidle device of the target CPU.
> + * @drv: cpuidle driver (assumed to point to intel_idle_driver).
> + * @index: Target idle state index.
> + *
> + * Request C0.1 or C0.2 using 'umwait' instruction with interrupts enabled.
> + */
> +static __cpuidle int intel_idle_umwait_irq(struct cpuidle_device *dev,
> +					   struct cpuidle_driver *drv,
> +					   int index)
> +{
> +	u32 state = flg2MWAIT(drv->states[index].flags);
> +
> +	raw_local_irq_enable();
> +	umwait_idle(rdtsc() + umwait_limit, state);
> +	local_irq_disable();
> +
> +	return index;
> +}

Bad copy paste job there...

vmlinux.o: warning: objtool: intel_idle_umwait_irq+0x8c: call to trace_hardirqs_off() leaves .noinstr.text section
