Return-Path: <linux-pm+bounces-34684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C3B581F3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 18:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4372164AA1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F728261B91;
	Mon, 15 Sep 2025 16:26:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE024DCE9;
	Mon, 15 Sep 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953598; cv=none; b=G0tNLrE5D8RnGQeu39bpTGof2emv7250oqydtaAxwjZsIK1GjIJGov/19I1V/Hg8cHZk4Qw9Q6a3NHqLu02T5qN/Av0cjFuJSjCaoqTiBu5YZ0tY2QxaiUiS2GmWFcxMj7/y4nLFWwQxF/rdrWMzMgaQcMmMciucrXuMitlVE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953598; c=relaxed/simple;
	bh=JTSY3ld7tW1cgh4uGWv9l2bQ8qf7J7s86kqL4TosX70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzcJMvyJVacYWl1IlpjeDihdTL5ffDlPLurstfJAWtDYnJyC/QxW878tyRz3yQV9PaVa/7B/T+lIl/rxwMof8evWM1i2IEkrvQNPi4xzcPrE+q2x05sJnkg9AyOr6X1ti22dYfaczO0aVW15l7DPkV48X+saKfxJrVV+y/HpE1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cQVl54WGxzYmZhf;
	Tue, 16 Sep 2025 00:25:53 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 00:26:24 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 00:26:23 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <feng.han@honor.com>, <lenb@kernel.org>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-pm@vger.kernel.org>, <liulu.liu@honor.com>,
	<lorenzo.stoakes@oracle.com>, <pavel@kernel.org>, <rafael@kernel.org>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <surenb@google.com>,
	<tglx@linutronix.de>, <zhongjinji@honor.com>
Subject: Re: [PATCH v9 2/2] mm/oom_kill: The OOM reaper traverses the VMA maple tree in reverse order
Date: Tue, 16 Sep 2025 00:26:19 +0800
Message-ID: <20250915162619.5133-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aMJ619kjFm00c4OP@tiehlicka>
References: <aMJ619kjFm00c4OP@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a018.hihonor.com
 (10.68.17.250)

This perf report evaluates the benefits that process_mrelease gains after
applying the patch. However, in this test, process_mrelease is not called
directly. Instead, the kill signal is proactively intercepted, and the
killed process is added to the oom_reaper queue to trigger the reaper
worker. This simulates the way LMKD calls process_mrelease, which helps
simplify the testing process.

Since the perf report is too complicated, let us focus on the key points
from the report.

Key points:
1. Compared to the version without the patch, the total time reduced by
exit_mmap plus reaper work is roughly equal to the reduction in total
pte spinlock waiting time.
2. With the patch applied, for certain functions, the reaper performs
more times, such as folio_remove_rmap_ptes, but the time spent by
exit_mmap on folio_remove_rmap_ptes decreases accordingly.

Summary of measurements (ms):
+----------------------------------------------------------------+
| Category                      | Applying patch | Without patch |
+-------------------------------+----------------+---------------+
| Total running time            |    132.6       |    167.1      |
|   (exit_mmap + reaper work)   |  72.4 + 60.2   |  90.7 + 76.4  |
+-------------------------------+----------------+---------------+
| Time waiting for pte spinlock |     1.0        |    33.1       |
|   (exit_mmap + reaper work)   |   0.4 + 0.6    |  10.0 + 23.1  |
+-------------------------------+----------------+---------------+
| folio_remove_rmap_ptes time   |    42.0        |    41.3       |
|   (exit_mmap + reaper work)   |  18.4 + 23.6   |  22.4 + 18.9  |
+----------------------------------------------------------------+

Report without patch:

