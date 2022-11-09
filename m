Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D02622D11
	for <lists+linux-pm@lfdr.de>; Wed,  9 Nov 2022 15:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKIOAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Nov 2022 09:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKIOA1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2022 09:00:27 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F4634E
        for <linux-pm@vger.kernel.org>; Wed,  9 Nov 2022 06:00:26 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id e15so10371194qts.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Nov 2022 06:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ug/ZUSfpqeBzCp/+2AJ33WlcK1pNZvoFgV1Z6DdI3U=;
        b=sxQJeXa9UKtvZxQpSjH6HWA5dVhEz+Nz0ZVosfm8Tg7F2PgxlBxP4cdfPbq07yRXXS
         Z4ZvlFX+r2G05HQxrqOzmlQO/WUQQLGX8+OY3MyNucrRHhGCsIrlQWa1ZI8ieSfeUfX7
         rilwgQ/DFCWRAUBz4oam0aN7DSAIy3vAQJmFpt7kOX9oVt7utiWZUMdG1nzw5vdjEGEi
         PL+AbfXDY8+GoT08c5QJ5xmu+zxpZr4E0DcVQmLm7+MoAifmKxPS+d0V+h7QTbgpI/P6
         8mLCSvjbMCEpDbGjSgTtQFInFobRv8MtiNDR5LMG12ICkkECmTvZNdA3enZKKZ2u0kTx
         T1ig==
X-Gm-Message-State: ACrzQf15jD7fit4GQBX42/5OQNqOXRHN4+JB+gFsIJMc1gC1/A+xi1ms
        TMu8D7rczBepqguD6TOomy6BQjuG9Z9oPZu2uT0=
X-Google-Smtp-Source: AMsMyM6tpZAc8azDTTlxXFm+d2l+hgAOGeZNboC5qVpx3kNAZrkb4C2d4hYgvPc6kEBNC5KAwfr8AdW5FDom1P1CfB4=
X-Received: by 2002:ac8:7d15:0:b0:3a5:449:87c3 with SMTP id
 g21-20020ac87d15000000b003a5044987c3mr47592903qtb.357.1668002423504; Wed, 09
 Nov 2022 06:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20221108081220.7070-1-rui.zhang@intel.com>
In-Reply-To: <20221108081220.7070-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 15:00:12 +0100
Message-ID: <CAJZ5v0iyMLX-D5OG7VYTD-PYpLbpA4+x2itPVUvGf+sF1DU-Uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/intel/intel_tcc_cooling: Detect TCC lock bit
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
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

On Tue, Nov 8, 2022 at 9:10 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> When MSR_IA32_TEMPERATURE_TARGET is locked, TCC Offset can not be
> updated even if the PROGRAMMABE Bit is set.
>
> Yield the driver on platforms with MSR_IA32_TEMPERATURE_TARGET locked.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> Note that this patch is made based on this patch series
> https://patchwork.kernel.org/project/linux-pm/list/?series=693050
> ---
>  drivers/thermal/intel/intel_tcc_cooling.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
> index ccd62358d4d0..f17fa5c81034 100644
> --- a/drivers/thermal/intel/intel_tcc_cooling.c
> +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> @@ -13,6 +13,7 @@
>  #include <asm/cpu_device_id.h>
>
>  #define TCC_PROGRAMMABLE       BIT(30)
> +#define TCC_LOCKED             BIT(31)
>
>  static struct thermal_cooling_device *tcc_cdev;
>
> @@ -80,6 +81,15 @@ static int __init tcc_cooling_init(void)
>         if (!(val & TCC_PROGRAMMABLE))
>                 return -ENODEV;
>
> +       err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
> +       if (err)
> +               return err;
> +
> +       if (val & TCC_LOCKED) {
> +               pr_info("TCC Offset locked\n");
> +               return -ENODEV;
> +       }
> +
>         pr_info("Programmable TCC Offset detected\n");
>
>         tcc_cdev =
> --

Applied as 6.2 material along with the [2/2], thanks!
