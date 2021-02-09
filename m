Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19D7314E50
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 12:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhBILiW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 06:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhBILae (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 06:30:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08DC061786;
        Tue,  9 Feb 2021 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MYZUFffmQnTW4I69FGK8ki7qFcjhUr81busQP5SyeeE=; b=d1IYJHbNLGueq5urP08KoKZ5L8
        GHNurCeysChyb8xZSgQ+5jngnAGTyrmw10rUAqQY9Rve2elSScnN5Z6QygZEpQFRqGSHYYl+pZIjs
        PC/DYAddfLc3sryDU3RnYpVeJpelXm9ADgtaREmoDnkt0Rd9vPGBF5BzTyMLoQB2pfifnl5WmNjvk
        NY0uiF8xxXtI15GZK6vRMAnLP8g8pKsEmsBiwnB5SwUTiRJZDv6XJeTWePmn/HafPmIquCcH1uiBO
        KSgOhWoP/oGFFhxwPcwLJa2i/zQimVcWMqSRlghmE3TBJOK/VUAdrJcj/QFlr2XOU0eUCDnVl5zQP
        wiEkatAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9RDC-007N0V-Rp; Tue, 09 Feb 2021 11:29:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 441DF3010D2;
        Tue,  9 Feb 2021 12:29:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 296FA2040C58E; Tue,  9 Feb 2021 12:29:42 +0100 (CET)
Date:   Tue, 9 Feb 2021 12:29:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Paul McKenney <paulmck@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        kvalo@codeaurora.org, johannes@sipsolutions.net
Subject: Re: WARNING: suspicious RCU usage (5.11.0-rc7+ #1812 Tainted: G)
Message-ID: <YCJyJgEeiQqBRgzL@hirez.programming.kicks-ass.net>
References: <2578278.ATerS0GEoy@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2578278.ATerS0GEoy@kreacher>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 08, 2021 at 08:04:27PM +0100, Rafael J. Wysocki wrote:
> Hi Peter & Paul,
> 
> The traces below are present in the boot dmesg log on my Dell XPS13 9360.
> 
> I haven't had the time to look into this in detail yet, but here it goes in
> case you know what's going on already.
> 
> Cheers!
> 
> 
> [   86.762542] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> 
> [   86.764298] =============================
> [   86.764300] WARNING: suspicious RCU usage
> [   86.764302] 5.11.0-rc7+ #1812 Tainted: G          I      
> [   86.764305] -----------------------------
> [   86.764307] /scratch/rafael/work/linux-pm/include/linux/rhashtable.h:594 suspicious rcu_dereference_check() usage!
> [   86.764309] 
>                other info that might help us debug this:
> 
> [   86.764311] 
>                rcu_scheduler_active = 2, debug_locks = 1
> [   86.764313] no locks held by swapper/1/0.
> [   86.764316] 
>                stack backtrace:
> [   86.764318] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G          I       5.11.0-rc7+ #1812
> [   86.764321] Hardware name: Dell Inc. XPS 13 9360/, BIOS 1.3.5 05/08/2017
> [   86.764323] Call Trace:
> [   86.764325]  <IRQ>
> [   86.764328]  dump_stack+0x77/0x97
> [   86.764336]  ieee80211_find_sta_by_ifaddr+0x218/0x2e0 [mac80211]
> [   86.764380]  ? ath10k_wmi_tlv_op_pull_mgmt_tx_bundle_compl_ev+0xe0/0xe0 [ath10k_core]
> [   86.764399]  ath10k_wmi_tlv_parse_peer_stats_info+0x2a/0x70 [ath10k_core]
> [   86.764411]  ath10k_wmi_tlv_iter+0x56/0xd0 [ath10k_core]
> [   86.764424]  ath10k_wmi_tlv_op_rx+0x75a/0xa30 [ath10k_core]
> [   86.764438]  ath10k_htc_rx_completion_handler+0xe8/0x120 [ath10k_core]
> [   86.764452]  ? ath10k_htc_process_trailer+0x290/0x290 [ath10k_core]
> [   86.764462]  ath10k_pci_process_rx_cb+0x117/0x180 [ath10k_pci]
> [   86.764472]  ? ath10k_ce_per_engine_service+0x4c/0x80 [ath10k_core]
> [   86.764490]  ? _raw_spin_unlock_irqrestore+0x47/0x60
> [   86.764504]  ath10k_ce_per_engine_service+0x5d/0x80 [ath10k_core]
> [   86.764524]  ath10k_ce_per_engine_service_any+0x6a/0xa0 [ath10k_core]
> [   86.764543]  ath10k_pci_napi_poll+0x44/0x110 [ath10k_pci]
> [   86.764552]  net_rx_action+0x15d/0x4e0
> [   86.764570]  __do_softirq+0xeb/0x492
> [   86.764583]  ? handle_fasteoi_irq+0x150/0x150
> [   86.764591]  asm_call_irq_on_stack+0x12/0x20
> [   86.764598]  </IRQ>
> [   86.764602]  do_softirq_own_stack+0x81/0xa0
> [   86.764609]  irq_exit_rcu+0xcd/0xe0
> [   86.764614]  common_interrupt+0xfe/0x230
> [   86.764623]  asm_common_interrupt+0x1e/0x40
> [   86.764626] RIP: 0010:cpuidle_enter_state+0x109/0x4a0
> [   86.764631] Code: 02 00 00 31 ff e8 b7 40 8e ff 45 84 ff 74 12 9c 58 f6 c4 02 0f 85 10 03 00 00 31 ff e8 70 42 96 ff e8 bb a2 9d ff fb 45 85 f6 <0f> 88 12 01 00 00 49 63 d6 4c 2b 24 24 48 8d 04 52 48 8d 04 82 49
> [   86.764634] RSP: 0018:ffffc900000e3e80 EFLAGS: 00000202
> [   86.764638] RAX: 00000000000e8d89 RBX: 0000000000000002 RCX: 0000000000000000
> [   86.764641] RDX: 0000000000000000 RSI: ffffffff82392561 RDI: ffffffff82344126
> [   86.764643] RBP: ffffe8ffffc93300 R08: 0000000000000001 R09: 0000000000000001
> [   86.764645] R10: ffffc900000e3e60 R11: 0000000000000002 R12: 00000014338d5797
> [   86.764647] R13: ffffffff827e6d60 R14: 0000000000000002 R15: 0000000000000000
> [   86.764667]  cpuidle_enter+0x29/0x40
> [   86.764672]  do_idle+0x22d/0x2b0
> [   86.764682]  cpu_startup_entry+0x19/0x20
> [   86.764686]  start_secondary+0x125/0x160
> [   86.764691]  secondary_startup_64_no_verify+0xb0/0xbb
> 

AFAICT that's a simple 'use RCU without holding rcu_read_lock' warning.
I've not dug through ath10k to see who should be doing rcu_read_lock,
but the few places I did look at don't seem to have changed recently.
