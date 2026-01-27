Return-Path: <linux-pm+bounces-41520-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M9fNyJ/eGmcqQEAu9opvQ
	(envelope-from <linux-pm+bounces-41520-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 10:02:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5E1916DC
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 10:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBE45300BB9E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E093346AF;
	Tue, 27 Jan 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UPtxkhHx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NkeYW2AU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80C33372E
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504521; cv=none; b=ZZABmQvS41RqJCQw5Kq9yTTeh+kPHx+w5WdPEdwF2g1Crechh61Qnobt/byhp4B94fMzEhq5XIKR1Vlr3ceXJRwXe64Nim5kRNlaP8YZY+luBZzY9SBkNjn7y0bW/a7JC+gsZfJiTDsv8O4uIAbDse7WsK02B37PK4ACKA7zodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504521; c=relaxed/simple;
	bh=0JQW3j0mOyDRk3Vp76qCRCemPu2yt2U3mO9vcjizvS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnC8Y9CKvKs30rsor6TwBy4rM1Sbctv0shcwkDNMPzf+t4tulIpqn2xebs3v27q9t/Kjk+bQbaK3Uen9tVKY/zamxbVukGj5G4vkuC4pei0OQLxT0gxLRHtScm4gr0mqSQVV5Q984jNK4O+O7JQEqpILaj/xtZmVl3CGl6Ukf1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UPtxkhHx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NkeYW2AU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4UC4S171550
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 09:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2/TjeU1c93O
	iGdQMnTfgmwqg5rVtkI37cvskFWSKidk=; b=UPtxkhHxiehBrzucBtTm4vkvd3F
	c6cp3GB2UY66KYuKsXr+SZSJWIzsvNezDlptIKU56mNvmCiAzVOS/a+K9mdOw6Ju
	eLpqkU5N2TzUQjt7PB4qfCXvlMtb+A8md4Fs+Kaak7dXz6DPPTznN1rhx3cbmvgf
	awL9ZpT2UqW1lNEjLwcAz9uRZoYAMF4Mh675iAi/ofT9Ji9eeH5BOLRWDeJ3lu2P
	5o76d+w3AF9xtklzZscKMGRF1m+WBTYP7gXbbw/wB0ji0beDDA5VbdgzczPUE5Qr
	zT1wiRF9iaA1hNutmRUPZscvaTHp0hJB72pSY+rAc7s1TXBdcHStfggwsCA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a240w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 09:01:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81eef665b49so992539b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 01:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769504518; x=1770109318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/TjeU1c93OiGdQMnTfgmwqg5rVtkI37cvskFWSKidk=;
        b=NkeYW2AUiCbOhihokjSrBjiqrW7U99hGjSHw/3pEonJdW5P5n1wZFHPZcWtfJu+FAK
         WEjmOoI9Fzana9HfAP4wMCoF4rOJ8ELhKjATHDI75vBLCHohVY90efTzP/g9igykC2b9
         vDNg0titIU6C5+bpKv1v7TBTkkQ73xhvQ1Mka5H1Co1Qye+6XeOeQ+tGlpRRwDcF9/uj
         Hft6UJvr6JyHAURnzvhQzP3lj+21Usc+mBY0xwJHZO3CVFzN2JqDY8A/49zx9M9JTvlz
         AL9Nh3MEUYZ7hnzhxk9iVD4q6Z7g22z0Otr+ilL6u7vyY5xFtxadmF0uYl/v8zWJjUZ5
         LLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769504518; x=1770109318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/TjeU1c93OiGdQMnTfgmwqg5rVtkI37cvskFWSKidk=;
        b=hVtIB1VDNKw/BJbMYsai3Dcg7c75Woba84NE7nOmipTwqttJ0dat3F6XgRbLWHdvVK
         kheKmxGIOyEHyVwjIcoh9Mehls847jCzw2V537YNSj7mjuoH3CgXEvKRnVcJVPGQiO3I
         0gW9jie55V5o13vdvndeTpyxmddRAiQVxRFQwNYu00kbcQncmH4J0YDrlEk2cMD6q1C5
         5Zb0MW5x6/bU110Pyr1Nokgplg2fLs7DpEw2CWdIRdlkKl6X5wM+ae9HHyt0y/CjwWLP
         4wzUV8Fq9WmkgfC4RTOk+y95d4vfuegu0OoPeSpxXKim00IGx+gJN+asr1+9/RDY2MHN
         aXtg==
X-Forwarded-Encrypted: i=1; AJvYcCVrKYQmOXpv7SGRAOsIP/7G/hbFW8g+KvNI+2rmrZYJYLlHup9nXo7Lesl7GF5qhxeJ18cwLpYnng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/EGMpwTZJ5W21U792g4lKqJ3Bkjd8ab6OaIXEC5eWv2WTMxI
	+0TC0hQsc+kgmBbZAnKCCwMXa5anlW9DDWICayOKMuViYCoBaeizq1M/lZphEcmJe7CmsLnimGw
	LuhIjzoKBMvkQRQ/ZoBLJt2KTY1SDdM143a7/yREkucuUwRCBFdlTDbNe17zlKA==
X-Gm-Gg: AZuq6aKGEKTlsbe6QyOqc07Ajcgj1chWizCwj8QcQWz4twHqqB46MRG/xzt6Hhspllf
	+htsmBSq39/11Kc8uowRsjnLF8HrSeFNSxp09j3+UnHjaicVksWmdGYlhK5c1AizH9G74tIPPdl
	WBGjD4quus9Gv0ZdK2w0rgiooPlEWPZSUz6Z26fdIafRg9YVeYJJILNC4V1qB+7pulsR1ecWQ4W
	/3V89way6Rs+kwd2IO+A9EIyoc5m9SG1Shatodo4HPb99AOEToIHGq6bwFQbQV8f+iY2XELtmoS
	fWGqnheSwj4JyMXQS+ZyfzWKjOJ8GZd284Vi5SfeYASX8iOJoSX0jQiMAkjvwvYcfvToVAxRjMJ
	CH22RaTUG4JjmbnCWdKCPN0BghFzgZJb3E0fe+h+Q38I=
X-Received: by 2002:a05:6a00:22d2:b0:81f:3eda:9d65 with SMTP id d2e1a72fcca58-823691995d3mr1255643b3a.18.1769504518249;
        Tue, 27 Jan 2026 01:01:58 -0800 (PST)
X-Received: by 2002:a05:6a00:22d2:b0:81f:3eda:9d65 with SMTP id d2e1a72fcca58-823691995d3mr1255615b3a.18.1769504517710;
        Tue, 27 Jan 2026 01:01:57 -0800 (PST)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873bf53sm11579228b3a.45.2026.01.27.01.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:01:57 -0800 (PST)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: qcs8300: Add clocks for QoS configuration
Date: Tue, 27 Jan 2026 14:31:16 +0530
Message-ID: <20260127090116.1438780-4-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
References: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA3MyBTYWx0ZWRfX2/xFdJ4EFFjc
 eO6E/ciWM3/g4IwxFcICznDztrPqT0kNDo7oP4FM4OU9Cq4DNdHqIi6ZC/RXupe+0PqSvX1zv9p
 nptcPuzhB6CKcU3UYeBZXpCZH+M0S7xTf40MVDSbEzlTpJSf1dpNitDRGsW4gnXQ77gc4yZYG0u
 D6VwCANtjXnCDkocDdqBMKEBAUBhuyrmVjuofdkseeP+8idFauHDVO2jpqKROjJEG7je6ufqfPK
 Vu3f1Ayt3Rum6iMv4KZQYyopndcF7qNUb+/Ax6qiGBoTgx0MlhohTZBK3Ioc3YS9KpB5D0v8VlS
 bKRcAdG+8FEi0ToOVWuQpFawvYD+abA5e59G64vbWJv/gbjpk/VbPdIiZOfCFsgOXDdUJRdNCOB
 m91eKsBz+Jff9+AeAFQuJ2n2VpjQ2R+rg5DhlATjJhc7rRhX4cpuE8y0858qMcZRU1HOZA280ak
 YEJfwQ+jQAjSPEAObBQ==
X-Proofpoint-ORIG-GUID: Ayy8RshN7cG0J8imV9LPGxjKsdNpG5so
X-Proofpoint-GUID: Ayy8RshN7cG0J8imV9LPGxjKsdNpG5so
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=69787f07 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-zSA_OpRfadHS7D8NhgA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41520-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.26.219.0:email,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,0.25.240.160:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.140.97.128:email,0.138.218.224:email];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CB5E1916DC
X-Rspamd-Action: no action

Add clocks which need to be enabled for configuring QoS on
qcs8300 SoC.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 5d2df4305d1c..867df0f20e8c 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -2234,6 +2234,10 @@ aggre1_noc: interconnect@16c0000 {
 			reg = <0x0 0x016c0000 0x0 0x17080>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_QUPV3_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
 		};
 
 		aggre2_noc: interconnect@1700000 {
@@ -2241,6 +2245,7 @@ aggre2_noc: interconnect@1700000 {
 			reg = <0x0 0x01700000 0x0 0x1a080>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
 		};
 
 		pcie_anoc: interconnect@1760000 {
@@ -5103,6 +5108,7 @@ gem_noc: interconnect@9100000 {
 			reg = <0x0 0x9100000 0x0 0xf7080>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_DDRSS_GPU_AXI_CLK>;
 		};
 
 		llcc: system-cache-controller@9200000 {
-- 
2.43.0


