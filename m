Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D048604A6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfGEKl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 06:41:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32929 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfGEKl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 06:41:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so4430884plo.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UJvr7EwOrXEFabP8+/Iu9pUax7qmvbIsgvs4a3zgZ8o=;
        b=v/aHFNTiGOQH568plo+1dy9bY6Pa+LBYo8oGMnc8bvfCMtEhstoSx+UNH9TjbLIrYU
         dyZAYANq1J17eADyWdOGLYCM4rWwxvSt006TR8Pr9OZZDTzzN/hrzfNWn6f6TWEBzV+b
         yMSXm0etTskIrvFSZx3ZNA6yPtrombgt+RUdy4zYPaWNF2G94E14najmtlKdbltc8mhx
         zHNe6K0ANp1KJnSK8eRyHgW/3MJ6ACy4k9mdUorY9U2gNW1lm7e31piSK1n+zmrfND4m
         TXKJTKnZv3glU9+ybp4Ni88mQQkcRR+9lCMj/axas7S/uCAuGmTQiTY8su7hNXUg9LpP
         gbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UJvr7EwOrXEFabP8+/Iu9pUax7qmvbIsgvs4a3zgZ8o=;
        b=iijrJ8sNVaYvTkm8YlFUqKVhL64PVM2PF8LdoWWJ1fgw0sGZwedNhk10cXDfoVCrGI
         l3KA/Lc/nr3whzAbY4wTL+3ec4gXN3SUwrzSjpp3AILMJYnS7AsJ3C+Gvvb+HWAq2B+r
         cvATnyH2+6EBU/MlqQDLHjl0xQ8nqAGZOIju9UrL7V97ZZouqXPJoLzP74mjs8JBYsOI
         rCBUvSo7o2U4/PMHJT66LyKMaoUwygAk2TYjQ1xjHWHaeAhbHC4s4c91Jgk2o5ZrNRKF
         hmPF3Qc2/Xvzy3Abs8PnX1Hp5ccfO/DlTLRBZ5ZlqleA/JMz5CdoZO1L5rbvVoMow5df
         VIcQ==
X-Gm-Message-State: APjAAAVCHlJmnS7xUEfkWnkZBdxjWwHTLoCbCiEOJU3iTN8AaSJEwJyz
        Pa+UHSuyaWtfv4yKgylqdpjbJA==
X-Google-Smtp-Source: APXvYqxuM8kh7vy+rh++wa/XTo/q9uThBhHGdFTRkTbc/lpvAAM9aqUg9r1UEi+y5/bo4UF2cKGm+A==
X-Received: by 2002:a17:902:8696:: with SMTP id g22mr4564945plo.249.1562323316141;
        Fri, 05 Jul 2019 03:41:56 -0700 (PDT)
Received: from localhost ([223.226.51.128])
        by smtp.gmail.com with ESMTPSA id q10sm7256923pgg.35.2019.07.05.03.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 03:41:55 -0700 (PDT)
Date:   Fri, 5 Jul 2019 16:11:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+de771ae9390dffed7266@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next boot error: WARNING in corrupted
Message-ID: <20190705104152.wniaje2u5d77iaoa@vireshk-i7>
References: <0000000000005bf6c3058cde49a7@google.com>
 <8755905.1UUJr7qOyo@kreacher>
 <CACT4Y+awzZOSAseosiUDvs_zk7hFRuQrrr0LjRmVwesVbF_+aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+awzZOSAseosiUDvs_zk7hFRuQrrr0LjRmVwesVbF_+aQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-07-19, 11:37, Dmitry Vyukov wrote:
