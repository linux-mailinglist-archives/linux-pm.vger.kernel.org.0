Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D353608D7
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhDOME2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbhDOMEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:25 -0400
Date:   Thu, 15 Apr 2021 12:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qTQ3M5pKKejtp2Ri6Ef9iU9AbB8qF51x5KTwSJqJFn8=;
        b=mRypYykoh2LxRaD0u2dvDBNaOWviM1Xn8y26sJ7GII5t4/DHWb6Ni8PyLH+BQFJYM9Neyw
        wuhw5nynbGUMSEgFb1J5d8OtDsTUbTHHLIzpP/XPDqhZEaAY0oJ/q0gLL26lEcPhdYEF06
        H99dRwgO0Uc2liqq+wYs9LRv3E8vl/X+aAlDf3h1E6CQQHFhXY0XpDyN5c0JwjWova42Nh
        8wcCBjKY0AjAtUcw87wbKvOK7mcRg6z5YCdRnt6bihnKN38xSk9+juoU399+DZ8JrzdjBn
        UFIeD+c1KML6hSBYcgOrtDOUisnHWSv6rR5Qc72jSN+WDVgkHzTyhhHHcbsnDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qTQ3M5pKKejtp2Ri6Ef9iU9AbB8qF51x5KTwSJqJFn8=;
        b=t/DW5EUzsuuIw0DEAWN90sFwlwKi4dMT4j1eWuS+1BZuNNb53xptynt5iG+FRxbcRSkOGU
        mep6k+YtdTOrNnBQ==
From:   "thermal-bot for Hao Fang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/hisi: Use the correct
 HiSilicon copyright
Cc:     Hao Fang <fanghao11@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1617086733-2705-1-git-send-email-fanghao11@huawei.com>
References: <1617086733-2705-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Message-ID: <161848824170.29796.14245035825395416946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     4481b39f9390e82c73fb03193b4a5e7e242d22a4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//4481b39f9390e82c73fb03193b4a5e7e242d22a4
Author:        Hao Fang <fanghao11@huawei.com>
AuthorDate:    Tue, 30 Mar 2021 14:45:33 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:42 +02:00

thermal/drivers/hisi: Use the correct HiSilicon copyright

s/Hisilicon/HiSilicon/g.
It should use capital S, according to
https://www.hisilicon.com/en/terms-of-use.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1617086733-2705-1-git-send-email-fanghao11@huawei.com
---
 drivers/thermal/hisi_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index ee05950..d902db9 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -1,7 +1,7 @@
 /*
- * Hisilicon thermal sensor driver
+ * HiSilicon thermal sensor driver
  *
- * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Copyright (c) 2014-2015 HiSilicon Limited.
  * Copyright (c) 2014-2015 Linaro Limited.
  *
  * Xinwei Kong <kong.kongxinwei@hisilicon.com>
@@ -672,5 +672,5 @@ module_platform_driver(hisi_thermal_driver);
 
 MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei@hisilicon.com>");
 MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
-MODULE_DESCRIPTION("Hisilicon thermal driver");
+MODULE_DESCRIPTION("HiSilicon thermal driver");
 MODULE_LICENSE("GPL v2");
