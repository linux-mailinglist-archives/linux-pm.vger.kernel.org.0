Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91B0325F9C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 10:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBZJFf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 04:05:35 -0500
Received: from lucky1.263xmail.com ([211.157.147.130]:36346 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhBZJFC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 04:05:02 -0500
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id E3494CFEB5;
        Fri, 26 Feb 2021 17:02:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.207.172.18])
        by smtp.263.net (postfix) whith ESMTP id P32473T140678948443904S1614330129607203_;
        Fri, 26 Feb 2021 17:02:09 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d79f3db01b8857c2acfa08dbd2693527>
X-RL-SENDER: wangjingyu@uniontech.com
X-SENDER: wangjingyu@uniontech.com
X-LOGIN-NAME: wangjingyu@uniontech.com
X-FST-TO: rjw@rjwysocki.net
X-SENDER-IP: 111.207.172.18
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   wangjingyu <wangjingyu@uniontech.com>
To:     rjw@rjwysocki.net
Cc:     pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, pa@zytor.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjingyu <wangjingyu@uniontech.com>
Subject: [PATCH] arch: x86/power Missing a blank line after declarations
Date:   Fri, 26 Feb 2021 17:02:05 +0800
Message-Id: <20210226090205.24132-1-wangjingyu@uniontech.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ensure checkpatch compliance

Signed-off-by: wangjingyu <wangjingyu@uniontech.com>
---
 arch/x86/power/hibernate_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index a595953f1d6d..7dfd3832c74c 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -78,6 +78,7 @@ static int set_up_temporary_text_mapping(pgd_t *pgd)
 	} else {
 		/* No p4d for 4-level paging: point the pgd to the pud page table */
 		pgd_t new_pgd = __pgd(__pa(pud) | pgprot_val(pgtable_prot));
+
 		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
 	}
 
-- 
2.11.0



