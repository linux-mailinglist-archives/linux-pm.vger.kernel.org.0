Return-Path: <linux-pm+bounces-28738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3568ADA4F1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2F216D167
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628C719259F;
	Mon, 16 Jun 2025 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nscwT137"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001917B425
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033714; cv=none; b=DkOVFmvXSn54k1GN+stMywgW3MqA2bkw3L+b9fYG14taRPyhzHkKaSIiEu3d+aySbqoyTTrL8BkzyJklqNOAk+0ypQwlPwnTHgYu+8EAd2h/WXFT8f1DXjECYSrzwowE6y6zF4xChUrv/8q2FzZfIQRen+8zd5And/1Hp1sQ2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033714; c=relaxed/simple;
	bh=gfgsNf97a4gh+Kj/WAFR7Au3voGVBKemXRNGvFV/pQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EMS2JgevIZbsbZreyfTXg6DR/n9Gu0+UMyMIlB6s+Q6OziDBpA6QS6VYBDr03hGGFzUMnWJWbeaJOhDU2mLXbCKN9uJZV6oBsmf3iKDvdoWV6OibcTPAO2rRAdk5SjRR7vYxh5g1R9cfFF4f3v+JCiY5VIekkExBZ4RGr5J9HuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nscwT137; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FLtQZZ012480
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FfzLENn8AreWFlLbfZZwByLrmHBduXBntme3gzzOYSg=; b=nscwT137R3EabhxY
	VVgxbAw18G+WKtWy/IOoz2MJx4UJd2ab3zeKvYXiGGczRKKA4dxLFUWT+jGzvDwX
	EtOx0ElGWf9Iux9/PvxC49QFAZQbgl6RxAJMSBf/QlxnoWbL2dwiyIIEHHzayZpE
	v4rTGgr8KkDhQxHGkz19YULnsFvL/8ngewNl+MwWkuwsIq6Gx2EA7m2J24DgwWn+
	k+uhZFSAKwFMKMgiwFhwNzdqtj1a8Z13jpf2Pqp3Z9E99InEpaA9QnN3v1yRRY5i
	Abs2MDWtswDLLhhkkn5iQuY14axX1kJyH0j+NKmUTGHxU7ySG5L9U8QaKNwjizew
	0jsEeA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47928mahjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d3d3f6471cso73295785a.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033710; x=1750638510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfzLENn8AreWFlLbfZZwByLrmHBduXBntme3gzzOYSg=;
        b=vMV8r2MT5Gi1eqVzzzBgiS1u0NCvDF+11sVqSJqRHHIhfKBrv5adrZ2K/i+/t9DKGt
         BOpO8iVWzVoVbLT+XlrFCmpw4cg+kYAe1v85VCTjdGq0eJ0EcQPuOpXGKgwbr6I8qcod
         1AZGchKPnlpYln9VRpJH9DoUjCZGXBJxWiV9k33d50rXiUG5jF/YL+DfmcfNfDMqzRaP
         ib7AF3GVmiBvlN4RN6F33jRDslv6Pd/Ywa50yspEL/w3xxNfQHILsHRbbzO5KC7ANWpQ
         yNjXYgIHCmuflT897jp/jctqtXQKJX7uetHIVnGGC/zTq/PIY3SkRWr8YKnAqgNGPDE+
         Ul9w==
X-Forwarded-Encrypted: i=1; AJvYcCXKtJJiExeInaJVe3IZu79mlcqpymZ60BPMGsN7F8aKjLvg+QHLdCHoZXl3lHoBqkTM53uGfsrmuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXVQFyixNZOjROGPnScaLrPOfKEs8YiiGsux2N72k7Gq6Eiwc
	l6ZZxqSxO8AtLSv3p3wJC9tZsx2AASAeXESmX0dsfojvluEitOprHizViZThw/HZ1m/1BFJly2+
	Mwot0pdh7TceQ2mcjQSSP/7jksz/bpGGn7vJf/PcqT1jBf760jshtrHGC5WkOXHfDg+ImdOPv
