Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D90759D43
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jul 2023 20:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjGSS3E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 19 Jul 2023 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGSS3E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2023 14:29:04 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E24B6
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2023 11:29:03 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b951a1a03bso7297251fa.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2023 11:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689791341; x=1692383341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEkMwuHdZu9EtLFAmtNGkY+E4/dneZKf8Grdd/ubuRg=;
        b=CcbBVbVQyS4jBMUlOmirgqDTndSe2Yp42ViESXZpD4TMi0jgtkp6yoDqegvCG9dKZv
         IqbPzcR6fmoBRHxxZOW+zWR6TCTjFPFVbQa4fdjaFdgxCCKYPDAc4tpzseUtpMEpXBPO
         6Xx8q9tGgY3ldhFGJwv0gCyX2PSaMPhzQIyI6ydMrSzA4tONdmWXtqk/ExIzSyg2dG19
         0q681RmW4PtaBen1lnJ0vQfog89Ga3tp1j7crX/hV/w/ZLTI0FgSeYut4Y9/I7gjhHQA
         h82SeU+9FeHJKInBqmjwmnqvb3c5YEUdNb0yzuh3F4E0XSq8GWMDztRtehx+aQR53vOx
         jsVQ==
X-Gm-Message-State: ABy/qLbq0qOfwlU3MQccpjLOeBCjZcEctiGjZ8B143CzYODHn9CvRhV9
        g4oson57zBObOhE6hkRaWqlYLA6QDr7LkrktP1EwZQPV
X-Google-Smtp-Source: APBJJlEBg+J3zw/lq8N3yh7T+wQuPdZlfsBv/Ko3yMQX6SgrMu4elfQ63lomDnNBlBpBu4iQtTqI3a2FvHy2FfnL6vI=
X-Received: by 2002:a2e:b105:0:b0:2b6:999f:b16c with SMTP id
 p5-20020a2eb105000000b002b6999fb16cmr409841ljl.4.1689791341103; Wed, 19 Jul
 2023 11:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230717151856.2529029-1-arjan@linux.intel.com>
In-Reply-To: <20230717151856.2529029-1-arjan@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jul 2023 20:28:49 +0200
Message-ID: <CAJZ5v0jMJwqwLcZA1c9qU5yJZsxJDBtT+BA=SmkKqxQcxOuRSA@mail.gmail.com>
Subject: Re: [PATCH 1/4] intel_idle: refactor and split out model specific
 fixups into its own function
To:     arjan@linux.intel.com
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 17, 2023 at 5:19 PM <arjan@linux.intel.com> wrote:
>
> From: Arjan van de Ven <arjan@linux.intel.com>
>
> As this list has been growing over time, lets split it into its own function.
> That also makes it possible to move other hw workarounds into this function over time.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

After a discussion with Peter I have decided to revert the original
changes, sorry about that.

IMV Peter has a point regarding the lack of data supporting the
claimed performance gain and without the umwait part they are rather
hard to defend.

> ---
>  drivers/idle/intel_idle.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index b930036edbbe..3bab6500697a 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1955,10 +1955,8 @@ static bool should_verify_mwait(struct cpuidle_state *state)
>         return true;
>  }
>
> -static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
> +static void __init model_specific_fixups(void)
>  {
> -       int cstate;
> -
>         switch (boot_cpu_data.x86_model) {
>         case INTEL_FAM6_IVYBRIDGE_X:
>                 ivt_idle_state_table_update();
> @@ -1983,6 +1981,13 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>                 adl_idle_state_table_update();
>                 break;
>         }
> +}
> +
> +static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
> +{
> +       int cstate;
> +
> +       model_specific_fixups();
>
>         for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
>                 struct cpuidle_state *state;
> --
> 2.41.0
>
