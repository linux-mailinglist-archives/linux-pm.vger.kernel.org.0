Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405AD346209
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 15:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhCWO4c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 10:56:32 -0400
Received: from foss.arm.com ([217.140.110.172]:47636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232308AbhCWO40 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 10:56:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB83BD6E;
        Tue, 23 Mar 2021 07:56:25 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.6.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2B6D3F718;
        Tue, 23 Mar 2021 07:56:23 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, rafael@kernel.org
Cc:     ionela.voinescu@arm.com, Dietmar.Eggemann@arm.com,
        lukasz.luba@arm.com, gregkh@linuxfoundation.org
Subject: [PATCH] PM / EM: postpone creating the debugfs dir till fs_initcall
Date:   Tue, 23 Mar 2021 14:56:08 +0000
Message-Id: <20210323145608.29832-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The debugfs directory '/sys/kernel/debug/energy_model' is needed before
the Energy Model registration can happen. With the recent change in
debugfs subsystem it's not allowed to create this directory at early stage
(core_initcall). Thus creating this directory would fail.
Postpone the creation of the EM debug dir to later stage: fs_initcall.
It should be safe since all clients: CPUFreq drivers, Devfreq drivers will
be initialized in later stages.
The custom debug log below prints the time of creation the EM debug dir at
fs_initcall and successful registration of EMs at later stages.

[    1.505717] energy_model: creating rootdir
[    3.698307] cpu cpu0: EM: created perf domain
[    3.709022] cpu cpu1: EM: created perf domain

fixes: 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi Rafael,

Please take this patch into your PM v5.12 fixes. The change described in
the patch above landed in v5.12-rc1. Some of our EAS/EM tests are failing.

Regards,
Lukasz

 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 1358fa4abfa8..0f4530b3a8cd 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -98,7 +98,7 @@ static int __init em_debug_init(void)
 
 	return 0;
 }
-core_initcall(em_debug_init);
+fs_initcall(em_debug_init);
 #else /* CONFIG_DEBUG_FS */
 static void em_debug_create_pd(struct device *dev) {}
 static void em_debug_remove_pd(struct device *dev) {}
-- 
2.17.1

