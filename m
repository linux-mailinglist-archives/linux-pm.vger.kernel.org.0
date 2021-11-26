Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A8845F6B1
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 22:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhKZWCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 17:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241797AbhKZWAB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 17:00:01 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEFBC061574
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 13:56:48 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r26so27257262lfn.8
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QWWtOidMzsjvAKxeAS7b8lTc05KdXZeQanVTUq2qbEo=;
        b=GcKt20lEaAogQDEQAun3vb0IjBQ/H18zsvVKCJZqsvuBjlberwkcwifN0FAXHA/FW9
         OU5IBLKi3cAIYY4KK8COo0liUi6zUZT9bQ1OzcQQil3rBIUqH2ZQAbOQXqdWOmAilEpH
         kHaOL5rA6bZi68A7rjeR8h4wqrMKVAT3kAak/RFxeVuFCuMaztinDbRJ4h3B2UZk9/oG
         WRMZ4nRta2hrIboaZLndKvO9IfokMLreyKCeFytQUyXC4jbG1t6jKTxRuGwlgD38ZkQz
         usGUgTBH7IV6Qc2gs39BNO0MM2wi0x6JTulxLdUQjuRkrZ7RFVAmgytZO9Rn9QDQAoiE
         7Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QWWtOidMzsjvAKxeAS7b8lTc05KdXZeQanVTUq2qbEo=;
        b=7N6hOuBHNPyl4zfbn2jdWIg9rdzGl5rYBS+QA87C4d+3MPLmhMqD5PzhZ5rre5Uete
         MHl9Hy5w74WlbleYI6TBp88PfLzYVmCuEGi4y4ntl9Nee766YJ2ViEI31ItY7mx4QWbA
         BbI0LoqZgm9zhKo7ZELl4nLRrnpeKlkKbdh8JjqKRGiNWAN6GYRkJFDshWUIrQVPHJQ/
         JdGu87dowUR6XUmlsmWwMstDP/VUdsgKthIFfe3Hzivyc9sfRQws0q5HgRZNC5PJWWfB
         u5jXEbL6Hfnq48cYl/hPatA1mj9jNSQz49LmEWL3wVDNBLBbazsqJtt+FDWl7i08vq3z
         yAmA==
X-Gm-Message-State: AOAM531ubFruQ1bxdqzJ74zUMOiLIfv/I4N6KhAMOmxtSp3C7+uSraoD
        wpzc9a5nvLXVQnGKlVKk46fkVvctBzvOIdA2IPgX1A==
X-Google-Smtp-Source: ABdhPJwtljwAmkD/NkmAfbPf/8CARqBuGrgIww0VlMYRN8503DRr8KdefbcChfI+9TFiMZaHNLBVnkFwJMtNsautp2g=
X-Received: by 2002:a05:6512:3a87:: with SMTP id q7mr31614406lfu.515.1637963806464;
 Fri, 26 Nov 2021 13:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-3-daniel.lezcano@linaro.org> <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
 <CAJZ5v0hcuq0qriHbc=XHbCo8fJMAV1dbCBws3M9GktN17aCE_g@mail.gmail.com> <acb3ac6c-d6e6-c3f7-6b04-12d3a1fbf0a1@linaro.org>
In-Reply-To: <acb3ac6c-d6e6-c3f7-6b04-12d3a1fbf0a1@linaro.org>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 26 Nov 2021 13:56:36 -0800
Message-ID: <CAAYoRsXftJbk0q7sjc8fvQJcWtjnsG-SrdhrvWHQbK2vw4TQLQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 26, 2021 at 9:43 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 26/11/2021 18:21, Rafael J. Wysocki wrote:
> > Hi Doug,
> >
> > On Fri, Nov 26, 2021 at 6:08 PM Doug Smythies <dsmythies@telus.net> wro=
te:
> >>
> >> Hi Daniel,
> >>
> >> This patch introduces a regression, at least on my test system.
> >> I can no longer change CPU frequency scaling drivers, for example
> >> from intel_cpufreq (A.K.A intel_pstate in passive mode) to intel_pstat=
e
> >> (A.K.A. active mode). The task just hangs forever.
> >>
> >> I bisected the kernel and got this commit as the result.
> >> As a double check, I reverted this commit:
> >> 7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c
> >> on kernel 5.16-rc2 and the issue was resolved.
> >>
> >> While your email is fairly old, I observe that it was only included as=
 of
> >> kernel 5.16-rc1.
> >>
> >> Command Example that never completes:
> >>
> >> $ echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status
> >>
> >> syslog excerpt attached.
> >
> > This looks like it may be problematic:
> >
> > diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> > index f6076de39540..98841524a782 100644
> > --- a/drivers/powercap/dtpm_cpu.c
> > +++ b/drivers/powercap/dtpm_cpu.c
> > @@ -204,7 +204,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
> >        return ret;
> > }
> >
> > -int dtpm_register_cpu(struct dtpm *parent)
> > +static int __init dtpm_cpu_init(void)
> > {
> >        int ret;
> >
> > so please try to remove the __init annotation from dtpm_cpu_init() and
> > see if that helps.
>
> Yes, actually that should be called only if it is configured properly.
> The dtpm_cpu just initializes itself unconditionally, I did not figured
> out there is the usually allyesconfig used by default by the distros.
>
> That should be fixed with a proper DT configuration [1]

I added your 5 patch set on top of 5.16-rc2 and confirm it fixes
the issue. I tested both ways, with CONFIG_OF not set, forcing the
CONFIG_DTPM stuff off, and with CONFIG_OF=3Dy.

Oh, I used V2 of the patch set from earlier today.

... Doug

>
> [1]
> https://lore.kernel.org/all/20211124125506.2971069-3-daniel.lezcano@linar=
o.org/
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
