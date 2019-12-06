Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9184114ACE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 03:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfLFCMP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 21:12:15 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:61156 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfLFCMP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 21:12:15 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191206021211epoutp0478a1be469b91bb90fdf024e2fe0e5faf~dplWyBuSd1827118271epoutp045
        for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2019 02:12:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191206021211epoutp0478a1be469b91bb90fdf024e2fe0e5faf~dplWyBuSd1827118271epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575598331;
        bh=yVjyyT6cyfAJws8dtkCEPFuAEVTFjI069XI6tOasVco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOkL9U4Ytfswc9kOfD0iNblm2lqQ9eVVRgAcEsgVzT9RUAb/Stc7y2kYAZb6dFoj3
         YKtB06sdvkF8BM0Ua+AsJTKvBwNLoz/qxPG9updtwV2AbZVthlULIdHAveC1OHvCEV
         JaSS9kD2fMKGqqk1RgmAkR9p6dfHpxlzltNGwKas=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191206021211epcas1p15277bdbadc97c59092574f9d881869bb~dplWMaUhQ1340813408epcas1p1e;
        Fri,  6 Dec 2019 02:12:11 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47Tbgr49rpzMqYkq; Fri,  6 Dec
        2019 02:12:08 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.7E.48498.8F8B9ED5; Fri,  6 Dec 2019 11:12:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191206021208epcas1p1d7b3bb434108f38b0ef83b1c7d7a5d79~dplTeC1Gl1339813398epcas1p1c;
        Fri,  6 Dec 2019 02:12:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191206021208epsmtrp125a68fe2cd4077f830c21b10108a5f05~dplTdKUlN0289602896epsmtrp1K;
        Fri,  6 Dec 2019 02:12:08 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-f5-5de9b8f8587a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.8D.06569.7F8B9ED5; Fri,  6 Dec 2019 11:12:07 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191206021207epsmtip19b7f4826bf9feecd479158ddcd5f8a43~dplTMZTDx1992119921epsmtip1T;
        Fri,  6 Dec 2019 02:12:07 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, myungjoo.ham@samsung.com,
        b.zolnierkie@samsung.com, cw00.choi@samsung.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        mchehab@kernel.org, cpgs@samsung.com,
        Kamil Konieczny <k.konieczny@samsung.com>
Subject: [PATCH v4] PM / devfreq: add clearing transitions stats
Date:   Fri,  6 Dec 2019 11:18:13 +0900
Message-Id: <20191206021813.7193-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205145527.26117-1-k.konieczny@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ12OhiLY3G5EoU6xkRQkAFbByKERGIa5YGEN2IDkzJpCd3s
        tAj6IKiRsiqQECASFwS1YgoTJIhLtWKMimIlRI02kaBCcWepKCp2GIi+/fc/33/PybkXQ+S1
        aDiWZ7IxVhNtINCl4u67UbExMz1+TZzrjoLqbHBJKL8nino+NSqhjra4UOrMRIOEGhjokFKP
        j3yUUoO9p1BqsqoPUFf6fFKqjfslol6VXESpkYufpKkydcsNv0jNOctQtbu5Xaqu7nIC9SQX
        kSHJyt+pZ+hcxqpgTFpzbp5Jl0zszczela1UxZExZCK1g1CYaCOTTKSlZ8TszjMEZyQUBbTB
        HrQyaJYltqXstJrtNkahN7O2ZIKx5BosiZZYljaydpMuVms2JpFxcfHKIJiTr3cMPxJb3q0p
        vN1zEykGL8PKQQgG8e3Q0d+MloOlmBzvAXDWUY0IhwkAn9TWAJ6S4wEAh46sW0zM/R4QCdDN
        YOJ0YOEwBSD3s0rCUygeDd1jL1Ber8ST4FjpuJSHEPy8CL76Vi/lC2F4Kmx8OBhMY5gY3wS5
        YQVvy/BE2NRYLhW6RcLLHbcRXofgybD72fv5ZhDvR6F39MMClAY7fV5E0GFw/H7Xgh8O/SeO
        L+hD8NKDPlQIOwDscj+VCIUE6G6tmx8CwaOgq3ebYG+A12abgaBlsLhzdv4eBA+Fn6crJTzO
        +47jcgHZCAff+ESCXgtbSstQAVHDugqVsJ+TAN64dgs5CSKb/jU7A4ATrGYsrFHHsKQl/v/X
        48D8f4xW9YBzT9I9AMcAsUzWMDmmkUvoArbI6AEQQ4iVMl2oXyOX5dJFBxmrOdtqNzCsByiD
        S61BwldpzcHfbbJlk8r4hIQEajupUpIksUaGzXg1clxH25h8hrEw1sWcCAsJLwbsoDZ18vWP
        t1n0+Cfuakl86n76QJLm8PfhdrdqvDKfdjZ8LZz74x1dEXJdFPCmpThf77PF2AOBC3tqth47
        +k6xuaOEMBYZuLb61qTlOWVfGlOGfv32oZljnhJnx/3mfnFERa++aahv2vf8Xn3Y2fbTjlib
        Z4mWexu55ZJr/YiDELN6moxGrCz9F3UjZ8KlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnO73HS9jDZo3WFpsnLGe1eLlIU2L
        61+es1o0L17PZrHg0wxWi/PnN7BbnG16w25xedccNovPvUcYLdYeuctusWzTHyaL240r2Cwe
        r3jL7sDrsXjPSyaPTas62Tz2z13D7tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZHQ9PsxQ8
        Fa84sGMvcwPjTeEuRk4OCQETif9/zzN1MXJxCAnsZpSY93sPC0RCUmLaxaPMXYwcQLawxOHD
        xRA1nxgl9m1qZAapYRPQktj/4gYbiC0iYCPxfu4ZFpAiZoENTBLrjm0DSwgLOEjMPHWZCWQQ
        i4CqxKaHCiBhXgFLiVkzu9ghdslLrN5wAGwmp4CtxLZLz8DKhYBmNrxhmcDIt4CRYRWjZGpB
        cW56brFhgVFearlecWJucWleul5yfu4mRnCwamntYDxxIv4QowAHoxIP74zPL2KFWBPLiitz
        DzFKcDArifCm872MFeJNSaysSi3Kjy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbL
        xMEp1cDIcXfrwlsZ+/We/wuuctqce84kKr/d8Yjok5uii+Z5n1hZu1b64I/t2w/nxxTvtfMF
        shWWKEr4N22Yt1ph35K8V684n2aHK0/bdX4nx4s/Bjp/U/T+ah/i/XSPpeTOdl7higAtpzbP
        BKWlYncvVDQzPPl7ddLEJxcf8TOyNF/vmNb1put9uJkSS3FGoqEWc1FxIgB+O4t9UgIAAA==
