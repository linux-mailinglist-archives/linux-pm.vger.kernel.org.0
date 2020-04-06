Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41319FE56
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 21:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgDFTpa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 15:45:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40218 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTpa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 15:45:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id y71so14192984oia.7;
        Mon, 06 Apr 2020 12:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1RzRkQXbJmYiaNrArg47G4F7EhjksiR5+/JZ9JGZAA=;
        b=ZTf9mhAYlpTqIAsWcka9DZuwrlSQnZ0gncKnXX0J8AuSq4FR5vZqnaFsvSigK5Og7L
         j/aGT9Yinui37M5/6tlb9yDiQ6nNtWqKgxrPjWVxQnDUgnDSEotv62L5VVrAmYXpLagC
         e5ivb82SuMqXQbC+BvY3WxFoRRpe2GmYw4u53gO5O3nk8PTzyowizlC3jzFvu79E1M0K
         QmjJ29oJ21lZiZT030a8WA2XWFQgLexD0aCi4Dk7aopMz2uACCXRjuX/04Jf6/bVS9zQ
         5rLmJXSAsduvjTuI5xkO84hKto/z4jYaufLHS702CgSnVevq3N5LK5hY8ARG+Jez4EgZ
         XaMQ==
X-Gm-Message-State: AGi0PuaKiBMscF0Vck16uG6rlQ2RXt8FNaNC7iSPSCgZOn7Hkqs0XT3j
        h8PgIfqONldFxfYbwtO8mfuLwT9kWDB9AnZ8d3w=
X-Google-Smtp-Source: APiQypIXF0aIb3eq4HWU0gbBbL/a9JNbUJjx6T2W3EG4mDEG3nAtAAl0bmc65fjOqhva1jkfUKaBiTtCCVLf8c1z1rA=
X-Received: by 2002:aca:f07:: with SMTP id 7mr844131oip.68.1586202329136; Mon,
 06 Apr 2020 12:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200406115835.1150002-1-hch@lst.de> <20200406115835.1150002-3-hch@lst.de>
In-Reply-To: <20200406115835.1150002-3-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Apr 2020 21:45:17 +0200
Message-ID: <CAJZ5v0jqEWpdbXpDFRejWDqF-8ptEdzHKoDj40YkqYw9ZSN56w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / sleep: handle the compat case in snapshot_set_swap_area
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 6, 2020 at 1:58 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use in_compat_syscall to copy directly from the 32-bit ABI structure.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/power/user.c | 54 ++++++++++++++++++---------------------------
>  1 file changed, 22 insertions(+), 32 deletions(-)
>
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 0cb555f526e4..7959449765d9 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -196,28 +196,44 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
>         return res;
>  }
>
> +struct compat_resume_swap_area {
> +       compat_loff_t offset;
> +       u32 dev;
> +} __packed;
> +
>  static int snapshot_set_swap_area(struct snapshot_data *data,
>                 void __user *argp)
>  {
> -       struct resume_swap_area swap_area;
>         sector_t offset;
>         dev_t swdev;
>
>         if (swsusp_swap_in_use())
>                 return -EPERM;
> -       if (copy_from_user(&swap_area, argp, sizeof(swap_area)))
> -               return -EFAULT;
> +
> +       if (in_compat_syscall()) {
> +               struct compat_resume_swap_area swap_area;
> +
> +               if (copy_from_user(&swap_area, argp, sizeof(swap_area)))
> +                       return -EFAULT;
> +               swdev = new_decode_dev(swap_area.dev);
> +               offset = swap_area.offset;
> +       } else {
> +               struct resume_swap_area swap_area;
> +
> +               if (copy_from_user(&swap_area, argp, sizeof(swap_area)))
> +                       return -EFAULT;
> +               swdev = new_decode_dev(swap_area.dev);
> +               offset = swap_area.offset;
> +       }
>
>         /*
>          * User space encodes device types as two-byte values,
>          * so we need to recode them
>          */
> -       swdev = new_decode_dev(swap_area.dev);
>         if (!swdev) {
>                 data->swap = -1;
>                 return -EINVAL;
>         }
> -       offset = swap_area.offset;
>         data->swap = swap_type_of(swdev, offset, NULL);
>         if (data->swap < 0)
>                 return -ENODEV;
> @@ -394,12 +410,6 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
>  }
>
>  #ifdef CONFIG_COMPAT
> -
> -struct compat_resume_swap_area {
> -       compat_loff_t offset;
> -       u32 dev;
> -} __packed;
> -
>  static long
>  snapshot_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
> @@ -410,33 +420,13 @@ snapshot_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>         case SNAPSHOT_AVAIL_SWAP_SIZE:
>         case SNAPSHOT_ALLOC_SWAP_PAGE:
>         case SNAPSHOT_CREATE_IMAGE:
> +       case SNAPSHOT_SET_SWAP_AREA:
>                 return snapshot_ioctl(file, cmd,
>                                       (unsigned long) compat_ptr(arg));
> -
> -       case SNAPSHOT_SET_SWAP_AREA: {
> -               struct compat_resume_swap_area __user *u_swap_area =
> -                       compat_ptr(arg);
> -               struct resume_swap_area swap_area;
> -               mm_segment_t old_fs;
> -               int err;
> -
> -               err = get_user(swap_area.offset, &u_swap_area->offset);
> -               err |= get_user(swap_area.dev, &u_swap_area->dev);
> -               if (err)
> -                       return -EFAULT;
> -               old_fs = get_fs();
> -               set_fs(KERNEL_DS);
> -               err = snapshot_ioctl(file, SNAPSHOT_SET_SWAP_AREA,
> -                                    (unsigned long) &swap_area);
> -               set_fs(old_fs);
> -               return err;
> -       }
> -
>         default:
>                 return snapshot_ioctl(file, cmd, arg);
>         }
>  }
> -
>  #endif /* CONFIG_COMPAT */
>
>  static const struct file_operations snapshot_fops = {
> --

Applied along with the [1/2] as 5.7-rc material, thanks!