Arch: arm64
Event: cpu-clock (type 1, config 0)
Samples: 6355
Event count: 90781175
do_exit
 |--93.81%-- mmput
 |    |--99.46%-- exit_mmap
 |    |    |--76.74%-- unmap_vmas
 |    |    |    |--9.14%-- [hit in function]
 |    |    |    |--34.25%-- tlb_flush_mmu
 |    |    |    |--31.13%-- folio_remove_rmap_ptes
 |    |    |    |--15.04%-- __pte_offset_map_lock
 |    |    |    |--5.43%-- free_swap_and_cache_nr
 |    |    |    |--1.80%-- _raw_spin_lock
 |    |    |    |--1.19%-- folio_mark_accessed
 |    |    |    |--0.84%-- __tlb_remove_folio_pages
 |    |    |    |--0.37%-- mas_find
 |    |    |    |--0.37%-- percpu_counter_add_batch
 |    |    |    |--0.20%-- __mod_lruvec_page_state
 |    |    |    |--0.13%-- f2fs_dirty_data_folio
 |    |    |    |--0.04%-- __rcu_read_unlock
 |    |    |    |--0.04%-- tlb_flush_rmaps
 |    |    |    |          folio_remove_rmap_ptes
 |    |    |     --0.02%-- folio_mark_dirty
 |    |    |--12.72%-- free_pgtables
 |    |    |--2.65%-- folio_remove_rmap_ptes
 |    |    |--2.50%-- __vm_area_free
 |    |    |    |--11.49%-- [hit in function]
 |    |    |    |--81.08%-- kmem_cache_free
 |    |    |    |--4.05%-- _raw_spin_unlock_irqrestore
 |    |    |     --3.38%-- anon_vma_name_free
 |    |    |--1.03%-- folio_mark_accessed
 |    |    |--0.96%-- __tlb_remove_folio_pages
 |    |    |--0.54%-- mas_find
 |    |    |--0.46%-- tlb_finish_mmu
 |    |    |    |--96.30%-- free_pages_and_swap_cache
 |    |    |    |    |--80.77%-- release_pages
 |    |    |--0.44%-- kmem_cache_free
 |    |    |--0.39%-- __pte_offset_map_lock
 |    |    |--0.30%-- task_work_add
 |    |    |--0.19%-- __rcu_read_unlock
 |    |    |--0.17%-- fput
 |    |    |--0.13%-- __mt_destroy
 |    |    |--0.10%-- down_write
 |    |    |--0.07%-- unlink_file_vma
 |    |    |--0.05%-- percpu_counter_add_batch
 |    |    |--0.02%-- free_swap_and_cache_nr
 |    |    |--0.02%-- flush_tlb_batched_pending
 |    |    |--0.02%-- uprobe_munmap
 |    |    |--0.02%-- _raw_spin_unlock
 |    |    |--0.02%-- unlink_anon_vmas
 |    |     --0.02%-- up_write
 |    |--0.40%-- fput
 |    |--0.10%-- mas_find
 |     --0.02%-- __vm_area_free
 |--5.19%-- task_work_run
 |--0.42%-- exit_files
 |          put_files_struct
 |--0.35%-- exit_task_namespaces

Children  Self      Command         Symbol
90752605  0         TEST_PROCESS    do_exit
90752605  0         TEST_PROCESS    get_signal
85138600  0         TEST_PROCESS    __mmput
84681480  399980    TEST_PROCESS    exit_mmap
64982465  5942560   TEST_PROCESS    unmap_vmas
22598870  1599920   TEST_PROCESS    free_pages_and_swap_cache
22498875  3314120   TEST_PROCESS    folio_remove_rmap_ptes
10985165  1442785   TEST_PROCESS    _raw_spin_lock
10770890  57140     TEST_PROCESS    free_pgtables
10099495  399980    TEST_PROCESS    __pte_offset_map_lock
8199590   1285650   TEST_PROCESS    folios_put_refs
4756905   685680    TEST_PROCESS    free_unref_page_list
4714050   14285     TEST_PROCESS    task_work_run
4671195   199990    TEST_PROCESS    ____fput
4085510   214275    TEST_PROCESS    __fput
3914090   57140     TEST_PROCESS    unlink_file_vma
3542680   28570     TEST_PROCESS    free_swap_and_cache_nr
3214125   2114180   TEST_PROCESS    free_unref_folios
3142700   14285     TEST_PROCESS    swap_entry_range_free
2828430   2828430   TEST_PROCESS    kmem_cache_free
2714150   528545    TEST_PROCESS    zram_free_page
2528445   114280    TEST_PROCESS    zram_slot_free_notify

Arch: arm64
Event: cpu-clock (type 1, config 0)
Samples: 5353
Event count: 76467605
kthread
|--99.57%-- oom_reaper
|    |--0.28%-- [hit in function]
|    |--73.58%-- unmap_page_range
|    |    |--8.67%-- [hit in function]
|    |    |--41.59%-- __pte_offset_map_lock
|    |    |--29.47%-- folio_remove_rmap_ptes
|    |    |--16.11%-- tlb_flush_mmu
|    |    |           free_pages_and_swap_cache
|    |    |    |--9.49%-- [hit in function]
|    |    |--1.66%-- folio_mark_accessed
|    |    |--0.74%-- free_swap_and_cache_nr
|    |    |--0.69%-- __tlb_remove_folio_pages
|    |    |--0.41%-- __mod_lruvec_page_state
|    |    |--0.33%-- _raw_spin_lock
|    |    |--0.28%-- percpu_counter_add_batch
|    |    |--0.03%-- tlb_flush_mmu_tlbonly
|    |     --0.03%-- __rcu_read_unlock
|    |--19.94%-- tlb_finish_mmu
|    |    |--23.24%-- [hit in function]
|    |    |--76.39%-- free_pages_and_swap_cache
|    |    |--0.28%-- free_pages
|    |     --0.09%-- release_pages
|    |--3.21%-- folio_remove_rmap_ptes
|    |--1.16%-- __tlb_remove_folio_pages
|    |--1.16%-- folio_mark_accessed
|    |--0.36%-- __pte_offset_map_lock
|    |--0.28%-- mas_find
|     --0.02%-- __rcu_read_unlock
|--0.17%-- tlb_finish_mmu
|--0.15%-- mas_find
|--0.06%-- memset
|--0.04%-- unmap_page_range
 --0.02%-- tlb_gather_mmu

