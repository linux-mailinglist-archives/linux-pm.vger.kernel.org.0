Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A311BF34E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 10:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgD3IqX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 04:46:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbgD3IqW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Apr 2020 04:46:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 65D34585BB77616707A;
        Thu, 30 Apr 2020 16:46:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 16:46:09 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [RFC v2 PATCH 0/6] cpuidle: Make cpuidle governor switchable to be the default behaviour
Date:   Thu, 30 Apr 2020 16:39:41 +0800
Message-ID: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For now cpuidle governor can be switched via sysfs only when the
boot option "cpuidle_sysfs_switch" is passed, but it's important
to switch the governor to adapt to different workloads, especially
after TEO and haltpoll governor were introduced.

Make cpuidle governor switchable to be the default behaviour by removing
the sysfs_switch and switch attributes, also update the document as well.

v1->v2:
 - Add two bugfix patch which can be triggered if the governor name is 15
   characters, it is not a 'real' bug for now as we don't have such usecases
   so we can merge them together via this patchset.
 - Remove the sysfs_switch, not introduce a CONFIG option to make cpuidle
   governor switchable in default, suggested by Daniel.
 - Update the document after cpuidle_sysfs_switch is removed, suggested by
   Doug Smythies.

Hanjun Guo (6):
  cpuidle: sysfs: Fix the overlap for showing available governors
  cpuidle: sysfs: Accept governor name with 15 characters
  cpuidle: Make cpuidle governor switchable to be the default behaviour
  cpuidle: sysfs: Remove sysfs_switch and switch attributes
  Documentation: cpuidle: update the document
  Documentation: ABI: make current_governer_ro as a candidate for
    removal

 Documentation/ABI/obsolete/sysfs-cpuidle           |  9 ++++
 Documentation/ABI/testing/sysfs-devices-system-cpu | 24 ++++------
 Documentation/admin-guide/pm/cpuidle.rst           | 20 ++++----
 Documentation/driver-api/pm/cpuidle.rst            |  5 +-
 drivers/cpuidle/sysfs.c                            | 56 ++++++----------------
 5 files changed, 44 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-cpuidle

-- 
1.7.12.4

