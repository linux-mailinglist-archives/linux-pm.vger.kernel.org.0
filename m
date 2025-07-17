Return-Path: <linux-pm+bounces-31014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666C6B08EC3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 16:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E247AFBD9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160E2F6FA7;
	Thu, 17 Jul 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIY9YdKR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4812F6FA0
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760911; cv=none; b=nHHCrMjqQ9gu28SUuLxy3OJlZNNbYhV0JKU3WhNcjpWlDRDxQDkt9YMO4Cv2LG0Gfe0+w/3N4Qh27WvhdloI9DHmKvulOTv250ZN7BuSIZaGlb8msiw8W7Fc026Sv2qI1t6M7dIzntkH1zhQO5Xg5Ww7Kc2u8ZPH3NMbS/5q4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760911; c=relaxed/simple;
	bh=Dhmeg5kW3jkXRtEQU8I7P8ZNQYm6stnF2VGjRncNTvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7SVEyzg/oZ8FDP3am3k4lsDcqb7Qebt2a7Sxy5xHzL17voQ2AxhjyY165rYIwSHRvDsN0oHw62Y+czZf6MSpeiq14rBMCp253qGEta9tsSZ2RUjVCFfp/9z0vRwr5twalhVJ0l2E7C8jpr98qaKh5GR/2KuMMOdkm0i1TvtvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DIY9YdKR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBsJA9022228
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Djf6erG+ZP+oc2BSetwCL7jzmGa3Zd+9Ksh0jXCgHwk=; b=DIY9YdKR8kgent7u
	ZmxoiG9MlHN8ZlkmvSnPuryvCLYsAxGlV+snUfCE2j589h/23QR59h3J//O+TAZo
	RBz5Y2GI1SKnydn+gnFpRijuuPT3h+qussb+M7ncrUf3FG8qzB+D/dtJuXRwpff1
	/qlIX4+4b0ZfOCZT3WZWUyehYFugYMbvbztLeOCsT4F5N7PiYbmz4MD0xlhoOGgK
	u7ZlJOXZFqcUgJlnB78/SD8vJiHKRNmDz9HJiUzo7QA0zZyKsXXWJp26fLIy1VoY
	uvcQl/9FpHr0z8BTr9QStFcX1MELlYhW/Siyu4sf0M3QbeQV7XdWdisCXFeCyci+
	QjkHCg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy7u6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so726757a12.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 07:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760909; x=1753365709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Djf6erG+ZP+oc2BSetwCL7jzmGa3Zd+9Ksh0jXCgHwk=;
        b=FE+6StpOThLjYSlFTNl1kmUEqNYXqKsGzEwkJGOGdBlloTYh5a7reynOA7/lHzGpql
         5CB7aMehiNDdOGFr85HUvOcMJDY/ovCAAhGg3rzpUSZqC5pCwVdQcQxl9G5GyzRhxWKz
         I3QkruB2sP/qFN1cEBxCmfhoEEELjex/oHjyJniUMsmqS2xjfsbLhrpUKvEo8S4vAdcj
         Hty10W4wcdGkF9p4HV7AJf+0AKFnYTlVcSdzoQ+jbNLp+ykKmtKLorhUpvB1/4vL8+oC
         JuskccVkxhE+fxRARPx+EiCpckpAfwIlLdUj1396LPA+UUqxPKNE2xzyGq3H/AjcCpCf
         IMJA==
X-Gm-Message-State: AOJu0Yw63JvR2mjZKq93+4DKox/3v4ZEXp9pbCwZDlM8Sn+rB8h5cax/
	WH04hmIfV7m0ZsdVBtg3w9j5W0ffYw2t8CPGAPerT47/P8jO0eImCaV0LR6glnkbeS0Kt2wdn9i
	E5lxiKS4Q9tMQWFgSbtsQmHQIjRZnYVkLgjlCVifmoBb1zPgKd5T+tiUjER4xcQ==
