Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D374C223364
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 08:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgGQGJh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 02:09:37 -0400
Received: from mail5.windriver.com ([192.103.53.11]:60090 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgGQGJh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Jul 2020 02:09:37 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 06H68dvf000744
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 16 Jul 2020 23:09:10 -0700
Received: from pek-lpggp3.wrs.com (128.224.153.76) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Thu, 16 Jul 2020
 23:08:53 -0700
From:   Liwei Song <liwei.song@windriver.com>
To:     Len Brown <lenb@kernel.org>, <linux-pm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <liwei.song@windriver.com>
Subject: [PATCH] tools/power turbostat: call pread64 in kernel directly
Date:   Fri, 17 Jul 2020 14:08:49 +0800
Message-ID: <20200717060849.12469-1-liwei.song@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

with 32-bit rootfs, the offset may out of range when set it
to 0xc0010299, define it as "unsigned long long" type and
call pread64 directly in kernel.

Signed-off-by: Liwei Song <liwei.song@windriver.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..4c5cdfcb5721 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -33,6 +33,7 @@
 #include <sys/capability.h>
 #include <errno.h>
 #include <math.h>
+#include <sys/syscall.h>
 
 char *proc_stat = "/proc/stat";
 FILE *outf;
@@ -381,11 +382,11 @@ int get_msr_fd(int cpu)
 	return fd;
 }
 
-int get_msr(int cpu, off_t offset, unsigned long long *msr)
+int get_msr(int cpu, unsigned long long offset, unsigned long long *msr)
 {
 	ssize_t retval;
 
-	retval = pread(get_msr_fd(cpu), msr, sizeof(*msr), offset);
+	retval = syscall(SYS_pread64, get_msr_fd(cpu), msr, sizeof(*msr), offset);
 
 	if (retval != sizeof *msr)
 		err(-1, "cpu%d: msr offset 0x%llx read failed", cpu, (unsigned long long)offset);
-- 
2.17.1

