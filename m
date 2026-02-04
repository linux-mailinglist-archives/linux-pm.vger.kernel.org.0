Return-Path: <linux-pm+bounces-42026-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK36KMOagmkzWwMAu9opvQ
	(envelope-from <linux-pm+bounces-42026-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:02:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2406FE039F
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C6C30DE9DD
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 01:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8AD26FA5A;
	Wed,  4 Feb 2026 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SFsNTKZ1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZoM/15XE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3CA42AA3
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166809; cv=none; b=itjm+AOGZWc0T1gvPFZs2omQknykfO80pcbK8zCV1tBaGED9PfLAeBgzbxUQzi35Ftj80QGfuUV2AaC5N1gGwfAcgxFojsulzqc7A6o4xFxrIROUbWKPx5uETHufGmm6SPQZ49mJ5OonrnDksfOGO2ZcsWPKJb8/A0uCYcyhZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166809; c=relaxed/simple;
	bh=8xvpoZBcwaB5XEQ8fd9wbf7am8qskE/GNdqJO+VC6E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QG7MxwhBNl/ZjvsjVIDtBkqzCFNu7eYLodUB5Ralxb89npgfcR+To49lonFXK0vrwWIEvvga0gCkbCBO/c7ASL75sHRuaT3v1+PpY7bZ5HZaN835iYe+SJ7xin11EPZ1Vn/j6MN6vgDGEqMMZfmhImmHMmrYVWdeuGitlwvxy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SFsNTKZ1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZoM/15XE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613ImFCP2056107
	for <linux-pm@vger.kernel.org>; Wed, 4 Feb 2026 01:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ce+ofkwDb44AUy52OKXawE+oRbp/+IIXGPOlNxXAeT0=; b=SFsNTKZ1Sg0jUIYm
	ces9VYwnnTdfuJQxsso2STOuEIEG6eLIfZ2XxUtks4PDNrC9YAKhzgzT0alxdLzs
	8yA0kiflHcseX6Rc+NMMQr94Ji7/offHlcdIAM5ZunpXQciJAYpzB966lEx/3rk8
	3JvZLQ5szTZ9o6V7Ny3Uc39Pgp1ZeK0c4JFGjOQH7d4416/CZJ8wW4cxDYhQwPAm
	swh20HujtkT+JQbui6PRq23d3ycPemLbeUgEoJKid8r5NhY61QQ4rbo31+sMp0Fb
	ouXWkhPkxYIri3PMGyXwOR5oaX+CMGEFADjQhNowMBDbvJcOkE/ICgij/nETWCkX
	ezCTsw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3exkat14-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 01:00:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70d16d5a9so536331285a.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 17:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770166807; x=1770771607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ce+ofkwDb44AUy52OKXawE+oRbp/+IIXGPOlNxXAeT0=;
        b=ZoM/15XETkdhiwmkI5qvzA14cqs5089ZThH18Z0a5L7+MjrSEffnxEoQIEM95Hh/U1
         O0NteDUasbCjFVDH2/W1Nu4Xy2cf1p+MVJyVpCj6S2r6G+KWNIImyWkSLVC0lrGO6Phv
         yF4ygcAmvRSradBBOLSt/ssJDAZUakOnD7KJVHHlFw1sqGn7Uvp/Nwn3z0SPA1wVxgr/
         AUKQXco7eXL5v5g8QTQ6z1XDIXHYexVKAjn1nnzBqlAh3TqgbIWs3/oK17exztGmbj8F
         bQDD3gYfcDYvVwnMqe1CmMewXIkRggdu8YfsI8vk+7Lm+oLhigcaJSKW6R4+zSdr2j6N
         L+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166807; x=1770771607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ce+ofkwDb44AUy52OKXawE+oRbp/+IIXGPOlNxXAeT0=;
        b=w5E65+TJfjiH/K6cGFaNYTzh7g2IQS0Sx9C+yp9zCWUoEtXOq2QqlgPr+EQFO4oS8E
         1p4AGldg6UKWlciwmUTvAjpTody38WfNw+/oGfhP0Z7xPUy8D27mFpnGMYZidthbpYt/
         xZrFj/ZsaXaTy6+v4rUwpIh2xInsRSMEud+4MlasF1PbTVHnydsXt8pnWMd3gEbGmbPI
         Epv/hNZuXIwWZR5Y4qebAohtyJDjM8HlyyGjQb25IbP1XSbaxzI9fhzqKITfm0Tqffqf
         FBksTp6NQ2FjpoN+2vd416UGjzD/TK/FQM54n93sxfLwcucpMp3Dwc2L/7TAYWRotHpx
         eEvA==
X-Forwarded-Encrypted: i=1; AJvYcCXIolHv3GceFMRTV3+wvCHSH4kqNVPIuYbOsMGErF4M90Ke38wLVMy7mrrr7p3l+uPNdZgzOSNdMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YztTNhbQgQU9atl9Q+1uyPZrDTnhmsCeI6JWuqa2ZCdkgPFruG6
	NeSXfNN9aC1Kbteway+ptc18CJ+ffe/bwi3WFbtAdX0SE/dbzzWM0rR8pO6f37yS6aLkVVDfbdZ
	6OJoZ5KF+F08ZpnGTDMHbl7L4OqElCk0t0O6tRErJ+1uLRarVwSEbkVEdfV+nNQ==
X-Gm-Gg: AZuq6aJvh4fz2eZPrrVdeFGbOUIZj070mu+3R6+smY0a67jKHbEXE0g/wwovH0rjTl9
	C8/yIU9KXjlqf/T+pT7VMyphEmNqtDHRGXnt9lOlZfE7Ue5OMcMjTdgx0aqFcE646+gdfqUsERV
	08wMvH1iir7qwA7e4seHOwNWiKB65cEY6CN2HZB7HrppOPWGsLl3WXaObxlcCqMmt3fAoOgqJiY
	fasUxu9lDO2qkZ+Gqycb/A1+0Y3NV19ZEm/3++e0HxzUzYoOZ/KuFUB2eTRexnORdPLtYVGw1A2
	pX/D//C//A1/LUZ2Pwp/py8xWsMH1jGOlOqZ2Qg2NHpgF9ep1fUKyXFlIPmx/Z+gbnrAYOHJb7B
	GULyyGo7HCANNu2Vcu5T0sCLrYbR7OHa7ES3NgW/zcyTN3nJh53X4xO5zFdX/J0YgWm+toyOQuP
	NssG8GbfndBOgnipM4BlOsPI4=
X-Received: by 2002:a05:620a:d84:b0:8c7:eb5:8528 with SMTP id af79cd13be357-8ca2f83a844mr199417585a.1.1770166806447;
        Tue, 03 Feb 2026 17:00:06 -0800 (PST)
X-Received: by 2002:a05:620a:d84:b0:8c7:eb5:8528 with SMTP id af79cd13be357-8ca2f83a844mr199411585a.1.1770166805883;
        Tue, 03 Feb 2026 17:00:05 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e386ff563sm253405e87.1.2026.02.03.17.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 17:00:03 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Feb 2026 02:59:54 +0200
Subject: [PATCH v3 6/7] arm64: dts: qcom: sm8250: sort out Iris power
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-iris-venus-fix-sm8250-v3-6-70fa68e57f96@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8xvpoZBcwaB5XEQ8fd9wbf7am8qskE/GNdqJO+VC6E4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpgpoIiliQCHBS41LWbVO46HJ+9YkHzvwGO0Ae+
 y2qqPQY3k2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaYKaCAAKCRCLPIo+Aiko
 1dGIB/9P+DKxN07RhkSeeARLygGwsImpsDAmJNjA2+sl733FQDQbzPnFiHIz4y7qztaU+XY1D0X
 CDkPkOvQTMldVT0TEVjeta63QPY8pyDC9Dx1WXmQXlN84XLGqMlBEU5H69t8q5yisvKD+Y4Q19a
 a9cAyTA8+1S9+u2jnQMDG767zVJ1Em24d7zR+e+N2H3uhEX57nP4rvylviZ39ylCxtWnq77sGd9
 eyWODvJTQuTu+ehnbREiKqBfKCWGGig2lWrlrWAFg2Oq08nGSXioYx6peYAzi3elOgPsr4iN0Ve
 u9UcBJeoACWx9TVvv68mdhAWXgUP+zZ+wWgwHQnf8zG+AE+8
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAwNCBTYWx0ZWRfX0IR437UpktQa
 ZqQOqFSkD3/0C5n+CNSnhVjZu7SdZCgEFvEwXJhukZhqe+hTjhubeEFqKbBMJilYKRjRsZOCY7u
 foC39hG+4NP5BeKSk1kRA8i7mKYDPb+2LoxG499GJ1givkUXqvXIbVJFyzkz1e43XkS5L5WBzVg
 VEBWqGUw1uP8QOxvWdYw8tSWW5bqvOcwNpqfjTO363bGGLrVFCbKfAcbycvmKZ9PJBShGNQT7tX
 iAw82YhPXXzckx3Av48QzpfvdcpW8Dx6NGUhpsByqBInqX7iAL/WHm536E9arKOFF4I0EEFGvrG
 bjk9+MwpGgBrt/94hvvFfWfBQmUG8K3Nhw7FK/KMESfO4x91zInklvs2FiM+HppiY+ydBVkN6zY
 iRJU2fkRV9/e9aj2Jbhefg4cWb3119Zr5euVw00l6zZ2Mr5f1U9AqYAh8BUdWycWk9XA+QJU0tI
 J6K+g1JwZc7VRTqOLQA==
X-Authority-Analysis: v=2.4 cv=XfOEDY55 c=1 sm=1 tr=0 ts=69829a17 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tBOqMctlXquWO7Kigf0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: nTlNbnjoUJom5wsyvQP_3WYmwKxqN6tk
X-Proofpoint-GUID: nTlNbnjoUJom5wsyvQP_3WYmwKxqN6tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040004
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
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42026-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,aa00000:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2406FE039F
X-Rspamd-Action: no action

On SM8250 Iris core requires two power rails to function, MX (for PLLs)
and MMCX (for everything else). The commit fa245b3f06cd ("arm64: dts:
qcom: sm8250: Add venus DT node") added only MX power rail, but,
strangely enough, using MMCX voltage levels.

Add MMCX domain together with the (more correct) MX OPP levels.

Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 980d6e894b9d..d8be5c1add1b 100644
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
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_low_svs>;
 				};
 
 				opp-1014000000 {
 					opp-hz = /bits/ 64 <1014000000>;
-					required-opps = <&rpmhpd_opp_svs>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
 				};
 
 				opp-1098000000 {
 					opp-hz = /bits/ 64 <1098000000>;
-					required-opps = <&rpmhpd_opp_svs_l1>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
 				};
 
 				opp-1332000000 {
 					opp-hz = /bits/ 64 <1332000000>;
-					required-opps = <&rpmhpd_opp_nom>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_nom>;
 				};
 			};
 		};

-- 
2.47.3


