Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002BB3AB52D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 15:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhFQNwb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 09:52:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50034 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhFQNwb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 09:52:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ltsPU-0007a3-GA; Thu, 17 Jun 2021 13:50:20 +0000
From:   Colin King <colin.king@canonical.com>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] opp: remove redundant continue statement
Date:   Thu, 17 Jun 2021 14:50:20 +0100
Message-Id: <20210617135020.16415-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The continue statement at the end of a for-loop has no effect,
remove it.

Addresses-Coverity: ("Continue has no effect")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/opp/of.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 9573facce53a..d298e38aaf7e 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -197,10 +197,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 		required_opp_tables[i] = _find_table_of_opp_np(required_np);
 		of_node_put(required_np);
 
-		if (IS_ERR(required_opp_tables[i])) {
+		if (IS_ERR(required_opp_tables[i]))
 			lazy = true;
-			continue;
-		}
 	}
 
 	/* Let's do the linking later on */
-- 
2.31.1

