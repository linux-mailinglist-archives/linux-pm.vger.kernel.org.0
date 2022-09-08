Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31C05B26C3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Sep 2022 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiIHTdA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Sep 2022 15:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiIHTc7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2022 15:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E1EC5788
        for <linux-pm@vger.kernel.org>; Thu,  8 Sep 2022 12:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662665577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kbSJ3Ub6+7lmJNrhe2b4vzhr03pyzD4LxIswRWlrDCQ=;
        b=XQxFLGUQNJspQZwyJnJrU4/ViedbbaYhdc8tQjNEWqLWVH5Se3qP2QKO2NCCnk1eB8dgwg
        fyrJfXifgFSZ0nMXQ5VMtDS4JFsWhs/aFFgFvWMvc+c85jcQ4DwTldEhLfbyjl/Ci1YPaE
        vQxSOSrKkNKRrTZatHIJv/gJCoyp390=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-Yr3w2RzwNuGfP6bE3hcaDw-1; Thu, 08 Sep 2022 15:32:56 -0400
X-MC-Unique: Yr3w2RzwNuGfP6bE3hcaDw-1
Received: by mail-ej1-f72.google.com with SMTP id ds17-20020a170907725100b007419bfb5fd4so6809622ejc.4
        for <linux-pm@vger.kernel.org>; Thu, 08 Sep 2022 12:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=kbSJ3Ub6+7lmJNrhe2b4vzhr03pyzD4LxIswRWlrDCQ=;
        b=sFajt/rTaE3lpW/Oiqn++zc8mwEH6hy9PQH7RxbtRs1p4pvaNqjzTkDNyjGcv9cH1L
         ufqF9z4bXBJpGmknYHgv0KWHXQncW248FZJSFCKoPJNL/KXI+cbvFDeAX6N45aSm6EvD
         zNLUmFTqtYKLbWcKC9A0thFWmb72zzZAhyRwNEYGS7Jit74skgtLEoWT0JC0GkW5/3UY
         3YLv2sh+1EbhHfAwWc/BIPAqXasFOKQYHsIDcEAIr+lIzgQJjhby09yVoN31fdBepV3X
         quAJ0od6OaJG1HFEcWoRZV0ZCYMygZKJ/y3hmh6wjfi6fvrBax2fSqTy/8IWnLWkDI2W
         Eb0A==
X-Gm-Message-State: ACgBeo2/FxYrMkJV2Grdd4E1Y6CV6D8dzYbMeWK+Qc5eCGMVw8jnJQrn
        QViAx31AKOpA6MUGK6lC61EuCFxz1hSvgRmEOm3JzjkJAakFo2Zp2wfYz4qVER0gvoifyqezvTb
        vkHAv9KVDsDsBEYfrqcM=
X-Received: by 2002:aa7:c556:0:b0:44e:9c95:a9a4 with SMTP id s22-20020aa7c556000000b0044e9c95a9a4mr8549338edr.301.1662665575273;
        Thu, 08 Sep 2022 12:32:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4AvZockYvN5AJRgRMuc80Hj8WUnQ2vYTahdLC9bVwyDRX1AyGqYGnJKlpyK7spKPTM61OT+g==
X-Received: by 2002:aa7:c556:0:b0:44e:9c95:a9a4 with SMTP id s22-20020aa7c556000000b0044e9c95a9a4mr8549328edr.301.1662665575054;
        Thu, 08 Sep 2022 12:32:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id h18-20020a170906261200b0073dbc35a0desm1575978ejc.100.2022.09.08.12.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 12:32:54 -0700 (PDT)
Message-ID: <dada2033-1db5-4205-319b-0308dbccd3b5@redhat.com>
Date:   Thu, 8 Sep 2022 21:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: powernow-k8 lockdep warning with 6.0.0-rc#
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

Because of the backlight refactoring work which I have been doing
I have been testing the latest kernel on some pretty old hw,
including a MSI S270 laptop with a single core Turion amd64
processor.

When the powernow-k8 driver loads on this laptop it triggers
the following lockdep warning:

