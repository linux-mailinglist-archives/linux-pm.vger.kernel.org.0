Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE46E35E7C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfFEN6k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 09:58:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfFEN6k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 09:58:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C07553107B05;
        Wed,  5 Jun 2019 13:58:35 +0000 (UTC)
Received: from prarit.khw1.lab.eng.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 564175C22B;
        Wed,  5 Jun 2019 13:58:35 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-pm@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH] turbostat: Fix Haswell Core systems
Date:   Wed,  5 Jun 2019 09:58:30 -0400
Message-Id: <20190605135830.23941-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 05 Jun 2019 13:58:40 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Haswell (model 0x3C) turbostat fails with

turbostat: cpu0: msr offset 0x630 read failed: Input/output error

because Haswell Core does not have C8-C10.

Output C8-C10 only on Haswell ULT.

Fixes: f5a4c76ad7de ("tools/power turbostat: consolidate duplicate model
numbers")
Cc: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c7727be9719f..ec8797005731 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4296,7 +4296,7 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL_ULT:
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
-- 
2.21.0

