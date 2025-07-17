Return-Path: <linux-pm+bounces-31015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C67B08EC6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B7F3B1E49
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F662F85CA;
	Thu, 17 Jul 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIg+XjZz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313462F7D1F
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760918; cv=none; b=RLtukzo/VgZi7tUdwcbZKwToYioAmoD3c+4HdtYBL9hxQ6oFN5bYwaevNbq6aU8HzM2iP0oxbsV95XBGdAdWohBXpcUZHSLDxHgSDJU5QFkfJt78w5fgl4SBKWQpBetKmE+0mdzcnYVOneIxFI8VWSqLJt0F06TzJFvddrqKV3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760918; c=relaxed/simple;
	bh=e62XasrSHfC8Z0rurv2mAXh/7HxCFsu1wN+MrwN9ftk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OaP6A/7s+ijUNxF8Rp7m9zhvpMgVvL0HsKad5s8Tqub/xL5n/qiWhrfzHnmJSlvqAoyT9FVIu35ZM/jN4frC+SNTDRW7r7D+3ll0wjzhBlAXp5rzkE6NJbmw1L6WNiVnqDlxglxPTzvTv06Y0+coyI1+868QXTsPoWYZBCMJtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SIg+XjZz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H8XU6X029884
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EOr/OjPds5RpcIm2BU/TDEzd1odaEkIi56AvFfjSPPU=; b=SIg+XjZzdNtHWPcX
	BEWDOFV6r0YmEmgqNFN9JMn9P7DdwEWKSfgpfCOs9aeEf/9N5R5Q3VQ4YFoPyPyc
	F9/CiylnChK6PxkrqYQkOod0BgnJ5BLCkGy2S99cFgAWUF7Dr8Ljj7DF8Dn0ttUU
	JdtWjg0UPL6OoHU6REgNE1e337vzhwKFGnQ3UmqEXdzps+mr4BzVuO/hUwwBCOmj
	gIMUrEfue6U7v4u/rRC5T4NVAMm9cHFPNiEVlzvCEg5HBextE1Z7za1zDTQtHHK8
	qniRQpxsOGfHdTlAsCowgmG3CBdOgHelRN98bL7jDashvre4VKataiSzSnL+6ajW
	HKNxHA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7mrk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-756bb07b029so1005404b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 07:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760914; x=1753365714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOr/OjPds5RpcIm2BU/TDEzd1odaEkIi56AvFfjSPPU=;
        b=mdkhZFrGq4OPqQBk7rdQK736PbFa0GNgjWJk2CHvNYDTgARc85XzcnBAAFtx98BS3i
         bO8Peqc0NyfXQLZa1BIwSvMgy+advkjulSsdyvuNkrYP4Xx/62rOKGdnPCJorINOsSGP
         PZIsM0ApnPGx2Jo4RmOkv7fNdgdVrUvYIvUeRs8yAs4d1zAC2WCDCZ+9yPdjk5lpNknv
         mEy0lqMWgJj+ExNV5GvEwGdnPaEj4K/IaxHCWE65MFe7s+TpAaanQ7Q8B6G6Y2ls42/o
         W2Y//e0MOucu8Oc5lNf/MoXvRvEq93EEtZDWlNHOf/c+idCsQV8YSYkF9CFp++r/yq5i
         E/7w==
X-Gm-Message-State: AOJu0Ywv0iRq/oXa9dczHi2iPnfFJssT0PFQbQKVZhgRxhdCJFcpFQ5h
	Sv2Z9MZZLIYkuVw0/wmjAXTLaVbVXP1B+XeKOE7ZbgM6iZgWjyAGuJ82zoP06u2//TIuzoyX1Sv
	YdwYYeUTrloEnk547x8sDyZ+18ek3hYV7t3AMWXt14LosHJRyQHMfmYPYUCaBuw==
X-Gm-Gg: ASbGncuoxFYgZBKxNHwRCGfkvJAZp/Aj5etqKd7jias5I17m/WfZS8A2ZKZyRMIWAbQ
	u50r/Sw/8lENpO+21SESQOOf9CgY+aocLmbIXIWHALSaXmBvqCnHgJ4CYLK1yVdA83JoqWSy5an
	9FAb92taYT6rk3VSuO4uklFian3/J1dM1BaCLUvTfExgNPnYKgxb8lT3o98XYA8yCwCZ2tTO3lm
	25K+OB3ytTvX+eO0tx5QImnW2kgHsJqJbyqgIdEaAZDD1C6XlLP2Uc33+EHS0cyt6Pg48TujB7Q
	X6zrlSGrMgH3k7K9x3P2fgyNc8CH7R5f7sQuptoQFNh5ppxcWmMym0Ek4nPC71nohH1fugOJKCg
	=
