Return-Path: <linux-pm+bounces-42025-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAXfE5qagmkzWwMAu9opvQ
	(envelope-from <linux-pm+bounces-42025-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:02:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D6E035A
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 992B23106F8E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5525EFBB;
	Wed,  4 Feb 2026 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5Z9xROV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vtg4OLBk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC082512C8
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166807; cv=none; b=Msu75YnzR2qodwQI2cEUZPcQHOZsG+cjv7HiJa/+jH5VrIGbkwTb0xhPUKp9n7Br1igvU5xUEda+Ku/Yha6AS0xoxPUPMP7Z06qoCtf67u9xHA36X4s7Ep064t10PXUzhhmscrLy3NLjAwmoL98h+CzSq66uWDUuq4taGDRziy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166807; c=relaxed/simple;
	bh=KSGW4Q8DYDhhzVXQ25otMmzjfKUl8PxhFUQ2hkE2KbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sW5PEOzBGZvfi4s2WCrEGbMy9uVbtOktyQmxMggJdTDGc3VcagTJEQiJoLMqc72QcykUayDJklJcSnxGk74Wbrwv66h/IKaLpr8tMqYlxBBYRBrY+N29k/+wSSO4iOPGCflIhI2N1rYgImrWzUROSU4vUDnrdxH1nzJ04PogRnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b5Z9xROV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vtg4OLBk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613Ilj0X2667153
	for <linux-pm@vger.kernel.org>; Wed, 4 Feb 2026 01:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OoBrr8C/QRp4i4HyUTLL0ZS25JBMm+mtVzwTnV3jZRc=; b=b5Z9xROVVg8vUvl3
	DgXj0wgIcnpFjmj93RTrVfYlGIdrRM47DEIFVJ8GedRT5bs6pjCf1W18EUpaWOlp
	C61aQHu8SvfWQHEHQNJ9ijNt6rWxPdhu1lhFXDR0UYKxK2K3zOXat4Yncro1pSO4
	Ethqwp3EaEPyHBijPgqbhsshngB9EVgBwi8Vxr3ViIsrzw2RvyL9+PlZyA28SAu6
	yqBZtF4WiCs0aU0IxbZ3psgoJJvMYAm7SaMIRNoI0jSoXYvLZ79qTy736BK5dIFa
	ZFkDQNmmwDaxuDAi8e4ZNeobYubB+Q9H0qMNyUVRi+d0gT+6dfMsQ7XS9z5xVcFO
	CJIAIQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3nf61b08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 01:00:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5032e68560dso72195011cf.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 17:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770166804; x=1770771604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoBrr8C/QRp4i4HyUTLL0ZS25JBMm+mtVzwTnV3jZRc=;
        b=Vtg4OLBkG0ar8PrXY5/au9AAtc2EervwD+aAe2+zZPUVoKbw/pd6ZWsjztsNE6J0k3
         6SC8ZcNV7F4inwmvugmW38drvd0R92peWo8vfb43300rfJJvLuBkQe2Oka/jRNhfc1iD
         HTkbw84vIcrtoHMww5hIupxocg4yXuCVCO/LkNM5+nKleGjsfPTT7UrY8bUU4WhVmQG+
         SIqCLrkmWCwYnjrsh65MTeoeYMbqDtjOpls2489h9/h204gWE/GJtmXL2S6kyIS90ld/
         pKiCxdkVWXKjOjf497sOPIJdtgvbERm2xUST6orkNIjKZxRwfxJ6tSZjN/R1IswUG8fH
         9Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166804; x=1770771604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OoBrr8C/QRp4i4HyUTLL0ZS25JBMm+mtVzwTnV3jZRc=;
        b=MyZcI0YqBj/6hahj9DKW2B02SQ7YO5+k0k8t+/NQmAnZ4yjc18jVHjj23Djr/+b8t8
         vVTJn2O33LHO+D1e6HVCRZJP1356R5ni0GVFxf9Q6vj6knxWmY8b7ZqLUCSqkHkOAH7z
         mgOzN4rvSNqDFgA74WILQXlOl2qm7nJet2gr87F7MxLll6hSDTuK2Ky9Y8StPNsHoHnM
         wxqUGSDFzt+Ok/i4LIay2HxTgYdRDJxK98GbjkJqZH9P/yKpM6FZDVZ8aSkuBfvW1wo6
         917tfn77PLo/lDvDbqQNQPitiS4BHQs5G9Wyf4IxFf/HAmABv/qQ/PxQyZB2p36S8jBA
         WxdA==
X-Forwarded-Encrypted: i=1; AJvYcCWVi7guKkmTLlodcrbnFChzwiswvOSBcFCrnnvpsMGf9byTvShXVJ82cF5CCc1mharYzsefgCW1NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQSOYevWZjd0jzcG4fh1OYLcOdv3hdKnVYhe15e4KjXkCEvAQl
	VHvMd6frc5ZOnn3cGN2rYWld/Ne4I+LwSiKxnsZkoto0LnKJKOjqyL0S6Wvd3oworM7C5ZHSwN/
	3dD9XP359YkWH+GKkQU7qp4ACObYG2W/+4r1+aP28ExmRucbsL7K3KYNNMXlONw==
X-Gm-Gg: AZuq6aKkCK7OaryntkFdxb8/BZQFA2sOt6NPQbBZYpwz9mTRK3AQPmrlqyMAW4h7lnl
	dDu26cCv8BUxYaySAOEx+QywzsUXrRe8wGeM/bmHPcJ1K8bVncKd4LWb5CxxJx01e365zo7n0J6
	Z7g/Dr9cklXhBOlexSBiwEZ5Btkrenvpm9zWGdLnVPSjvVgfIL+PAUwMP47vvMMh83gPMjO7vU1
	FVMWnHL6D40iZwoOiwlhXASSxL/llWwB5Ki8viohLJ2hLXdJQLNrxu6YxC6C59dFaaJkqPt5Rtn
	FjPG45TMnSW/nF45LDnD3Lsu0ih4mdrmnz6LQ6Cp7zSCQ8kYsraGi+IP3oUtFLFjlj6+1dx9lKR
	Bj7r5aRppuNxMylKw6WQh5WSn1uYSTSpq4zn+D5xTXvlkpYi9CMClloUkFAr/KM5u9gHKBd4BJW
	4Iskx1Ws1H0Z0J1ei0SIBaTjE=
X-Received: by 2002:a05:620a:29cf:b0:8c8:82a1:11c9 with SMTP id af79cd13be357-8ca2f83bdc9mr196461085a.14.1770166803845;
        Tue, 03 Feb 2026 17:00:03 -0800 (PST)
X-Received: by 2002:a05:620a:29cf:b0:8c8:82a1:11c9 with SMTP id af79cd13be357-8ca2f83bdc9mr196457885a.14.1770166803314;
        Tue, 03 Feb 2026 17:00:03 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e386ff563sm253405e87.1.2026.02.03.17.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 17:00:02 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Feb 2026 02:59:53 +0200
Subject: [PATCH v3 5/7] arm64: dts: qcom: sm8250: add MX power domain to
 the video CC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-iris-venus-fix-sm8250-v3-5-70fa68e57f96@oss.qualcomm.com>
References: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
In-Reply-To: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=KSGW4Q8DYDhhzVXQ25otMmzjfKUl8PxhFUQ2hkE2KbU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpgpoIF8Rb4QZxvt4JJAHhE7PQtITxEFt8T28Fh
 YnflDeO6baJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaYKaCAAKCRCLPIo+Aiko
 1bh9B/9Qdca0dqLIdd8Edm3TsEkONTyhZGu4hGaMiqN5Cyp2g9K+VkLg4UcwdlCWxaiCNOb3+X1
 yHcjlSoo0tYXqbmUh5Ao87ncvIfabP2JAM80/W6j76hA7tshBfityk/rT9IBwOaBdiGmmbqPNXM
 Y8Zv3KkoWZ1NLxKuW27t1hrvbzX0jxZRfCR0u7/rK8PPMKY9e3gYU6UOxcAb4wAyVQ10jzIaOuK
 Vh1kTB46FNwndUVfx6qfSLf7/hLg7WsZ+RYBoza4HXHrz+t7ZBeT70Hx0LDz5OZRoHBcs7Vo9cl
 PnR61mgjurPnIpaDWDo1Tr8aqjyolmafUUpsSq0nLICoaLsj
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 0VCUWPVz_5NAx60D6BtufDSdYNGcOWce
X-Proofpoint-ORIG-GUID: 0VCUWPVz_5NAx60D6BtufDSdYNGcOWce
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAwNCBTYWx0ZWRfX9hUr30Mh0mJA
 8OhAsc6xQ4bCRT8P4/WJEHKlK9KMbcgm8nV7Gpeb0cGALnWQEbhdYRLtKfPT6SVycwIcjf8sgBL
 f/o96Vq9krf+RsURQrABbNiztnhVSU6+proJvgkeRwDt2zc2I6QHyDJM9UUfzCASfAXxaYjlexf
 KoA/Sq3jX4PpdB2+lS0SP7JMPmA0H1VWJq6+UfMNuMqBRsBpojlSIUedBdRhDEKGAt+5Vl0QSBt
 QZiAns7uY0ehSa4TrztK8QGng5nWul2R7AjepUFM1fGT9ZbxJ59vU6L208sRVehk9QdoKnIMSsw
 zVtBmTozrNjZUwhYeWCIH2BNqmw7bQEHdPkIgaEgymZUKKG5eOKnABaJCbOp6CgpijqYk48+xzJ
 hJ/u2MUB9V8BAzyEzIV0YDICDiyRj0MCf0LClfRub/At8GMvMh7GGQu85Gh8Duk53uocURn9XeS
 LFfKhH/T2vSsYWp6ucw==
X-Authority-Analysis: v=2.4 cv=doTWylg4 c=1 sm=1 tr=0 ts=69829a14 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=8Bs0yZVtKZY9psgxZcQA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42025-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,abf0000:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CA8D6E035A
X-Rspamd-Action: no action

To configure the video PLLs and enable the video GDSCs on SM8250,
platform, the MX rail must be ON along with MMCX. Update the videocc
device node to include the MX power domain.

Fixes: 5b9ec225d4ed ("arm64: dts: qcom: sm8250: Add videocc DT node")
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index c7dffa440074..980d6e894b9d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4374,8 +4374,10 @@ videocc: clock-controller@abf0000 {
 			clocks = <&gcc GCC_VIDEO_AHB_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>;
-			power-domains = <&rpmhpd RPMHPD_MMCX>;
-			required-opps = <&rpmhpd_opp_low_svs>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MX>;
+			required-opps = <&rpmhpd_opp_low_svs>,
+					<&rpmhpd_opp_low_svs>;
 			clock-names = "iface", "bi_tcxo", "bi_tcxo_ao";
 			#clock-cells = <1>;
 			#reset-cells = <1>;

-- 
2.47.3


