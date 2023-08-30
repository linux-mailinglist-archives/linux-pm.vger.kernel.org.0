Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B44978DA4D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjH3SgB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 30 Aug 2023 14:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243706AbjH3LeO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 07:34:14 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663EA132;
        Wed, 30 Aug 2023 04:34:11 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6bf106fb6a0so935305a34.0;
        Wed, 30 Aug 2023 04:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693395250; x=1694000050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZk50f5qfIYptXHl3M1EoNb26pcF10CEZl+wjqQVJ9k=;
        b=Co6987Ochgz0//q44pt7YNMLeQ5EBKmkWdNdJDoVHSaz+sTv3RscSlt/0UABX+ICOb
         a13WiTC1ZLrrrN/z3BSHPKpJzIgQp8TKNxOUr3n6eqczLyWp71eTgHgpanW0povfmh3z
         kPXaIRYxDDlgXIMZjgacnxVN+DpeTw0Jqu9JC7rPdFoe15sNfs9iWVbmJSKbnkRP8mx3
         Dap01zCU5AmCZDe+6xZwEC8LOEZ283a5O0khwRR6tNfKtMOPa6BHIUW1NikHo1qqmTYk
         Zjhrh+cm/5FBK+VEyu0Q5dB2SKCWd8tV6R7IJBmwEYAdhUd45e6El+Ije3J0KfVUi/hX
         kxyg==
X-Gm-Message-State: AOJu0Yyw+nzoXlATPljdYn4mtds1AFy99Lt/X984l/VJnpdSvUsBm8HR
        yZo2fHfbjXNDCzn0l9JnFQ44lKLS1GYIXcGfQjM=
X-Google-Smtp-Source: AGHT+IGeILT7TBoTXfEA1mKCiifAMVcywqeXlWLTMws3d5mrqGTEIxvClcbeBFHT0ktRYWMPqT9jwY+v2obL7A1LubA=
X-Received: by 2002:a4a:de8f:0:b0:573:55af:777c with SMTP id
 v15-20020a4ade8f000000b0057355af777cmr1975827oou.0.1693395250501; Wed, 30 Aug
 2023 04:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230829194200.1901988-1-festevam@gmail.com> <20230829194200.1901988-2-festevam@gmail.com>
In-Reply-To: <20230829194200.1901988-2-festevam@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Aug 2023 13:33:59 +0200
Message-ID: <CAJZ5v0hb-26qYZus97oJDOSga_1mE31ppk+ibK1JX42ZA5-hXw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] reboot: Introduce hw_protection_reboot()
To:     Fabio Estevam <festevam@gmail.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 29, 2023 at 9:42 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Introduce hw_protection_reboot() to trigger an emergency reboot.
>
> It is a counterpart of hw_protection_shutdown() with the difference
> that it will force a reboot instead of shutdown.
>
> The motivation for doing this is to allow the thermal subystem
> to trigger a reboot when the temperature reaches the critical
> temperature.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v4:
> - None
>
>  include/linux/reboot.h |  1 +
>  kernel/reboot.c        | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index 2b6bb593be5b..4a319bc24f6a 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -174,6 +174,7 @@ void ctrl_alt_del(void);
>
>  extern void orderly_poweroff(bool force);
>  extern void orderly_reboot(void);
> +void hw_protection_reboot(const char *reason, int ms_until_forced);
>  void hw_protection_shutdown(const char *reason, int ms_until_forced);
>
>  /*
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 3bba88c7ffc6..05333ae8bc6b 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -952,6 +952,40 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
>                               msecs_to_jiffies(poweroff_delay_ms));
>  }
>
> +/**
> + * hw_protection_reboot - Trigger an emergency system reboot
> + *
> + * @reason:            Reason of emergency reboot to be printed.
> + * @ms_until_forced:   Time to wait for orderly reboot before tiggering a
> + *                     forced reboot. Negative value disables the forced
> + *                     reboot.
> + *
> + * Initiate an emergency system reboot in order to protect hardware from
> + * further damage. Usage examples include a thermal protection.
> + *
> + * NOTE: The request is ignored if protection reboot is already pending even
> + * if the previous request has given a large timeout for forced reboot.
> + * Can be called from any context.
> + */
> +void hw_protection_reboot(const char *reason, int ms_until_forced)

Some code and kerneldoc comment duplication could be avoided by
changing hw_protection_shutdown() definition to take an additional
argument specifying the final action to carry out, so there would be

void __hw_protection_shutdown(const char *reason, int ms_until_forced,
bool reboot)
{
...
   if (reboot)
       orderly_reboot();
   else
      orderly_poweroff(true);
}

and both hw_protection_shutdown() and hw_protection_reboot() can be
defined as static inline wrappers around this.

> +{
> +       static atomic_t allow_proceed = ATOMIC_INIT(1);
> +
> +       pr_emerg("HARDWARE PROTECTION reboot (%s)\n", reason);
> +
> +       /* Reboot should be initiated only once. */
> +       if (!atomic_dec_and_test(&allow_proceed))
> +               return;
> +
> +       /*
> +        * Queue a backup emergency reboot in the event of
> +        * orderly_reboot failure
> +        */
> +       hw_failure_emergency_poweroff(ms_until_forced);
> +       orderly_reboot();
> +}
> +EXPORT_SYMBOL_GPL(hw_protection_reboot);
> +
>  /**
>   * hw_protection_shutdown - Trigger an emergency system poweroff
>   *
> --
> 2.34.1
>
