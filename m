Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366C533F096
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhCQMjq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhCQMjO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:14 -0400
Date:   Wed, 17 Mar 2021 12:39:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqjmBd/hLNwcPlfMkF1v8P5kZvoPrOjrYZY8NFgf26o=;
        b=S1Xbk6EziSiy4aVh9USyx5lOPMt0dtVL8FWUXjICLwnzBuTNfNX7bey5yZPw5OAaccKwvG
        WB/Ax1GtNcEZu12eldtpYr8D4jDD3kr4SjmhPebNZ/yTRtqGbjefJeOziydYwRAJ0b80Zp
        zPqndyi2bUnMUZeIeV99DC+E34cdQJjNlqMDkZKW0sUuzbMIZDq7LxfaLtDR8QEg577Vej
        1Va2NCA7SQRI7QG+9T2+UUnqZNMNAPhEV0cPbpFVoapn3clLF3RqtGwbP5vxjmsyYPJBZM
        ermD+ybbFNoMTI8Pa2m9mPHUzQscrWlcwe8O9lFnht9Ze4f4b82ivisA3UHkKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqjmBd/hLNwcPlfMkF1v8P5kZvoPrOjrYZY8NFgf26o=;
        b=36nTRRJrFEVpE1jtVqYKLhF3hDE2vcsYAoF4NZCUePIQqNmz/1UejRNUBLccEFq9PKHp4/
        ysllp2b8vbfyQtBA==
From:   "thermal-bot for Zhang Yunkai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal:ti-soc-thermal: Remove duplicate
 include in ti-bandgap
Cc:     Zhang Yunkai <zhang.yunkai@zte.com.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210306123415.219441-1-zhang.yunkai@zte.com.cn>
References: <20210306123415.219441-1-zhang.yunkai@zte.com.cn>
MIME-Version: 1.0
Message-ID: <161598475284.398.16285889390760354167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     7440e912b0fe755d80b958a65859ebabb5338cf8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//7440e912b0fe755d80b958a65859ebabb5338cf8
Author:        Zhang Yunkai <zhang.yunkai@zte.com.cn>
AuthorDate:    Sat, 06 Mar 2021 04:34:15 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 10 Mar 2021 13:04:16 +01:00

thermal:ti-soc-thermal: Remove duplicate include in ti-bandgap

'of_device.h' included in 'ti-bandgap.c' is duplicated.
It is also included in the 25th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210306123415.219441-1-zhang.yunkai@zte.com.cn
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 8a3646e..d81af89 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -32,7 +32,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "ti-bandgap.h"
 
