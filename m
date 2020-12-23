Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D502E1979
	for <lists+linux-pm@lfdr.de>; Wed, 23 Dec 2020 08:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgLWHt7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Dec 2020 02:49:59 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39247 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727063AbgLWHt6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2020 02:49:58 -0500
X-UUID: f1eb7a0b826f48c39453b49c5c9ef7ea-20201223
X-UUID: f1eb7a0b826f48c39453b49c5c9ef7ea-20201223
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 164922422; Wed, 23 Dec 2020 15:49:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Dec 2020 15:48:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 15:48:49 +0800
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
Subject: [PATCH] thermal: cpufreq_cooling: fix slab OOB issue
Date:   Wed, 23 Dec 2020 15:48:49 +0800
Message-ID: <20201223074849.1989-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
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

Signed-off-by: brian-sy yang <brian-sy.yang@mediatek.com>
---
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

