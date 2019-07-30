Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC1EC7A088
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 07:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfG3Fqy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 01:46:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38944 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG3Fqx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 01:46:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so59031707otq.6;
        Mon, 29 Jul 2019 22:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMOUaXgENhw7c5CQJ0IlirbOeRGGcqxTZWNVzp5Nhn4=;
        b=eAcaiU13snkUCtWd2P4Bam8po4kmlLaZ92dQM2chr0Z7NtiXhIYj+j1LdY5rKHNKfw
         KCFHcRjbp6XsUKhy0M94CxPb8VAPsG62WXCQpDvoZ8DgI1ft6rRegaiGDjY7aZewF7E1
         Qih45PrTN2W2I0u9jCLrY7aSQ/SWDBraUVJ3/890MIzrE1IHT7lnBMXwW6P2skryKM46
         S9F7pNHyj+/G0G4dKhIRxO33xP611teS8eP8EUHpRY66Y9LFbcYMeDALxl3hjTjehhJR
         d81Aslnd093q6CQjC92GM4hyFKb1YSSWJSbRvNLYS2AWAtp9jihPEwAUy5M75nNgT7ov
         D/6w==
X-Gm-Message-State: APjAAAVaK6TYtw/u8gcPrehyUVQ+qbeo8frmOmYZoPBDyw4FUoy4yDdF
        LNVYkpE064FFDI5wlVxHLtmagOlBiJOkF37BsTw=
X-Google-Smtp-Source: APXvYqyQkcz5FVKAON64DOvc7wXyiLuBKR60JbdzyA2IBU7uWK8lBbuJl29z4ZCXSC8fjca86GPgJrAI8cGt9ZMrxuc=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr78953797otp.189.1564465612966;
 Mon, 29 Jul 2019 22:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190730024309.233728-1-trong@android.com>
In-Reply-To: <20190730024309.233728-1-trong@android.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jul 2019 07:46:44 +0200
Message-ID: <CAJZ5v0jJn=vHdYExbzwRAMsk=Ad5bhvOAvHEXe-FHOj2R4Gwig@mail.gmail.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
To:     Tri Vo <trong@android.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 30, 2019 at 4:45 AM Tri Vo <trong@android.com> wrote:
>
> Userspace can use wakeup_sources debugfs node to plot history of suspend
> blocking wakeup sources over device's boot cycle. This information can
> then be used (1) for power-specific bug reporting and (2) towards
> attributing battery consumption to specific processes over a period of
> time.
>
> However, debugfs doesn't have stable ABI. For this reason, create a
> 'struct device' to expose wakeup sources statistics in sysfs under
> /sys/class/wakeup/wakeup<ID>/*.
>
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Co-developed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Tri Vo <trong@android.com>
> Tested-by: Tri Vo <trong@android.com>
> Tested-by: Kalesh Singh <kaleshsingh@google.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-class-wakeup |  76 +++++++++
>  drivers/acpi/device_pm.c                     |   3 +-
>  drivers/base/power/Makefile                  |   2 +-
>  drivers/base/power/wakeup.c                  |  21 ++-
>  drivers/base/power/wakeup_stats.c            | 171 +++++++++++++++++++
>  fs/eventpoll.c                               |   4 +-
>  include/linux/pm_wakeup.h                    |  15 +-
>  kernel/power/autosleep.c                     |   2 +-
>  kernel/power/wakelock.c                      |  10 ++
>  kernel/time/alarmtimer.c                     |   2 +-
>  10 files changed, 294 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-wakeup
>  create mode 100644 drivers/base/power/wakeup_stats.c
>
> v2:
> - Updated Documentation/ABI/, as per Greg.
> - Removed locks in attribute functions, as per Greg.
> - Lifetimes of struct wakelock and struck wakeup_source are now different due to
>   the latter embedding a refcounted kobject. Changed it so that struct wakelock
>   only has a pointer to struct wakeup_source, instead of embedding it.
> - Added CONFIG_PM_SLEEP_STATS that enables/disables wakeup source statistics in
>   sysfs.
>
> v3:
> Changes by Greg:
> - Reworked code to use 'struct device' instead of raw kobjects.
> - Updated documentation file.
> - Only link wakeup_stats.o when CONFIG_PM_SLEEP_STATS is enabled.
> Changes by Tri:
> - Reverted changes to kernel/power/wakelock.c. 'struct device' hides kobject
>   operations. So no need to handle lifetimes in wakelock.c
>
> v4:
> - Added 'Co-developed-by:' and 'Tested-by:' fields to commit message.
> - Moved new documentation to a separate file
>   Documentation/ABI/testing/sysfs-class-wakeup, as per Greg.
> - Fixed copyright header in drivers/base/power/wakeup_stats.c, as per Greg.
>
> v5:
> - Removed CONFIG_PM_SLEEP_STATS
> - Used PTR_ERR_OR_ZERO instead of if(IS_ERR(...)) + PTR_ERR, reported by
>   kbuild test robot <lkp@intel.com>
> - Stephen reported that a call to device_init_wakeup() and writing 'enabled' to
>   that device's power/wakeup file results in multiple wakeup source being
>   allocated for that device.  Changed device_wakeup_enable() to check if device
>   wakeup was previously enabled.
> Changes by Stephen:
> - Changed stats location from /sys/class/wakeup/<name>/* to
>   /sys/class/wakeup/wakeup<ID>/*, where ID is an IDA-allocated integer. This
>   avoids name collisions in /sys/class/wakeup/ directory.
> - Added a "name" attribute to wakeup sources, and updated documentation.
> - Device registering the wakeup source is now the parent of the wakeup source.
>   Updated wakeup_source_register()'s signature and its callers accordingly.

And I really don't like these changes.  Especially having "wakeup"
twice in the path.

Couldn't you find a simpler way to avoid the name collisions?
