Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0327F142801
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 11:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgATKQZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 05:16:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44347 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgATKQY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 05:16:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so28126436otj.11;
        Mon, 20 Jan 2020 02:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5bfxqdMUxSLxjM/r63YRuvggOpa5byidD0DwyaZom4=;
        b=BJw11PzLeRkKzO/CHRO8sze+GG7+j9Be0HQtfPyl0qgvAv5+vvfXHqPx7TrjzRHFbI
         Q80LNt1tJOi2MQy+bEeyq0yEk4QqQUPrFme401ywrTggdsThTOYJEAEM1kpUAjTVodVA
         tHq5xi9rgwEJ6QGWdbatxaVuJrOcmDRuSqNf76taYooDeNTKifesV09mcyJIz0J8VeYp
         djlaj16F05ki93VU56VeuJW55KLDtC9+r7X18yc4n+YxmNPWHZ9YjUssnKTWTwwBzi63
         pmeABfAD/aYVTTF6pyq63bh6zFs4PaPM5QL+Y+aUdO3qKX01pIOzqzu+d3XZ8x8dHfTk
         0APw==
X-Gm-Message-State: APjAAAUyEAkm7iVUV8hL1e8eE9qAH9iOTjWKThntY3qEC/AUxXVj7RWN
        5pWmf4umuhJrkOoWliUNn1MNftRAAF72fpUbXfI=
X-Google-Smtp-Source: APXvYqxrwVFJWvVYhz0+b+fpElzaDaCSySYGJ7rKzf41+oOEN1Oq5O54xFDy9zfFdwaqOiO/kBtXrBYBLdJPrZgt+wY=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr14630787otr.167.1579515383764;
 Mon, 20 Jan 2020 02:16:23 -0800 (PST)
MIME-Version: 1.0
References: <201911151357.A9MjGImg%lkp@intel.com> <CAMuHMdX6-jb1W8uC2_237m8ctCpsnGp=JCxqt8pCWVqNXHmkVg@mail.gmail.com>
In-Reply-To: <CAMuHMdX6-jb1W8uC2_237m8ctCpsnGp=JCxqt8pCWVqNXHmkVg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Jan 2020 11:16:12 +0100
Message-ID: <CAJZ5v0i4nezntZJRSpv-LOwE_ZkE5Vr+YHkwJ8tX5GgG64gB=Q@mail.gmail.com>
Subject: Re: drivers/acpi/processor_thermal.c:66:1: warning: the frame size of
 2160 bytes is larger than 2048 bytes
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 17, 2020 at 4:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rafael, Viresh,
>
> On Fri, Nov 15, 2019 at 6:23 AM kbuild test robot <lkp@intel.com> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   96b95eff4a591dbac582c2590d067e356a18aacb
> > commit: 3000ce3c52f8b8db093e4dc649cd172390f71137 cpufreq: Use per-policy frequency QoS
> > date:   4 weeks ago
> > config: ia64-randconfig-a001-20191115 (attached as .config)
> > compiler: ia64-linux-gcc (GCC) 7.4.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 3000ce3c52f8b8db093e4dc649cd172390f71137
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.4.0 make.cross ARCH=ia64
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
>
> Seeing similar warnings on arm64, so this triggered my attention.
>
> > --
> >    drivers/cpufreq/cpufreq.c: In function 'refresh_frequency_limits.part.33':
> > >> drivers/cpufreq/cpufreq.c:1116:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>
> |       struct cpufreq_policy new_policy;
>
> That's a large struct on the stack...
>
> |       if (!policy_is_inactive(policy)) {
> |               new_policy = *policy;
>
> Let's make a copy?
> How well does this work, given struct cpufreq_policy contains a
> work_struct, list_head, kobject, completion, semaphore, spinlock_t,
> wait_queue_head_t, and two notifier_blocks, which are all objects you
> cannot just copy and reuse?
>
> |               pr_debug("updating policy for CPU %u\n", policy->cpu);
> |
> |               cpufreq_set_policy(policy, &new_policy);
>
> If cpufreq_set_policy() uses only a few fields from new_policy,

That's really the case.

> it might be a good idea to extract those into its own structure.

Or organize the code differently.

This is old code that hasn't been change, but I'll look at it since it
is problematic.

Thanks!
