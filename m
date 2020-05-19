Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE0F1D9020
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 08:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgESGcf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 02:32:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39444 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726943AbgESGce (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 02:32:34 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C5C95F07358CB38F3006;
        Tue, 19 May 2020 14:32:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 14:32:18 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 6/6] Documentation: ABI: make current_governer_ro as a candidate for removal
Date:   Tue, 19 May 2020 14:25:25 +0800
Message-ID: <1589869525-29893-7-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1589869525-29893-1-git-send-email-guohanjun@huawei.com>
References: <1589869525-29893-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since both current_governor and current_governor_ro co-exist under
/sys/devices/system/cpu/cpuidle/ file, and it's duplicate,
make current_governer_ro as a candidate for removal.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Doug Smythies <dsmythies@telus.net>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/ABI/obsolete/sysfs-cpuidle | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/ABI/obsolete/sysfs-cpuidle

diff --git a/Documentation/ABI/obsolete/sysfs-cpuidle b/Documentation/ABI/obsolete/sysfs-cpuidle
new file mode 100644
index 00000000..e398fb5
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-cpuidle
@@ -0,0 +1,9 @@
+What:		/sys/devices/system/cpu/cpuidle/current_governor_ro
+Date:		April, 2020
+Contact:	linux-pm@vger.kernel.org
+Description:
+	current_governor_ro shows current using cpuidle governor, but read only.
+	with the update that cpuidle governor can be changed at runtime in default,
+	both current_governor and current_governor_ro co-exist under
+	/sys/devices/system/cpu/cpuidle/ file, it's duplicate so make
+	current_governor_ro obselete.
-- 
1.7.12.4

