Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BA19150D
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 16:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgCXPk2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 11:40:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43734 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbgCXPk2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 11:40:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id a6so17347217otb.10;
        Tue, 24 Mar 2020 08:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x91Gn6ctV7uAtmkacQ15CXSKd6r2ddccL8V3P9sMjNA=;
        b=pfMj7row9sTrv4thwk7KfT+caqwHdG3s0euotqjGzU/BWsPbKbqETn4/g4QA0SwOnw
         phHxte+faIoNTkFkvpxllaze69d464k7Q28h33EKHRCogupdQwfpGaWLbFFhwRLXUySN
         +K5MO+KB57qvUERrTle7Bbws7rUYWXvDhU80Lg5y8ORS9cAsCRhvYJ2QxIENESqS6d5W
         9xswU66yaQPNaEYHymbzuTa6lSWXSP/sG5FTqHuO7q//bZrSfe/RPOikCCf/eu3kxCPh
         33zwkZNI4fU9csqKcTLfCF9Ul7hQu2B0s1vtQSL/GLBeH1EVz7FWFwYardutuTFpaK4g
         xYmA==
X-Gm-Message-State: ANhLgQ13gTc1DZVMqob/dBWdpFQT5XWnWUgr2nMpzjh6OhsgltX8FIQ7
        JRQkI60XIz3iGjAVU+0fRjbRAlT5FLUSZPrslATkUA==
X-Google-Smtp-Source: ADFU+vtOOAmaA25O7ZsrbfelAo4/GiymbQ4narnzwPJk3U/bOgQJEAOi/z87tKAKA8y4280wJe3a3HGwWFYAk+n4Vj8=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr21308652otm.167.1585064427356;
 Tue, 24 Mar 2020 08:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200323181245.GJ4288@osiris>
In-Reply-To: <20200323181245.GJ4288@osiris>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Mar 2020 16:40:16 +0100
Message-ID: <CAJZ5v0hzf=kQBcR=K2KL1kEVtA6oLPtLDaeeaVuWMPsXomhJHw@mail.gmail.com>
Subject: Re: s390: removal of hibernate support
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, Mar 23, 2020 at 7:12 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> Hi Rafael,
>
> we are going to remove hibernate support on s390, since it is
> - broken since many years
> - there is no real use case which justifies keeping and maintaining
>   the code
>
> See also https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=394216275c7d503d966317da9a01ad6626a6091d
>
> This in turn allows also to remove s390 specific hooks in generic
> power management code (see patch below). The patch below is currently
> also on the same features branch.
> I silently assume(d) that you don't mind to get rid of otherwise dead
> code, or do you have any objections?
>
> From 086b2d78375cffe58f5341359bebec0650793811 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Wed, 18 Mar 2020 20:55:20 +0100
> Subject: [PATCH] PM: remove s390 specific callbacks
>
> ARCH_SAVE_PAGE_KEYS has been introduced in order to be able to save
> and restore s390 specific storage keys into a hibernation image.
> With hibernation support removed from s390 there is no point in
> keeping the callbacks.
>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Can I take this patch or would it be better to route it differently?

