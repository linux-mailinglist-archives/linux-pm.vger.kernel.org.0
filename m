Return-Path: <linux-pm+bounces-742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBD806DF4
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 12:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99271F21060
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0E531A6C;
	Wed,  6 Dec 2023 11:30:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0556A137;
	Wed,  6 Dec 2023 03:30:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4333EC15;
	Wed,  6 Dec 2023 03:31:30 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.1.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECD243F5A1;
	Wed,  6 Dec 2023 03:30:42 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH 0/5] Add callback for cooling list update to speed-up IPA
Date: Wed,  6 Dec 2023 11:31:33 +0000
Message-Id: <20231206113138.3576492-1-lukasz.luba@arm.com>
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

The goal is to move the memory allocations and heavy computations
(multiplications) out of throttle() callback hot path.

In addition there are some small clean-ups for IPA code.

Regards,
Lukasz

Lukasz Luba (5):
  thermal: core: Add callback for governors with cooling instances
    change
  thermal: gov_power_allocator: Refactor check_power_actors()
  thermal: gov_power_allocator: Move memory allocation out of throttle()
  thermal: gov_power_allocator: Simplify checks for valid power actor
  thermal: gov_power_allocator: Refactor checks in divvy_up_power()

 drivers/thermal/gov_power_allocator.c | 202 +++++++++++++++++---------
 drivers/thermal/thermal_core.c        |  14 ++
 include/linux/thermal.h               |   4 +
 3 files changed, 154 insertions(+), 66 deletions(-)

-- 
2.25.1


