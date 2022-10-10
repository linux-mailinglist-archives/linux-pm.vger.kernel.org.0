Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F555F9875
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 08:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiJJGnO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 02:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJJGnN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 02:43:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A514DB4A
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 23:43:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b2so9541510plc.7
        for <linux-pm@vger.kernel.org>; Sun, 09 Oct 2022 23:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dChD4EhiLuIwEWm7qEl8/Ih0FpVMr7QHqXLEYDXKsg=;
        b=gpTRugq7dPLmWMMzuApv4NNJ3LrM1tz+bN7ObOu7KR5s3lecrDd3TYhpWugdD6RNvY
         5MDZAy7AP9MpyodSobSw2XClQ4P+gBsy1xVo7DgDBPYkTSGsvUcYEtd9oDm2QW9Y0+6x
         zKILYsfAMj+14/yOV5rJr6/8l/lmCMd4kCJHsF75yx+/qKWGutNQ9fvsdRDtXRDTuWQ5
         6/AEynwmo6cuWDoZFFwS/QEB7yO9bMsh7lC1Cw/bnr5S5kOVjewSyFUdEIRz8/4tNxz5
         uZG60iHmjx+pVJM3vbQQSYxAO5KAa0gwgR1RpUg0syBK7CoiwIAfYRQKHigvc61TgU0d
         upaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dChD4EhiLuIwEWm7qEl8/Ih0FpVMr7QHqXLEYDXKsg=;
        b=zIYhTMcxpIrG2q1oC2R/6A/nW8hHy32sxxtksd/1jrrm1o20ukyfAj69cAc3AdwUvC
         xzoP8cZlP3edCqBkonZz+JAIs3RQTlmlVzlWpfXKuccDhIvD5QlE09NN21Ij8useoBv6
         FqjRRpCSnW3WTe7CLuaLF4m9+foZtFtrOehRCViGcd/u+i//YrYbgU1iZvgKqA1AqLDJ
         /qoA96IW0YYmWhZkhuZgYr+fkhxPYyUE/LGKkNciy6ZHX+wkgy9jrQHoUql/aGdGWz4f
         5X33/UQI2taloWG+H5WxpyRdU9KsWbxnxJ42ln/qxfbjrq8VSf0ihu6/Oe1pRCEteApZ
         Lx9w==
X-Gm-Message-State: ACrzQf1PAGITPTGGwnGvS7EvAJboNtKS9gA5hrME4vQk6rbITDtqUI4H
        lh2HzOduCLSnfbeRCjqyN2G+ug==
X-Google-Smtp-Source: AMsMyM7BUzadflPqRrD+dp6myfwUbLtWjJr1N0erRPYEccPMc90RYB+weMD8CVK4H4UkHjt7UgiJPw==
X-Received: by 2002:a17:902:f78c:b0:17a:ef1:e902 with SMTP id q12-20020a170902f78c00b0017a0ef1e902mr17505534pln.5.1665384192084;
        Sun, 09 Oct 2022 23:43:12 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id a5-20020a63e405000000b00462ae17a1c4sm875031pgi.33.2022.10.09.23.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 23:43:11 -0700 (PDT)
Date:   Mon, 10 Oct 2022 12:13:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: powernow-k8 lockdep warning with 6.0.0-rc#
Message-ID: <20221010064309.gr6hwok5ohqneczf@vireshk-i7>
References: <dada2033-1db5-4205-319b-0308dbccd3b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dada2033-1db5-4205-319b-0308dbccd3b5@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry for the late reply.

