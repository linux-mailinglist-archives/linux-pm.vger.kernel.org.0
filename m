Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B4D756A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfJOLqn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 07:46:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41927 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbfJOLqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 07:46:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so12311831pfh.8
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 04:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7nxz6zGMrO8KEWQH3HeYGqaLsVZGUP/TEpFv7v6lvxs=;
        b=zvSGZhiOtHdGvy14s6GyHZuv88yUqPbQwJpWSzfbMYO5X9dWo5YYuHa6rNSQRvD+So
         gQqpIGP5TbYKTxYrAaCidrqfnNq0975PPFG+AhBp5OL22ab8iRsCR4gYyxixRlxbL69N
         ssAf4NW0g2tZmUBkUmujAHGpHMb6+WfP4J8z5bmZT8fe4Pit9+XMbFzXSqnf/4KpgFpT
         7gZ4fLKI89TDHttIkcS/qIKANqSXF4n+rTDvJkWKO34sz/OO5A1m86i8ZpfWJXfnANN0
         8TsSdz2p4rGez9OJseuDXbHApFTnFax32bcky64+HFr7AX4kTvxfPfzmDLYEuWed5e55
         BXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7nxz6zGMrO8KEWQH3HeYGqaLsVZGUP/TEpFv7v6lvxs=;
        b=hY3gs0TAJl5vGcXOK9f4UzaReBYQunpPiQ2bh/X37aesq1drMKnDn14PgF2E3u2VNi
         bJDdyPRPZVBHwNj/Czv8we7jNGrapYfJssEmMTy1GDvL8Og9W1QUG0wDuRjhSxSrcWdX
         ah2ppS+DYfC1ydKhDSutWEXw8zOuloN+6T2rzoE1/Su8ozryAsPPrguvudFYcG2/HpmU
         hNfi0MVCtatt4UumsCrAm6HQOUQijd4Y96suV3td5uQBh0lFLuhGL5y+P4TRMKoGO5qC
         hjKn+8ua5oKYg0d6Fnx/WePbi3qTOf+hDkJTjzzk6pnuDIYQ1vi/WtwpTvvRC1ZKjw0J
         uDQw==
X-Gm-Message-State: APjAAAXDvLLSZue3zxC4FZhjqV5XvUEzGRc9T55VK8M/rR3BCR3HSs4J
        p5urzAUCMIkfHo8hEhGxR+Nt5omVR7U=
X-Google-Smtp-Source: APXvYqx57AELHzxiNgpMzoxeCvv9cjy2XscqdyIxlwGe5Q3KNTjsdl/RhoTDUKUsXGBSzws2Bo9sCw==
X-Received: by 2002:a63:9255:: with SMTP id s21mr39408310pgn.325.1571140002251;
        Tue, 15 Oct 2019 04:46:42 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id q2sm24373495pfg.144.2019.10.15.04.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 04:46:40 -0700 (PDT)
Date:   Tue, 15 Oct 2019 17:16:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        ulf.hansson@linaro.org, sfr@canb.auug.org.au, pavel@ucw.cz,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V7 5/7] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20191015114637.pcdbs2ctxl4xoxdo@vireshk-i7>
References: <5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org>
 <2c7a751a58adb4ce6f345dab9714b924504009b6.1562583394.git.viresh.kumar@linaro.org>
 <a1c503a7-6136-a405-369c-596a680183f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c503a7-6136-a405-369c-596a680183f2@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-09-19, 23:12, Dmitry Osipenko wrote:
> Hello Viresh,
> 
> This patch causes use-after-free on a cpufreq driver module reload. Please take a look, thanks in advance.
> 
> 
> [   87.952369] ==================================================================
> [   87.953259] BUG: KASAN: use-after-free in notifier_chain_register+0x4f/0x9c
> [   87.954031] Read of size 4 at addr e6abbd0c by task modprobe/243
> 
> [   87.954901] CPU: 1 PID: 243 Comm: modprobe Tainted: G        W
> 5.3.0-next-20190920-00185-gf61698eab956-dirty #2408
> [   87.956077] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [   87.956807] [<c0110aad>] (unwind_backtrace) from [<c010bb71>] (show_stack+0x11/0x14)
> [   87.957709] [<c010bb71>] (show_stack) from [<c0d37b25>] (dump_stack+0x89/0x98)
> [   87.958616] [<c0d37b25>] (dump_stack) from [<c02937e1>]
> (print_address_description.constprop.0+0x3d/0x340)
> [   87.959785] [<c02937e1>] (print_address_description.constprop.0) from [<c0293c6b>]
> (__kasan_report+0xe3/0x12c)
> [   87.960907] [<c0293c6b>] (__kasan_report) from [<c014988f>] (notifier_chain_register+0x4f/0x9c)
> [   87.962001] [<c014988f>] (notifier_chain_register) from [<c01499b5>]
> (blocking_notifier_chain_register+0x29/0x3c)
> [   87.963180] [<c01499b5>] (blocking_notifier_chain_register) from [<c06f7ee9>]
> (dev_pm_qos_add_notifier+0x79/0xf8)
> [   87.964339] [<c06f7ee9>] (dev_pm_qos_add_notifier) from [<c092927d>] (cpufreq_online+0x5e1/0x8a4)
> [   87.965351] [<c092927d>] (cpufreq_online) from [<c09295c9>] (cpufreq_add_dev+0x79/0x80)
> [   87.966247] [<c09295c9>] (cpufreq_add_dev) from [<c06eb9d3>] (subsys_interface_register+0xc3/0x100)
> [   87.967297] [<c06eb9d3>] (subsys_interface_register) from [<c0926e53>]
> (cpufreq_register_driver+0x13b/0x1ec)
> [   87.968476] [<c0926e53>] (cpufreq_register_driver) from [<bf800435>]
> (tegra20_cpufreq_probe+0x165/0x1a8 [tegra20_cpufreq])

Hi Dmitry,

Thanks for the bug report and I was finally able to reproduce it at my end and
this was quite an interesting debugging exercise :)

When a cpufreq driver gets registered, we register with the subsys interface and
it calls cpufreq_add_dev() for each CPU, starting from CPU0. And so the QoS
notifiers get added to the first CPU of the policy, i.e. CPU0 in common cases.

When the cpufreq driver gets unregistered, we unregister with the subsys
interface and it calls cpufreq_remove_dev() for each CPU, starting from CPU0
(should have been in reverse order I feel). We remove the QoS notifier only when
cpufreq_remove_dev() gets called for the last CPU of the policy, lets call it
CPUx. Now this has a different notifier list as compared to CPU0.

In short, we are adding the cpufreq notifiers to CPU0 and removing them from
CPUx. When we try to add it again by inserting the module for second time, we
find a node in the notifier list which is already freed but still in the list as
we removed it from CPUx's list (which doesn't do anything as the node wasn't
there in the first place).

@Rafael: How do you see we solve this problem ? Here are the options I could
think of:

- Update subsys layer to reverse the order of devices while unregistering (this
  will fix the current problem, but we will still have corner cases hanging
  around, like if the CPU0 is hotplugged out, etc).

- Update QoS framework with the knowledge of related CPUs, this has been pending
  until now from my side. And this is the thing we really need to do. Eventually
  we shall have only a single notifier list for all CPUs of a policy, at least
  for MIN/MAX frequencies.

- ??

-- 
viresh
