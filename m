Return-Path: <linux-pm+bounces-32505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D82B29C0C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 10:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF1D19611C9
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E091B30497C;
	Mon, 18 Aug 2025 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Trfu9uoq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D557302CBD
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505407; cv=none; b=VSOwUQ538xllsSqcxwkqnfGDksml4Zzwq0+qbKDwdU5L2M1BrDkuZcV0L6eFqGjtZc+lTv0L4DidQs6Tk0MApyuDGMYWDAsbqgIrOjrluHdaI0SmjnTq1vSiG1WwfICSiLK3wP2xSCN55MCuP/oszKqUwKilP4y13k+hxKRIq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505407; c=relaxed/simple;
	bh=r1P5XOZ9xenxmIBMJEe17CUSV641Nz0efcyuB6UGa2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSi1LmYv3RNAvAM7LW/N/ONa2eWS5vq31rW+LnvDYMMK9pvzaGRcJonCXnvepsjVKfs1r5P5Es7Q4QYC25NiVDQxJHK8xHIt9sFGSU5/hVizKUtct8nYr8VMMSAUmvRILMF8+UhQQOBEH6CNndNR0CQfjTSNHOgqbzvEIaOp/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Trfu9uoq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7pj8r007143
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 08:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YA2b9PAvdXRmG3Yuf64IGVHkPXHXY02Aav+qtOoDO0w=; b=Trfu9uoqWNmuDAZp
	dgQT+DNWP7ceg/uWTWqS8ycztNGXI13n4/uE5bYLdZxm/L9fVhYF6wM6j9pqO0mD
	J1TixYrRUv2bqDdk4Hv8R1Lb19zs9KSDZ2fGIWUWdZS+TyzLFpJIJfSphQ6cyiEA
	gtNB0SDWxAVJMJkuu52NiS0SPdBU155RL+yXWAKGkC3jZzGTrmZ2/nk6uRzg1uIU
	TGQC8hJCrjEdpfxj4kpz8Rim7n4OQkubd08zaUYFN3BqZftINjX+zvK8rukQ4Inz
	IXf0wWAJYc+SHz4h3ewIJrf0VPo17oTzqFx4jb4V6A5L1PArNkFNR2i+ETyfmfvd
	a++a0Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7uwhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 08:23:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-323267bf596so3639257a91.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 01:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505404; x=1756110204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YA2b9PAvdXRmG3Yuf64IGVHkPXHXY02Aav+qtOoDO0w=;
        b=uESeQ/y+4fnPpWh6zZOi520W6CgHQz2A4Co6nKZgylAgv+dymeONFKl4lBCzjy+Zid
         9GfcBDtrtUerte4hFcyTsLusAltvCDARVo9k4rWEyHpJXjoyq5FMNi8m24SxI02MEpeL
         o6z19cunE4Fgh1TfyYFKRB9bCUJubbNqfolg9GktAmQzEoKR8ZY9C5biDT8mJw1JkrUj
         yyM9C2ySdfSg3iosEwUmbONM4pg4XgdHCTSrD8PgumQc+55coaQUWv81GNTnsIOIWuSk
         VIw1BOA9CUFJXjt2UtLEi3TrE/YIGQ1wRdYgitLEIZvUjb5btP8ZFjbvHQOpqplQKRcl
         VOPQ==
X-Gm-Message-State: AOJu0Yy5C7j6gDPTGmMQzV1SNbQxt9Socrq7bvoCiMRKX9tNchwnJNxT
	x5EuvRiFVeyEA1iYUTr1Q7JUJT9CtPluKD1kCz1Uky3J0MNAvCRrW9BvXbTufr4cX6YgzWl7p35
	WP9eCt8PZqZP6HtQyZcKYtLov5Ci6SjgvNgKs98EgQeOkSFX8LG1/9cEFdV8o9A==
