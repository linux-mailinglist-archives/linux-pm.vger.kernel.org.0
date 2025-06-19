Return-Path: <linux-pm+bounces-29029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF129ADFC05
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 05:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29462189F0C1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 03:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F99239E7D;
	Thu, 19 Jun 2025 03:54:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42C288A8;
	Thu, 19 Jun 2025 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750305270; cv=none; b=TM3112E1zy6APTqOiRc51r9YodFlwfsCNyMWuu+ASj/eGQFxUWItBwRr6mXUGWnMGG5/y68g+6yZdJdBp452r1EyTfkuVQltGZuI4ccN3OZbhkV/zZpZ89qxnlWYGREL+QyWLnp1HnBdFOI5lGh6l5PF7ba/p9XAC+GzA1J/EUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750305270; c=relaxed/simple;
	bh=IFX+3v+vUS9YCIeKiKTjDAaKXNEZMuRRJOChFHrQovk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=si+u/c6MbWouryokLkSCGiTns59koG1Y45LAijbEq0Q9U8F8iCZGzlvWkEz3MLUxJA8Vk1Ivr8aWCcKFuKMDzGJZtKhyZL+GXOMvVHlp2pM8aydeap47eqR4yw5Rm9/TpUJbQ+rm1OiouLKXHeGlnIRB4NQmfgZ0vMI4HtIbHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 141b5b664cc111f0b29709d653e92f7d-20250619
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c2a26077-7b1e-40b0-b404-faf2d230091b,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:ff7e6dd868d25dd7e522693d27707afc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 141b5b664cc111f0b29709d653e92f7d-20250619
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 401056050; Thu, 19 Jun 2025 11:54:19 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 9EAF2E00891C;
	Thu, 19 Jun 2025 11:54:19 +0800 (CST)
X-ns-mid: postfix-685389EB-2938696
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id E482BE008900;
	Thu, 19 Jun 2025 11:53:58 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2 0/4] PM: freezer: Add retry stats and D-state task logging for debugging
Date: Thu, 19 Jun 2025 11:53:51 +0800
Message-Id: <20250619035355.33402-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In our internal testing of system suspend and process freezing behavior,
we observed that the time taken to freeze userspace processes is often
non-deterministic. On certain systems (e.g. desktop with Xorg), the freez=
er
frequently requires 5 to 6 retry iterations before all tasks are frozen.
Upon investigation, we found that this instability is primarily caused by
user processes entering D-state (TASK_UNINTERRUPTIBLE) during the freeze
window. Since such tasks cannot be frozen and are not killable by signals=
,
they cause the freezer to repeatedly sleep and retry, resulting in:
- Increased system suspend latency (from hundreds of milliseconds up to s=
everal milliseconds)
- Elevated CPU usage due to repeated full task list scans
- In worst cases, freezer may fail
This patchset introduces two debugging aids to help analyze and mitigate
this issue:

- Patch 1: Add retry counter and report how many rounds freezing took
- Patch 2: Log all D-state tasks in each freeze iteration
- Patch 3: ensures pm_pr_dbg() works properly
- Patch 4: simplifies state check

These tools make it easier to identify problematic tasks and evaluate
the impact of uninterruptible waits on suspend/resume stability.
Tested on systems where D-state tasks (e.g. from Xorg or poll-heavy
drivers) regularly delay suspend.

