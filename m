Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FFE307104
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 09:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhA1IOS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 03:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhA1INQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 03:13:16 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06249C061573
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 00:12:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id z16so1228859wml.2
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 00:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FbpNwiDeT863/15cTZC2AAGS+7sfbc9swedNhiLcVTc=;
        b=j3GgrxqEipKq+zaibSuBW3ImeRruW0ZgB6gE1HkO4kS2G4P9TlW+6ms35Lfh22YUdd
         grNuc8fux1Sdvgbtfw1cEfN7rBW2BlYftfdXRs1tHFhNlIQhOBi3JhO/b3Tp+k34poc5
         J7o0dLLLI1/Bs1asv7knt5fy8NmXI545oRELZ8DGkH9jMOFi0p4dluNko7KMzaWOCCZl
         EGwJzGtM7a3f5f7zOBRLqF44K/UkhpizLlH1ssrDgzZ08r4RBHsR5kayWdad0E15JsBO
         W+jx7JJBgjJk8YE98xSVdhbW6Ez6RRCplhXiAXwkSPTWfaXybuCNU2QmRntfr7TJFGrl
         CdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FbpNwiDeT863/15cTZC2AAGS+7sfbc9swedNhiLcVTc=;
        b=Ntvl5Z5+8/0iplrpvhHI8/GQa++11CV5pPdCNrSN5S7aZ7ykfY7WavfIib5STDgJNj
         iii1eG63GgCTxQci2skNbRvOwnjY15z60Z16iyIclOyjb1yOKTgkc/aw5VU1fByfGNM2
         3GivY7IbyFmMnO6NFjnEOsfillt+BrqHUBtXdPwkBP1CRpw466cuKyA6WVop2n0vHo1R
         PmNspEVIHIApIx7Kp7y8Pxz6ttdKeHi4PN3CnNkBbVDd8shSyt/RSuecwv9iT/pkQIrD
         nw9HVEe3VqV8qc9xZaCt8Gant0tz92MUYcWjmXvTDR4Xy073Yn0EeQx87NHrT5ZflC19
         fmkA==
X-Gm-Message-State: AOAM533FsdoSiHYxSuPXliWVVI4sv3yZXpsIXSKMTf6MxrfrB/YafD7D
        hYqbLeAUvDOVnd2QMQOmjxQ/Gw==
X-Google-Smtp-Source: ABdhPJyUDo3LQYdRX3YU6zZqUg66yZ3MiIxUfGZb33Ed6R7b/LQFhlej39rLZsngzpUWIiCK9IiaSg==
X-Received: by 2002:a05:600c:35d6:: with SMTP id r22mr3035103wmq.44.1611821554629;
        Thu, 28 Jan 2021 00:12:34 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id e4sm6017454wrw.96.2021.01.28.00.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 00:12:33 -0800 (PST)
Date:   Thu, 28 Jan 2021 08:12:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/10] power: supply: ab8500: Push data to power supply
 code
Message-ID: <20210128081232.GA4774@dell>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
 <20210123221908.2993388-3-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210123221908.2993388-3-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 23 Jan 2021, Linus Walleij wrote:

> The global definition of platform data for the battery
> management code has no utility after the OF conversion,
> move the <linux/mfd/abx500/ab8500-bm.h> to be a local
> file in drivers/power/supply and stop defining the
> platform data in drivers/power/supply/ab8500_bmdata.c
> and broadcast to the kernel only to have it assigned
> as platform data to the MFD cells and then picked back
> into the same subsystem that defined it in the first
> place. This kills off a layer of indirection.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c                     | 17 +++++----
>  .../power/supply}/ab8500-bm.h                 | 19 ++--------
>  drivers/power/supply/ab8500_bmdata.c          |  3 +-
>  drivers/power/supply/ab8500_btemp.c           | 35 +++----------------
>  drivers/power/supply/ab8500_charger.c         | 10 ++----
>  drivers/power/supply/ab8500_fg.c              | 10 ++----
>  drivers/power/supply/abx500_chargalg.c        | 10 ++----
>  drivers/power/supply/pm2301_charger.c         |  2 +-
>  8 files changed, 27 insertions(+), 79 deletions(-)
>  rename {include/linux/mfd/abx500 => drivers/power/supply}/ab8500-bm.h (96%)
> 
> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> index ba8da061af0e..82db43b2b6f1 100644
> --- a/drivers/mfd/ab8500-core.c
> +++ b/drivers/mfd/ab8500-core.c
> @@ -19,7 +19,6 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ab8500.h>
> -#include <linux/mfd/abx500/ab8500-bm.h>
>  #include <linux/mfd/dbx500-prcmu.h>
>  #include <linux/regulator/ab8500.h>
>  #include <linux/of.h>
> @@ -610,14 +609,14 @@ int ab8500_suspend(struct ab8500 *ab8500)
>  }
>  
>  static const struct mfd_cell ab8500_bm_devs[] = {
> -	MFD_CELL_OF("ab8500-charger", NULL, &ab8500_bm_data,
> -		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-charger"),
> -	MFD_CELL_OF("ab8500-btemp", NULL, &ab8500_bm_data,
> -		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-btemp"),
> -	MFD_CELL_OF("ab8500-fg", NULL, &ab8500_bm_data,
> -		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-fg"),
> -	MFD_CELL_OF("ab8500-chargalg", NULL, &ab8500_bm_data,
> -		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-chargalg"),
> +	MFD_CELL_OF("ab8500-charger", NULL, NULL, 0, 0,
> +		    "stericsson,ab8500-charger"),
> +	MFD_CELL_OF("ab8500-btemp", NULL, NULL, 0, 0,
> +		    "stericsson,ab8500-btemp"),
> +	MFD_CELL_OF("ab8500-fg", NULL, NULL, 0, 0,
> +		    "stericsson,ab8500-fg"),
> +	MFD_CELL_OF("ab8500-chargalg", NULL, NULL, 0, 0,
> +		    "stericsson,ab8500-chargalg"),
>  };

If you rework this, would you mind popping these on one line please?

Other than that:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