X-Gm-Gg: ASbGncugWHvA8pwk9pA4c/R9wZ1wmATY2+NwKtK+u4mkAdXU8XGV91HlGgMphiBzDEF
	09W+qmkUaavF282MNWAWdhiAW6dlizHLSliT2+RTZQojwqGQsUU4LzxKpGPSE6MDSNEQr5vnR/y
	hwNZUXVdz5/KwrNsBXL+z5GZ0wKqpZDWGnjFYigwKTF44J6KyeXaRnp3y5t2O2e93wuKhPtgeld
	LETXvYu6DeMSb7Ku5EAwpu0kd6YtIiwBRC+aT5x9DUne+V9DOP0OG1+tl2MRVl/+xafEJQZwAlr
	o+cE38mU9lLsqztBnpmhnAu9O1MY0U/vNtvAjVMslOuwbSUvg+pUuA9rCXB48NTEzdv8mC9ieI8
	=
X-Received: by 2002:a17:903:37cd:b0:240:70d4:85d9 with SMTP id d9443c01a7336-24478cd29c1mr101023155ad.0.1755505403882;
        Mon, 18 Aug 2025 01:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYuBoM4owvivfKknYahmOIJgp7qidwojBn4u8QZooyQId72Yf/YGItXF9hitSi0rTk8Kblig==
X-Received: by 2002:a17:903:37cd:b0:240:70d4:85d9 with SMTP id d9443c01a7336-24478cd29c1mr101022735ad.0.1755505403431;
        Mon, 18 Aug 2025 01:23:23 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5536c3sm73225155ad.137.2025.08.18.01.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:23:23 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:52:55 +0530
Subject: [PATCH v2 3/3] PCI: qcom: Use frequency and level based OPP lookup
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-opp_pcie-v2-3-071524d98967@oss.qualcomm.com>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
In-Reply-To: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755505382; l=1213;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=r1P5XOZ9xenxmIBMJEe17CUSV641Nz0efcyuB6UGa2k=;
 b=yIhj5/flyrKcPzl2sJmHXf4IYpP87Kd3PzPby7h3mDHr2w3wwdRaowv/CYbZlukjY53rlE0WV
 t8sMccGGJAlBnKRYYFnGhVi+7QJBVVH0ErrAJh7QHWOlzcOXc3+RhS7
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfXyjBMeDBQb/Iy
 v2+9ATNk2AuvaWAg4r78rmc2n4A7vJF83uS+1PRZOKxV+3502TBQJsfN3pbe6M815n1EkcFLzC0
 y/GTpEKR9v5q3bUHyFXtN9oV95cUAEMTHjMCrR+jIbQiHNJu8kyGwfeA6EesNsbexxshli7KXSG
 +8g+SYYnnyocKILIp0F9HMPWaqN127XYoT7o7Bqr1jt46h3qoFKcwmAWyKoDNe4v+s6iV4iz8RE
 zFbxwCTVsuaCV9mx1iB16is2JgB9XYBBK879feLBUjhfsOw+EXMjWwua8xHXILaUvZpJ3nmfYlN
 mb1MKM1LnOdjuVk6ZnX7YVcRXKOeHxFBzo7kYLWlCTrPtUL5qkl7xoChjIKbKesCZbwPYn6bzLq
 mT43rSUb
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a2e2fd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: r_fge-Z8RU1oK8eiFmToh4fim2ZGzBrP
X-Proofpoint-ORIG-GUID: r_fge-Z8RU1oK8eiFmToh4fim2ZGzBrP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

PCIe supports multiple data rates that may operate at the same clock
frequency by varying the link width. In such cases, frequency alone
is insufficient to identify the correct OPP. Use the newly introduced
dev_pm_opp_find_freq_level_exact() API to match both frequency and
level when selecting an OPP, here level indicates PCIe data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..698209b5c13d99c639b09ca05bcd05767a2b9be1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1582,8 +1582,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			return;
 
 		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
-						 true);
+		opp = dev_pm_opp_find_freq_level_exact(pci->dev, freq_kbps * width, speed, true);
 		if (!IS_ERR(opp)) {
 			ret = dev_pm_opp_set_opp(pci->dev, opp);
 			if (ret)

-- 
2.34.1


