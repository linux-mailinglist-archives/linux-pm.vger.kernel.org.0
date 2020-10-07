Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD3C285F0A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgJGMXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 08:23:34 -0400
Received: from foss.arm.com ([217.140.110.172]:42872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgJGMXe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 08:23:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C10B81042;
        Wed,  7 Oct 2020 05:23:33 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.52.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDAC03F71F;
        Wed,  7 Oct 2020 05:23:23 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com,
        michael.kao@mediatek.com, rui.zhang@intel.com
Subject: [PATCH 0/3] Add upper and lower limits in IPA power budget calculation
Date:   Wed,  7 Oct 2020 13:22:53 +0100
Message-Id: <20201007122256.28080-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch set makes thermal governor Intelligent Power Allocation (IPA)
aware of cooling device limits for upper and lower bounds and respects them
in the internal power budget calculation.
The patch set should be applied on top of some already posted IPA changes [1][2].

Regards,
Lukasz

[1] https://lore.kernel.org/linux-pm/20201002122416.13659-1-lukasz.luba@arm.com/
[2] https://lore.kernel.org/linux-pm/9ecedd8a-fbc3-895c-d79c-f05af5c90ae5@arm.com/T/#t

Lukasz Luba (3):
  thermal: power_allocator: respect upper and lower bounds for cooling
    device
  thermal: core: remove unused functions in power actor section
  thermal: move power_actor_set_power into IPA

 drivers/thermal/gov_power_allocator.c | 38 ++++++++++-
 drivers/thermal/thermal_core.c        | 90 ---------------------------
 drivers/thermal/thermal_core.h        |  6 --
 3 files changed, 36 insertions(+), 98 deletions(-)

-- 
2.17.1

