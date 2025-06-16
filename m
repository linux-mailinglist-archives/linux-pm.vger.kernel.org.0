Return-Path: <linux-pm+bounces-28737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C90ADA4EE
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87473AFC9C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B67E161302;
	Mon, 16 Jun 2025 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N6jM/syt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380A1494C3
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033711; cv=none; b=NCbJFV+8YOcj+PLGurRDjCxUfb/1gy12KdUec1Sgsf+gAORBQ2wYbxi4HmG02xdC6Hg8rr2l8rkcALeEXfSVn1y4o6X3vvvowsZ75uSPUWGDcZDVHaKtNY5FDx72ZoE9M6rdGKPpguDxVeJJ6zGhtgUGQUb0Ht60kJyLLH761no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033711; c=relaxed/simple;
	bh=CyevXooayJgTRHhip0Jc/dJHXf5dF8Ulyrh+9bR9yQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VY9J0m9vjLlusrThHgRrp5RfBjrrokxQa0KzqVYLIaxv+l7VkWr4MUnsltUsdKcOgwgVa0f+9a5DMS1UIfA+A/P/Nz9pYoHrPFO6s9T/3y56vCwHATxNeI9yLd62saU958uH8vKn+HzSfHSfLZ5nJHoZzYVC83QktpsLb4Mjsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N6jM/syt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNJl6n026338
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dDGlOHr4NgcDVCXG2RQ6GCKnY1CV3e4EG2J6GhifJ9w=; b=N6jM/sytFMeGNTKD
	ARV7N7bz0CnHvGuwbMJWaCFnWsoosqBcivtvF9oegs3hu+bbzwNYCciHpWRzm8CT
	irW55+qQuZPZumhJgqPGs/dyVKicn7cW4Fd9Kw9YS6JTNeQZ9tz2vG+Znqq9iAno
	yUlRDKzvofSSG+DWoZCiIKFIie36AzovUgushf2aNuBELAEq8+k+J9pd+RE7T3s7
	C1coJw6RBJtV7hQTbXcuPhTP2X3zlNMaTmxU6n7kzMht7874e/KVv/YbFBjec9kh
	Ux1Gt4g8xL2tJ2/PIctCwHubaHSG/US7hpKd+UAlWDQwJ+P3irEmKAgVrdkx+iiU
	HOMb9Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hfam6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:29 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6faeebe9c5bso34738256d6.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033708; x=1750638508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDGlOHr4NgcDVCXG2RQ6GCKnY1CV3e4EG2J6GhifJ9w=;
        b=UBI4+CNz9RQf2xfb7Qa/+2giSGaSZb0ZJ7STVx/tlnuwRb0u+qCYaKbS/khDtjmdTv
         sO5DSbbzLvoLrQEjg0oaMbWGI9V7MtXgK9DJrqfssHCx+3oocxyIXGrjSbmYgDdmYAp2
         CgCCNHtMnDZ20XbQjzjrgC5gfIZAFaFxKKCI5KgYuNoFzv/KLNoRb6Z685XQ52v4FvaN
         XBLBDQVjrpkoSmzMj4aOuh6E6DcgKwKMmx7n5yeAIf1Sg2zzHgITDe/hAU5ffzwna7Cx
         fBvS8FSqN4O8Jpm6A9i9hM2xLjkshPMLqE9MQrSXMywZIu3myXZXXP1iRO4ZB5JwUy9Q
         Z15Q==
X-Forwarded-Encrypted: i=1; AJvYcCXf1iodiU6TLNlo6mwgRddgpo58bQ3rOf/kKYeWJTVwK1nbsiKkizF4tG3TSx5GkX5haSxHcQLjhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0PPRlaMYYKc8PLzHhAYWE2fKl84L6PLmgBTDwCj7JhqxYLPPN
	vBCrHXc689kiCaTO3ezfBldK7bWyRq9/r8zQSkEnHOz474yL0m6PkvjQhkbX5bzYJFSv5c3kHZV
	o///FVJI68HxNMKYXo9nohhBtCwoBwi3gtOATdJYQSA7T2AC/6FZlTrGTX6Lkdg==
X-Gm-Gg: ASbGncvd40ZcMaOq4/aJiAOxIXpd/7+7qdJN7odknrqrMZb5zRjiNpg8gaiforYuah5
	V3cldyqRpqyps7nOX8CORCuwKCn72d3arzYZCDUBBJFi9+zUQ0VZI5ia5Di8qVV3a8cHdU0wB8l
	LCz87oeACGbPw+bphdJNFH3MOJBIiq2AUFdNn/rfF4PuRvJinOF4qVPX1Tw/M5vk9OptQSU67hj
	YQxik8EcHAKQZtz8fVZtB4abKq8b56mLMpPAMVIS/mYtYxU1lR2p6RyXir5+IqIJvk17PnJ50Tt
	dLIjlTZjU0rQyxW8VKgpAlsl2Ug+L4IT4rnR5RrsbFMR89smP2OO2IbGFquXohtfeHEtf26/RAR
	kybH4EykFvBFf7q4uhkaB9+KkjNUVUnWDUTg=
