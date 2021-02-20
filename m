Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E951320519
	for <lists+linux-pm@lfdr.de>; Sat, 20 Feb 2021 12:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhBTLfJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Feb 2021 06:35:09 -0500
Received: from mail-m2452.qiye.163.com ([220.194.24.52]:36310 "EHLO
        mail-m2452.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTLfJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Feb 2021 06:35:09 -0500
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Feb 2021 06:35:09 EST
Received: from localhost.localdomain (unknown [106.75.220.3])
        by mail-m2452.qiye.163.com (Hmail) with ESMTPA id 44BBB4C5032;
        Sat, 20 Feb 2021 19:27:56 +0800 (CST)
From:   Bingsong Si <owen.si@ucloud.cn>
To:     linux-pm@vger.kernel.org
Cc:     lenb@kernel.org
Subject: [PATCH] tools/power turbostat: fix offset and idx on Amd F17h and newer
Date:   Sat, 20 Feb 2021 19:27:49 +0800
Message-Id: <20210220112749.3415192-1-owen.si@ucloud.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSUI3V1ktWUFJV1kPCR
        oVCBIfWUFZGR0fTh8fSxlCThgdVkpNSkhDSUtPTE1PSUNVGRETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0JITVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OFE6ODo4MD04AzkvTE5MEi1P
        NBVPCSpVSlVKTUpIQ0lLT0xNTk9NVTMWGhIXVRQMHhVVCBI7DhgXFA4fVRgVRVlXWRILWUFZSktN
        VUxOVUlJS1VIWVdZCAFZQUpMS0M3Bg++
X-HM-Tid: 0a77bf323bb68c11kuqt44bbb4c5032
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Amd uses a different pkg energy msr, without this fix, turbostat exit
immediately on Amd Epyc Cpu.

Fixes: 3316f99a9f1 ("tools/power turbostat: Also read package power on AMD F17h (Zen)")

Signed-off-by: Bingsong Si <owen.si@ucloud.cn>
---
 tools/power/x86/turbostat/turbostat.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a7c4f0772e53..68cb2ae632de 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -297,7 +297,10 @@ int idx_to_offset(int idx)
 
 	switch (idx) {
 	case IDX_PKG_ENERGY:
-		offset = MSR_PKG_ENERGY_STATUS;
+		if (do_rapl & RAPL_AMD_F17H)
+			offset = MSR_PKG_ENERGY_STAT;
+		else
+			offset = MSR_PKG_ENERGY_STATUS;
 		break;
 	case IDX_DRAM_ENERGY:
 		offset = MSR_DRAM_ENERGY_STATUS;
@@ -326,6 +329,7 @@ int offset_to_idx(int offset)
 
 	switch (offset) {
 	case MSR_PKG_ENERGY_STATUS:
+	case MSR_PKG_ENERGY_STAT:
 		idx = IDX_PKG_ENERGY;
 		break;
 	case MSR_DRAM_ENERGY_STATUS:
-- 
2.27.0

