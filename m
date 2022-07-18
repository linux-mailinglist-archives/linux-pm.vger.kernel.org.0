Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DCA5783D4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiGRNgs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 09:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiGRNgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 09:36:47 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89B251A3B0
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 06:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qiii+
        ijtDUpLXuKUfT/gct0Y4qtxlMum/HdyRii7+OE=; b=p9de7dN/DVTk5mq1PeV/8
        IZhL8Dm3QMSJ1vNcOoCWHPQ7FogT0WLDpU4vgEhJpMOBWf3QZUYqT3q9H9raOVeb
        HA/5BmjiLAXoKRe9pln+clSAHPYV0c6k0tcba5KCYw64aI6zeXy5vdKsnnf5Hmp3
        AEB0YJpTouUKLtVRH5OgkY=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgBX6IThYdVigvlWIA--.52604S2;
        Mon, 18 Jul 2022 21:36:33 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, windhl@126.com
Subject: [PATCH v2 1/2] OPP: Fix refcount leak bug for opp_table
Date:   Mon, 18 Jul 2022 21:36:31 +0800
Message-Id: <20220718133632.937290-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBX6IThYdVigvlWIA--.52604S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW7KrykJr4rWw1kJryxXwb_yoW8XFW3pr
        15JrZ0yFW3X3yqyr47Jan29a4YyanFqrykK3s5C34Yvw1qya4UXFW2q343AFykJas5XFWa
        qF1qqr4UWa1xJ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYjgxUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgJCF18RPhBXjAAAsi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In _of_init_opp_table(), of_put_node() in the last line is not
needed as the 'opp_np' is escaped out into 'opp_table->np' and
’opp_table' is an out parameter. We should call the of_node_put()
when the 'opp_table' is released in _opp_table_kref_release().

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: (1) add the of_node_put() in _opp_table_kref_release()
     (2) rebase on linux-next/master
     (3) split v1 into two commits, opp_table->np and opp->np
 v1: https://lore.kernel.org/all/20220715144712.444104-1-windhl@126.com/


 drivers/opp/core.c | 1 +
 drivers/opp/of.c   | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4f4a285886fa..cc2671322e41 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1499,6 +1499,7 @@ static void _opp_table_kref_release(struct kref *kref)
 		dev_pm_opp_put(opp_table->current_opp);
 
 	_of_clear_opp_table(opp_table);
+	of_node_put(opp_table->np);
 
 	/* Release automatically acquired single clk */
 	if (!IS_ERR(opp_table->clk))
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 8367823a2001..374544afe9e4 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -242,7 +242,6 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
 	opp_table->np = opp_np;
 
 	_opp_table_alloc_required_tables(opp_table, dev, opp_np);
-	of_node_put(opp_np);
 }
 
 void _of_clear_opp_table(struct opp_table *opp_table)
-- 
2.25.1

