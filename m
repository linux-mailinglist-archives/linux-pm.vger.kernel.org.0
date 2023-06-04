Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31517721815
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jun 2023 17:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFDPB3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sun, 4 Jun 2023 11:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDPB2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jun 2023 11:01:28 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF9F83
        for <linux-pm@vger.kernel.org>; Sun,  4 Jun 2023 08:01:27 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-974539fd9f0so65424166b.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Jun 2023 08:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685890885; x=1688482885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vBlLS8JticIB6GsRN1lEWPgN19Qtc5J5rWjPP6B4mM=;
        b=anpwwXdolfJvA0kQ536enGLocMoPqCwWElxeKtshypAhGi7W34lf2LlKStGyhZReqv
         TYWfCUD367FWeg2wC8oV8nK9YhDNWeqImr8DyVRpOEqYCyzuMUoqQ1KiGYKXVY0wiRlD
         9G/hwEqMXIEAZjcLUCHaGkMtOVIIqjk1beJDqkzbTvMslbKNinCP1OuUOu8hBypSBgcI
         o1AoHtaXOD2AH6JffXKPKJa9CTsl7RrQtMZAIJ2V1YJ+/lxReZp+J53WQWREpR7BnV4K
         6f1g1Ya9IPN2a/E46SJ4sfCJJJSpmpwihA2/p+GiLRbqT1ZZF9e/B2gklQpKjfOusQ8w
         u1jw==
X-Gm-Message-State: AC+VfDyThff52VWyrtRtBgaIJd4jxeFCbixLz2HBtVnJ/O5Mkc9V8bwi
        d6iHiDGiaX05XHJu94zSFaG0R2aJH7VZPatV2ODr1G2S
X-Google-Smtp-Source: ACHHUZ5cdwlkyOzk1Y2D4u6lGVmaYZWzUUl5mSPG6FqkDQx+62xxTrIu8KXNvkpTiZd1EobvcJZ+MHcGnaGvEudaRGE=
X-Received: by 2002:a17:906:109b:b0:974:5480:6270 with SMTP id
 u27-20020a170906109b00b0097454806270mr6276951eju.0.1685890885270; Sun, 04 Jun
 2023 08:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230601182801.2622044-1-arjan@linux.intel.com>
In-Reply-To: <20230601182801.2622044-1-arjan@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 17:01:14 +0200
Message-ID: <CAJZ5v0hL+v22S6RX+2y8B+3RL3uSUJ-i6N8kEuLcOXKN3zgx9Q@mail.gmail.com>
Subject: Re: [PATCH 00/7 Add support for running in VM guests to intel_idle
To:     arjan@linux.intel.com
Cc:     linux-pm@vger.kernel.org, artem.bityutskiy@linux.intel.com,
        rafael@kernel.org
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
> From: Arjan van de Ven <arjan@linux.intel.com>
>
> intel_idle provides the CPU Idle states (for power saving in idle) to the
> cpuidle framework, based on per-cpu tables combined with limited hardware
> enumeration. This combination of cpuidle and intel_idle provides dynamic
> behavior where power saving and performance impact are dynamically balanced
> and where a set of generic knobs are provided in sysfs for users to tune
> the heuristics (and get statistics etc)
>
> However, intel_idle currently does not support running inside VM guests, and
> the linux kernel falls back to either ACPI based idle (if supported by the
> hypervisor/virtual bios) or just the default x86 fallback "hlt" based idle
> method... that was introduced in the 1.2 kernel series... and lacks all the
> dynamic behavior, user control and statistics that cpuidle brings.
>
> While this is obviously functional, it's not great and we can do better
> for the user by hooking up intel_idle into the cpuidle framework also
> for the "in a guest" case.
> And not only not great for the user, it's also not optimal and lacks two
> key capabilities that are supported by the bare metal case:
>
> 1) The ability to flush the TLB for very long idle periods, to avoid
>    a costly (and high latency) IPI wakeup later, of an idle vCPU when a
>    process that used to run on the idle vCPU does an munmap or similar
>    operation. Avoiding high latency IPIs helps avoid performance jitter.
> 2) The ability to use the new Intel C0.2 idle state instead of polling
>    for very short duration idle periods to save power (and carbon footprint)
>
> This patch series adds the basic support to run in a VM guest
> to the intel_idle driver, and then addresses the first of these shortfalls.

Is intel_idle supposed to replace ACPI idle inside VM guests where it
is supported?

If not, how is it prevented from taking over in those cases?

> The C0.2 gap will be fixed with a small additional patch after the
> C0.2 support is merged seperately.
>
> Arjan van de Ven (7):
>   intel_idle: refactor state->enter manipulation into its own function
>   intel_idle: clean up the (new) state_update_enter_method function
>   intel_idle: Add a sanity check in the new state_update_enter_method
>     function
>   intel_idle: Add helper functions to support 'hlt' as idle state
>   intel_idle: Add a way to skip the mwait check on all states
>   intel_idle: Add support for using intel_idle in a VM guest using just
>     hlt
>   intel_idle: Add a "Long HLT" C1 state for the VM guest mode
>
>  drivers/idle/intel_idle.c | 216 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 194 insertions(+), 22 deletions(-)
>
> --
