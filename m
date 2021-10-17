Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E388C430857
	for <lists+linux-pm@lfdr.de>; Sun, 17 Oct 2021 13:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245483AbhJQL07 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Oct 2021 07:26:59 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54940 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbhJQL05 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Oct 2021 07:26:57 -0400
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 19HBONTM000462;
        Sun, 17 Oct 2021 20:24:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sun, 17 Oct 2021 20:24:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 19HBOMte000456
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 17 Oct 2021 20:24:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [syzbot] possible deadlock in blk_request_module
To:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <000000000000a6de6705cc9f0be7@google.com>
Cc:     linux-block@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        linux-pm@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <9739a06a-58c6-0187-fa0b-7be85f26cf9a@I-love.SAKURA.ne.jp>
Date:   Sun, 17 Oct 2021 20:24:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <000000000000a6de6705cc9f0be7@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello.

Commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
is calling destroy_workqueue() with lo->lo_mutex held, and syzbot is
reporting circular locking dependency

  &disk->open_mutex => &lo->lo_mutex => (wq_completion)loop$M =>
  (work_completion)(&lo->rootcg_work) => sb_writers#$N => &p->lock =>
  &of->mutex => system_transition_mutex/1 => &disk->open_mutex

. Can you somehow call destroy_workqueue() without holding a lock (e.g.
breaking &lo->lo_mutex => (wq_completion)loop$M dependency chain by
making sure that below change is safe) ?

@@ -1365,7 +1365,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
        /* freeze request queue during the transition */
        blk_mq_freeze_queue(lo->lo_queue);

+       mutex_unlock(&lo->lo_mutex);
        destroy_workqueue(lo->workqueue);