X-CMS-MailID: 20191206021208epcas1p1d7b3bb434108f38b0ef83b1c7d7a5d79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191206021208epcas1p1d7b3bb434108f38b0ef83b1c7d7a5d79
References: <20191205145527.26117-1-k.konieczny@samsung.com>
        <CGME20191206021208epcas1p1d7b3bb434108f38b0ef83b1c7d7a5d79@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Kamil Konieczny <k.konieczny@samsung.com>

Add clearing transition table and time in states devfreq statistics
by writing 0 (zero) to trans_stat file in devfreq sysfs. An example use
is like following:

echo 0 > /sys/class/devfreq/devfreqX/trans_stat

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
[cw00.choi: Edit return value if entering the wrong value for reset
 and use arrary3_size() to get the size of 3-dimensional array]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/ABI/testing/sysfs-class-devfreq | 11 ++++---
 drivers/devfreq/devfreq.c                     | 29 ++++++++++++++++++-
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 75897e2fde43..9758eb85ade3 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -55,12 +55,15 @@ What:		/sys/class/devfreq/.../trans_stat
 Date:		October 2012
 Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
 Description:
-		This ABI shows the statistics of devfreq behavior on a
-		specific device. It shows the time spent in each state and
-		the number of transitions between states.
+		This ABI shows or clears the statistics of devfreq behavior
+		on a specific device. It shows the time spent in each state
+		and the number of transitions between states.
 		In order to activate this ABI, the devfreq target device
 		driver should provide the list of available frequencies
-		with its profile.
+		with its profile. If need to reset the statistics of devfreq
+		behavior on a specific device, enter 0(zero) to 'trans_stat'
+		as following:
+			echo 0 > /sys/class/devfreq/.../trans_stat
 
 What:		/sys/class/devfreq/.../userspace/set_freq
 Date:		September 2011
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index abecadeb3dc2..df31f430051d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1478,7 +1478,34 @@ static ssize_t trans_stat_show(struct device *dev,
 					devfreq->total_trans);
 	return len;
 }
-static DEVICE_ATTR_RO(trans_stat);
+
+static ssize_t trans_stat_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct devfreq *df = to_devfreq(dev);
+	int err, value;
+
+	if (df->profile->max_state == 0)
+		return count;
+
+	err = kstrtoint(buf, 10, &value);
+	if (err || value != 0)
+		return -EINVAL;
+
+	mutex_lock(&df->lock);
+	memset(df->time_in_state, 0, (df->profile->max_state *
+					sizeof(*df->time_in_state)));
+	memset(df->trans_table, 0, array3_size(sizeof(unsigned int),
+					df->profile->max_state,
+					df->profile->max_state));
+	df->total_trans = 0;
+	df->last_stat_updated = get_jiffies_64();
+	mutex_unlock(&df->lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(trans_stat);
 
 static struct attribute *devfreq_attrs[] = {
 	&dev_attr_name.attr,
-- 
2.17.1

