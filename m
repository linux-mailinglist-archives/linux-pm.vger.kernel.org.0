Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEB436718E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 19:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243052AbhDURm3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 13:42:29 -0400
Received: from foss.arm.com ([217.140.110.172]:38842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236913AbhDURm2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 13:42:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3508C11FB;
        Wed, 21 Apr 2021 10:41:55 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.27.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A4C703F694;
        Wed, 21 Apr 2021 10:41:53 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH v3 0/3] Improve IPA mechanisms in low temperature state
Date:   Wed, 21 Apr 2021 18:41:42 +0100
Message-Id: <20210421174145.8213-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This v3 patch set aims to address the issues present in IPA when the
temperature is below the first trip point and cooling devices are not
throttled.
The first patch adds a basic check of cooling devices power to keep the
internal statistics fresh. This allows to avoid issue when the statistics
cover very long period, because they were not maintained.
The second patch addresses an issue described in bugzilla [1], which is:
unneccessary updating cooling devices when their state has not changed
because they are not throttled. This update triggers sending an event,
which should be avoided. Thus, patch 2/3 adds a tracking mechanism if
the update was triggered and makes sure it will be done only once when
the temperature continue to stay below first trip point.
The last patch 3/3 is co-developed by Daniel, who presented the code
during v2 review. I have created a helper function based on his idea,
which can now be used inside IPA governor lock protected code. 

changelog:
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
  thermal: power_allocator: maintain the device statistics from going
    stale
  thermal: power_allocator: update once cooling devices when temp is low
  thermal: create a helper __thermal_cdev_update() without a lock

 drivers/thermal/gov_power_allocator.c | 21 ++++++++++++++++----
 drivers/thermal/thermal_core.h        |  1 +
 drivers/thermal/thermal_helpers.c     | 28 +++++++++++++++++----------
 3 files changed, 36 insertions(+), 14 deletions(-)

-- 
2.17.1

