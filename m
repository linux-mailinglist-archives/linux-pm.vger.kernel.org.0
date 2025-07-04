Return-Path: <linux-pm+bounces-30143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC5AF987A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA826166E51
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094872EBDE7;
	Fri,  4 Jul 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9Pjmo1M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7219D2DAFCD
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646928; cv=none; b=TnwQ9gRY9mzAdwEbSyhtgvvpAL3Fsro00FiVPKyr+l+ecitpv7dw/EZ4HnqaDdnjTGcw37it34zdZYAxcjzavCJuoPLTSenJueahy87vHl2PGN1TcFe/MBpzcKPYlUZRt0SKmdzYSbtsQKwEH2edxIDoKqqcJxE9qZwY0Dh7L6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646928; c=relaxed/simple;
	bh=gfgsNf97a4gh+Kj/WAFR7Au3voGVBKemXRNGvFV/pQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PC1uHOkz/vu5N9k8D2pV2sTAWRhy+hbMEQ0g1pX0m0rvPMt3N/+QvxXzZ5F872jHSp8qzqGODfZn3JWZjH2D54NEQWrnbd7AaXefpU+L7Wf2g2oVzhllUwQFkewgIezZ7LzU6SawITPUXdSW8fhuaGvBALb0K9JfS0FU8hXT/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O9Pjmo1M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5648VVjD010221
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FfzLENn8AreWFlLbfZZwByLrmHBduXBntme3gzzOYSg=; b=O9Pjmo1MDjryCOMZ
	QWV+ISc4yHeTnhBN6wCYr+Mryws5Gya7KyT62gT869o1Zq035KV/9fBs0buRW4iv
	eMP7+YCgnPZZ7v0Oi2RAc7f+KKrK/r1KmQjNHyeu2F1BcD65hmnKmqgl7s+E5z/I
	XW7OKxInpCkAvhjXD9qIO4dtba7sEwQq+eE4apwTM9wIMbHMeJa/9lxM9z5aQ6kb
	Mn0akcBYiYyuRDdKYXH0tJuBVJhh73o77ZXifket71vSgyk7DKuSb+DUywmTzh9J
	R+CUZa7xN733kATqiOMJqnuaZ+3H4Znps/E6+9Duu3tMMkwBTJtimqhf3Qfpq1pv
	9SwwYA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8s9vh1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:35:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d3cbf784acso282343185a.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646926; x=1752251726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfzLENn8AreWFlLbfZZwByLrmHBduXBntme3gzzOYSg=;
        b=kBiEncpdiOiOEhq8wdZwu/BtM31CmMkD/9o4wq6xi3EH43MnWclGOJyja8xMTlBRuB
         XHWUwpKIUH3tw8UMHoNGS+/qxnkBySUzdGdwE7UcnG2wJoQqQArQMI/4/PYqAJxEtK2a
         D0zp2FNJ+0b1T1Mj+RBENRpfCRuB0qoG+bp3Nyd7cMOULkNBPmG6PTje7Oz7q0wJ0zJ9
         IMuvuMZ1UbpN3S3HUDF1k+lASOKFRkaMBG16dGxSCv1/jaM7jLV9UjC5JamKWnuRHq/T
         syRWmdHEhOdIv/cJUYKFxKEGKoxER6CbUPlmnoRb3bVR2aJR4wskRsBf7lBqBAxXe+sP
         k7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUIOfOc1XLwmUAnlvEM+wEmFl5Z4V8Mv2ZNEy6M3DRd/R1wuVc4otrT8CS4rHYZhUkAzL8CT1hVJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwoH/cv2zCA0FfeelXDVq8rXQM8j0be5bjzHUnEPsN1jL+GlNA
	cgXLIsHyK0OmuZQ8n20eCeGxo1xPoSKJRs0887WQYK8UZX4TpAxOKFOpDmRazUzYgeCovFm6ubY
	pNBSpw3o/LECDHQOckK27zfxAA0gkBYx1tXMZwvTxBI2jfk5MtJEQjVdoyv3ylg==
X-Gm-Gg: ASbGncuqHzf4K9TDEOJOGJQFSYT1YuBTYRO/DkxEKajPik7IWC/pI5KJezhdveCtcVy
	yscwmXVvmIjQEE/0zdSOKuWpyYQqejOlblC3jogX4qQLUoldZ3m4B5ImrYKZNE02ewJXzFqOl0h
	yit03fZybdaYGD6sTHwgkLLimcotPWGx2HlFV1WHuvG72UgoHFe0Dv4j4ninreJkvqP8Mxj3nYf
	aKLbxmXxvjU6H1rPLSGbiycQGOJteOOrlDTRAVAyGFyoR9vrssFeXGhfu5Gs8gE7BQrsYjzJ5SJ
	6neoHeyGVfDS4JQDygt/+yOaArGkTSgkAYo6wF1/HIyTP6l0w4/3GJJ5PWbd+x2WMdrhnIJxQsM
	RrWECgxQ4xS+ds3Z73oi581AyG2/RHDKMee8=
