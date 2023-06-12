Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C8772CD84
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbjFLSJW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 12 Jun 2023 14:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbjFLSJS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 14:09:18 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9387A7
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 11:09:16 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f64f21b6f0so976719e87.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 11:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593355; x=1689185355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL7cRgOWSCUPGVzFqtksv2UWaR5IoDwWi1rlM4CaafI=;
        b=DiOOhXZOTsIJLRNoCUw+N2Os8r2+xIXNiNNdha8suiLKMJTaGuxSlLclKhkibPBaRW
         jJIlr0Tf1PD0N9tXZw1l3ow6gNPCG2Sl0J7KDXf+yH16CxoNLadzvi26nIR5kVgvQASP
         UoggFC5+JTcCwNUqai7UAAtoGzKpLd+Ew1QohmFH0E501hiP+1vDakCFH15rxQy3m5Nk
         tcwRSgtNUQop4V3+32xoT+JVv/V77Fu9YvyehzRnxDLbVs35vfDSdw181qNuiIsdp8hx
         9OnW9r5QT0hxUZBLMeAXfaX25QfE3UDLKVbyzBo3hEFQ+zrnZj5Xpw0GF9nY2oPOUMWA
         eo/A==
X-Gm-Message-State: AC+VfDxs+Ory7CbVMX1moGD+mnnmzOWaUGwVh9axoasDd40ALBqnyYay
        yv+T9mbBMGvsMdBVDWTG822x08eWKso0i1nbhwA=
X-Google-Smtp-Source: ACHHUZ41zspbUUN2W5VCBuzlnF8UIq8/Dj0tlcPdOxmIfVi065yMtVBa8hflkHWKdeSj/Y4Yeuul1N43nPf0Xr+fA6Q=
X-Received: by 2002:a05:651c:3c2:b0:2b2:d2e8:9f40 with SMTP id
 f2-20020a05651c03c200b002b2d2e89f40mr3034055ljp.5.1686593354875; Mon, 12 Jun
 2023 11:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230605154716.840930-1-arjan@linux.intel.com> <20230605154716.840930-3-arjan@linux.intel.com>
In-Reply-To: <20230605154716.840930-3-arjan@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 20:09:03 +0200
Message-ID: <CAJZ5v0g0K-Lenhx=5AcDM-O1c3ChJ12ka4ejcU6+_nWKNxfErA@mail.gmail.com>
Subject: Re: [PATCH 2/4] intel_idle: clean up the (new) state_update_enter_method
 function
To:     arjan@linux.intel.com
Cc:     linux-pm@vger.kernel.org, artem.bityutskiy@linux.intel.com,
        rafael@kernel.org
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

On Mon, Jun 5, 2023 at 5:47 PM <arjan@linux.intel.com> wrote:
>
> From: Arjan van de Ven <arjan@linux.intel.com>
>
> Now that the logic for state_update_enter_method() is in its own
> function, the long if .. else if .. else if .. else if chain
> can be simplified by just returning from the function
> at the various places. This does not change functionality,
> but it makes the logic much simpler to read or modify later.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
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

This and the [1/4] applied as 6.5 material.

I'll get to the other two shortly.

Thanks!