X-Received: by 2002:a05:6214:470a:b0:6fb:4954:846a with SMTP id 6a1803df08f44-6fb4954886dmr91519706d6.3.1750033707809;
        Sun, 15 Jun 2025 17:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt/JZjdIkRHjrhbfDSHfCFDPji9PWUnBm0HXDcW0iTYfjKMfPKMxD5XA4I6dTHJmHeuaSYxQ==
X-Received: by 2002:a05:6214:470a:b0:6fb:4954:846a with SMTP id 6a1803df08f44-6fb4954886dmr91519516d6.3.1750033707402;
        Sun, 15 Jun 2025 17:28:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:28:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:13 +0300
Subject: [PATCH 01/28] interconnect: qcom: sc8280xp: specify num_links for
 qnm_a1noc_cfg
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-1-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=814;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CyevXooayJgTRHhip0Jc/dJHXf5dF8Ulyrh+9bR9yQI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2UheJCO7+4KsyI6UefPVpkp7eVLHpsfkW/8Y
 gH6QLOIvVSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lIQAKCRCLPIo+Aiko
 1ScPB/0RAK0//iNxH/4+6HAe6bd22Av+Lttd13V1+oqzqJ+YtOIhBJSwlFRTpgY60SRhmWl3mdG
 QHkyMdPnQsVVdWn/IV5O6IH6lC9vB86u/mG4J45dwCFtXfw0F3ERMM3woOIDJeAXlIL/sLLUc/s
 SzG1/fcFTrZsrpPbV5yqHVpkwyBuTaHaIZsUyuakeF0Xa4ToMCFFbnzClf5nTCBOl6ml9rRwp1c
 Y7odSPsFlopOrEP40b/z7XnDx0uznUz6fbqpBCLVUdpCEM48QGcUlec2zF+ItRuGSX1nCwN2fsR
 zM0hX3g6NP7Ub2fhp0v+J4YUKw6GAmWxneORcdBI2GbQdlC0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMSBTYWx0ZWRfX7r6oQMpLdRy+
 cPs5GXzy+afWkIwsfJBwJIDvdfbX9gfDq7LUW8bfzycjnhtRuRc9PxYHof4LncaEaCR7Gy7W1Iq
 AByUJpM0kfgmnnj5RZbmpr4zmbdhUDC06ldIMlDJGnGWBdHY//FIKmlEAB4Nercdl86hW5bnlzY
 3j9UWItJ2gy9ahYyJPcdsQbMyVRFO7OecQ7whGp0zkL9JmWiUl+1L2vF+hCS0nbtbRtcYbFlY8r
 kJhLTpbo3iy/DuzlELLoXujSXLQV1yul+b+edFk6uxtJw1mHYcWrE2EYyaE0Nlq17Vq/CXfc6Id
 I65YjZ8ogTraur7zNUFsYEv8TIndSh4IB2ULAAtBS9dwWqfsLFpy2TJHGb9IxtTxr+T0p7TMvpv
 rYOvt/KFBo+ifNXHZGMVKCfvGN3Oe4Y7sq/9hUsZIygd9cWRvNPD0dZwBFN1R0QjglHc6MbH
X-Authority-Analysis: v=2.4 cv=VvEjA/2n c=1 sm=1 tr=0 ts=684f652d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=lLMxHPiN_djQrzgEttIA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 7KuGlXTllnMW-IFXUjYpBUgLIisqbMoF
X-Proofpoint-ORIG-GUID: 7KuGlXTllnMW-IFXUjYpBUgLIisqbMoF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160001

The qnm_a1noc_cfg declaration didn't include .num_links definition, fix
it.

Fixes: f29dabda7917 ("interconnect: qcom: Add SC8280XP interconnect provider")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sc8280xp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index 0270f6c64481a92149cb19556acdc6e2fead39c9..c646cdf8a19bf6f5a581cd9491b104259259fff3 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -48,6 +48,7 @@ static struct qcom_icc_node qnm_a1noc_cfg = {
 	.id = SC8280XP_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.num_links = 1,
 	.links = { SC8280XP_SLAVE_SERVICE_A1NOC },
 };
 

-- 
2.39.5


