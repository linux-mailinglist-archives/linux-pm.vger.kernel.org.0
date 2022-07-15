Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4C85763D2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 16:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiGOOrl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGOOrk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 10:47:40 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CF63753BF
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Nd5Hs
        Pk8fGP8VUjiATVKxAce6syuZDoHdH66AepuTZ0=; b=pwZEl2l/mc4u/0gT/xUex
        Ge9FRxBUNz06a5+eSpXXz/1oGy+tn95W1JJQQH6S2+CLZzNGRm8WbbW1sJ42daiI
        kH0kqd+dp7la9jx9wpwA4X48BV8OBt7ktGLZtVum2Y6djRfIvpJ1fVSD7Ij8YX9E
        rJTtnQt+u9u2uL917Adv+g=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowAAHp5jwfdFiWhw9FA--.14048S2;
        Fri, 15 Jul 2022 22:47:13 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, windhl@126.com
Subject: [PATCH] OPP: Fix two refcount bugs
Date:   Fri, 15 Jul 2022 22:47:12 +0800
Message-Id: <20220715144712.444104-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowAAHp5jwfdFiWhw9FA--.14048S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW7KrykJrWUWrWxtryDAwb_yoW8tw1Dpr
        45G3s0yFnxXF4ktr4Iy3Wv9F90ywsrXrykG3s3C34Yvw45tryUXFyYga43JF95JF95ZFWa
        qF1vqF43Aa18Aw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi4rWxUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBI-F2JVkYXEcgAAsX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In drivers/opp/of.c, there are two refcount bugs:
(1) in _of_init_opp_table(), of_put_node() in the last line is not
needed as the 'opp_np' is escaped out into 'opp_table->np' and
’opp_table' is an out parameter.
(2) in _opp_add_static_v2(), we need call of_node_get() for the new
reference created when "new_opp->np = np;" as new_opp is escaped out.
Here we should also take care of the of_node_put() when 'new_opp' is
freed based on the function description: "The opp can be controlled
... and may be removed by dev_pm_opp_remove".
NOTE: _opp_add_static_v2() is called by _of_add_opp_table_v2() in a
for_each_available_child_of_node() which will automatically increase
and decrease the refcount. So we need an additional of_node_get()
for the new reference created in _opp_add_static_v2().

Fixes: f06ed90e7051 ("OPP: Parse OPP table's DT properties from _of_init_opp_table()")
Fixes: 274659029c9d ("PM / OPP: Add support to parse "operating-points-v2" bindings")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/opp/core.c | 1 +
 drivers/opp/of.c   | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 84063eaebb91..70775362eb05 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1576,6 +1576,7 @@ static void _opp_kref_release(struct kref *kref)
 	list_del(&opp->node);
 	mutex_unlock(&opp_table->lock);
 
+	of_node_put(opp->np);
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 30394929d700..0a38fc2c0f05 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -242,7 +242,6 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
 	opp_table->np = opp_np;
 
 	_opp_table_alloc_required_tables(opp_table, dev, opp_np);
-	of_node_put(opp_np);
 }
 
 void _of_clear_opp_table(struct opp_table *opp_table)
@@ -902,7 +901,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 
 	new_opp->turbo = of_property_read_bool(np, "turbo-mode");
 
-	new_opp->np = np;
+	new_opp->np = of_node_get(np);
 	new_opp->dynamic = false;
 	new_opp->available = true;
 
-- 
2.25.1

