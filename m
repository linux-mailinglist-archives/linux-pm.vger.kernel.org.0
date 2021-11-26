Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A319145E56E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 03:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358130AbhKZCmL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 21:42:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357808AbhKZCkL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Nov 2021 21:40:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA58661246;
        Fri, 26 Nov 2021 02:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637894050;
        bh=06hdsoMWR+nlY7xtQxV2IWooLhbGfGJIcGNAqt4e7aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5VTEja/NgDFcTd6KloYPijLJS+6octkho/5BZPbVKQck9dLjlmk3kR4IR7SFQEWg
         kXggMQTDscJJNjwtg8KWZiJoZ4EvKCxxKa50suy62R/vFsVATV0G6cgr5fIbBKJ4Kc
         OLhkxqBrRG+VMaKibXIRMyHDub9UiRMkTvDMaSn9Llmmi5/fEo49Of42dI8FDiBGG8
         APy5w6sfnQfGZdcMf+jvC/PMIpzur367qC12NUosc39nKsnALgSHHlAMRxVweBYIK2
         hkp63Gha7OWwcxpbrq95N2IwmThg62yYiKYv/reRtXqIX7yBi8TQzNpYF3gOWyZw4k
         ushCiYguVtBOg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 16/28] thermal: core: Reset previous low and high trip during thermal zone init
Date:   Thu, 25 Nov 2021 21:33:31 -0500
Message-Id: <20211126023343.442045-16-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211126023343.442045-1-sashal@kernel.org>
References: <20211126023343.442045-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>

[ Upstream commit 99b63316c39988039965693f5f43d8b4ccb1c86c ]

During the suspend is in process, thermal_zone_device_update bails out
thermal zone re-evaluation for any sensor trip violation without
setting next valid trip to that sensor. It assumes during resume
it will re-evaluate same thermal zone and update trip. But when it is
in suspend temperature goes down and on resume path while updating
thermal zone if temperature is less than previously violated trip,
thermal zone set trip function evaluates the same previous high and
previous low trip as new high and low trip. Since there is no change
in high/low trip, it bails out from thermal zone set trip API without
setting any trip. It leads to a case where sensor high trip or low
trip is disabled forever even though thermal zone has a valid high
or low trip.

During thermal zone device init, reset thermal zone previous high
and low trip. It resolves above mentioned scenario.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 17de8a9b991e9..d9e34ac376626 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -474,6 +474,8 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *pos;
 	tz->temperature = THERMAL_TEMP_INVALID;
+	tz->prev_low_trip = -INT_MAX;
+	tz->prev_high_trip = INT_MAX;
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
 		pos->initialized = false;
 }
-- 
2.33.0

