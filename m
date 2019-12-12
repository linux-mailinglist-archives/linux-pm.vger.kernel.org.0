Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E653511C31E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 03:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfLLCS4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 21:18:56 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:16451 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfLLCS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 21:18:56 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191212021854epoutp015cb03140a5670ba8a75e10d2dbe1b9ac~ffi7g1pgl3042630426epoutp01F
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 02:18:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191212021854epoutp015cb03140a5670ba8a75e10d2dbe1b9ac~ffi7g1pgl3042630426epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576117134;
        bh=D/mpbRPQ7PYfFvRy7oND/XIuRaRfz2xb+Q3d4iAPYow=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pJvOMGSQ0eAzPuWKeNDR7yMlvEx5cDeybXUYzAxh7fsfr2ol2ucJZpCuzuzlQo5fY
         mc6WVq2Irr/u0n/idJt32lpvfx6XxWdYMPRQB5NOnB5eG3CY+ZmA+jQ92KfcaWiqCH
         EiKs7jndayvtqsDHVSU7yMsj6nsk0mkho8f9sSOk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191212021853epcas1p11159d588db64827853e04199855f5a5a~ffi6qWCpl0318503185epcas1p1j;
        Thu, 12 Dec 2019 02:18:53 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47YHXj6f6szMqYkZ; Thu, 12 Dec
        2019 02:18:45 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.7E.48498.583A1FD5; Thu, 12 Dec 2019 11:18:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191212021845epcas1p25476799a9de72f80c722b59ca67ce34d~ffiy0BxU81369213692epcas1p2c;
        Thu, 12 Dec 2019 02:18:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191212021845epsmtrp11780f5ac5590fa048a9cea31ce592e19~ffiyzXr_p0161301613epsmtrp1G;
        Thu, 12 Dec 2019 02:18:45 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-40-5df1a385bfc4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.E8.10238.483A1FD5; Thu, 12 Dec 2019 11:18:44 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191212021844epsmtip1fc1a27e37dfdf65cf773da3a3d08a35b~ffiyqMFgD0624706247epsmtip1w;
        Thu, 12 Dec 2019 02:18:44 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / devfreq: rk3399_dmc: Add COMPILE_TEST dependency for
 build test
Date:   Thu, 12 Dec 2019 11:25:08 +0900
Message-Id: <20191212022508.13716-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7bCmrm7r4o+xBm+Oilhc//Kc1eJs0xt2
        i8u75rBZfO49wmhxu3EFmwOrR9+WVYwenzfJBTBFZdtkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        pRak5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRnLGpvYCzYxFWxYdcFpgbGxxxdjJwcEgIm
        Ep8PTmIDsYUEdjBKzGpJ6GLkArI/MUpM2jKdGcL5xihx+MNnFpiOU48fs0Ek9jJKvPl4kwnC
        +cIosfNnGyNIFZuAlsT+FzfA5ooIyEhMvbKfFcRmFsiTWHtlF1hcWCBconn9ajCbRUBVYt36
        FmYQm1fASmLlrztsENvkJVZvOAB2hoTAU1aJv//vAW3jAHJcJFbPTIWoEZZ4dXwLO4QtJfGy
        vw3KrpZYefIIG0RvB6PElv0XWCESxhL7l04Gm8MsoCmxfpc+RFhRYufvuYwQd/JJvPvawwqx
        ileio00IokRZ4vKDu0wQtqTE4vZONogSD4m2bk9IKMZKnDm5nn0Co+wshPkLGBlXMYqlFhTn
        pqcWGxYYIcfRJkZw+tEy28G46JzPIUYBDkYlHt4H0h9jhVgTy4orcw8xSnAwK4nwHm97FyvE
        m5JYWZValB9fVJqTWnyI0RQYdhOZpUST84GpMa8k3tDUyNjY2MLE0MzU0FBJnJfjx8VYIYH0
        xJLU7NTUgtQimD4mDk6pBsZNmQqr/Yqb3/7Lk+P5OCHuWdFcQW91tm/rdX8a8+z5s9PhS83M
        XaHKFnwGPs+uvn2guj/lkJzNfXfLaweND1zZ+nWKwKcX8fsK9WaXKglPs6qXzk22jTBQsNyk
        4rH+wv7FjI57xR2FlqyKvnyUZ9m+bwE2FzqnGf+9WbCo9qBdho/2kf8sXHeVWIozEg21mIuK
        EwFMrTDGVQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJMWRmVeSWpSXmKPExsWy7bCSnG7L4o+xBgcbbS2uf3nOanG26Q27
        xeVdc9gsPvceYbS43biCzYHVo2/LKkaPz5vkApiiuGxSUnMyy1KL9O0SuDIWtTcwFmziqtiw
        6wJTA+Njji5GTg4JAROJU48fs3UxcnEICexmlJjdNpUVIiEpMe3iUeYuRg4gW1ji8OFiiJpP
        jBK/j7Yyg9SwCWhJ7H9xgw3EFhGQkZh6ZT9YL7NAkcTJ7Q/YQWxhgVCJZVe3gdWzCKhKrFvf
        AmbzClhJrPx1hw1il7zE6g0HmCcw8ixgZFjFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7
        iREcElqaOxgvL4k/xCjAwajEwztD/WOsEGtiWXFl7iFGCQ5mJRHe423vYoV4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpgrJZ0UvR2uFawTJ5zZ9+5uYmt
        NySm2ApoNFTPW5n+5dPOwlPJJ18sSIvmnf9Y6PsV3zdzXmXuTdV4qi6UtfTUhe+r3576zuiY
        6OjsHc9755xVkr/cnKttO268dwia+uUY295lb/d4bFi53HdL6Ov97mbd2tvW5N6ov7B4byLn
        u6bJS1b+jjd/+VWJpTgj0VCLuag4EQDjpFoUBQIAAA==
X-CMS-MailID: 20191212021845epcas1p25476799a9de72f80c722b59ca67ce34d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191212021845epcas1p25476799a9de72f80c722b59ca67ce34d
References: <CGME20191212021845epcas1p25476799a9de72f80c722b59ca67ce34d@epcas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To build test, add COMPILE_TEST depedency to both ARM_RK3399_DMC_DEVFREQ
and DEVFREQ_EVENT_ROCKCHIP_DFI configuration.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/Kconfig       | 2 +-
 drivers/devfreq/event/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 8485f948caeb..c9b1039ade64 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -125,7 +125,7 @@ config ARM_TEGRA20_DEVFREQ
 
 config ARM_RK3399_DMC_DEVFREQ
 	tristate "ARM RK3399 DMC DEVFREQ Driver"
-	depends on ARCH_ROCKCHIP
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select DEVFREQ_EVENT_ROCKCHIP_DFI
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_DEVFREQ_EVENT
diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
index cef2cf5347ca..a53e0a6ffdfe 100644
--- a/drivers/devfreq/event/Kconfig
+++ b/drivers/devfreq/event/Kconfig
@@ -34,7 +34,7 @@ config DEVFREQ_EVENT_EXYNOS_PPMU
 
 config DEVFREQ_EVENT_ROCKCHIP_DFI
 	tristate "ROCKCHIP DFI DEVFREQ event Driver"
-	depends on ARCH_ROCKCHIP
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	help
 	  This add the devfreq-event driver for Rockchip SoC. It provides DFI
 	  (DDR Monitor Module) driver to count ddr load.
-- 
2.17.1