Children  Self      Command       Symbol
76467605  0         oom_reaper    kthread
76139050  214275    oom_reaper    oom_reaper
56054340  4885470   oom_reaper    unmap_page_range
23570250  385695    oom_reaper    __pte_offset_map_lock
23341690  257130    oom_reaper    _raw_spin_lock
23113130  23113130  oom_reaper    queued_spin_lock_slowpath
20627540  1371360   oom_reaper    free_pages_and_swap_cache
19027620  614255    oom_reaper    release_pages
18956195  3399830   oom_reaper    folio_remove_rmap_ptes
15313520  3656960   oom_reaper    tlb_finish_mmu
11799410  11785125  oom_reaper    cgroup_rstat_updated
11285150  11256580  oom_reaper    _raw_spin_unlock_irqrestore
9028120   0         oom_reaper    tlb_flush_mmu
8613855   1342790   oom_reaper    folios_put_refs
5442585   485690    oom_reaper    free_unref_page_list
4299785   1614205   oom_reaper    free_unref_folios
3385545   1299935   oom_reaper    free_unref_page_commit

Report with patch:

Arch: arm64
Event: cpu-clock (type 1, config 0)
Samples: 5075
Event count: 72496375
|--99.98%-- do_notify_resume
|    |--92.63%-- mmput
|    |    |--99.57%-- exit_mmap
|    |    |    |--0.79%-- [hit in function]
|    |    |    |--76.43%-- unmap_vmas
|    |    |    |    |--8.39%-- [hit in function]
|    |    |    |    |--42.80%-- tlb_flush_mmu
|    |    |    |    |           free_pages_and_swap_cache
|    |    |    |    |--34.08%-- folio_remove_rmap_ptes
|    |    |    |    |--9.51%-- free_swap_and_cache_nr
|    |    |    |    |--2.40%-- _raw_spin_lock
|    |    |    |    |--0.75%-- __tlb_remove_folio_pages
|    |    |    |    |--0.48%-- mas_find
|    |    |    |    |--0.36%-- __pte_offset_map_lock
|    |    |    |    |--0.34%-- percpu_counter_add_batch
|    |    |    |    |--0.34%-- folio_mark_accessed
|    |    |    |    |--0.20%-- __mod_lruvec_page_state
|    |    |    |    |--0.17%-- f2fs_dirty_data_folio
|    |    |    |    |--0.11%-- __rcu_read_unlock
|    |    |    |    |--0.03%-- _raw_spin_unlock
|    |    |    |    |--0.03%-- tlb_flush_rmaps
|    |    |    |     --0.03%-- uprobe_munmap
|    |    |    |--14.19%-- free_pgtables
|    |    |    |--2.52%-- __vm_area_free
|    |    |    |--1.52%-- folio_remove_rmap_ptes
|    |    |    |--0.83%-- mas_find
|    |    |    |--0.81%-- __tlb_remove_folio_pages
|    |    |    |--0.77%-- folio_mark_accessed
|    |    |    |--0.41%-- kmem_cache_free
|    |    |    |--0.36%-- task_work_add
|    |    |    |--0.34%-- fput
|    |    |    |--0.32%-- __pte_offset_map_lock
|    |    |    |--0.15%-- __rcu_read_unlock
|    |    |    |--0.15%-- __mt_destroy
|    |    |    |--0.09%-- unlink_file_vma
|    |    |    |--0.06%-- down_write
|    |    |    |--0.04%-- lookup_swap_cgroup_id
|    |    |    |--0.04%-- uprobe_munmap
|    |    |    |--0.04%-- percpu_counter_add_batch
|    |    |    |--0.04%-- up_write
|    |    |    |--0.02%-- flush_tlb_batched_pending
|    |    |    |--0.02%-- _raw_spin_unlock
|    |    |    |--0.02%-- unlink_anon_vmas
|    |    |     --0.02%-- tlb_finish_mmu
|    |    |               free_unref_page
|    |    |--0.38%-- fput
|    |     --0.04%-- mas_find
|    |--6.21%-- task_work_run
|    |--0.47%-- exit_task_namespaces
|    |--0.16%-- ____fput
|     --0.04%-- mm_update_next_owner

