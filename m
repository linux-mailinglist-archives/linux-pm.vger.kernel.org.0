Return-Path: <linux-pm+bounces-17703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 301319D0F00
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 11:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F138BB25627
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 10:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5D819538D;
	Mon, 18 Nov 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t16F74SE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147AA194094;
	Mon, 18 Nov 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925442; cv=none; b=Jh/UWhMWa1c1eIIwPmtOPlnoXR7uAdsntrbMDuuFM/siwNF8P5kdopUc+Kq6F+Wi8fK3U08IOWE4CpoGsoNBpoloVZaV9qIHR7FQ9/1sMflyc1FKL9n8KRy4SGk0ifecbvW6Jfsb/il3mKXAAAb9wrjoM6C1ZFN0+rIlfWr9x4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925442; c=relaxed/simple;
	bh=xvLvWV9VR+bB9tOaGuSAYrJs8CvxungYCsVwLkjIixQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cti0T+Q69I/x6l3QsEgc258rjLuQHTj5J7RgWirQDZtNoiyCmXyIFR8vFtTffeClgRi7YuZ3SwZ/KJfZ7omDHx+00ibXWXAcne86J0Doowkj9UO6U2oNlUSErUSAxOeno/kZONALxiZ6VV9/Ocw3N16ref25rGoT8nMzyVQ+ko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t16F74SE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F73C4CED6;
	Mon, 18 Nov 2024 10:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731925441;
	bh=xvLvWV9VR+bB9tOaGuSAYrJs8CvxungYCsVwLkjIixQ=;
	h=From:Date:Subject:To:Cc:From;
	b=t16F74SEiS+YtnpMZG9rsStMfkAQvg6HldPN309NF/RKAd0EZLyXNS8KIrGUnvsNC
	 iEkWNMoKDPKtayL3lT6KmFSCwHFm4wU3SedoreiZmaUby7n72n+cIZZvcuTXbfGx2D
	 svv1s6lwS00Yt5yMwXG+2NIDRkf4cB1uxFFZ6NAZsOvlHcI6Zphc5ifCYTMGBwgA1X
	 ceNMqYidyujtLt3SBs+Bh0gmPeyRemINgIVPDaTho4TL1t8B0CuLEuL0SIexWmx78k
	 9tK0fxqjMwBe7BsKVABoS822bfjdQLkAQ330TzLwJfNgoHoDXzZtUFm55C4PkzD42u
	 Ljr5ImdZiAGDw==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e5fbc40239so592850b6e.3;
        Mon, 18 Nov 2024 02:24:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKEjZF15OLnjnZ/G7oo7cdVxsi6Nx1F+a/2m4ZEkq0oxGDn+YonQ+jM7QjMQsFywMtgnNJ9GzMVL35jbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0UfPsq0wTZAesMTXMBAMa+BnWIWeWdOhm6ueWAGE2bL2Ril8
	enG5EVJmhGx91J/hrUsdqVhpj5H5XaP3X/ehWBXCawYTh0T3p10+QFituyuDZSDTLSFuP9xtsNR
	P7Uv4CiHQwJqVdPykUOnvkC9LHSY=
X-Google-Smtp-Source: AGHT+IGYzZ1dH3I36kCmcAWaqnUeqvjV6qRjt/bk8fVXlZLykBAk5pVknV3FCF9Hs2dZGBu3X8rLRGiCD2s2+EEpZOA=
X-Received: by 2002:a05:6808:3094:b0:3e6:5f1d:411a with SMTP id
 5614622812f47-3e7bc865a3bmr11863527b6e.31.1731925441222; Mon, 18 Nov 2024
 02:24:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Nov 2024 11:23:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0imu3DZbUb6P=UGP5G9ffxS6MbnRb-2zx7pXNTrxS1Z1A@mail.gmail.com>
Message-ID: <CAJZ5v0imu3DZbUb6P=UGP5G9ffxS6MbnRb-2zx7pXNTrxS1Z1A@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.13-rc1

with top-most commit 0104dcdaad3a7afd141e79a5fb817a92ada910ac

 thermal: testing: Initialize some variables annoteded with _free()

on top of commit 5469a8deac05391781bcd27e7c40f2c35121ca09

 Merge tag 'thermal-v6.12-rc7' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux

to receive thermal control updates for 6.13-rc1.

These are thermal core changes, including the addition of support for
temperature thresholds that can be set from user space, fixes related
to thermal zone initialization, suspend/resume and exit, locking rework
and rearrangement of the code handling thermal zone temperature updates.

Specifics:

 - Add support for thermal thresholds that can be added and removed from
   user space via netlink along with a related library update (Daniel
   Lezcano).

 - Fix thermal zone initialization, suspend/resume and exit
   synchronization issues (Rafael Wysocki).

 - Rearrange locking in the thermal core to use guards (Rafael Wysocki).

 - Make the code handling thermal zone temperature updates use sorted
   lists of trip points to reduce the number of trip points table walks
   in the thermal core (Rafael Wysocki).

 - Fix and clean up the thermal testing facility code (Rafael Wysocki).

 - Fix a Power Allocator thermal governor issue (ZhengShaobo).

