Return-Path: <linux-pm+bounces-42368-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLdGFWdIimmXJAAAu9opvQ
	(envelope-from <linux-pm+bounces-42368-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:49:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580711490B
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BE1D300D776
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 20:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD113425CCD;
	Mon,  9 Feb 2026 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RKrrqfX9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PIIMGXNz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2183A1A5B
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670163; cv=none; b=YTYEShMCh5jLtIxIa2LYBTesmB2T8SNB+bKysgPsvHEIxvJaCpSphOG21Xv8WMw7tRcJjNNbykyOZY5/fx5kKB0Mb+wXtQ8vGCE/eKvrxoPNmDC/Rsf8wnScnJVwYPewp3+f3EyqrdvQUDlFce2feQZsbgmgkjQ3zYhr0xfFLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670163; c=relaxed/simple;
	bh=szE3uTdQ2zlh+pJ+0h433F4Jn9gSZEhssLs2SPsqn0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LTKnSSLvtA45TVpsnIFZC9H2GYX3RiKP6klO2VhlfGhXO8mTI5p5oBq6NFnfacv1DhIl7KlyB4F5DiTyzR5q6+cmmYLYZNmX2Kgl01aXRVJmAAd5hBQ/izCUIe4rrNXtDjx5XiS6H50uOa9m9VF6mifXBTyAso2LyONslw+FpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RKrrqfX9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PIIMGXNz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619HNLcF3699972
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 20:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NcxRueC2eU5
	LWtebFYR9VPhKwz6ZxYqBGgW0AGpwe1A=; b=RKrrqfX9Gb8mccVOEvel0hlK6NH
	QxH2vFugKe9frvo6f9Y1R3IS9ULzcsEsx8VSKs6fEpSO2zIYR5mEJFw3bRSsJ/pc
	qjCLKv/uuuosxKplawMQfNDipsl26BjodLWFQbY8KM5gIhtWPpR+FQXS7/2WYWRN
	yiF0F7WK+uVYqkWV7100lwHyOc0hfvxFEJ4ZDASPzIvBazw5UT8SlhNZylFa+foH
	I3jwd+WM7GPME5+K0Dc272VzLr8t119Rc1IEKX0joK3L4NSHgwiwkaAiFf2k2X5u
	7z21gl0LGIohJYrXuqMbslatPxnc9exvDnCTaAp3YrvoEwK+Bxdo5Gme1pw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7e4m9yb7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 20:49:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba6e8ac125so452663eec.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 12:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770670161; x=1771274961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcxRueC2eU5LWtebFYR9VPhKwz6ZxYqBGgW0AGpwe1A=;
        b=PIIMGXNzW3OORTLa0ch3Nn6yPTlfHDMA2LphpB753ETvP8sEW6YBxrHg6WipX2D+Le
         L0C32lQZ5KEDLNbzdoY1bL2ByBsllMqpN08V1UCeMtBaKlUjAOlB2uO0GPikGqs7IpQO
         MpFjYDzCJU6qTTMhaBdbd9s/vHNsomkYq9QzHxwrStrtAFLoILLHDnm4ky2MUwIXKCSw
         TynELGHE67neyxdlH7Cmj7nKVVuMdpjwJLxNHDoxqsFTy0xMW+9pU4puWXzOo9ZJRqqu
         A1bIfN/rQuVe3wmRrMlAa4OuhVQ+rs7MdSrddar3OHyVo6HHdMbEyTKn78PI9YPebkgj
         1LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670161; x=1771274961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NcxRueC2eU5LWtebFYR9VPhKwz6ZxYqBGgW0AGpwe1A=;
        b=VFksq1cAy1C20FqS83LK8G3UCe3epfo5GN/i0zZuJ4Xo+nOOiLoUnmCyA96UbsxH69
         47jz68CwLyRATEDf+4DB2VHbh+f512dLNqavbq05C2aBV3k7z5eQPLiDryv4Kva45R2U
         0/x9zjD2mlL9S9zaNGz8jHX5YJdroLU3PVXf+WAIRRknsE6O7C8x4gIQEGnolhZWUB6C
         rU6q7QwovP3DxMM3ZlDgFv/fxRD4nBxIFW/QPNHtElKVQqRiyh+1ZGqsvCj3BUSyOzVX
         7pqSsaMS8o01/TTOp3ue83jZwwLAdxFQl+iRj+LyhyhuuKydcRiFG7cpe78xfhz93bY6
         XJ6w==
X-Forwarded-Encrypted: i=1; AJvYcCWs2WFYuG6EJn3CBKEjviJ0L4ecuoW/t3LSSc+9M+PK/T1Ms0QooSr1PCu03NNDPolHcsfaVHmLeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTtypxVr2j0ZdPSjb2dka1bAuzgfNFZQt4hLLIKb2VrPrkbwGK
	qzHkh3ZAyAQPHhQoizgvafec+nzg0PdKRnOpkPMfIQVIPoKyz29HeAq+ZxivCfAlPrebx6hI7lj
	jjUdglbW90XD8GM5vGmfbXmOiwYGVo4XPw3u+7QuCk+P8GDsqh04+/pEzmKMRIQ==
X-Gm-Gg: AZuq6aLxh9DMCkTCWPH3M3h04nUHprRqfP5LGfGqMoVylm6uBaR0M5V/5QRIz267s8N
	0eMj2gbD3BEEKy/7BIbM1U143yl9U4+8Xuw3Zjke8Oxi4G72gwSw+zgXyR9MWXQCWgth+SNqu/q
	varl2QGtEkR2rt3SR/nrDuQ4RD/PJaLVwbs7fzWPuxy3MfxhbE33LqJ3np9/tyo1WQvqUk7ZqEU
	7dT+51VVW56/bFQMciOdwyDuv0Ilzx8cs2TttH6+7sVORazPRh+Iu2ar60vY/Ey/mePcuisnDbz
	x+J0OulDXub2f9UapAZd0a4YymkYdQO7FTwyz8NsZiDj9O+Y78LZqBhzsrsYnhcI3RHBw6mHRfv
	ixfHsYdLrS6XqcNxrKaxHvAxazUGRdnj4vbIAQbzH+75vSD8R5/slYa2xSWJNrwb9Rwg1S9kC
X-Received: by 2002:a05:7301:38a3:b0:2b8:2910:dc9b with SMTP id 5a478bee46e88-2b8563d941fmr5919652eec.3.1770670160778;
        Mon, 09 Feb 2026 12:49:20 -0800 (PST)
X-Received: by 2002:a05:7301:38a3:b0:2b8:2910:dc9b with SMTP id 5a478bee46e88-2b8563d941fmr5919641eec.3.1770670160175;
        Mon, 09 Feb 2026 12:49:20 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba89ae14c9sm106247eec.29.2026.02.09.12.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 12:49:17 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v5 2/5] soc: qcom: pmic_glink: Add charger PDR service information to client data
