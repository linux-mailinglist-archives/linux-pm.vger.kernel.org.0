Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1711D11FC00
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 01:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfLPAGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 19:06:07 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:44164 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfLPAGG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 19:06:06 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191216000603epoutp025bde8e819f54c32ae36f0c5afd4ca764~gsUFLZ-kT1533615336epoutp02k
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 00:06:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191216000603epoutp025bde8e819f54c32ae36f0c5afd4ca764~gsUFLZ-kT1533615336epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576454763;
        bh=yiZ2VagM8HQOxVfhO1tU2xkE4O7iWivvMoYcoWs9/co=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QQGWYhJpqLx1u0TBnVvZeIz8cZd8yI/KunSJU6bTlEWjbmSqvNTQRdGEUt9LDmBHW
         LAqVw4YFx0jP9jwxOOpalhDtuTwi5ZumqPdphTR7YGmVgQ20kwxqFZODMhZ34tL68K
         OLFr6LTEVhDcQKaJ044NAGadCrD4GZeyFv4PNk7c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191216000602epcas1p10a7aa2bd1d5ff5310c1200db1fd2a49c~gsUEMmMTR0396103961epcas1p1c;
        Mon, 16 Dec 2019 00:06:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47bhPg3ySvzMqYkc; Mon, 16 Dec
        2019 00:05:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.E2.48019.66AC6FD5; Mon, 16 Dec 2019 09:05:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191216000557epcas1p1f82e6da04e99a0299a67a95f9abbfe7a~gsT-PEuY41073410734epcas1p1F;
        Mon, 16 Dec 2019 00:05:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191216000557epsmtrp2747362009f1df9cf95c20b48d088a95b~gsT-LeGz72725127251epsmtrp2R;
        Mon, 16 Dec 2019 00:05:57 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-05-5df6ca66be89
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.66.10238.46AC6FD5; Mon, 16 Dec 2019 09:05:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191216000556epsmtip29edfa6046ffefe886e1ef5c8fd3a4e63~gsT_-5Ikl0780607806epsmtip2R;
        Mon, 16 Dec 2019 00:05:56 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM / devfreq: rk3399_dmc: Add COMPILE_TEST and
 HAVE_ARM_SMCCC dependency
Date:   Mon, 16 Dec 2019 09:12:28 +0900
Message-Id: <20191216001228.5258-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7bCmnm7aqW+xBjO3iFpc//Kc1eJs0xt2
        i8u75rBZfO49wmhxu3EFmwOrR9+WVYwenzfJBTBFZdtkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        pRak5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRnvFiyka1gEm/F4RdPmRsYO7i7GDk5JARM
        JObs/83SxcjFISSwg1Hixfsj7CAJIYFPjBLvXjBCJL4xStw+f40dpuPx/7OsEIm9jBKf+7ZB
        tX9hlDiytosVpIpNQEti/4sbbCC2iICMxNQr+8HizAJ5Emuv7AKLCwvESTSun8QIYrMIqEr8
        erMcLM4rYCmx8tclJoht8hKrNxxgBlkgIfCQVaKv5zvUGS4Sz56vhrKFJV4d3wJlS0l8freX
        DcKullh58ggbRHMHo8SW/RdYIRLGEvuXTgbawAF0kabE+l36EGFFiZ2/5zJCHMon8e5rDytI
        iYQAr0RHmxBEibLE5Qd3oW6TlFjc3skGUeIh8XV1OSTkYiUeTfzBOoFRdhbC/AWMjKsYxVIL
        inPTU4sNC0yQI2kTIzgBaVnsYNxzzucQowAHoxIP74uMb7FCrIllxZW5hxglOJiVRHhTtT/H
        CvGmJFZWpRblxxeV5qQWH2I0BQbeRGYp0eR8YHLMK4k3NDUyNja2MDE0MzU0VBLn5fhxMVZI
        ID2xJDU7NbUgtQimj4mDU6qB0fLHS9ZC7n07vm723Glib2z0mqVfxuBcx+KA1I06mVvPmy0J
        vD1/duiUZ+sN5s1dv+/EFjPnuCVcLJcLr8W1OW7TlHXTmn0nS57x7rEFxdvCOvaGt0X/uON3
        dWr8Zc1pWTkq377m31fXvWqR1/kpbfnvX5fiDAUFLx+TLvgxydIrNuBGzRTZPUosxRmJhlrM
        RcWJAGTjS5ZWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsWy7bCSvG7qqW+xBut3MFlc//Kc1eJs0xt2
        i8u75rBZfO49wmhxu3EFmwOrR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGW8WLKRrWASb8Xh
        F0+ZGxg7uLsYOTkkBEwkHv8/ywpiCwnsZpR4vFgfIi4pMe3iUeYuRg4gW1ji8OHiLkYuoJJP
        jBLHvh0Aq2cT0JLY/+IGG4gtIiAjMfXKfrA4s0CRxMntD9hBeoUFYiT2LHAFCbMIqEr8erMc
        rJxXwFJi5a9LTBCr5CVWbzjAPIGRZwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxN
        jOBw0NLcwXh5SfwhRgEORiUeXofsb7FCrIllxZW5hxglOJiVRHhTtT/HCvGmJFZWpRblxxeV
        5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cCYc0fUh9/CS/uY91fnlX8Ofnv8
        MmNbO5ds3eneKd2b1+x5rxMr80/2d67XszO7ddfuedl+ZE/NhM55P/rrjDi+vHSpOTOH+VS4
        4FwuneMvnm9/8sOFx25p1PM3J16bzZmnnP8/zfH5t/QfiesPn7nMnRIvwHixMIL5xd8mP30Z
        cY/YuxybNweLK7EUZyQaajEXFScCAH0wsRMDAgAA
X-CMS-MailID: 20191216000557epcas1p1f82e6da04e99a0299a67a95f9abbfe7a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191216000557epcas1p1f82e6da04e99a0299a67a95f9abbfe7a
References: <CGME20191216000557epcas1p1f82e6da04e99a0299a67a95f9abbfe7a@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To build test, add COMPILE_TEST depedency to both ARM_RK3399_DMC_DEVFREQ
and DEVFREQ_EVENT_ROCKCHIP_DFI configuration. And ARM_RK3399_DMC_DEVFREQ
used the SMCCC interface so that add HAVE_ARM_SMCCC dependency to prevent
the build break.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v1:
- Add HAVE_ARM_SMCCC dependency because this driver used SMCCC interface.
  It was reportd from kbuild test robot.

 drivers/devfreq/Kconfig       | 3 ++-
 drivers/devfreq/event/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 8485f948caeb..1526f758daeb 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -125,7 +125,8 @@ config ARM_TEGRA20_DEVFREQ
 
 config ARM_RK3399_DMC_DEVFREQ
 	tristate "ARM RK3399 DMC DEVFREQ Driver"
-	depends on ARCH_ROCKCHIP
+	depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
+		(COMPILE_TEST && HAVE_ARM_SMCCC)
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

