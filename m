Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8883F2A491A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgKCPNH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbgKCPME (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:04 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DDF52242B;
        Tue,  3 Nov 2020 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416324;
        bh=g0c8i/wdirmEYHXgRwCXZZmdKKepVVMI3U4ztkA4in0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aP017Doc5x9VuinHfN7uLdejq4NF9mpSFQIXl0JILMsrPkXeocGbvikqZ0dY/9tse
         srta7uThrURjeYUL+3Pznxn407rBhyY6/iu598Og/N+ddVxyIYCI54KWh92LT6mNJk
         gMn/QNDVyCrQheRzYMcPdewnapxYtHE8NviBrA+E=
Received: by pali.im (Postfix)
        id 7FBBD1A15; Tue,  3 Nov 2020 16:12:01 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] cpufreq: loongson1: Add missing MODULE_ALIAS
Date:   Tue,  3 Nov 2020 16:11:37 +0100
Message-Id: <20201103151139.29690-8-pali@kernel.org>
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
Fixes: a0a22cf14472f ("cpufreq: Loongson1: Add cpufreq driver for Loongson1B")
---
 drivers/cpufreq/loongson1-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index 0ea88778882a..86f612593e49 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -216,6 +216,7 @@ static struct platform_driver ls1x_cpufreq_platdrv = {
 
 module_platform_driver(ls1x_cpufreq_platdrv);
 
+MODULE_ALIAS("platform:ls1x-cpufreq");
 MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
 MODULE_DESCRIPTION("Loongson1 CPUFreq driver");
 MODULE_LICENSE("GPL");
-- 
2.20.1