X-Received: by 2002:a05:6a20:2588:b0:222:1802:2dd7 with SMTP id adf61e73a8af0-2381143f214mr11866945637.13.1752760914191;
        Thu, 17 Jul 2025 07:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMvl3MAcM4sjD4kYy+/+p3tdz64aMRUaqIYkDD07g/QLTinAeONBpOyIiIidysTHEQEjPUng==
X-Received: by 2002:a05:6a20:2588:b0:222:1802:2dd7 with SMTP id adf61e73a8af0-2381143f214mr11866851637.13.1752760913624;
        Thu, 17 Jul 2025 07:01:53 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7507a64b57dsm10311986b3a.14.2025.07.17.07.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:01:53 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 19:31:18 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: sm8450: Keep only x1 lane PCIe OPP
 entries
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-opp_pcie-v1-3-dde6f452571b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752760888; l=1743;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=e62XasrSHfC8Z0rurv2mAXh/7HxCFsu1wN+MrwN9ftk=;
 b=r7CoP3HyktXj92XLKc2jPHd7tzYKulq7P2RE5k93K7GbLTC10b0OfqnOXhwx0gCvpiisoVuOh
 qpz2HrEPlbVA3JZgk6dOhKdIF9rXgbkjo4GDl5FCcacO4lWG0e82ctF
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfX8tZ+7ac9Rz8B
 qs12u4HR8wA8NcwoPUzhsgOyBiayjxtxg5pt8Ev7sxtBZCDLI1fjEz81VMCq5nHn7uyfTFWSyK0
 bQRaCEbfzA1HA59mmyV9M8/DqVF5U4ZyjztUIu0ffxAOEexHbonf491qwbp+OeLajuYXvUA3G76
 uJGNJKQHx6ZzHVAZapGQ+eYxkPA3yXIXrNn2QjY8XS2Dd4/TvqkAoIz/FEvyUSHbE/3BADi2Wue
 cl3OFnBayHeBG1eQCn6v0Hh58emUE/4XiWEn9TMu9Pew1JK95oxpNuIxNDhiWe9irKeW+k0dKhv
 c3G2fctAgF/5vnpDW9xDL4t37pBQDbTNqgTODGYm9XSQokqY+2b3pjBsRUnOjlho/DhmfZd8efo
 Jckq29ty0i9MjrK+Vqqyj7T126P8Y0DsGt0/NQ0tLm831qkYOdiAbObYmEv2NPEYKKCZbX5W
X-Proofpoint-GUID: ODjIlRSeQgOanJDAjpb4swAZhFrW4HvT
X-Proofpoint-ORIG-GUID: ODjIlRSeQgOanJDAjpb4swAZhFrW4HvT
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=68790254 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_k9ig2nQFDp-gxZIyLcA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=672 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170123

Currently the PCIe OPP table is included entries for multiple lanes
configurations like x2. Since the driver now uses bw_factor to adjust
bandwidth based on link width, we only need to define OPPs for x1
lane configurations.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 54c6d0fdb2afa51084c510eddc341d6087189611..d752dc2b17f03284fada7584b5fbdf7672e06142 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2216,20 +2216,13 @@ opp-2500000 {
 					opp-peak-kBps = <250000 1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
+				/* GEN 2 x1 */
 				opp-5000000 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
 				};
 
-				/* GEN 2 x2 */
-				opp-10000000 {
-					opp-hz = /bits/ 64 <10000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
-					opp-peak-kBps = <1000000 1>;
-				};
-
 				/* GEN 3 x1 */
 				opp-8000000 {
 					opp-hz = /bits/ 64 <8000000>;
@@ -2237,19 +2230,13 @@ opp-8000000 {
 					opp-peak-kBps = <984500 1>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
+				/* GEN 4 x1 */
 				opp-16000000 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
 				};
 
-				/* GEN 4 x2 */
-				opp-32000000 {
-					opp-hz = /bits/ 64 <32000000>;
-					required-opps = <&rpmhpd_opp_nom>;
-					opp-peak-kBps = <3938000 1>;
-				};
 			};
 
 			pcie@0 {

-- 
2.34.1