Children  Self      Command         Symbol
72482090  0         TEST_PROCESS    get_signal
67139500  0         TEST_PROCESS    __mmput
67139500  0         TEST_PROCESS    mmput
66853800  528545    TEST_PROCESS    exit_mmap
51097445  4285500   TEST_PROCESS    unmap_vmas
21870335  0         TEST_PROCESS    tlb_flush_mmu
21870335  1371360   TEST_PROCESS    free_pages_and_swap_cache
20384695  485690    TEST_PROCESS    release_pages
18427650  1814195   TEST_PROCESS    folio_remove_rmap_ptes
13799310  13785025  TEST_PROCESS    cgroup_rstat_updated
12842215  12842215  TEST_PROCESS    _raw_spin_unlock_irqrestore
9485240   14285     TEST_PROCESS    free_pgtables
7785325   428550    TEST_PROCESS    folios_put_refs
4899755   642825    TEST_PROCESS    free_unref_page_list
4856900   42855     TEST_PROCESS    free_swap_and_cache_nr
4499775   14285     TEST_PROCESS    task_work_run
4385495   114280    TEST_PROCESS    ____fput
3971230   714250    TEST_PROCESS    zram_free_page
3899805   14285     TEST_PROCESS    swap_entry_range_free
3785525   185705    TEST_PROCESS    zram_slot_free_notify
399980    399980    TEST_PROCESS    __pte_offset_map_lock

Arch: arm64
Event: cpu-clock (type 1, config 0)
Samples: 4221
Event count: 60296985
kthread
|--99.53%-- oom_reaper
|    |--0.17%-- [hit in function]
|    |--55.77%-- unmap_page_range
|    |    |--20.49%-- [hit in function]
|    |    |--58.30%-- folio_remove_rmap_ptes
|    |    |--11.48%-- tlb_flush_mmu
|    |    |--3.33%-- folio_mark_accessed
|    |    |--2.65%-- __tlb_remove_folio_pages
|    |    |--1.37%-- _raw_spin_lock
|    |    |--0.68%-- __mod_lruvec_page_state
|    |    |--0.51%-- __pte_offset_map_lock
|    |    |--0.43%-- percpu_counter_add_batch
|    |    |--0.30%-- __rcu_read_unlock
|    |    |--0.13%-- free_swap_and_cache_nr
|    |    |--0.09%-- tlb_flush_mmu_tlbonly
|    |     --0.04%-- __rcu_read_lock
|    |--32.21%-- tlb_finish_mmu
|    |    |--88.69%-- free_pages_and_swap_cache
|    |--6.93%-- folio_remove_rmap_ptes
|    |--1.90%-- __tlb_remove_folio_pages
|    |--1.55%-- folio_mark_accessed
|    |--0.69%-- __pte_offset_map_lock
|    |--0.45%-- mas_find_rev
|    |    |--21.05%-- [hit in function]
|    |     --78.95%-- mas_prev_slot
|    |--0.12%-- mas_prev_slot
|    |--0.10%-- free_pages_and_swap_cache
|    |--0.07%-- __rcu_read_unlock
|    |--0.02%-- percpu_counter_add_batch
|     --0.02%-- lookup_swap_cgroup_id
|--0.12%-- mas_find_rev
|--0.12%-- unmap_page_range
|--0.12%-- tlb_finish_mmu
|--0.09%-- tlb_gather_mmu
 --0.02%-- memset

Children  Self      Command       Symbol
60296985  0         oom_reaper    kthread
60011285  99995     oom_reaper    oom_reaper
33541180  6928225   oom_reaper    unmap_page_range
23670245  5414015   oom_reaper    folio_remove_rmap_ptes
21027520  1757055   oom_reaper    free_pages_and_swap_cache
19399030  2171320   oom_reaper    tlb_finish_mmu
18970480  885670    oom_reaper    release_pages
13785025  13785025  oom_reaper    cgroup_rstat_updated
11442285  11442285  oom_reaper    _raw_spin_unlock_irqrestore
7928175   1871335   oom_reaper    folios_put_refs
4742620   371410    oom_reaper    free_unref_page_list
3928375   942810    oom_reaper    free_unref_folios
3842665   14285     oom_reaper    tlb_flush_mmu
3385545   728535    oom_reaper    free_unref_page_commit
585685    571400    oom_reaper    __pte_offset_map_lock

