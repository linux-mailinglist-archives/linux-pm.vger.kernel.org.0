Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E75310857
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 10:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBEJv1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 04:51:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12135 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhBEJrb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 04:47:31 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DX9Wr253Mz164xC;
        Fri,  5 Feb 2021 17:45:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:46:38 +0800
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
Subject: [PATCH 0/4] Use subdir-ccflags-* to inherit debug flag
Date:   Fri, 5 Feb 2021 17:44:11 +0800
Message-ID: <1612518255-23052-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Few drivers use ccflags-* in their top directory to enable
-DDEBUG, but don't have config options to enable debug
in the sub-directories. They should want the subdirectories
inherit the debug flag from the top.

Use subdir-ccflags-* instead of ccflags-* to inherit the debug
settings from Kconfig when traversing subdirectories.

We primarily find this issue when debugging PCIe and other
drivers may also have this issues. Previous discussion can
be find at
https://lore.kernel.org/linux-pci/1612438215-33105-1-git-send-email-yangyicong@hisilicon.com/

Junhao He (4):
  driver core: Use subdir-ccflags-* to inherit debug flag
  hwmon: Use subdir-ccflags-* to inherit debug flag
  pps: Use subdir-ccflags-* to inherit debug flag
  staging: comedi: Use subdir-ccflags-* to inherit debug flag

 drivers/base/Makefile                         | 2 +-
 drivers/base/power/Makefile                   | 2 --
 drivers/hwmon/Makefile                        | 2 +-
 drivers/pps/Makefile                          | 2 +-
 drivers/staging/comedi/Makefile               | 2 +-
 drivers/staging/comedi/drivers/Makefile       | 1 -
 drivers/staging/comedi/drivers/tests/Makefile | 2 --
 drivers/staging/comedi/kcomedilib/Makefile    | 2 --
 8 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.8.1

