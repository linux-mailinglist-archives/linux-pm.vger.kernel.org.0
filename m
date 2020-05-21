Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325D51DCCDE
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 14:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgEUM3A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 08:29:00 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57966 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgEUM27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 08:28:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200521122858euoutp028392c546c07008fdb4a2e6ae57a55a40~RCujQHvL30377303773euoutp022
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2020 12:28:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200521122858euoutp028392c546c07008fdb4a2e6ae57a55a40~RCujQHvL30377303773euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590064138;
        bh=igXGRewGvuHwG1JtRT/phNUdDRjD08TvAgW2YxVqo4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODqnwnmLnd6a0bEV8c+h1VnQ47cQuHArvm+C/It1fIWECdPl9M5ihqt8OHNjeOIQe
         +Lqb7lcFN328fiNw3J3IkctEn3SBrHerkzqBMhRTPNKjygqRG2bduo1BDnWhLgjYap
         4AKY+JMsuCUic2ES0y+Ko99myW1kFYYGoyQHErrM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200521122857eucas1p244a6ea13ecf91a631fdcac6f74c2d638~RCuiXTTzq2557525575eucas1p2i;
        Thu, 21 May 2020 12:28:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 71.38.60679.90476CE5; Thu, 21
        May 2020 13:28:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200521122857eucas1p1db29d5dd09e801ca22214e94022a951b~RCuiJFOBq2055920559eucas1p1K;
        Thu, 21 May 2020 12:28:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200521122857eusmtrp24965f68ad019e8c96894122014cfcb08~RCuiIZdZr3031730317eusmtrp2M;
        Thu, 21 May 2020 12:28:57 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-50-5ec67409c827
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.6C.07950.90476CE5; Thu, 21
        May 2020 13:28:57 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200521122856eusmtip2fa784dfb01e2c67cef875537ef683d8c~RCuhqQ3Ta0357403574eusmtip2j;
        Thu, 21 May 2020 12:28:56 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org
Cc:     a.swigon@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v5 3/3] interconnect: Allow inter-provider pairs to be
 configured
Date:   Thu, 21 May 2020 14:28:41 +0200
Message-Id: <20200521122841.8867-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521122841.8867-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7qcJcfiDF7vkLO4P6+V0WLjjPWs
        Fte/PGe1mL53E5vF+fMb2C0u75rDZvG59wijxYzz+5gs1h65y25x+E07qwOXx6ZVnWwed67t
        YfPo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujPe9F9gLjolU7G3sYmlgvCDQxcjBISFgIrF4
        c3oXIxeHkMAKRonWzztYIJwvjBIzF25khnA+M0r0LtrMAtPxcY9dFyMnUHw5UNGberiGZbv3
        sIAk2AQMJXqP9jGC2CICMhJ7miaxghQxCzQxSdxcvAFskLBAsMSB9eUgJouAqsTUezUg5bwC
        VhLnF3xjA7ElBOQlVm84wAxicwpYS2w7NoUJokZQ4uTMJ2CrmIFqmrfOZoao38Yu8eSID4Tt
        IvF86wNWCFtY4tXxLewQtozE/53zmUDOkRBoZpTo2X2bHcKZwChx//gCRogqa4k7536xgRzH
        LKApsX6XPkTYUWLT7OXMkHDgk7jxVhDiBj6JSdumQ4V5JTrahCCqVSR+r5rOBGFLSXQ/+c8C
        YXtITN99lmUCo+IsJN/MQvLNLIS9CxiZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgQm
        ntP/jn/ZwbjrT9IhRgEORiUe3gfJx+KEWBPLiitzDzFKcDArifAu5D8aJ8SbklhZlVqUH19U
        mpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAPj6nkn+jcl8Qeqaxq94jkynyfb
        c/6Bi++zq688/7w3IObRpgnXxZ8fZtWfaHDjvPJf7o45aVvvsy1RSOuS+zN31lqGmA5GRieX
        X5WrrTVqZh1b2Xks+IeSVMQflZpTgddcLOZndOt3zXwc0ap7nK1t3RpWTueYU/simh4qrv5i
        Jt5g5nbX2qleiaU4I9FQi7moOBEAvx4PRDgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7qcJcfiDOae4rO4P6+V0WLjjPWs
        Fte/PGe1mL53E5vF+fMb2C0u75rDZvG59wijxYzz+5gs1h65y25x+E07qwOXx6ZVnWwed67t
        YfPo27KK0ePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jPe9F9gLjolU7G3sYmlgvCDQxcjBISFgIvFxj10XIxeHkMBSRolJK/qYIOJS
        EvNblLoYOYFMYYk/17rYQGwhgU+MEpe3MIPYbAKGEr1H+xhBbBEBGYk9TZNYQeYwC/QwSZz5
        vIAdJCEsECgxqfccC8hMFgFVian3akDCvAJWEucXfGODmC8vsXrDAbCZnALWEtuOTWGC2GUl
        cfHBAXaIekGJkzOfgI1hFlCXWD9PCCTMDNTavHU28wRGwVlIqmYhVM1CUrWAkXkVo0hqaXFu
        em6xkV5xYm5xaV66XnJ+7iZGYDxtO/Zzyw7GrnfBhxgFOBiVeHgfJB+LE2JNLCuuzD3EKMHB
        rCTCu5D/aJwQb0piZVVqUX58UWlOavEhRlOgzyYyS4km5wNjPa8k3tDU0NzC0tDc2NzYzEJJ
        nLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+MiZ/Y5GW8O9q2QVoqae+ulYTO7Qq/p/VVs/RlP
        zhbGR0dl2tvarknZevKS6+T6ic9N9Jo4bI2qZDr3ump1Xlhd+OlwljZLy7GdkUsKN+Z83rf5
        tr6zwB47vSNTc/4Ly6WunBNzUGNh/t/C/aFJjRHH4koVHVPXHNpivmRe/W/fn5M6FoV4/FRi
        Kc5INNRiLipOBABEHfAAvQIAAA==
