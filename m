Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6344272185B
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jun 2023 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjFDPzI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sun, 4 Jun 2023 11:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjFDPzF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jun 2023 11:55:05 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E0DDF
        for <linux-pm@vger.kernel.org>; Sun,  4 Jun 2023 08:55:04 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-977d3292be0so16812566b.1
        for <linux-pm@vger.kernel.org>; Sun, 04 Jun 2023 08:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685894103; x=1688486103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/dDtElB7q30aD2QguPmnh4ENDLkJY0HSWqXaGeimlk=;
        b=ZwWI+FBBgEyhovIpVaA0k32NoxjCmkrHGkS7n4dRFlLw5b9XHy3W6RvwjskPYpb1Gx
         +Kvs6SDYTQuVyzcVQKSMPy2M5Wdj7sbFnDduMQvY5BZnflG2+dhdG4sXDWC1kEUWJg/v
         GqJMgc+mXJcgiDdSqVMTPIJ/XfwExueYxN6/QRvzmcc4fvFJ3u5HftGKUvd5P0t2if4U
         qudSSkCNiDaaxY9SyCsEaoN2T4grJ0POYzRlrSR+IEkM9I7SxmH15tWCyfSOUPANxRij
         Rv8qKAX/UMyFJui7RwpIQU+YJV/C3vWsm/ec6XiiQa410kz6QUTsNpSngoG+tXpT5Vro
         GYyQ==
X-Gm-Message-State: AC+VfDyWwJJa8mPo+87leut4YsvfN/boLCPazE69tYgJ6oq27ureZ63s
        xL5Y2js7yEhyOVZKNi0/J0ULzcuxFx9mLHlFq7jOJQDXnz0=
X-Google-Smtp-Source: ACHHUZ5UL0Z21mHYowFX3CjjoFnSijIoyJ7eWATt+rHCc/4do7Fz3OnscDT5lgqyTk+PzlqgA6/N++9723EQEkvLKaU=
X-Received: by 2002:a17:906:74d1:b0:977:b21d:7d8c with SMTP id
 z17-20020a17090674d100b00977b21d7d8cmr3765164ejl.6.1685894102673; Sun, 04 Jun
 2023 08:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230601182801.2622044-1-arjan@linux.intel.com> <20230601182801.2622044-6-arjan@linux.intel.com>
In-Reply-To: <20230601182801.2622044-6-arjan@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 17:54:51 +0200
Message-ID: <CAJZ5v0gUCmf1e+uSQnYbQcTUjqDqKVjgJ=UaXW7Rk6NjB5K3Eg@mail.gmail.com>
Subject: Re: [PATCH 5/7] intel_idle: Add a way to skip the mwait check on all states
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
> Currently, intel_idle verifies that the cpuid instruction enumerates
> that the mwait value for a state is actually supported by the CPU.
>
> Going forward, when running in a VM guest, that check will not work
> and we're going to need a way to turn it off.
>
> Add a global bool for this, and uses this in the check
> function to short circuit this cpuid check.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 66d262fd267e..55c3e6ece3dd 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -69,6 +69,7 @@ static int max_cstate = CPUIDLE_STATE_MAX - 1;
>  static unsigned int disabled_states_mask __read_mostly;
>  static unsigned int preferred_states_mask __read_mostly;
>  static bool force_irq_on __read_mostly;
> +static bool skip_mwait_check __read_mostly;
>
>  static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
>
> @@ -1866,6 +1867,9 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
>         unsigned int num_substates = (mwait_substates >> mwait_cstate * 4) &
>                                         MWAIT_SUBSTATE_MASK;
>
> +       if (skip_mwait_check)
> +               return true;
> +

I don't think that the static variable is needed here.

This function is only called from intel_idle_init_cstates_icpu() which
in turn is only called by intel_idle_cpuidle_driver_init().

The latter is called directly by intel_idle_vminit() in the next patch
and so it can be passed a bool arg indicating whether or not to skip
the mwait checks.

I would even check this arg in intel_idle_init_cstates_icpu() so it is
not necessary to look into intel_idle_verify_cstate() to see what it
is for.

>         /* Ignore the C-state if there are NO sub-states in CPUID for it. */
>         if (num_substates == 0)
>                 return false;
> --
