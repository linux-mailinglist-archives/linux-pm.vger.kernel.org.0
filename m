Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736BF13DDB7
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 15:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgAPOmp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 09:42:45 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58997 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgAPOmo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 09:42:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200116144243euoutp0285d73dc9bb8e4025c4c1e53a742e77b5~qZRXKBH3_2980429804euoutp02G
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 14:42:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200116144243euoutp0285d73dc9bb8e4025c4c1e53a742e77b5~qZRXKBH3_2980429804euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579185763;
        bh=Lium7TTZwjTEPgh49ryz56emZXTsJeqKBjeesI4GlDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cfV4eWn5jVqqt/+Sd+GHNeeWVJw7BSg+dJfIXFNhPyW1QXBZWY1zPv96PJxl+4JD/
         DwxvfN6Nu6Fsqv2wM+B8ynXpxe602kBOXZ+BQjuEtykT74pAul+WhwnO/qwTuB48X9
         838aq6cgNnfPlEKdMAnK9CwwwxK8d/zzmWIVSFfc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200116144243eucas1p1c137e737a96f07880a7c80a3c09ff20a~qZRW7VUje0497404974eucas1p1E;
        Thu, 16 Jan 2020 14:42:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 68.F2.60679.366702E5; Thu, 16
        Jan 2020 14:42:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200116144242eucas1p1b66d8ca0d111f140c48b80c5064ca4ff~qZRWhbFD40497404974eucas1p1D;
        Thu, 16 Jan 2020 14:42:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116144242eusmtrp13d1f7f04c02b7845a9b11ee6195b4f44~qZRWgrfuS0584505845eusmtrp1Z;
        Thu, 16 Jan 2020 14:42:42 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-46-5e20766382e1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8A.E4.07950.266702E5; Thu, 16
        Jan 2020 14:42:42 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200116144242eusmtip2bc90f6c9b952b9436eed055b20fd4699~qZRV4a8Ie2554125541eusmtip2e;
        Thu, 16 Jan 2020 14:42:42 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        georgi.djakov@linaro.org, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com, krzk@kernel.org
Subject: [PATCH v4 3/3] interconnect: Allow inter-provider pairs to be
 configured
Date:   Thu, 16 Jan 2020 15:42:02 +0100
Message-Id: <20200116144202.12116-4-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116144202.12116-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87rJZQpxBh/ui1jcn9fKaLFxxnpW
        i+tfnrNaTN+7ic3i/PkN7BaXd81hs/jce4TRYsb5fUwWa4/cZXfg9Ni0qpPN4861PWwefVtW
        MXp83iQXwBLFZZOSmpNZllqkb5fAlTHl4W7mgkMiFQ+mLWZqYDwp0MXIwSEhYCKxbKpEFyMn
        h5DACkaJ5jv5XYxcQPYXRom9e2YyQTifGSUmLuxmhmmYe8QcIr6cUWLX6rNMcB0X729lBBnF
        JuAoMWnqA3YQW0QgXuLjtn8sIEXMAjsZJY78/cMEMklYIFii9YIYSA2LgKrEnsVHwHp5BSwl
        dk1vAuuVEJCXWL3hANhiTgEric+PVSFKBCVOznzCAmIzA5U0b53NDDJeQmAdu8S3hmagBDuQ
        4yKxPgJiirDEq+NboCbKSJye3MMCYRdLPN15nxWitYFRYtOyI8wQCWuJO+d+sYGsZRbQlFi/
        Sx8i7Cixb+t6Fkgw8EnceCsIcQGfxKRt06GhwyvR0SYEYSpJ7JrJB9EoIdG0+hrUbA+J9wc7
        2SYwKs5C8sosJK/MQli7gJF5FaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmCiOf3v+Jcd
        jLv+JB1iFOBgVOLhnRGkECfEmlhWXJl7iFGCg1lJhPfkDNk4Id6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhhlHeNFLKotv9T9XMIYcSerPsp8vrCc172n
        6z799lR+0dvPpuzxb3Py4xWOs6SEdsXddP9016vCXMLl49ycA+enrQt8Gv1xWvyFcGNT7d9M
        3u8/9JvuzDjcO6eyQUnLY88bx4lb5Y9su8t75em1Uy++zkr2fn2a++v9B4eL5l/J8alW+X8x
        ZrGlEktxRqKhFnNRcSIA+8imlzADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7pJZQpxBt9/G1vcn9fKaLFxxnpW
        i+tfnrNaTN+7ic3i/PkN7BaXd81hs/jce4TRYsb5fUwWa4/cZXfg9Ni0qpPN4861PWwefVtW
        MXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5eglzHl4W7mgkMiFQ+mLWZqYDwp0MXIwSEhYCIx94h5FyMXh5DAUkaJySv3s3UxcgLFJSQ+
        rr/BCmELS/y51sUGUfSJUeL9/vNgCTYBR4lJUx+wg9giAokStx49ZgYpYhbYzyjx8k4b2CRh
        gUCJzTsPgtksAqoSexYfYQSxeQUsJXZNb2KH2CAvsXrDAWaQizgFrCQ+P1YFCQsBldze2M0K
        US4ocXLmExaQEmYBdYn184RAwsxAnc1bZzNPYBSchaRqFkLVLCRVCxiZVzGKpJYW56bnFhvp
        FSfmFpfmpesl5+duYgRG0rZjP7fsYOx6F3yIUYCDUYmHd0aQQpwQa2JZcWXuIUYJDmYlEd6T
        M2TjhHhTEiurUovy44tKc1KLDzGaAn02kVlKNDkfGOV5JfGGpobmFpaG5sbmxmYWSuK8HQIH
        Y4QE0hNLUrNTUwtSi2D6mDg4pRoYI3d2/E7Ya91760jclcqwSfxrvNYVpYoKZEXmR98tLU/U
        /nTSVneBjdyMxbnMOVqx1ybdsPUuiW+NvNY047e8qK935aQH8x+bFB+R51Z+/n3vUZek6QZt
        nwR2PzyaoHX+ZET+/TOhGnY7bq7cuzeq6ATPPK3JK6oinmzKvcTR3r6zcs1eJ6UVSizFGYmG
        WsxFxYkALfUZGboCAAA=
X-CMS-MailID: 20200116144242eucas1p1b66d8ca0d111f140c48b80c5064ca4ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116144242eucas1p1b66d8ca0d111f140c48b80c5064ca4ff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116144242eucas1p1b66d8ca0d111f140c48b80c5064ca4ff
References: <20200116144202.12116-1-a.swigon@samsung.com>
        <CGME20200116144242eucas1p1b66d8ca0d111f140c48b80c5064ca4ff@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds support for a new boolean 'inter_set' field in struct
icc_provider. Setting it to 'true' enables calling '->set' for
inter-provider node pairs. All existing users of the interconnect
framework allocate this structure with kzalloc, and are therefore
unaffected by this change.

This makes it easier for hierarchies like exynos-bus, where every bus
is probed separately and registers a separate interconnect provider, to
model constraints between buses (or between buses and DMC, handled by
two separate drivers in case of Exynos5422).

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
---
 drivers/interconnect/core.c           | 11 +++++------
 include/linux/interconnect-provider.h |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 5ea270af5ff4..caa9e35f06a3 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -259,23 +259,22 @@ static int aggregate_requests(struct icc_node *node)
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
index cc965b8fab53..b6ae0ee686c5 100644
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
2.17.1

