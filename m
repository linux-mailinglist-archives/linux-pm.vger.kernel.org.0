Return-Path: <linux-pm+bounces-41864-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMXnFpUwf2k8lQIAu9opvQ
	(envelope-from <linux-pm+bounces-41864-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:53:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E08FFC5ADB
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02C230675AC
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8D03376B8;
	Sun,  1 Feb 2026 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MyUaV3BQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Swdk4oo+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4DB3328F3
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942966; cv=none; b=N/L/la3hGWeWdI+/Sr/EofBG0qIECw4Wm1fgEa/BGVKiMiMIq9ogtIQEH1NRJFKtQ8e46uWGBtWO5jVD2wraPZwbexMdPXjxnbkvxbIUBbAjCKRJcNVFSH3jYe1bvrKLpn7bvQpXU9sjLSKy+o2mGiiNoz5zsw1hp3EaUat1bAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942966; c=relaxed/simple;
	bh=MDNd56HziQpfdDNbX3xousM3G0a+/+wP6bT6aYLLnm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XexXpuGDrsM+QutSlHun6WRpPRwYzoP82LShCIM70Li97CtqhLu4tcF0Xnbw4ulvXcOC8aJ57/B91k9ioDbWP/3/d+xao8+rK01fxIZrtuW+6uGCTLbETCtZndbJRdQyytaMgzCTAwrBZiSmAjxBRtWKEWkdIihTh6bT1N9FAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MyUaV3BQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Swdk4oo+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6117RmDu3645661
	for <linux-pm@vger.kernel.org>; Sun, 1 Feb 2026 10:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WwvFGoypMjbFfcuK0I6naYkVDqDhMxNZNLoSz66wsVs=; b=MyUaV3BQzLtTkM7n
	2dSuZR2L2XxT0GmrDsXbYtEZyz7LQHNXhp70Derze70zjY7Zjp2BL3aj1fdnJEDR
	fhwoDV+ZIJO6IKda7Qm+32TCsC02wDWZdTwCtCIxKVt+Jb1Z7ZFWrgvE/xhUzuoS
	5yU9W9KmmgH1CVl1AHRZOHV551LOOw9ORu3d3YbQHxY8rXmYw5whISxWRJailz6l
	rZgpuRwh+xZN9ouFqmJwairH32DKJqQRj2dKt2N0/fZYd8pgan4G6KZeawPVpBYF
	R9vcbEewDu7gVno3klGbkuSxR6Qi55VmLZhk0HvrNCGnEVts6C3P2BUa7vqwKzdp
	R5zxxw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1as0tfuh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 10:49:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50335bd75bdso24651361cf.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769942963; x=1770547763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwvFGoypMjbFfcuK0I6naYkVDqDhMxNZNLoSz66wsVs=;
        b=Swdk4oo+qIqAIe2IFT7zguU3enQWUOUnlRsQorZhrhLs99VFPA1Oxi6o7KbTL87Zvn
         jC7CpAiVKFEIm74hBO8Bx3y6oh3RnKtu2XPA/lQ5oBE6fIRxsJNORTmgGAPpixjP0gK6
         4IIfAYc3WeCcgtFpgtlbmf3tWm6JPDxyNtaCgavWclCHfpQdPhC8HqEGHLcTMGLYMAuQ
         UKoYB8OLvo3fXvsR07LiELt4Y+znBIxKzyszWcMSrZ/OyLhLH2ujYgQGDB4JQ3kZgTXf
         7faWveCmDG0YZ7IWLju+f9pwx1ZPSSRqrjncx0vwqjYh2im8pIIZigKlIdqMXcaFEyZs
         YQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942963; x=1770547763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WwvFGoypMjbFfcuK0I6naYkVDqDhMxNZNLoSz66wsVs=;
        b=Y+euJC1X+QMGeQWX/vM/VSDbJ5q6mKHyPHrIKUtQLrQE+xm7stNAAGU59eV7ZYKY1a
         8p2GbaODjtY7M7O4ntYkQZOvxjfwJvamF0xuh+Fd4CgIzYRgJ2kb3Rx61atXOsq3EI7K
         Pt5PeA0T7zkQJkD8XcQDr0RecP6RaPRDHM5gq5w5EZ6fTiQmGLNvvXF1CnzRU2IJEpSD
         5sEL37vVdl/ZZKhbg2t65AbGoooLiaK31TqkKhr6WvYlE9MCrfgQv6kcRRngG/gAoWze
         KPLD5XXQKuh438gubQdGxXgAg/LLkkZXjYR2FvlZAPISSFnYaWgnUQyKRPmmBVk+j1lh
         3NUg==
X-Forwarded-Encrypted: i=1; AJvYcCXy/9e9j1eeHD7O5OfjSpmr62gEKZvQxhiA5X9dZQM2Dq9nsMoMjoufUoBHal002KdqHH6rNXVdIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJx5+GDAtVMbrzqIUIk29b516KXaPFQmZA/qhW/TpM5o0YKzh
	2q9mf00DlsSk8onMJEBD9GCqoAVk1Koyed+M9k7/3goYhEc93LhJVRy3WrXdeWp0+rnmIpcA4Rj
	2Nf5BFI7MgzfTVIthkcLFiaWLrXWUrYHX3HqYl3uTVg2nOQu1BcT1ZXd8Ydj1FA==
X-Gm-Gg: AZuq6aJYfd9g6oIowBoBPGVbbJjAX9Q3fqMdrSsqtoVXDNdUtXfjkwis/2U5lZl4S7l
	t/y8yCwRMEJvUaLoVZK3Jz7psza3ExS03EYlyzMh3D/Fvps/A/i4mlDZZmRKNykgbIfcFuOJmvY
	yrrOJGtXBnL/wc9FKWcrefK3tpoJxlcCCQjInj/p0UZaMhOx7YiyHOI431YgIlhgkP4kbOIpOs/
	O95Bz0NhT9j92TzZa68cwMulipdaONsRvRO80r5UijmtNI9jXglmumll/BPXgI52IyFp+l0iQAa
	SVuP+0RY8yr2sFmY1JyAb5C1W672BWG4fMmw4Phpm4XigGr+ZKi2uVoCzVR73aqLnNuer1VGZSC
	s7+oT1BnQN/anx8JiD/rh8eoFfl/q7dmwdA40TDQIRyzWS1nyCw5jfVKRvki/tsdZfy0pQhrbcU
	tnhhgAoNVekryJRQQJmgM45i8=
X-Received: by 2002:ac8:5986:0:b0:503:426a:1474 with SMTP id d75a77b69052e-505d22a4b09mr124111851cf.57.1769942962652;
        Sun, 01 Feb 2026 02:49:22 -0800 (PST)
X-Received: by 2002:ac8:5986:0:b0:503:426a:1474 with SMTP id d75a77b69052e-505d22a4b09mr124111501cf.57.1769942961922;
        Sun, 01 Feb 2026 02:49:21 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7a8csm2835006e87.77.2026.02.01.02.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:49:20 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 01 Feb 2026 12:49:04 +0200
Subject: [PATCH v2 7/8] arm64: dts: qcom: sort out Iris power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-iris-venus-fix-sm8250-v2-7-6f40d2605c89@oss.qualcomm.com>
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
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2223;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MDNd56HziQpfdDNbX3xousM3G0a+/+wP6bT6aYLLnm0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpfy+m2PNrDaIL5kZI33VRgtQpqzQPtqYo9YLlw
 fJrNcYK8FWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaX8vpgAKCRCLPIo+Aiko
 1XhkB/4sApbQ0av7LltP/Y6E56Qa0P3c8HLuU+iocBfixerEmdaVhEusANHe9a/WsO7vdkI5VXJ
 5uABplv8qW68f7qCIlsaZ1UJ3OFzOTGC7XfYJIO+dGhjTBJrsGl/8ikz6mPFEEJnZds1r+c78/T
 f+q3xRcngKc3IFASXibji8q+CQmCN9ipzbUsZHbeCBmNqpjal5WaQ8oUwGeiovJtAyK6fg1R2nC
 wZG5BVXfV80az0z02q1vZ2UJAEeefjUO5juJqQRaWdnbA5tU0znmzMwcoxlKjgAxElAb5XaZR1e
 LDMaaTGKQyE006ffgW55WRtF03jE/yL2VsMRN/zkGMyf3LH3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDA5NCBTYWx0ZWRfX5DKBJE6wTfF3
 ZRxp3ikU6R1kI607M4MpqN8NU9AkJoRP7TpvQyrDQMqdV7ajJ8w+on46e3J0kpKs5g40xPw9GT3
 JpgGAj3KmtXC1Erz5+uyV0FnY17BphsVtTW9NcDyBmxJ91YF1qHwE0cBkKpEQvVOwwxpro77djg
 eItOaw+rCdlpzzitrn1XnifbvJr/PjM210cBCnCB7PvSk8qptJn3Wvd+L3rxwTjvp14Xfl9b7YH
 BWhQwkz6PlMwOYdIXuOfYaO37MIFG9q9kFKGIEpjTomb13UUKc3aMIpe4uNdv65OXy2mLRyBvEr
 4iJ9fbUoYSQdW0NQL4w7w4P81iTqHsqeA3z2PM67FtFd7iIb57yAcjF9oHiumWmQhsodgLY+iMd
 IpFEQt2ir0ASZVjteUTXoysLIbwfINCHmuvav4ocZjqXZlmwq2DJLx4fo+MPPzhNKWAelPVr53r
 hndCf55QQwpOSoK4RUQ==
X-Proofpoint-ORIG-GUID: qIuZ86mQ53DIuzQG8HdGqEz1gnDitJDG
X-Proofpoint-GUID: qIuZ86mQ53DIuzQG8HdGqEz1gnDitJDG
X-Authority-Analysis: v=2.4 cv=MYthep/f c=1 sm=1 tr=0 ts=697f2fb3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tBOqMctlXquWO7Kigf0A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602010094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41864-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E08FFC5ADB
X-Rspamd-Action: no action

On SM8250 Iris core requires two power rails to function, MX (for PLLs)
and MMCX (for everything else). The commit fa245b3f06cd ("arm64: dts:
qcom: sm8250: Add venus DT node") added only MX power rail, but,
strangely enough, using MMCX voltage levels.

Add MMCX domain together with the (more correct) MX OPP levels.

Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 980d6e894b9d..531470506809 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4321,8 +4321,12 @@ venus: video-codec@aa00000 {
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&videocc MVS0C_GDSC>,
 					<&videocc MVS0_GDSC>,
-					<&rpmhpd RPMHPD_MX>;
-			power-domain-names = "venus", "vcodec0", "mx";
+					<&rpmhpd RPMHPD_MX>,
+					<&rpmhpd RPMHPD_MMCX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mx",
+					     "mmcx";
 			operating-points-v2 = <&venus_opp_table>;
 
 			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
@@ -4348,22 +4352,26 @@ venus_opp_table: opp-table {
 
 				opp-720000000 {
 					opp-hz = /bits/ 64 <720000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
+					required-opps = <&rpmhpd_opp_low_svs>,
+							<&rpmhpd_opp_low_svs>;
 				};
 
 				opp-1014000000 {
 					opp-hz = /bits/ 64 <1014000000>;
-					required-opps = <&rpmhpd_opp_svs>;
+					required-opps = <&rpmhpd_opp_low_svs>,
+							<&rpmhpd_opp_svs>;
 				};
 
 				opp-1098000000 {
 					opp-hz = /bits/ 64 <1098000000>;
-					required-opps = <&rpmhpd_opp_svs_l1>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs_l1>;
 				};
 
 				opp-1332000000 {
 					opp-hz = /bits/ 64 <1332000000>;
-					required-opps = <&rpmhpd_opp_nom>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_nom>;
 				};
 			};
 		};

-- 
2.47.3


