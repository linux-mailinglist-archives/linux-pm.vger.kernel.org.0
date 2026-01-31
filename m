Return-Path: <linux-pm+bounces-41842-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DdDJNQ9fmk6WgIAu9opvQ
	(envelope-from <linux-pm+bounces-41842-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:37:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B01C3525
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71BA7303EE83
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235C3624CB;
	Sat, 31 Jan 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z6m820uO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OB8kQSMC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF713612D3
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880846; cv=none; b=socBbiYVMq8sf0FvUhshSNM52SXF5ipsMeWvdNUqkDODbGazPLaVjc0wUiGzl7bAChonGAqccgNq0jCHqplmsjTJI1Aehd/Mzc2+8Atwvb0cY1vBv0YjvCALBYKa2rT4jWHu25UPXtc6xrPB6lUnN0pDylTchzNPefs1WFDjh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880846; c=relaxed/simple;
	bh=MDNd56HziQpfdDNbX3xousM3G0a+/+wP6bT6aYLLnm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NMiPLJq76Q397zGlsiwauTOd73Sm3ubaScQ7IjG03TVcJvHjDEK8dtClh+bZcTDUSwVQ75rg+atFOWAhH2wI7/g4/5xknQeSLpnmkVQBaShqTEHIDi4AHus0aLZRhjsRhAzC5s0nO9GvmJ6Xs6d+2Yngc5f9NTGTdIY18TDdjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z6m820uO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OB8kQSMC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4eNwg393123
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WwvFGoypMjbFfcuK0I6naYkVDqDhMxNZNLoSz66wsVs=; b=Z6m820uOoVDRQPew
	WAq4x1ZVd+loxuvHT9KKogpDpvVbLXQitnvoYpBtmEa6uadzeRhH97EO4yRZvM5t
	E/ljoNXulQR8dM03tdMB8v0uPUB+4iV09uNvNP5XG9fO8sTCPjdEYwuQZeCzr9EJ
	H7/krzzSlfJ2S+3WjBehOFXcMbUgDij4CA2oz1o8b+ps7Dbl8f/7Sh3Vyw8oiVpl
	DyoXiRdeMXAwbbH4LZdZ1XddvWjE/BXPS/6NICdBByZ7t5uUgMSjktovaPxMo1vY
	VBRVLHzQtplt49SjuWMj1fPy1EP+BYGXPJfVPdOltlu0+hvPDCE6Y7wTDk4COqxi
	6gLiuQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1awns697-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:34:02 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ec38a3265aso10551632137.1
        for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 09:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769880842; x=1770485642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwvFGoypMjbFfcuK0I6naYkVDqDhMxNZNLoSz66wsVs=;
        b=OB8kQSMC6Ky7Ey0FnrccnXuz81sqxKqueD7TW9Ch1+EyiAZzPPWzz3HJ97CUGHlDMA
         0rhA6b3iBAS1kn0s1ckMZ7EpGJ8N2LRx+kWc1mwAcSUgKkSGP0JJNeverRqd25szF2tf
         b+60kI9z4867BJrswXr9vyhsEDtdGq0ZSgZri8beiHijCj5HBn8nCx+P+Rerr3tWb27c
         e1TB1oRBrlEi+NDVeTg7j3T13iJGMvR5/+IZMw4IjiRsAr0f0AiuJJcHQN3aBrg0IbgI
         emntj+RGT+1L7M/HDumg/6IUBJDcrsmGZMl60wN2AKiBdym+xCEKez6COmfRtydiKww+
         75cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769880842; x=1770485642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WwvFGoypMjbFfcuK0I6naYkVDqDhMxNZNLoSz66wsVs=;
        b=qvm3OWUs3ntXCG+YS9FurT3cynQLQpueyYIup9+tLtgLqNg826TwyjVKjuKBYmBz9u
         Mafi3A8gR29SloecPSn3egdxyAZwBKqJ3tllABnXn7YXNjyVekfZQNb62ranH0t2yUwc
         whg/bigvzTSGAW6/J9B+eZWxaLvWinWLDHK4dJm+t1I3vmPdPscaP5gZBpm2GybNkt8y
         vVVjvM5d4lBzx8QSiItosrzG5YKjFgplBIPYdz/FKsYREYWraCM1y34OuZR1IGX/Zt4m
         X1FuHoXDG0wTR2QKIF73G9mKVbNQh85W50k+6KvGu2xr3PsxRsyf+ZvVkSgaU9SYLG0k
         UMHg==
X-Forwarded-Encrypted: i=1; AJvYcCU1BemBiJQkWnqq8KaeAiYayjt0/7TGEY7jg5FCqGeYYuIyG8NL+XH7sQJK2IR88xzxFfkLh0AuUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+SxUnuYnP36+2tUkYl4BrYkUVqf0LOcqiAr3oDabk0ELX838
	3kj5DslqWCckzNRtvr91P72Hsf3oaaA5Ts05PqH5HX32ilHMFG+3+8Iby12/wm47KvksTgfV+QO
	VCuqKmPRTccozZtyDifc1snoDHp3D2NkQLcUnjeiDRlk41Xzd/g1K8taIS5ar0A==
X-Gm-Gg: AZuq6aKc+h2bh9b9d0MPo6rioA+RIfAKdKA27ULaerecaL2UIfJUaH8k57wjy3hSVLV
	4DFFUihprauQeXiJeQx2IlHpPlFZtWqDp6Mka056RlaVNOKKJFIWWQm7OoQdyC4U940fuji5KR+
	IhgZSkiMpvCh6aXPqAn7/TovvjSBUrzv4LlgKHD+0daMzEXheRo7QFChibGn4mb22hlHa6JXprw
	HtStP6yN+TQGMXQpekZrKq8agGI+ZGkxar7fGPF7hLU1IXjmq6hlTHIODpyCc7C0lqB5AvW+iQD
	6ArQttwjGVnpQecFZvA3ZJqS0+gMi8EiQCB0NnlCPBLU8BK33Nh14U2UTwmN3f1Ydur7+oMdOeY
	ZPpRD0+viSpDvNBnLyiN3wDQFjmfxRuiOLVucoNZ/1rlPYcJ7fiXurrd1yQP6GJNgCN+BMuA3CT
	giTrVBTKvt101tRh5/cke87dY=
X-Received: by 2002:a05:6102:c50:b0:5f5:4e0d:2046 with SMTP id ada2fe7eead31-5f8cdbf6decmr3348408137.15.1769880842036;
        Sat, 31 Jan 2026 09:34:02 -0800 (PST)
X-Received: by 2002:a05:6102:c50:b0:5f5:4e0d:2046 with SMTP id ada2fe7eead31-5f8cdbf6decmr3348378137.15.1769880841606;
        Sat, 31 Jan 2026 09:34:01 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074886f0sm2443236e87.24.2026.01.31.09.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 09:34:01 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 31 Jan 2026 19:33:49 +0200
Subject: [PATCH 7/8] arm64: dts: qcom: sort out Iris power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260131-iris-venus-fix-sm8250-v1-7-b635ee66284c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2223;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MDNd56HziQpfdDNbX3xousM3G0a+/+wP6bT6aYLLnm0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpfjz/c17+bd6qhjDuDDyzvSrSs0Hej9DaCSZ4+
 EXTo6V/zC+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaX48/wAKCRCLPIo+Aiko
 1R9JCACaB4CLTA3yu35nxhYP/dRbPYEyYygXz0L03fZeu5cKmKY2gQl8Y02bB2Wj3lqZLMwnn8l
 5bgpZpxsazZ1dw4cO4OGMunK8pT/Tm54IuPnSdDnvk91o3tqLRwtMtBULAgQFmLonk33fkEugHF
 DcDbiuKRuZtSF7t5EB5uHjPqXSdNubFHT4QOl9Xc+Ec3ric7nKRxiDGHE+aJNzsXzUe+oZF0BPr
 fZZclIeJX9R9hWhhDQf5oYQL6+mk1fnDcwBOnpX7tTFOAgLeuiBoUzULgzeK5bwdJqpBSchWLLm
 zFRIzOPzBIdYdzC2PeP4RwBIsB6wdhr8IRQrpM1FnqOLhZFh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=MNltWcZl c=1 sm=1 tr=0 ts=697e3d0a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tBOqMctlXquWO7Kigf0A:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: pc3_kye5cFLuKlLZ3vS0sGaRFdELO_IS
X-Proofpoint-ORIG-GUID: pc3_kye5cFLuKlLZ3vS0sGaRFdELO_IS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE0NyBTYWx0ZWRfX0i676Emi/dF4
 u6ynDw+snGBll8mLRY9Xt4QkhCIEVAQXE5+CVALgDoLSosNWJg0mYAnTc+eWyTN+Ng6sd7arh6E
 xVkk3SpvnUG68SyQtLrQHdps9ico4Oi23vz9cjNHZcvHlPO7tSTq1L5Whc1amBZxSjvOnNtLzT4
 jHcVspf5CVH31QIkUXHF4tTLZU7+rMR2SfaOAEjggyy3dOSaJdq1mqBQkELAVK5C5otnV67TCMp
 wLB61pcmpTKW3/CJl+QNtC4wa+eeC2MQ44dV/0JJiTeDLM0nxtpfTt5X2AhDC1qDlzAfLdZ7mGr
 9k6pPfl1AlL34B0ruKq4dq16H1FsojtiF2hS3054rq5IgcsG3T+pAc34e526iR3+7U1vLh3LVc1
 /Ho1RbqNGK3DxKw2IglPDxv+bv6gMYiwF5IildWuBjNeFJd4fyuWXnBoNrynr1f/05gY6nU7uxX
 x3col3+oWMQsQKQ2zJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601310147
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
	TAGGED_FROM(0.00)[bounces-41842-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aa00000:email,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 13B01C3525
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