[   81.371376] ======================================================
[   81.371376] WARNING: possible circular locking dependency detected
[   81.371376] 6.0.0-rc3+ #112 Tainted: G            E     
[   81.371376] ------------------------------------------------------
[   81.371376] sugov:0/554 is trying to acquire lock:
[   81.371376] ffffa865c17cbe00 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: __flush_work+0x2f4/0x460
[   81.371376] 
               but task is already holding lock:
[   81.371376] ffff9a88858ad528 (&sg_policy->work_lock){+.+.}-{3:3}, at: sugov_work+0x3c/0x60
[   81.371376] 
               which lock already depends on the new lock.

[   81.371376] 
               the existing dependency chain (in reverse order) is:
[   81.371376] 
               -> #4 (&sg_policy->work_lock){+.+.}-{3:3}:
[   81.371376]        __mutex_lock+0x93/0x7e0
[   81.371376]        sugov_limits+0x3a/0x90
[   81.371376]        cpufreq_start_governor+0x69/0xb0
[   81.371376]        cpufreq_set_policy+0x4ac/0x610
[   81.371376]        cpufreq_online+0x2c6/0xa80
[   81.371376]        cpufreq_add_dev+0x77/0x90
[   81.371376]        subsys_interface_register+0x138/0x150
[   81.371376]        cpufreq_register_driver+0x161/0x2c0
[   81.371376]        powernowk8_init+0xb5/0x177 [powernow_k8]
[   81.371376]        do_one_initcall+0x5d/0x300
[   81.371376]        do_init_module+0x4a/0x1f0
[   81.371376]        __do_sys_init_module+0x16a/0x1a0
[   81.371376]        do_syscall_64+0x5b/0x80
[   81.371376]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   81.371376] 
               -> #3 (&policy->rwsem){+.+.}-{3:3}:
[   81.371376]        down_write+0x3b/0x70
[   81.371376]        cpufreq_online+0x51b/0xa80
[   81.371376]        cpufreq_add_dev+0x77/0x90
[   81.371376]        subsys_interface_register+0x138/0x150
[   81.371376]        cpufreq_register_driver+0x161/0x2c0
[   81.371376]        k8temp_probe+0x149/0x1ef [k8temp]
[   81.371376]        do_one_initcall+0x5d/0x300
[   81.371376]        do_init_module+0x4a/0x1f0
[   81.371376]        __do_sys_init_module+0x16a/0x1a0
[   81.371376]        do_syscall_64+0x5b/0x80
[   81.371376]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   81.371376] 
               -> #2 (subsys mutex#8){+.+.}-{3:3}:
[   81.371376]        __mutex_lock+0x93/0x7e0
[   81.371376]        subsys_interface_register+0x63/0x150
[   81.371376]        cpufreq_register_driver+0x161/0x2c0
[   81.371376]        k8temp_probe+0x149/0x1ef [k8temp]
[   81.371376]        do_one_initcall+0x5d/0x300
[   81.371376]        do_init_module+0x4a/0x1f0
[   81.371376]        __do_sys_init_module+0x16a/0x1a0
[   81.371376]        do_syscall_64+0x5b/0x80
[   81.371376]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   81.371376] 
               -> #1 (cpu_hotplug_lock){++++}-{0:0}:
[   81.371376]        cpus_read_lock+0x3c/0xd0
[   81.371376]        alloc_workqueue+0x38d/0x4c0
[   81.371376]        scsi_host_alloc+0x367/0x3c0
[   81.371376]        ata_scsi_add_hosts+0xba/0x130
[   81.371376]        ata_host_register+0x11e/0x1a0
[   81.371376]        ata_pci_sff_activate_host+0x7e/0x240
[   81.371376]        ata_pci_init_one+0x137/0x160
[   81.371376]        atiixp_init_one+0x45/0x50 [pata_atiixp]
[   81.371376]        local_pci_probe+0x41/0x80
[   81.371376]        work_for_cpu_fn+0x16/0x20
[   81.371376]        process_one_work+0x257/0x570
[   81.371376]        worker_thread+0x4f/0x3a0
[   81.371376]        kthread+0xf5/0x120
[   81.371376]        ret_from_fork+0x22/0x30
[   81.371376] 
               -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
