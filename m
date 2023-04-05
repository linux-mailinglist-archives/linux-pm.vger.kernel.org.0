Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B88D6D861E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Apr 2023 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjDEShr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 5 Apr 2023 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDEShq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Apr 2023 14:37:46 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C0592;
        Wed,  5 Apr 2023 11:37:45 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-4fa3ca41384so626261a12.2;
        Wed, 05 Apr 2023 11:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680719864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQgrthbzkZSgbjXBIoNTxJNXLdPaAi1kAx3jHiOuJGY=;
        b=KdapSN8c786gGnmL0acpiCx31NMhVnewOWR1wlay5DNxOcXVdaYMvOl/UOwgazNfEk
         1EGlLKhHZIddi4TW/+xh5/fOong3d1VpHHAwnK3B1Wy6Zfu4uIReYSshHR+C8Km43G1I
         wMXWg4z/I3gCc7j5DUz468V7YioYigx1g3vK+JlK/ynazvuJZ/KLwh/oGr98PmwrNcbC
         lSGRJiDfckGgbia+oydsXacWv08eOgwxKOBuhkiOpXb2gFoSv0Veu7qiUgKYi57Iuld+
         qm+2nsVq17lGx+dSloaBhXc0cV2kgn14A0whZWYA9iT5nhnB7VWiz5BEmhsk1AGR7vRz
         rwCg==
X-Gm-Message-State: AAQBX9c763IdZNgsH1uaG7DhshB/lUt4rjocw4S/p43KqgNXzhzGeyac
        j+gRWHsWb6hx3e7V80Ig/4IKkJ6NDEwU/93XkVmSZHgo
X-Google-Smtp-Source: AKy350a3YWi1+xyCQ0womx+bhSyZFoXh9CVMP9FDFizW66fB8RzHzH7pvPsfMwsDewc0ab8sodEjNowy1l5LRg5RTvI=
X-Received: by 2002:a50:baeb:0:b0:4fc:ebe2:2fc9 with SMTP id
 x98-20020a50baeb000000b004fcebe22fc9mr1678581ede.3.1680719863770; Wed, 05 Apr
 2023 11:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230401165540.322665-1-yu.c.chen@intel.com>
In-Reply-To: <20230401165540.322665-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Apr 2023 20:37:32 +0200
Message-ID: <CAJZ5v0j704JoCPTrDO1jTHwP1+8NVdLk7hym5036uFcfo7YHXQ@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Do not get block device exclusively in
 test_resume mode
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yifan Li <yifan2.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Apr 1, 2023 at 10:59 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> The system refused to do a test_resume because it found that the
> swap device has already been taken by someone else. Specificly,
> the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
> do this check.
>
> Steps to reproduce:
>  dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo |
>        awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
>  mkswap /swapfile
>  swapon /swapfile
>  swap-offset /swapfile
>  echo 34816 > /sys/power/resume_offset
>  echo test_resume > /sys/power/disk
>  echo disk > /sys/power/state
>
>  PM: Using 3 thread(s) for compression
>  PM: Compressing and saving image data (293150 pages)...
>  PM: Image saving progress:   0%
>  PM: Image saving progress:  10%
>  ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  ata1.00: configured for UDMA/100
>  ata2: SATA link down (SStatus 0 SControl 300)
>  ata5: SATA link down (SStatus 0 SControl 300)
>  ata6: SATA link down (SStatus 0 SControl 300)
>  ata3: SATA link down (SStatus 0 SControl 300)
>  ata4: SATA link down (SStatus 0 SControl 300)
>  PM: Image saving progress:  20%
>  PM: Image saving progress:  30%
>  PM: Image saving progress:  40%
>  PM: Image saving progress:  50%
>  pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
>  PM: Image saving progress:  60%
>  PM: Image saving progress:  70%
>  PM: Image saving progress:  80%
>  PM: Image saving progress:  90%
>  PM: Image saving done
>  PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
>  PM: S|
>  PM: hibernation: Basic memory bitmaps freed
>  PM: Image not found (code -16)
>
> This is because when using the swapfile as the hibernation storage,
> the block device where the swapfile is located has already been mounted
> by the OS distribution(usually been mounted as the rootfs). This is not
> an issue for normal hibernation, because software_resume()->swsusp_check()
> happens before the block device(rootfs) mount. But it is a problem for the
> test_resume mode. Because when test_resume happens, the block device has
> been mounted already.
>
> Thus remove the FMODE_EXCL for test_resume mode. This would not be a
> problem because in test_resume stage, the processes have already been
> frozen, and the race condition described in
> Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> is unlikely to happen.
>
> Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> Reported-by: Yifan Li <yifan2.li@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/power/hibernate.c | 18 +++++++++++-------
>  kernel/power/power.h     |  2 +-
>  kernel/power/swap.c      | 10 +++++++---
>  3 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 793c55a2becb..f50456e72f0a 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -683,22 +683,26 @@ static void power_down(void)
>                 cpu_relax();
>  }
>
> -static int load_image_and_restore(void)
> +static int load_image_and_restore(bool safe)

