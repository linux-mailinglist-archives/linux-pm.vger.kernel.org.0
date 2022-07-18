Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF655783D5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiGRNgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiGRNgt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 09:36:49 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DB111A3B1
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 06:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MxHIn
        upCOqspUhbDEdp4NqT3uVJmKh522j8Cwo7kgUM=; b=dMo0xQavWWCt+kKn2a9Ja
        TOAByAVu5THddOtXrZdEUmCPsHHocX9nEau6PXB3A96CdNhd31X1OElQlQM6CsBe
        09nA4Fmz9K+h4rSEIgg7eS/A70i1OxUSWEb3CcrFkX12MRWd5QYAskbvdWti/8T2
        oCD3PDbRyk9T0tTHbGdwHk=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgBX6IThYdVigvlWIA--.52604S3;
        Mon, 18 Jul 2022 21:36:36 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, windhl@126.com
Subject: [PATCH v2 2/2] OPP: Fix refcount leak bug for opp
Date:   Mon, 18 Jul 2022 21:36:32 +0800
Message-Id: <20220718133632.937290-2-windhl@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718133632.937290-1-windhl@126.com>
References: <20220718133632.937290-1-windhl@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBX6IThYdVigvlWIA--.52604S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4UGr4xZw1xXF1xXw43ZFb_yoW8Wryxpr
        sxK343AFyDXFWDtw4Iy3W8uF90y3Wqqry8WFyfG34F9w45tFyUX34Ygay5tFn8XFykArWa
        qF18tF45Wa18Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ufb18UUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuARCF2JVkaOAHwAAsz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In _opp_add_static_v2(), we need call of_node_get() for the new
reference created when "new_opp->np = np;" as new_opp is escaped out.
Here we should also take care of the of_node_put() when 'new_opp' is
freed based on the function description: "The opp can be controlled
... and may be removed by dev_pm_opp_remove".
For example, _opp_add_static_v2() is called by _of_add_opp_table_v2()
in a for_each_available_child_of_node() which will automatically
increase and decrease the refcount. So we need an additional
of_node_get() for the new reference created in _opp_add_static_v2().

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/opp/core.c | 1 +
 drivers/opp/of.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cc2671322e41..2f7988a05cb7 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1549,6 +1549,7 @@ static void _opp_kref_release(struct kref *kref)
 	list_del(&opp->node);
 	mutex_unlock(&opp_table->lock);
 
+	of_node_put(opp->np);
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 374544afe9e4..ac4a3ff12677 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -937,7 +937,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 
 	new_opp->turbo = of_property_read_bool(np, "turbo-mode");
 
-	new_opp->np = np;
+	new_opp->np = of_node_get(np);
 	new_opp->dynamic = false;
 	new_opp->available = true;
 
-- 
2.25.1

