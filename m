Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7199F11441E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 16:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLEPwu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 10:52:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38183 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLEPwu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 10:52:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id h20so3000445otn.5
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 07:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+uGQ97FSibUNCeL+TJXQI7iPeyr+WpS0SocEXOFxjc=;
        b=Xjk2Az6bG6jNUxabOAM4mMh+NuEEMGTQ/yepW8g0pRORuxC3Ud9zY0V67tmbe4TGwg
         BbYZH+5/2hVKQH780zghz6gmzCA5cUJy61K+TnthabuUM7lhMo8EL/X7z6ikdv+fXGvr
         uLFZNv3NieU5m2q70EVbuiTw6rKVZwm6ArVNQEHWadTy6BhmJrRUtZRX7aVdDucB06E7
         ymLsD3L+qEbBV5/8Ik3cOVb5mRdT6I8q2ufl3OAdIfSgbPsEzBmQR98xyoIJyTeNcbRd
         kHK+HC9ZiSPqKmAjm0iaDOexdrIZCCImtNa8wvgGOnvAgAFlTWRMXRDvpG65WkiENL3W
         OOEg==
X-Gm-Message-State: APjAAAVj16rBmkt6A1y1Xs1/bP+K+XtmqCaOmN82gtUjOVk97LUCE3mU
        bpcosO4U76LR1O5Ra7kvXEnTGaF1jYOXR4mNFNU=
X-Google-Smtp-Source: APXvYqxlmdcfMfzOhIkV0mtjsIeaYL8opyudKDQ9VyfkmXVBfxO3ti8srNtFkn1xsLJ68TRWb7WjIqYD6y/6bb8X7mk=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr6717577ote.118.1575561168756;
 Thu, 05 Dec 2019 07:52:48 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C8F16045625489E776F4F5460@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <4087016.QifdzW7851@kreacher> <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Dec 2019 16:52:37 +0100
