Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02F117284C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 20:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgB0TEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 14:04:33 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.38]:14031 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729385AbgB0TEd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 14:04:33 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 27F83400CFD8F
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 13:04:32 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7OSWjfNuOXVkQ7OSWj0QWD; Thu, 27 Feb 2020 13:04:32 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a4cGODhzoqFN7XGLNvkdgu9vu9YdHDnB4q9Ykb1Vc28=; b=jP1MdHKVsh/wfVAve847rc8Ls3
        kR+ScU0Uk04FU9J/wDGSWCDwGFdVWrtTaAfyxk4nUV1UFAP9qNiS8ddxKw6kODNjFx/FhOYSX9fsz
        1VEovtHNx5zZWaoOUqWYrZSKltm/DNXUt4H9ZpTPWufPNJC4rctUvxyrl+OQ4Wf7ovKoVaZ/+SWA+
        KFXs9gQuSYptNOwVwJ7SQLFxMhe6w6SctRNe7vsmoRzxDG63HBFWbVQbhSlDcNV5sCFoaUDw07zjA
        qScg/7rG08/iHVju0kdYY9QUVS1VriidIDn0w0ni9Tv6DzxEb1FUjtOQj4uSOrSCGKXgOh+sU9v5G
        R5E8Um0g==;
Received: from [201.162.168.186] (port=28892 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j7OST-004Cgc-KG; Thu, 27 Feb 2020 13:04:30 -0600
Date:   Thu, 27 Feb 2020 13:07:21 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] powercap: idle_inject: Replace zero-length array with
 flexible-array member
Message-ID: <20200227190721.GA19083@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.168.186
X-Source-L: No
X-Exim-ID: 1j7OST-004Cgc-KG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.168.186]:28892
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

Lastly, fix the following checkpatch warning:
WARNING: Prefer 'unsigned long' over 'unsigned long int' as the int is unnecessary
+	unsigned long int cpumask[];

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/powercap/idle_inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index cd1270614cc6..e9bbd3c42eef 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -67,7 +67,7 @@ struct idle_inject_device {
 	struct hrtimer timer;
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
-	unsigned long int cpumask[0];
+	unsigned long cpumask[];
 };
 
 static DEFINE_PER_CPU(struct idle_inject_thread, idle_inject_thread);
-- 
2.25.0

