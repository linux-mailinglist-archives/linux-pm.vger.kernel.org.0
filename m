Return-Path: <linux-pm+bounces-31012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 577B9B08EAD
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 16:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82693A6260
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208252F6F9B;
	Thu, 17 Jul 2025 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUkb5wRy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704971DE4E1
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760901; cv=none; b=XbNmX+A9HqBdSVkuMRvKQJCTmEK9w20dSqSKa/TK2Wub+8m28dSnqwOHB8GSEwXvmNfJ7Q75Zg8wC27k1GZ4nPc/cnl7xBxqS0dKXiRBUHdXeKeDwC2IjVDbxoCqejUNldJKUdYN/3aqk9K6UgkPjAJDmmZRUUt5ZxHcK4oAk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760901; c=relaxed/simple;
	bh=0BTQfC2w5Rd4VcCTtFNmuoBqEatSoZ/OgMG1M6bwx54=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tXobxn0YHN5ZGkpxlD0VYV9lhWdzv92qNa3cCEd8G75EqN1EchBScBQhJlmzloM/sCLq2YaH68q7Wlczzjr5lPg0ZgPMM6WO0afNqBiXCXliRsoiGV+D7u6zgZiiq8ybhOANfppVEPXq5exbyzIiBD56pMBDhn3wS5sPlS4atXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DUkb5wRy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCUWfj032375
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pXji7w03b38emMA9vb5J3M
	JvatE27Vxj2JoLrEFkbvQ=; b=DUkb5wRywSO/YzhBHoThRutav7lcjS4xzXeDF2
	Oq2RYGobttVW46n0OFmJkJr/3K9wVb5fS+g8Do6AHOqXev27nRsOTPfzyeNqcie+
	NUjmJThNdgV8SVf7+2VODfenC5VQo5fJZw7Ux6hY3fcNdjCu5+lbjeULN2sbLlnt
	2nlhvdk8Tf2tsD4q6oHinbSM/MNrV0rQ8IdTFeOp7zSIi3fMzrEMiEea1g1EZaTn
	G4GtawRWcnjWsoafFHSYyd+ljloMN3E2xXFz2MXJh+3+XaLgbnEFUtzcVMkTvBVl
	IzXiUyEm8JiCGVwJSOR33z0SvwQIsqdzihsVFVk/suxFTnhA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug3881r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:38 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74d12fa4619so993798b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 07:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760897; x=1753365697;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXji7w03b38emMA9vb5J3MJvatE27Vxj2JoLrEFkbvQ=;
        b=Nft41Er6mrOfqfUvhzg0S8DksjSTTkAFye/zLJ8B5NTXMEBih4Gl/LTKCzTtqLDLd/
         xU4UM/6SM9t+8yy2aYS7uF9eDTYTj9vL/hfa9yjebNy9w3bTo+wk64xzyslBVXBivfaT
         l/sERsXQFTqqXHAxXMNFPw23lH7C4vV+xkgXenK00QgCmcQzaOnKN3YUpiNmSjgoJFVC
         imQLMyfoFZEmRikYDVSElzy0xW7Wp2YlriXcdz2UGsiSg4q8bX4jDgBm80zC/ji6H6hn
         o+zeK86r7f84yW+vzZ+yVfrK4/69PagxFU5pyOTdDYu/u4rODh9j9JgVDplxzFj35igf
         hveA==
X-Gm-Message-State: AOJu0Yzd2A82W53QNOHxtQDQ7C/nErYehLhwMiGQyk/Kvjp03BzO0NR3
	z60pEDNBe+6zFEgnu7Jer3diOGptzVJ14QZbtz4pBfsSO/u8lepnfixQewwUUFu9FT1n/qAvbrP
	yiuZFcJm3eCo8OfE9vV2Ll6w7rzbFPqLtDTYIy6RwBzjgpWnO844YKm2K8BCEhg==
X-Gm-Gg: ASbGnct5SbxQ+cMr22bgPUuPOkBTqe1wFWF2sBvFGMl26AHeRpRd37pbEMRW+6qwQlw
	j8+9Y8eqlUAJ/VOAuhUMQ2LxjwgSc6H2M9lw0gZb/nvGxKOJ9LV7RoD9RB3c9Mtvbk7LabtzM25
	BEA8FdKZegSmmX5rJ7GL5iGYJ0Dcbor+JjqScXDWga0zQyX6RW9dJEKMc/9EnxQS05bPQm1jNBt
	TEjAYV3wZmsR4JIJ0JXgbhjVADUe+qqCDDJXG0a7pn6X85GuE4ywAtqzTYTIOtAnmATOFRGd6fL
	yLpVweDA5e7zmxfpjO8ZIXV7qriClWUiVEirrnVK+Lvmo0knq+rJmwW5fTgfBLevvWOYUbVjews
	=
