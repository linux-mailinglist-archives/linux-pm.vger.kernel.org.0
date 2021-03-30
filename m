Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FF534E153
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 08:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhC3Gjh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 02:39:37 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:36578 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhC3Gjg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 02:39:36 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 2274998045C;
        Tue, 30 Mar 2021 14:39:34 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] linux/intel_rapl.h: Modify struct declaration
Date:   Tue, 30 Mar 2021 14:39:23 +0800
Message-Id: <20210330063923.2269702-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGU8YH0gaTElMH0pCVkpNSkxLQ01ITE9PQkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PlE6Kyo6ET8OSzcYLyEIP1Yc
        Nk0aCzRVSlVKTUpMS0NNSExPTE5JVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKT0xJNwY+
X-HM-Tid: 0a7881dbe162d992kuws2274998045c
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

struct rapl_package is declared twice. One has been declared
at 80th line.
By reviewing the code, it should declare struct rapl_domain
rather than rapl_package. Modify it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/intel_rapl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 50b8398ffd21..93780834fc8f 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -33,7 +33,7 @@ enum rapl_domain_reg_id {
 	RAPL_DOMAIN_REG_MAX,
 };
 
-struct rapl_package;
+struct rapl_domain;
 
 enum rapl_primitives {
 	ENERGY_COUNTER,
-- 
2.25.1

