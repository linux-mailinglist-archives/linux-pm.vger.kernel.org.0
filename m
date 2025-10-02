Return-Path: <linux-pm+bounces-35662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C95DBB35B7
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 10:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD61188F8D3
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7B2DF14E;
	Thu,  2 Oct 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDIQ9QHY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208DA2FCBE1
	for <linux-pm@vger.kernel.org>; Thu,  2 Oct 2025 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395189; cv=none; b=rwfBWcDHWzOQpwrAKsTSEbCPLep3Pni4KVj+ei+ck2iruIvUKUk1airI9xhrXmyd0y/CBMdwcbBW1bYcougKd6LcCVYBSC4UeTlmHWUFH5mAIj6ycEGrMwCADxG9MCg5iNhaQSaLqJwJI4/3XVHzbQMu45/SkYJO45FA9bW6WzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395189; c=relaxed/simple;
	bh=yEWKVEONPMuo/1ZLJQobHQKN74Mos671QJLh8xq2IEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rf6jHdwekMs1LSrlqS2eofFJJGLr0/SBwQWwqlXYUb1b61Rq7uWkr26Ah+u/fQ9sQ1nXbA7jmrl3l5bHcpyfeLXEj4SAzCW5iQkl7TNN8R6TWR+ogdyAHBsfsiXvvtu/Z6ZXPoxIez0a/7MGqwSJVzsELzm+K8RpRlRrsFUgxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bDIQ9QHY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcEZQ012624
	for <linux-pm@vger.kernel.org>; Thu, 2 Oct 2025 08:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DDVKEu0l6U8/m1DkbF4V1wuFoj1Y7XDb8Q8vVrzOiNI=; b=bDIQ9QHY77iWHYUn
	ROjZnAipZqv2MDIVn4zBi509kJ8ZzZS69omgEOBUolx29qdmLcTIjhYITOojM3jF
	ZpJFC3shbwzeZE3zd42iyk/DAzOA9/9zR2omgdDB4mkVjS2psV9fBEm7eBvCEfNo
	dbVXuHzOcmMs5VwbnfI6Lcj+n+ZasS93MLYvDDcNodCH7zzA81ZVxBEiWdC6bPxY
	uA4AAU3O8YzbJKp7R3lM1jiemXy7xMwwVS/MGItB4OCXYA3C9KBKXHJCU5PUx4pI
	km7hLSxxDDEOVqQXeG1AMGZ9ifvwvNfZG0whT+6zx+7hnlvdgFeMKeOov872Z4xi
	AB64zA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tye9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2025 08:53:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4de53348322so34971691cf.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2025 01:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759395184; x=1759999984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDVKEu0l6U8/m1DkbF4V1wuFoj1Y7XDb8Q8vVrzOiNI=;
        b=eOXW9hxmewLwLEeKR2vZ+Fba4g6+t0JBoVSUCxyg+Rn7hav1Y3AwTjZHn4e0O56OIn
         htYa7sYCRehHXa6KPPDXePy7g1Ye4EkMDjz1DbgDcidOBxLLe/uDHnsKyz4cpNi8miQp
         GTSCnVnfDjpeD5KuwxkzOgFnobu/ArtD5LUWWZg9P7s5ka7htPWXdH+I5X+eB/Hkcn7q
         NjopjMWLvCfGS1IVr85EVJ59Tx3y5dzti9fOB3RDR+AwXa7A63Z+sCj5NpD/+16VDaIs
         u4cFj8/O6WJNtb6XXehCq17z9LNM5kdm0W5GmQEc4YXUbns7SAYAXxJmFB8usN+ielPp
         Zvfw==
X-Forwarded-Encrypted: i=1; AJvYcCXEx5Uy4r1kE8KADgZJyPOPlEEwURXevaXWs5/ivRguqwJP2AbytOjYkD1rqZ/dPFZ/ZswTBNdD+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZywPpaIRVz6MBzWrpY8ij/5iSBvq3yqb6VSr3rghHOP6C8bg
	7FVFAC9tK25OKTDSE0LHdp5yQIikkazDMjrqCsbkdyq3wiaTa2z84oAFGgrifbaC2s2U7pqZouC
	3XuXgP1xpM+N/28F1af420VXp2YJqV+h0mddkZYB0xqsxt8AGGgkt4adFln7Z+w==
X-Gm-Gg: ASbGncsP3pFviNLMEN1PolNe8n+uQPyPAkps9eC2y7kL4QDWcjls7UPf+6HN5VUTejg
	aCP07/cz1LEBaelxxREBu90ukJIITnrMouOfuSEiLGRaGEHSZM9GhGhL5SM1zH/1wiwYxHh423S
	96y5ITVCuQ4JCPq7m0ogAxX2zVg3H0plaPDHpiibO+wSwKANTpIDo8PGXr9bLXTRAa2qbYjERL0
	AyrPVhbReWMFDHroiAor3GqetJhVmuDif+/naY1/ytUOs25QoE1kuCISo/zp41dtMehgBmFt4oG
	VRJDRJbMbOilrxGwDOYQ/pxkDCQLbPkVU2GsQ405hdGpj2+rmeEjliQ5sgZqmexkQeClCFhyrLf
	lrJ/BevnHSKPIE/Dx72ELDpgpI9dMkRsuO/rOXHwlTU8a4cChNSaNkSqAQA==
