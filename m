Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D4D314DF9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 12:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBILN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 06:13:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12902 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhBILLz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 06:11:55 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DZgCX5gBPzjKK8;
        Tue,  9 Feb 2021 19:10:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 19:10:58 +0800
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
Subject: [PATCH v2 4/4] staging: comedi: Use subdir-ccflags-* to inherit debug flag
Date:   Tue, 9 Feb 2021 19:08:19 +0800
Message-ID: <1612868899-9185-5-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612868899-9185-1-git-send-email-yangyicong@hisilicon.com>
References: <1612868899-9185-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Junhao He <hejunhao2@hisilicon.com>

As CONFIG_COMEDI_DEBUG intends to have the DEBUG flag
recursively under drivers/staging/comedi, use
subdir-ccflags-* instead of ccflags-* will make it
clearer as the DEBUG flag will be inherited when
traversing subdirectories.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/staging/comedi/Makefile               | 2 +-
 drivers/staging/comedi/drivers/Makefile       | 1 -
 drivers/staging/comedi/drivers/tests/Makefile | 2 --
 drivers/staging/comedi/kcomedilib/Makefile    | 2 --
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/comedi/Makefile b/drivers/staging/comedi/Makefile
index 072ed83..f51cc14 100644
--- a/drivers/staging/comedi/Makefile
+++ b/drivers/staging/comedi/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-$(CONFIG_COMEDI_DEBUG)		:= -DDEBUG
+subdir-ccflags-$(CONFIG_COMEDI_DEBUG)	:= -DDEBUG
 
 comedi-y				:= comedi_fops.o range.o drivers.o \
 					   comedi_buf.o
diff --git a/drivers/staging/comedi/drivers/Makefile b/drivers/staging/comedi/drivers/Makefile
index b24ac00..7cafc36 100644
--- a/drivers/staging/comedi/drivers/Makefile
+++ b/drivers/staging/comedi/drivers/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for individual comedi drivers
 #
-ccflags-$(CONFIG_COMEDI_DEBUG)		:= -DDEBUG
 
 # Comedi "helper" modules
 obj-$(CONFIG_COMEDI_8254)		+= comedi_8254.o
diff --git a/drivers/staging/comedi/drivers/tests/Makefile b/drivers/staging/comedi/drivers/tests/Makefile
index b5d8e13..44ac13d 100644
--- a/drivers/staging/comedi/drivers/tests/Makefile
+++ b/drivers/staging/comedi/drivers/tests/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for comedi drivers unit tests
 #
-ccflags-$(CONFIG_COMEDI_DEBUG)		:= -DDEBUG
-
 obj-$(CONFIG_COMEDI_TESTS)		+= example_test.o ni_routes_test.o
 CFLAGS_ni_routes_test.o			:= -DDEBUG
diff --git a/drivers/staging/comedi/kcomedilib/Makefile b/drivers/staging/comedi/kcomedilib/Makefile
index 8031142..9f20318 100644
--- a/drivers/staging/comedi/kcomedilib/Makefile
+++ b/drivers/staging/comedi/kcomedilib/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-$(CONFIG_COMEDI_DEBUG)		:= -DDEBUG
-
 obj-$(CONFIG_COMEDI_KCOMEDILIB)	+= kcomedilib.o
 
 kcomedilib-objs := kcomedilib_main.o
-- 
2.8.1

