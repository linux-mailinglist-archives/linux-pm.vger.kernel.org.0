Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5326227C
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 00:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIHWPP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 18:15:15 -0400
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:43756
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgIHWPO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 18:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599603313;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=W604g/+Pc0fmhkoTf73JJ4kvixv5ZQPsQb39D8H0cRQ=;
        b=KqvbDCeaFW8XJJbmTdOsk9QU7GO8+Z0aq53m2Ol0VVdzSX5TcEhb5lFpOPeIZGqC
        o/wgsQg+H7zXzADiUv3yofnI157Zh2vN0XCz81tfTolFb6uwyEgScD8b3V9MD9S/fp1
        R+4lcxhH2v9ies1BVa+kTpmSGgaQOIXOEJl0PRsU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599603313;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=W604g/+Pc0fmhkoTf73JJ4kvixv5ZQPsQb39D8H0cRQ=;
        b=oGe1m4seHg+mpWCR3tmWSf88zVyJIEZlLxxBYY+OtzgfLAg5btthwC0Qzxx6dzCi
        3is/dRbV6QuVjaETgXokpoVirL9niTbticCKFeuuj1yn+ha0wB9VlUbdppLOgk94XIX
        dY13iFsDYjwPSjYj+5xHewfJ7oOUL01zZy9piseM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3B35C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] cpuidle: governor: export cpuidle governor functions
Date:   Tue, 8 Sep 2020 22:15:13 +0000
Message-ID: <010101746fc98add-45e77496-d2d6-4bc1-a1ce-0692599a9a7a-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.09.08-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
capability of registering cpuidle governors, which was unused at that
time. By exporting the symbol, let's allow platform specific modules to
register cpuidle governors and use cpuidle_governor_latency_req() to get
the QoS for the CPU.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/cpuidle/governor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 29acaf48e575..0e51ed25665e 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -102,6 +102,7 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cpuidle_register_governor);
 
 /**
  * cpuidle_governor_latency_req - Compute a latency constraint for CPU
@@ -118,3 +119,4 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
 
 	return (s64)device_req * NSEC_PER_USEC;
 }
+EXPORT_SYMBOL_GPL(cpuidle_governor_latency_req);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

