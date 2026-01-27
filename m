Return-Path: <linux-pm+bounces-41556-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPgaHv/heGkGtwEAu9opvQ
	(envelope-from <linux-pm+bounces-41556-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:04:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8C297584
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6823300AB1F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D6F35DCE6;
	Tue, 27 Jan 2026 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a4yoYuqE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aSgy06/t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489535DD1C
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529481; cv=none; b=F1EgixdSrHTcJYzW3ha1N07doQL/XMOXz6kwwZ8z/Y7vCQJlQraqojdFO8sX8ArQhuGlSzQTepEafUAWm9YpSa3pdaJ7jIfCU5p8hpoqLA9RG5t9VrMmMF8COpgt43llvZKPP107ohTyk9mSNDKGjfOZwn0idpAiltminWwVMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529481; c=relaxed/simple;
	bh=x/M55gi6Qb9WqILWE7GBmprHl3OPtbhtG5WQWHrVqk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDrrtCZrmuUoO+i1JoeQGC5VbOD2QkrbNzsE3MAuSphDYXIUmEwxFaerp3ClGV4jtoLTmP4nEGK4QEjQZ21cXzWlb4TBqCkt7ij5Uf5iuIjVlmZVfHpLGgVvbo3j8Jb7vghi6Z0EMUDCW/9UW21fr9BcxMx0gCqKu3o7Y9VBDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a4yoYuqE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aSgy06/t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBxWlk1795590
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kXcTyy9q1Y6
	KHhlX1eAZU2D74U7jaLF8GAA6nS+na/o=; b=a4yoYuqEBTEb7Vb+0sQgXqWOcQA
	Vc/jSWy5k5fAGXyu+lkcezSTOxVV/xYqylTnAjZXcYuDECTgtB8oLTchzBL0hL7v
	yKe/0KRezobir6hqvZ58GFNikp6RcKxIvur+r+j7KWHgKh2s4ul3Lczb7TjWOox6
	8Do8/13v1kuV0VbKdvUUnHBjTB/BM8544+IpFezqfjW53dEuTZAO+UyWUrIDKMan
	KEqxUdFlrxy0ur5yx3khne2+xytgR7/8D5IVCDtv/QNP0nPHmu4sb/xRbtZJU3/9
	RKFfh2T2xZP5dLqPSPXfjRkWJR4Xck3EgaQtKViL+OqCzHjJKUvyjE1oacA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxg93k715-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:57:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a76f2d7744so55419495ad.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 07:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529476; x=1770134276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXcTyy9q1Y6KHhlX1eAZU2D74U7jaLF8GAA6nS+na/o=;
        b=aSgy06/tf+k6ODxhrOnynalOVt1PgCf/TiOwXJU9EwHBzm/7T6ZtsniCo40hXR3eFw
         jgEQVub27phASdz9iF8hMjF3PtCh68YbaF86RqHUQofktAuvUIcbn9C9kWqvClvPMbJm
         CoEZ/SOpn8myS89LePDFKSqRfMILA5SyCFgGbwvPstUAb+2+DR2gQgZKgQ3T0KOlUF5B
         qOGbbkqkIoxZ3Salj+IQp54BrevJIouEN4MvY8BNf0c0QeB98YxXV5koZimlA96DkUAj
         tZmXtnQtXxX6N4OK99Chape1Dordm7TY9zvq20hWkHpjSQFXJh9p9OByG3pCPvhQngxU
         oHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529476; x=1770134276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kXcTyy9q1Y6KHhlX1eAZU2D74U7jaLF8GAA6nS+na/o=;
        b=W/uOkYdqYZ/mFjYNwmyDWO7TLgvVqssWeOuWg1l2dcGtuIfw2tLZdD9jeOup0XvgtG
         w4hK7IQ5kS2OOJ+fDKqnZLXvY4skT2pb+AJ7InUsSqRYhBjeO7cv/HzD7M4kNN7GH+pq
         ecClP6r3FzsB8bioxhVZyZavPdjdC84Jy9Yxh/sr75q2wXTMigPQ+BjGChKEnqPOnOlt
         A9jgoliJp53weZMzzXlc/B8B9TW6KroctwUYMllm6GXQUmB1ju8ErqgofY1srgSSjuLc
         DSWokuDaCbzAdJuTYos+icuvn3Bx88z03zSjWX9lqDuLuAQff0T8M4wJ70h21tXcDWI8
         P9UA==
X-Forwarded-Encrypted: i=1; AJvYcCUZc+/wnpJfQx9VF0F4J9M5SKeAeYWBUcF2zSzaSBO8Uy+qEM9wEf2OB9dDjsyJ5SWWUOWS3iWJ2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJpGWD7ddD8Yav7sQsKBTQxRvPdlW/kd9T4cVjfIiKHs1w9jwF
	BKD9Ff9EORhZcvZ4TjDpdGigKCPzkTSpmbqIkYBxxNQVlEzCjQCerDMWDrVrJ4eVpva8SWl1QOc
	QxfYmscJwvOCIimbe3bR6LwJM9MaABxrhO8vjOESjekqBbFJFC0yPzlUy2PzuOw==
X-Gm-Gg: AZuq6aJRihCVI9sWyOrbav0+yh22o42rsjjAwpwcos9E9CmndcUQZ6HGg3CDoUJbTpN
	wbb/C+i+W+e8+0Y3lhM8dOKGRzT40RkRRXvkvqpPONdr7m/cXYJtdlJW4tIc2a0Q7GCfiaTEn2J
	7V+qRafB7c0nJnzepzNgs9aYjWiDrinXDfP1kPzjpTCTFI1+r1EuuD6rrYT0nBCd0UQELEQJKPm
	4F6h8umCBvChNEiQrXdZErmTba7ij1YR9xcoNLpwENqptPtULOwWwTxa7SSJlfbdFd0bW32w/AZ
	hlbVnd/PYhQUwMzpe5pvs2BrfXelrw2VkhBcT7/AUpcymkupmm79d+qY3eRw3m3qD2NFScZPoP8
	dK0g7HaTVUsBJ55XT2JnBkde9m/wcECiGhDxA49Y=
X-Received: by 2002:a17:902:ea08:b0:29e:9387:f2b9 with SMTP id d9443c01a7336-2a870d6f1d1mr21909215ad.24.1769529475451;
        Tue, 27 Jan 2026 07:57:55 -0800 (PST)
X-Received: by 2002:a17:902:ea08:b0:29e:9387:f2b9 with SMTP id d9443c01a7336-2a870d6f1d1mr21909005ad.24.1769529474746;
        Tue, 27 Jan 2026 07:57:54 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede745sm120577465ad.44.2026.01.27.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:57:54 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gaurav.kohli@oss.qualcomm.com, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 3/8] remoteproc: qcom: probe all child devices