[   81.371376]        __lock_acquire+0x12e7/0x1fa0
[   81.371376]        lock_acquire+0xbf/0x2b0
[   81.371376]        __flush_work+0x31b/0x460
[   81.371376]        work_on_cpu+0x8a/0xa0
[   81.371376]        powernowk8_target+0x23/0x30 [powernow_k8]
[   81.371376]        __cpufreq_driver_target+0x260/0x6d0
[   81.371376]        sugov_work+0x4d/0x60
[   81.371376]        kthread_worker_fn+0xda/0x3c0
[   81.371376]        kthread+0xf5/0x120
[   81.371376]        ret_from_fork+0x22/0x30
[   81.371376] 
               other info that might help us debug this:

[   81.371376] Chain exists of:
                 (work_completion)(&wfc.work) --> &policy->rwsem --> &sg_policy->work_lock

[   81.371376]  Possible unsafe locking scenario:

[   81.371376]        CPU0                    CPU1
[   81.371376]        ----                    ----
[   81.371376]   lock(&sg_policy->work_lock);
[   81.371376]                                lock(&policy->rwsem);
[   81.371376]                                lock(&sg_policy->work_lock);
[   81.371376]   lock((work_completion)(&wfc.work));
[   81.371376] 
                *** DEADLOCK ***

[   81.371376] 1 lock held by sugov:0/554:
[   81.371376]  #0: ffff9a88858ad528 (&sg_policy->work_lock){+.+.}-{3:3}, at: sugov_work+0x3c/0x60
[   81.371376] 
               stack backtrace:
[   81.371376] CPU: 0 PID: 554 Comm: sugov:0 Tainted: G            E      6.0.0-rc3+ #112
[   81.371376] Hardware name: MICRO-STAR INT'L CO.,LTD MS-1013, BIOS A1013AMS V4.30 01/09/2006
[   81.371376] Call Trace:
[   81.371376]  <TASK>
[   81.371376]  dump_stack_lvl+0x5b/0x77
[   81.371376]  check_noncircular+0xe2/0x110
[   81.371376]  ? register_lock_class+0x38/0x480
[   81.371376]  __lock_acquire+0x12e7/0x1fa0
[   81.371376]  lock_acquire+0xbf/0x2b0
[   81.371376]  ? __flush_work+0x2f4/0x460
[   81.371376]  ? find_held_lock+0x2b/0x80
[   81.371376]  __flush_work+0x31b/0x460
[   81.371376]  ? __flush_work+0x2f4/0x460
[   81.371376]  ? lock_is_held_type+0xe3/0x140
[   81.371376]  ? queue_work_on+0x45/0x80
[   81.371376]  ? queue_work_on+0x45/0x80
[   81.371376]  ? lockdep_hardirqs_on+0x7d/0x100
[   81.371376]  work_on_cpu+0x8a/0xa0
[   81.371376]  ? __traceiter_workqueue_execute_end+0x50/0x50
[   81.371376]  ? powernowk8_cpu_init+0xa30/0xa30 [powernow_k8]
[   81.371376]  powernowk8_target+0x23/0x30 [powernow_k8]
[   81.371376]  __cpufreq_driver_target+0x260/0x6d0
[   81.371376]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[   81.371376]  ? kthread_worker_fn+0x145/0x3c0
[   81.371376]  ? sugov_limits+0x90/0x90
[   81.371376]  sugov_work+0x4d/0x60
[   81.371376]  kthread_worker_fn+0xda/0x3c0
[   81.371376]  ? kthread_create_worker_on_cpu+0x50/0x50
[   81.371376]  kthread+0xf5/0x120
[   81.371376]  ? kthread_complete_and_exit+0x20/0x20
[   81.371376]  ret_from_fork+0x22/0x30
[   81.371376]  </TASK>


I would be more then happy to test any patches to try and resolve this.

Regards,

Hans


