Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033CF37192D
	for <lists+linux-pm@lfdr.de>; Mon,  3 May 2021 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhECQXS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 May 2021 12:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhECQXS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 May 2021 12:23:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07903C06174A
        for <linux-pm@vger.kernel.org>; Mon,  3 May 2021 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BZaX6SgQalUlI4Sq0vnZaNqPpeANlVb/POst7Vj03bo=; b=IoCgFI7pkPtVYzwvxEA/gaN46O
        +B13JMalu8gpDlNTj+XKwhmbSzB8P4izDkrot9Vv+3Cupz7ly1v6zpvkFu+xjNxyNt6s1Wc6xSJVT
        uG98j6Je/EOWGHaIYUfX4EjTjp0OAvTvfEld4FtNpjD/resNF6QMjzCPsBKPrD3YsiGgqeYMGdhSA
        U6msQ4nszUzG+YiKlBEgZSZ6wy2eMn5gMB7EoFIgm7T70+08N+1x/qA7uCWfXyzGBMBmbetH4tqsx
        PRKr9Xkgd1YWHMIke8qOEV42ujp8E5dc3wGaOSCD+VNDZjOH887akwLl83lyeEqC0XmrifrVPDnHi
        Stn8j6vg==;
Received: from [2601:1c0:6280:3f0::df68] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldbHR-00FIyn-C6; Mon, 03 May 2021 16:19:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: sc520_freq: add 'fallthrough' to one case
Date:   Mon,  3 May 2021 09:18:40 -0700
Message-Id: <20210503161840.26771-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quieten an implicit-fallthrough warning in sc520_freq.c:

../drivers/cpufreq/sc520_freq.c: In function 'sc520_freq_get_cpu_frequency':
../include/linux/printk.h:343:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
../drivers/cpufreq/sc520_freq.c:43:3: note: in expansion of macro 'pr_err'
   pr_err("error: cpuctl register has unexpected value %02x\n",
../drivers/cpufreq/sc520_freq.c:45:2: note: here
  case 0x01:

Fixes: bf6fc9fd2d848 ("[CPUFREQ] AMD Elan SC520 cpufreq driver.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
Found in linux-next but applies to mainline.

 drivers/cpufreq/sc520_freq.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210503.orig/drivers/cpufreq/sc520_freq.c
+++ linux-next-20210503/drivers/cpufreq/sc520_freq.c
@@ -42,6 +42,7 @@ static unsigned int sc520_freq_get_cpu_f
 	default:
 		pr_err("error: cpuctl register has unexpected value %02x\n",
 		       clockspeed_reg);
+		fallthrough;
 	case 0x01:
 		return 100000;
 	case 0x02:
