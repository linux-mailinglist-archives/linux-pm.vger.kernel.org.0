Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDFA68F35B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 17:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjBHQkB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 11:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjBHQkA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 11:40:00 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC04DBF0
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 08:39:51 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PBm1b5Zncz9sVy;
        Wed,  8 Feb 2023 17:39:47 +0100 (CET)
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     linux-pm@vger.kernel.org
Cc:     Hagen Paul Pfeifer <hagen@jauu.net>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vinay Kumar <vinay.kumar@intel.com>
Subject: [PATCH] intel_idle: add support for Intel Raptorlake
Date:   Wed,  8 Feb 2023 17:39:34 +0100
Message-Id: <20230208163934.6119-1-hagen@jauu.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RPL misses Intel Idle (C State) support and ACPI is used as an fallback.
The mircoarchitecture between ADL and RPL does not differ on the power
management critical aspects, so ADL can be used as a base at this point.

Before:

  $ grep . /sys/devices/system/cpu/cpu0/cpuidle/state*/name
  /sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
  /sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1_ACPI
  /sys/devices/system/cpu/cpu0/cpuidle/state2/name:C2_ACPI
  /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3_ACPI

After:

  grep . /sys/devices/system/cpu/cpu0/cpuidle/state*/name
  /sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
  /sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1E
  /sys/devices/system/cpu/cpu0/cpuidle/state2/name:C6
  /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C8
  /sys/devices/system/cpu/cpu0/cpuidle/state4/name:C10

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Vinay Kumar <vinay.kumar@intel.com>
Signed-off-by: Hagen Paul Pfeifer <hagen@jauu.net>
---

I skipped RAPTORLAKE_P and RAPTORLAKE_S lineup support - just because of
missing testing capability. But can be added and will be (implicitly)
tested by -rcX users during merge window. Can be cooked in a v2?!
---
 drivers/idle/intel_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index cfeb24d40d37..d1a88dfdbc53 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1436,6 +1436,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&idle_cpu_bxt),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&idle_cpu_dnv),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&idle_cpu_snr),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&idle_cpu_adl),
 	{}
 };
 
@@ -1867,6 +1868,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
 	case INTEL_FAM6_ALDERLAKE_N:
+	case INTEL_FAM6_RAPTORLAKE:
 		adl_idle_state_table_update();
 		break;
 	}
-- 
2.39.1

