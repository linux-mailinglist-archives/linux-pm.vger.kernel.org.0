Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670F63608D5
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhDOME1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbhDOMEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5260C061756
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 05:04:02 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:04:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GUI5Akfoi0AO9pkb9mEuO6LNc0sXIotwjn0CX8O1f10=;
        b=I+z78Zk2jOxfuCvkLC9bFppOm4vFOcwUAlhcGhEFr54jvnjglT9IpDqgNyip6+WG2/DPvx
        An/jG32JJfeTk2ULptm9ee+hT8lOlB4ubuXXhMCx6bgCjTkDQQj+xRVv6PzyJ1t9r1kD8L
        6jA6l+ZwtWHnDMJo7XaR0w/NDri6B1RqZoOWIJ5aDAL1Zjz5jgGzMFF4t5YNvBHZHmn5i5
        sZB5Y8KlD6mI3pEsRw2o4QXVtlVVNjIENDYrbD9eijyeQIDJj7DqMNj07WFg8ru2ADdn1l
        mquL9IP9eRUI/i/YXNFxKjgC0ay7VqiMnRB3EAJKOiSMO3vGzkGttXwW/Q7piA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GUI5Akfoi0AO9pkb9mEuO6LNc0sXIotwjn0CX8O1f10=;
        b=VjifrLsy3yUV+ti+6jdSftmseOGbVB3SoKHfjy0UHkuj88Se9KgjJZYTAW3nzwnLqBerQf
        vmBZfNnzpU6kk3BQ==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] MAINTAINERS: update thermal CPU cooling section
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210217115908.22547-1-lukasz.luba@arm.com>
References: <20210217115908.22547-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <161848824055.29796.13659501203766535115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     5b5f1121d60bca8305951930d7aa2123fb213cb0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//5b5f1121d60bca8305951930d7aa2123fb213cb0
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Wed, 17 Feb 2021 11:59:08 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:42 +02:00

MAINTAINERS: update thermal CPU cooling section

Update maintainers responsible for CPU cooling on Arm side.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Javi Merino <javi.merino@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210217115908.22547-1-lukasz.luba@arm.com
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f919aa8..6926711 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17771,7 +17771,7 @@ THERMAL/CPU_COOLING
 M:	Amit Daniel Kachhap <amit.kachhap@gmail.com>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
-M:	Javi Merino <javi.merino@kernel.org>
+R:	Lukasz Luba <lukasz.luba@arm.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
