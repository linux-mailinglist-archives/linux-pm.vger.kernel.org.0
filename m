Return-Path: <linux-pm+bounces-41843-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMBLFes9fmk6WgIAu9opvQ
	(envelope-from <linux-pm+bounces-41843-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:37:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE503C352E
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DECA306BCA8
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 17:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13906363C68;
	Sat, 31 Jan 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dqgzLnhO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VEfzt2Jv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0B8361677
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880846; cv=none; b=nSfRM11nRIAOBByqNNw4A8CDzchlvEtRc0JpDRXmlCvWv8uxfGU2kE50voqBStUhpy4Kr/AKUbixM0oCxLjSak1NUuphKcGJNnUo8Ukcm79gANMBT1TZsIX+/4m/tz3z0fXPnCtR2ApJryFPZwNS5O3xCjErbRiXpgj2pWyYkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880846; c=relaxed/simple;
	bh=rOtATlSUdBEg1H0iWW1mR8swNg1N1WiPDt1QTwWw37Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhci2r1H0eiqsis9x1e3VjSKMGhbh6aErViqC8wqfhLP1yTTWVlPmL4dcvRu6lz+LPbSbc0djqKSvYdqXrOvDyl0T20IMOjyizFF1kWaazj96Hs2eKf1Ildym+S42cc0XtZ8H1NaH20OGF2Mpo4DnK86QRKEXU3YASsrXJS+URo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dqgzLnhO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VEfzt2Jv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4d1AS4076807
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FAPtvj1aaT/4nS3PbQJ8vu2dWXMqUi3SGtAzQD4qK7c=; b=dqgzLnhOtDSbKs6A
	ldiFNFA+pqrgKaArFwhD2TgeolgjchihkbzpN75u835H9tx/gxDT0EdLxF20QGgE
	AlSHju9n7WNJ+zpMiFvhzvtQkOwJIiQJUjwzgtFptUNkW1Lf75Xx2FxzHF+VqS9G
	e1MAQCwtBNMS33w8hJJjIxgRM+0muhsd3GYB2xYlCr3Ej0bY7it8Repoii/i+u0i
	f6zlY8woYZ+ubjht3c9XeMBZn18kZYToS39v8/ph8kVT+9VfDzqu16NIoivWfZP2
	Mvsbs34yf7ujnK/DZTQhEPrUIoq7wFRN2wJ3xm7ll1r7iNrMdzzZwV6FoX6LWuy6
	XCV4Vw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1avx16r6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:34:03 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-948ad0e4134so646948241.1
        for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 09:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769880843; x=1770485643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAPtvj1aaT/4nS3PbQJ8vu2dWXMqUi3SGtAzQD4qK7c=;
        b=VEfzt2JvbYm9/mjGaRNOWFT34pfLX7iQc/wlbmD+TR+hTl4ntWo9iilcT0v8eMMNZz
         3A/DbNd1RpGFJ5lHwrfaF1dl+jlm6HqB8JN/WC650QTYMhXP+FGROTuAdxd7G1u8zkpz
         SSJoo2WkPM6jzh4hIY2B4Yq1HIImm2S39Lg086u3JfUAv4IeESMsdseZh7rcC7DCB7HS
         8KD5BIHZg5F74VaUQK3mhFg0d/KDErr5niztt9RQgdJsyLXETGFpNb9KdGK4cck3GeC8
         F3a5RVUVvKSM5zSsyM02DYZWIV43OilMnvEkmXW6XySaj94HqailYTBzqXP05FuzzFso
         L/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769880843; x=1770485643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FAPtvj1aaT/4nS3PbQJ8vu2dWXMqUi3SGtAzQD4qK7c=;
        b=jvg2DWP/yHsUWeV2wiKcf8Fzmfw0AgYNQWCGEDc9lbbMdm2Sbbaf+5ri6A/WSQNeq4
         2AdsY2eTAoLzxmXlwpn6vWBaY1e8L7amZ9drelyGRooNPtXxaJ4TkFwgAr0nNN9Rs7tX
         cSwYqfHSDXukRsRORa+bBWYZguP+MvyiFADsnmaTeDpZhhNc9GKm8bZmCAOiiMhLgv/V
         2O4EvsZffI96WnD1Y4PBW1gRPIEhHb6oPQO4Ua4AhYmIcEfQmddfKTH1tAHbp8WZSwC9
         Mb+M/oL6jC11b02a4oVGJNZCMY8gSdCdnnRtI5QcwXNzWuPlroxjA9FECwFy7ZtMrGEQ
         6JEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBBBiU9dm/KA7y2+LNlSx16713FLbi95ItIxRMOPew+zmS0NKbehdhtxwCyVsI85q8k/KZcnmKBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yymlzbdw0RNrjYe++St9oYAwy6xinD3eH/eoAWNqyHAWnMl6ITR
	bcIbtNaLBiOrC5vppJ2GkSH6qjOqn6Q0v8/KKa7zew+hJfHtQKjzdIMDaut6wGm61/1Rwa4bpg6
	mLAuTcw6thNUJb8vNWO+OE9xD6Hgzgnl7jBX2zqfOJHBoZ+tCg8C2hNtnsrU2yQ==
X-Gm-Gg: AZuq6aLwLhIO2IkFs2Vs035Qu20/F/baK94ISBdq2Ed/mVeZYEJLLFlr3+MCQFDAFZC
	KcTCVSqDb19ru2Mf8rpNWf/Qs6PycFUhgmqp0dzl3BvAGlM8AaUPCvrtpZnDzCn0F6hfXIHv03v
	fyWlUFiZFEZJvrw6xTjQ0TmtJfdmx856qwX7FqDKh2ro8SHeG4jLSDurk3ew65gz2VlG/PAzk0X
	SZpIeQA/YhJGKi9uEhnBpfhwI3auZYo2zNTzUMlJhTlg8X9lZrYi/XEINWZBUnHu1/kl4+IKmq4
	xbd4sPBpsmUfoVCrdQYZl6bIBoRcrefJgejHpyFM3jHjZwNc2dvAwsp6zGQH6yW0u93wp0zirtE
	7+sYptyRhjysVMh9D/XUrW0MvEehuGTykpYDSr8VsiLMBHpo7g1QSFvCgI8iEaKNmJI4Yz3jTid
	Uv8nO9tQ/RPHtrrzvUS0ozP44=
X-Received: by 2002:a05:6102:6112:20b0:5f8:e3a5:40ac with SMTP id ada2fe7eead31-5f8e3a54830mr1242343137.17.1769880843065;
        Sat, 31 Jan 2026 09:34:03 -0800 (PST)
X-Received: by 2002:a05:6102:6112:20b0:5f8:e3a5:40ac with SMTP id ada2fe7eead31-5f8e3a54830mr1242331137.17.1769880842680;
        Sat, 31 Jan 2026 09:34:02 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074886f0sm2443236e87.24.2026.01.31.09.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 09:34:02 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 31 Jan 2026 19:33:50 +0200
Subject: [PATCH 8/8] arm64: dts: qcom: sm8250: correct frequencies in the
 Iris OPP table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260131-iris-venus-fix-sm8250-v1-8-b635ee66284c@oss.qualcomm.com>
References: <20260131-iris-venus-fix-sm8250-v1-0-b635ee66284c@oss.qualcomm.com>
In-Reply-To: <20260131-iris-venus-fix-sm8250-v1-0-b635ee66284c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=rOtATlSUdBEg1H0iWW1mR8swNg1N1WiPDt1QTwWw37Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpfjz/pOjKg0Y6ylBWtl+rxPfBZQiUdYI2FzDZa
 PpVj/eR7n6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaX48/wAKCRCLPIo+Aiko
 1ZQmB/41FwhU1i3cnQtLfyRxR1Z7I99s+iXEpuOF3Ey7f5BfAbY3gvCyhQ673lqUg50M4Pb5IgZ
 M/HMSspV+CzAeBzhm7XZzmJKk2lQsi0jui78NC1E9u54sGmlm/iJ+t3FzftAr11huEBbCuJXOnq
 Hrm9YlaUgM5lHv4q8CBbTkmjilbJmz0qVk3rPky0qZubzPtgWK/yy/ZN3O7ACjEDcY8eZBtzNzX
 2p5i6MwzHOO7MK1cpsPr4+LWxZPcQqNMaXfIFINGSZm8Cp0IwkoXdrHYEMQGoQUC3ziigVNk283
 dE8I7JXfrTNKB0gDcf/79WG3OgFVI0uofDRehgGFRNnLT7cJ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: fyRnE3zOJhXA4cqngtZd90kC_gOJ0Y74
X-Proofpoint-GUID: fyRnE3zOJhXA4cqngtZd90kC_gOJ0Y74
X-Authority-Analysis: v=2.4 cv=P4w3RyAu c=1 sm=1 tr=0 ts=697e3d0b cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=jxPhmlQz5o5YGUuCidoA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE0NyBTYWx0ZWRfXxIU2Md8gaZek
 q0TusCXlFlj4N1SUT0ssWUq1C0nt94w0Ug8pBdMn/hJmGpWuYC7I5c9utSln3dvsPm7zWD8JXu+
 Gsr5z579Dp78smazoXPLKNjNwyYvNeduvEguPr/y+iJUOa3M1E4ccGEycI31IHf5v2O7j46Hab5
 yMr7JwpLTW9Q9iGkkAkkKkj7xwno4oTR8v+gI4n1gYUzl05Z/ZfhCm9kfA/LlpW3d7utuKb+b2H
 6kDG0mTrwhkv+7u3e9F8VmqJmT+ea0Tiw5X6bqBaUxJetkcqY6+Suk8yGo29N7FWQNjeMbi+DI1
 SeignNXtu+sykeKHXPbzke22C0Zgjm6dro9qesLyqKWLge1q8M87bfAXbsWyma+A5Z7oz+kHCSy
 SR2CIzzfxj+sOre0mDCR1Y0PnHGiJGPY607U8OAmNA3v5F4TrKSJj99VrAYYrGl63ZX0cGqa+Hx
 WZKDL5D3jgP0N7xZ6oA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601310147
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41843-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,aa00000:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE503C352E
X-Rspamd-Action: no action

The OPP table for the Iris core is wrong, it copies the VDD table from
the downstream kernel, but that table is written for the
video_cc_mvs0_clk_src, while the upstream uses video_cc_mvs0_clk for OPP
rate setting (which is clk_src divided by 3). Specify correct
frequencies in the OPP table.

Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 531470506809..21a186e199a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4350,26 +4350,26 @@ venus: video-codec@aa00000 {
 			venus_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				opp-720000000 {
-					opp-hz = /bits/ 64 <720000000>;
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
 					required-opps = <&rpmhpd_opp_low_svs>,
 							<&rpmhpd_opp_low_svs>;
 				};
 
-				opp-1014000000 {
-					opp-hz = /bits/ 64 <1014000000>;
+				opp-338000000 {
+					opp-hz = /bits/ 64 <338000000>;
 					required-opps = <&rpmhpd_opp_low_svs>,
 							<&rpmhpd_opp_svs>;
 				};
 
-				opp-1098000000 {
-					opp-hz = /bits/ 64 <1098000000>;
+				opp-366000000 {
+					opp-hz = /bits/ 64 <366000000>;
 					required-opps = <&rpmhpd_opp_svs>,
 							<&rpmhpd_opp_svs_l1>;
 				};
 
-				opp-1332000000 {
-					opp-hz = /bits/ 64 <1332000000>;
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000>;
 					required-opps = <&rpmhpd_opp_svs>,
 							<&rpmhpd_opp_nom>;
 				};

-- 
2.47.3


