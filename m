Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEA82A4911
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgKCPNG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:13:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgKCPME (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:04 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CA2E2242A;
        Tue,  3 Nov 2020 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416324;
        bh=ZKXngPztHzQWd5h+WROAbBiPi04VlbaKl6Ma7l/Vt7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tD4CXwDUTajEng9yYRtap3QsxJ8wL/K5soWfcFREHiPZDGs6VMLI+vyvGaghWccEk
         DPvnHkrNkwh06kajsbE39yNfJ+tw00tKR08/BZp0KA50JwKz/C3hXLorFNSuQRrz3r
         nDqUl1VVFn/Sgw+PNlf9iO3tZ3KNr6VH+QYAGdqg=
Received: by pali.im (Postfix)
        id BE4171A79; Tue,  3 Nov 2020 16:12:01 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] cpufreq: scpi: Add missing MODULE_ALIAS
Date:   Tue,  3 Nov 2020 16:11:38 +0100
Message-Id: <20201103151139.29690-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201103151139.29690-1-pali@kernel.org>
References: <20201103151139.29690-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing MODULE_ALIAS for automatic loading of this cpufreq
driver when it is compiled as an external module.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 8def31034d033 ("cpufreq: arm_big_little: add SCPI interface driver")
---
 drivers/cpufreq/scpi-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 43db05b949d9..e5140ad63db8 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -233,6 +233,7 @@ static struct platform_driver scpi_cpufreq_platdrv = {
 };
 module_platform_driver(scpi_cpufreq_platdrv);
 
+MODULE_ALIAS("platform:scpi-cpufreq");
 MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
 MODULE_DESCRIPTION("ARM SCPI CPUFreq interface driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