X-Gm-Gg: ASbGncsgS2vctJsVJ8o2s2hezoEQAe7Ygf6iaQNgJ+IDhhz3tfuq4qCWsWBpaEZdK3N
	M/Vj7+j/w4kJ4QGDCL8WIiVdcIgRSAOw8WLjCTGteNWwUWzwHU69JbzIcfMGwSK06HLn9avYFp9
	xusYewMFp7Jvbo8zU4RYoDRz80fCfxWfR3wAuW4yJwxniatnFAZkGDcICCjwCl9LVyVIlZ3p3Zy
	UiS/HhNimZzbg2PXsNeGalWub7dm3ONBZYRvumfPW61KFdQCw+mXZ1t/Hd3KJqpQseAQDFu+vrz
	xDE2tD5942AJuKSZG1cGR602bALCB2ZE3u/PTNeCtv3RDRSOwhz8ZPTLnZtZQAJjEtODyj1E76E
	=
X-Received: by 2002:a05:6a20:7290:b0:235:b6de:4470 with SMTP id adf61e73a8af0-237d5a04312mr13021392637.13.1752760908516;
        Thu, 17 Jul 2025 07:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqfgvPvr2MPvSRydxqMLEX8fOncC77Ga6bNoSEBZPXqpAQm3mCkG2jxNO5HoVFg/84ZPlWmg==
X-Received: by 2002:a05:6a20:7290:b0:235:b6de:4470 with SMTP id adf61e73a8af0-237d5a04312mr13021329637.13.1752760907916;
        Thu, 17 Jul 2025 07:01:47 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7507a64b57dsm10311986b3a.14.2025.07.17.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:01:46 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 19:31:17 +0530
Subject: [PATCH 2/3] PCI: qcom: Use bw_factor to adjust bandwidth based on
 link width
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-opp_pcie-v1-2-dde6f452571b@oss.qualcomm.com>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
In-Reply-To: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752760888; l=1499;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Dhmeg5kW3jkXRtEQU8I7P8ZNQYm6stnF2VGjRncNTvk=;
 b=084KUxFpeuJmftJPk/FbKVmIaYC1dXtazX4CPnFK15rWpGQGjjydZZMBNZrWPmRUtVBAw6skJ
 SiJ78PAdaVsDM9kS62O4m0IJwHUNPuuA2uMAA2Ft7ClH2vU7dOebCvY
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfX3p2v25B58NUU
 wsk2x8wIzF3ws+xSIiUnLyVscrb8NsYCmGKfRCg14gJ9K4ovCECmYpxfRXUgsZkR9vzG08x/Ve9
 Hhlb8/+4KlMNHUPbDlCUiBgMJrsu+cWBSDOB59VcSowfOvhNQdC+86jDcIcQtknm3pWXxKE6B5X
 +uaq6VhUzs3Uf5l0S5WQkEx9fHc83RpslfcidBR1CioGL5Fh5SW8bZvwnsUe9DNxObpGXGvFm/1
 pzJkjQkuVG91Mwrh8qh9gL5TsvBx55kQ855t+0e4I//Kmmn8e115v37ngkr9LnLRLBYDNaAiaev
 T8zCh94mYeCWcwSC53+DsoACtekGUlwZuGmNWbBjRevMcjn0mGRk1b4l1TUy/5OhV5H/0aniq6v
 t8irLp/nXZllUV4Q6Cr00g6ATdj/Ap6O79VzFiMZPH3doEdPitRqaGW2oUZbo8I+4yQopFez
X-Proofpoint-GUID: PB-1eJpp3XgsIF_QkV_hI72wqaB-qin4
X-Proofpoint-ORIG-GUID: PB-1eJpp3XgsIF_QkV_hI72wqaB-qin4
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6879024d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170123

Data rates 8GT/s x2 and Data rates 16GT/s x1 have same frequency so using
same OPP entry in the OPP table.  QCOM controllers may have different RPMh
votes for different rates. So we can't use shared entries in the OPP.

Use only data rate freqiency and remove width in it and use bw_factor
to multiply bandwidth based up on the link width through OPP.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f856550bcfa1ce09962ba9c086d117de05..fde9fd3fff6bdcec0c9618d3f4b003a3d823307f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1505,13 +1505,17 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			return;
 
 		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
+		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps,
 						 true);
 		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_bw_factor(pci->dev, width);
+			if (ret)
+				dev_err(pci->dev, "Failed to set OPP scale: %d\n", ret);
+
 			ret = dev_pm_opp_set_opp(pci->dev, opp);
 			if (ret)
 				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
-					freq_kbps * width, ret);
+					freq_kbps, ret);
 			dev_pm_opp_put(opp);
 		}
 	}

-- 
2.34.1


