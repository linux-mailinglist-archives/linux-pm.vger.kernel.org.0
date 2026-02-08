Return-Path: <linux-pm+bounces-42292-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ALnJ4ciiWkK3AQAu9opvQ
	(envelope-from <linux-pm+bounces-42292-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 00:55:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C90C410AA46
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 00:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 792703002D3A
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 23:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A83385ED8;
	Sun,  8 Feb 2026 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WOCtR05s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dbUIKb0R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2452385EC6
	for <linux-pm@vger.kernel.org>; Sun,  8 Feb 2026 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770594943; cv=none; b=nTIcHzy26efngUuVUPzcYv8rhd32GHMMzqq/ePgJGpbsAsES4LM3y2XFGcBwQMdwemQdiqtZJTqbgge86ug/UCIHdQsrXm5+BvJrRV3c/B0UKkMeAbLDCjhhlj9ZNhoRJX6dOAviXyo1C2uAiSn71pCnv9iH9HjtJ6n/jQ1aHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770594943; c=relaxed/simple;
	bh=5zdqDOnvQk1WfMVdlJEQ2lF1AIwuHIpbtDl2oeKAurQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NrWglZ3KY/PNbkeIHgI4amwYeSAHd0FxOr6mtW6K78jVTZpLZoySWEOTrqcZ4I9OnOmK+lD/oBNRiLUK9K+wz/15gaj739S0/Kt83WhFqYlUwOkkfybvwYUIur+FXnOY7qW9L4ga6MdLCVXbhyv5xgNy7FYy3xv6Biqi/7HHMBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WOCtR05s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dbUIKb0R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618KrZsL921260
	for <linux-pm@vger.kernel.org>; Sun, 8 Feb 2026 23:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mJjEwFPYNGwUl9CYhCrEgKBed+V4A/onH3wDZR0gVPM=; b=WOCtR05s07O7LTJZ
	0naaXlWylkhD1FZXDWKitPNbwmTJNOn9FFVPigqrvYU+9KjFlO1rBJGT3RYy65rn
	X3H/iedEeLUgBoZUdeO9B++OFz8nXmOaXrR7CxlBS4jbXqlezhI16Fg3w7ICWEo6
	7mYrdSWG+nqrlJtfV3QnIoia9ShtdUEyWg6KGigtny+uhchu0378yVZ6xwPkvuac
	N/bDaB6qUBghzJlQHQfc2SfxKkWoij3H28h4tcIIw1apOcL9KuAQNBHy+ACVxA8F
	qN96qmJItiTJm+rQv/+hER+i6eVwmtrKogGwEX+d9SMPCOglQ3dWZ3pBCONp8RXP
	EDccyA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xdd339n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 23:55:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6b4058909so1039777985a.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 15:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770594942; x=1771199742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJjEwFPYNGwUl9CYhCrEgKBed+V4A/onH3wDZR0gVPM=;
        b=dbUIKb0R05yO91wN6os09yaiLHE8ry7NeZmO1CA1Y3fJRIw5Mv3tZpCbRGr0yLBmdC
         cj7u3eJYS33cd66C/U12txfUvWQE0sM1nqhvS27QK57VVD/4M4QHZt8wVCprt8XDe0xT
         uWy22M0AjyFMNvVo8/QPTMuwWUyXCBNiKTAvNR2yEvfeOSf65QlVBSeDP1D6lDXWq1YU
         kFPgvnORSJ6rjnaVgwxKQaK8qY6MXcTgc4ZR8HOa4P8gxjhKzM5MZW7/pAI4moiqxbqs
         5wfw1Uvbru578PyXz51uswSUOOd0ofAUBQ0JArWDXu57Uopww+mpqC4QVSmrJBRWbPPH
         qYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770594942; x=1771199742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mJjEwFPYNGwUl9CYhCrEgKBed+V4A/onH3wDZR0gVPM=;
        b=MndysZFzazvKIjp4yxskFnPAZ/CB0KYtD45jjGlvPc6kdlvfXCJPIUetMdLWVQGwtu
         v9M8i2LM4R3ssH79W+B3WMTmeerkD78uzZQwd8GluoYgBFmgNW0UyBZq3n0AHH70chX0
         Ddm58m8M/Idxxtts7pSsE24zCjn3eyRM1Ab4BkfJ3SW+yXMFR8fkd5GdknvQjCf4Zcqe
         WPSCVM32h0yFMjbWe4iUi1ga+McM878gb7YTSeoRWgj1qNljxirZslUln7Mf9CHQuECw
         74EmCNdXDL1pcMFC07S2izhrCWaRUjfZxtPbMlJ9KpPHzfT+M6ekFoW6ayecaW03yDfR
         UFHw==
X-Forwarded-Encrypted: i=1; AJvYcCVGtDvEyYOLZkEyJkpCOxwb0z+M/OhWVhMz3G6zkiPjmv7Zlcdc+PpQkjQKkUBy0cLxjbLFeVKk4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9XQxPeWiY/fCYU8Hrx4nFx5rhI/covpNxrUw1zzDejqe0tXf
	uXPnnc5By5kcE3qf78J6T06/zRcf594ZhVWtPuP1Z/AkklwGIL8XkxY/LcGD5eLkdNOCnbeVdhM
	U+3X5euZiUVrl05lJTHA3CN55MOMm/Ew18M+ommXy/Z2Lz0hV2C2kgV05NEkFog==
X-Gm-Gg: AZuq6aKlemCK2aFhaSVcwd4uIVMxheTUUCWYi0DKAoIexXmn2qSOkpYM3qIHefIGeyA
	kk9zuXh9kGoSz5Tu8MDWa5aqbBiSt9ankdwaaFu3YBis1Kx/0qnL1LYRZXNAG137RkBoAdl6rf5
	tAtaIDb6Zs/7/s/MukZYvpHCThI9FhdCip6ytwcjULgZPpNJaEyG6ei0v4HJAZRPBeHYmx3z/1M
	kYLYb+JMFwHag6leoW7FoUiS1vGMdJ6NICOZ16DxsQOBdTO0GjvoYXKvdXNDVKfwC52mwdtpT8B
	XVvYsROqeus/i+X7Tb83A5Xh3Qd+l+DZ/qIauaQy4NwQfCRQanj6HE2wkJwNs9jlpJem6dSUCAb
	yknIXWtcxMxllnO90MwsDY5dfCeG6Ps8L2V9TFdWjQvmu6QMk3H4sbEEsIRIAyALYGS4KpolmQt
	urnkApIzLeepvwL67hAxLJt0g=
X-Received: by 2002:a05:620a:3953:b0:8c5:391f:1db7 with SMTP id af79cd13be357-8caf058312amr1287250085a.64.1770594942173;
        Sun, 08 Feb 2026 15:55:42 -0800 (PST)
X-Received: by 2002:a05:620a:3953:b0:8c5:391f:1db7 with SMTP id af79cd13be357-8caf058312amr1287247085a.64.1770594941636;
        Sun, 08 Feb 2026 15:55:41 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6ee4sm2188074e87.4.2026.02.08.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:55:41 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 09 Feb 2026 01:55:35 +0200
Subject: [PATCH v4 1/5] media: dt-bindings: qcom,sm8250-venus: sort out
 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-iris-venus-fix-sm8250-v4-1-9662a0471d82@oss.qualcomm.com>
References: <20260209-iris-venus-fix-sm8250-v4-0-9662a0471d82@oss.qualcomm.com>
In-Reply-To: <20260209-iris-venus-fix-sm8250-v4-0-9662a0471d82@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5zdqDOnvQk1WfMVdlJEQ2lF1AIwuHIpbtDl2oeKAurQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpiSJ6I/Tq1p/qfVQx47K/DfTM3AisnyeF3DByS
 9YoJ9tjcTiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaYkiegAKCRCLPIo+Aiko
 1eQ1B/wMDN5teAlk01p2sWIzNKYWl4hwu4Vm26CJ1lS5lJpCl/i8kPf6yV+Zt7RfsKle74+8pjn
 naoqdMGXB2tphlkBQ4J80G1+7LnDDd6Ga7zjdAbK5p+D/OeccYYbno657uGv/BS6Wvd+rOX41xg
 ukMTGBo6l1JGLBDuVYPp3eChVQy11crs+NpUbE+Qe9YFMmxbfmz+FeNXt8tFZFAGji+hKezArCu
 6LQumU9ubJKwtEw8oStKTDfd3jXclC8hU5RjqlE9oCJWYvV1vNNsD7b00vAXyE5rBdqMegRUVS5
 XrQkwwjZFBjOA/26wlsHcS54CgFbm7XEZQAfBMSM8lSrtm+5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 1g3AgEgeqPYBr8w0ZfRJ_m_THkdJcajI
X-Proofpoint-ORIG-GUID: 1g3AgEgeqPYBr8w0ZfRJ_m_THkdJcajI
X-Authority-Analysis: v=2.4 cv=Rdadyltv c=1 sm=1 tr=0 ts=6989227e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=LJIQitKNcm_3rt92gHIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDIwNiBTYWx0ZWRfX2xQkE0LxMnAb
 eQ8PlpgAnaiI0AJBplrv8JSSaY+V5dOVLLzkS8iEOQPHG/eIKD7JZobm7p1e0qGw3X9PLfQFCBs
 zfT7BN7BnBkhJ1y7eFEqkCyq/uNm76l59RYFd/qlJY+jTMB2e3t+TqWUv8K7wiyE1tcdQVv/wFY
 ewUnftgXlpETGc49Yd1BFLXRhksuvuacIUCvSokJiWXVPOy/LnOoQtUpMJBkuQWkb+7h/aOoph2
 mc9fV+gQKsFzgKzPb7EaQw/0b/KVDUGwnOQGuX//xkV2YVDHsiYVpUEuuXkN3uRH23YF0jA1T02
 +uqHZ8EB6+fvY4Z0KJB+6OoiI4+yamOiR4qVcf5p7UkT9XNFQEu04xFetx7IchG+Boqx9tZEpJU
 Dd3g5yBwa0uO2NbSs5hY0rBrJFL2K8SN6SVbadtyktJAPTPNL2L1yJVyRPfGv41Xhe3rD8GU3Fj
 b4KmptrnpcbxFLg6Ifg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602080206
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42292-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C90C410AA46
X-Rspamd-Action: no action

First of all, on SM8250 Iris (ex-Venus) core needs to scale clocks which
are powered by the MMCX domain. Add MMCX domain to the list of the power
domain to be used on this platform.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/media/qcom,sm8250-venus.yaml      | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
index da54493220c9..311c3c191b1e 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
@@ -21,15 +21,16 @@ properties:
     const: qcom,sm8250-venus
 
   power-domains:
-    minItems: 2
-    maxItems: 3
+    minItemx: 2
+    maxItems: 4
 
   power-domain-names:
-    minItems: 2
+    minItemx: 2
     items:
       - const: venus
       - const: vcodec0
       - const: mx
+      - const: mmcx
 
   clocks:
     maxItems: 3
@@ -114,8 +115,12 @@ examples:
         interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&videocc MVS0C_GDSC>,
                         <&videocc MVS0_GDSC>,
-                        <&rpmhpd RPMHPD_MX>;
-        power-domain-names = "venus", "vcodec0", "mx";
+                        <&rpmhpd RPMHPD_MX>,
+                        <&rpmhpd RPMHPD_MMCX>;
+        power-domain-names = "venus",
+                             "vcodec0",
+                             "mx",
+                             "mmcx";
 
         clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
                  <&videocc VIDEO_CC_MVS0C_CLK>,

-- 
2.47.3