With our patch:
dmesg | grep -E 'elap|round'
[   63.227193] freeze round: 0, task to freeze: 681
[   63.228110] freeze round: 1, task to freeze: 1
[   63.230248] freeze round: 2, task to freeze: 1
[   63.234247] freeze round: 3, task to freeze: 1
[   63.242270] freeze round: 4, task to freeze: 1
[   63.250272] freeze round: 5, task to freeze: 1
[   63.258516] freeze round: 6, task to freeze: 1
[   63.266478] freeze round: 7, task to freeze: 0
[   63.266481] Freezing user space processes completed (elapsed 0.039 sec=
onds)
[   63.266641] freeze round: 0, task to freeze: 4
[   63.267347] freeze round: 1, task to freeze: 0
[   63.267349] Freezing remaining freezable tasks completed (elapsed 0.00=
0 seconds)
[   74.452100] freeze round: 0, task to freeze: 686
[   74.452781] freeze round: 1, task to freeze: 1
[   74.454915] freeze round: 2, task to freeze: 1
[   74.458947] freeze round: 3, task to freeze: 1
[   74.466938] freeze round: 4, task to freeze: 1
[   74.474950] freeze round: 5, task to freeze: 1
[   74.482954] freeze round: 6, task to freeze: 1
[   74.491320] freeze round: 7, task to freeze: 0
[   74.491324] Freezing user space processes completed (elapsed 0.039 sec=
onds)
[   74.491485] freeze round: 0, task to freeze: 4
[   74.492748] freeze round: 1, task to freeze: 0
[   74.492750] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
[   85.642102] freeze round: 0, task to freeze: 685
[   85.642841] freeze round: 1, task to freeze: 1
[   85.644974] freeze round: 2, task to freeze: 1
[   85.648978] freeze round: 3, task to freeze: 1
[   85.656972] freeze round: 4, task to freeze: 1
[   85.665231] freeze round: 5, task to freeze: 1
[   85.673492] freeze round: 6, task to freeze: 1
[   85.682035] freeze round: 7, task to freeze: 0
[   85.682039] Freezing user space processes completed (elapsed 0.040 sec=
onds)
[   85.682198] freeze round: 0, task to freeze: 4
[   85.682972] freeze round: 1, task to freeze: 0
[   85.682974] Freezing remaining freezable tasks completed (elapsed 0.00=
0 seconds)
[   96.863597] freeze round: 0, task to freeze: 678
[   96.864298] freeze round: 1, task to freeze: 1
[   96.866430] freeze round: 2, task to freeze: 1
[   96.870477] freeze round: 3, task to freeze: 1
[   96.878486] freeze round: 4, task to freeze: 1
[   96.886463] freeze round: 5, task to freeze: 1
[   96.894745] freeze round: 6, task to freeze: 1
[   96.903120] freeze round: 7, task to freeze: 0
[   96.903124] Freezing user space processes completed (elapsed 0.040 sec=
onds)
[   96.903288] freeze round: 0, task to freeze: 4
[   96.904480] freeze round: 1, task to freeze: 0
[   96.904482] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
[  108.026657] freeze round: 0, task to freeze: 678
[  108.027363] freeze round: 1, task to freeze: 1
[  108.029476] freeze round: 2, task to freeze: 1
[  108.033527] freeze round: 3, task to freeze: 1
[  108.041510] freeze round: 4, task to freeze: 1
[  108.049774] freeze round: 5, task to freeze: 1
[  108.057485] freeze round: 6, task to freeze: 0
[  108.057487] Freezing user space processes completed (elapsed 0.031 sec=
onds)
[  108.057604] freeze round: 0, task to freeze: 4
[  108.058474] freeze round: 1, task to freeze: 0
[  108.058476] Freezing remaining freezable tasks completed (elapsed 0.00=
0 seconds)
[  119.171536] freeze round: 0, task to freeze: 678
[  119.172301] freeze round: 1, task to freeze: 1
[  119.174402] freeze round: 2, task to freeze: 1
[  119.178445] freeze round: 3, task to freeze: 1
[  119.186442] freeze round: 4, task to freeze: 1
[  119.194445] freeze round: 5, task to freeze: 1
[  119.202425] freeze round: 6, task to freeze: 1
[  119.210572] freeze round: 7, task to freeze: 0
[  119.210576] Freezing user space processes completed (elapsed 0.039 sec=
onds)
[  119.210733] freeze round: 0, task to freeze: 4
[  119.211435] freeze round: 1, task to freeze: 0
[  119.211437] Freezing remaining freezable tasks completed (elapsed 0.00=
0 seconds)
[  130.577681] freeze round: 0, task to freeze: 688
[  130.578819] freeze round: 1, task to freeze: 3
[  130.580489] freeze round: 2, task to freeze: 3
[  130.584525] freeze round: 3, task to freeze: 3
[  130.592511] freeze round: 4, task to freeze: 3
[  130.600496] freeze round: 5, task to freeze: 3
[  130.608495] freeze round: 6, task to freeze: 3
[  130.616642] freeze round: 7, task to freeze: 2
[  130.624597] freeze round: 8, task to freeze: 1
[  130.632868] freeze round: 9, task to freeze: 1
[  130.640430] freeze round: 10, task to freeze: 0
[  130.640434] Freezing user space processes completed (elapsed 0.063 sec=
onds)
[  130.640592] freeze round: 0, task to freeze: 4
[  130.641397] freeze round: 1, task to freeze: 0
[  130.641399] Freezing remaining freezable tasks completed (elapsed 0.00=
0 seconds)
[  142.024896] freeze round: 0, task to freeze: 687
[  142.025680] freeze round: 1, task to freeze: 3
[  142.027855] freeze round: 2, task to freeze: 3
[  142.031872] freeze round: 3, task to freeze: 3
[  142.039876] freeze round: 4, task to freeze: 3
[  142.048215] freeze round: 5, task to freeze: 3
[  142.055875] freeze round: 6, task to freeze: 3
[  142.063839] freeze round: 7, task to freeze: 2
[  142.071957] freeze round: 8, task to freeze: 2
[  142.080048] freeze round: 9, task to freeze: 2
[  142.088052] freeze round: 10, task to freeze: 2
[  142.096595] freeze round: 11, task to freeze: 2
[  142.104908] freeze round: 12, task to freeze: 1
[  142.112904] freeze round: 13, task to freeze: 1
[  142.121407] freeze round: 14, task to freeze: 0
[  142.121411] Freezing user space processes completed (elapsed 0.097 sec=
onds)
[  142.121573] freeze round: 0, task to freeze: 4
[  142.122944] freeze round: 1, task to freeze: 0
[  142.122948] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
[  153.374096] freeze round: 0, task to freeze: 687
[  153.374840] freeze round: 1, task to freeze: 3
[  153.377042] freeze round: 2, task to freeze: 3
[  153.381074] freeze round: 3, task to freeze: 3
[  153.389017] freeze round: 4, task to freeze: 2
[  153.397331] freeze round: 5, task to freeze: 2
[  153.405600] freeze round: 6, task to freeze: 1
[  153.413910] freeze round: 7, task to freeze: 0
[  153.413913] Freezing user space processes completed (elapsed 0.040 sec=
onds)
[  153.414073] freeze round: 0, task to freeze: 4
[  153.414974] freeze round: 1, task to freeze: 0
[  153.414976] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
[  164.640178] freeze round: 0, task to freeze: 687
[  164.640865] freeze round: 1, task to freeze: 3
[  164.643050] freeze round: 2, task to freeze: 3
[  164.647084] freeze round: 3, task to freeze: 3
[  164.655014] freeze round: 4, task to freeze: 2
[  164.663304] freeze round: 5, task to freeze: 2
[  164.671018] freeze round: 6, task to freeze: 2
[  164.679274] freeze round: 7, task to freeze: 1
[  164.687812] freeze round: 8, task to freeze: 0
[  164.687815] Freezing user space processes completed (elapsed 0.048 sec=
onds)
[  164.687971] freeze round: 0, task to freeze: 4
[  164.688969] freeze round: 1, task to freeze: 0
[  164.688971] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)