Message-ID: <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peng Fan <peng.fan@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 5, 2019 at 2:18 PM Anson Huang <anson.huang@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Sent: Thursday, December 5, 2019 6:48 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>; Jacky Bai <ping.bai@nxp.com>;
> > linux-pm@vger.kernel.org
> > Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
> >
> > On Thursday, December 5, 2019 9:53:20 AM CET Anson Huang wrote:
> > > Hi, Rafael
> > >     This issue is very weird, the irq_work used in cpufreq_governor.c is
> > very
> > >     simple, ONLY one entry to claim the irq_work, and
> > cpufreq_governor's irq_work
> > >     is a private irq_work structure, no other drivers use it. I added some
> > trace
> > >     event in cpufreq_governor.c and irq_work.c, every time, the issue
> > happened at
> > >     the point of CPU1/2/3 all off, and CPU1 start ON line, but when CPU1
> > tried to
> > >     sync the irq_work in cpufreq_dbs_governor_stop(), the irq_work
> > shows that
> > >     previous work is pending on CPU3 which is offline, I also had the
> > trace event
> > >     in irq_work_claim(),  but no any log shows the cpufreq_governor
> > irq_work is
> > >     claimed on CPU3 after CPU3 offline, below is the debug patch I added
> > and the
> > >     log on 2 consoles:
> > >     If I understand it correctly, the irq work used in cpufreq_governor
> > ONLY has
> > >     one entry of calling irq_work_queue() which will be ONLY claimed on
> > the CPU
> > >     calling the irq_work_queue(), but from trace result, I have NOT see
> > where
> > >     CPU3 could call irq_work_queue() after it finishes the irq work sync
> > before
> > >     offline.
> >
> > Right.
> >
> > Which means that this particular irq_work only runs on the CPU that has run
> > irq_work_queue() for it.
> >
> > >     Could it something wrong related to cache maintain during CPU
> > hotplug?
> >
> > I'm not sure what is going on, but I do agree that it is weird enough. :-)
> >
> > [cut]
> >
> > > LOG on console 1 which does CPU1/2/3 offline and online stress test:
> > > CPUHotplug: 4575 times remaining
> > > [ 1047.401185] CPU1: shutdown
> > > [ 1047.403917] psci: CPU1 killed.
> > > [ 1047.449153] CPU2: shutdown
> > > [ 1047.451880] psci: CPU2 killed.
> > > [ 1047.501131] CPU3: shutdown
> > > [ 1047.503857] psci: CPU3 killed.
> > > [ 1048.541939] Detected VIPT I-cache on CPU1 [ 1048.541983] GICv3:
> > > CPU1: found redistributor 1 region 0:0x0000000051b20000 [ 1048.542050]
> > > CPU1: Booted secondary processor 0x0000000001 [0x410fd042] [
> > > 1048.585024] Detected VIPT I-cache on CPU2 [ 1048.585061] GICv3: CPU2:
> > > found redistributor 2 region 0:0x0000000051b40000 [ 1048.585121] CPU2:
> > > Booted secondary processor 0x0000000002 [0x410fd042] [ 1048.645070]
> > > Detected VIPT I-cache on CPU3 [ 1048.645112] GICv3: CPU3: found
> > > redistributor 3 region 0:0x0000000051b60000 [ 1048.645181] CPU3:
> > > Booted secondary processor 0x0000000003 [0x410fd042]
> > > CPUHotplug: 4574 times remaining
> > > [ 1049.769187] CPU1: shutdown
> > > [ 1049.771913] psci: CPU1 killed.
> > > [ 1049.809126] CPU2: shutdown
> > > [ 1049.811856] psci: CPU2 killed.
> > > [ 1049.853135] CPU3: shutdown
> > > [ 1049.855868] psci: CPU3 killed.
> > >
> > > Waiting here forever.....
> > >
> > > LOG on console 2 which enables the trace events I added upper:
> > >              sed-4591  [003] d..4  1049.705561: cpu_frequency_irq_claim:
> > cpu_id=3, flag=3
> > >              sed-4591  [003] dNh1  1049.705604:
> > > cpu_frequency_irq_run_list: cpu_id=3, flag=0
> >
> > So here CPU3 runs an IRQ work, presumably the cpufreq governor's one.
> >
> > After that its raised_list should be empty and it doesn't claim any IRQ works
> > going forward.
> >
> > >           <idle>-0     [001] d.s2  1049.716308: cpu_frequency_irq_work:
> > cpu_id=1, cpu=-1
> > >           <idle>-0     [001] d.s2  1049.716319: cpu_frequency_irq_claim:
> > cpu_id=1, flag=3
> > >           <idle>-0     [001] dNH2  1049.716338: cpu_frequency_irq_run_list:
> > cpu_id=1, flag=0
> >
> > And now CPU1 runs the cpufreq governor IRQ work, so it sets work->cpu to 1
> > and then to -1 (when flushing raised_list).
> >
> > >           <idle>-0     [002] d.s2  1049.728303: cpu_frequency_irq_work:
> > cpu_id=2, cpu=-1
> > >           <idle>-0     [002] d.s2  1049.728307: cpu_frequency_irq_claim:
> > cpu_id=2, flag=3
> > >           <idle>-0     [002] dNH2  1049.728320: cpu_frequency_irq_run_list:
> > cpu_id=2, flag=0
> > >           <idle>-0     [001] d.s2  1049.740305: cpu_frequency_irq_work:
> > cpu_id=1, cpu=-1
> > >           <idle>-0     [001] d.s2  1049.740307: cpu_frequency_irq_claim:
> > cpu_id=1, flag=3
> > >           <idle>-0     [001] dNH2  1049.740319: cpu_frequency_irq_run_list:
> > cpu_id=1, flag=0
> > >           <idle>-0     [001] d.s2  1049.752305: cpu_frequency_irq_work:
> > cpu_id=1, cpu=-1
> > >           <idle>-0     [001] d.s2  1049.752307: cpu_frequency_irq_claim:
> > cpu_id=1, flag=3
> > >           <idle>-0     [001] dNH2  1049.752316: cpu_frequency_irq_run_list:
> > cpu_id=1, flag=0
> > >          cpuhp/1-13    [001] ....  1049.768340: cpu_frequency_irq_work_sync:
> > cpu_id=1, cpu=-1, flag=0
> > >          cpuhp/1-13    [001] d..4  1049.768681: cpu_frequency_irq_work:
> > cpu_id=1, cpu=-1
> > >          cpuhp/1-13    [001] d..4  1049.768683: cpu_frequency_irq_claim:
> > cpu_id=1, flag=3
> > >          cpuhp/1-13    [001] dNh1  1049.768698: cpu_frequency_irq_run_list:
> > cpu_id=1, flag=0
> > >      smp_test.sh-734   [000] ...1  1049.771903: cpu_frequency_irq_claim:
> > cpu_id=0, flag=7
> > >      smp_test.sh-734   [000] dNh1  1049.775009: cpu_frequency_irq_run_list:
> > cpu_id=0, flag=4
> > >      smp_test.sh-734   [000] ...1  1049.776084: cpu_frequency_irq_claim:
> > cpu_id=0, flag=7
> > >      smp_test.sh-734   [000] dNh.  1049.776392: cpu_frequency_irq_run_list:
> > cpu_id=0, flag=4
> > >      smp_test.sh-734   [000] d..2  1049.779093: cpu_frequency_irq_work:
> > cpu_id=0, cpu=-1
> > >      smp_test.sh-734   [000] d..2  1049.779103: cpu_frequency_irq_claim:
> > cpu_id=0, flag=3
> > >           <idle>-0     [000] dNh2  1049.779162: cpu_frequency_irq_run_list:
> > cpu_id=0, flag=0
> > >           <idle>-0     [000] d.s2  1049.792305: cpu_frequency_irq_work:
> > cpu_id=0, cpu=-1
> > >           <idle>-0     [000] d.s2  1049.792315: cpu_frequency_irq_claim:
> > cpu_id=0, flag=3
> > >           <idle>-0     [000] dNH2  1049.792329: cpu_frequency_irq_run_list:
> > cpu_id=0, flag=0
> > >          cpuhp/2-18    [002] ....  1049.808315: cpu_frequency_irq_work_sync:
> > cpu_id=2, cpu=-1, flag=0
> > >          cpuhp/2-18    [002] d..4  1049.808642: cpu_frequency_irq_work:
> > cpu_id=2, cpu=-1
> > >          cpuhp/2-18    [002] d..4  1049.808645: cpu_frequency_irq_claim:
> > cpu_id=2, flag=3
> > >          cpuhp/2-18    [002] dNh1  1049.808658: cpu_frequency_irq_run_list:
> > cpu_id=2, flag=0
> > >      smp_test.sh-734   [000] ...1  1049.811848: cpu_frequency_irq_claim:
> > cpu_id=0, flag=7
> > >      smp_test.sh-734   [000] dNh1  1049.814949: cpu_frequency_irq_run_list:
> > cpu_id=0, flag=4
> > >      smp_test.sh-734   [000] ...1  1049.815988: cpu_frequency_irq_claim:
> > cpu_id=0, flag=7
> > >      smp_test.sh-734   [000] dNh1  1049.816321: cpu_frequency_irq_run_list:
> > cpu_id=0, flag=4
> > >      smp_test.sh-734   [000] d..3  1049.818936: cpu_frequency_irq_work:
> > cpu_id=0, cpu=-1
> > >      smp_test.sh-734   [000] d..3  1049.818946: cpu_frequency_irq_claim:
> > cpu_id=0, flag=3
> > >      smp_test.sh-734   [000] dNh2  1049.818973: cpu_frequency_irq_run_list:
> > cpu_id=0, flag=0
> > >           <idle>-0     [000] d.s4  1049.832308: cpu_frequency_irq_work:
> > cpu_id=0, cpu=-1
> > >           <idle>-0     [000] d.s4  1049.832317: cpu_frequency_irq_claim:
> > cpu_id=0, flag=3
> > >           <idle>-0     [000] dNH3  1049.832332: cpu_frequency_irq_run_list:
> > cpu_id=0, flag=0
> > >          cpuhp/3-23    [003] ....  1049.852314: cpu_frequency_irq_work_sync:
> > cpu_id=3, cpu=-1, flag=0
> > >
> > > [Anson] when CPU3 offline, the irq work sync is successfully, no irq
> > > work pending any more;
> > >
> > >      smp_test.sh-734   [000] ...1  1049.855859: cpu_frequency_irq_claim:
> > cpu_id=0, flag=7
> > >      smp_test.sh-734   [000] dNh1  1049.858958: cpu_frequency_irq_run_list:
> > cpu_id=0, flag=4
> > >      smp_test.sh-734   [000] ...1  1049.859990: cpu_frequency_irq_claim:
> > cpu_id=0, flag=7
> > >      smp_test.sh-734   [000] dNh.  1049.860346: cpu_frequency_irq_run_list:
> > cpu_id=0, flag=4
> > >           <idle>-0     [001] d.h1  1050.896329: cpu_frequency_irq_run_list:
> > cpu_id=1, flag=4
> > >          cpuhp/1-13    [001] ....  1050.916319: cpu_frequency_irq_work_sync:
> > cpu_id=1, cpu=3, flag=3
> > >
> > > [Anson] we can see when CPU1 start online and tried to sync irq work,
> > > found it is pending on CPU3 which is offline, and in this period, no
> > > irq work claimed by cpufreq_governor,
> >
> > So I'm wondering how it is possible at all that work->cpu value is 3 at this
> > point.
> >
> > The last CPU that wrote to work->cpu was CPU0 and the written value was -1,
> > and
> > CPU3 saw that value when it was running irq_work_sync().
> >
> > There is no sane way by which work->cpu can be equal to 3 from CPU1's
> > perspective, because the last value written to it by CPU1 itself was -1 and the
> > last value written to it by any other CPU also was -1.
> >
> > Moreover, after CPU3 had updated it last time (and the last value written to
> > it by CPU3 had been -1), other CPUs, *including* CPU1, updated it too (and
> > that for multiple times).
> >
> > So the only theory that can explain why CPU1 sees 3 in there when it is going
> > online appears to be some silent memory corruption.
> >
> > That said, have you tried to make the READ_ONCE() change suggested a
> > while ago?
>
> Below patch does NOT work using READ_ONCE() if I did the change correctly:

