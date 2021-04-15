Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB20135FFCD
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 04:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhDOCFv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 22:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDOCFu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Apr 2021 22:05:50 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF90C061756
        for <linux-pm@vger.kernel.org>; Wed, 14 Apr 2021 19:05:27 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id i6so7455385qti.10
        for <linux-pm@vger.kernel.org>; Wed, 14 Apr 2021 19:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=6xhuUVgjBAC1B6CSbTxZXzScfJ4bMKqw6vDHawJD1C4=;
        b=Jqmm8OgSc88cnUqwazmpGrij1003UuKustveP2GDVtNaaRF13m12U88Ofd/giO5FZ8
         dw4kD5RR/jEHCJXIH+ne0DgEG0vjBXIcfNFCeqHDHDEE/8XLYFGLU+dhzh4b/KGYc/g0
         kIMqpnV0UT5//s2nswOY/Re/fAmt3WgocLbT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=6xhuUVgjBAC1B6CSbTxZXzScfJ4bMKqw6vDHawJD1C4=;
        b=CnXznqBb4r2R4Kg/oKjOIBbZaS5RGYduSwMuqH+oAtipXbIsYVL7mGRHC74L2/RQWN
         1DVTWBM7z56oKsjISOPzoXhusttttzNwnezIoK1We7pPPsDgOvEoqWdAVMNL/LPBMaMX
         VmoDerFpivp4LMgMVVW5+C3j8IYxWJtP9UiceSBwCxjNHTNZMmSeUETJQ3v6CnXRK0tj
         OmidhZcSZH92yxp/bGlB7pW+Tt3BbIoTzdFdoXUMno5u+u7BrZ7IPR6zFGT6ZE7B/d32
         Ngr8PL7PytG7WAqdHc6b2AsEZdJT2BQoyRBHCG/Q9aQbfN2bdCUHCAa3jEw4d1bf9CM+
         TQtA==
X-Gm-Message-State: AOAM533v2ziYSgUVkR41bva0WGe4UylyP+DHQcuy8UwUsPeddYjpVZi2
        M8qD6YFSjV36F0+W+TdOuSF4IkY7ZbnJ2cY7
X-Google-Smtp-Source: ABdhPJyFOL+4vGBXdOfpecXwAwZ83EwIJMAtJadyx0Rf90fufgsZ21AA3mETfYaoxkeAM+hhPvhxrw==
X-Received: by 2002:ac8:45c6:: with SMTP id e6mr1017883qto.228.1618452326372;
        Wed, 14 Apr 2021 19:05:26 -0700 (PDT)
Received: from saya.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id f27sm925917qkh.118.2021.04.14.19.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:05:25 -0700 (PDT)
Message-ID: <88d11c19e662f67ae492eb4b93e12e1b24e68c1d.camel@kepstin.ca>
Subject: [PATCH] Fix turbostat exiting with an error when run on AMD CPUs
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Linux PM list <linux-pm@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>
Date:   Wed, 14 Apr 2021 22:05:24 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current version of turbostat exits immediately upon entering the
main loop, with error code -13. This is a regression that was introducted
in these commits:

9972d5d84d76 tools/power turbostat: Enable accumulate RAPL display
87e15da95775 tools/power turbostat: Introduce functions to accumulate RAPL consumption

Which introduced a method to accumulate MSR values over long sampling
durations.

The commits failed to account for the fact that AMD CPUs use a different
(but confusingly similarly named) MSR for reading the package energy.
I've added the AMD version of the MSR to the methods so that turbostat
can be run again.

(If you run on a system with mixed Intel and AMD cpus, you might have
problems, but I have been assured that this isn't likely in practice.)

The MSR offsets in the conversion functions have been switched to use
type off_t, since the offsets of the AMD MSRs exceed the range of a
signed 32-bit int.

Note that since the framework introduced only handles per-cpu MSRs but not
per-core MSRs, AMD "Core" energy is not currently accumulated over long
sampling periods.

Fixes: 9972d5d84d76982606806b2ce887f70c2f8ba60a
Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
---
 tools/power/x86/turbostat/turbostat.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a7c4f0772e53..576e03d373c4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -291,13 +291,16 @@ struct msr_sum_array {
 /* The percpu MSR sum array.*/
 struct msr_sum_array *per_cpu_msr_sum;
 
-int idx_to_offset(int idx)
+off_t idx_to_offset(int idx)
 {
-	int offset;
+	off_t offset;
 
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
@@ -320,11 +323,12 @@ int idx_to_offset(int idx)
 	return offset;
 }
 
-int offset_to_idx(int offset)
+int offset_to_idx(off_t offset)
 {
 	int idx;
 
 	switch (offset) {
+	case MSR_PKG_ENERGY_STAT:
 	case MSR_PKG_ENERGY_STATUS:
 		idx = IDX_PKG_ENERGY;
 		break;
@@ -353,7 +357,7 @@ int idx_valid(int idx)
 {
 	switch (idx) {
 	case IDX_PKG_ENERGY:
-		return do_rapl & RAPL_PKG;
+		return do_rapl & (RAPL_PKG | RAPL_AMD_F17H);
 	case IDX_DRAM_ENERGY:
 		return do_rapl & RAPL_DRAM;
 	case IDX_PP0_ENERGY:
-- 
2.31.1



