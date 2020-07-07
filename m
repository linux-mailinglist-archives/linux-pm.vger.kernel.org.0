Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6080217311
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 17:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgGGPyL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 11:54:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45775 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGPyL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 11:54:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id h1so12493127otq.12;
        Tue, 07 Jul 2020 08:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUWo+ABoGaY5YMN3ISixI5iI43FT2WEg9Sy5KiriC20=;
        b=oyqhDNALTNcyifuSOqgl8e5r6T/Q7DkTB1tC22wCUk3jXxMu7F0cFF+77mW413do+E
         pD4tOjynUZnDW5hMPmhyCauImweEivRIO0WuyU+6eZJOX33Kq3lUk1TAyZD5oWSYs+zM
         RehPsLBIMyKa+vLkHr3yZ1w6KplbFfuHc+itOAsgVfqBBRcALdAFtE25+rlM+GR5bPbb
         RMzkjoUjAKsbj8t1KAKgCuiyD4mu3zVSxd685sAhM6x2XX4qYGm/3LNcez4fmZ5f/67x
         Emu2hBVLPGX13wRQm1IAkNV4fCp+8NjxRhHVDjTN40OlqCz6k+Z71vsPYTZ/M8FFukMv
         zGZw==
X-Gm-Message-State: AOAM5320Rkh046dWjjys00ZPuRy5RHcRSHx+suOZPDeo5nhc5jNXQYgm
        StrK5TrM7BzQcgOfICtIHs2Kg9350D26r6CG+uE=
X-Google-Smtp-Source: ABdhPJx1Ku7oIoTGez7vzkNKzJzCy5ZHGH/LnBGgtx2DghCYvkbjHJdNWl4cNLuuFhtveS0OmaQjT7n0dYlzh/UIpRU=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr27979494ota.167.1594137250094;
 Tue, 07 Jul 2020 08:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200707154905.2763616-1-abhishekpandit@chromium.org> <20200707084857.v3.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
In-Reply-To: <20200707084857.v3.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jul 2020 17:53:59 +0200
Message-ID: <CAJZ5v0hCM12vkaCLeFVyFRNj7Qv3Hj0LhtcgseAW_++A91nKJw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 7, 2020 at 5:49 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Udev rules that depend on the power/wakeup attribute don't get triggered
> correctly if device_set_wakeup_capable is called after the device is
> created. This can happen for several reasons (driver sets wakeup after
> device is created, wakeup is changed on parent device, etc) and it seems
> reasonable to emit a changed event when adding or removing attributes on
> the device.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
> Changes in v3:
> - Simplified error handling
>
> Changes in v2:
> - Add newline at end of bt_dev_err
>
>  drivers/base/power/sysfs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 24d25cf8ab1487..04c82373c8f240 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* sysfs entries for device PM */
>  #include <linux/device.h>
> +#include <linux/kobject.h>
>  #include <linux/string.h>
>  #include <linux/export.h>
>  #include <linux/pm_qos.h>
> @@ -739,12 +740,18 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>
>  int wakeup_sysfs_add(struct device *dev)
>  {
> -       return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> +       int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> +
> +       if (ret)
> +               return ret;
> +
> +       return kobject_uevent(&dev->kobj, KOBJ_CHANGE);

Returning an error code here may be misleading, because the basic
operation (i.e. merging the attribute group) has succeeded already.

What about printing a message if kobject_uevent() returns an error and
returning 0 anyway?

>  }
>
>  void wakeup_sysfs_remove(struct device *dev)
>  {
>         sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> +       return kobject_uevent(&dev->kobj, KOBJ_CHANGE);

This is a void function, so it cannot return anything.

>  }
>
>  int pm_qos_sysfs_add_resume_latency(struct device *dev)
> --
