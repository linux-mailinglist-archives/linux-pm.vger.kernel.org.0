Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47CD30167B
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbhAWPuL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 10:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbhAWPuJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 10:50:09 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C6EC06174A
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 07:49:28 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s3so1683455edt.7
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=basnieuwenhuizen.nl; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zyl5GSBGd/oNImpJtBfc3jd3P4/zNXMNogqjsD66BjM=;
        b=gCxJ38IX0080P2+aTGNBI+D0is0EdqbNxp2mx2j09uFmiDKwMH8EVxlW9DoiTUdvCo
         RerNaBXDvB7pIk/fWKu+9xII7DFE5QHVYVxNIi2+sjSCSmf0PNRIIUWL9t9Aj/JljBdl
         qTEMVrPcUR2UM4Wy4+6nYcyny4wqeAOTB6+RA03EkvAQGtj+XQt355eb4xsp1VveJtK/
         NYXD+79FkUmQobcOXJXh+uG76cj9MSvGmA3AQreoadDaMiClkO/ZI45O5+jKPMM4I/E3
         1mWSB0JRNFog9gPRiZ9koqNqfxDz8Pix0oMdLPc1XWGMJTavIuKOWZUR7t+LaTX7W5Jk
         /ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zyl5GSBGd/oNImpJtBfc3jd3P4/zNXMNogqjsD66BjM=;
        b=ElRjjWIUMBjXMtNSq6tVDrd/I3yMLktgxGJhQTwWtdl2HOMK7cf/Tq0/v13BR3oEoI
         VZKweOxWvOTlXAF0gAvDX04/24UYNGb2y4sbhC/QvwoLfjY2cfvSEdHhlZ6GKDyYjqQX
         O2meHq/+cfhpDdUpB8qF/73A8TscoMeKOydqRDKLYxk+acf3B3VEP2C8TXx1yjFiSJ25
         gkeax8V0FdjyYY5eLZCi9rnHQxEiS9Bf5npZkpTXZITEJUjRcHmRU9m2NVXkIgXvPKop
         LdTuc1e/9Ny0NiDKBcEKbFLUjs0o4I0My4LiFeJxll4LYFzmrpLg2NTSuYk+izlMotSy
         xd4w==
X-Gm-Message-State: AOAM531b2sWI8WiG3I6nldMuLQGg0xlAoUFwLy5jE2SrArzrmHasddZS
        ggjqxXJjI76AI3QqUMDqBr8K2RJC2xbJgQ==
X-Google-Smtp-Source: ABdhPJyOR6ssVkf+4lzRydqeHrecU/4X2i4gJsO1xChO3e8+nl2S150id4A50d5NGiMMyVYC9tCJkQ==
X-Received: by 2002:a05:6402:1f4:: with SMTP id i20mr2447982edy.180.1611416967520;
        Sat, 23 Jan 2021 07:49:27 -0800 (PST)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
        by smtp.gmail.com with ESMTPSA id x17sm7184534edd.76.2021.01.23.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 07:49:26 -0800 (PST)
From:   Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To:     linux-pm@vger.kernel.org
Cc:     lenb@kernel.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen CPUs
Date:   Sat, 23 Jan 2021 16:50:03 +0100
Message-Id: <20210123155003.30370-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On my Zen+ system turbostat started exiting, which I tracked
down to the MSR_PKG_ENERGY_STAT read failing because
offset_to_idx wasn't returning a non-negative index.

This adds the MSR to the index system as alternative for
MSR_PKG_ENERGY_STATUS.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 389ea5209a83..6b9528d96c48 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -297,7 +297,10 @@ int idx_to_offset(int idx)
 
 	switch (idx) {
 	case IDX_PKG_ENERGY:
-		offset = MSR_PKG_ENERGY_STATUS;
+		if (do_rapl & RAPL_PKG)
+			offset = MSR_PKG_ENERGY_STATUS;
+		else
+			offset = MSR_PKG_ENERGY_STAT;
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
2.29.2

