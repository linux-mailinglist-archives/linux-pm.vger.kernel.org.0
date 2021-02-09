Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80D314E02
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 12:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhBILOE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 06:14:04 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12882 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhBILLx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 06:11:53 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DZgC819fdz7jJr;
        Tue,  9 Feb 2021 19:09:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 19:10:57 +0800
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
Subject: [PATCH v2 0/4] Use subdir-ccflags-* to inherit debug flag
Date:   Tue, 9 Feb 2021 19:08:15 +0800
Message-ID: <1612868899-9185-1-git-send-email-yangyicong@hisilicon.com>
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
in the sub-directories, or they use per subdirectory
ccflags-* to have DEBUG with the same kconfig option.

Considering they intends to enable debug for all the files
under the directory with the same kconfig option, it will
be clearer to use subdir-ccflags-* instead of ccflags-*
to inherit the debug settings from Kconfig when traversing
subdirectories.

We primarily find this issue when debugging PCIe and thought
other drivers may also have this issues. Previous discussion
can be find at
https://lore.kernel.org/linux-pci/1612438215-33105-1-git-send-email-yangyicong@hisilicon.com/

Change since v1:
- reword the commits to illustrate the reasons of the change and the benefits.
v1: https://lore.kernel.org/lkml/1612518255-23052-1-git-send-email-yangyicong@hisilicon.com/

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

