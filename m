Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F52215C21
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 18:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgGFQoy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 12:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgGFQoy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 12:44:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F372C061755;
        Mon,  6 Jul 2020 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nNfTuHPUfs6PO3Ww3M+wQvUkhv+TTYKzJicouLRKRMw=; b=a1+V8UoOtgEsLkN9UOIZ4Bnv/p
        lcMSuwC7t0ZzoTOvnhy9U7pPwxjLtzHa717t+nema+w3WTRdOPugdMbTfOBXZ9/fjWT4uZ2vEgmq4
        xc1Ym0sB9SP55Xm21azWnVN85JBtWGuxrWE6o2H+NLcXlG4Lk7ZTIZZwwRqGO+9P/nqZAGteC6rb+
        hCJ1s+jYU4mqxTzSnjLWhNi2aA9oIhxmbK8AkzX+J/bISH2bA1SFSpr0g2XsOe2AXVw9gMuvcZh2y
        K7QmLLekR8tgjXXhwoujOIJ9Z6t9rQW86NvD4Sep8WClf24vQvNEgpaujBFaAhb5Phs42U5gdbUU6
        Po4ivOGQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsUEb-0002lO-Uu; Mon, 06 Jul 2020 16:44:50 +0000
To:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] cpufreq: add stub for get_cpu_idle_time() to fix
 scsi/lpfc driver build
Message-ID: <3a20bf20-247d-1242-dcd0-aef1bbc6e308@infradead.org>
Date:   Mon, 6 Jul 2020 09:44:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

To fix a build error in drivers/scsi/lpfc/lpfc_sli.c when
CONFIG_CPU_FREQ is not set/enabled, add a stub function for
get_cpu_idle_time() in <linux/cpufreq.h>.

../drivers/scsi/lpfc/lpfc_sli.c: In function ‘lpfc_init_idle_stat_hb’:
../drivers/scsi/lpfc/lpfc_sli.c:7330:26: error: implicit declaration of function ‘get_cpu_idle_time’; did you mean ‘set_cpu_active’? [-Werror=implicit-function-declaration]
   idle_stat->prev_idle = get_cpu_idle_time(i, &wall, 1);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: linux-scsi@vger.kernel.org
---
 include/linux/cpufreq.h |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20200706.orig/include/linux/cpufreq.h
+++ linux-next-20200706/include/linux/cpufreq.h
@@ -237,6 +237,10 @@ static inline unsigned int cpufreq_get_h
 {
 	return 0;
 }
+static inline u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
+{
+	return 0;
+}
 static inline void disable_cpufreq(void) { }
 #endif
 