Date: Tue, 27 Jan 2026 21:27:17 +0530
Message-Id: <20260127155722.2797783-4-gaurav.kohli@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfX4BgXiYOm2QF+
 6L5rR1i0DYu9VKVkOTtTKkQouTqo2oyXU/o4Ul7AP8w53cF3AjnuFQxkbtPcUZti6WixQsFaS3A
 uOdFuoBhZEWyl/nN0vDaVIGLsd//CpsfdvO9+FuVmsxbGRRS+Fy6Yz2VX5Ara+tOTU5jjrUwloc
 RzLrVPYsUNdVPH9c/bdvxNfyiLv7PIi+IZz6Hw12oBJnsjzNzYu/BRTm0Ew9JLq9zoWr5mLByqN
 h5sYtqjEUhloWeRJp7g13F1AlRLtBx8ruPOSi7EIaYHv3LBqRGln1wXm/17wn54qPLiI1/ZaB/T
 tz6hZ4pZlit+wV0AOor/ptOix7MIsZZ1tHzLxgxL5oYsKCZmPrXwtaDC7quacuqGeafBcEnO3mM
 BhN5kIdqZ0rh1u2hQHNFWyqIHlZB5AudU0kxdKcs/995ANMYp6f0bGLjWreBwWsVQjaClpiratF
 h7LJz2Bd++Vg57iEh6w==
X-Authority-Analysis: v=2.4 cv=Uc1ciaSN c=1 sm=1 tr=0 ts=6978e084 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=85acS0iEUgW5otQd-vMA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: iEJbHiv-E5bLjKpd92Za9MyFmYRZLoa5
X-Proofpoint-GUID: iEJbHiv-E5bLjKpd92Za9MyFmYRZLoa5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41556-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB8C297584
X-Rspamd-Action: no action

From: Casey Connolly <casey.connolly@linaro.org>

Currently, only qcom,bam-dmux nodes are supported as
remoteproc children with of_platform_populate(). This limits
the other child nodes to probe separately.

Generalise the qcom,bam-dmux child node support by probing all
remoteproc children with of_platform_populate(). This enables
support for devices that represent themselves as subnodes of
the remoteproc, such as QMI clients.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5.c     | 4 ++++
 drivers/remoteproc/qcom_q6v5_mss.c | 8 --------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 58d5b85e58cd..a02839c7ed8c 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2014 Sony Mobile Communications AB
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
  */
+#include <linux/of_platform.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/interconnect.h>
@@ -351,6 +352,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 		return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
 				     "failed to acquire interconnect path\n");
 
+	of_platform_populate(q6v5->dev->of_node, NULL, NULL, q6v5->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_init);
@@ -361,6 +364,7 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_init);
  */
 void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5)
 {
+	of_platform_depopulate(q6v5->dev);
 	qmp_put(q6v5->qmp);
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_deinit);
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 91940977ca89..d40565c1cc62 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -238,7 +238,6 @@ struct q6v5 {
 	struct qcom_rproc_pdm pdm_subdev;
 	struct qcom_rproc_ssr ssr_subdev;
 	struct qcom_sysmon *sysmon;
-	struct platform_device *bam_dmux;
 	bool need_mem_protection;
 	bool has_alt_reset;
 	bool has_mba_logs;
@@ -2029,7 +2028,6 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 static int q6v5_probe(struct platform_device *pdev)
 {
 	const struct rproc_hexagon_res *desc;
-	struct device_node *node;
 	struct q6v5 *qproc;
 	struct rproc *rproc;
 	const char *mba_image;
@@ -2163,10 +2161,6 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_sysmon_subdev;
 
-	node = of_get_compatible_child(pdev->dev.of_node, "qcom,bam-dmux");
-	qproc->bam_dmux = of_platform_device_create(node, NULL, &pdev->dev);
-	of_node_put(node);
-
 	return 0;
 
 remove_sysmon_subdev:
@@ -2186,8 +2180,6 @@ static void q6v5_remove(struct platform_device *pdev)
 	struct q6v5 *qproc = platform_get_drvdata(pdev);
 	struct rproc *rproc = qproc->rproc;
 
-	if (qproc->bam_dmux)
-		of_platform_device_destroy(&qproc->bam_dmux->dev, NULL);
 	rproc_del(rproc);
 
 	qcom_q6v5_deinit(&qproc->q6v5);
-- 
2.34.1


