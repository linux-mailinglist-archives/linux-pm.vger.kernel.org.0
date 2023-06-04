Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADE6721837
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jun 2023 17:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjFDPe5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sun, 4 Jun 2023 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjFDPen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jun 2023 11:34:43 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25A9CD
        for <linux-pm@vger.kernel.org>; Sun,  4 Jun 2023 08:34:41 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-974604c1394so68605266b.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Jun 2023 08:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685892880; x=1688484880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKPyAhSLXQmW6xvxgFwNtorJccijYF4JCh1VkoaPO6Q=;
        b=Oc9Cesa9SMZ8PUu1cq7/D0I2rzZ5Pzvnio9JMEe1sZmREERFCFC/w8gVAEWC8xoXLO
         Ug2JucvfY+Gm3/uXyXiyIY2mLOy0JNhw4qnUUvFijNRm3pM2eQ7Q89XrW59woIySZZJ3
         v2DjkwuHhTd8RSH8no9Lu3tmgznGJ9C2KnLjceTe/kyuwdh9UrI6ltSqrKLZpmeVv53Y
         1yIoXa6YWebXUIzFXolEg/tHxmFJatkF/JlEIt7ptWfmf0ocGs8KZje5uqBKzSxjLoKe
         PD/GzmpImvCj5sSk5bPzs8DSfxgFNK/yMmG+MkzOxRq9mh0OHQ6+DR3eCj2JiCzjxaHC
         piLA==
X-Gm-Message-State: AC+VfDxmmE08j6wPjEYRMOkFQsGY0W0pEeJIvLe+DsTlu/UP++uU/8Ra
        Nxhd8Dc2ciHJqBa0jVeIAEaul01J6AOBYQiLf8k=
X-Google-Smtp-Source: ACHHUZ4Sb8NACLhPTAeXPp4uDCUfKyGtVZ1jbuJpLlXU1WYD8d+QvULL8qzKV3EymhvrWewLLGKoc85rZzw8GS3nrDY=
X-Received: by 2002:a17:906:74c7:b0:977:c853:fba6 with SMTP id
 z7-20020a17090674c700b00977c853fba6mr3175618ejl.2.1685892880076; Sun, 04 Jun
 2023 08:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230601182801.2622044-1-arjan@linux.intel.com> <20230601182801.2622044-3-arjan@linux.intel.com>
In-Reply-To: <20230601182801.2622044-3-arjan@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 17:34:29 +0200
Message-ID: <CAJZ5v0hO_WFnKpBaFay7NtUiemrS1rKKfh_0an0U7UC9FDBGOg@mail.gmail.com>
Subject: Re: [PATCH 2/7] intel_idle: clean up the (new) state_update_enter_method
 function
To:     arjan@linux.intel.com
Cc:     linux-pm@vger.kernel.org, artem.bityutskiy@linux.intel.com,
        rafael@kernel.org, Arjan van de Ven <arjan.van.de.ven@intel.com>
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

On Thu, Jun 1, 2023 at 8:28 PM <arjan@linux.intel.com> wrote:
>
> From: Arjan van de Ven <arjan.van.de.ven@intel.com>
>
> Now that the logic for state_update_enter_method() is in its own
> function, the long if .. else if .. else if .. else if chain
> can be simplified by just returning from the function
> at the various places. This does not change functionality,
> but it makes the logic much simpler to read or modify later.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

This and the [1/7] can be applied without the rest of the series, so
please let me know if you want me to do that.

> ---
>  drivers/idle/intel_idle.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index c351b21c0875..256c2d42e350 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1849,7 +1849,10 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
>                 WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IBRS);
>                 WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
>                 state->enter = intel_idle_xstate;
> -       } else if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
> +               return;
> +       }
> +
> +       if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
>                            state->flags & CPUIDLE_FLAG_IBRS) {
>                 /*
>                  * IBRS mitigation requires that C-states are entered
> @@ -1857,9 +1860,15 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
>                  */
>                 WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
>                 state->enter = intel_idle_ibrs;
> -       } else if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE) {
> +               return;
> +       }
> +
> +       if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE) {
>                 state->enter = intel_idle_irq;
> -       } else if (force_irq_on) {
> +               return;
> +       }
> +
> +       if (force_irq_on) {
>                 pr_info("forced intel_idle_irq for state %d\n", cstate);
>                 state->enter = intel_idle_irq;
>         }
> --
> 2.40.1
>
