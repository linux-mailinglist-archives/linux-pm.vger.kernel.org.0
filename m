Return-Path: <linux-pm+bounces-22294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A58AA39744
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 10:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D103A1192
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBA922D4C9;
	Tue, 18 Feb 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UTawcBYP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD07222CBF1
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871297; cv=none; b=q5ZmifqD24GOuErIN1NdBwbL9kvmRzHr/FUgcAirlstMcGuGIQZxvQ8oqwHisUKTKijun124BaSQQeBuwaT6toDX0VN6eC8JKruPC56W2qchmOUwJ8NI4MdOh/EU1At9Xv/7Jatl0Md028ygBfHlYmtCI4jvf2+QM3ZKlfr528I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871297; c=relaxed/simple;
	bh=sB1UQmqQhK4gu2XLaAeMf+Ioaa3KMzmflfX9KGqBfmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2s3weFxdVmp55sbSI7TjM5a6uIT+MDdgeGFkBsrYfErWFjwCWbXM9GrFxcGsHbQDn826TnNcsRQ+EyOim1AaHsmtNhWPNF1fJRVo3oaqbACpdPqTwsby/hSqwK0qZipgVbmxQZIx891xSZj7Lyplbkmyo1scZ6X4qlyZToNCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UTawcBYP; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739871234;
	bh=lrJ+uz6pYSSmZnPoJqYxyOn4CEF57kGU7YO1XGtPxMM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UTawcBYPwv5eayVw0ZuqhVK+cGMbuOqV+WVpqE79wVNjXhFSt/BaCaB4vy648LUkv
	 3TR5KJLpk7wwdH6Yh8pfcnoWDpwuBpMtLyLs3NFEixdcvmNNnHk0hBDStFrewGO+aj
	 SLWi3RdNv/QsoH5ooZ/DzfXpFC7Mgl+83sPMEcPM=
X-QQ-mid: bizesmtpip4t1739871228t799soe
X-QQ-Originating-IP: eOhUft3SiXMuSqrs1C1mKuWl6jXlFu9DXoSdxRQLA8c=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Feb 2025 17:33:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7470718702053355893
From: WangYuli <wangyuli@uniontech.com>
To: chenhuacai@loongson.cn
Cc: akpm@linux-foundation.org,
	chenhuacai@kernel.org,
	gongruiqi@huaweicloud.com,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	pavel@kernel.org,
	rafael@kernel.org,
	stable@vger.kernel.org,
	wangyuli@uniontech.com,
	xiujianfeng@huawei.com,
	42.hyeyoo@gmail.com
Subject: Re: [PATCH] mm/slab: Initialise random_kmalloc_seed after initcalls
Date: Tue, 18 Feb 2025 17:33:45 +0800
Message-ID: <EF80DE9BF13D24E4+20250218093345.479309-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250212141648.599661-1-chenhuacai@loongson.cn>
References: <20250212141648.599661-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OYM3GZRvbPalPjUU/PfsypbkB8oo2IUi202VIvs4CDcZWAH+Km+oz59t
	51M6Er0yn/Ivmo/umt2EH5dh8T7QokM9g8EJe/l1NTxUfdQ2TYg+WB5TUrJSYOWIDKaNU4n
	O5r7auevj9GQqJ68oV9CD10b1FsB+iIPjIe6SPkDkoe8u3Cwf3PDWc3h9PkyMS27oSvfQJr
	k7eH0r9KAm4/kxXIEqJkSD5pVrkKNMlwP+DEYa+IhymxggP5BTDIolD4lptjlyHErCshXIu
	E2g0394Wzi0tqLobAztx9lp+MgkNsyrFAfEJTalP7rCCy12rsXJNy9MQXQWZWOv+nwqOj0u
	uUUhjZ0TNLD4NT3MQ+J/H3IQybSI/bSIgRm8v+zlan2Cx0vbWZfzcIyvunS4qWkH2chlcfF
	tlgLsXu7XdtUB12/YQ5IjDE/IQHDLDIY0I/vwYC7acB6vR+NNRcOTwgMHDuVROsSCteWqN/
	OcK9K4lemU2m3EOLFc9dTWCGBcazsDggs3ZmwFJTvwkSKkNimj4TkwxSbDIN6mY3L2jVTRS
	1R2dbSRyCf4SYaKOsMiCnbXF5SU7HJ4RDKbVLI4CQu+LNI8q7Mo9/ktD/tyXNQtd3B8z7Bv
	wM2ohnGV9fAbu+2akREehxXC9sIDIKgqlXSa9rNp9yF8hUljlpEi5EcUOIcNvBXQyHgnlFv
	ZpyLe2eBbzBRRZAdZHj0CrE/sNzKlMb+GrAhs6zAA4IBP3HazR9J6QOLci/aPNm00RQ82zb
	EhSky8XlQ9s7QQ2xr1PA/pEpnFaSrT7NPRb6CseHzAxy+NKNeNiBeorm6MaipkWwqtFXzaI
	5cxa4ZPcOEqHjbZh++fky+lTZRuUjRw/UzcitGm2AilXzYXoB/+B8t1BKH7zaU6ZlWLjv0w
	84SdM9VjdbAEGMMqMZ+X2Jv3l6vE0SZGVjWLsfK/D4/ZDC+40zHJ9ZFKi47LaasB+FNRHkS
	iSINKaYcYQKkPr+gcTUxSHxMkhHQB2YE5KjNACoEOXAf6CTh7QYDyijsA
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Hi all,

