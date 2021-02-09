Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7111315567
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 18:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhBIRsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 12:48:08 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40509 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbhBIRpO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 12:45:14 -0500
Received: by mail-oi1-f180.google.com with SMTP id 18so9186425oiz.7;
        Tue, 09 Feb 2021 09:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtXdLx7QlA0Hn7jRs0rtA6L/r/My3x/LjkODXAI/ZOI=;
        b=UnaSPPQrY9SJvTNkpoFtHCGP4lc3BDUp+QZwxWF369mPoJBBM4uIY0IE+wXAfN7E0o
         nQi4uZ1P0GeOqdWDHr0EmLMHiiRzTgV+Iaip18ASDUYQS3IQ1TEQVPj19qMoxL4jyzSW
         FChAxFQZs7Hp3WqPdmgFdQ5xin0+vmpUh83ShkvbHXHS5qyk4YCMRoxxP2wr4sYUbm2u
         83qw8fnmwPljM3Jnrqc39Ucena3ypy7jBN3e3rhlbTlUJHALGHQWpQLwqHlcXRQFqaS4
         4p3G+3GrAODcj1YBdh1w38IY8DMp8TuVY3OwWGLmCFB6MfZvuFxVNZnnQlumN+ffaGcA
         yXsQ==
X-Gm-Message-State: AOAM533PpX2lC8FvLODHkAN6avoHM9Tfk3KunRtauwZwjz5OD7Q2rhko
        iNexlBV6NKfrg7eWlU/R8OdO+e88s7O6EWQrxajIOFbD
X-Google-Smtp-Source: ABdhPJzvatBRRP9QCg3hWjuREYuGegpUTJw/ZdMXqcue86G/3sT32HdOXCN6FcQCHTbSD9e+iBL4Ycr1573AUX0yf3w=
X-Received: by 2002:aca:d14:: with SMTP id 20mr3398663oin.157.1612892672828;
 Tue, 09 Feb 2021 09:44:32 -0800 (PST)
MIME-Version: 1.0
References: <2578278.ATerS0GEoy@kreacher> <YCJyJgEeiQqBRgzL@hirez.programming.kicks-ass.net>
 <877dnhv4lg.fsf@codeaurora.org>
