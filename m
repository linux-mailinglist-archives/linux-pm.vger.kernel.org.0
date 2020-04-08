Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD21A1A19
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 04:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDHCpu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 22:45:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgDHCpu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Apr 2020 22:45:50 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 725002787E87A1C8BD97;
        Wed,  8 Apr 2020 10:45:46 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 8 Apr 2020
 10:45:38 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-pm@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ACPI, x86/boot: make acpi_nobgrt static
Date:   Wed, 8 Apr 2020 10:44:12 +0800
Message-ID: <20200408024412.41402-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following sparse warning:

arch/x86/kernel/acpi/boot.c:48:5: warning: symbol 'acpi_nobgrt' was not
declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/x86/kernel/acpi/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1ae5439a9a85..683ed9e12e6b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -45,7 +45,7 @@ EXPORT_SYMBOL(acpi_disabled);
 #define PREFIX			"ACPI: "
 
 int acpi_noirq;				/* skip ACPI IRQ initialization */
-int acpi_nobgrt;			/* skip ACPI BGRT */
+static int acpi_nobgrt;			/* skip ACPI BGRT */
 int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
-- 
2.17.2

