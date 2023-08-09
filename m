Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F87D775CD1
	for <lists+linux-pm@lfdr.de>; Wed,  9 Aug 2023 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjHILbP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Aug 2023 07:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjHILbP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2023 07:31:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333191BFA;
        Wed,  9 Aug 2023 04:31:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A91B666071A7;
        Wed,  9 Aug 2023 12:31:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691580672;
        bh=Ueh2Uw7nXcphuWCsjKcDvV+Ppt4f4sMX9TxcRQ3TAoU=;
        h=From:To:Cc:Subject:Date:From;
        b=bZoiysaTqew8tc880iInXchIazEHzOOEQ99/Qxsxs5Eop9pQRsw2lMRBnrLC98yNO
         QBAvmmwpA9yIeyJYyqmclV7d9eLi50JVtPoNYwPRWUBUgr9DWDDuMUIHysM6kDzj3M
         7rbnjivRIIhPjsmFfBHmfmVSXZDBtsW8NxZBGCz0jkft1FgLvMBUYYgdSKeXmjMv1e
         HWofiQuRqYcCnFopvDxre62HXUT5CL5OkNONQjZ/N1oE5KQX+8cFVAp/aUO43M7/gu
         FQC7l24PYXBZac5SThHdVrK56tWNEV0K3fYllR3D7WGIQHD3TSPiSpTRryV49rzKw+
         2YRB00dNKSPdw==
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        stable@vger.kernel.org
Subject: [PATCH] PM / devfreq: Fix leak in devfreq_dev_release()
Date:   Wed,  9 Aug 2023 13:31:08 +0200
Message-ID: <20230809113108.2306272-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

srcu_init_notifier_head() allocates resources that need to be released
with a srcu_cleanup_notifier_head() call.

Reported by kmemleak.

Fixes: 0fe3a66410a3 ("PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/devfreq/devfreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e36cbb920ec8..9464f8d3cb5b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -763,6 +763,7 @@ static void devfreq_dev_release(struct device *dev)
 		dev_pm_opp_put_opp_table(devfreq->opp_table);
 
 	mutex_destroy(&devfreq->lock);
+	srcu_cleanup_notifier_head(&devfreq->transition_notifier_list);
 	kfree(devfreq);
 }
 
-- 
2.41.0

