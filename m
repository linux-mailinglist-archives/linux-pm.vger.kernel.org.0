Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2038B753EF4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jul 2023 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjGNPe7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 14 Jul 2023 11:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbjGNPe6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 11:34:58 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF82D68
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 08:34:57 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-98e2865e2f2so54696566b.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 08:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689348896; x=1689953696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XPHBmq0TIOA1euXbS+4nIlI6UWd+FMwT1rRpO/HkvI=;
        b=UMp6b3HOlV7NjZUhdzEwc0NmF5Z/l+64s8J8Oh1LAZ2Yv8b6tXQDI8h/XVu9QAwLV8
         9X1GhzxHVwFfd8KX9TWpkn5w46O9fam1qdk8KZDCO3qyKwTLwqH0JNE2BIhL8gO2tA7n
         QMkWkk17eo9k2eMUdJHXrZoYcZ/fyRHnKVfxLTOvf6G9ciunkWM6kWIyM+Mt/HTUJ4UB
         +dcftvsTxTHgFCLuSDGujw9cfz+79KqIa9WKH/Ha55gCKTPvsu1v612vlI2XGnewF0hm
         R6VYybIMVUKkhCnFWEve6CT/sL10jToQWaOagbQXwk9Yeh41mRzaItOdifmAhWZIkLkJ
         gbMQ==
X-Gm-Message-State: ABy/qLYFYcma/goJeNvCdtrY221LecU67sBOA4vM2j1XQWjzeFrgVwhw
        m9QBgx2vDljbrbDF6AukbSlB9a2Mnr5RkMmlcqM=
X-Google-Smtp-Source: APBJJlFwbvGBRVFmdJuNmA1fpDG64V/vruae2q24a7xuxg3CjpJsiW+esXlnq+WAHZPh492HktuYUdfFwEczUPm2Rdc=
X-Received: by 2002:a17:906:2205:b0:993:d0e1:f308 with SMTP id
 s5-20020a170906220500b00993d0e1f308mr3929072ejs.2.1689348895862; Fri, 14 Jul
 2023 08:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230710093100.918337-1-dedekind1@gmail.com> <20230710093100.918337-4-dedekind1@gmail.com>
In-Reply-To: <20230710093100.918337-4-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 17:34:43 +0200
Message-ID: <CAJZ5v0hb9ns2yZ==n83viqniCr4QqupY+FKR2Dy0jE0Obahq_g@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] intel_idle: rename 'intel_idle_hlt_irq_on()'
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Mon, Jul 10, 2023 at 11:31 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Rename 'intel_idle_hlt_irq_on()' to 'intel_idle_hlt_irq()' for consistency with
> 'intel_idle_irq()'.
>
> While on it, fix indentation in 'intel_idle_hlt_irq()' declaration to use tabs
> instead of white-spaces.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

I think I can apply this right away without the rest of the series as
it doesn't seem to depend on the other patches.

Any concerns regarding this?

> ---
>  drivers/idle/intel_idle.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index b930036edbbe..0a835f97de72 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -224,8 +224,8 @@ static __cpuidle int intel_idle_hlt(struct cpuidle_device *dev,
>         return __intel_idle_hlt(dev, drv, index);
>  }
>
> -static __cpuidle int intel_idle_hlt_irq_on(struct cpuidle_device *dev,
> -                                   struct cpuidle_driver *drv, int index)
> +static __cpuidle int intel_idle_hlt_irq(struct cpuidle_device *dev,
> +                                       struct cpuidle_driver *drv, int index)
>  {
>         int ret;
>
> @@ -1900,11 +1900,11 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
>         if (state->enter == intel_idle_hlt) {
>                 if (force_irq_on) {
>                         pr_info("forced intel_idle_irq for state %d\n", cstate);
> -                       state->enter = intel_idle_hlt_irq_on;
> +                       state->enter = intel_idle_hlt_irq;
>                 }
>                 return;
>         }
> -       if (state->enter == intel_idle_hlt_irq_on)
> +       if (state->enter == intel_idle_hlt_irq)
>                 return; /* no update scenarios */
>
>         if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
> @@ -1949,7 +1949,7 @@ static bool should_verify_mwait(struct cpuidle_state *state)
>  {
>         if (state->enter == intel_idle_hlt)
>                 return false;
> -       if (state->enter == intel_idle_hlt_irq_on)
> +       if (state->enter == intel_idle_hlt_irq)
>                 return false;
>
>         return true;
> --
> 2.40.1
>
