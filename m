Return-Path: <linux-pm+bounces-35958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7BEBD2AB1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 12:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BE6189C584
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C18307490;
	Mon, 13 Oct 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdb2ehCv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E3306D5E
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352861; cv=none; b=KDPRqz0Jy4Fdl9Fr7h2iSCZEEvE0FyPL8cAAKGJNlY1rHFYfdVsb9+1++yiQzux1Y9K53y1MLSQrI8InTaPfpB8eC3d5ZCMBruSPpKCy/oYyjxieE6H+m+lGBuyPfUx1C4xWWG/a60fcQyMBC4hT6oamLmXzhQe6/aO3j8v8Clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352861; c=relaxed/simple;
	bh=s8aliwbSN8aDBycb6R1r4K4cCFRZ355dOg0hIcHGa6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3Zohz7Nr5mP0TQacwkV+mVwkaUfcnSxnwCPWywAv6C7CDj4m2StJEQJFi5HbzA6GAsg5Dn4aztphKfpyioD3KWhJ4t71xwvUYQZ0GfNztQ2dh4PtYVmGyQSbTW+a9ldeQY1sjPX9YtX54vUiXE3L+jmyS/61melFaCG1J296Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdb2ehCv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DABYIk016699
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 10:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dzqy/pPgafXyIrZ6tRmMgMR1smWL+TClMm1JmbNZJBg=; b=jdb2ehCvapwFCoKK
	TZVZmSWkpxlOqrwE5nrUK09QmyWMqisZYE+hfs8sREQhMACN4DMnwT4GAsHDma7w
	G1XB8m/oFdgInMa7P7hqpvof7CcQF8IAMcPAQqnEd3yh+dLy1ApibyzgyP8OzLN7
	PgdpAlOwTVCEe5seGngB5VOLe5XtjG5aOk83Jm8snUFw7/8Wnad93AM5/YwrGK0c
	GQYUlFcDSNuSVlr+8wGQ1btjqfaokBQtwo/8MlndNwcmGq2lJ+WZIRD7Z5oyMoYc
	Pvoh0B4EDcWGZVZckgBjvQSH84o2PRkIQ6JPWwG+QKU3ryaF/sRbuFyu6l6M5yUJ
	pzOpfQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbhva74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 10:54:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5533921eb2so6411689a12.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 03:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352858; x=1760957658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzqy/pPgafXyIrZ6tRmMgMR1smWL+TClMm1JmbNZJBg=;
        b=E45PFfgnatSlnUjGudam2xTtLSH8ol1E6enqO7jP/T5sFiJHgxI/A4QEqkfAFJOEcE
         OObihfkFaBx5VH5Obl9Bt3O8ecyHqOhb+ot5eDHMUtrVvpaR6lYsEgLfIRqKx+qYpcmS
         fjfVV4wl6bgg+Irp5xzx2heaviTO24LtAm+Y0SvGH2qce074fDONq1EdleVvrJ7NBb8m
         uzyzssbVUg/gAuewQ8GPb/VA/QlvDbE1m3KBW80W4AphYvGG6xo7BVej4liyD/OOjhm9
         Y10zg703fEFyFmfKiXX3n7Q+R5ne+lq7+9wvsc2uGo601yOIx14oLSHgVZoWyNf5nkdA
         7gvg==
X-Gm-Message-State: AOJu0YysAxnTWNgmfO+iPXU+kMtBEBggCOKUGrfhlqzUUlRZ8gcCVZq6
	rOJ+WFpIvZWQ4x9xuVF9zZHee1oqHAU08WZ2CEVeteqN2tBjak3bTUBKKUj+ydoybjUb/AGSh/y
	R0ExKdqVBgadmnohd1ek3EMfMPiYLBMj0bMbplyAIAV+SzEkTt/Cs3vJXZ9/T7w==
X-Gm-Gg: ASbGnct0AWllSzEC6Turf0hDPw+lL+oFgVthfitU5rSSM8lowcqkROvOGv6VSKxW/fJ
	NX9/raFKpaTBrW0sW1iNi7PE4pJylGApN3N/uWKO+FanvTNFogtIkElfbIcafhUHNC3QmUu0U7c
	hZLFmu19nVwvlt4ZLmH1mOEeTTo4ndmGnAw12TP4lYnLE8WVPo9tbH5B+Q1xf/oMUFhD31meogA
	tpz5bDSLmlQBMxarFEBHqNOLdtwlJZtcg/6k/sw3V3ispEwupnUYU1KbkXo+qn4NI4B5m7tTuH0
	wfmEn7ieHrmDbDPP3WpBdimnlgUKxpbFrZp1KaJXXHw2XuAoJFbzpg3uV+mdCt8ZlbTOZgQSvoM
	=
