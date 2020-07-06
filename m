Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63309215922
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgGFOHv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 10:07:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57802 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbgGFOHu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 10:07:50 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jsRmd-0003Nm-FA; Mon, 06 Jul 2020 14:07:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal: core: remove redundant initialization of variable ret
Date:   Mon,  6 Jul 2020 15:07:47 +0100
Message-Id: <20200706140747.489075-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/thermal_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index d3c48bbcd269..cb56950f59d2 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -548,7 +548,7 @@ static int thermal_genl_cmd_dumpit(struct sk_buff *skb,
 	struct param p = { .msg = skb };
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	int cmd = info->ops->cmd;
-	int ret = -EMSGSIZE;
+	int ret;
 	void *hdr;
 
 	hdr = genlmsg_put(skb, 0, 0, &thermal_gnl_family, 0, cmd);
-- 
2.27.0

