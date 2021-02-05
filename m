Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36902310850
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 10:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhBEJvD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 04:51:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12134 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhBEJrc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 04:47:32 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DX9Wr1cWTz164x8;
        Fri,  5 Feb 2021 17:45:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:46:39 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <giometti@enneenne.com>, <abbotti@mev.co.uk>,
        <hsweeten@visionengravers.com>, <kw@linux.com>,
        <helgaas@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kbuild@vger.kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>
CC:     <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <linuxarm@openeuler.org>
Subject: [PATCH 2/4] hwmon: Use subdir-ccflags-* to inherit debug flag
Date:   Fri, 5 Feb 2021 17:44:13 +0800
Message-ID: <1612518255-23052-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612518255-23052-1-git-send-email-yangyicong@hisilicon.com>
References: <1612518255-23052-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Junhao He <hejunhao2@hisilicon.com>

Use subdir-ccflags-* instead of ccflags-* to inherit the debug
settings from Kconfig when traversing subdirectories.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwmon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 09a86c5..1c0c089 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -201,5 +201,5 @@ obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
 obj-$(CONFIG_SENSORS_OCC)	+= occ/
 obj-$(CONFIG_PMBUS)		+= pmbus/
 
-ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
+subdir-ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
 
-- 
2.8.1