In-Reply-To: <877dnhv4lg.fsf@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Feb 2021 18:44:21 +0100
Message-ID: <CAJZ5v0iX0Bn7qjTB6S8exox_NYujAupUy4XkJAyFVNDjvnnZXg@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage (5.11.0-rc7+ #1812 Tainted: G)
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Paul McKenney <paulmck@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 9, 2021 at 12:57 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> + ath10k list
>
> Peter Zijlstra <peterz@infradead.org> writes:
>
> > On Mon, Feb 08, 2021 at 08:04:27PM +0100, Rafael J. Wysocki wrote:
> >> Hi Peter & Paul,
> >>
> >> The traces below are present in the boot dmesg log on my Dell XPS13 9360.
> >>
> >> I haven't had the time to look into this in detail yet, but here it goes in
> >> case you know what's going on already.
> >>
> >> Cheers!
> >>
> >>
> >> [   86.762542] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> >>
> >> [   86.764298] =============================
> >> [   86.764300] WARNING: suspicious RCU usage
> >> [   86.764302] 5.11.0-rc7+ #1812 Tainted: G          I
> >> [   86.764305] -----------------------------
> >> [ 86.764307]
> >> /scratch/rafael/work/linux-pm/include/linux/rhashtable.h:594
> >> suspicious rcu_dereference_check() usage!
> >> [   86.764309]
> >>                other info that might help us debug this:
> >>
> >> [   86.764311]
> >>                rcu_scheduler_active = 2, debug_locks = 1
> >> [   86.764313] no locks held by swapper/1/0.
> >> [   86.764316]
> >>                stack backtrace:
> >> [ 86.764318] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G I 5.11.0-rc7+
> >> #1812
> >> [   86.764321] Hardware name: Dell Inc. XPS 13 9360/, BIOS 1.3.5 05/08/2017
> >> [   86.764323] Call Trace:
> >> [   86.764325]  <IRQ>
> >> [   86.764328]  dump_stack+0x77/0x97
> >> [   86.764336]  ieee80211_find_sta_by_ifaddr+0x218/0x2e0 [mac80211]
> >> [ 86.764380] ?
> >> ath10k_wmi_tlv_op_pull_mgmt_tx_bundle_compl_ev+0xe0/0xe0
> >> [ath10k_core]
> >> [   86.764399]  ath10k_wmi_tlv_parse_peer_stats_info+0x2a/0x70 [ath10k_core]
> >> [   86.764411]  ath10k_wmi_tlv_iter+0x56/0xd0 [ath10k_core]
> >> [   86.764424]  ath10k_wmi_tlv_op_rx+0x75a/0xa30 [ath10k_core]
> >> [   86.764438]  ath10k_htc_rx_completion_handler+0xe8/0x120 [ath10k_core]
> >> [   86.764452]  ? ath10k_htc_process_trailer+0x290/0x290 [ath10k_core]
> >> [   86.764462]  ath10k_pci_process_rx_cb+0x117/0x180 [ath10k_pci]
> >> [   86.764472]  ? ath10k_ce_per_engine_service+0x4c/0x80 [ath10k_core]
> >> [   86.764490]  ? _raw_spin_unlock_irqrestore+0x47/0x60
> >> [   86.764504]  ath10k_ce_per_engine_service+0x5d/0x80 [ath10k_core]
> >> [   86.764524]  ath10k_ce_per_engine_service_any+0x6a/0xa0 [ath10k_core]
> >> [   86.764543]  ath10k_pci_napi_poll+0x44/0x110 [ath10k_pci]
> >> [   86.764552]  net_rx_action+0x15d/0x4e0
> >> [   86.764570]  __do_softirq+0xeb/0x492
> >> [   86.764583]  ? handle_fasteoi_irq+0x150/0x150
> >> [   86.764591]  asm_call_irq_on_stack+0x12/0x20
> >> [   86.764598]  </IRQ>
> >> [   86.764602]  do_softirq_own_stack+0x81/0xa0
> >> [   86.764609]  irq_exit_rcu+0xcd/0xe0
> >> [   86.764614]  common_interrupt+0xfe/0x230
> >> [   86.764623]  asm_common_interrupt+0x1e/0x40
> >> [   86.764626] RIP: 0010:cpuidle_enter_state+0x109/0x4a0
> >> [ 86.764631] Code: 02 00 00 31 ff e8 b7 40 8e ff 45 84 ff 74 12 9c
> >> 58 f6 c4 02 0f 85 10 03 00 00 31 ff e8 70 42 96 ff e8 bb a2 9d ff fb
> >> 45 85 f6 <0f> 88 12 01 00 00 49 63 d6 4c 2b 24 24 48 8d 04 52 48 8d
> >> 04 82 49
> >> [   86.764634] RSP: 0018:ffffc900000e3e80 EFLAGS: 00000202
> >> [   86.764638] RAX: 00000000000e8d89 RBX: 0000000000000002 RCX: 0000000000000000
> >> [   86.764641] RDX: 0000000000000000 RSI: ffffffff82392561 RDI: ffffffff82344126
> >> [   86.764643] RBP: ffffe8ffffc93300 R08: 0000000000000001 R09: 0000000000000001
> >> [   86.764645] R10: ffffc900000e3e60 R11: 0000000000000002 R12: 00000014338d5797
> >> [   86.764647] R13: ffffffff827e6d60 R14: 0000000000000002 R15: 0000000000000000
> >> [   86.764667]  cpuidle_enter+0x29/0x40
> >> [   86.764672]  do_idle+0x22d/0x2b0
> >> [   86.764682]  cpu_startup_entry+0x19/0x20
> >> [   86.764686]  start_secondary+0x125/0x160
> >> [   86.764691]  secondary_startup_64_no_verify+0xb0/0xbb
> >>
> >
> > AFAICT that's a simple 'use RCU without holding rcu_read_lock' warning.
> > I've not dug through ath10k to see who should be doing rcu_read_lock,
> > but the few places I did look at don't seem to have changed recently.
>
> Just this morning I applied a patch which should fix this:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=2615e3cdbd9c0e864f5906279c952a309871d225
>
> Please let me know if it fixes the issue.

The traces are gone after applying this patch, so it does help:

Tested-by: Rafael J. Wysocki <rafael@kernel.org>