X-Received: by 2002:a05:6a20:914f:b0:2c4:c85a:7da5 with SMTP id adf61e73a8af0-32da81345e5mr29088596637.6.1760352857998;
        Mon, 13 Oct 2025 03:54:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Dc1sV8qzTg3yBNUQrWbsJJQp0QNojNq7MP48Dww6Xlvl/hVhSX+o5b9dp/M0VJWQ68tALQ==
X-Received: by 2002:a05:6a20:914f:b0:2c4:c85a:7da5 with SMTP id adf61e73a8af0-32da81345e5mr29088557637.6.1760352857498;
        Mon, 13 Oct 2025 03:54:17 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626403desm11662295a91.7.2025.10.13.03.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:54:17 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:23:32 +0530
Subject: [PATCH v5 5/5] PCI: qcom: Use frequency and level based OPP lookup
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-opp_pcie-v5-5-eb64db2b4bd3@oss.qualcomm.com>
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
In-Reply-To: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352825; l=2164;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=s8aliwbSN8aDBycb6R1r4K4cCFRZ355dOg0hIcHGa6Y=;
 b=a9LPyMNvzxPSP5d74h2NSW3Y7ZtnU8wBZN6ChdVmntSo234L2UuCKTBXfZNDbzGbpK6SvrjLI
 wQHRfMY25SRDQHvbRmR1981JYMJhkbcL3Omgj8+AFkHcJdOnaHfsYos
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX/mdQIBGw5hIQ
 Ffi5hBNqiEhBnMcJht9OvNGli9edYw6C8v2bEu1QQByUkgG6hKmhl5pBEqannFHL2egiK17tZ3e
 oy8ZD9DuBAarxHiePdTDY3S3eUQaEL7NKUWSInHGKQl7kHNNB+co8XPWt9zaX4N4eWyY1F6D76d
 gG9z0mFiJsgimlopkbT4O4Hl/YyHP/Gg40m8MjCApnSiJgRzrw53QcyxV7YHP9V+OJ8+1jN98op
 bUXlxcZrUcDv/EADKMTPcJvy23QQBsttgmIlEGIE2jDTOrzaOEzrw78Yiaf2n5Ot3wE6eMEaq9v
 KdX6SYUkypW17ev+WMih/K2oMajX9osnotSYcD04aJMnW0rtGG8ZQTKYPdlvjOhOTCwJlrU4E89
 rCBbXUF3Wgm4gBZL7B/CpFXIt7y9ug==
X-Proofpoint-ORIG-GUID: jbMBEkhcA1B7zG-d8DBtg0SYikrpv9pb
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ecda5b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: jbMBEkhcA1B7zG-d8DBtg0SYikrpv9pb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

PCIe link configurations such as 8GT/s x2 and 16GT/s x1 may operate at
the same frequency but differ in other characteristics like RPMh votes.
The existing OPP selection based solely on frequency cannot distinguish
between such cases.

In such cases, frequency alone is insufficient to identify the correct OPP.
Use the newly introduced dev_pm_opp_find_key_exact() API to match both
frequency and level when selecting an OPP, here level indicates PCIe
data rate.

To support older device tree's where opp-level is not defined, check if
opp-level is present or not using dev_pm_opp_find_level_exact(). if
not present fallback to frequency only match.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eba496bc99ca82051dee43d240f359..03b3a1d3a40359a0c70704873b72539ffa43e722 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1565,6 +1565,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
 	u32 offset, status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
+	struct dev_pm_opp_key key;
 	unsigned long freq_kbps;
 	struct dev_pm_opp *opp;
 	int ret, freq_mbps;
@@ -1592,8 +1593,20 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			return;
 
 		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
-						 true);
+		opp = dev_pm_opp_find_level_exact(pci->dev, speed);
+		if (IS_ERR(opp)) {
+			 /* opp-level is not defined use only frequency */
+			opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
+							 true);
+		} else {
+			/* put opp-level OPP */
+			dev_pm_opp_put(opp);
+
+			key.freq = freq_kbps * width;
+			key.level = speed;
+			key.bw = 0;
+			opp = dev_pm_opp_find_key_exact(pci->dev, &key, true);
+		}
 		if (!IS_ERR(opp)) {
 			ret = dev_pm_opp_set_opp(pci->dev, opp);
 			if (ret)

-- 
2.34.1