OK

> @@ -212,7 +208,7 @@ void irq_work_sync(struct irq_work *work)
>  {
>         lockdep_assert_irqs_enabled();
>
> -       while (work->flags & IRQ_WORK_BUSY)
> +       while (READ_ONCE(work->flags) & IRQ_WORK_BUSY)

You also may try using test_bit() instead of the raw read, but anyway
at this point I would start talking to the arch/HW people if I were
you.

>                 cpu_relax();
>  }
>
> LOG:
> CPUHotplug: 4937 times remaining
> [  214.837047] CPU1: shutdown
> [  214.839781] psci: CPU1 killed.
> [  214.877041] CPU2: shutdown
> [  214.879767] psci: CPU2 killed.
> [  214.917026] CPU3: shutdown
> [  214.919758] psci: CPU3 killed.
> [  215.957816] Detected VIPT I-cache on CPU1
> [  215.957860] GICv3: CPU1: found redistributor 1 region 0:0x0000000051b20000
> [  215.957930] CPU1: Booted secondary processor 0x0000000001 [0x410fd042]
> [  216.001025] Detected VIPT I-cache on CPU2
> [  216.001064] GICv3: CPU2: found redistributor 2 region 0:0x0000000051b40000
> [  216.001126] CPU2: Booted secondary processor 0x0000000002 [0x410fd042]
> [  216.068960] Detected VIPT I-cache on CPU3
> [  216.069004] GICv3: CPU3: found redistributor 3 region 0:0x0000000051b60000
> [  216.069076] CPU3: Booted secondary processor 0x0000000003 [0x410fd042]
> CPUHotplug: 4936 times remaining
> [  217.201055] CPU1: shutdown
> [  217.203779] psci: CPU1 killed.
> [  400.506869] audit: type=1006 audit(1573738201.312:3): pid=1332 uid=0 old-aui1
> [ 4000.600430] audit: type=1006 audit(1573741801.408:4): pid=1352 uid=0 old-aui1
> [ 7600.687496] audit: type=1006 audit(1573745401.492:5): pid=1371 uid=0 old-aui1
>
>
>          cpuhp/1-13    [001] ....   217.200231: cpu_frequency_irq_work_sync: cpu_id=1, cpu=-1, flag=0
>      smp_test.sh-741   [002] ...1   217.203770: cpu_frequency_irq_claim: cpu_id=2, flag=7
>      smp_test.sh-741   [002] d.h1   217.206873: cpu_frequency_irq_run_list: cpu_id=2, flag=4
>      smp_test.sh-741   [002] ...1   217.206893: cpu_frequency_irq_claim: cpu_id=2, flag=7
>      smp_test.sh-741   [002] dNh.   217.208222: cpu_frequency_irq_run_list: cpu_id=2, flag=4
>          cpuhp/2-18    [002] ....   217.248206: cpu_frequency_irq_work_sync: cpu_id=2, cpu=1, flag=3
>
> [Anson] this time, the irq work is pending on CPU1 which is offline.
>
>          kauditd-31    [000] ...1   400.519304: cpu_frequency_irq_claim: cpu_id=0, flag=7
>           <idle>-0     [000] dNh1   400.520231: cpu_frequency_irq_run_list: cpu_id=0, flag=4
>          kauditd-31    [003] ...1  4000.612845: cpu_frequency_irq_claim: cpu_id=3, flag=7
>            crond-1352  [003] d.h.  4000.616221: cpu_frequency_irq_run_list: cpu_id=3, flag=4
>          kauditd-31    [000] ...1  7600.699988: cpu_frequency_irq_claim: cpu_id=0, flag=7
>           <idle>-0     [000] dNh1  7600.700205: cpu_frequency_irq_run_list: cpu_id=0, flag=4
> root@imx8qxpmek:~#
>
>
