Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599F11945C2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 18:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgCZRr3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 13:47:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:24017 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgCZRr3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 13:47:29 -0400
IronPort-SDR: XVCY0YJ8OVdC0oZA+qecrALSFzJHOYxW41Qc/fhL4B5NLTXhEb8geS7Uw+YnLDHTB0aW3rA0pU
 CZe/RXGdvLUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 10:47:28 -0700
IronPort-SDR: /9Mch0sTAXIZmgMS9wHyoh9oSUrvPC8OuVMYkbCJIDWODvYg4uoXOwGCou4XMiH8hN5skBX9bJ
 B5u3chFPcjow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="394087896"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by orsmga004.jf.intel.com with ESMTP; 26 Mar 2020 10:47:28 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     lenb@kernel.org, linux-pm@vger.kernel.org
Cc:     azhar.shaikh@intel.com
Subject: [PATCH v2] tools/power turbostat: Update the field name for PkgC10
Date:   Thu, 26 Mar 2020 10:47:35 -0700
Message-Id: <20200326174735.29636-1-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The field name for PkgC10 currently is PkC10.
Make it unifrom as other package C state field names.

Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
---
Changes in v2:
  - Update the title

 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..67ffd2872c94 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -427,7 +427,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "Pkg%pc7" },
 	{ 0x0, "Pkg%pc8" },
 	{ 0x0, "Pkg%pc9" },
-	{ 0x0, "Pk%pc10" },
+	{ 0x0, "Pkg%pc10" },
 	{ 0x0, "CPU%LPI" },
 	{ 0x0, "SYS%LPI" },
 	{ 0x0, "PkgWatt" },
@@ -746,7 +746,7 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_Pkgpc9))
 		outp += sprintf(outp, "%sPkg%%pc9", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc10))
-		outp += sprintf(outp, "%sPk%%pc10", (printed++ ? delim : ""));
+		outp += sprintf(outp, "%sPkg%%pc10", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU_LPI))
 		outp += sprintf(outp, "%sCPU%%LPI", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_SYS_LPI))
-- 
2.17.1

