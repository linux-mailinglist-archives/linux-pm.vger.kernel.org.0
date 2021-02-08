Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C9313E77
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 20:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhBHTHA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 14:07:00 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64096 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhBHTFS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 14:05:18 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id f271e82a41dea252; Mon, 8 Feb 2021 20:04:28 +0100
Received: from kreacher.localnet (89-64-80-68.dynamic.chello.pl [89.64.80.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3659A6608B3;
        Mon,  8 Feb 2021 20:04:28 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: WARNING: suspicious RCU usage (5.11.0-rc7+ #1812 Tainted: G)
Date:   Mon, 08 Feb 2021 20:04:27 +0100
Message-ID: <2578278.ATerS0GEoy@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrheefgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeevudefgfeguedtjedvhfetveegleduveeuvedvjeekleefhfduhfefheekffefveenucfkphepkeelrdeigedrkedtrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrieekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter & Paul,

The traces below are present in the boot dmesg log on my Dell XPS13 9360.

I haven't had the time to look into this in detail yet, but here it goes in
case you know what's going on already.

Cheers!


[   86.762542] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready

[   86.764298] =============================
[   86.764300] WARNING: suspicious RCU usage
[   86.764302] 5.11.0-rc7+ #1812 Tainted: G          I      
[   86.764305] -----------------------------
[   86.764307] /scratch/rafael/work/linux-pm/include/linux/rhashtable.h:594 suspicious rcu_dereference_check() usage!
[   86.764309] 
               other info that might help us debug this:

[   86.764311] 
               rcu_scheduler_active = 2, debug_locks = 1
[   86.764313] no locks held by swapper/1/0.
[   86.764316] 
               stack backtrace:
[   86.764318] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G          I       5.11.0-rc7+ #1812
[   86.764321] Hardware name: Dell Inc. XPS 13 9360/, BIOS 1.3.5 05/08/2017
[   86.764323] Call Trace:
[   86.764325]  <IRQ>
[   86.764328]  dump_stack+0x77/0x97
[   86.764336]  ieee80211_find_sta_by_ifaddr+0x218/0x2e0 [mac80211]
[   86.764380]  ? ath10k_wmi_tlv_op_pull_mgmt_tx_bundle_compl_ev+0xe0/0xe0 [ath10k_core]
[   86.764399]  ath10k_wmi_tlv_parse_peer_stats_info+0x2a/0x70 [ath10k_core]
[   86.764411]  ath10k_wmi_tlv_iter+0x56/0xd0 [ath10k_core]
[   86.764424]  ath10k_wmi_tlv_op_rx+0x75a/0xa30 [ath10k_core]
[   86.764438]  ath10k_htc_rx_completion_handler+0xe8/0x120 [ath10k_core]
[   86.764452]  ? ath10k_htc_process_trailer+0x290/0x290 [ath10k_core]
[   86.764462]  ath10k_pci_process_rx_cb+0x117/0x180 [ath10k_pci]
[   86.764472]  ? ath10k_ce_per_engine_service+0x4c/0x80 [ath10k_core]
[   86.764490]  ? _raw_spin_unlock_irqrestore+0x47/0x60
[   86.764504]  ath10k_ce_per_engine_service+0x5d/0x80 [ath10k_core]
[   86.764524]  ath10k_ce_per_engine_service_any+0x6a/0xa0 [ath10k_core]
[   86.764543]  ath10k_pci_napi_poll+0x44/0x110 [ath10k_pci]
[   86.764552]  net_rx_action+0x15d/0x4e0
[   86.764570]  __do_softirq+0xeb/0x492
[   86.764583]  ? handle_fasteoi_irq+0x150/0x150
[   86.764591]  asm_call_irq_on_stack+0x12/0x20
[   86.764598]  </IRQ>
[   86.764602]  do_softirq_own_stack+0x81/0xa0
[   86.764609]  irq_exit_rcu+0xcd/0xe0
[   86.764614]  common_interrupt+0xfe/0x230
[   86.764623]  asm_common_interrupt+0x1e/0x40
[   86.764626] RIP: 0010:cpuidle_enter_state+0x109/0x4a0
[   86.764631] Code: 02 00 00 31 ff e8 b7 40 8e ff 45 84 ff 74 12 9c 58 f6 c4 02 0f 85 10 03 00 00 31 ff e8 70 42 96 ff e8 bb a2 9d ff fb 45 85 f6 <0f> 88 12 01 00 00 49 63 d6 4c 2b 24 24 48 8d 04 52 48 8d 04 82 49
[   86.764634] RSP: 0018:ffffc900000e3e80 EFLAGS: 00000202
[   86.764638] RAX: 00000000000e8d89 RBX: 0000000000000002 RCX: 0000000000000000
[   86.764641] RDX: 0000000000000000 RSI: ffffffff82392561 RDI: ffffffff82344126
[   86.764643] RBP: ffffe8ffffc93300 R08: 0000000000000001 R09: 0000000000000001
[   86.764645] R10: ffffc900000e3e60 R11: 0000000000000002 R12: 00000014338d5797
[   86.764647] R13: ffffffff827e6d60 R14: 0000000000000002 R15: 0000000000000000
[   86.764667]  cpuidle_enter+0x29/0x40
[   86.764672]  do_idle+0x22d/0x2b0
[   86.764682]  cpu_startup_entry+0x19/0x20
[   86.764686]  start_secondary+0x125/0x160
[   86.764691]  secondary_startup_64_no_verify+0xb0/0xbb

[   86.764710] =============================
[   86.764712] WARNING: suspicious RCU usage
[   86.764714] 5.11.0-rc7+ #1812 Tainted: G          I      
[   86.764716] -----------------------------
[   86.764718] /scratch/rafael/work/linux-pm/include/linux/rhashtable.h:369 suspicious rcu_dereference_check() usage!
[   86.764720] 
               other info that might help us debug this:

[   86.764722] 
               rcu_scheduler_active = 2, debug_locks = 1
[   86.764724] no locks held by swapper/1/0.
[   86.764726] 
               stack backtrace:
[   86.764728] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G          I       5.11.0-rc7+ #1812
[   86.764730] Hardware name: Dell Inc. XPS 13 9360/, BIOS 1.3.5 05/08/2017
[   86.764732] Call Trace:
[   86.764734]  <IRQ>
[   86.764737]  dump_stack+0x77/0x97
[   86.764742]  ieee80211_find_sta_by_ifaddr+0x249/0x2e0 [mac80211]
[   86.764781]  ? ath10k_wmi_tlv_op_pull_mgmt_tx_bundle_compl_ev+0xe0/0xe0 [ath10k_core]
[   86.764795]  ath10k_wmi_tlv_parse_peer_stats_info+0x2a/0x70 [ath10k_core]
[   86.764806]  ath10k_wmi_tlv_iter+0x56/0xd0 [ath10k_core]
[   86.764819]  ath10k_wmi_tlv_op_rx+0x75a/0xa30 [ath10k_core]
[   86.764833]  ath10k_htc_rx_completion_handler+0xe8/0x120 [ath10k_core]
[   86.764845]  ? ath10k_htc_process_trailer+0x290/0x290 [ath10k_core]
[   86.764856]  ath10k_pci_process_rx_cb+0x117/0x180 [ath10k_pci]
[   86.764865]  ? ath10k_ce_per_engine_service+0x4c/0x80 [ath10k_core]
[   86.764876]  ? _raw_spin_unlock_irqrestore+0x47/0x60
[   86.764885]  ath10k_ce_per_engine_service+0x5d/0x80 [ath10k_core]
[   86.764897]  ath10k_ce_per_engine_service_any+0x6a/0xa0 [ath10k_core]
[   86.764908]  ath10k_pci_napi_poll+0x44/0x110 [ath10k_pci]
[   86.764915]  net_rx_action+0x15d/0x4e0
[   86.764927]  __do_softirq+0xeb/0x492
[   86.764934]  ? handle_fasteoi_irq+0x150/0x150
[   86.764940]  asm_call_irq_on_stack+0x12/0x20
[   86.764944]  </IRQ>
[   86.764946]  do_softirq_own_stack+0x81/0xa0
[   86.764951]  irq_exit_rcu+0xcd/0xe0
[   86.764954]  common_interrupt+0xfe/0x230
[   86.764961]  asm_common_interrupt+0x1e/0x40
[   86.764964] RIP: 0010:cpuidle_enter_state+0x109/0x4a0
[   86.764967] Code: 02 00 00 31 ff e8 b7 40 8e ff 45 84 ff 74 12 9c 58 f6 c4 02 0f 85 10 03 00 00 31 ff e8 70 42 96 ff e8 bb a2 9d ff fb 45 85 f6 <0f> 88 12 01 00 00 49 63 d6 4c 2b 24 24 48 8d 04 52 48 8d 04 82 49
[   86.764970] RSP: 0018:ffffc900000e3e80 EFLAGS: 00000202
[   86.764974] RAX: 00000000000e8d89 RBX: 0000000000000002 RCX: 0000000000000000
[   86.764976] RDX: 0000000000000000 RSI: ffffffff82392561 RDI: ffffffff82344126
[   86.764978] RBP: ffffe8ffffc93300 R08: 0000000000000001 R09: 0000000000000001
[   86.764980] R10: ffffc900000e3e60 R11: 0000000000000002 R12: 00000014338d5797
[   86.764983] R13: ffffffff827e6d60 R14: 0000000000000002 R15: 0000000000000000
[   86.765002]  cpuidle_enter+0x29/0x40
[   86.765007]  do_idle+0x22d/0x2b0
[   86.765019]  cpu_startup_entry+0x19/0x20
[   86.765025]  start_secondary+0x125/0x160
[   86.765031]  secondary_startup_64_no_verify+0xb0/0xbb
[   88.867292] pcieport 0000:00:1c.4: AER: Corrected error received: 0000:00:1c.4
[   88.867348] pcieport 0000:00:1c.4: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
[   88.867351] pcieport 0000:00:1c.4:   device [8086:9d14] error status/mask=00001000/00002000
[   88.867354] pcieport 0000:00:1c.4:    [12] Timeout               
[   95.481009] pcieport 0000:00:1c.4: AER: Corrected error received: 0000:00:1c.4
[   95.481024] pcieport 0000:00:1c.4: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
[   95.481028] pcieport 0000:00:1c.4:   device [8086:9d14] error status/mask=00001000/00002000
[   95.481031] pcieport 0000:00:1c.4:    [12] Timeout               