On 08-09-22, 21:32, Hans de Goede wrote:
> Because of the backlight refactoring work which I have been doing
> I have been testing the latest kernel on some pretty old hw,
> including a MSI S270 laptop with a single core Turion amd64
> processor.
> 
> When the powernow-k8 driver loads on this laptop it triggers
> the following lockdep warning:
> 
> [   81.371376] ======================================================
> [   81.371376] WARNING: possible circular locking dependency detected
> [   81.371376] 6.0.0-rc3+ #112 Tainted: G            E     
> [   81.371376] ------------------------------------------------------
> [   81.371376] sugov:0/554 is trying to acquire lock:
> [   81.371376] ffffa865c17cbe00 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: __flush_work+0x2f4/0x460
> [   81.371376] 
>                but task is already holding lock:
> [   81.371376] ffff9a88858ad528 (&sg_policy->work_lock){+.+.}-{3:3}, at: sugov_work+0x3c/0x60
> [   81.371376] 
>                which lock already depends on the new lock.
> 
> [   81.371376] 
>                the existing dependency chain (in reverse order) is:
> [   81.371376] 
>                -> #4 (&sg_policy->work_lock){+.+.}-{3:3}:
> [   81.371376]        __mutex_lock+0x93/0x7e0
> [   81.371376]        sugov_limits+0x3a/0x90
> [   81.371376]        cpufreq_start_governor+0x69/0xb0
> [   81.371376]        cpufreq_set_policy+0x4ac/0x610
> [   81.371376]        cpufreq_online+0x2c6/0xa80
> [   81.371376]        cpufreq_add_dev+0x77/0x90
> [   81.371376]        subsys_interface_register+0x138/0x150
> [   81.371376]        cpufreq_register_driver+0x161/0x2c0
> [   81.371376]        powernowk8_init+0xb5/0x177 [powernow_k8]
> [   81.371376]        do_one_initcall+0x5d/0x300
> [   81.371376]        do_init_module+0x4a/0x1f0
> [   81.371376]        __do_sys_init_module+0x16a/0x1a0
> [   81.371376]        do_syscall_64+0x5b/0x80
> [   81.371376]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   81.371376] 
>                -> #3 (&policy->rwsem){+.+.}-{3:3}:
> [   81.371376]        down_write+0x3b/0x70
> [   81.371376]        cpufreq_online+0x51b/0xa80
> [   81.371376]        cpufreq_add_dev+0x77/0x90
> [   81.371376]        subsys_interface_register+0x138/0x150
> [   81.371376]        cpufreq_register_driver+0x161/0x2c0
> [   81.371376]        k8temp_probe+0x149/0x1ef [k8temp]
> [   81.371376]        do_one_initcall+0x5d/0x300
> [   81.371376]        do_init_module+0x4a/0x1f0
> [   81.371376]        __do_sys_init_module+0x16a/0x1a0
> [   81.371376]        do_syscall_64+0x5b/0x80
> [   81.371376]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   81.371376] 
>                -> #2 (subsys mutex#8){+.+.}-{3:3}:
> [   81.371376]        __mutex_lock+0x93/0x7e0
> [   81.371376]        subsys_interface_register+0x63/0x150
> [   81.371376]        cpufreq_register_driver+0x161/0x2c0
> [   81.371376]        k8temp_probe+0x149/0x1ef [k8temp]
> [   81.371376]        do_one_initcall+0x5d/0x300
> [   81.371376]        do_init_module+0x4a/0x1f0
> [   81.371376]        __do_sys_init_module+0x16a/0x1a0
> [   81.371376]        do_syscall_64+0x5b/0x80
> [   81.371376]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   81.371376] 
>                -> #1 (cpu_hotplug_lock){++++}-{0:0}:
> [   81.371376]        cpus_read_lock+0x3c/0xd0
> [   81.371376]        alloc_workqueue+0x38d/0x4c0
> [   81.371376]        scsi_host_alloc+0x367/0x3c0
> [   81.371376]        ata_scsi_add_hosts+0xba/0x130
> [   81.371376]        ata_host_register+0x11e/0x1a0
> [   81.371376]        ata_pci_sff_activate_host+0x7e/0x240
> [   81.371376]        ata_pci_init_one+0x137/0x160
> [   81.371376]        atiixp_init_one+0x45/0x50 [pata_atiixp]
> [   81.371376]        local_pci_probe+0x41/0x80
> [   81.371376]        work_for_cpu_fn+0x16/0x20
> [   81.371376]        process_one_work+0x257/0x570
> [   81.371376]        worker_thread+0x4f/0x3a0
> [   81.371376]        kthread+0xf5/0x120
> [   81.371376]        ret_from_fork+0x22/0x30
> [   81.371376] 
>                -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
> [   81.371376]        __lock_acquire+0x12e7/0x1fa0
> [   81.371376]        lock_acquire+0xbf/0x2b0
> [   81.371376]        __flush_work+0x31b/0x460
> [   81.371376]        work_on_cpu+0x8a/0xa0
> [   81.371376]        powernowk8_target+0x23/0x30 [powernow_k8]
> [   81.371376]        __cpufreq_driver_target+0x260/0x6d0
> [   81.371376]        sugov_work+0x4d/0x60
> [   81.371376]        kthread_worker_fn+0xda/0x3c0
> [   81.371376]        kthread+0xf5/0x120
> [   81.371376]        ret_from_fork+0x22/0x30
> [   81.371376] 
>                other info that might help us debug this:
> 
> [   81.371376] Chain exists of:
>                  (work_completion)(&wfc.work) --> &policy->rwsem --> &sg_policy->work_lock
> 
> [   81.371376]  Possible unsafe locking scenario:
> 
> [   81.371376]        CPU0                    CPU1
> [   81.371376]        ----                    ----
> [   81.371376]   lock(&sg_policy->work_lock);
> [   81.371376]                                lock(&policy->rwsem);
> [   81.371376]                                lock(&sg_policy->work_lock);
> [   81.371376]   lock((work_completion)(&wfc.work));
> [   81.371376] 
>                 *** DEADLOCK ***
> 
> [   81.371376] 1 lock held by sugov:0/554:
> [   81.371376]  #0: ffff9a88858ad528 (&sg_policy->work_lock){+.+.}-{3:3}, at: sugov_work+0x3c/0x60
> [   81.371376] 
>                stack backtrace:
> [   81.371376] CPU: 0 PID: 554 Comm: sugov:0 Tainted: G            E      6.0.0-rc3+ #112
> [   81.371376] Hardware name: MICRO-STAR INT'L CO.,LTD MS-1013, BIOS A1013AMS V4.30 01/09/2006
> [   81.371376] Call Trace:
> [   81.371376]  <TASK>
> [   81.371376]  dump_stack_lvl+0x5b/0x77
> [   81.371376]  check_noncircular+0xe2/0x110
> [   81.371376]  ? register_lock_class+0x38/0x480
> [   81.371376]  __lock_acquire+0x12e7/0x1fa0
> [   81.371376]  lock_acquire+0xbf/0x2b0
> [   81.371376]  ? __flush_work+0x2f4/0x460
> [   81.371376]  ? find_held_lock+0x2b/0x80
> [   81.371376]  __flush_work+0x31b/0x460
> [   81.371376]  ? __flush_work+0x2f4/0x460
> [   81.371376]  ? lock_is_held_type+0xe3/0x140
> [   81.371376]  ? queue_work_on+0x45/0x80
> [   81.371376]  ? queue_work_on+0x45/0x80
> [   81.371376]  ? lockdep_hardirqs_on+0x7d/0x100
> [   81.371376]  work_on_cpu+0x8a/0xa0
> [   81.371376]  ? __traceiter_workqueue_execute_end+0x50/0x50
> [   81.371376]  ? powernowk8_cpu_init+0xa30/0xa30 [powernow_k8]
> [   81.371376]  powernowk8_target+0x23/0x30 [powernow_k8]
> [   81.371376]  __cpufreq_driver_target+0x260/0x6d0
> [   81.371376]  ? _raw_spin_unlock_irqrestore+0x30/0x60
> [   81.371376]  ? kthread_worker_fn+0x145/0x3c0
> [   81.371376]  ? sugov_limits+0x90/0x90
> [   81.371376]  sugov_work+0x4d/0x60
> [   81.371376]  kthread_worker_fn+0xda/0x3c0
> [   81.371376]  ? kthread_create_worker_on_cpu+0x50/0x50
> [   81.371376]  kthread+0xf5/0x120
> [   81.371376]  ? kthread_complete_and_exit+0x20/0x20
> [   81.371376]  ret_from_fork+0x22/0x30
> [   81.371376]  </TASK>

I think this comes from the fact that the powernowk8_target()
schedules the update via a work item. But I don't understand why this
is getting reported here and what's the exact case where we can get
into a deadlock.

-- 
viresh
