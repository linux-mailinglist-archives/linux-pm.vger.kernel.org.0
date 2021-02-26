Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA036325F6E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 09:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBZIuH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 03:50:07 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:37688 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhBZIuF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 03:50:05 -0500
Received: from localhost (unknown [192.168.167.139])
        by lucky1.263xmail.com (Postfix) with ESMTP id 55C58A78B4;
        Fri, 26 Feb 2021 16:47:47 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P26070T139688400631552S1614329267704221_;
        Fri, 26 Feb 2021 16:47:47 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c2aaa023577d4f028ac0a933fc9e2a22>
X-RL-SENDER: wangjingyu@uniontech.com
X-SENDER: wangjingyu@uniontech.com
X-LOGIN-NAME: wangjingyu@uniontech.com
X-FST-TO: rjw@rjwysocki.net
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   wangjingyu <wangjingyu@uniontech.com>
To:     rjw@rjwysocki.net
Cc:     pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjingyu <wangjingyu@uniontech.com>
Subject: [PATCH] arch: x86/power Missing a blank line after declarations
Date:   Fri, 26 Feb 2021 16:47:45 +0800
Message-Id: <20210226084745.22996-1-wangjingyu@uniontech.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ensure checkpatch compliance

Signed-off-by: wangjingyu <wangjingyu@uniontech.com>
---
 arch/x86/power/hibernate_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index 223d5bca29b8..90e40055a5ae 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -60,6 +60,7 @@ static pte_t *resume_one_page_table_init(pmd_t *pmd)
 {
 	if (pmd_none(*pmd)) {
 		pte_t *page_table = (pte_t *)get_safe_page(GFP_ATOMIC);
+
 		if (!page_table)
 			return NULL;
 
-- 
2.11.0



