Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50902E6E0E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 06:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgL2FJh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 00:09:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44775 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725967AbgL2FJg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Dec 2020 00:09:36 -0500
X-UUID: e4301387693b4638b66833880f68d291-20201229
X-UUID: e4301387693b4638b66833880f68d291-20201229
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 401845018; Tue, 29 Dec 2020 13:08:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Dec 2020 13:09:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 13:09:36 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     <michael.kao@mediatek.com>, <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        brian-sy yang <brian-sy.yang@mediatek.com>
Subject: [PATCH v2] thermal: cpufreq_cooling: fix slab OOB issue
Date:   Tue, 29 Dec 2020 13:08:31 +0800
Message-ID: <20201229050831.19493-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 89869AB40C5636F00832BEFA7C75FECE2ED5AC7D82557EE0D66B7497DA6FFB252000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: brian-sy yang <brian-sy.yang@mediatek.com>

Slab OOB issue is scanned by KASAN in cpu_power_to_freq().
If power is limited below the power of OPP0 in EM table,
it will cause slab out-of-bound issue with negative array
index.

Return the lowest frequency if limited power cannot found
a suitable OPP in EM table to fix this issue.

Backtrace:
[<ffffffd02d2a37f0>] die+0x104/0x5ac
[<ffffffd02d2a5630>] bug_handler+0x64/0xd0
[<ffffffd02d288ce4>] brk_handler+0x160/0x258
[<ffffffd02d281e5c>] do_debug_exception+0x248/0x3f0
[<ffffffd02d284488>] el1_dbg+0x14/0xbc
[<ffffffd02d75d1d4>] __kasan_report+0x1dc/0x1e0
[<ffffffd02d75c2e0>] kasan_report+0x10/0x20
[<ffffffd02d75def8>] __asan_report_load8_noabort+0x18/0x28
[<ffffffd02e6fce5c>] cpufreq_power2state+0x180/0x43c
[<ffffffd02e6ead80>] power_actor_set_power+0x114/0x1d4
[<ffffffd02e6fac24>] allocate_power+0xaec/0xde0
[<ffffffd02e6f9f80>] power_allocator_throttle+0x3ec/0x5a4
[<ffffffd02e6ea888>] handle_thermal_trip+0x160/0x294
[<ffffffd02e6edd08>] thermal_zone_device_check+0xe4/0x154
[<ffffffd02d351cb4>] process_one_work+0x5e4/0xe28
[<ffffffd02d352f44>] worker_thread+0xa4c/0xfac
[<ffffffd02d360124>] kthread+0x33c/0x358
[<ffffffd02d289940>] ret_from_fork+0xc/0x18

Fixes: 371a3bc79c11b ("thermal/drivers/cpufreq_cooling: Fix wrong frequency converted from power")
Signed-off-by: brian-sy yang <brian-sy.yang@mediatek.com>
Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---

Changes from v1:
- add fixes tag
- add reviewed-by

 drivers/thermal/cpufreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index cc2959f22f01..fb33b3480a8f 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -123,7 +123,7 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 {
 	int i;
 
-	for (i = cpufreq_cdev->max_level; i >= 0; i--) {
+	for (i = cpufreq_cdev->max_level; i > 0; i--) {
 		if (power >= cpufreq_cdev->em->table[i].power)
 			break;
 	}
-- 
2.18.0

