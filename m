Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB9114428E
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 17:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgAUQzL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 11:55:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39161 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQzL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 11:55:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id z2so3206748oih.6;
        Tue, 21 Jan 2020 08:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOvmrPQfd4U+qe0npdLRSLPDRxtxwmXyCEJF2rCC57c=;
        b=aUxl7/f2Y7WmzIKKQfxr4ej+2RjkUStKIU4kvQVes/B7NkbmszbBOTJgdIT5831egG
         DSe5MIEWNhF131GVHqa8BOd149pxnFgyOZQLJQe3FgddWCtAI131nhIZnqLfNNY5eBqq
         k1mNEQwK+BwBxZs/dvZCrcCe8lUp5Dojw4APd/7mcBUYoJRYZq4RQM28f691wtrAtLhT
         4PXtgvPE7wpgxbBiHsTisSf12/iTj73V3c764gUcotjnIdZ4KDlqhF0wTxZBi9zoZ4vk
         jDii8kwmHiwcrLhaMhPJ2j/58RXhJnaBm8fi3fOq/ZCpOsj9K2wz8nEiCyCgXQyYeuJ3
         lIcg==
X-Gm-Message-State: APjAAAXDMG7a1CKZsznlJo6sl4McUtnTTwzCQB47F0UsxwBnms6YkwhN
        mJ4zrTjQ7mpB2vTqNOVHCJPFashrcZzrdt+KOH4hIj9Q
X-Google-Smtp-Source: APXvYqzxhaTNpRA+5QY5lrzk0qTtFHFllDefpDwTO21p0OhCoMM91mHZwlny6DTxv1uDaOC3GQXhW9wqrgPPbogY/54=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr3770244oiy.110.1579625710490;
 Tue, 21 Jan 2020 08:55:10 -0800 (PST)
MIME-Version: 1.0
References: <1579568452-27253-1-git-send-email-chanho.min@lge.com>
In-Reply-To: <1579568452-27253-1-git-send-email-chanho.min@lge.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Jan 2020 17:54:58 +0100
Message-ID: <CAJZ5v0hP4S3+8yNZkbWAUaQof_ikar+w3F8Li6zvPSJcKif3NQ@mail.gmail.com>
Subject: Re: [PATCH] PM / sleep: fix use-after-free on async resume
To:     Chanho Min <chanho.min@lge.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daewoong Kim <daewoong00.kim@lge.com>,
        Seokjoo Lee <seokjoo.lee@lge.com>,
        Lee Gunho <gunho.lee@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 21, 2020 at 2:31 AM Chanho Min <chanho.min@lge.com> wrote:
>
> Some device can be released during suspend (e.g. usb disconnection).
> But, Its child device still use dev->parent's lock in dpm_wait().
> It can be ocurred use-after-free as bellows. This is happened during
> usb resume in practice.

In that case the resume of the child is going to be carried out after
its parent has gone away, which is generally incorrect..

> device hierarchy: "1-1" <- "1-1:1.2" <- "ep83"
>
> <parent>                <child>
> device_resume("1-1:1.2")
> dpm_wait("1-1")
>                         device_resume("ep_83");
>                         dpm_wait("1-1:1.2");
>  usb_disconnect
>   put_device("1-1:1.2")
>
> put_device("1-1:1.2")
>  usb_release_interface
>  kfree(intf) <- "1-1:1.2"'s struct device is freed
>
>                          wait_for_common
>                          do {
>                          ...
>                          spin_lock_irq(&x->wait.lock); <- "1-1:1-2"'s lock
>                          } while (!x->done && timeout);
>
> This is call stack of the system hang caused by freed lock value in practice.
>
> Call trace:
> [<ffffffc000ef59a8>] _raw_spin_lock_irq+0x38/0x80
> [<ffffffc000ef2dac>] wait_for_common+0x12c/0x140
> [<ffffffc000ef2dd4>] wait_for_completion+0x14/0x20
> [<ffffffc000480c1c>] dpm_wait+0x5c/0xb0
> [<ffffffc0004813d8>] device_resume+0x78/0x320
> [<ffffffc000481ed4>] async_resume+0x24/0xe0
> [<ffffffc0000c671c>] async_run_entry_fn+0x54/0x158
> [<ffffffc0000bd720>] process_one_work+0x1e8/0x4b0
> [<ffffffc0000bdb10>] worker_thread+0x128/0x4b8
> [<ffffffc0000c3a14>] kthread+0x10c/0x110
> [<ffffffc00008ddd0>] ret_from_fork+0x10/0x40
>
> To prevent such use-after-free, dpm_wait_for_parent() keeps parent's reference
> using get/put_device even if it is disconnected.
>
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> Signed-off-by: Daewoong Kim <daewoong00.kim@lge.com>
> ---
>  drivers/base/power/main.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index f946511..95a7499 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -234,13 +234,29 @@ static void initcall_debug_report(struct device *dev, ktime_t calltime,
>   * @dev: Device to wait for.
>   * @async: If unset, wait only if the device's power.async_suspend flag is set.
>   */
> +static void _dpm_wait(struct device *dev, bool async)
> +{
> +       if (async || (pm_async_enabled && dev->power.async_suspend))
> +               wait_for_completion(&dev->power.completion);
> +}
> +
>  static void dpm_wait(struct device *dev, bool async)
>  {
>         if (!dev)
>                 return;
>
> -       if (async || (pm_async_enabled && dev->power.async_suspend))
> -               wait_for_completion(&dev->power.completion);
> +       _dpm_wait(dev, async);
> +}
> +
> +static void dpm_wait_for_parent(struct device *dev, bool async)
> +{
> +       if (dev && dev->parent) {
> +               struct device *dev_p = dev->parent;
> +

This is racy, because the parent may have gone away already before the
get_device() below.

> +               get_device(dev_p);
> +               _dpm_wait(dev_p, async);
> +               put_device(dev_p);
> +       }
>  }
>
>  static int dpm_wait_fn(struct device *dev, void *async_ptr)
> @@ -277,7 +293,7 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
>
>  static void dpm_wait_for_superior(struct device *dev, bool async)
>  {
> -       dpm_wait(dev->parent, async);
> +       dpm_wait_for_parent(dev, async);
>         dpm_wait_for_suppliers(dev, async);
>  }
>
> --

Something a bit more sophisticated is needed here, let me think about that.
