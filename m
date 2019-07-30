Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC77B221
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 20:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfG3Sjq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 14:39:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33875 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfG3Sjq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 14:39:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id l12so48683259oil.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hn8rVqsLu57CTsIv+4AEu3lgPz7dzu5u0LtZwakTzpQ=;
        b=aZq4W3sYpLbfDXk5mPkDRrGoJ9ERrPYOH1zTUawx2IBk9XlL1qSZOl4yzfvfL6lp4M
         mW8BUurVMViiftyaCdfttaIrynR3pQLSfUsP0pYx2Xa+rrmVgxB4/ajPx5Ia37i8SKKB
         JVbwfSMPoPgxuthtY56dIC9aQLYBODZDnwAlFGbDq6lG7ZhY2DSg7W8XyOvx6Opbn2Pq
         Qxae5KbdBEwPr1o8HPt5Can+Qah0B7u2dsFtxAtFMQEepS3fEsVCRjgRCJY4Mu29f+q6
         YMQ8ayP2AL+nzAdJPXhcxlxwzyBLScI2Rp1M+5mLTjZgSUrj45+O4e1F8SPftegc70+c
         hPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hn8rVqsLu57CTsIv+4AEu3lgPz7dzu5u0LtZwakTzpQ=;
        b=JiMEUBoQuM1Vn+EQUpZyILn2v6Hy7Ry+A0D5T8MYWMJjVTYFdyeV7Hzr8P8YWERcSz
         pmGmOURDs9IJ/BKNrxGezpxcUE8+uwtV6qs0xYdIgc/P16OsOq/EWKwdSqCRnkcK4u5J
         epFF92vatL/3irxmcugOoiWSwBQEMvjVPRrHVmEkaRO69vHzstMkAJyXcsFdsqlJDufE
         05vM5YJXYFkpWHCF2WY4n4IlTQorqlAH7gt3twH51Ddts1w1L7Y6H5tUuJ/dqXul3IBY
         ZMVpv4oAYQGkMcGUGswo5AJyeOhjXvPcGT1TklqtXgck6eWEz0kmjDQBhGFWPQjFTWuT
         gMQQ==
X-Gm-Message-State: APjAAAU2hzEPZxuYcatzNerK7TaEqItxWLw1Pvn235ntS3ZwW5OsyzBr
        YFYxUqNKz5odiKaAp71o2/ycSSyheWHGql1oiv4=
X-Google-Smtp-Source: APXvYqzcHIs1IocmYpbfRWUSjCZAhhUgwcXSaYsCUrLX2GJ9L0TTQB47knLCvvOTNP4HMJqHvGbL3aG3dPnIio241hw=
X-Received: by 2002:aca:3509:: with SMTP id c9mr60354165oia.179.1564511985221;
 Tue, 30 Jul 2019 11:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190730024309.233728-1-trong@android.com> <CAJZ5v0jJn=vHdYExbzwRAMsk=Ad5bhvOAvHEXe-FHOj2R4Gwig@mail.gmail.com>
In-Reply-To: <CAJZ5v0jJn=vHdYExbzwRAMsk=Ad5bhvOAvHEXe-FHOj2R4Gwig@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Tue, 30 Jul 2019 11:39:34 -0700
Message-ID: <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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

On Mon, Jul 29, 2019 at 10:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jul 30, 2019 at 4:45 AM Tri Vo <trong@android.com> wrote:
> >
> > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > blocking wakeup sources over device's boot cycle. This information can
> > then be used (1) for power-specific bug reporting and (2) towards
> > attributing battery consumption to specific processes over a period of
> > time.
> >
> > However, debugfs doesn't have stable ABI. For this reason, create a
> > 'struct device' to expose wakeup sources statistics in sysfs under
> > /sys/class/wakeup/wakeup<ID>/*.
> >
> > Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Co-developed-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Tri Vo <trong@android.com>
> > Tested-by: Tri Vo <trong@android.com>
> > Tested-by: Kalesh Singh <kaleshsingh@google.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-wakeup |  76 +++++++++
> >  drivers/acpi/device_pm.c                     |   3 +-
> >  drivers/base/power/Makefile                  |   2 +-
> >  drivers/base/power/wakeup.c                  |  21 ++-
> >  drivers/base/power/wakeup_stats.c            | 171 +++++++++++++++++++
> >  fs/eventpoll.c                               |   4 +-
> >  include/linux/pm_wakeup.h                    |  15 +-
> >  kernel/power/autosleep.c                     |   2 +-
> >  kernel/power/wakelock.c                      |  10 ++
> >  kernel/time/alarmtimer.c                     |   2 +-
> >  10 files changed, 294 insertions(+), 12 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-wakeup
> >  create mode 100644 drivers/base/power/wakeup_stats.c
> >
> > v2:
> > - Updated Documentation/ABI/, as per Greg.
> > - Removed locks in attribute functions, as per Greg.
> > - Lifetimes of struct wakelock and struck wakeup_source are now different due to
> >   the latter embedding a refcounted kobject. Changed it so that struct wakelock
> >   only has a pointer to struct wakeup_source, instead of embedding it.
> > - Added CONFIG_PM_SLEEP_STATS that enables/disables wakeup source statistics in
> >   sysfs.
> >
> > v3:
> > Changes by Greg:
> > - Reworked code to use 'struct device' instead of raw kobjects.
> > - Updated documentation file.
> > - Only link wakeup_stats.o when CONFIG_PM_SLEEP_STATS is enabled.
> > Changes by Tri:
> > - Reverted changes to kernel/power/wakelock.c. 'struct device' hides kobject
> >   operations. So no need to handle lifetimes in wakelock.c
> >
> > v4:
> > - Added 'Co-developed-by:' and 'Tested-by:' fields to commit message.
> > - Moved new documentation to a separate file
> >   Documentation/ABI/testing/sysfs-class-wakeup, as per Greg.
> > - Fixed copyright header in drivers/base/power/wakeup_stats.c, as per Greg.
> >
> > v5:
> > - Removed CONFIG_PM_SLEEP_STATS
> > - Used PTR_ERR_OR_ZERO instead of if(IS_ERR(...)) + PTR_ERR, reported by
> >   kbuild test robot <lkp@intel.com>
> > - Stephen reported that a call to device_init_wakeup() and writing 'enabled' to
> >   that device's power/wakeup file results in multiple wakeup source being
> >   allocated for that device.  Changed device_wakeup_enable() to check if device
> >   wakeup was previously enabled.
> > Changes by Stephen:
> > - Changed stats location from /sys/class/wakeup/<name>/* to
> >   /sys/class/wakeup/wakeup<ID>/*, where ID is an IDA-allocated integer. This
> >   avoids name collisions in /sys/class/wakeup/ directory.
> > - Added a "name" attribute to wakeup sources, and updated documentation.
> > - Device registering the wakeup source is now the parent of the wakeup source.
> >   Updated wakeup_source_register()'s signature and its callers accordingly.
>
> And I really don't like these changes.  Especially having "wakeup"
> twice in the path.

I can trim it down to /sys/class/wakeup/<ID>/. Does that sound good?

About the other change, I think making the registering device the
parent of the wakeup source is a worthwhile change, since that way one
can associate a wakeup source sysfs entry with the device that created
it.
>
> Couldn't you find a simpler way to avoid the name collisions?

I could also simply log an error in case of a name collision instead
of failing hard. That way I can keep the old path with the wakeup
source name in it. Other than that, I can't think of a way to resolve
the directory name collisions without making that directory name
unique, i.e. generating IDs is probably the simplest way. I'm still
learning about the kernel, and I might be wrong though. What do you
think?