Date: Mon,  9 Feb 2026 12:49:12 -0800
Message-Id: <20260209204915.1983997-3-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2cs38CPBvM7H0T-P1b4_wRdb_g4XoQQ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE3NSBTYWx0ZWRfX4p0c6SwcPPXC
 QLDRI1sy151f0pa0k5FV05j99ottsm0LDCAhWdu973xXI1JCk56JqXXyv15vO5az604UCvDaQI7
 a1bFmCMIrHdMkWXFdTomow9P9cqqqQiK6sUvPf/yp0zfW2Unz5L3vPXYrxqADu7z3nVqpLfa44S
 Ghff4jAJT4FFk9AQ77U9n0iN28+bVchMQoWbztOZbA2Bcmp+3QnOrrRtFjxQjGpK5GKiJTNLfmN
 +w1K2ca8NLUb/Bwtj/rpXtOyoZSaiMBpeSkeLGWbCDaMYya40UDTW9Y+d8yxrNzFE9tBYOhqKvr
 xRmJuVPP+L+ekZlNMHtbr/JmV/yxTJ4iOdWTl1rrwTFO8gyI8fbkon9GZPdM/SYtBPcTcvBHPf+
 yhItsW3USY7hsV/qH4w5o+ePtxQVsm/+W3MsmMriE0DXNmGPywy56jpOinrreyWB3T/uUlcubTP
 8Njtb6R/xk737w6mgmA==
X-Proofpoint-ORIG-GUID: 2cs38CPBvM7H0T-P1b4_wRdb_g4XoQQ5
X-Authority-Analysis: v=2.4 cv=WecBqkhX c=1 sm=1 tr=0 ts=698a4851 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=qLYHXgdTuLTpAkILo5MA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anjelique.melendez@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42368-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0580711490B
X-Rspamd-Action: no action

