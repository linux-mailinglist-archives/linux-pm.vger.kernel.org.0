Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2B1E097F
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 11:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbgEYJBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 05:01:20 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:44450 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgEYJBU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2020 05:01:20 -0400
Received: by mail-oo1-f66.google.com with SMTP id u40so503020ooi.11;
        Mon, 25 May 2020 02:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vWyA0zi2Dx/7wa6PSD2ADmwVek1tPCdMhKzL6eGG4k=;
        b=G/RYR+5/V62BiIHj2kXuC7wbWGVi9mHAn+pX2OUjiYnR6BJng7jqwU4lHh6GyCiqjx
         vypo81n+FIcHwIt+dEoCRcDVB33M15/1Bv2xGPKF4LEuO8KnfIIeLFWxkQ244kwX+FTj
         +O/t1/5I18qJx8vrIhLJpTeybsRbBQnu3LGCy0/JjOHaDs5PS7ibNZ6BH+Xdb+++H6hw
         8r/pgyO50+6ZqVtO0CklDj+JoFhxeoPccGgJIK6Lig8l6I1QZ9TlPafyIe40jYETMh+Q
         HAmGba/z0GBfkypjjR5+d4okdNsHE2tL37LHPLiLHrU4SToZc1YilL0xj4AP7n/oeLPx
         P5Fw==
X-Gm-Message-State: AOAM530Y3rv1AGhHxzcy1iY5vPTLhw+ma2+Lh5sGJlKPDlIlxOAFtoSD
        feN071WWN46dcqI2hOt3U4ul59xPR3KALNDdiWg=
X-Google-Smtp-Source: ABdhPJyzwX2iVrT6Qd3l9Fgc1FvAqYA6sYZDs1ME68NNegl3tYP9ebp9y13iR7l/9ojM1/K+7pi6N5fpXNoNobI++a0=
X-Received: by 2002:a4a:e759:: with SMTP id n25mr12329240oov.75.1590397279123;
 Mon, 25 May 2020 02:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <1590043466-11325-1-git-send-email-sumeet.r.pawnikar@intel.com>
In-Reply-To: <1590043466-11325-1-git-send-email-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 May 2020 11:01:02 +0200
Message-ID: <CAJZ5v0jWtBK7jR3q64+4_9zVowORVp5rO9CMUDNhYVWMo_Yriw@mail.gmail.com>
Subject: Re: [PATCH] powercap: remove unused local MSR define
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 21, 2020 at 8:38 AM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Remove unused PLATFORM_POWER_LIMIT MSR local definition from file
> intel_rapl_common.c. This was missed while splitting old RAPL code
> intel_rapl.c file into two new files intel_rapl_msr.c and
> intel_rapl_common.c as per the commit 3382388d7148
> ("intel_rapl: abstract RAPL common code"). Currently, this #define
> entry is being used only in intel_rapl_msr.c file and local definition
> present in this file.
>
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c |    3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index eb328655bc01..5527a7c76309 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -26,9 +26,6 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>
> -/* Local defines */
> -#define MSR_PLATFORM_POWER_LIMIT       0x0000065C
> -
>  /* bitmasks for RAPL MSRs, used by primitive access functions */
>  #define ENERGY_STATUS_MASK      0xffffffff
>
> --

Applied as 5.8 material, thanks!
