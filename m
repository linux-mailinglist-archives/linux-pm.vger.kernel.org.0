Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A657AD1E8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 09:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjIYHlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Sep 2023 03:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjIYHlS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2023 03:41:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70850EE
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NWBk5b0dW5WKTXzL0sgz+ZHsJKEjA7PFiYwSgbCsBbk=; b=1oXq8xzlAGq4vvPP5NmOn+vf6i
        SYt7cuId/p3EAOZt4tWEgZ+RyIoQrobAxGTgOfYQs9irI8YiQr3UNwD5ZVI547YVMkeWMpamZxtnL
        AE8Or8/OPK1KBXsrTsDgubkSak+kdJFnTaUUKPi4jA0gUzLrCRjwl7dcXbg6JLRYUEXnTil6jgFjC
        1FFjme7dI0ukSXUv2yukL7YzT7Lfsu4asVhh+wlcw1cRXFLM2o1JtFCOv1SQlSD+yvf4kWuQBZ/Nn
        elwMhlyV9RrtBKuAAaSrsxkLu8fzUSDXN0nQNvG7sOaw1ur2tijxX+ttrqrpSL8TcA+cEr1cgCPXG
        mGseERkw==;
Received: from [2001:4bb8:180:ac72:5d00:ec60:acf5:548c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qkgDI-00Ddar-0e;
        Mon, 25 Sep 2023 07:41:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] PM: hibernate: fix the kerneldoc comment for swsusp_check and swsusp_close
Date:   Mon, 25 Sep 2023 09:40:58 +0200
Message-Id: <20230925074058.149779-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The comments for both swsusp_check and swsusp_close don't actually
describe what they are doing.

Just removing the comments would probably better, but as the file is
full of useless kerneldoc comments for non-exported symbols this fits
in better with the style.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/power/swap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 48ec6a8ef9c445..b9763f2f632b8a 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1513,7 +1513,7 @@ int swsusp_read(unsigned int *flags_p)
 static void *swsusp_holder;
 
 /**
- * swsusp_check - Check for swsusp signature in the resume device
+ * swsusp_check - Open the resume device and check for the swsusp signature.
  * @exclusive: Open the resume device exclusively.
  */
 
@@ -1567,7 +1567,7 @@ int swsusp_check(bool exclusive)
 }
 
 /**
- * swsusp_close - close swap device.
+ * swsusp_close - close resume device.
  * @exclusive: Close the resume device which is exclusively opened.
  */
 
-- 
2.39.2

