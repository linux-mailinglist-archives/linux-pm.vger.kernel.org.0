Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2204A3504AA
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhCaQea (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 12:34:30 -0400
Received: from foss.arm.com ([217.140.110.172]:46484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233706AbhCaQeT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 12:34:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E266D6E;
        Wed, 31 Mar 2021 09:34:19 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF6F93F792;
        Wed, 31 Mar 2021 09:34:17 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH 0/2] Improve IPA mechanisms in low temperature state
Date:   Wed, 31 Mar 2021 17:33:50 +0100
Message-Id: <20210331163352.32416-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch set aims to address the issues present in IPA when the
temperature is below the first trip point and cooling devices are not
throttled.
The first patch adds a basic check of cooling devices power to keep the
internal statistics fresh. This allows to avoid issue when the statistics
cover very long period, because they were not maintained.
The second patch addressed an issue described in bugzilla [1], which is:
unnecessary updating cooling devices when their state has not changed
because they are not throttled. This update triggers sending an event,
which should be avoided. Thus, patch 2/2 adds a tracking mechanism if
the update was triggered and makes sure it will be done only once when
the temperature continue to stay below first trip point.

Regards,
Lukasz Luba

[1] https://bugzilla.kernel.org/show_bug.cgi?id=212501

Lukasz Luba (2):
  thermal: power_allocator: maintain the device statistics from going
    stale
  thermal: power_allocator: update once cooling devices when temp is low

 drivers/thermal/gov_power_allocator.c | 33 +++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

-- 
2.17.1

