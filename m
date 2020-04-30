Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28CE1BF35A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 10:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgD3Iqt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 04:46:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3396 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbgD3Iqs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Apr 2020 04:46:48 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5ABEF243B61531968836;
        Thu, 30 Apr 2020 16:46:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 16:46:12 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [RFC v2 PATCH 6/6] Documentation: ABI: make current_governer_ro as a candidate for removal
Date:   Thu, 30 Apr 2020 16:39:47 +0800
Message-ID: <1588235987-12300-7-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
References: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since both current_governor and current_governor_ro co-exist under
/sys/devices/te system/cpu/cpuidle/ file, and it's duplicate,
make current_governer_ro as a candidate for removal.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 Documentation/ABI/obsolete/sysfs-cpuidle | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/ABI/obsolete/sysfs-cpuidle

diff --git a/Documentation/ABI/obsolete/sysfs-cpuidle b/Documentation/ABI/obsolete/sysfs-cpuidle
new file mode 100644
index 00000000..f984b9c
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
+	/sys/devices/te system/cpu/cpuidle/ file, it's duplicate so make
+	current_governor_ro obselete.
-- 
1.7.12.4

