Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7548A1403B5
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 06:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgAQFwJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 00:52:09 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:30749 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgAQFwI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 00:52:08 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200117055205epoutp04d7f3c85f933cff5876cb4e84de25f77f~qlrWJyr1P0190601906epoutp04O
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 05:52:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200117055205epoutp04d7f3c85f933cff5876cb4e84de25f77f~qlrWJyr1P0190601906epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579240325;
        bh=pL9w1KAw9HjHZTaEzQOzdBlBCswZ4N9iJrQbbkHjEac=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mpe++tUdsKb0I+gum5KSA1thsS9Qc2YTWHJiXxABhPIkEdJcTN9LT0wauH6wCj0yB
         JT4rt2JeYI0O/V8vQ4twcuGO/h98NPU0qYPdkLoHvQWmZF5hYUd9JhARouBD/dl3sE
         0FgHY7pKm5kJrq8be3eVzjQODGDl0I9A7/YWnYkk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200117055205epcas1p3db9389138b312197303b3c7ebbc09e94~qlrVqC2tn2139621396epcas1p3o;
        Fri, 17 Jan 2020 05:52:05 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47zVZB6ndVzMqYkw; Fri, 17 Jan
        2020 05:52:02 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.4D.48498.28B412E5; Fri, 17 Jan 2020 14:52:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200117055202epcas1p13550813b01bb497ca79c8d31e45584c9~qlrS-fXzq2741527415epcas1p1o;
        Fri, 17 Jan 2020 05:52:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200117055202epsmtrp27e5d328863ccefe8f53fb849727b81e1~qlrS_2dNl0834908349epsmtrp2C;
        Fri, 17 Jan 2020 05:52:02 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-98-5e214b825da5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.CB.06569.28B412E5; Fri, 17 Jan 2020 14:52:02 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200117055202epsmtip142f10c612090f7b8befdbadd21c4e795~qlrS02bs62205422054epsmtip1q;
        Fri, 17 Jan 2020 05:52:02 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] thermal: Drop explicit PM_OPP dependency from
 DEVFREQ_THERMAL
Date:   Fri, 17 Jan 2020 14:59:14 +0900
Message-Id: <20200117055914.14584-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7bCmvm6Tt2KcwbsnFhbfz/1ksrj+5Tmr
        xbzPshaXd81hs/jce4TR4snDPjYHNo/Fe14yedy5tofNo2/LKkaPjuOVHp83yQWwRmXbZKQm
        pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDtV1IoS8wpBQoF
        JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZkZ7x9V1zw
        lK3iwrzYBsaLrF2MnBwSAiYSh+e8ZOti5OIQEtjBKDFn7gRGCOcTo8SxL/+YIJxvjBJvF/xl
        gmn5fBumai+jxOqVx6GqvjBKTLzfwQ5SxSagJbH/xQ02EFtEIFCidd4TsIXMAkkSd1ofgMWF
        BQIkur7fA5vKIqAqsePNfkYQm1fASmJW70VGiG3yEqs3HGAGWSAh8JNV4v3k31BnuEj8WvCa
        GcIWlnh1fAs7hC0l8fndXjYIu1pi5ckjbBDNHYwSW/ZfgHrbWGL/0slAgziALtKUWL9LHyKs
        KLHz91xGiEP5JN597WEFKZEQ4JXoaBOCKFGWuPzgLtQJkhKL2zuhVnlIfJo5CywuJBAr8a1v
        J8sERtlZCAsWMDKuYhRLLSjOTU8tNiwwQo6kTYzgJKVltoNx0TmfQ4wCHIxKPLwzghTihFgT
        y4orcw8xSnAwK4nwnpwhGyfEm5JYWZValB9fVJqTWnyI0RQYehOZpUST84EJNK8k3tDUyNjY
        2MLE0MzU0FBJnHe6C9AcgfTEktTs1NSC1CKYPiYOTqkGRj77nbbGCpM1JA/Ylb5+Gv4mrE4o
        y7o09s48xeQVEzdO1rC42HRcp0Y7RqdkWoynxlqvbje+drUlmw49esQXZym94PRL486WFRH2
        lUdem0hXTOStvRE6OfmPy1oloeuvW352h9bGmWWp7XwoLFE7gbmFY9JfkRKXDrkbXhNaK30O
        LVB6qhuvxFKckWioxVxUnAgAD2oK4GgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42LZdlhJTrfJWzHOYPYjUYvv534yWVz/8pzV
        Yt5nWYvLu+awWXzuPcJo8eRhH5sDm8fiPS+ZPO5c28Pm0bdlFaNHx/FKj8+b5AJYo7hsUlJz
        MstSi/TtErgy3r4rLnjKVnFhXmwD40XWLkZODgkBE4nPtycwdjFycQgJ7GaUuLPrNFRCUmLa
        xaPMXYwcQLawxOHDxRA1nxgl1p/czgRSwyagJbH/xQ02EFtEIFjiwop2sDizQIrEmXdH2EFs
        YQE/if6n7WA1LAKqEjve7GcEsXkFrCRm9V5khNglL7F6wwHmCYw8CxgZVjFKphYU56bnFhsW
        GOWllusVJ+YWl+al6yXn525iBIeMltYOxhMn4g8xCnAwKvHwzghSiBNiTSwrrsw9xCjBwawk
        wntyhmycEG9KYmVValF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6pBkYd
        xX19Yppzpfe0qfQfy2XUnvGz9uKrWbMzj8Zn+e4VD5dT93mgtCt45kS2O6e0057s4V/gISrm
        0iIeoj0peeYEUe1Dup8sRS37z/Jv2tiosPUSH2+utbD6wS9S327Pm31RuKHo84lZXI3TXpzK
        knx08xkj42N7cwWl85tPpzS7bVt+tiaw87oSS3FGoqEWc1FxIgAv8VFKFQIAAA==
X-CMS-MailID: 20200117055202epcas1p13550813b01bb497ca79c8d31e45584c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200117055202epcas1p13550813b01bb497ca79c8d31e45584c9
References: <CGME20200117055202epcas1p13550813b01bb497ca79c8d31e45584c9@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The commit b9c69e043266 ("PM / devfreq: Add dependency on PM_OPP")
has selected PM_OPP always to use it as the mandatory interface. So that
CONFIG_DEVFREQ_THERMAL doesn't need to specify the PM_OPP dependency
because if CONFIG_PM_DEVFREQ is enabled, PM_OPP is always enabled.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/thermal/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 79b27865c6f4..9c3acd715428 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -175,7 +175,6 @@ config CLOCK_THERMAL
 config DEVFREQ_THERMAL
 	bool "Generic device cooling support"
 	depends on PM_DEVFREQ
-	depends on PM_OPP
 	help
 	  This implements the generic devfreq cooling mechanism through
 	  frequency reduction for devices using devfreq.
-- 
2.17.1

