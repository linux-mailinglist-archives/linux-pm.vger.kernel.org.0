Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D633729EA69
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 12:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgJ2LYB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 07:24:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56330 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2LYB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 07:24:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09SEDxLw118461;
        Wed, 28 Oct 2020 09:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603894439;
        bh=CGbk+TqltaWljJdz+345eX5OA+IoIF5ZNzvJtBc9gHY=;
        h=From:To:CC:Subject:Date;
        b=mxX6HFhGoBHnyILxu+I+zbgNowxtBCvhK6Tg1yU88Yju6IwiAbUydjh79W/abAB21
         a5j2uO3l4Tk/nNJMTbYUu9OxPld/Y1MggYb1vh929i/7l6yszI86l60In/89P+8Q/y
         gO7LR+kPDqoGj88CVS/olva6i6lLdXPJT/NI288w=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09SEDxOT080689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 09:13:59 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 09:13:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 09:13:59 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09SEDvZK029136;
        Wed, 28 Oct 2020 09:13:58 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] opp: fix bad error check logic in the opp helper register
Date:   Wed, 28 Oct 2020 16:13:57 +0200
Message-ID: <20201028141357.10345-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The error check is incorrectly negated causing the helper to never
register anything. This causes platforms that depend on this
functionality to fail always with any cpufreq transition, and at least
TI DRA7 based platforms fail to boot completely due to warning message
flood from _generic_set_opp_regulator complaining about multiple
regulators not being supported.

Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2483e765318a..4ac4e7ce6b8b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1930,7 +1930,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 		return ERR_PTR(-EINVAL);
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!IS_ERR(opp_table))
+	if (IS_ERR(opp_table))
 		return opp_table;
 
 	/* This should be called before OPPs are initialized */
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