X-CMS-MailID: 20200521122857eucas1p1db29d5dd09e801ca22214e94022a951b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200521122857eucas1p1db29d5dd09e801ca22214e94022a951b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200521122857eucas1p1db29d5dd09e801ca22214e94022a951b
References: <20200521122841.8867-1-s.nawrocki@samsung.com>
        <CGME20200521122857eucas1p1db29d5dd09e801ca22214e94022a951b@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@samsung.com>

This patch adds support for a new boolean 'inter_set' field in struct
icc_provider. Setting it to 'true' enables calling '->set' for
inter-provider node pairs. All existing users of the interconnect
framework allocate this structure with kzalloc, and are therefore
unaffected by this change.

This makes it easier for hierarchies like exynos-bus, where every bus
is probed separately and registers a separate interconnect provider, to
model constraints between buses.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/interconnect/core.c           | 11 +++++------
 include/linux/interconnect-provider.h |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 6a342ef..b549249 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -263,23 +263,22 @@ static int aggregate_requests(struct icc_node *node)
 static int apply_constraints(struct icc_path *path)
 {
 	struct icc_node *next, *prev = NULL;
+	struct icc_provider *p;
 	int ret = -EINVAL;
 	int i;
 
 	for (i = 0; i < path->num_nodes; i++) {
 		next = path->reqs[i].node;
+		p = next->provider;
 
-		/*
-		 * Both endpoints should be valid master-slave pairs of the
-		 * same interconnect provider that will be configured.
-		 */
-		if (!prev || next->provider != prev->provider) {
+		/* both endpoints should be valid master-slave pairs */
+		if (!prev || (p != prev->provider && !p->inter_set)) {
 			prev = next;
 			continue;
 		}
 
 		/* set the constraints */
-		ret = next->provider->set(prev, next);
+		ret = p->set(prev, next);
 		if (ret)
 			goto out;
 
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index c92be2a..38701925 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -41,6 +41,7 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
  * @xlate: provider-specific callback for mapping nodes from phandle arguments
  * @dev: the device this interconnect provider belongs to
  * @users: count of active users
+ * @inter_set: whether inter-provider pairs will be configured with @set
  * @data: pointer to private data
  */
 struct icc_provider {
@@ -53,6 +54,7 @@ struct icc_provider {
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
+	bool			inter_set;
 	void			*data;
 };
 
-- 
2.7.4