Thanks!


---------------

Daniel Lezcano (8):
      thermal: core: Add user thresholds support
      thermal: core: Connect the threshold with the core
      thermal: netlink: Add the commands and the events for the thresholds
      tools/lib/thermal: Make more generic the command encoding function
      tools/lib/thermal: Add the threshold netlink ABI
      tools/thermal/thermal-engine: Take into account the thresholds API
      thermal: thresholds: Fix thermal lock annotation issue
      thermal/lib: Fix memory leak on error in thermal_genl_auto()

Rafael J. Wysocki (36):
      thermal: core: Initialize thermal zones before registering them
      thermal: core: Rearrange PM notification code
      thermal: core: Represent suspend-related thermal zone flags as bits
      thermal: core: Mark thermal zones as initializing to start with
      thermal: core: Fix race between zone registration and system suspend
      thermal: core: Consolidate thermal zone locking during initialization
      thermal: core: Mark thermal zones as exiting before unregistration
      thermal: core: Consolidate thermal zone locking in the exit path
      thermal: core: Update thermal zones after cooling device binding
      thermal: core: Drop need_update field from struct thermal_zone_device
      thermal: core: Move lists of thermal instances to trip descriptors
      thermal: core: Pass trip descriptors to trip bind/unbind functions
      thermal: core: Add and use thermal zone guard
      thermal: core: Add and use a reverse thermal zone guard
      thermal: core: Separate code running under thermal_list_lock
      thermal: core: Manage thermal_list_lock using a mutex guard
      thermal: core: Call thermal_governor_update_tz() outside of cdev lock
      thermal: core: Introduce thermal_instance_add()
      thermal: core: Introduce thermal_instance_delete()
      thermal: core: Introduce thermal_cdev_update_nocheck()
      thermal: core: Add and use cooling device guard
      thermal: core: Separate thermal zone governor initialization
      thermal: core: Manage thermal_governor_lock using a mutex guard
      thermal: core: Build sorted lists instead of sorting them later
      thermal: core: Rename trip list node in struct thermal_trip_desc
      thermal: core: Prepare for moving trips between sorted lists
      thermal: core: Rearrange __thermal_zone_device_update()
      thermal: core: Pass trip descriptor to thermal_trip_crossed()
      thermal: core: Move some trip processing to thermal_trip_crossed()
      thermal: core: Relocate functions that update trip points
      thermal: core: Eliminate thermal_zone_trip_down()
      thermal: core: Use trip lists for trip crossing detection
      thermal: core: Relocate thermal zone initialization routine
      thermal: testing: Simplify tt_get_tt_zone()
      thermal: testing: Use DEFINE_FREE() and __free() to simplify code
      thermal: testing: Initialize some variables annoteded with _free()

ZhengShaobo (1):
      thermal: gov_power_allocator: Granted power set to max when
nobody request power

---------------

 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/gov_bang_bang.c               |  15 +-
 drivers/thermal/gov_fair_share.c              |  20 +-
 drivers/thermal/gov_power_allocator.c         |  86 +--
 drivers/thermal/gov_step_wise.c               |  22 +-
 drivers/thermal/testing/zone.c                |  41 +-
 drivers/thermal/thermal_core.c                | 883 +++++++++++++++-----------
 drivers/thermal/thermal_core.h                |  41 +-
 drivers/thermal/thermal_debugfs.c             |  50 +-
 drivers/thermal/thermal_helpers.c             |  46 +-
 drivers/thermal/thermal_hwmon.c               |   5 +-
 drivers/thermal/thermal_netlink.c             | 253 +++++++-
 drivers/thermal/thermal_netlink.h             |  34 +
 drivers/thermal/thermal_sysfs.c               | 132 ++--
 drivers/thermal/thermal_thresholds.c          | 240 +++++++
 drivers/thermal/thermal_thresholds.h          |  19 +
 drivers/thermal/thermal_trip.c                |  48 +-
 include/linux/thermal.h                       |   6 +
 include/uapi/linux/thermal.h                  |  29 +-
 tools/lib/thermal/commands.c                  | 188 +++++-
 tools/lib/thermal/events.c                    |  55 +-
 tools/lib/thermal/include/thermal.h           |  40 ++
 tools/lib/thermal/libthermal.map              |   5 +
 tools/lib/thermal/thermal.c                   |  17 +
 tools/thermal/lib/Makefile                    |   2 +-
 tools/thermal/thermal-engine/thermal-engine.c | 105 ++-
 26 files changed, 1650 insertions(+), 733 deletions(-)