This patch helps resolve a wake-up issue after hibernation on Lenovo M90f
desktops (with Phytium D3000 processor). The kernel stack trace when
reproducing this issue is as follows:

[   67.503075] task:jbd2/nvme0n1p4- state:D stack:0     pid:363   ppid:2      flags:0x00000008
[   67.511418] Call trace:
[   67.513852]  __switch_to+0xe4/0x128
[   67.517333]  __schedule+0x214/0x588
[   67.520809]  schedule+0x5c/0xc8
[   67.523938]  __bio_queue_enter+0x144/0x240
[   67.528024]  blk_mq_submit_bio+0x2b4/0x608
[   67.532109]  __submit_bio+0x90/0x150
[   67.535672]  submit_bio_noacct_nocheck+0x104/0x1c0
[   67.540451]  submit_bio_noacct+0x12c/0x548
[   67.544535]  submit_bio+0x4c/0xd8
[   67.547838]  submit_bh_wbc+0x148/0x1d0
[   67.551576]  write_dirty_buffer+0x7c/0x158
[   67.555660]  flush_descriptor.part.0+0x6c/0xd8
[   67.560093]  jbd2_journal_write_revoke_records+0x130/0x1a8
[   67.565567]  jbd2_journal_commit_transaction+0x380/0x18a0
[   67.570954]  kjournald2+0xe4/0x370
[   67.574344]  kthread+0xe4/0xf0
[   67.577388]  ret_from_fork+0x10/0x20
[   67.580952] task:systemd-journal state:D stack:0     pid:449   ppid:1      flags:0x00000804
[   67.589290] Call trace:
[   67.591724]  __switch_to+0xe4/0x128
[   67.595200]  __schedule+0x214/0x588
[   67.598677]  schedule+0x5c/0xc8
[   67.601806]  io_schedule+0x48/0x78
[   67.605195]  bit_wait_io+0x24/0x90
[   67.608585]  __wait_on_bit+0x7c/0xe0
[   67.612148]  out_of_line_wait_on_bit+0x94/0xd0
[   67.616580]  do_get_write_access+0x31c/0x508
[   67.620838]  jbd2_journal_get_write_access+0x94/0xe8
[   67.625791]  __ext4_journal_get_write_access+0x7c/0x1c0
[   67.631004]  ext4_reserve_inode_write+0xb4/0x118
[   67.635609]  __ext4_mark_inode_dirty+0x74/0x280
[   67.640127]  ext4_dirty_inode+0x70/0xa0
[   67.643951]  __mark_inode_dirty+0x60/0x428
[   67.648035]  generic_update_time+0x58/0x78
[   67.652119]  file_update_time+0xb4/0xc0
[   67.655942]  ext4_page_mkwrite+0xb4/0x5d8
[   67.659939]  do_page_mkwrite+0x64/0xf0
[   67.663677]  do_wp_page+0x198/0x4a8
[   67.667153]  __handle_mm_fault+0x438/0x450
[   67.671237]  handle_mm_fault+0xac/0x288
[   67.675061]  do_page_fault+0x278/0x4a8
[   67.678799]  do_mem_abort+0x50/0xb0
[   67.682276]  el0_da+0x3c/0xe8
[   67.685233]  el0t_64_sync_handler+0xc0/0x138
[   67.689492]  el0t_64_sync+0x1ac/0x1b0
[   67.693142] task:jbd2/nvme0n1p5- state:D stack:0     pid:582   ppid:2      flags:0x00000008
[   67.701480] Call trace:
[   67.703914]  __switch_to+0xe4/0x128
[   67.707390]  __schedule+0x214/0x588
[   67.710866]  schedule+0x5c/0xc8
[   67.713996]  __bio_queue_enter+0x144/0x240
[   67.718080]  blk_mq_submit_bio+0x2b4/0x608
[   67.722164]  __submit_bio+0x90/0x150
[   67.725728]  submit_bio_noacct_nocheck+0x104/0x1c0
[   67.730507]  submit_bio_noacct+0x12c/0x548
[   67.734592]  submit_bio+0x4c/0xd8
[   67.737895]  submit_bh_wbc+0x148/0x1d0
[   67.741632]  submit_bh+0x20/0x38
[   67.744848]  jbd2_journal_commit_transaction+0x564/0x18a0
[   67.750234]  kjournald2+0xe4/0x370
[   67.753624]  kthread+0xe4/0xf0
[   67.756666]  ret_from_fork+0x10/0x20
[   67.760234] task:fprintd         state:D stack:0     pid:630   ppid:1      flags:0x00000804
[   67.768572] Call trace:
[   67.771005]  __switch_to+0xe4/0x128
[   67.774482]  __schedule+0x214/0x588
[   67.777958]  schedule+0x5c/0xc8
[   67.781087]  __bio_queue_enter+0x144/0x240
[   67.785172]  blk_mq_submit_bio+0x2b4/0x608
[   67.789257]  __submit_bio+0x90/0x150
[   67.792820]  submit_bio_noacct_nocheck+0x104/0x1c0
[   67.797599]  submit_bio_noacct+0x12c/0x548
[   67.801684]  submit_bio+0x4c/0xd8
[   67.804987]  ext4_mpage_readpages+0x1a4/0x780
[   67.809331]  ext4_readahead+0x44/0x60
[   67.812982]  read_pages+0xa4/0x318
[   67.816372]  page_cache_ra_unbounded+0x164/0x1f8
[   67.820977]  page_cache_ra_order+0x94/0x360
[   67.825148]  filemap_fault+0x478/0xaa0
[   67.828885]  __do_fault+0x48/0x220
[   67.832274]  do_read_fault+0x108/0x1f0
[   67.836011]  do_pte_missing+0x15c/0x1e8
[   67.839835]  __handle_mm_fault+0x204/0x450
[   67.843919]  handle_mm_fault+0xac/0x288
[   67.847742]  do_page_fault+0x278/0x4a8
[   67.851480]  do_translation_fault+0x5c/0x90
[   67.855652]  do_mem_abort+0x50/0xb0
[   67.859128]  el0_ia+0x68/0x148
[   67.862171]  el0t_64_sync_handler+0xd8/0x138
[   67.866429]  el0t_64_sync+0x1ac/0x1b0
[   67.870092] task:deepin-anything state:D stack:0     pid:871   ppid:1      flags:0x00000004
[   67.878429] Call trace:
[   67.880862]  __switch_to+0xe4/0x128
[   67.884339]  __schedule+0x214/0x588
[   67.887815]  schedule+0x5c/0xc8
[   67.890944]  io_schedule+0x48/0x78
[   67.894333]  bit_wait_io+0x24/0x90
[   67.897723]  __wait_on_bit+0x7c/0xe0
[   67.901286]  out_of_line_wait_on_bit+0x94/0xd0
[   67.905717]  do_get_write_access+0x31c/0x508
[   67.909975]  jbd2_journal_get_write_access+0x94/0xe8
[   67.914928]  __ext4_journal_get_write_access+0x7c/0x1c0
[   67.920140]  ext4_reserve_inode_write+0xb4/0x118
[   67.924745]  __ext4_mark_inode_dirty+0x74/0x280
[   67.929263]  ext4_dirty_inode+0x70/0xa0
[   67.933086]  __mark_inode_dirty+0x60/0x428
[   67.937170]  generic_update_time+0x58/0x78
[   67.941254]  file_modified+0xe4/0xf0
[   67.944816]  ext4_buffered_write_iter+0x64/0x148
[   67.949422]  ext4_file_write_iter+0x44/0x90
[   67.953593]  vfs_write+0x218/0x3d0
[   67.956984]  ksys_write+0x80/0x128
[   67.960374]  __arm64_sys_write+0x28/0x40
[   67.964285]  invoke_syscall+0x54/0x138
[   67.968023]  el0_svc_common.constprop.0+0x4c/0x100
[   67.972803]  do_el0_svc+0x28/0x40
[   67.976106]  el0_svc+0x44/0x128
[   67.979236]  el0t_64_sync_handler+0x108/0x138
[   67.983581]  el0t_64_sync+0x1ac/0x1b0
[   67.987243] task:wireplumber     state:D stack:0     pid:1792  ppid:1764   flags:0x00000804
[   67.995581] Call trace:
[   67.998014]  __switch_to+0xe4/0x128
[   68.001490]  __schedule+0x214/0x588
[   68.004966]  schedule+0x5c/0xc8
[   68.008096]  __bio_queue_enter+0x144/0x240
[   68.012180]  blk_mq_submit_bio+0x2b4/0x608
[   68.016264]  __submit_bio+0x90/0x150
[   68.019828]  submit_bio_noacct_nocheck+0x104/0x1c0
[   68.024607]  submit_bio_noacct+0x12c/0x548
[   68.028691]  submit_bio+0x4c/0xd8
[   68.031994]  ext4_io_submit+0x3c/0x70
[   68.035644]  ext4_do_writepages+0x41c/0x6b0
[   68.039814]  ext4_writepages+0xac/0x148
[   68.043638]  do_writepages+0x98/0x238
[   68.047287]  filemap_fdatawrite_wbc+0xa0/0x110
[   68.051719]  __filemap_fdatawrite_range+0x70/0xb0
[   68.056411]  file_write_and_wait_range+0x78/0xf8
[   68.061016]  ext4_sync_file+0x80/0x398
[   68.064753]  vfs_fsync_range+0x40/0x98
[   68.068491]  do_fsync+0x4c/0xa8
[   68.071621]  __arm64_sys_fsync+0x24/0x40
[   68.075532]  invoke_syscall+0x54/0x138
[   68.079269]  el0_svc_common.constprop.0+0xd4/0x100
[   68.084048]  do_el0_svc+0x28/0x40
[   68.087352]  el0_svc+0x44/0x128
[   68.090481]  el0t_64_sync_handler+0x108/0x138
[   68.094827]  el0t_64_sync+0x1ac/0x1b0
[   68.098481] task:startdde        state:D stack:0     pid:2105  ppid:1764   flags:0x00000005
[   68.106819] Call trace:
[   68.109252]  __switch_to+0xe4/0x128
[   68.112729]  __schedule+0x214/0x588
[   68.116205]  schedule+0x5c/0xc8
[   68.119334]  __bio_queue_enter+0x144/0x240
[   68.123418]  blk_mq_submit_bio+0x2b4/0x608
[   68.127502]  __submit_bio+0x90/0x150
[   68.131065]  submit_bio_noacct_nocheck+0x104/0x1c0
[   68.135844]  submit_bio_noacct+0x12c/0x548
[   68.139928]  submit_bio+0x4c/0xd8
[   68.143232]  ext4_mpage_readpages+0x1a4/0x780
[   68.147576]  ext4_readahead+0x44/0x60
[   68.151226]  read_pages+0xa4/0x318
[   68.154616]  page_cache_ra_unbounded+0x130/0x1f8
[   68.159220]  page_cache_ra_order+0x94/0x360
[   68.163391]  filemap_fault+0x478/0xaa0
[   68.167128]  __do_fault+0x48/0x220
[   68.170518]  do_read_fault+0x108/0x1f0
[   68.174255]  do_pte_missing+0x15c/0x1e8
[   68.178078]  __handle_mm_fault+0x204/0x450
[   68.182162]  handle_mm_fault+0xac/0x288
[   68.185986]  do_page_fault+0x278/0x4a8
[   68.189724]  do_translation_fault+0x5c/0x90
[   68.193896]  do_mem_abort+0x50/0xb0
[   68.197372]  el0_da+0x3c/0xe8
[   68.200328]  el0t_64_sync_handler+0xc0/0x138
[   68.204586]  el0t_64_sync+0x1ac/0x1b0
[   68.208242] task:dde-file-manage state:D stack:0     pid:2202  ppid:1764   flags:0x00000004
[   68.216579] Call trace:
[   68.219012]  __switch_to+0xe4/0x128
[   68.222489]  __schedule+0x214/0x588
[   68.225965]  schedule+0x5c/0xc8
[   68.229094]  __bio_queue_enter+0x144/0x240
[   68.233178]  blk_mq_submit_bio+0x2b4/0x608
[   68.237263]  __submit_bio+0x90/0x150
[   68.240826]  submit_bio_noacct_nocheck+0x104/0x1c0
[   68.245605]  submit_bio_noacct+0x12c/0x548
[   68.249689]  submit_bio+0x4c/0xd8
[   68.252992]  ext4_io_submit+0x3c/0x70
[   68.256641]  ext4_do_writepages+0x41c/0x6b0
[   68.260812]  ext4_writepages+0xac/0x148
[   68.264635]  do_writepages+0x98/0x238
[   68.268285]  filemap_fdatawrite_wbc+0xa0/0x110
[   68.272716]  __filemap_fdatawrite_range+0x70/0xb0
[   68.277408]  filemap_flush+0x28/0x40
[   68.280971]  ext4_alloc_da_blocks+0x38/0x90
[   68.285141]  ext4_release_file+0x88/0xf0
[   68.289052]  __fput+0xe0/0x2a0
[   68.292096]  __fput_sync+0x5c/0x78
[   68.295486]  __arm64_sys_close+0x44/0x98
[   68.299397]  invoke_syscall+0x54/0x138
[   68.303135]  el0_svc_common.constprop.0+0x4c/0x100
[   68.307914]  do_el0_svc+0x28/0x40
[   68.311217]  el0_svc+0x44/0x128
[   68.314347]  el0t_64_sync_handler+0x108/0x138
[   68.318692]  el0t_64_sync+0x1ac/0x1b0
[   68.322347] task:dde-session-dae state:D stack:0     pid:2247  ppid:1764   flags:0x00000004
[   68.330684] Call trace:
[   68.333118]  __switch_to+0xe4/0x128
[   68.336594]  __schedule+0x214/0x588
[   68.340070]  schedule+0x5c/0xc8
[   68.343199]  __bio_queue_enter+0x144/0x240
[   68.347284]  blk_mq_submit_bio+0x2b4/0x608
[   68.351368]  __submit_bio+0x90/0x150
[   68.354932]  submit_bio_noacct_nocheck+0x104/0x1c0
[   68.359710]  submit_bio_noacct+0x12c/0x548
[   68.363794]  submit_bio+0x4c/0xd8
[   68.367097]  submit_bh_wbc+0x148/0x1d0
[   68.370833]  submit_bh+0x20/0x38
[   68.374049]  __ext4_read_bh+0x58/0xe8
[   68.377700]  ext4_read_bh+0x4c/0xf0
[   68.381176]  ext4_read_bh_lock+0x60/0xd8
[   68.385088]  ext4_bread+0x88/0xf8
[   68.388390]  __ext4_read_dirblock+0x68/0x3d8
[   68.392649]  htree_dirblock_to_tree+0x98/0x348
[   68.397081]  ext4_htree_fill_tree+0xe8/0x378
[   68.401339]  ext4_dx_readdir+0xf4/0x380
[   68.405162]  ext4_readdir+0x53c/0x6e8
[   68.408812]  iterate_dir+0xa4/0x190
[   68.412288]  __arm64_sys_getdents64+0x7c/0x170
[   68.416720]  invoke_syscall+0x54/0x138
[   68.420457]  el0_svc_common.constprop.0+0x4c/0x100
[   68.425236]  do_el0_svc+0x28/0x40
[   68.428540]  el0_svc+0x44/0x128
[   68.431669]  el0t_64_sync_handler+0x108/0x138
[   68.436014]  el0t_64_sync+0x1ac/0x1b0
[   68.439669] task:dde-lock        state:D stack:0     pid:2259  ppid:1764   flags:0x00000004
[   68.448007] Call trace:
[   68.450440]  __switch_to+0xe4/0x128
[   68.453916]  __schedule+0x214/0x588
[   68.457392]  schedule+0x5c/0xc8
[   68.460522]  io_schedule+0x48/0x78
[   68.463911]  bit_wait_io+0x24/0x90
[   68.467300]  __wait_on_bit+0x7c/0xe0
[   68.470864]  out_of_line_wait_on_bit+0x94/0xd0
[   68.475295]  do_get_write_access+0x31c/0x508
[   68.479553]  jbd2_journal_get_write_access+0x94/0xe8
[   68.484505]  __ext4_journal_get_write_access+0x7c/0x1c0
[   68.489717]  ext4_reserve_inode_write+0xb4/0x118
[   68.494322]  __ext4_mark_inode_dirty+0x74/0x280
[   68.498840]  ext4_dirty_inode+0x70/0xa0
[   68.502664]  __mark_inode_dirty+0x60/0x428
[   68.506748]  generic_update_time+0x58/0x78
[   68.510831]  file_modified+0xe4/0xf0
[   68.514393]  ext4_buffered_write_iter+0x64/0x148
[   68.518998]  ext4_file_write_iter+0x44/0x90
[   68.523169]  vfs_write+0x218/0x3d0
[   68.526559]  ksys_write+0x80/0x128
[   68.529949]  __arm64_sys_write+0x28/0x40
[   68.533860]  invoke_syscall+0x54/0x138
[   68.537598]  el0_svc_common.constprop.0+0x4c/0x100
[   68.542377]  do_el0_svc+0x28/0x40
[   68.545680]  el0_svc+0x44/0x128
[   68.548810]  el0t_64_sync_handler+0x108/0x138
[   68.553155]  el0t_64_sync+0x1ac/0x1b0
[   68.556837] task:dde-blackwidget state:D stack:0     pid:3059  ppid:1764   flags:0x00000005
[   68.565174] Call trace:
[   68.567607]  __switch_to+0xe4/0x128
[   68.571084]  __schedule+0x214/0x588
[   68.574560]  schedule+0x5c/0xc8
[   68.577689]  __bio_queue_enter+0x144/0x240
[   68.581773]  blk_mq_submit_bio+0x2b4/0x608
[   68.585858]  __submit_bio+0x90/0x150
[   68.589421]  submit_bio_noacct_nocheck+0x104/0x1c0
[   68.594200]  submit_bio_noacct+0x12c/0x548
[   68.598284]  submit_bio+0x4c/0xd8
[   68.601587]  ext4_mpage_readpages+0x1a4/0x780
[   68.605931]  ext4_readahead+0x44/0x60
[   68.609582]  read_pages+0xa4/0x318
[   68.612972]  page_cache_ra_unbounded+0x164/0x1f8
[   68.617576]  page_cache_ra_order+0x94/0x360
[   68.621747]  filemap_fault+0x478/0xaa0
[   68.625484]  __do_fault+0x48/0x220
[   68.628873]  do_read_fault+0x108/0x1f0
[   68.632610]  do_pte_missing+0x15c/0x1e8
[   68.636434]  __handle_mm_fault+0x204/0x450
[   68.640518]  handle_mm_fault+0xac/0x288
[   68.644341]  do_page_fault+0x278/0x4a8
[   68.648078]  do_translation_fault+0x5c/0x90
[   68.652250]  do_mem_abort+0x50/0xb0
[   68.655726]  el0_ia+0x68/0x148
[   68.658769]  el0t_64_sync_handler+0xd8/0x138
[   68.663027]  el0t_64_sync+0x1ac/0x1b0
[   68.666677] task:kworker/u16:8   state:D stack:0     pid:3071  ppid:2      flags:0x00000008
[   68.675015] Workqueue: nvme-reset-wq nvme_reset_work
[   68.679969] Call trace:
[   68.682403]  __switch_to+0xe4/0x128
[   68.685880]  __schedule+0x214/0x588
[   68.689356]  schedule+0x5c/0xc8
[   68.692485]  schedule_timeout+0x180/0x198
[   68.696483]  io_schedule_timeout+0x54/0x78
[   68.700567]  __wait_for_common+0xd8/0x290
[   68.704565]  wait_for_completion_io+0x2c/0x48
[   68.708909]  blk_execute_rq+0xd4/0x178
[   68.712646]  __nvme_submit_sync_cmd+0xa4/0x180
[   68.717079]  nvme_identify_ctrl+0xdc/0x140
[   68.721164]  nvme_init_identify+0x4c/0x598
[   68.725248]  nvme_init_ctrl_finish+0x94/0x300
[   68.729592]  nvme_reset_work+0xa0/0x2e8
[   68.733415]  process_one_work+0x160/0x3c8
[   68.737413]  worker_thread+0x2e4/0x508
[   68.741150]  kthread+0xe4/0xf0
[   68.744193]  ret_from_fork+0x10/0x20
[   68.747764] task:kworker/u16:66  state:D stack:0     pid:3129  ppid:2      flags:0x00000008
[   68.756102] Workqueue: writeback wb_workfn (flush-259:0)
[   68.761403] Call trace:
[   68.763836]  __switch_to+0xe4/0x128
[   68.767313]  __schedule+0x214/0x588
[   68.770789]  schedule+0x5c/0xc8
[   68.773918]  __bio_queue_enter+0x144/0x240
[   68.778002]  blk_mq_submit_bio+0x2b4/0x608
[   68.782087]  __submit_bio+0x90/0x150
[   68.785650]  submit_bio_noacct_nocheck+0x104/0x1c0
[   68.790429]  submit_bio_noacct+0x12c/0x548
[   68.794513]  submit_bio+0x4c/0xd8
[   68.797817]  ext4_io_submit+0x3c/0x70
[   68.801466]  ext4_do_writepages+0x2ec/0x6b0
[   68.805637]  ext4_writepages+0xac/0x148
[   68.809460]  do_writepages+0x98/0x238
[   68.813110]  __writeback_single_inode+0x4c/0x408
[   68.817714]  writeback_sb_inodes+0x22c/0x5d8
[   68.821972]  __writeback_inodes_wb+0x6c/0x160
[   68.826316]  wb_writeback+0x2ec/0x3e0
[   68.829966]  wb_do_writeback+0x2cc/0x408
[   68.833877]  wb_workfn+0x88/0x2b8
[   68.837180]  process_one_work+0x160/0x3c8
[   68.841178]  worker_thread+0x2e4/0x508
[   68.844916]  kthread+0xe4/0xf0
[   68.847958]  ret_from_fork+0x10/0x20
[   68.851522] task:kworker/u16:69  state:D stack:0     pid:3132  ppid:2      flags:0x00000008
[   68.859859] Workqueue: writeback wb_workfn (flush-259:0)
[   68.865160] Call trace:
[   68.867593]  __switch_to+0xe4/0x128
[   68.871069]  __schedule+0x214/0x588
[   68.874545]  schedule+0x5c/0xc8
[   68.877674]  io_schedule+0x48/0x78
[   68.881064]  bit_wait_io+0x24/0x90
[   68.884453]  __wait_on_bit+0x7c/0xe0
[   68.888017]  out_of_line_wait_on_bit+0x94/0xd0
[   68.892448]  do_get_write_access+0x31c/0x508
[   68.896706]  jbd2_journal_get_write_access+0x94/0xe8
[   68.901659]  __ext4_journal_get_write_access+0x7c/0x1c0
[   68.906870]  ext4_mb_mark_diskspace_used+0x148/0x3e8
[   68.911823]  ext4_mb_new_blocks+0x198/0x7a0
[   68.915994]  ext4_ext_map_blocks+0x620/0x828
[   68.920252]  ext4_map_blocks+0x1b0/0x5b8
[   68.924162]  mpage_map_one_extent+0x80/0x1a0
[   68.928419]  mpage_map_and_submit_extent+0x8c/0x338
[   68.933284]  ext4_do_writepages+0x5bc/0x6b0
[   68.937454]  ext4_writepages+0xac/0x148
[   68.941278]  do_writepages+0x98/0x238
[   68.944928]  __writeback_single_inode+0x4c/0x408
[   68.949532]  writeback_sb_inodes+0x22c/0x5d8
[   68.953790]  __writeback_inodes_wb+0x6c/0x160
[   68.958134]  wb_writeback+0x2ec/0x3e0
[   68.961784]  wb_do_writeback+0x2cc/0x408
[   68.965694]  wb_workfn+0x88/0x2b8
[   68.968997]  process_one_work+0x160/0x3c8
[   68.972995]  worker_thread+0x2e4/0x508
[   68.976732]  kthread+0xe4/0xf0
[   68.979774]  ret_from_fork+0x10/0x20
[   68.983340] task:(oothd.sh)      state:D stack:0     pid:3150  ppid:1      flags:0x00000804
[   68.991677] Call trace:
[   68.994110]  __switch_to+0xe4/0x128
[   68.997587]  __schedule+0x214/0x588
[   69.001063]  schedule+0x5c/0xc8
[   69.004192]  __bio_queue_enter+0x144/0x240
[   69.008276]  blk_mq_submit_bio+0x2b4/0x608
[   69.012361]  __submit_bio+0x90/0x150
[   69.015924]  submit_bio_noacct_nocheck+0x104/0x1c0
[   69.020703]  submit_bio_noacct+0x12c/0x548
[   69.024787]  submit_bio+0x4c/0xd8
[   69.028090]  ext4_mpage_readpages+0x1a4/0x780
[   69.032434]  ext4_readahead+0x44/0x60
[   69.036085]  read_pages+0xa4/0x318
[   69.039475]  page_cache_ra_unbounded+0x164/0x1f8
[   69.044080]  page_cache_ra_order+0x94/0x360
[   69.048250]  ondemand_readahead+0x16c/0x2e0
[   69.052421]  page_cache_sync_ra+0xa4/0xc8
[   69.056418]  filemap_get_pages+0xc8/0x3c0
[   69.060416]  filemap_read+0xec/0x398
[   69.063979]  generic_file_read_iter+0x50/0x160
[   69.068410]  ext4_file_read_iter+0x60/0x240
[   69.072581]  __kernel_read+0xdc/0x280
[   69.076232]  kernel_read+0x74/0xc8
[   69.079621]  search_binary_handler+0x60/0x320
[   69.083967]  exec_binprm+0x5c/0x1c0
[   69.087444]  bprm_execve.part.0+0x1e8/0x270
[   69.091614]  bprm_execve+0x68/0xa8
[   69.095004]  do_execveat_common.isra.0+0x1a8/0x250
[   69.099783]  __arm64_sys_execve+0x4c/0x70
[   69.103781]  invoke_syscall+0x54/0x138
[   69.107518]  el0_svc_common.constprop.0+0xd4/0x100
[   69.112297]  do_el0_svc+0x28/0x40
[   69.115601]  el0_svc+0x44/0x128
[   69.118730]  el0t_64_sync_handler+0x108/0x138
[   69.123075]  el0t_64_sync+0x1ac/0x1b0
[   69.126725] task:QThread         state:D stack:0     pid:3174  ppid:1486   flags:0x00000005
[   69.135063] Call trace:
[   69.137496]  __switch_to+0xe4/0x128
[   69.140973]  __schedule+0x214/0x588
[   69.144449]  schedule+0x5c/0xc8
[   69.147578]  __bio_queue_enter+0x144/0x240
[   69.151663]  blk_mq_submit_bio+0x2b4/0x608
[   69.155748]  __submit_bio+0x90/0x150
[   69.159312]  submit_bio_noacct_nocheck+0x104/0x1c0
[   69.164090]  submit_bio_noacct+0x12c/0x548
[   69.168175]  submit_bio+0x4c/0xd8
[   69.171478]  ext4_mpage_readpages+0x1a4/0x780
[   69.175822]  ext4_readahead+0x44/0x60
[   69.179472]  read_pages+0xa4/0x318
[   69.182861]  page_cache_ra_unbounded+0x164/0x1f8
[   69.187466]  page_cache_ra_order+0x94/0x360
[   69.191637]  ondemand_readahead+0x16c/0x2e0
[   69.195808]  page_cache_sync_ra+0xa4/0xc8
[   69.199805]  filemap_get_pages+0xc8/0x3c0
[   69.203802]  filemap_read+0xec/0x398
[   69.207365]  generic_file_read_iter+0x50/0x160
[   69.211796]  ext4_file_read_iter+0x60/0x240
[   69.215967]  __kernel_read+0xdc/0x280
[   69.219617]  kernel_read+0x74/0xc8
[   69.223007]  search_binary_handler+0x60/0x320
[   69.227352]  exec_binprm+0x5c/0x1c0
[   69.230829]  bprm_execve.part.0+0x1e8/0x270
[   69.235000]  bprm_execve+0x68/0xa8
[   69.238389]  do_execveat_common.isra.0+0x1a8/0x250
[   69.243168]  __arm64_sys_execve+0x4c/0x70
[   69.247166]  invoke_syscall+0x54/0x138
[   69.250904]  el0_svc_common.constprop.0+0x4c/0x100
[   69.255684]  do_el0_svc+0x28/0x40
[   69.258987]  el0_svc+0x44/0x128
[   69.262117]  el0t_64_sync_handler+0x108/0x138
[   69.266462]  el0t_64_sync+0x1ac/0x1b0
[   69.270111] task:(sd-rmrf)       state:D stack:0     pid:3177  ppid:1      flags:0x00000004
[   69.278449] Call trace:
[   69.280882]  __switch_to+0xe4/0x128
[   69.284358]  __schedule+0x214/0x588
[   69.287835]  schedule+0x5c/0xc8
[   69.290964]  io_schedule+0x48/0x78
[   69.294353]  bit_wait_io+0x24/0x90
[   69.297743]  __wait_on_bit+0x7c/0xe0
[   69.301306]  out_of_line_wait_on_bit+0x94/0xd0
[   69.305738]  do_get_write_access+0x31c/0x508
[   69.309996]  jbd2_journal_get_write_access+0x94/0xe8
[   69.314948]  __ext4_journal_get_write_access+0x7c/0x1c0
[   69.320160]  ext4_orphan_add+0x158/0x398
[   69.324071]  ext4_rmdir+0x26c/0x3d8
[   69.327547]  vfs_rmdir+0x98/0x250
[   69.330849]  do_rmdir+0x184/0x1b8
[   69.334152]  __arm64_sys_unlinkat+0x74/0xa0
[   69.338322]  invoke_syscall+0x54/0x138
[   69.342060]  el0_svc_common.constprop.0+0x4c/0x100
[   69.346840]  do_el0_svc+0x28/0x40
[   69.350143]  el0_svc+0x44/0x128
[   69.353273]  el0t_64_sync_handler+0x108/0x138
[   69.357617]  el0t_64_sync+0x1ac/0x1b0
[  101.463556] nvme nvme0: I/O 17 QID 0 timeout, completion polled
[  101.463558] nvme nvme0: Shutdown timeout set to 10 seconds
[FAILED] Failed to start nmbd.service - Samba NMB Daemon.