It is not very clear why the argument is called "safe".

Either this needs to be explained in a comment, or I would just call
it "exclusive" and rework the checks accordingly.

>  {
> +       fmode_t mode = FMODE_READ;
>         int error;
>         unsigned int flags;
>
>         pm_pr_dbg("Loading hibernation image.\n");
>
> +       if (!safe)
> +               mode |= FMODE_EXCL;
> +
>         lock_device_hotplug();
>         error = create_basic_memory_bitmaps();
>         if (error) {
> -               swsusp_close(FMODE_READ | FMODE_EXCL);
> +               swsusp_close(mode);
>                 goto Unlock;
>         }
>
>         error = swsusp_read(&flags);
> -       swsusp_close(FMODE_READ | FMODE_EXCL);
> +       swsusp_close(mode);
>         if (!error)
>                 error = hibernation_restore(flags & SF_PLATFORM_MODE);
>
> @@ -785,9 +789,9 @@ int hibernate(void)
>         unlock_device_hotplug();
>         if (snapshot_test) {
>                 pm_pr_dbg("Checking hibernation image\n");
> -               error = swsusp_check();
> +               error = swsusp_check(true);
>                 if (!error)
> -                       error = load_image_and_restore();
> +                       error = load_image_and_restore(true);
>         }
>         thaw_processes();
>
> @@ -983,7 +987,7 @@ static int software_resume(void)
>                 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
>
>         pm_pr_dbg("Looking for hibernation image.\n");
> -       error = swsusp_check();
> +       error = swsusp_check(false);
>         if (error)
>                 goto Unlock;
>
> @@ -1011,7 +1015,7 @@ static int software_resume(void)
>                 goto Close_Finish;
>         }
>
> -       error = load_image_and_restore();
> +       error = load_image_and_restore(false);
>         thaw_processes();
>   Finish:
>         pm_notifier_call_chain(PM_POST_RESTORE);
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index b4f433943209..66a7595ad3e7 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -173,7 +173,7 @@ extern int swsusp_swap_in_use(void);
>  #define SF_HW_SIG              8
>
>  /* kernel/power/hibernate.c */
> -extern int swsusp_check(void);
> +extern int swsusp_check(bool safe);
>  extern void swsusp_free(void);
>  extern int swsusp_read(unsigned int *flags_p);
>  extern int swsusp_write(unsigned int flags);
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 36a1df48280c..1be0257da8ab 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1514,13 +1514,17 @@ int swsusp_read(unsigned int *flags_p)
>   *      swsusp_check - Check for swsusp signature in the resume device
>   */
>
> -int swsusp_check(void)
> +int swsusp_check(bool safe)

An analogous comment applies here.

>  {
> +       fmode_t mode = FMODE_READ;
>         int error;
>         void *holder;
>
> +       if (!safe)
> +               mode |= FMODE_EXCL;
> +
>         hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
> -                                           FMODE_READ | FMODE_EXCL, &holder);
> +                                           mode, &holder);
>         if (!IS_ERR(hib_resume_bdev)) {
>                 set_blocksize(hib_resume_bdev, PAGE_SIZE);
>                 clear_page(swsusp_header);
> @@ -1547,7 +1551,7 @@ int swsusp_check(void)
>
>  put:
>                 if (error)
> -                       blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
> +                       blkdev_put(hib_resume_bdev, mode);
>                 else
>                         pr_debug("Image signature found, resuming\n");
>         } else {
> --
