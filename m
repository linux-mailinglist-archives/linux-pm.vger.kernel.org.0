Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E237CA8
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 20:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfFFSvB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 14:51:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbfFFSvA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 14:51:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEB5230842A8;
        Thu,  6 Jun 2019 18:51:00 +0000 (UTC)
Received: from dba62.ml3.eng.bos.redhat.com (dba62.ml3.eng.bos.redhat.com [10.19.176.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 226291017E2C;
        Thu,  6 Jun 2019 18:51:00 +0000 (UTC)
From:   David Arcari <darcari@redhat.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Arcari <darcari@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: pcc-cpufreq: Fail initialization if driver cannot be registered
Date:   Thu,  6 Jun 2019 14:50:52 -0400
Message-Id: <20190606185052.71959-1-darcari@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 06 Jun 2019 18:51:00 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make pcc_cpufreq_init() return error codes when the driver cannot be
registered.  Otherwise the driver can shows up loaded via lsmod even
though it failed initialization.  This is confusing to the user.

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pcc-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 1e5e64643c3a..fdc767fdbe6a 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -582,10 +582,10 @@ static int __init pcc_cpufreq_init(void)
 
 	/* Skip initialization if another cpufreq driver is there. */
 	if (cpufreq_get_current_driver())
-		return 0;
+		return -EEXIST;
 
 	if (acpi_disabled)
-		return 0;
+		return -ENODEV;
 
 	ret = pcc_cpufreq_probe();
 	if (ret) {
-- 
2.18.1