With our patch:
[   62.880497] PM: suspend entry (deep)
[   63.130639] Filesystems sync: 0.249 seconds
[   63.130643] PM: Preparing system for sleep (deep)
[   63.226398] Freezing user space processes
[   63.227193] freeze round: 0, task to freeze: 681
[   63.228110] freeze round: 1, task to freeze: 1
[   63.230064] task:Xorg            state:D stack:0     pid:1404  tgid:14=
04  ppid:1348   task_flags:0x400100 flags:0x00004004
[   63.230068] Call Trace:
[   63.230069]  <TASK>
[   63.230071]  __schedule+0x52e/0xea0
[   63.230077]  schedule+0x27/0x80
[   63.230079]  schedule_timeout+0xf2/0x100
[   63.230082]  wait_for_completion+0x85/0x130
[   63.230085]  __flush_work+0x21f/0x310
[   63.230087]  ? __pfx_wq_barrier_func+0x10/0x10
[   63.230091]  drm_mode_rmfb+0x138/0x1b0
[   63.230093]  ? __pfx_drm_mode_rmfb_work_fn+0x10/0x10
[   63.230095]  ? __pfx_drm_mode_rmfb_ioctl+0x10/0x10
[   63.230097]  drm_ioctl_kernel+0xa5/0x100
[   63.230099]  drm_ioctl+0x270/0x4b0
[   63.230101]  ? __pfx_drm_mode_rmfb_ioctl+0x10/0x10
[   63.230104]  ? syscall_exit_work+0x108/0x140
[   63.230107]  radeon_drm_ioctl+0x4a/0x80 [radeon]
[   63.230141]  __x64_sys_ioctl+0x93/0xe0
[   63.230144]  ? syscall_trace_enter+0xfa/0x1c0
[   63.230146]  do_syscall_64+0x7d/0x2c0
[   63.230148]  ? do_syscall_64+0x1f3/0x2c0
[   63.230150]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   63.230153] RIP: 0033:0x7f1aa132550b
[   63.230154] RSP: 002b:00007ffebab69678 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
[   63.230156] RAX: ffffffffffffffda RBX: 00007ffebab696bc RCX: 00007f1aa=
132550b
[   63.230158] RDX: 00007ffebab696bc RSI: 00000000c00464af RDI: 000000000=
000000e
[   63.230159] RBP: 00000000c00464af R08: 00007f1aa0c41220 R09: 000055a71=
ce32310
[   63.230160] R10: 0000000000000087 R11: 0000000000000246 R12: 000055a71=
b813660
[   63.230161] R13: 000000000000000e R14: 0000000003a8f5cd R15: 000055a71=
b6bbfb0
[   63.230164]  </TASK>
[   63.230248] freeze round: 2, task to freeze: 1

Changes in v2:
- Add retry count statistics and print D-state process=20

Zihuan Zhang (4):
  PM: freezer: Add retry count statistics for freeze pass iterations
  PM: freezer: Print tasks stuck in D-state during freeze
  PM: suspend: Assign pm_suspend_target_state earlier for valid debug
    logs
  PM: suspend: Simplify state check using sleep_state_supported()

 kernel/power/process.c |  7 +++++++
 kernel/power/suspend.c | 17 +++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

--=20
2.25.1