X-Received: by 2002:a05:622a:4d0e:b0:4cb:102c:56b2 with SMTP id d75a77b69052e-4e4192f7886mr86280841cf.0.1759395184146;
        Thu, 02 Oct 2025 01:53:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzoeXCsCYajxT61dCdKaUdyvl96BO5g78vsxvJhmN//YTWTsStifnvfSF0Kf3B7QHZtn7D9Q==
X-Received: by 2002:a05:622a:4d0e:b0:4cb:102c:56b2 with SMTP id d75a77b69052e-4e4192f7886mr86280511cf.0.1759395183470;
        Thu, 02 Oct 2025 01:53:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba3124bbsm5207351fa.27.2025.10.02.01.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:53:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 02 Oct 2025 11:53:00 +0300
Subject: [PATCH 1/2] interconnect: qcom: msm8996: add missing link to
 SLAVE_USB_HS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-fix-msm8996-icc-v1-1-a36a05d1f869@oss.qualcomm.com>
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
In-Reply-To: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=989;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yEWKVEONPMuo/1ZLJQobHQKN74Mos671QJLh8xq2IEI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo3j1s5EDM9dHkNBqE1ej+iY8LhlPeUyUebTYbE
 +8rfOXz9FiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaN49bAAKCRCLPIo+Aiko
 1VbaB/9I8MxIptyQz+jehF3TFFzZP1BOna+zENlbWyss4aU13MaIdAtq6etDhYdtsSHMQyDvMhe
 4iS84XB3WDiDXwHACSYW4P6DS05vNv9ovjCk4SAQXclLGZztZtQo+Fn8vxe9uO51ajsCRfwgpER
 SEhIYuUpuYqjFk7ksnlKJ95jhAKYppDUkqnyxgO5v3AqlE14z4pLw1zsZP1ChUmRpkU1Dcc8qRV
 DXbrrYAir2Fx8sqQc42uBLbd0WHmZmgKDg7PBYhoCBMDICxKnF5MLhumqdzIhl0ZeHevh8mnze+
 v4lozF7Avfx1pwtupEfhRaHlPOfhrHRafSUau64XAo6RgmQN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX60dvBOVkEVFR
 0qUotuUXdtjlJh+Exy+hbnxmnwN4Yfq36hz2cSCynilC8RQd5n9rrYFJIZmHc+hKTxYsT4H4MiH
 NlTBICfDFcslvyjK8V9AwKtcucpBz3xdXddej1fzVmqF7eQCL7BTfoBOgcSwW3dPU4Qpv6TwYfo
 trhH7772yIMmwXIHq/yKWVTdJACOVq8aANlT1inVWmJe6Mie2mifECmkgLPfzL+5H2ESlfRS0CZ
 75aK901q2qQ1OChQkHeoz60Iiog8PJ4sbhdw0jxatYl361cehQeY2UXQkYqIStl8SrjyvKCSRrv
 PueHSURZlxV0Am7u7pbwlBlwH8pkV8GpHbB6CoOt9Iw18J4arzXDLagZKSoYDTkqWzH7D6YC7Zd
 fjEEOgWVzadTY2eDoeBCrXct589lTQ==
X-Proofpoint-GUID: loBmotXqo6pw7-WGvayOMWP4sE6AzpPP
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68de3d71 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=PsYRQ7GA2nqPEF2217oA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: loBmotXqo6pw7-WGvayOMWP4sE6AzpPP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-10-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

From the initial submission the interconnect driver missed the link from
SNOC_PNOC to the USB 2 configuration space. Add missing link in order to
let the platform configure and utilize this path.

Fixes: 7add937f5222 ("interconnect: qcom: Add MSM8996 interconnect provider driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/msm8996.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index b73566c9b21f9dd275878419e030ab07163ef8dd..84cfafb22aa17dba0d5fc4074613546c3dd95625 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -552,6 +552,7 @@ static struct qcom_icc_node mas_venus_vmem = {
 static const u16 mas_snoc_pnoc_links[] = {
 	MSM8996_SLAVE_BLSP_1,
 	MSM8996_SLAVE_BLSP_2,
+	MSM8996_SLAVE_USB_HS,
 	MSM8996_SLAVE_SDCC_1,
 	MSM8996_SLAVE_SDCC_2,
 	MSM8996_SLAVE_SDCC_4,

-- 
2.47.3