X-Gm-Gg: ASbGncu0gk0errMwVOpXUp2pfH3Nkj+Q8PlghkFwKfGf4FZQXwPTlmsW1PHjD7LVD3I
	PcGC9D6kHs5Cktp03aLAwoMmefiGqUtkBVD85rV3NGI2KfrmhzFaSpZ8KFkihkhbFVKLRP6oLP/
	2rGHGS7RTraMb/fEpV7HtY4dl/XkscsJwFhIzDmfiXQRJqKiUFb8TMJhs/ymRcYQmv1kNByarFL
	2ODbs/IDPOiiei383JwBcPUIG8HCSG0K+SP0L1ONyZz3cBcphgHR9blkVk/aKIwDZy3B2XXQp9j
	ZggBOWPUar4a5AY83+2zVcIYEQauIOPxzn3Ho+dLtqj8oOcxPY/OIZEQgbYwKjWJjbefPCyFEQq
	eDJry0AISJNfSCy7rPMG0DjTcKKjpQKmNFpY=
X-Received: by 2002:a05:620a:44d0:b0:7d0:a309:b1a0 with SMTP id af79cd13be357-7d3c6c0c751mr1110730785a.1.1750033710502;
        Sun, 15 Jun 2025 17:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk/yIzuRZZqMQ3LhoDyERqVvcf5MD4vzKio/gwar+uk6piJ5F4dlFaXrkh0qfchEHb4lRJgA==
X-Received: by 2002:a05:620a:44d0:b0:7d0:a309:b1a0 with SMTP id af79cd13be357-7d3c6c0c751mr1110728485a.1.1750033710115;
        Sun, 15 Jun 2025 17:28:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:28:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:14 +0300
Subject: [PATCH 02/28] interconnect: qcom: sc8180x: specify num_nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-2-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gfgsNf97a4gh+Kj/WAFR7Au3voGVBKemXRNGvFV/pQo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2UhCwSIZoeznObh5E5DDpjjQHwCl8X37gjwA
 rGvZJybsM6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lIQAKCRCLPIo+Aiko
 1bv6B/4kC5faMWFiz744jY1UFxso0LnlWVgZjY27ELM2XZmV41yZaF6n6LY3n6EIVP3CWq2PJf/
 FeOCF/Ikpndorq3NZJ67FR8E0RW4JGaxD/DvKRAmfMzX3mGxq3QCmdUBgkZ28CVYVRcmb3NWXWK
 SOWkdGALsa/agjjQfQxLgy5VqGbMjCNQ4FxUvKaVsIQZg1K6/bDGtFLozifwcjItxbuwGJJEBlD
 cLI15YMYr9Nq7QSNzyakYu9nSizz07fVvlhjeL0IGYgraaotNjVHsg6DOMJRGSeKUBtJtTegpu9
 MdDqr5a30V9JA0rtcuG51WXhjCcqFDPTItYmlWbIaKG7dQ4e
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMSBTYWx0ZWRfX0ZHNp/Xwdyzf
 UH+XJjhxv4abUt7Rvt2I/KDODOeS1WXF8UGZCkSaBpKFHQ67L5zYlma1S+G5cOaBmUtqWC0XWsm
 Tdmq2WohvHgLFJuG6trDwr85d+TvQjwB9Ua5umzdye5iyNjZsHxnwAkZnwqFFYeafN6VPNmt7oU
 7uXfM84wsAaT2UI89R0zBov0vg0zTzNIZ4WTYgr9/a3tuRE9a27RIr2I0FQrBNaXhCeoczs9n8Q
 XhHCmNxLQ0bwibnH9e31MMXOhjipDD8J4VUellZXIozJeo9agP1vE9Y5Rj0u8Eu2SRqAmTG7aa+
 PI+bRQoKGgCI/Inyn8vJld2wDQen29y3Hiue7IXhsqgMU1GlNiSyKy13ZScFWvz5lVIcPl/0uUy
 E7qWgO+RktYaQ+8ruqFKbT+lxyavNkIqa0EGhTRq2oYiAk+xqfzvBfF3gyH5aSyl1+eC1g5c
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=684f6530 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=vjf1cmd32cIfnlU9i4cA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: uYtz092t7ZGhBXd9GjVQfj-hT1AIPJoK
X-Proofpoint-ORIG-GUID: uYtz092t7ZGhBXd9GjVQfj-hT1AIPJoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=931 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160001

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


