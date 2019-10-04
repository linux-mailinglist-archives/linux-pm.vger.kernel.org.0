Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA90CBB97
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbfJDNWa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 09:22:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34741 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbfJDNWa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 09:22:30 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so13532440ion.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LEJ9dg5xbbVV3C3q2sRRPp0B1uzrgFWed1hhJkYm69Y=;
        b=vUmqqKfe0iMgqQT1tBxf5L1Tzjr/8LsPzYoTRi5HnnZQi6OPLN+MSrqfkvxFB+KJ8g
         J9TSTshM2pCNFHqUrXr7VWcEaqbB0zClY5hRVcYS7c2VS3XzldzVcvDZUD/4jUzEglN1
         L3MxWuOxvJNCHRVQv2ut5Dp0i++aZiOmqPOxf6g80n4QyQWCc9NDVP195xFSbZmFsSw5
         qSC6svrQG+aRjdCg3/AzDyeO2ufS+lVeOTC8evuIySD7T9s0N44Vh8tGGxGKbex5JbSN
         xA3mBb26Yj7FdvVCNxGaldGhi0xovY9K+VXUkqFx9sFpxVxMOY6Fln1oLJIdiGCqg6vZ
         VCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEJ9dg5xbbVV3C3q2sRRPp0B1uzrgFWed1hhJkYm69Y=;
        b=Ld1xqJtB4RyeCk6HvaemNTYa0xmwPZYBl7VQo8RZuCvgQw89B1nr9nnohheJUiKZ0u
         BssLWZGSdU6FFryL744M8H92SYlpwzFlGv6+6yRhaBzIK/2vm2S8OUfIl1TjTBiXWTwR
         ad/+BROf5QqhOtFsBzhVOtVBqbBqW/c6icU2oqyK8nGkZhECnBD3gBWne/wB7MTH42Km
         lMI389DJXoZROSP6hH0Hx11w7+AcmqSCZKbLIF92ygPOCvz0LYq8LbUpDb/eCMG8s2vW
         V3hI89W4NYcVda3KEXqvkrDM8CwgfUOrAFN92S1H6AhH+SrQZFqFKhVXsxyJ8C2BApJ6
         71Ag==
X-Gm-Message-State: APjAAAU2nSCE5G8Hsvj0+Qj68M4yvwC0GZwfFnb/KCORpH/yKGDkY535
        nGGI8Mc/jg/HLzIfvgn7dX0ViOeR8Ac4rw==
X-Google-Smtp-Source: APXvYqwQrXsm+JA/LtxH6GpCLZs4bFRPqRu7If4SldN0S4B5xsUwRTuxEufarPrQTL32YciKOaVH/Q==
X-Received: by 2002:a02:7f49:: with SMTP id r70mr14623123jac.85.1570195347722;
        Fri, 04 Oct 2019 06:22:27 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c65sm3169547ilg.26.2019.10.04.06.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:22:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] bdi: Do not use freezable workqueue
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Jan Kara <jack@suse.cz>,
        Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        AceLan Kao <acelan.kao@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20191004100025.70798-1-mika.westerberg@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0002b2f3-d17c-0d49-52f4-b2ce31832e6c@kernel.dk>
Date:   Fri, 4 Oct 2019 07:22:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004100025.70798-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/4/19 4:00 AM, Mika Westerberg wrote:
> A removable block device, such as NVMe or SSD connected over Thunderbolt
> can be hot-removed any time including when the system is suspended. When
> device is hot-removed during suspend and the system gets resumed, kernel
> first resumes devices and then thaws the userspace including freezable
> workqueues. What happens in that case is that the NVMe driver notices
> that the device is unplugged and removes it from the system. This ends
> up calling bdi_unregister() for the gendisk which then schedules
> wb_workfn() to be run one more time.
> 
> However, since the bdi_wq is still frozen flush_delayed_work() call in
> wb_shutdown() blocks forever halting system resume process. User sees
> this as hang as nothing is happening anymore.
> 
> Triggering sysrq-w reveals this:
> 
>    Workqueue: nvme-wq nvme_remove_dead_ctrl_work [nvme]
>    Call Trace:
>     ? __schedule+0x2c5/0x630
>     ? wait_for_completion+0xa4/0x120
>     schedule+0x3e/0xc0
>     schedule_timeout+0x1c9/0x320
>     ? resched_curr+0x1f/0xd0
>     ? wait_for_completion+0xa4/0x120
>     wait_for_completion+0xc3/0x120
>     ? wake_up_q+0x60/0x60
>     __flush_work+0x131/0x1e0
>     ? flush_workqueue_prep_pwqs+0x130/0x130
>     bdi_unregister+0xb9/0x130
>     del_gendisk+0x2d2/0x2e0
>     nvme_ns_remove+0xed/0x110 [nvme_core]
>     nvme_remove_namespaces+0x96/0xd0 [nvme_core]
>     nvme_remove+0x5b/0x160 [nvme]
>     pci_device_remove+0x36/0x90
>     device_release_driver_internal+0xdf/0x1c0
>     nvme_remove_dead_ctrl_work+0x14/0x30 [nvme]
>     process_one_work+0x1c2/0x3f0
>     worker_thread+0x48/0x3e0
>     kthread+0x100/0x140
>     ? current_work+0x30/0x30
>     ? kthread_park+0x80/0x80
>     ret_from_fork+0x35/0x40
> 
> This is not limited to NVMes so exactly same issue can be reproduced by
> hot-removing SSD (over Thunderbolt) while the system is suspended.
> 
> Prevent this from happening by removing WQ_FREEZABLE from bdi_wq.

This series looks good for me, I don't think there's a reason for
the workers to be marked freezable.

-- 
Jens Axboe

