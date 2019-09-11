Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A52B045C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 21:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfIKTCx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 15:02:53 -0400
Received: from 8.mo7.mail-out.ovh.net ([46.105.77.114]:53498 "EHLO
        8.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfIKTCx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 15:02:53 -0400
X-Greylist: delayed 19200 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 15:02:52 EDT
Received: from player168.ha.ovh.net (unknown [10.109.143.175])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 3429C132148
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2019 15:04:09 +0200 (CEST)
Received: from qperret.net (115.ip-51-255-42.eu [51.255.42.115])
        (Authenticated sender: qperret@qperret.net)
        by player168.ha.ovh.net (Postfix) with ESMTPSA id BE701997FF58;
        Wed, 11 Sep 2019 13:03:51 +0000 (UTC)
From:   Quentin Perret <qperret@qperret.net>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qperret@qperret.net
Subject: [PATCH v8 2/4] PM / EM: Declare EM data types unconditionally
Date:   Wed, 11 Sep 2019 15:03:12 +0200
Message-Id: <20190911130314.29973-3-qperret@qperret.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911130314.29973-1-qperret@qperret.net>
References: <20190911130314.29973-1-qperret@qperret.net>
X-Ovh-Tracer-Id: 17350399039456041977
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Quentin Perret <quentin.perret@arm.com>

The structs representing capacity states and performance domains of an
Energy Model are currently only defined for CONFIG_ENERGY_MODEL=y. That
makes it hard for code outside PM_EM to manipulate those structures
without a lot of ifdefery or stubbed accessors.

So, move the declaration of the two structs outside of the
CONFIG_ENERGY_MODEL ifdef. The client code (e.g. EAS or thermal) always
checks the return of em_cpu_get() before using it, so the exising code
is still safe to use as-is.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/energy_model.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 73f8c3cb9588..d249b88a4d5a 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -9,7 +9,6 @@
 #include <linux/sched/topology.h>
 #include <linux/types.h>
 
-#ifdef CONFIG_ENERGY_MODEL
 /**
  * em_cap_state - Capacity state of a performance domain
  * @frequency:	The CPU frequency in KHz, for consistency with CPUFreq
@@ -40,6 +39,7 @@ struct em_perf_domain {
 	unsigned long cpus[0];
 };
 
+#ifdef CONFIG_ENERGY_MODEL
 #define EM_CPU_MAX_POWER 0xFFFF
 
 struct em_data_callback {
@@ -160,7 +160,6 @@ static inline int em_pd_nr_cap_states(struct em_perf_domain *pd)
 }
 
 #else
-struct em_perf_domain {};
 struct em_data_callback {};
 #define EM_DATA_CB(_active_power_cb) { }
 
-- 
2.22.1

