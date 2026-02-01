Return-Path: <linux-pm+bounces-41863-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDQdE28wf2k8lQIAu9opvQ
	(envelope-from <linux-pm+bounces-41863-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:52:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A107DC5A6A
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 186DF305FFFB
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367573346BC;
	Sun,  1 Feb 2026 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FBSDsufE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CMheeNAg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076F3314D9
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942964; cv=none; b=Hp37l7pY6BzCpnQYvF7XiF4y0D9P9BezS+K+3jUvGUbRrQLycN8Asi3uoKPI6T93e7u1KGtY9Y3EwX6/TqUvzmUlPUpXNu7JOAQ6mWW3s71QoimF6U0Ff6KOdqgrHV58cjSY+VqRBq2uaODFRcjANCM2ZZHD1+3iEEQB0mDOzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942964; c=relaxed/simple;
	bh=6nfUUNCUKm6Zb4Py6SMv77VBlTkgwaJH9oS28jOc1Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlF0tql9nwdEk37WRn7jxdzc4GBD2fxe8tmooq6LPFnU9Ohc8Tib7Ornmsgohgv6L504f1OW+SRMI2m4wbfbyp84zfnMJJXG0JuVgzdbWSp+aZV9CpJgG3rRyze6NRZnpTgrIILGuy+9iUW+gFql2DsER1fjHujFrBxEUlyhk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FBSDsufE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CMheeNAg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6117S9G43001947
	for <linux-pm@vger.kernel.org>; Sun, 1 Feb 2026 10:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qKaKCFigaiRPavXRqYsIyD5X8QHsbYeYL/Pyt3XLwQ0=; b=FBSDsufEDaxulmXp
	z9F8++a+UB6xP1D4zzvl/GeiPEDcdTlKB3uKkLioOCGNBxaIGul5HEioNrAVqkjk
	DxTjHK+BJ5sH7hCF+pKRoC3k4olSkzWXrgW9RKkRnMLeveblO2LPoaAqWpKvxaBG
	QZvrgyjsGwBwhzYugw1S+mzRQ+9PU4q/c5vPwrpYJC5agrgAaOhjdyJpJtGthB1b
	vJWOpCm7zQQtJ4/fyVWlx1nAf3foI3Ar3S7TpRuehu9ump2xcZgJqNgmWQJ0t/f4
	68CgKV6rx4f+VTHqy2kK6zPIAoPrJHacDf/XJ7dYaRtt3jBopXR1zcNIGJKRfYeo
	XP1AzA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1b17tdmc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 10:49:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70ef98116so885883285a.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769942961; x=1770547761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKaKCFigaiRPavXRqYsIyD5X8QHsbYeYL/Pyt3XLwQ0=;
        b=CMheeNAgYkyESBgHinWcoHhRQWTuNeuaygDGlrRq3atsHRrG4Z/MVQQO6VBYYFkAhe
         p/QAXjKqZfiuZSAHCtcD9UM9WUFzk67aHuNZLEQ3rMN0RKNyWijy7DTzFP7JHJb1OXQe
         fj0iwCmc+Yhn1/ixQR1viEgmBd9ldQ8RvyyrmxP0iETLDNOHFoZ4UaqvAPYtX++K1Mn0
         voIb6COSu2825HkOBbFyoCj5FmB2aci1Nc1kS1huvMf8ArzR9an0XNmQ/iSWKqjPFIPV
         5yXGmnziRbvkW3EYhY0XO9frOoC39s4w4F8k7XlYEB4R8VvVW8isbxyI1ycizC5Pgvfp
         EIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942961; x=1770547761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qKaKCFigaiRPavXRqYsIyD5X8QHsbYeYL/Pyt3XLwQ0=;
        b=P43lZAYtDdC/TevOlbJn2zWJ5oYbLp0njy8bPfQjDKg9FXdJyzko2W69ImFmwFMskt
         AjGY+vDw+rTgyORLBLFhYzAbx3YZEYi95v2lTg6mHyoXiUuU8nEzus/Bhcd6R9gkOw/g
         eShZ9sz04NCHJmQxSinTIUHgR5F2DbshgLsLMFuqHtPfHFBX+Hi5Qm76ThVYhIsbuBQr
         q/TheGXwbtWjBLrve/eqTlaJ5K5OqjgK42MOKDe6N8mHNSBJAt/5aDZ0/RaIsdiwCUj/
         Nd/00E2ZmhQ+I3WHvJKqKfk+Jz6CbNsN7f0/I4nlxFbw7lRSS3dmYPSVuD9z2V6ujGbl
         V7QA==
X-Forwarded-Encrypted: i=1; AJvYcCVSAkXOatfsEQ8iROrxyMWqMQno5mN/dChPJLSARNd9gQIZEJfQ42woPzKwctG1fiiMFU0ozvtb/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUWqq6RC0broqUGTZ7V1+Ih2d/8wXfeGfsftiJwoZlelE7Wvav
	dt4oqxSmssuALz+9/VxpwkUm2x7s4nemqH+CVqcfj2+tL3f2SATGjNs5S5KZnG0FGNdLKBi6AWl
	sRhl5CUbM2amODmBBSbHlNuFGMJvwSdw4LjqvFc1NX/RydK8w5f0SrTow7rqbYg==
X-Gm-Gg: AZuq6aIH3wCazOlEjep6kotGdDhGVFpz1oUy3Zxphr49Hx4/zeGtsOXP4uB4+VHIulZ
	h+tV7XFhs3Tdtn5kbtq9eAmHCvvJQ39esDvuHcTjupYRuFJ6SQ+/SQlz4T7J+PY6HxhBf5EGsmQ
	ZP9b8jVAVunHWYZVJr8OwMUGMLBoPRvohDSNML7uGRLG+l7ArJ0jMDog/0IORMOKR3AIZ9utLSK
	XlCQixL8P5VZcunDT1y9F7qvF4uJIWsmCq7c6XzbMokT/L0j4xmTccV3HYm0ecBpaiT5ayDgb6P
	OFmbp2edrkawKQjPaYMmNSQNsRS4+1jY2QaFOFbjYP4o7rCdd/xEs2xkZIWc8jF30i6IlNA44oL
	IwxluSq7lWCfGZZC9elUb2tqYZXkBPH52mrtaLYc9/RYcSMqbROoruhL4f0S7wy8VuCMaKXbatA
	ytRhoBAwULHPibGr1ztIDJiog=
X-Received: by 2002:ae9:f804:0:b0:8c9:f996:81f9 with SMTP id af79cd13be357-8c9f9968319mr553192385a.82.1769942960571;
        Sun, 01 Feb 2026 02:49:20 -0800 (PST)
X-Received: by 2002:ae9:f804:0:b0:8c9:f996:81f9 with SMTP id af79cd13be357-8c9f9968319mr553190385a.82.1769942960094;
        Sun, 01 Feb 2026 02:49:20 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7a8csm2835006e87.77.2026.02.01.02.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:49:19 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 01 Feb 2026 12:49:03 +0200
Subject: [PATCH v2 6/8] arm64: dts: qcom: sm8250: add MX power domain to
 the video CC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-iris-venus-fix-sm8250-v2-6-6f40d2605c89@oss.qualcomm.com>
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
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
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6nfUUNCUKm6Zb4Py6SMv77VBlTkgwaJH9oS28jOc1Dk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpfy+lDnMA1ntTeX/YmLKiGvhe57Gs+TZNh0572
 dJZkgdDN8yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaX8vpQAKCRCLPIo+Aiko
 1YG1B/930l46bMIcNy+eK3fxqhM6n6pSRk9aQkERL0/4YaUJnFTXdSC6dq3jMgBStVvv7dFO8AR
 2So+clQ87arEQ5onLYr2npyiMQqI+A07C06TQe1u4U77yh6Lo8++gISqwuOgmLebDyQhqkG+3fl
 J5X1NzGdeTzA+IWlS9SA0h+i5F00Xon8ZG3iwT5r0iSeM4CliujY4GuwEFaWPSD/Q3iYFXdjj7H
 ZBpnOiGp2yONQ4TvQ8Be6IsMmjX5gmzeQviebIbHpzfp7yLoUoPAc9S/2wssV6TZtE5lkVPv9Xd
 s38Qw2MW8Z/n703NHlHuH0Ky3YKRv+Q2QDoBZSAOdSiot+JH
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=LcAxKzfi c=1 sm=1 tr=0 ts=697f2fb1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=8Bs0yZVtKZY9psgxZcQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: NQHTUskQdOfQkpbS9XCPXeYvaYseOyxh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDA5NCBTYWx0ZWRfX3H+gQS2zpRtg
 urw68UZZocb1XLramLaa00Vrq3AOSIgmMnB2hn0KxVX+9pvUFBe6EVuYicL+YMC/si486w+ATeE
 YbjCBnoB7jSYsacxViuhMOfV9S3ztdwU+RvBnEvsTQfj/XcZaI9dPvD984ybv7KjIxY4roe8H4t
 V9I3I3iACMJbQC9oy9LDzlUNJUw7zzXEEW/T73HlXKiAf+W5GdBNQqIudr8NCwW24R4x/DxIzdB
 9kDaFvqV/k2BI+gpqNXdUrhe6N9bVfxYqwwHBlZrN9aH5i3BcMjY6wimhGJAaX1+lLeyds9Le8m
 EdTi4WF304z51RIBeQBYgunCAvtkgzOgbXPKT2WZmTURUbY9mrF+Cepo0LKT0/0Ewmp8+bp5Mii
 Rxq/MIffSOmM0kCeuYy0TMcE6bt9n1o7cBo2ZauVd33iT6yaXhusbC8p+qT5MUwGrnydKEXETZ6
 yF5/HxDJ56nP43aT4GQ==
X-Proofpoint-GUID: NQHTUskQdOfQkpbS9XCPXeYvaYseOyxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602010094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41863-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,abf0000:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A107DC5A6A
X-Rspamd-Action: no action

To configure the video PLLs and enable the video GDSCs on SM8250,
platform, the MX rail must be ON along with MMCX. Update the videocc
device node to include the MX power domain.

Fixes: 5b9ec225d4ed ("arm64: dts: qcom: sm8250: Add videocc DT node")
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


