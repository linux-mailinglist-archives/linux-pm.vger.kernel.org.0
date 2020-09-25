Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB68278C67
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 17:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgIYPVG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 11:21:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:34936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgIYPVG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Sep 2020 11:21:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03F05AFF8;
        Fri, 25 Sep 2020 15:21:05 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, Lv Zheng <lv.zheng@intel.com>
Subject: tools/power/acpi: Serialize Makefile
Date:   Fri, 25 Sep 2020 17:21:04 +0200
Message-ID: <1967924.6sJ7JGzvSp@c100>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Before this patch you get tools/power/acpi/Makefile.rules
included in parallel trying to copy KERNEL_INCLUDE multiple
times:

make -j20 acpi
  DESCEND  power/acpi
  DESCEND  tools/acpidbg
  DESCEND  tools/acpidump
  DESCEND  tools/ec
  MKDIR    include
  MKDIR    include
  MKDIR    include
  CP       include
  CP       include
cp: cannot create directory '/home/abuild/rpmbuild/BUILD/linux-5.7.7+git20200917.10b82d517648/tools/power/acpi/include/acpi': File exists
make[2]: *** [../../Makefile.rules:20: /home/abuild/rpmbuild/BUILD/linux-5.7.7+git20200917.10b82d517648/tools/power/acpi/include] Error 1
make[1]: *** [Makefile:16: acpidbg] Error 2
make[1]: *** Waiting for unfinished jobs....

with this patch each subdirectory will be processed serialized:

  DESCEND  power/acpi
  DESCEND  tools/acpidbg
  MKDIR    include
  CP       include
  CC       tools/acpidbg/acpidbg.o
  LD       acpidbg
  STRIP    acpidbg
  DESCEND  tools/acpidump
  CC       tools/acpidump/apdump.o
...
  LD       acpidump
  STRIP    acpidump
  DESCEND  tools/ec
  CC       tools/ec/ec_access.o
  LD       ec
  STRIP    ec

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 tools/power/acpi/Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/tools/power/acpi/Makefile
+++ b/tools/power/acpi/Makefile
@@ -7,6 +7,8 @@
 
 include ../../scripts/Makefile.include
 
+.NOTPARALLEL:
+
 all: acpidbg acpidump ec
 clean: acpidbg_clean acpidump_clean ec_clean
 install: acpidbg_install acpidump_install ec_install



