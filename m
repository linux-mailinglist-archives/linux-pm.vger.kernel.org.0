Return-Path: <linux-pm+bounces-967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C3A80EE03
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7732B20D85
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EF16DD02;
	Tue, 12 Dec 2023 13:48:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D058100;
	Tue, 12 Dec 2023 05:47:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42004143D;
	Tue, 12 Dec 2023 05:48:43 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0E613F738;
	Tue, 12 Dec 2023 05:47:55 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v2 0/8] Add callback for cooling list update to speed-up IPA
Date: Tue, 12 Dec 2023 13:48:36 +0000
Message-Id: <20231212134844.1213381-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

The patch set a new callback for thermal governors and implementation for
Intelligent Power Allocator.

The goal is to move some heavy operarions like the memory allocations and heavy
computations (multiplications) out of throttle() callback hot path.

The new callback is generic enough to handle other imporants update events.
It re-uses existing thermal_notify_event definitions.

In addition there are some small clean-ups for IPA code.

changes:
v2:
- change callback name to update_tz() and add parameter (Rafael)
- added new event to trigger this callback - instance 'weight' update

Regards,
Lukasz

Lukasz Luba (8):
  thermal: core: Add governor callback for thermal zone change
  thermal: gov_power_allocator: Refactor check_power_actors()
  thermal: gov_power_allocator: Move memory allocation out of throttle()
  thermal: gov_power_allocator: Simplify checks for valid power actor
  thermal: gov_power_allocator: Refactor checks in divvy_up_power()
  thermal/sysfs: Update instance->weight under tz lock
  thermal/sysfs: Update governors when the 'weight' has changed
  thermal: gov_power_allocator: Support new update callback of weights

 drivers/thermal/gov_power_allocator.c | 216 ++++++++++++++++++--------
 drivers/thermal/thermal_core.c        |  13 ++
 drivers/thermal/thermal_sysfs.c       |  15 ++
 include/linux/thermal.h               |   6 +
 4 files changed, 182 insertions(+), 68 deletions(-)

-- 
2.25.1


