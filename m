Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3931A72183E
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jun 2023 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjFDPnu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sun, 4 Jun 2023 11:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjFDPnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jun 2023 11:43:49 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BFED3
        for <linux-pm@vger.kernel.org>; Sun,  4 Jun 2023 08:43:48 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-974604c1394so68753566b.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Jun 2023 08:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685893427; x=1688485427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sy+peT2R+usJlNDXEsGuOE47toF02SzS/Vz5HbH6Vyw=;
        b=h8EAJ9LLW67vz2PXCGgwckxPZ/CPCsFvqiuImeNHliMO6TWYaoX8WvOhsEg+CCBKiQ
         j9RbZejgm4mtGrjYCXla++ftTfdDelWohiO0oMi2qoHX+bvgyBaHiBpdadeAwMuJ3D3r
         xLnsfELzRNAvsI0Q4EA4dv4NMBf1EsvIJpKxtWMzwWqqK4POsdKuM/o9Px3aCenyMhSM
         Q6vU4s8pTX9cO33+cqaKm8MApswZWHePzU9sG2M50D+3LVqYGeiLMe0MM6Ygifvty3+A
         2Fpp+l0UwFyVcJNm+nj1wgfAMcC/Au1krGCF8ORPYhZByIHCwo1X849QgFnZmyXmbg7e
         4iDg==
X-Gm-Message-State: AC+VfDwS83vb48vtJDcMRiYWzj8/dvdK8/tKOi8tGfHMiaTGFgzrOyc0
        GbOeo8LopHurLfGJjhbt6jr4wYcveJ194q8mR9V7q/EsFvI=
X-Google-Smtp-Source: ACHHUZ7h54ysfTsIc1EmWj6n1HCuf30PbIXiEBMs/JnPhftsIYbivzQ/+okkyTx9IzylO0gmWSsb0598hNUmaFu2/mA=
X-Received: by 2002:a17:906:7a13:b0:974:1caa:f660 with SMTP id
 d19-20020a1709067a1300b009741caaf660mr13962244ejo.5.1685893427043; Sun, 04
 Jun 2023 08:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230601182801.2622044-1-arjan@linux.intel.com> <20230601182801.2622044-4-arjan@linux.intel.com>
In-Reply-To: <20230601182801.2622044-4-arjan@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 17:43:36 +0200
Message-ID: <CAJZ5v0iEVQpvvtrAkD7gq2hFLJspmxLF20DyW9OBtg5vYEpqaA@mail.gmail.com>
Subject: Re: [PATCH 3/7] intel_idle: Add a sanity check in the new
 state_update_enter_method function
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
> The state_update_enter_method function updates a state's enter function pointer,
> but does so assuming that the current function is "intel_idle" or "intel_idle_irq".
>
> In the code currently that's basically the case, but soon this will change.
> Add a sanity check early in the function to make the assumption explicit,
> and return early if the precondition is not met.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 256c2d42e350..8415965372c7 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1841,6 +1841,14 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
>
>  static void state_update_enter_method(struct cpuidle_state *state, int cstate)
>  {
> +       /*
> +        * The updates below are only valid if state->enter is actually the
> +        * 'intel_idle' or 'intel_idle_irq' functions; for all other cases
> +        * we just bow out early.
> +        */
> +       if (state->enter != intel_idle && state->enter != intel_idle_irq )
> +               return;

Instead of doing this, I would add a check against intel_idle_hlt_irq
in patch [6/7] and extend it to cover intel_idle_hlt in patch [6/7],
because these are the cases to skip here.

> +
>         if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
>                 /*
>                  * Combining with XSTATE with IBRS or IRQ_ENABLE flags
> --
> 2.40.1
>