X-Received: by 2002:a05:620a:2487:b0:7d4:5361:bb7e with SMTP id af79cd13be357-7d5ddaa7e54mr403616985a.8.1751646925610;
        Fri, 04 Jul 2025 09:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSiIrbj5T8wan4VzNj4OM6LypfF2CYwdOWFucarddTghF4qTmlqyWy4L3a86W6cPqRfAe6hw==
X-Received: by 2002:a05:620a:2487:b0:7d4:5361:bb7e with SMTP id af79cd13be357-7d5ddaa7e54mr403613185a.8.1751646925135;
        Fri, 04 Jul 2025 09:35:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:35:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:14 +0300
Subject: [PATCH v2 02/28] interconnect: qcom: sc8180x: specify num_nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-2-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gfgsNf97a4gh+Kj/WAFR7Au3voGVBKemXRNGvFV/pQo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaALE8wL7DGkOZpUsG21ISBXejjozAU1TYZo0u
 gCLksE44X+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGgCxAAKCRCLPIo+Aiko
 1UIsB/95IXcFcAp3rJaW5SDpehXV0cFUM15twIA1QVGZv5Fl7nmafvVlVszgSMExLecPYn3itU9
 zbUe8MawNQdHFGmcUliKp9po/zHYAPA4WMopMGcBE8vC+85ngz+PgP596VO2JNJmZs4v9EwHN0A
 cC4lgR0EjRnpmyu8BcVw4+w9Kq35deM2bPFVh7y3vhOp9PrbMEyS1EE1btjvli3VooETB+UcJE2
 rCB8iS90r872pMwSfKqfVXzTgFO5Lkb46kbgkO+rpUHmFcJ2+7/WC5oPsvDiLJoystwam2UZBLl
 RMZGN/cRomBLO+lEYcMDA1eYgCEiVa0Z+FUW6EDSARXNH5R/
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=H/Pbw/Yi c=1 sm=1 tr=0 ts=686802ce cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=vjf1cmd32cIfnlU9i4cA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: rKQpAzhA20Oib1Qoh-yd7VaqnS8kFD-F
X-Proofpoint-GUID: rKQpAzhA20Oib1Qoh-yd7VaqnS8kFD-F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfX3KHb84043VxY
 8dhBAiUSmk/8+1wPsse6/J+Za4hKiNDsJ2J5cDge4zSZ1sNZW63+M+4Uido0x4Mh8QMxJP/xqEQ
 0F2EppI+CwyoKDh2h/sJOqIeuAI6mKN7+3G2Oq8YHP0Imp8lo8tQdgzPQael5/oWmsTLi3VwZIo
 8w1iG+gmeGf3i+RO0etxTJZUcqjNzIW+LiW3w/wTHRudC6uUkXMajMwPRt1ukSnEW8uJrIC1UdU
 +3nvAfm2DRtKKbo5GJhvLHM6Qy/L+45wyvXX/Tkr7XOIK3sogegFDO4+Ug2GyZbfucOkpMzZmA0
 EX6J9Q/aMNOBuCIVv1af0CgSvLg4IjDwQ700loB6YwHjtqVqt+WjlNNoHvTE1LvB3msvjl3dg5z
 HXPNBKX/6ssJdZ1yPjoLtUEZNyERA4mSsggEnhJHYMtQkOtP1IEUSUPt5/3VmKTqQPbgXhoj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=906
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507040126

Specify .num_nodes for several BCMs which missed this declaration.

Fixes: 04548d4e2798 ("interconnect: qcom: sc8180x: Reformat node and bcm definitions")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sc8180x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index a741badaa966e0b1d0e0117f73f5d37c6ef9f19d..4dd1d2f2e8216271c15b91b726d4f0c46994ae78 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1492,34 +1492,40 @@ static struct qcom_icc_bcm bcm_sh3 = {
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
+	.num_nodes = 1,
 	.nodes = { &slv_qns_gemnoc_sf }
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
+	.num_nodes = 1,
 	.nodes = { &slv_qxs_imem }
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = true,
+	.num_nodes = 1,
 	.nodes = { &slv_qns_gemnoc_gc }
 };
 
 static struct qcom_icc_bcm bcm_co2 = {
 	.name = "CO2",
+	.num_nodes = 1,
 	.nodes = { &mas_qnm_npu }
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = true,
+	.num_nodes = 2,
 	.nodes = { &slv_srvc_aggre1_noc,
 		  &slv_qns_cnoc }
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
+	.num_nodes = 1,
 	.nodes = { &slv_qxs_pimem }
 };
 

-- 
2.39.5


