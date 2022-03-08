Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9634D1935
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 14:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbiCHNdi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 08:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiCHNdf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 08:33:35 -0500
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4A61B786
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 05:32:38 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id z30so24947770ybi.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2022 05:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bHIvvL2sOeYDH5/vIxNi5UsSy/nVkzPtzV5JWbs1S0=;
        b=INtrpnARuZn/s4V0YgmnsSSo1AMqW11F71I5LgVBCUEtuD5U8FSSPcrGBnKoZB3ptY
         VzKQW0OIjJZCq100v3j48wjgfjq+gnhCRg8/7McqbYsE68SfLORyb00dh+GvKCzilSSn
         q4r75bYUFoLgF54vIEbxI1TnuxjQDKWXAg45eF+f01+JEloI8tmPhVdLWwSJgXrJqaAe
         osnfzPLlY2MZ7FJp/dH35VaYDHQTvMVhf1zUVHl6UHCd9tuQZ/bbue/uz6ikfPbkiVfz
         SzDYK4jZwJ13L2gz5eHjzSkNkunebY2lktYOFankHN7dkg5fwmrnEI/i4zqRog1bje3X
         Xn3g==
X-Gm-Message-State: AOAM531Wrf4XOkujidOUeclaIg4p9/fiy49AeXdkgxjuz6IS2gEWJipM
        77zjFuJWE6AgHx24GVeSLW+6LUawgDs5H36kAPRtxz8c
X-Google-Smtp-Source: ABdhPJyuNXsORjMKSPHCxo9uhzz6vRQxjs7WwHcw1VcIFX4ftLLvIIx2UYkw057ibDWeiK/2UmkTbegqY1RL6U5Gj1Y=
X-Received: by 2002:a25:3a41:0:b0:628:86a2:dbc with SMTP id
 h62-20020a253a41000000b0062886a20dbcmr11629052yba.633.1646746357831; Tue, 08
 Mar 2022 05:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20220308114101.3872868-1-dedekind1@gmail.com>
In-Reply-To: <20220308114101.3872868-1-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Mar 2022 14:32:25 +0100
Message-ID: <CAJZ5v0i60xdW=pGAGrwjvd_Bp2pLsr9Q6C_cvGg=e_O+89rzSQ@mail.gmail.com>
Subject: Re: [PATCH resend] turbostat: fix PC6 displaying on some systems
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, Yu Chen <yu.c.chen@intel.com>,
        Kin Cho <kin.cho@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 8, 2022 at 12:41 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> 'MSR_PKG_CST_CONFIG_CONTROL' encodes the deepest allowed package C-state limit,
> and turbostat decodes it.
>
> Before this patch: turbostat does not recognize value "3" on Ice Lake Xeon
> (ICX) and Sapphire Rapids Xeon (SPR), treats it as "unknown", and does not
> display any package C-states in the results table.
>
> After this patch: turbostat recognizes value 3 on ICX and SPR, treats it as
> "PC6", and correctly displays package C-states in the results table.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Note 1: I apologize for submitting this patch several times. I clearly forgot
> how to use 'git send-email' and missed the '--dry-run' option. Sorry for this.
>
> Note 2: this patch is a rebased version of the same patch I sent earlier:
> https://patchwork.kernel.org/project/linux-pm/patch/20211004105224.3145916-1-dedekind1@gmail.com/
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 47d3ba895d6d..bc5ae0872fed 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -2323,7 +2323,7 @@ int skx_pkg_cstate_limits[16] =
>  };
>
>  int icx_pkg_cstate_limits[16] =
> -    { PCL__0, PCL__2, PCL__6, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV,
> +    { PCL__0, PCL__2, PCL__6, PCL__6, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV,
>         PCLRSV, PCLRSV
>  };
>
> --

turbostat material has been handled by Len so far, but I've queued up
this patch for 5.18.

Thanks!
