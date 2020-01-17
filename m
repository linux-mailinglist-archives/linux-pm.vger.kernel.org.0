Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E16D3140E4E
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 16:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAQPvo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 10:51:44 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34065 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgAQPvn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 10:51:43 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so22918939otf.1;
        Fri, 17 Jan 2020 07:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjP6xd/aM21czdMmKXew0tRFkJqCnJh+EdhOGgIIkYQ=;
        b=TZ/Z8+xIBFxBYUwheSwTOd+aFI4+hhQBFcTY8uhmAXj6pcnB7jVI+1K1FmnWripISO
         hJb6fCS3002rknaRIIeIEJE6czW97YjdeLaEfn4ziuyZUa5FX9wtikWZVshZONGbgqAW
         h2SvSaOuQMox+UN2FfmTYxI2FdXJy2Djhl7RBBgBJpp3yTFS5hI8c1QxIljpXMY9XpfK
         K2Lq7A1ygFjb+KgLxZX5xMkHMY2hcJ7WBURe1VAcX1F9sNtQAqNl6q3JyzouijSRpiCR
         pqjZq3bXPYFFjyo9gMbatSD7pHYvCRxKFAqFs2aBzGOFWhCO0K9y+nMT61zbK2vdqE1n
         FgBw==
X-Gm-Message-State: APjAAAU6WGaVqBKQH9C8BAIz450CyIchp3B169KpAGE2Yeo47kLLey2B
        ru6JLWs1m+XxSj6jFZTwIxiomefV3Tj6z62SaKo=
X-Google-Smtp-Source: APXvYqwHuswdiRCNHZRorbXFlUZ+ijMnK5tym/0cTkPp/nD8koF+iUggcxNHD3IMG21KEMdZbznVckqhBMp3JY8rbss=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr6699833otm.297.1579276302707;
 Fri, 17 Jan 2020 07:51:42 -0800 (PST)
MIME-Version: 1.0
References: <201911151357.A9MjGImg%lkp@intel.com>
In-Reply-To: <201911151357.A9MjGImg%lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Jan 2020 16:51:21 +0100
Message-ID: <CAMuHMdX6-jb1W8uC2_237m8ctCpsnGp=JCxqt8pCWVqNXHmkVg@mail.gmail.com>
Subject: Re: drivers/acpi/processor_thermal.c:66:1: warning: the frame size of
 2160 bytes is larger than 2048 bytes
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael, Viresh,

On Fri, Nov 15, 2019 at 6:23 AM kbuild test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   96b95eff4a591dbac582c2590d067e356a18aacb
> commit: 3000ce3c52f8b8db093e4dc649cd172390f71137 cpufreq: Use per-policy frequency QoS
> date:   4 weeks ago
> config: ia64-randconfig-a001-20191115 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 3000ce3c52f8b8db093e4dc649cd172390f71137
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=ia64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

Seeing similar warnings on arm64, so this triggered my attention.

> --
>    drivers/cpufreq/cpufreq.c: In function 'refresh_frequency_limits.part.33':
> >> drivers/cpufreq/cpufreq.c:1116:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]

|       struct cpufreq_policy new_policy;

That's a large struct on the stack...

|       if (!policy_is_inactive(policy)) {
|               new_policy = *policy;

Let's make a copy?
How well does this work, given struct cpufreq_policy contains a
work_struct, list_head, kobject, completion, semaphore, spinlock_t,
wait_queue_head_t, and two notifier_blocks, which are all objects you
cannot just copy and reuse?

|               pr_debug("updating policy for CPU %u\n", policy->cpu);
|
|               cpufreq_set_policy(policy, &new_policy);

If cpufreq_set_policy() uses only a few fields from new_policy, it might
be a good idea to extract those into its own structure.

>     }
>     ^
>    drivers/cpufreq/cpufreq.c: In function 'store_scaling_governor':
>    drivers/cpufreq/cpufreq.c:789:1: warning: the frame size of 2176 bytes is larger than 2048 bytes [-Wframe-larger-than=]

|       struct cpufreq_policy new_policy;
|
|       memcpy(&new_policy, policy, sizeof(*policy));

Likewise.

>     }
>     ^
>    drivers/cpufreq/cpufreq.c: In function 'cpufreq_init_policy':
>    drivers/cpufreq/cpufreq.c:1081:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]

|       struct cpufreq_policy new_policy;
|
|       memcpy(&new_policy, policy, sizeof(*policy));

One more.

>     }
>     ^

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
