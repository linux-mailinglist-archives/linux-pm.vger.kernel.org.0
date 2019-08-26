Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B99CC61
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfHZJQB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 05:16:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56330 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbfHZJQB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 05:16:01 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 591d2b0a859a49d1; Mon, 26 Aug 2019 11:15:58 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Tri Vo <trong@android.com>
Cc:     gregkh@linuxfoundation.org, viresh.kumar@linaro.org,
        rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v8 0/3] PM / wakeup: Show wakeup sources stats in sysfs
Date:   Mon, 26 Aug 2019 11:15:58 +0200
Message-ID: <1676352.3Ka9HrfE86@kreacher>
In-Reply-To: <20190807014846.143949-1-trong@android.com>
References: <20190807014846.143949-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, August 7, 2019 3:48:43 AM CEST Tri Vo wrote:
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
> Patch 1 and 2 do some cleanup to simplify our changes to how wakeup sources are
> created. Patch 3 implements wakeup sources stats in sysfs.
> 
> Tri Vo (3):
>   PM / wakeup: Drop wakeup_source_init(), wakeup_source_prepare()
>   PM / wakeup: Use wakeup_source_register() in wakelock.c
>   PM / wakeup: Show wakeup sources stats in sysfs
> 
>  Documentation/ABI/testing/sysfs-class-wakeup |  76 +++++++
>  drivers/acpi/device_pm.c                     |   3 +-
>  drivers/base/power/Makefile                  |   2 +-
>  drivers/base/power/power.h                   |   9 +
>  drivers/base/power/wakeup.c                  |  59 +++---
>  drivers/base/power/wakeup_stats.c            | 203 +++++++++++++++++++
>  fs/eventpoll.c                               |   4 +-
>  include/linux/pm_wakeup.h                    |  21 +-
>  kernel/power/autosleep.c                     |   2 +-
>  kernel/power/wakelock.c                      |  32 +--
>  kernel/time/alarmtimer.c                     |   2 +-
>  11 files changed, 358 insertions(+), 55 deletions(-)
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
> 
> v6:
> - Changed stats location to /sys/class/wakeup/ws<ID>/*
> - Replaced ida_simple_get()/ida_simple_remove() with ida_alloc()/ida_free() as
>   the former is deprecated.
> - Reverted changes to device_init_wakeup(). Rafael is preparing a patch to deal
>   with extra wakeup source allocation in a separate patch.
> 
> v7:
> - Removed wakeup_source_init(), wakeup_source_prepare().
> - Removed duplicate wakeup source creation code from  kernel/power/wakelock.
> - Moved ID allocation to wakeup source object creation time.
> - Changed stats location back to /sys/class/wakeup/wakeup<ID>/*
> - Remove wakeup source device's "power" attributes.
> 
> v8:
> - Updated commit message on patch 1 to indicate change of behavior of
>   wakeup_source_create(), as per Stephen.
> - Included headers for used symbols, as per Stephen.
> - Added a function to create wakeup source devices to use
>   device_set_pm_not_required() to skip power management for such devices, as per
>   Stephen.
> 
> --
> 2.22.0.770.g0f2c4a37fd-goog
> 
> 

All three patches applied along with the later fixes from Stephen.

Thanks!




