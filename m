Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819466DA7D5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Apr 2023 04:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjDGCsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Apr 2023 22:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjDGCsJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2023 22:48:09 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8B94ED6
        for <linux-pm@vger.kernel.org>; Thu,  6 Apr 2023 19:48:08 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-627ed1ac61cso379242b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Apr 2023 19:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680835688; x=1683427688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEKF2ishCKn2YX7YX48VS1nRgPoxqb95NFnlr6xUF6Y=;
        b=yNNbzdVxiFzTMYTnQr5E9+x3Kv0xG6o2wL25Y4rlC3z8jAg5vO8VH/oyjbNQzXRn8t
         6woQMly3bQfCy5+5j/9XWzvftp7L3XI48mwc65eLi+Fi5Zq79ATuQbG+v04Q5RSdGbcU
         x0+9sL7YmkVkgixarQU2V9ZaXgXGKS68tgSp92EKUXOEe9ZOeguhgpvrncRpXfevR928
         haTrnNaR/UCT6fzWfNsKXUGi4xTabTJnWI6RKiAOboHIZ03tBSSuKd3LHYS+rRb8C17k
         tcxIczmf00EorYH+CsvCeyakzFpbOOXTGVQy6PGZOIhehMnEIu22a4W63CQN0QrbpkTN
         3RZw==
X-Gm-Message-State: AAQBX9fQhltV6WJaAagQ6QbhLBiLHvJJ+HF98gHdMJ3N8hlwKad64qKL
        SgtJxBGiP3PAQmhgS+Axw+i/smQRg5o=
X-Google-Smtp-Source: AKy350Y1vADQJk8PsINpjka5Ne1hd7nNaxcGs1H7Xj7mwRosjP1rYTqtWMARkQD7BgaypvqXc1fAzA==
X-Received: by 2002:a05:6a00:468a:b0:625:a08c:a8ba with SMTP id de10-20020a056a00468a00b00625a08ca8bamr1246633pfb.1.1680835688291;
        Thu, 06 Apr 2023 19:48:08 -0700 (PDT)
Received: from tgsp-ThinkPad-X280.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id r20-20020a62e414000000b0062602254895sm2077168pfh.10.2023.04.06.19.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:48:07 -0700 (PDT)
From:   xiongxin <xiongxin@kylinos.cn>
To:     xiongxin@kylinos.cn, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org
Subject: [v2] powercap: intel_rapl: Optimize rp->domains memory allocation
Date:   Fri,  7 Apr 2023 10:47:59 +0800
Message-Id: <20230407024759.2320858-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the memory allocation of rp->domains in rapl_detect_domains(), there
is an additional memory of struct rapl_domain allocated, optimize the
code here to save sizeof(struct rapl_domain) bytes of memory.

Test in Intel NUC (i5-1135G7).

Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Tested-by: xiongxin <xiongxin@kylinos.cn>
---

v2: The extra memory will never be used, so can directly remove '+1'.

 drivers/powercap/intel_rapl_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 8970c7b80884..a766d6e43c34 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1319,7 +1319,7 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 	}
 	pr_debug("found %d domains on %s\n", rp->nr_domains, rp->name);
 
-	rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct rapl_domain),
+	rp->domains = kcalloc(rp->nr_domains, sizeof(struct rapl_domain),
 			      GFP_KERNEL);
 	if (!rp->domains)
 		return -ENOMEM;
-- 
2.34.1

