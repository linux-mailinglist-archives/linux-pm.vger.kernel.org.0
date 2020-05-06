Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F7A1C783F
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 19:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgEFRnk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 13:43:40 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60712 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgEFRna (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 13:43:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A8A1480307C2;
        Wed,  6 May 2020 17:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gy1-Mn2vu5hz; Wed,  6 May 2020 20:43:27 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/20] mips: cm: Fix an invalid error code of INTVN_*_ERR
Date:   Wed, 6 May 2020 20:42:22 +0300
Message-ID: <20200506174238.15385-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Commit 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache
errors") adds cm2_causes[] array with map of error type ID and
pointers to the short description string. There is a mistake in
the table, since according to MIPS32 manual CM2_ERROR_TYPE = {17,18}
correspond to INTVN_WR_ERR and INTVN_RD_ERR, while the table
claims they have {0x17,0x18} codes. This is obviously hex-dec
copy-paste bug. Moreover codes {0x18 - 0x1a} indicate L2 ECC errors.

Fixes: 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache errors")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/kernel/mips-cm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index cdb93ed91cde..361bfc91a0e6 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -119,9 +119,9 @@ static char *cm2_causes[32] = {
 	"COH_RD_ERR", "MMIO_WR_ERR", "MMIO_RD_ERR", "0x07",
 	"0x08", "0x09", "0x0a", "0x0b",
 	"0x0c", "0x0d", "0x0e", "0x0f",
-	"0x10", "0x11", "0x12", "0x13",
-	"0x14", "0x15", "0x16", "INTVN_WR_ERR",
-	"INTVN_RD_ERR", "0x19", "0x1a", "0x1b",
+	"0x10", "INTVN_WR_ERR", "INTVN_RD_ERR", "0x13",
+	"0x14", "0x15", "0x16", "0x17",
+	"0x18", "0x19", "0x1a", "0x1b",
 	"0x1c", "0x1d", "0x1e", "0x1f"
 };
 
-- 
2.25.1