> ---
>  include/linux/suspend.h | 34 ----------------------------------
>  kernel/power/Kconfig    |  3 ---
>  kernel/power/snapshot.c | 18 ------------------
>  3 files changed, 55 deletions(-)
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 2b2055b035ee..4fcc6fd0cbd6 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -566,38 +566,4 @@ static inline void queue_up_suspend_work(void) {}
>
>  #endif /* !CONFIG_PM_AUTOSLEEP */
>
> -#ifdef CONFIG_ARCH_SAVE_PAGE_KEYS
> -/*
> - * The ARCH_SAVE_PAGE_KEYS functions can be used by an architecture
> - * to save/restore additional information to/from the array of page
> - * frame numbers in the hibernation image. For s390 this is used to
> - * save and restore the storage key for each page that is included
> - * in the hibernation image.
> - */
> -unsigned long page_key_additional_pages(unsigned long pages);
> -int page_key_alloc(unsigned long pages);
> -void page_key_free(void);
> -void page_key_read(unsigned long *pfn);
> -void page_key_memorize(unsigned long *pfn);
> -void page_key_write(void *address);
> -
> -#else /* !CONFIG_ARCH_SAVE_PAGE_KEYS */
> -
> -static inline unsigned long page_key_additional_pages(unsigned long pages)
> -{
> -       return 0;
> -}
> -
> -static inline int  page_key_alloc(unsigned long pages)
> -{
> -       return 0;
> -}
> -
> -static inline void page_key_free(void) {}
> -static inline void page_key_read(unsigned long *pfn) {}
> -static inline void page_key_memorize(unsigned long *pfn) {}
> -static inline void page_key_write(void *address) {}
> -
> -#endif /* !CONFIG_ARCH_SAVE_PAGE_KEYS */
> -
>  #endif /* _LINUX_SUSPEND_H */
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 7cbfbeacd68a..c208566c844b 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -80,9 +80,6 @@ config HIBERNATION
>
>           For more information take a look at <file:Documentation/power/swsusp.rst>.
>
> -config ARCH_SAVE_PAGE_KEYS
> -       bool
> -
>  config PM_STD_PARTITION
>         string "Default resume partition"
>         depends on HIBERNATION
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index ddade80ad276..e99d13b0b8fc 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1744,9 +1744,6 @@ int hibernate_preallocate_memory(void)
>         count += highmem;
>         count -= totalreserve_pages;
>
> -       /* Add number of pages required for page keys (s390 only). */
> -       size += page_key_additional_pages(saveable);
> -
>         /* Compute the maximum number of saveable pages to leave in memory. */
>         max_size = (count - (size + PAGES_FOR_IO)) / 2
>                         - 2 * DIV_ROUND_UP(reserved_size, PAGE_SIZE);
> @@ -2075,8 +2072,6 @@ static inline void pack_pfns(unsigned long *buf, struct memory_bitmap *bm)
>                 buf[j] = memory_bm_next_pfn(bm);
>                 if (unlikely(buf[j] == BM_END_OF_MAP))
>                         break;
> -               /* Save page key for data page (s390 only). */
> -               page_key_read(buf + j);
>         }
>  }
>
> @@ -2226,9 +2221,6 @@ static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
>                 if (unlikely(buf[j] == BM_END_OF_MAP))
>                         break;
>
> -               /* Extract and buffer page key for data page (s390 only). */
> -               page_key_memorize(buf + j);
> -
>                 if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j]))
>                         memory_bm_set_bit(bm, buf[j]);
>                 else
> @@ -2623,11 +2615,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
>                 if (error)
>                         return error;
>
> -               /* Allocate buffer for page keys. */
> -               error = page_key_alloc(nr_copy_pages);
> -               if (error)
> -                       return error;
> -
>                 hibernate_restore_protection_begin();
>         } else if (handle->cur <= nr_meta_pages + 1) {
>                 error = unpack_orig_pfns(buffer, &copy_bm);
> @@ -2649,8 +2636,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
>                 }
>         } else {
>                 copy_last_highmem_page();
> -               /* Restore page key for data page (s390 only). */
> -               page_key_write(handle->buffer);
>                 hibernate_restore_protect_page(handle->buffer);
>                 handle->buffer = get_buffer(&orig_bm, &ca);
>                 if (IS_ERR(handle->buffer))
> @@ -2673,9 +2658,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
>  void snapshot_write_finalize(struct snapshot_handle *handle)
>  {
>         copy_last_highmem_page();
> -       /* Restore page key for data page (s390 only). */
> -       page_key_write(handle->buffer);
> -       page_key_free();
>         hibernate_restore_protect_page(handle->buffer);
>         /* Do that only if we have loaded the image entirely */
>         if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages) {
> --
> 2.17.1
>
