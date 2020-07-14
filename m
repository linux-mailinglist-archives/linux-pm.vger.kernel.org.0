Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3443821F785
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgGNQly (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 12:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgGNQlx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 12:41:53 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EF3C08C5C1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 09:41:53 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id c7so5896589uap.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ab7n3z5mmwJTrVdm4I/Qk+EgWW2BK5sF3S4Gs9LC2pU=;
        b=VHZOUHrVRhNSrg3KXXZP+GAKYukKuZJqUkm5rQjUQ1ljdD3rJiZmHJ9JBEZxI/gQ78
         LdVSaAcjIaGH2WHm3B6K1fnEsO+RpwuJIMwNVJZg0DwnljFT9vzkoAWDwNWe+zXSrjao
         IpMj2M0CS/PRNwwFHxaGEGojTVKjZxRItENog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ab7n3z5mmwJTrVdm4I/Qk+EgWW2BK5sF3S4Gs9LC2pU=;
        b=f9fwdh4+V9cn28DIEOosxSHWYqRjqcZIAlxFCULD58qOc+ReKN/0NuL7P5+SYK46NT
         CFsMSHrzu3vhC8xYjhUVBqsCZaoTJSwCAh25fKoEwR0WwGOcytzDagBR/g7x3GplkKvB
         vOgm5nMdVwsDe8lnkIVrYSAEq18JGhQ0GTHotdz4lVkUHg8G1q+nmV3YRh+rILoYD3Xu
         g9mSjfoY/TrElGtA93zHeJBmOxkAFja2MlnFPBDzD+TXCA1yZZ7NP9YhJPsE97Shc8FT
         qMqsQ7whk3s/sN7FGdZEdmRs3hoWbNcUw0TG3rnMMnEeOCjAfb8cb+7NHzo/1iWfjLsF
         UZew==
X-Gm-Message-State: AOAM531wboQ9wOSbSx7J5GAPzvT+AFkIWqmw3eSaeN9vZ1+sdCgYrryn
        UGsrpz/eJ1vC34EB4sTdl9tUHFMMoZJWr0o6vGM/OA==
X-Google-Smtp-Source: ABdhPJyXVJ/fLtTJ5u5u/TYEyFxPBC2v7sTjbhSHP3mdXvobPVLvPRM7juHvP/wKZQeY+BIpC4A3UhZVueVzzEMcOHI=
X-Received: by 2002:ab0:6f0a:: with SMTP id r10mr4847028uah.100.1594744912382;
 Tue, 14 Jul 2020 09:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200706140715.v2.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
 <20200714052941.GB3874@shao2-debian>
In-Reply-To: <20200714052941.GB3874@shao2-debian>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 14 Jul 2020 09:41:41 -0700
Message-ID: <CANFp7mURm5QKe8afuCHjFt89bgJtOyUkj_MJKdfzVto0i7EpZw@mail.gmail.com>
Subject: Re: [power] 47b918cf9a: kmsg.power_supply_ADP1:Error_in_uevent_for_wakeup_sysfs_add
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, lkp@lists.01.org,
        yu.c.chen@intel.com, "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This version of the patch was not merged and the message above doesn't
exist in the merged patch:
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9a3e9e6ff6d7f6b8ce7903893962d50adcbe82d2

The err log was emitted during boot as well and is innocuous since the
power_supply initializes fully in the next line:
kern  :err   : [    5.918034] power_supply ADP1: Error in uevent for
wakeup_sysfs_add: -11
kern  :info  : [    5.918300] ACPI: AC Adapter [ADP1] (on-line)

Abhishek

On Mon, Jul 13, 2020 at 10:30 PM kernel test robot
<rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 47b918cf9a1d2b6e36706fd2be2b91e65f490146 ("[PATCH v2 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove")
> url: https://github.com/0day-ci/linux/commits/Abhishek-Pandit-Subedi/power-Emit-changed-uevent-on-wakeup_sysfs_add-remove/20200707-050912
> base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
>
> in testcase: suspend-stress
> with following parameters:
>
>         mode: freeze
>         iterations: 10
>
>
>
> on test machine: 4 threads Ivy Bridge with 4G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
>
> kern  :debug : [    5.917685] calling  acpi_ac_init+0x0/0xa3 @ 1
> kern  :err   : [    5.918034] power_supply ADP1: Error in uevent for wakeup_sysfs_add: -11
> kern  :info  : [    5.918300] ACPI: AC Adapter [ADP1] (on-line)
> kern  :debug : [    5.918500] initcall acpi_ac_init+0x0/0xa3 returned 0 after 609 usecs
> kern  :debug : [    5.918725] calling  acpi_button_driver_init+0x0/0x53 @ 1
> kern  :info  : [    5.919006] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> kern  :info  : [    5.919367] ACPI: Power Button [PWRB]
> kern  :info  : [    5.919580] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
> kern  :info  : [    5.919927] ACPI: Lid Switch [LID]
> kern  :info  : [    5.920131] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> kern  :info  : [    5.920455] ACPI: Power Button [PWRF]
> kern  :debug : [    5.920644] initcall acpi_button_driver_init+0x0/0x53 returned 0 after 1669 usecs
> kern  :debug : [    5.920944] calling  acpi_fan_driver_init+0x0/0x13 @ 1
> kern  :debug : [    5.921155] initcall acpi_fan_driver_init+0x0/0x13 returned 0 after 11 usecs
> kern  :debug : [    5.921388] calling  acpi_processor_driver_init+0x0/0xb7 @ 1
> kern  :debug : [    5.921905] initcall acpi_processor_driver_init+0x0/0xb7 returned 0 after 299 usecs
> kern  :debug : [    5.922203] calling  acpi_thermal_init+0x0/0x82 @ 1
> kern  :info  : [    5.922755] thermal LNXTHERM:00: registered as thermal_zone0
> kern  :info  : [    5.922977] ACPI: Thermal Zone [TZ01] (16 C)
> kern  :debug : [    5.923177] initcall acpi_thermal_init+0x0/0x82 returned 0 after 759 usecs
> kern  :debug : [    5.923409] calling  acpi_battery_init+0x0/0x39 @ 1
> kern  :debug : [    5.923606] initcall acpi_battery_init+0x0/0x39 returned 0 after 4 usecs
> kern  :debug : [    5.923841] calling  acpi_hed_driver_init+0x0/0x11 @ 1
> kern  :debug : [    5.924075] initcall acpi_hed_driver_init+0x0/0x11 returned 0 after 32 usecs
> kern  :info  : [    5.924178] battery: ACPI: Battery Slot [BAT1] (battery present)
> kern  :debug : [    5.924309] calling  bgrt_init+0x0/0xbe @ 1
> kern  :debug : [    5.924312] initcall bgrt_init+0x0/0xbe returned -19 after 0 usecs
> kern  :debug : [    5.924928] calling  erst_init+0x0/0x309 @ 1
> kern  :debug : [    5.925110] initcall erst_init+0x0/0x309 returned 0 after 0 usecs
> kern  :debug : [    5.925325] calling  ghes_init+0x0/0xe5 @ 1
> kern  :debug : [    5.925504] initcall ghes_init+0x0/0xe5 returned -19 after 0 usecs
> kern  :debug : [    5.925721] calling  erst_dbg_init+0x0/0x2c @ 1
> kern  :info  : [    5.925912] ERST DBG: ERST support is disabled.
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
>
>
> Thanks,
> Rong Chen
>
