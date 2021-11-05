Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C30446500
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 15:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhKEOgf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 10:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhKEOge (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 10:36:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25785C061714;
        Fri,  5 Nov 2021 07:33:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636122832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDQ7Vlp4ZOk3OANnx52v04hzRNMdVvh44HRolFIyIAQ=;
        b=XO98W27616NvKI97Mivdn1rwsesN/VZHlmzi8aFlXtf8O1iBxJfFa81vtOieGEbSmJyLjA
        1Iex+jL+fh+71A5wfgk/gY8oz+lFurfAs5fMu8uGNISpkL+U+EGjMXxzoZoL/EtwL2NXZc
        /Z1OaGvMT6H77GzIgqRzMOt7c1aYnGJMcuUZUeA4gs2Lss0Eh1noYfkNxVJ7qcHb8BIAue
        WPGuF3eHeSaG82ESTh4du5QwolZxKz8p972tuF9pQlj+1Pmi50z6/tfLe7vSOCmLd6fBKq
        3fNp1/3wjIJnGATg3hG7rmWitD1+Z2dZS0oGEQAhSxi3TI1GPXSQDPyga1qnng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636122832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDQ7Vlp4ZOk3OANnx52v04hzRNMdVvh44HRolFIyIAQ=;
        b=BbR0IXGCaZkM33c0ZQTShuP3SUwC6/3Cbn/eW73UTOoPjqkBCtKYCARHootjdKiF0jeLja
        h9XbkLJsksJlhzDA==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, peterz@infradead.org,
        bp@alien8.de, mingo@redhat.com, chang.seok.bae@intel.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/4] intel_idle: Add SPR support with AMX INIT-state
In-Reply-To: <20211104225226.5031-5-chang.seok.bae@intel.com>
References: <20211104225226.5031-1-chang.seok.bae@intel.com>
 <20211104225226.5031-5-chang.seok.bae@intel.com>
Date:   Fri, 05 Nov 2021 15:33:52 +0100
Message-ID: <878ry24qpb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Chang,

On Thu, Nov 04 2021 at 15:52, Chang S. Bae wrote:
> +/**
> + * intel_idle_tile - Ask the processor to enter the given idle state.
> + * @dev: cpuidle device of the target CPU.
> + * @drv: cpuidle driver (assumed to point to intel_idle_driver).
> + *
> + * Ensure TILE registers in INIT-state before using intel_idle() to
> + * enter the idle state.
> + */
> +static __cpuidle int intel_idle_tile(struct cpuidle_device *dev,
> +				     struct cpuidle_driver *drv, int index)
> +{
> +	fpu_idle_fpregs();

That's redundant because arch_cpu_idle_enter() is invoked before the
actual idle mechanism. 

> +/**
> + * intel_idle_s2idle_tile - Ask the processor to enter the given idle state.
> + * @dev: cpuidle device of the target CPU.
> + * @drv: cpuidle driver (assumed to point to intel_idle_driver).
> + * @index: Target idle state index.
> + *
> + * Ensure TILE registers in INIT-state before using intel_idle_s2idle() to
> + * enter the idle state.
> + */
> +static __cpuidle int intel_idle_s2idle_tile(struct cpuidle_device *dev,
> +					    struct cpuidle_driver *drv, int index)
> +{
> +	fpu_idle_fpregs();

Ditto

Thanks,

        tglx
