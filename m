Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA66FD3E8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 06:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfKOFGh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 00:06:37 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19605 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbfKOFGh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 00:06:37 -0500
X-IronPort-AV: E=Sophos;i="5.68,307,1569254400"; 
   d="scan'208";a="78485426"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2019 13:06:31 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id CA0234CE1A0C;
        Fri, 15 Nov 2019 12:58:18 +0800 (CST)
Received: from localhost.localdomain (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 15 Nov 2019 13:06:38 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: [RFC PATCH] x86/acpi: Drop duplicate BOOT table initialization
Date:   Fri, 15 Nov 2019 13:06:13 +0800
Message-ID: <20191115050613.1556-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: CA0234CE1A0C.A94EC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Cao jin <caoj.fnst@cn.fujitsu.com>

ACPI BOOT table is initialized in both acpi_boot_table_init &
acpi_boot_init of setup_arch, but its usage is quite late at the end of
start_kernel. It should be safe to drop one of them. Since it is less
related with table init, drop it from there.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/acpi/boot.c | 2 --
 1 file changed, 2 deletions(-)

It existed since git repo is built, so it might has its reason? The
patch is not tested since I don't have BOOT table in my firmware.

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 04205ce127a1..ca1c15bb0b48 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1558,8 +1558,6 @@ void __init acpi_boot_table_init(void)
 		return;
 	}
 
-	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
-
 	/*
 	 * blacklist may disable ACPI entirely
 	 */
-- 
2.21.0



