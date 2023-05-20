Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62BB70A969
	for <lists+linux-pm@lfdr.de>; Sat, 20 May 2023 19:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjETRAr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 May 2023 13:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETRAq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 May 2023 13:00:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA7102
        for <linux-pm@vger.kernel.org>; Sat, 20 May 2023 10:00:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 645B86603276;
        Sat, 20 May 2023 18:00:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684602044;
        bh=YxgxkrJl5/qkkFDEokaNDt50Kt3D9ZANTx+mPpJIOBQ=;
        h=From:To:Cc:Subject:Date:From;
        b=nEabmxdec9djcCg62M7Ab4spap6v4+iH8SvjXBNC2xdLB5HSEJ95uFRnq1M1oLbwj
         7a5SeX+6dUHjE3YxibQNiUAApCA51q/z8gXxZuxCyqHKpK97lC6uGe4kjx9YSaEWiJ
         duS47Iq4og4I3lgma5VRiAWamEaDckDnUWVnmUdE1z+ZkpHkdQ7alMzjS+XRCqYcR5
         KrtAnoFPwyvOYw8+YJwBNio0DDP9XAF6pbSYSHLcU+RonGQxzEJ0bvQu6Kcf99xJSy
         vXEfOVzahWYcxUJuBhgXa+itpNNZtynBg02nkMacwJ9bOD5cuxftZEl7GTj2A5JHgj
         wyy6bFWfzgQjQ==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org
Cc:     adrian.larumbe@collabora.com
Subject: [PATCH] OPP: rate-limit debug messages when no change in OPP is required
Date:   Sat, 20 May 2023 18:00:35 +0100
Message-Id: <20230520170035.2540438-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Otherwise, when enabling a debug build and dynamic debug in the kernel, it
quickly floods the kernel ring buffer and makes debugging of other
subsystems almost impossible, unless manually disabled.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 954c94865cf5..85cbc8de407c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1091,7 +1091,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 
 	/* Return early if nothing to do */
 	if (!forced && old_opp == opp && opp_table->enabled) {
-		dev_dbg(dev, "%s: OPPs are same, nothing to do\n", __func__);
+		dev_dbg_ratelimited(dev, "%s: OPPs are same, nothing to do\n", __func__);
 		return 0;
 	}
 
-- 
2.40.0

