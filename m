Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956A5580428
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jul 2022 20:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiGYSmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jul 2022 14:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiGYSmE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2022 14:42:04 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE191C914
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 11:42:02 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id i14so21722475yba.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 11:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eGJ/EyemtwiclRDOY6J0pieoHL35ja71OCA+705OUww=;
        b=GD+RyKMn+8XCzDI0EBp1Ve1xaxOTUripYLD4RLqINl24jSSUFLzLxkLwy5WQminLuB
         QoMva0ePM7mCR1YHtLYPIfymJxFzHi61H4yyxtweFQnljNvFsVJBMuG9C30hf7PZXcqW
         9bBt1BwjeaXWhK6KezLYECfztyzO+/Yx2Vm2hA9Gh5zG0vDyt4GCPGbNyakl1xGafWyh
         NoEQho+Gqmni2NYOhTrKyX7yMbeQ7jbwfc4FG2nNBxDP6t2odgfePszVID/Z16YnOL3C
         vriIghGa92LCt3/xmzhAq7wizNESm3z9PnNGL8XBiAOVB+78sCBqv6Z1tsT27rLPL3sw
         tn5A==
X-Gm-Message-State: AJIora8Z8vM/muR4B0byPrI8ilASH/ZcW4NInBb+wDUP7rODOpaBB4Lj
        qGmBuc2I1JZc5J/b5fGSQaPDksyqU47cxOLGsapdCLE7
X-Google-Smtp-Source: AGRyM1tXhT5VN3m0BdiiYsJuZhGyzLs41L7u+jneF2q4auDCrKG+7wfwNhu/7zUsWjS0/zV0HcM0ps9O0MwdxITmDEk=
X-Received: by 2002:a5b:202:0:b0:66f:aab4:9c95 with SMTP id
 z2-20020a5b0202000000b0066faab49c95mr10373463ybl.81.1658774521973; Mon, 25
 Jul 2022 11:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220716062655.704893-1-dedekind1@gmail.com>
In-Reply-To: <20220716062655.704893-1-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jul 2022 20:41:51 +0200
Message-ID: <CAJZ5v0iy_yH4bdJO+tCYrZMMDUFN81rFymR=b7Q6MfE4smzoPw@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: make SPR C1 and C1E be independent
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 16, 2022 at 8:27 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> This patch partially reverts the changes made by the following commit:
>
> da0e58c038e6 intel_idle: add 'preferred_cstates' module argument
>
> As that commit describes, on early Sapphire Rapids Xeon platforms the C1 and
> C1E states were mutually exclusive, so that users could only have either C1 and
> C6, or C1E and C6.
>
> However, Intel firmware engineers managed to remove this limitation and make C1
> and C1E to be completely independent, just like on previous Xeon platforms.
>
> Therefore, this patch:
>  * Removes commentary describing the old, and now non-existing SPR C1E
>    limitation.
>  * Marks SPR C1E as available by default.
>  * Removes the 'preferred_cstates' parameter handling for SPR. Both C1 and
>    C1E will be available regardless of 'preferred_cstates' value.
>
> We expect that all SPR systems are shipping with new firmware, which includes
> the C1/C1E improvement.
>
> Cc: stable@vger.kernel.org # v5.18+
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 424ef470223d..ba2b485a03ed 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -879,16 +879,6 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
>                 .enter = NULL }
>  };
>
> -/*
> - * On Sapphire Rapids Xeon C1 has to be disabled if C1E is enabled, and vice
> - * versa. On SPR C1E is enabled only if "C1E promotion" bit is set in
> - * MSR_IA32_POWER_CTL. But in this case there effectively no C1, because C1
> - * requests are promoted to C1E. If the "C1E promotion" bit is cleared, then
> - * both C1 and C1E requests end up with C1, so there is effectively no C1E.
> - *
> - * By default we enable C1 and disable C1E by marking it with
> - * 'CPUIDLE_FLAG_UNUSABLE'.
> - */
>  static struct cpuidle_state spr_cstates[] __initdata = {
>         {
>                 .name = "C1",
> @@ -901,8 +891,7 @@ static struct cpuidle_state spr_cstates[] __initdata = {
>         {
>                 .name = "C1E",
>                 .desc = "MWAIT 0x01",
> -               .flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE |
> -                                          CPUIDLE_FLAG_UNUSABLE,
> +               .flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
>                 .exit_latency = 2,
>                 .target_residency = 4,
>                 .enter = &intel_idle,
> @@ -1724,17 +1713,6 @@ static void __init spr_idle_state_table_update(void)
>  {
>         unsigned long long msr;
>
> -       /* Check if user prefers C1E over C1. */
> -       if ((preferred_states_mask & BIT(2)) &&
> -           !(preferred_states_mask & BIT(1))) {
> -               /* Disable C1 and enable C1E. */
> -               spr_cstates[0].flags |= CPUIDLE_FLAG_UNUSABLE;
> -               spr_cstates[1].flags &= ~CPUIDLE_FLAG_UNUSABLE;
> -
> -               /* Enable C1E using the "C1E promotion" bit. */
> -               c1e_promotion = C1E_PROMOTION_ENABLE;
> -       }
> -
>         /*
>          * By default, the C6 state assumes the worst-case scenario of package
>          * C6. However, if PC6 is disabled, we update the numbers to match
> --

Applied as 5.20 material, thanks!