+       mutex_lock(&lo->lo_mutex);
        spin_lock_irq(&lo->lo_work_lock);
        list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
                                idle_list) {
On 2021/09/23 9:52, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    93ff9f13be91 Merge tag 's390-5.15-3' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d5b33d300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
> dashboard link: https://syzkaller.appspot.com/bug?extid=384fb45e189bf86b6bb9
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+384fb45e189bf86b6bb9@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.15.0-rc1-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.3/12106 is trying to acquire lock:
> ffffffff8c201508 (major_names_lock){+.+.}-{3:3}, at: blk_request_module+0x25/0x1d0 block/genhd.c:634
> 
> but task is already holding lock:
> ffffffff8b84fda8 (system_transition_mutex/1){+.+.}-{3:3}, at: software_resume.part.0+0x19/0x1f0 kernel/power/hibernate.c:932
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #9 (system_transition_mutex/1){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:596 [inline]
>        __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
>        software_resume.part.0+0x19/0x1f0 kernel/power/hibernate.c:932
>        software_resume kernel/power/hibernate.c:86 [inline]
>        resume_store+0x161/0x190 kernel/power/hibernate.c:1179
>        kobj_attr_store+0x50/0x80 lib/kobject.c:856
>        sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
>        kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
>        call_write_iter include/linux/fs.h:2163 [inline]
>        do_iter_readv_writev+0x472/0x750 fs/read_write.c:729
>        do_iter_write+0x188/0x710 fs/read_write.c:855
>        vfs_iter_write+0x70/0xa0 fs/read_write.c:896
>        iter_file_splice_write+0x723/0xc70 fs/splice.c:689
>        do_splice_from fs/splice.c:767 [inline]
>        direct_splice_actor+0x110/0x180 fs/splice.c:936
>        splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
>        do_splice_direct+0x1b3/0x280 fs/splice.c:979
>        do_sendfile+0xae9/0x1240 fs/read_write.c:1249
>        __do_sys_sendfile64 fs/read_write.c:1314 [inline]
>        __se_sys_sendfile64 fs/read_write.c:1300 [inline]
>        __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #8 (&of->mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:596 [inline]
>        __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
>        kernfs_seq_start+0x4b/0x260 fs/kernfs/file.c:112
>        seq_read_iter+0x2c7/0x1240 fs/seq_file.c:225
>        kernfs_fop_read_iter+0x44f/0x5f0 fs/kernfs/file.c:241
>        call_read_iter include/linux/fs.h:2157 [inline]
>        new_sync_read+0x421/0x6e0 fs/read_write.c:404
>        vfs_read+0x35c/0x600 fs/read_write.c:485
>        ksys_read+0x12d/0x250 fs/read_write.c:623
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #7 (&p->lock){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:596 [inline]
>        __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
>        seq_read_iter+0xdf/0x1240 fs/seq_file.c:182
>        call_read_iter include/linux/fs.h:2157 [inline]
>        generic_file_splice_read+0x453/0x6d0 fs/splice.c:311
>        do_splice_to+0x1bf/0x250 fs/splice.c:796
>        splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
>        do_splice_direct+0x1b3/0x280 fs/splice.c:979
>        do_sendfile+0xae9/0x1240 fs/read_write.c:1249
>        __do_sys_sendfile64 fs/read_write.c:1314 [inline]
>        __se_sys_sendfile64 fs/read_write.c:1300 [inline]
>        __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #6 (sb_writers#3){.+.+}-{0:0}:
>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>        __sb_start_write include/linux/fs.h:1812 [inline]
>        sb_start_write include/linux/fs.h:1882 [inline]
>        file_start_write include/linux/fs.h:3008 [inline]
>        lo_write_bvec+0x3b6/0x6d0 drivers/block/loop.c:327
>        lo_write_simple drivers/block/loop.c:350 [inline]
>        do_req_filebacked drivers/block/loop.c:668 [inline]
>        loop_handle_cmd drivers/block/loop.c:2201 [inline]
>        loop_process_work+0xc60/0x24e0 drivers/block/loop.c:2241
>        process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
>        worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
>        kthread+0x3e5/0x4d0 kernel/kthread.c:319
>        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> 
> -> #5 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
>        process_one_work+0x92e/0x16b0 kernel/workqueue.c:2273
>        worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
>        kthread+0x3e5/0x4d0 kernel/kthread.c:319
>        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> 
> -> #4 ((wq_completion)loop3){+.+.}-{0:0}:
>        flush_workqueue+0x110/0x15b0 kernel/workqueue.c:2817
>        drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2982
>        destroy_workqueue+0x71/0x800 kernel/workqueue.c:4419
>        __loop_clr_fd+0x212/0x15e0 drivers/block/loop.c:1368
>        lo_release+0x1ac/0x1f0 drivers/block/loop.c:2068
>        blkdev_put_whole block/bdev.c:691 [inline]
>        blkdev_put+0x2fb/0x9e0 block/bdev.c:953
>        blkdev_close+0x8d/0xb0 block/fops.c:459
>        __fput+0x288/0x9f0 fs/file_table.c:280
>        task_work_run+0xdd/0x1a0 kernel/task_work.c:164
>        tracehook_notify_resume include/linux/tracehook.h:189 [inline]
>        exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
>        exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
>        __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>        syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
>        do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #3 (&lo->lo_mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:596 [inline]
>        __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
>        lo_open+0x75/0x120 drivers/block/loop.c:2040
>        blkdev_get_whole+0x99/0x2a0 block/bdev.c:668
>        blkdev_get_by_dev.part.0+0x354/0xb60 block/bdev.c:823
>        blkdev_get_by_dev+0x6b/0x80 block/bdev.c:856
>        blkdev_open+0x154/0x2b0 block/fops.c:447
>        do_dentry_open+0x4c8/0x11d0 fs/open.c:822
>        do_open fs/namei.c:3428 [inline]
>        path_openat+0x1c9a/0x2740 fs/namei.c:3561
>        do_filp_open+0x1aa/0x400 fs/namei.c:3588
>        do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
>        do_sys_open fs/open.c:1216 [inline]
>        __do_sys_open fs/open.c:1224 [inline]
>        __se_sys_open fs/open.c:1220 [inline]
>        __x64_sys_open+0x119/0x1c0 fs/open.c:1220
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #2 (&disk->open_mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:596 [inline]
>        __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
>        bd_register_pending_holders+0x2c/0x470 block/holder.c:160
>        device_add_disk+0x74c/0xfc0 block/genhd.c:475
>        add_disk include/linux/genhd.h:221 [inline]
>        brd_alloc+0x466/0x660 drivers/block/brd.c:413
>        brd_init+0x16f/0x276 drivers/block/brd.c:496
>        do_one_initcall+0x103/0x650 init/main.c:1303
>        do_initcall_level init/main.c:1376 [inline]
>        do_initcalls init/main.c:1392 [inline]
>        do_basic_setup init/main.c:1411 [inline]
>        kernel_init_freeable+0x6b1/0x73a init/main.c:1614
>        kernel_init+0x1a/0x1d0 init/main.c:1505
>        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> 
> -> #1 (brd_devices_mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:596 [inline]
>        __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
>        brd_probe+0x31/0xe0 drivers/block/brd.c:428
>        blk_request_module+0x111/0x1d0 block/genhd.c:637
>        blkdev_get_no_open+0x178/0x1e0 block/bdev.c:739
>        blkdev_get_by_dev.part.0+0x22/0xb60 block/bdev.c:803
>        blkdev_get_by_dev+0x6b/0x80 block/bdev.c:856
>        blkdev_open+0x154/0x2b0 block/fops.c:447
>        do_dentry_open+0x4c8/0x11d0 fs/open.c:822
>        do_open fs/namei.c:3428 [inline]
>        path_openat+0x1c9a/0x2740 fs/namei.c:3561
>        do_filp_open+0x1aa/0x400 fs/namei.c:3588
>        do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
>        do_sys_open fs/open.c:1216 [inline]
>        __do_sys_openat fs/open.c:1232 [inline]
>        __se_sys_openat fs/open.c:1227 [inline]
>        __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #0 (major_names_lock){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3051 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3174 [inline]
>        validate_chain kernel/locking/lockdep.c:3789 [inline]
>        __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
>        lock_acquire kernel/locking/lockdep.c:5625 [inline]
>        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
>        __mutex_lock_common kernel/locking/mutex.c:596 [inline]
>        __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
>        blk_request_module+0x25/0x1d0 block/genhd.c:634
>        blkdev_get_no_open+0x178/0x1e0 block/bdev.c:739
>        blkdev_get_by_dev.part.0+0x22/0xb60 block/bdev.c:803
>        blkdev_get_by_dev+0x6b/0x80 block/bdev.c:856
>        swsusp_check+0x4d/0x270 kernel/power/swap.c:1525
>        software_resume.part.0+0x102/0x1f0 kernel/power/hibernate.c:977
>        software_resume kernel/power/hibernate.c:86 [inline]
>        resume_store+0x161/0x190 kernel/power/hibernate.c:1179
>        kobj_attr_store+0x50/0x80 lib/kobject.c:856
>        sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
>        kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
>        call_write_iter include/linux/fs.h:2163 [inline]
>        do_iter_readv_writev+0x472/0x750 fs/read_write.c:729
>        do_iter_write+0x188/0x710 fs/read_write.c:855
>        vfs_iter_write+0x70/0xa0 fs/read_write.c:896
>        iter_file_splice_write+0x723/0xc70 fs/splice.c:689
>        do_splice_from fs/splice.c:767 [inline]
>        direct_splice_actor+0x110/0x180 fs/splice.c:936
>        splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
>        do_splice_direct+0x1b3/0x280 fs/splice.c:979
>        do_sendfile+0xae9/0x1240 fs/read_write.c:1249
>        __do_sys_sendfile64 fs/read_write.c:1314 [inline]
>        __se_sys_sendfile64 fs/read_write.c:1300 [inline]
>        __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   major_names_lock --> &of->mutex --> system_transition_mutex/1
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(system_transition_mutex/1);
>                                lock(&of->mutex);
>                                lock(system_transition_mutex/1);
>   lock(major_names_lock);
> 
>  *** DEADLOCK ***
> 
> 4 locks held by syz-executor.3/12106:
>  #0: ffff88807ec32460 (sb_writers#6){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1314 [inline]
>  #0: ffff88807ec32460 (sb_writers#6){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1300 [inline]
>  #0: ffff88807ec32460 (sb_writers#6){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
>  #1: ffff888075c42088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x287/0x500 fs/kernfs/file.c:287
>  #2: ffff888015db0830 (kn->active#594){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ab/0x500 fs/kernfs/file.c:288
>  #3: ffffffff8b84fda8 (system_transition_mutex/1){+.+.}-{3:3}, at: software_resume.part.0+0x19/0x1f0 kernel/power/hibernate.c:932
> 
> stack backtrace:
> CPU: 1 PID: 12106 Comm: syz-executor.3 Not tainted 5.15.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2131
>  check_prev_add kernel/locking/lockdep.c:3051 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3174 [inline]
>  validate_chain kernel/locking/lockdep.c:3789 [inline]
>  __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
>  lock_acquire kernel/locking/lockdep.c:5625 [inline]
>  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
>  __mutex_lock_common kernel/locking/mutex.c:596 [inline]
>  __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
>  blk_request_module+0x25/0x1d0 block/genhd.c:634
>  blkdev_get_no_open+0x178/0x1e0 block/bdev.c:739
>  blkdev_get_by_dev.part.0+0x22/0xb60 block/bdev.c:803
>  blkdev_get_by_dev+0x6b/0x80 block/bdev.c:856
>  swsusp_check+0x4d/0x270 kernel/power/swap.c:1525
>  software_resume.part.0+0x102/0x1f0 kernel/power/hibernate.c:977
>  software_resume kernel/power/hibernate.c:86 [inline]
>  resume_store+0x161/0x190 kernel/power/hibernate.c:1179
>  kobj_attr_store+0x50/0x80 lib/kobject.c:856
>  sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
>  kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
>  call_write_iter include/linux/fs.h:2163 [inline]
>  do_iter_readv_writev+0x472/0x750 fs/read_write.c:729
>  do_iter_write+0x188/0x710 fs/read_write.c:855
>  vfs_iter_write+0x70/0xa0 fs/read_write.c:896
>  iter_file_splice_write+0x723/0xc70 fs/splice.c:689
>  do_splice_from fs/splice.c:767 [inline]
>  direct_splice_actor+0x110/0x180 fs/splice.c:936
>  splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
>  do_splice_direct+0x1b3/0x280 fs/splice.c:979
>  do_sendfile+0xae9/0x1240 fs/read_write.c:1249
>  __do_sys_sendfile64 fs/read_write.c:1314 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1300 [inline]
>  __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f74925ad739
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f748fb24188 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007f74926b1f80 RCX: 00007f74925ad739
> RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000004
> RBP: 00007f7492607cc4 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000000c R11: 0000000000000246 R12: 00007f74926b1f80
> R13: 00007fff0a996b3f R14: 00007f748fb24300 R15: 0000000000022000
> PM: Image not found (code -6)
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 

