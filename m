Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2067A1D901B
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgESGc1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 02:32:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbgESGc1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 02:32:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5A0ECA095799125A86D;
        Tue, 19 May 2020 14:32:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 14:32:15 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 0/6] cpuidle: Make cpuidle governor switchable to be the default behaviour
Date:   Tue, 19 May 2020 14:25:19 +0800
Message-ID: <1589869525-29893-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is the formal patch set after the RFC v2 [0].

For now cpuidle governor can be switched via sysfs only when the
boot option "cpuidle_sysfs_switch" is passed, but it's useful
to switch the governor to adapt to different workloads, especially
after TEO and haltpoll governors were introduced.

Make cpuidle governor switchable to be the default behaviour by
removing the sysfs_switch and switch attributes, also update the
document as well.

Patch 1/6 and 2/6 are bugfix patch which can be triggered if the
governor name is 15 characters, it is not a 'real' bug for now as we
don't have such usecases, so we can merge them together via this
patchset.

Patch 3/6 and 4/6 are the functional update to make cpuidle governor
switchable to be the default behaviour.

Patch 5/6 and 6/6 are the document update.

Changes since RFC v2:
 - Remove sizeof(char) in patch 1/6;
 - Fix some minor typos;
 - Adding Review/Test/ACK tags.

[0]:https://patchwork.kernel.org/cover/11519511/

Hanjun Guo (6):
  cpuidle: sysfs: Fix the overlap for showing available governors
  cpuidle: sysfs: Accept governor name with 15 characters
  cpuidle: Make cpuidle governor switchable to be the default behaviour
  cpuidle: sysfs: Remove sysfs_switch and switch attributes
  Documentation: cpuidle: update the document
  Documentation: ABI: make current_governer_ro as a candidate for
    removal

 Documentation/ABI/obsolete/sysfs-cpuidle           |  9 ++++
 Documentation/ABI/testing/sysfs-devices-system-cpu | 24 ++++-----
 Documentation/admin-guide/pm/cpuidle.rst           | 20 ++++----
 Documentation/driver-api/pm/cpuidle.rst            |  5 +-
 drivers/cpuidle/sysfs.c                            | 58 ++++++----------------
 5 files changed, 45 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-cpuidle

-- 
1.7.12.4

