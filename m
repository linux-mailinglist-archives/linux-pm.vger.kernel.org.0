Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C150F3608DB
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhDOME3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhDOME1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:27 -0400
Date:   Thu, 15 Apr 2021 12:04:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPZ9iQQMA+4H0gwZaYtVSbj7b1aYOo0qGN0IRc0e2Co=;
        b=sGHCRG4rSbKUSdOoQxJPo53xUsFBpUzMG6Oi6GwDUbqcIL6PLwlez0RXmTNWj2a2N8Hkc8
        fMB9cF3j04EQqP9kLaq6y2q37m3uEaScs1bpOoKVoMlGjtI12/0BHpPVAo9BvVOS9/vhbf
        gdmXAk5lw67T6SPPvkxOvcB/HwM6UijrkSzGToHIDp0CUfot1hwzn8DB0ftBjjIhcKnSeK
        X8/nb8+dyzxGznREH0w524NXeA78PQGEs2l5ZnD3+a9hFSkv3fpd8z3eW86msz8OFhhAl7
        CPAG8f/iGRCnyxFrphjGJSwqJYGmVDyJihzH5Jc62vivgX4KA/YaEkVmlcPgxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPZ9iQQMA+4H0gwZaYtVSbj7b1aYOo0qGN0IRc0e2Co=;
        b=xnCryY5sEFaao64gXYs3HGmIe39rNjHwYlaijvq5jI2VlHkngQZ0KrQn8mOgn2FMs6keok
        3hC8gwtt+AIGoHCg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Fix memory leak in the error path
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210319202257.890848-1-daniel.lezcano@linaro.org>
References: <20210319202257.890848-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161848824314.29796.15876356390545439449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d44616c6cc3e35eea03ecfe9040edfa2b486a059
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d44616c6cc3e35eea03ecfe9040edfa2b486a059
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Fri, 19 Mar 2021 21:22:57 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:00 +02:00

thermal/core: Fix memory leak in the error path

Fix the following error:

 smatch warnings:
 drivers/thermal/thermal_core.c:1020 __thermal_cooling_device_register() warn: possible memory leak of 'cdev'

by freeing the cdev when exiting the function in the error path.

Fixes: 584837618100 ("thermal/drivers/core: Use a char pointer for the cooling device name")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210319202257.890848-1-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c8d4010..3566fd2 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1017,6 +1017,7 @@ out_kfree_type:
 out_ida_remove:
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
 out_kfree_cdev:
+	kfree(cdev);
 	return ERR_PTR(ret);
 }
 
