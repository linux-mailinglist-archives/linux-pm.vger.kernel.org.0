Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0227721846
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jun 2023 17:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjFDPrJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sun, 4 Jun 2023 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjFDPrI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jun 2023 11:47:08 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E61E9F
        for <linux-pm@vger.kernel.org>; Sun,  4 Jun 2023 08:47:07 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-96fc07d7e6bso80732966b.1
        for <linux-pm@vger.kernel.org>; Sun, 04 Jun 2023 08:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685893626; x=1688485626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQcn2O9WAncYaGnXMtjatxqd3d/NwJBjpyoinCpGY88=;
        b=Ccu6iz2aM2kZ0Abj2BTxCYy3RPB5fcj2EOYvjgoHiGodW29NGR17pktFR1usKvkXyR
         Li6BWCuhfDjyuVLugMdFVl0UELkhoXuylfERV/rOke2/MuZhzT66ZuktXrx3K8loNoH9
         LN5ZOe8MU4QYpveHy2s+FheI6sGqOE0y55HWeKJcO0ZTIb+MTsMk2e9xhk17XHsPj4s5
         p+O/K68RsccBkA1cgEfBeHomL3DzgBXXjP2TCcoenbC/VwckfpvRAmi+O7EsK0rdXc5S
         uMravmjpORtb0yQoMBixinN4UbANQ18P9F+QDsqGr0PN9buK5+ijt2HCEUkTeRKL4Ib7
         SANA==
X-Gm-Message-State: AC+VfDxAWBuzhpGwSqwQurPKmrB9EscZmziRUvKSLddhKnQRAw1SmvAX
        K9FZHAdDEQ+jlQN/LadvLljYkdczjK4nbZ2nsUo=
X-Google-Smtp-Source: ACHHUZ5Y44Vqrq8LNdPVhgMT+CR9t5BK/G7i1u2DguaXg+bEf5E1YhINbrY1DTjKrAIq0Pa42PmbrsXhbOzGwvPwV2s=
X-Received: by 2002:a17:906:d2:b0:977:cb73:ef6a with SMTP id
 18-20020a17090600d200b00977cb73ef6amr2476085eji.3.1685893626015; Sun, 04 Jun
 2023 08:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230601182801.2622044-1-arjan@linux.intel.com> <20230601182801.2622044-5-arjan@linux.intel.com>
In-Reply-To: <20230601182801.2622044-5-arjan@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 17:46:54 +0200
Message-ID: <CAJZ5v0h7N7xZAoxZDnUqPCZfoFALSq+tgWgD0bROThWFHrsaRA@mail.gmail.com>
Subject: Re: [PATCH 4/7] intel_idle: Add helper functions to support 'hlt' as
 idle state
To:     arjan@linux.intel.com
Cc:     linux-pm@vger.kernel.org, artem.bityutskiy@linux.intel.com,
        rafael@kernel.org, Arjan van de Ven <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 1, 2023 at 8:28 PM <arjan@linux.intel.com> wrote:
>
> From: Arjan van de Ven <arjan.van.de.ven@intel.com>
>
> Currently the intel_idle driver has a family of functions called
> intel_idle/intel_idle_irq/intel_idle_xsave/... that use the
> mwait instruction to enter into a low power state.
>
> x86 cpus can also use the legacy "hlt" instruction for this,
> and in some cases (VM guests for example) the mwait instruction
> might not be available.
>
> Because of this, add the basic helpers to allow 'hlt' to be used to enter
> a low power state (will be used in later patches), both in the
> regular and the _irq enabled variant.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

I would prefer this to be combined with patch [6/7] by the rule that
it's better to add helpers along with their users.

> ---
>  drivers/idle/intel_idle.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 8415965372c7..66d262fd267e 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -199,6 +199,43 @@ static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
>         return __intel_idle(dev, drv, index);
>  }
>
> +static __always_inline int __intel_idle_hlt(struct cpuidle_device *dev,
> +                                       struct cpuidle_driver *drv, int index)
> +{
> +       raw_safe_halt();
> +       raw_local_irq_disable();
> +       return index;
> +}
> +
> +/**
> + * intel_idle_hlt - Ask the processor to enter the given idle state using hlt.
> + * @dev: cpuidle device of the target CPU.
> + * @drv: cpuidle driver (assumed to point to intel_idle_driver).
> + * @index: Target idle state index.
> + *
> + * Use the HLT instruction to notify the processor that the CPU represented by
> + * @dev is idle and it can try to enter the idle state corresponding to @index.
> + *
> + * Must be called under local_irq_disable().
> + */
> +static __cpuidle int intel_idle_hlt(struct cpuidle_device *dev,
> +                               struct cpuidle_driver *drv, int index)
> +{
> +       return __intel_idle_hlt(dev, drv, index);
> +}
> +
> +static __cpuidle int intel_idle_hlt_irq(struct cpuidle_device *dev,
> +                                   struct cpuidle_driver *drv, int index)
> +{
> +       int ret;
> +
> +       raw_local_irq_enable();
> +       ret = __intel_idle_hlt(dev, drv, index);
> +       raw_local_irq_disable();
> +
> +       return ret;
> +}
> +
>  /**
>   * intel_idle_s2idle - Ask the processor to enter the given idle state.
>   * @dev: cpuidle device of the target CPU.
> --
> 2.40.1
>
