Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF3619C2C1
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 15:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbgDBNd6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 09:33:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43482 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbgDBNd5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 09:33:57 -0400
Received: by mail-oi1-f193.google.com with SMTP id k5so2730777oiw.10;
        Thu, 02 Apr 2020 06:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECW1sL5MI7yjOdWrTi6RkJft8XYzmpkaIoE7bQzsjaM=;
        b=RwPo6pLpJgNzlpYdXNOdKeH7P0zxM50gXVPMN9rphPYxblGPnjQV/n6VXiPM2DGE4/
         4wRVlqu3FAqijVNlpAPobVS2dqsWz3kEs1axA6fRb3CDjCMSQtznhLT/XFpIc5oSCPqd
         Bgt82DIBkDXjMp+SOl4igMGEvOeKvBjN1mLkryFVDSMaSWSoql+5lZ4eLkfQj6y4/l46
         gwMFQPTfKXO2MrCJdeqiDaOxh2XMrJfi0UCD0+LtFdxqX3OaAXY/2Y/5SHvCsLjI6Mff
         2wKsc8sZkB0Hi0EEl6SzhefnaPSGlyIT4vbSj4TSio4XKsJmLdbYDSk7TRLl4JE59nGw
         xb0A==
X-Gm-Message-State: AGi0Pubarc/af5BMfGUJSJn6lt8YZQVP01BYsbdPDcFrULj6xNPrBECI
        yWgf0XAx7VyeRdqBnN47CfxUQEdacb9nhBMuPl0=
X-Google-Smtp-Source: APiQypI2kY313Dq4uTKl7sebjrsM4yTadP8qeVcR6tRx3hDHNt1HwO5A2TJ0fvzY/Ly7nMDEQdosvXBfsEGRwDQHc2Y=
X-Received: by 2002:aca:2209:: with SMTP id b9mr2258758oic.103.1585834436843;
 Thu, 02 Apr 2020 06:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200402075652.13289-1-yu.c.chen@intel.com>
In-Reply-To: <20200402075652.13289-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Apr 2020 15:33:45 +0200
Message-ID: <CAJZ5v0j2W5MYJnb4hiDn0OgR1xJZwm4TxVm9o-iw+epXPTp82g@mail.gmail.com>
Subject: Re: [PATCH][v3] PM / sleep: Add pm_debug_messages boot command control
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 2, 2020 at 9:58 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Debug messages from the system suspend/hibernation infrastructure
> is disabled by default, and can only be enabled after the system
> has boot up via /sys/power/pm_debug_messages. This makes the hibernation
> resume hard to track as it involves system boot up across hibernation.
> There's no chance for software_resume() to track the resume process,
> eg.
>
> Turning on the pm_debug_messages during boot up by appending
> 'pm_debug_messages'.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: According to Randy's suggestion, add the command line
>     option to Documentation/admin-guide/kernel-parameters.txt
>
> v3: According to Rafael's suggestion, rename the boot command
>     to pm_debug_messages
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  kernel/power/main.c                             | 7 +++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ed73df5f1369..3fb9cbee8d28 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3720,6 +3720,9 @@
>                         Override pmtimer IOPort with a hex value.
>                         e.g. pmtmr=0x508
>
> +       pm_debug_messages       [SUSPEND,KNL]
> +                       Enable suspend/resume debug messages during boot up.
> +
>         pnp.debug=1     [PNP]
>                         Enable PNP debug messages (depends on the
>                         CONFIG_PNP_DEBUG_MESSAGES option).  Change at run-time
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 69b7a8aeca3b..40f86ec4ab30 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -535,6 +535,13 @@ static ssize_t pm_debug_messages_store(struct kobject *kobj,
>
>  power_attr(pm_debug_messages);
>
> +static int __init pm_debug_messages_setup(char *str)
> +{
> +       pm_debug_messages_on = true;
> +       return 1;
> +}
> +__setup("pm_debug_messages", pm_debug_messages_setup);
> +
>  /**
>   * __pm_pr_dbg - Print a suspend debug message to the kernel log.
>   * @defer: Whether or not to use printk_deferred() to print the message.
> --

Applied (as 5.7-rc material) with modified subject and changelog, thanks!