Currently, the charger PD service path and service name are hard coded
however these paths are not guaranteed to be the same between SOCs.

Define charger PDR service path and service name as client data so that
each PMIC generation can properly define these paths.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/soc/qcom/pmic_glink.c | 58 ++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 627f96ca322e..df2fd03d3b33 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -23,13 +23,19 @@ enum {
 	PMIC_GLINK_CLIENT_UCSI,
 };
 
+struct pmic_glink_data {
+	unsigned long	client_mask;
+	const char	*charger_pdr_service_name;
+	const char	*charger_pdr_service_path;
+};
+
 struct pmic_glink {
 	struct device *dev;
 	struct pdr_handle *pdr;
 
 	struct rpmsg_endpoint *ept;
 
-	unsigned long client_mask;
+	const struct pmic_glink_data *data;
 
 	struct auxiliary_device altmode_aux;
 	struct auxiliary_device ps_aux;
@@ -292,7 +298,6 @@ static struct rpmsg_driver pmic_glink_rpmsg_driver = {
 
 static int pmic_glink_probe(struct platform_device *pdev)
 {
-	const unsigned long *match_data;
 	struct pdr_service *service;
 	struct pmic_glink *pg;
 	int ret;
@@ -309,12 +314,10 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	spin_lock_init(&pg->client_lock);
 	mutex_init(&pg->state_lock);
 
-	match_data = (unsigned long *)of_device_get_match_data(&pdev->dev);
-	if (!match_data)
+	pg->data = of_device_get_match_data(&pdev->dev);
+	if (!pg->data)
 		return -EINVAL;
 
-	pg->client_mask = *match_data;
-
 	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
 	if (IS_ERR(pg->pdr)) {
 		ret = dev_err_probe(&pdev->dev, PTR_ERR(pg->pdr),
@@ -322,27 +325,30 @@ static int pmic_glink_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->ucsi_aux, "ucsi");
 		if (ret)
 			goto out_release_pdr_handle;
 	}
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
 		if (ret)
 			goto out_release_ucsi_aux;
 	}
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT)) {
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_BATT)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
 		if (ret)
 			goto out_release_altmode_aux;
 	}
 
-	service = pdr_add_lookup(pg->pdr, "tms/servreg", "msm/adsp/charger_pd");
-	if (IS_ERR(service)) {
-		ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
-				    "failed adding pdr lookup for charger_pd\n");
-		goto out_release_aux_devices;
+	if (pg->data->charger_pdr_service_name && pg->data->charger_pdr_service_path) {
+		service = pdr_add_lookup(pg->pdr, pg->data->charger_pdr_service_name,
+					 pg->data->charger_pdr_service_path);
+		if (IS_ERR(service)) {
+			ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
+					    "failed adding pdr lookup for charger_pd\n");
+			goto out_release_aux_devices;
+		}
 	}
 
 	mutex_lock(&__pmic_glink_lock);
@@ -352,13 +358,13 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	return 0;
 
 out_release_aux_devices:
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
 		pmic_glink_del_aux_device(pg, &pg->ps_aux);
 out_release_altmode_aux:
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
 		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
 out_release_ucsi_aux:
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
 		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
 out_release_pdr_handle:
 	pdr_handle_release(pg->pdr);
@@ -372,23 +378,27 @@ static void pmic_glink_remove(struct platform_device *pdev)
 
 	pdr_handle_release(pg->pdr);
 
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
 		pmic_glink_del_aux_device(pg, &pg->ps_aux);
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
 		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
 		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
 
 	guard(mutex)(&__pmic_glink_lock);
 	__pmic_glink = NULL;
 }
 
-static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
-							   BIT(PMIC_GLINK_CLIENT_ALTMODE) |
-							   BIT(PMIC_GLINK_CLIENT_UCSI);
+static const struct pmic_glink_data pmic_glink_adsp_data = {
+	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
+		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
+		       BIT(PMIC_GLINK_CLIENT_UCSI),
+	.charger_pdr_service_name = "tms/servreg",
+	.charger_pdr_service_path = "msm/adsp/charger_pd",
+};
 
 static const struct of_device_id pmic_glink_of_match[] = {
-	{ .compatible = "qcom,pmic-glink", .data = &pmic_glink_sm8450_client_mask },
+	{ .compatible = "qcom,pmic-glink", .data = &pmic_glink_adsp_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pmic_glink_of_match);
-- 
2.34.1


