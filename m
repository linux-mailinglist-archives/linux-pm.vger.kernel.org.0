Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7225A28C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 03:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBBIv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 21:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgIBBIu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 21:08:50 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A15C061244;
        Tue,  1 Sep 2020 18:08:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d26so4298265ejr.1;
        Tue, 01 Sep 2020 18:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJmsjMjQXD9euSDFDAcpYgZuaejqzhy2qITfzbgNpKE=;
        b=TAeyufl1suFcqLh+QauL42AgfbkE13Sa2w2NWZJ/rEDu8d08pjJyzxTeVnwh2WEcnD
         sTrtJLhT1iBSQ1cPak0dvNxTUTN96v6br9TBPWGGoWA1DO6ELlZ+3ap486eedQZV7nLb
         r88wUh9wtr/7MUzyFRxearWkGGjRFhRcol/IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJmsjMjQXD9euSDFDAcpYgZuaejqzhy2qITfzbgNpKE=;
        b=YCcwdI9XjEryLUmsRBAC3oul1z0UucU1xFseTfNPmhhCwt543wWwyWS58YptUhZyxX
         KwLkd6VRjvp7VHMtHiM+P63PKCeObvt5/2ruAD0SVYYE1C4PDoiA2iCTzgHV6lPBuP+x
         OYCq58CErixYfChNwsLcUz5C6/1Gs7kxHeq+4dEohWziwJYUfaWyfqGV26uGLK/bBYBJ
         5MlJ3s0KxOiIjvZuJsIaSQQl0JzqH7cLQIhLPSFogNPXle87TUDtGfKs0MRB3p24B4Ji
         oCvrXXXqcSpjNNuMnHv4V3vFd8GK7+kuYAR1/wFkZoi7QeygMEy7KijX7Vj0RlT6ckhj
         KwXw==
X-Gm-Message-State: AOAM533oEfyuxgxz+o6qCAZsTUFRycgV1cu1q11pTvj8BX93PjFMyn08
        2xN2FPKJ0i0rjD8d32Ny1EE4iKewAYCiPA0ukBs=
X-Google-Smtp-Source: ABdhPJzT3Dik4BO60pm+fdl9vlDHqT+pk5zT0GT/JkiiAEnkjOqWwch8KcIADNWOBsQFD2hK/CkwbOXoIgzgO75LL1Y=
X-Received: by 2002:a17:906:c351:: with SMTP id ci17mr3945397ejb.266.1599008928180;
 Tue, 01 Sep 2020 18:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <1598969293-29228-1-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1598969293-29228-1-git-send-email-ego@linux.vnet.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Sep 2020 01:08:35 +0000
Message-ID: <CACPK8XfZdnKusEuu8i=-aH=Wfr6X6sMrvX=btFq9PtnXJ2w-SQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle-pseries: Fix CEDE latency conversion from tb to us
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 1 Sep 2020 at 14:09, Gautham R. Shenoy <ego@linux.vnet.ibm.com> wrote:
>
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
> CEDE(0)") sets the exit latency of CEDE(0) based on the latency values
> of the Extended CEDE states advertised by the platform. The values
> advertised by the platform are in timebase ticks. However the cpuidle
> framework requires the latency values in microseconds.
>
> If the tb-ticks value advertised by the platform correspond to a value
> smaller than 1us, during the conversion from tb-ticks to microseconds,
> in the current code, the result becomes zero. This is incorrect as it
> puts a CEDE state on par with the snooze state.
>
> This patch fixes this by rounding up the result obtained while
> converting the latency value from tb-ticks to microseconds.
>
> Fixes: commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
> CEDE(0)")
>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Should you check for the zero case and print a warning?

> ---
>  drivers/cpuidle/cpuidle-pseries.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index ff6d99e..9043358 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -361,7 +361,7 @@ static void __init fixup_cede0_latency(void)
>         for (i = 0; i < nr_xcede_records; i++) {
>                 struct xcede_latency_record *record = &payload->records[i];
>                 u64 latency_tb = be64_to_cpu(record->latency_ticks);
> -               u64 latency_us = tb_to_ns(latency_tb) / NSEC_PER_USEC;
> +               u64 latency_us = DIV_ROUND_UP_ULL(tb_to_ns(latency_tb), NSEC_PER_USEC);
>
>                 if (latency_us < min_latency_us)
>                         min_latency_us = latency_us;
> --
> 1.9.4
>