X-Received: by 2002:a05:6a21:151a:b0:238:3f54:78e9 with SMTP id adf61e73a8af0-2383f548d09mr9251732637.43.1752760896669;
        Thu, 17 Jul 2025 07:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF45A+lgEoQb8f4TyEa6YkAJM5UqE/OX4TYBGRzoYifUxZTa8/Qrlg8/ommRgyQucY5cADfQA==
X-Received: by 2002:a05:6a21:151a:b0:238:3f54:78e9 with SMTP id adf61e73a8af0-2383f548d09mr9251480637.43.1752760894322;
        Thu, 17 Jul 2025 07:01:34 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7507a64b57dsm10311986b3a.14.2025.07.17.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:01:32 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
Date: Thu, 17 Jul 2025 19:31:15 +0530
Message-Id: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACsCeWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nz3fyCgviC5MxUXXNLY0MzgySjJENDYyWg8oKi1LTMCrBR0bG1tQC
 91UdPWgAAAA==
X-Change-ID: 20250717-opp_pcie-793160b2b113
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752760888; l=1757;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0BTQfC2w5Rd4VcCTtFNmuoBqEatSoZ/OgMG1M6bwx54=;
 b=yZHyhU2ZmPe2y6FRKoFJIShRvrs8JFdyP+hmuU3SAHzGxMKpB3+iCxlbylH9wPkKzi6DgxqGt
 csXPI+55WroBjWicfathL9vSadm88SK0hZ27fR6A63Od80rp/Tj8H8D
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfX0Y7DpDZMB+eu
 m8Zyxf5PPq2sni6SQON2uPPxVIiCF/moyK4XfPBm0O4qDNZZwj0kInfuV58Sa3g9yhkgxCBbjvb
 90SSVF4xVGs2xOsKutaEmNM1FH6ASX0lQuHny7OIvpxWFcyihbMMy8O7zE0d8hpWA+JvwlZJEG/
 feGfQWsxWpQDiCi8xze3gt4ufJ+M7LITmD2jDN+L3f02HfLhOrm332Bq2oAHmsLJ3fP2Jmfcuo8
 xS2cHdENF6CsR1xc6SNLgU33SLnEpD8kQMr9JoK5rPXg1dKfw5Cy0BTOn96kbio+hwe6/KZ2lsB
 dkhtQPxltAhfiv9HsWdls8ogLiyyFgkY3zbjjlSOjjix0JYnKNbeLR/YjogywW78mLfptatlRkH
 zW9aaUMTra05/DEIJAK37n/dawUoNdyKUET3cIcYe36tL92jDE3hAJhoS7Fd95avE3Po/paM
X-Proofpoint-GUID: hapy6s3Fee-1KtQ12MAOCAMkzhwH3vao
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=68790242 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KRKipztoQesxEaMeAmMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: hapy6s3Fee-1KtQ12MAOCAMkzhwH3vao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=936 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170123

The existing OPP table in the device tree for PCIe is shared across
different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
These configurations often operate at the same frequency, allowing them
to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
different characteristics beyond frequency—such as RPMh votes in QCOM
case, which cannot be represented accurately when sharing a single OPP.

To avoid conflicts and duplication in the device tree, we now define only
one set of OPP entries per table and introduce a new mechanism to adjust
bandwidth dynamically using a `bw_factor`.

The `bw_factor` is a multiplier applied to the average and peak bandwidth
values of an OPP entry. This allows PCIe drivers to modify the effective
bandwidth at runtime based on the actual link width without needing
separate OPP entries for each configuration.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (3):
      opp: Add bw_factor support to adjust bandwidth dynamically
      PCI: qcom: Use bw_factor to adjust bandwidth based on link width
      arm64: dts: qcom: sm8450: Keep only x1 lane PCIe OPP entries

 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 17 ++--------------
 drivers/opp/core.c                     | 37 ++++++++++++++++++++++++++++++++--
 drivers/opp/opp.h                      |  2 ++
 drivers/pci/controller/dwc/pcie-qcom.c |  8 ++++++--
 include/linux/pm_opp.h                 |  7 +++++++
 5 files changed, 52 insertions(+), 19 deletions(-)
---
base-commit: e2291551827fe5d2d3758c435c191d32b6d1350e
change-id: 20250717-opp_pcie-793160b2b113

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


