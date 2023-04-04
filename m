Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C826D5AFC
	for <lists+linux-pm@lfdr.de>; Tue,  4 Apr 2023 10:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjDDIhF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Apr 2023 04:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjDDIhF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2023 04:37:05 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691AEA8
        for <linux-pm@vger.kernel.org>; Tue,  4 Apr 2023 01:37:01 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so33179876pjl.4
        for <linux-pm@vger.kernel.org>; Tue, 04 Apr 2023 01:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680597421; x=1683189421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3aA/g9Yqu4ZYuQ2TGgQYZOEwq76FdRGoOsWRA/ffUg=;
        b=eSuHj9ASbudCGZUTemtOKJ0m7J6WtYe7t3Xz9GGuBXJHtlBtQj3iZG3DFvCAlTAspJ
         VetOlpNraIG91QpLkd1++Ez5eLfb9e/tZ4kE04ewVVysC2JQ7d/lBsJLfJMLJKrz8Wzw
         QxfIuUHS7O3tJDLzqcvDW8cAhjvDM3XN8uzpCTxFigxTKU++kwSTtb9+Ma2s+D44FeCZ
         3GgtNBygi4oALB0ZfaOV4Ek5qonD/kWwvMyfDOfRCxWUzHmbF5Ls8jIg8veFcThKN40R
         2VP+kub2DoakVFw3JAtSk5ThzihgQsfFmjJEMSzUmMdzkqEt1WZvClkCUvBS5So9h/b6
         1iCw==
X-Gm-Message-State: AAQBX9ffruu7caxkKgLt714kvDudRa+cdIXwW4Z2bbBhu6LU9bBcfkT3
        E3VfvX8R5vZ0jK4WHrMxXhsQuO97nDmVLQ==
X-Google-Smtp-Source: AKy350bUJNOrvlBxLPIDF2TcKbk1bGFxUWUwGUV2hXaHhsHM9AgG8nQzJgPEEKDIfQuP2QX5LW80Mw==
X-Received: by 2002:a17:902:b7ca:b0:1a2:1a52:14b3 with SMTP id v10-20020a170902b7ca00b001a21a5214b3mr1661692plz.4.1680597420872;
        Tue, 04 Apr 2023 01:37:00 -0700 (PDT)
Received: from tgsp-ThinkPad-X280.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001a1a9a5e53fsm7949491plb.136.2023.04.04.01.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 01:37:00 -0700 (PDT)
From:   xiongxin <xiongxin@kylinos.cn>
To:     xiongxin@kylinos.cn, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] powercap: intel_rapl: Optimize rp->domains memory allocation
Date:   Tue,  4 Apr 2023 16:36:56 +0800
Message-Id: <20230404083656.713825-1-xiongxin@kylinos.cn>
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
is an additional memory of struct rapl_domain allocated to prevent the
pointer out of bounds called later.

Optimize the code here to save sizeof(struct rapl_domain) bytes of
memory.

Test in Intel NUC (i5-1135G7).

Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Tested-by: xiongxin <xiongxin@kylinos.cn>
---
 drivers/powercap/intel_rapl_common.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 8970c7b80884..f8971282498a 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1171,13 +1171,14 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 {
 	struct rapl_domain *rd;
 	struct powercap_zone *power_zone = NULL;
-	int nr_pl, ret;
+	int nr_pl, ret, i;
 
 	/* Update the domain data of the new package */
 	rapl_update_domain_data(rp);
 
 	/* first we register package domain as the parent zone */
-	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
+	for (i = 0; i < rp->nr_domains; i++) {
+		rd = &rp->domains[i];
 		if (rd->id == RAPL_DOMAIN_PACKAGE) {
 			nr_pl = find_nr_power_limit(rd);
 			pr_debug("register package domain %s\n", rp->name);
@@ -1201,8 +1202,9 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 		return -ENODEV;
 	}
 	/* now register domains as children of the socket/package */
-	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
+	for (i = 0; i < rp->nr_domains; i++) {
 		struct powercap_zone *parent = rp->power_zone;
+		rd = &rp->domains[i];
 
 		if (rd->id == RAPL_DOMAIN_PACKAGE)
 			continue;
@@ -1302,7 +1304,6 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
  */
 static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 {
-	struct rapl_domain *rd;
 	int i;
 
 	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
@@ -1319,15 +1320,15 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 	}
 	pr_debug("found %d domains on %s\n", rp->nr_domains, rp->name);
 
-	rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct rapl_domain),
+	rp->domains = kcalloc(rp->nr_domains, sizeof(struct rapl_domain),
 			      GFP_KERNEL);
 	if (!rp->domains)
 		return -ENOMEM;
 
 	rapl_init_domains(rp);
 
-	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++)
-		rapl_detect_powerlimit(rd);
+	for (i = 0; i < rp->nr_domains; i++)
+		rapl_detect_powerlimit(&rp->domains[i]);
 
 	return 0;
 }
-- 
2.34.1

