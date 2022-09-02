Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6BA5AB7E0
	for <lists+linux-pm@lfdr.de>; Fri,  2 Sep 2022 20:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiIBSAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Sep 2022 14:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiIBSAs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2022 14:00:48 -0400
Received: from vorpal.se (vorpal.se [IPv6:2a01:7e00::f03c:91ff:fe73:398e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B324E1920;
        Fri,  2 Sep 2022 11:00:47 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id AF442142D4;
        Fri,  2 Sep 2022 18:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662141646; bh=ieJxfXn8RBLaaarQxjRT77vhQr+Ye5GGe2lBdjfql6o=;
        h=From:To:Cc:Subject:Date:From;
        b=IWn48oPl+R5nL1nys3Es3V4bCDYYqmpQ3802wFy6NiuT1z5AcPT/txCVi0Y7+n29/
         Yzodjw26f4jxbxg2t/6jSBHLab3iJWwykeJXHKwt9F5kf0PRRb9OV+OkMHnKXAsBoO
         znqNvl7z7a/bfZN+AHvyJc6hwjN9CV6EN/zUF/VJxXF4Q96r7znr+dMH0dPEewDeML
         LwvjjHPhjtBrBmn9JBEuCAZ3xfn/n2iknAJlm7il60E43MJSUfYHRKz+bjqII7bWJG
         gbEJbLQkmlDdZkuB0dh4mGP9vmIHmN8DR2i+4XhOtehoYYZX6E2etpkDsq9TeqSG8J
         VQo+gH9keKQOg==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH v2 0/3] platform/x86: Battery charge mode in toshiba_acpi
Date:   Fri,  2 Sep 2022 20:00:34 +0200
Message-Id: <20220902180037.1728546-1-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Here we go again.

Note that this patch series edits in the same place as my patch series
adding HWMON support for the fan, so there will be a trivial merge
conflict, as both series insert new functions in the same location in the
file. Hopefully this is not a big issue, but if so I can rebase one on top
of the other.

Changelog
=========
v2:
  * Fix compiler warning discovered by "kernel test robot" in patch 2
    (real issue).
  * Added Acked-by in patch 3 (Thanks Sebastian Reichel).


Mostly original (from v1 of this series) cover letter follows:

Summary
=======

This patch series implements battery charge control for Toshiba Satellite
Z830 (and posssibly some other models). The full background is available
in the two emails linked below, but a short summary will follow, including
only what is relevant for battery charge control.

Background (from link 1)
==========

The Toshiba Satellite/Portege Z830 supports not charging the battery fully
in order to prolong battery life. Unlike for example ThinkPads where this
control is granular here it is just off/on. When off it charges to 100%.
When on it charges to about 80%.

According to the Windows program used to control the feature the setting
will not take effect until the battery has been discharged to around 50%.
However, in my testing it takes effect as soon as the charge drops below
80%. On Windows Toshiba branded this feature as "Eco charging"

In the following example ACPI calls I will use the following newly defined
constants:
#define HCI_BATTERY_CHARGE_MODE 0xba
#define BATTERY_CHARGE_FULL 0
#define BATTERY_CHARGE_80_PERCENT 1

To set the feature:
  {HCI_SET, HCI_BATTERY_CHARGE_MODE, charge_mode, 0, 0, 0}
To query for the existence of the feature:
  {HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 0}
To read the feature:
  {HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 1}

The read may need to be retried if TOS_DATA_NOT_AVAILABLE is returned as
the status code. This rarely happens (I have never observed it on Linux),
but I have seen it happen under Windows once, and the software did retry
it.


Improvements
============

As discussed in link 2 & 3 below, the original approach was suboptimal.

This patch series instead consists of two patches.

The first patch implements detecting the feature as well as internal
getter/setter methods.

The second patch adds battery hooks (heavily based on the code for this in
thinkpad_acpi) which creates the standard charge_control_end_threshold file
under /sys/class/power_supply/BAT1.

Side note: There is no BAT0 on this Toshiba, I'm not sure why the numbering
ends up starting from 1 instead of 0 here. This differs from my Thinkpads,
where the numbering starts from 0, with BAT1 being the second battery.
However, I haven't spent much effort investigating this, as it did not seem
important.

Patch 3 updates the ABI test documentation as suggested by Hans de Goede.
Note that only the charge_control_end_threshold is updated, as this is the
only limit supported by the Toshiba Z830. Possibly
charge_control_start_threshold should also be updated similarly, or would
it be better to wait for an actual example of this in the wild first?

Link (1): https://www.spinics.net/lists/platform-driver-x86/msg34314.html
Link (2): https://www.spinics.net/lists/platform-driver-x86/msg34354.html
Link (3): https://www.spinics.net/lists/platform-driver-x86/msg34320.html

Best regards,
Arvid Norlander


Arvid Norlander (3):
  platform/x86: Battery charge mode in toshiba_acpi (internals)
  platform/x86: Battery charge mode in toshiba_acpi (sysfs)
  docs: ABI: charge_control_end_threshold may not support all values

 Documentation/ABI/testing/sysfs-class-power |   5 +-
 drivers/platform/x86/toshiba_acpi.c         | 166 ++++++++++++++++++++
 2 files changed, 170 insertions(+), 1 deletion(-)


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.37.3

