Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE41813C9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 09:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCKI6H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 04:58:07 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33565 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKI6H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 04:58:07 -0400
Received: by mail-vs1-f66.google.com with SMTP id n27so827697vsa.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2020 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gU9ErITT1QpCPjL82L11n7TGUqA4ycf13KZv8wmMFUs=;
        b=pNxDDKgBb9qmnTlpnjI08oEZvwCsHtVy6nFYbnGtUf+nLRY4z2KyI2VjERT72GdI4I
         L6GI7YXSQtT07fB1OTdwOQkEsLsIKvspk1bw6zURmukghssL6foEBt9BcxyxyJLv6grl
         2vTouZHCkvqXfKWmArJ9BrKfqY4305jpiWQ1UZ4D0DXxiOUadjY9LdsJ2GdphQCBxe56
         Q9bhQsWAqXRvI9zgYkfoiAfB2FyMjm7XytZrRwo/1x1SM3Lnf7f22Kmj7qhIPMaHBtfH
         /oqIs74MNOc9RVbolhE6iLDaZqUu/N59WvyEbsnhxRryrgsLvg+Pjmv/s/q6gWI09ut5
         i//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gU9ErITT1QpCPjL82L11n7TGUqA4ycf13KZv8wmMFUs=;
        b=iAZ06n05hfiAO4gzPwCujhIlQpCjHeg3HcMBPEOY4w3HlyBels4vUlRPtgP7s7YgNS
         b7HmzJQztPJfQb6b8EX0byxsN3KFFKewmTMYHQ/IJzTrGccOfArzR/LoSkkUwHBgqB/l
         TaiqnP3s2LQISDk64yMCCABZcHCMrcUPws0GV09Oo8tliR8T7463cXC3vsLcrAnhXzlK
         eqGkSjyQS8hcfkQ84uxRkJc07U1LelvibPvBPU0dLkLUQaM3+YOJF5uAxByaR+XuFNv5
         yoPcUaQa6qZMPE6dl+lhhJzBDXtQLiuO2WKREnW0ypKa6n/L+y9t0/vERq9qOCk/3nuZ
         eAMA==
X-Gm-Message-State: ANhLgQ1DGIlXuMDJ7Rr9OajR9b2URgmoSqCo4sK1er3e2pFJAIz3cVto
        JKbWQtjdRHVS3KcUfpClxjor0PFWcFXOeZ2zfFYoOg==
X-Google-Smtp-Source: ADFU+vtOR68AAuws2jiKlsA3945WHYipYLNHGQ2Ef2RWnrCXylZalAG4BHR0y5+N6tGeQ66q3W76CQ/Cw+FS06wgxlw=
X-Received: by 2002:a67:870f:: with SMTP id j15mr1212241vsd.95.1583917085791;
 Wed, 11 Mar 2020 01:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com> <1583903252-2058-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1583903252-2058-2-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 11 Mar 2020 14:27:54 +0530
Message-ID: <CAHLCerOLaXqejgAZYB1_QZ5WiUK4p+nsmhfVQqgKDW--DSC0bA@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: qoriq: Sort includes alphabetically
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 11, 2020 at 10:44 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Sort includes alphabetically for consistency, and take this chance
> to remove unused include of of_address.h.


Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/qoriq_thermal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 67a8d84..028a6bb 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -3,12 +3,11 @@
>  // Copyright 2016 Freescale Semiconductor, Inc.
>
>  #include <linux/clk.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/sizes.h>
>  #include <linux/thermal.h>
> --
> 2.7.4
>
