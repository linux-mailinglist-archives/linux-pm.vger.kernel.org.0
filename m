Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8678219A8CC
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 11:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbgDAJoE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 05:44:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46153 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbgDAJoD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 05:44:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id q204so21580958oia.13;
        Wed, 01 Apr 2020 02:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tc/XOc5/LK1Q2z5fURAPBVNdJRpf3W6JCMUDG26GjAA=;
        b=ppLeAwfEvUJnGL9KZATgfL72F6SWFf6GmzF2TwLZ1/r05alfHZ8ArydD2z8ryt1VKy
         PMmxoeHjVekvT+U5bBiG6mVxfWiaPL2O4wQ5J3J55e3U8YEE1bY6nyisx7PcQW9K1chs
         1RhSGVwJ7C0O1Bp5c9LgYAJ6Ft06x3CpBnKnN9k/SksL2etKhXQkdpTxvojZT6DkZgtn
         dJo6y+oHWxY1/P8crUXyR+tbhBIQMs0Hf+366aaWaamB+GXs6Pm0+A0AK1PmVk2fdwC1
         f3az4ajEWHbrT0oGTax/6VM3htyNFVP913+TbobQdH2o++7HRRy0cpH/itvjLHUs2rna
         NXpw==
X-Gm-Message-State: AGi0PuZGyYdO8ItbzDAtrqbFX5Z07GJdalhc3/nA1iRd2rxL92a/rgXt
        bnOEss7hSShztx/KAwt8PwBdfy7AYo+W0/Yw3LE=
X-Google-Smtp-Source: APiQypIx6BXDtcLC1NIBjcSQ0pUhumEFfmetRvP19HCeojek7ZuEzadWynK1exhfGc0EyDZD28JGUbNTXHpM7N81smI=
X-Received: by 2002:aca:2209:: with SMTP id b9mr2183308oic.103.1585734243209;
 Wed, 01 Apr 2020 02:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200329144640.20536-1-yu.c.chen@intel.com>
In-Reply-To: <20200329144640.20536-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Apr 2020 11:43:51 +0200
Message-ID: <CAJZ5v0gV2Tn_CQoJiuR92gjJ8-xjzLPY8esAkxgy=W8YkvUNyg@mail.gmail.com>
Subject: Re: [PATCH][v2] PM / sleep: Add pm_debug_messages boot command control
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 29, 2020 at 4:48 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Debug messages from the system suspend/hibernation infrastructure
> is disabled by default, and can only be enabled after the system
> has boot up via /sys/power/pm_debug_messages. This makes the hibernation
> resume hard to track as it involves system boot up across hibernation.
> There's no chance for software_resume() to track the resume process,
> eg.
>
> Turning on the pm_debug_messages during boot up by appending
> 'pm_debug_message'.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: According to Randy's suggestion, add the command line
>     option to Documentation/admin-guide/kernel-parameters.txt
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  kernel/power/main.c                             | 7 +++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c07815d230bc..105ec73743d7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3698,6 +3698,9 @@
>                         Override pmtimer IOPort with a hex value.
>                         e.g. pmtmr=0x508
>
> +       pm_debug_message        [SUSPEND,KNL]
> +                       Enable suspend/resume debug messages during boot up.
> +
>         pnp.debug=1     [PNP]
>                         Enable PNP debug messages (depends on the
>                         CONFIG_PNP_DEBUG_MESSAGES option).  Change at run-time
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 69b7a8aeca3b..1da3d7c15e03 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -535,6 +535,13 @@ static ssize_t pm_debug_messages_store(struct kobject *kobj,
>
>  power_attr(pm_debug_messages);
>
> +static int __init pm_debug_message_setup(char *str)
> +{
> +       pm_debug_messages_on = true;
> +       return 1;
> +}
> +__setup("pm_debug_message", pm_debug_message_setup);

I'd call this "pm_debug_messages" (just like the sysfs knob) and
rename the rest accordingly.

> +
>  /**
>   * __pm_pr_dbg - Print a suspend debug message to the kernel log.
>   * @defer: Whether or not to use printk_deferred() to print the message.
> --