> On Fri, Jul 5, 2019 at 11:23 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Thursday, July 4, 2019 7:27:04 PM CEST syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    16c474c9 Add linux-next specific files for 20190704
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17f8b463a00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=983f02aae1ef31b6
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=de771ae9390dffed7266
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+de771ae9390dffed7266@syzkaller.appspotmail.com
> > >
> ...
> > > ------------[ cut here ]------------
> > > __dev_pm_qos_remove_request() called for unknown object
> > > WARNING: CPU: 1 PID: 1 at drivers/base/power/qos.c:486
> > > __dev_pm_qos_remove_request+0x3d3/0x4d0 drivers/base/power/qos.c:486
> >
> > Viresh, any chance to look at this?
> >
> > I'm a bit concerned about the freq QoS series at this point, may defer pushing it.
> 
> FWIW here is full WARNING since I am hitting it locally too:
> 
> commit 16c474c9ba39ede5fd1cd835ac52b3760d7820b7 (HEAD, tag:
> next-20190704, next/master)
>     Add linux-next specific files for 20190704
> 
> ------------[ cut here ]------------
> __dev_pm_qos_remove_request() called for unknown object
> WARNING: CPU: 3 PID: 1 at drivers/base/power/qos.c:486
> __dev_pm_qos_remove_reques0
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc7-next-20190704 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>  panic+0x2dc/0x755 kernel/panic.c:219
>  __warn.cold+0x20/0x4c kernel/panic.c:576
>  report_bug+0x263/0x2b0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:179 [inline]
>  fixup_bug arch/x86/kernel/traps.c:174 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:1008
> RIP: 0010:__dev_pm_qos_remove_request+0x3d3/0x4d0 drivers/base/power/qos.c:486
> Code: 09 fd e9 9a fd ff ff 41 bd ed ff ff ff e9 b8 fd ff ff e8 d0 c9
> 7b fd 48 c7 2
> RSP: 0000:ffff88806c27fac8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff815cae36 RDI: ffffed100d84ff4b
> RBP: ffff88806c27faf8 R08: ffff88806c276000 R09: fffffbfff14a6b45
> R10: fffffbfff14a6b44 R11: ffffffff8a535a27 R12: ffff8880664cf0f8
> R13: ffff88806ae4c000 R14: 0000000000000004 R15: ffff88806ae4c008
>  dev_pm_qos_remove_request+0x24/0x40 drivers/base/power/qos.c:520
>  cpufreq_policy_free+0x2b7/0x3d0 drivers/cpufreq/cpufreq.c:1282
>  cpufreq_online+0x239/0x17a0 drivers/cpufreq/cpufreq.c:1482
>  cpufreq_add_dev+0x119/0x160 drivers/cpufreq/cpufreq.c:1500
>  subsys_interface_register+0x2fc/0x470 drivers/base/bus.c:1081
>  cpufreq_register_driver+0x331/0x570 drivers/cpufreq/cpufreq.c:2669
>  acpi_cpufreq_init+0x579/0x5ff drivers/cpufreq/acpi-cpufreq.c:966
>  do_one_initcall+0x120/0x81a init/main.c:939
>  do_initcall_level init/main.c:1007 [inline]
>  do_initcalls init/main.c:1015 [inline]
>  do_basic_setup init/main.c:1033 [inline]
>  kernel_init_freeable+0x4d4/0x5c3 init/main.c:1193
>  kernel_init+0x12/0x1c5 init/main.c:1111
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

This fixes it for me (after faking the failure). @Rafael this needs to
be merged to the top commit:

0d4c2a013b32 cpufreq: Add QoS requests for userspace constraints

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 13c2f119cc0c..5eecd54195a9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1228,12 +1228,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
                goto err_min_qos_notifier;
        }
 
-       policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
-                                      GFP_KERNEL);
-       if (!policy->min_freq_req)
-               goto err_max_qos_notifier;
-
-       policy->max_freq_req = policy->min_freq_req + 1;
        INIT_LIST_HEAD(&policy->policy_list);
        init_rwsem(&policy->rwsem);
        spin_lock_init(&policy->transition_lock);
@@ -1244,9 +1238,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
        policy->cpu = cpu;
        return policy;
 
-err_max_qos_notifier:
-       dev_pm_qos_remove_notifier(dev, &policy->nb_max,
-                                  DEV_PM_QOS_MAX_FREQUENCY);
 err_min_qos_notifier:
        dev_pm_qos_remove_notifier(dev, &policy->nb_min,
                                   DEV_PM_QOS_MIN_FREQUENCY);
@@ -1370,6 +1361,13 @@ static int cpufreq_online(unsigned int cpu)
                        add_cpu_dev_symlink(policy, j);
                }
 
+               policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
+                                              GFP_KERNEL);
+               if (!policy->min_freq_req)
+                       goto out_destroy_policy;
+
+               policy->max_freq_req = policy->min_freq_req + 1;
+
                ret = dev_pm_qos_add_request(dev, policy->min_freq_req,
                                             DEV_PM_QOS_MIN_FREQUENCY,
                                             policy->min);


-- 
viresh
