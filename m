Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61037367FBB
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 13:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbhDVLnv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 07:43:51 -0400
Received: from foss.arm.com ([217.140.110.172]:50406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236040AbhDVLnv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 07:43:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 356DC13A1;
        Thu, 22 Apr 2021 04:43:16 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.27.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5FDD3F774;
        Thu, 22 Apr 2021 04:43:14 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH v4 0/3] Improve IPA mechanisms in low temperature state
Date:   Thu, 22 Apr 2021 12:43:05 +0100
Message-Id: <20210422114308.29684-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This v4 patch set aims to address the issues present in IPA when the
temperature is below the first trip point and cooling devices are not
throttled.
The last patch 1/3 is co-developed by Daniel, who presented the code
during v2 review. I have created a helper function based on his idea,
which can now be used inside IPA governor lock protected code. 
The patch 2/3 adds a basic check of cooling devices power to keep the
internal statistics fresh. This allows to avoid issue when the statistics
cover very long period, because they were not maintained.
The patch 3/3 addresses an issue described in bugzilla [1], which is:
unnecessary updating cooling devices when their state has not changed
because they are not throttled. This update triggers sending an event,
which should be avoided. Thus, patch 2/3 adds a tracking mechanism if
the update was triggered and makes sure it will be done only once when
the temperature continue to stay below first trip point.

changelog:
v4:
- reordered the patches, patch 3/3 from v3 is now 1/3 
v3:
- new patch 3/3 co-developed with Daniel
v2:
- patch 2/2 uses now simple 'update' bool flag and information from
  'tz->last_temperature'
- patch 1/2 has small change in the comment
- re-based on top of today's thermal/next branch

Regards,
Lukasz Luba

[1] https://bugzilla.kernel.org/show_bug.cgi?id=212501

Lukasz Luba (3):
  thermal: create a helper __thermal_cdev_update() without a lock
  thermal: power_allocator: maintain the device statistics from going
    stale
  thermal: power_allocator: update once cooling devices when temp is low

 drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++----
 drivers/thermal/thermal_core.h        |  1 +
 drivers/thermal/thermal_helpers.c     | 27 +++++++++++++++++----------
 3 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.17.1

