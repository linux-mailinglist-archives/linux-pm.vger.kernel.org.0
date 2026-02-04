Return-Path: <linux-pm+bounces-42021-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLIZNzeagmkzWwMAu9opvQ
	(envelope-from <linux-pm+bounces-42021-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:00:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F5BE02CD
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CEB830D34AA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 01:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB923EAA3;
	Wed,  4 Feb 2026 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PT2Q7ODv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HEeP7nH/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202F2367BA
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166802; cv=none; b=YHgZRZkAahGEGF5aau5hFgHVWEjy5tlybOOXWjC5qyEs7VgadHrjb340N82NHVpjNEXgDoeSFOsL3WocWVKr6+V3GHEGh6On3DVNTh/GyDGb6KsAnaN/pSds8nu7AzXBS7gSYg8xizqQ4pstCWS797hsD6xeZcltcXXMhRy4VZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166802; c=relaxed/simple;
	bh=NfLzmE5xWwA42fboOATaUS3ihgAtr6cr7dapV1J0XF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6yi3fBvSnfGxiCS6dDOQHPRdaY2foUwXdx0M7P7Vmjac7GN+75Z5sN7X2XYMWrvVO4xbud7rIw2Od2dvtUnTQCGf1h8SQPTFqDoLyYqbS2uzRezRa/WWlJCGo07TzyxSzzPhpFfNyJdx2jxpOKDxMcKUBKBCwHbg5F3fp+i0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PT2Q7ODv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HEeP7nH/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613IllLe2963025
	for <linux-pm@vger.kernel.org>; Wed, 4 Feb 2026 00:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cdJXOV1m+mI0FazdKoVmmfJbSUPedEZOVAEp+F9mNEY=; b=PT2Q7ODvpzBAdVmU
	EScc9i56eREFS6WbsbonUBddpNTAhI9G14D6wBcrwwqlUerIcC3Rmb+hndgloipN
	Xy9j1ttyssc9lN7r5/L0QLlPsTw5hemKtVs25VmQOGEuzbY6W1/LOt6ylPUAmWJh
	YEhuUgyDgHRlYcQAyk8JO/lYYTGjM2YVxNV+/O6J1jQq8KFyQYVnbpocHqNCJXzc
	PL5V/aQN8Ig/3qwImMRuWWnuUUIU2bPVEi1TkhGx6/8T0PXf3554T3p3cTC+5iRy
	XYuRlFXWvMbEOjQQnmB2Z16ii2qfJuth4rytzGw0HqUy95nsHW+hGDAWLkCdwEOI
	rQy9dw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3ne7sc48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 00:59:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5033c483b76so226651291cf.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 16:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770166798; x=1770771598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdJXOV1m+mI0FazdKoVmmfJbSUPedEZOVAEp+F9mNEY=;
        b=HEeP7nH/oDld9bXhI1Bd1gs1NVf0BPeXGUoXHreYAp6mYZvRgRWkTLTPgkJWCk1Wwg
         7tlhLjXlfMv2+rVdm83FN6m4jyVo/SY/7GSNZbtp610W0eNxhAlAlmSp4YbMBmvOSrPb
         a4rWDZhn94raVc9uSHb71Mkh8196kW6M0A1aFrUEnZ4fzcDDX+JJ9JP8fjlR2dIbpf1h
         aAybhgHqS/AUeuQxeWiPypLvoMMfk46o9+hHLuOMZH7IE/Mu7AdUzw/3Ahrbe09IovLM
         1zl3ad5uc2JAkx+NjsbW03Uru+ckvxq2vUiJnyJYROe7Q3//zEeOo/6+h3OH+FmnU2/q
         d0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166798; x=1770771598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cdJXOV1m+mI0FazdKoVmmfJbSUPedEZOVAEp+F9mNEY=;
        b=BxA1dig2iBZF2oa0zGevMI0eezQcGj3Ol+6IDJFSo7gIk99+UxSKKRe51Z8u+WtKQJ
         TV2+rkB77aZ7AQHk7SLnhRLfGRHtHa6cKVRynV16M9sRBzoU9r4GxdzWEzqIEgNa5o05
         vLMFinWSlY3IJe861Qt6ucjJlrllwSUpr/dKcX9pKhBJERjl9NjlMQju38XdXod6dPS5
         TJWyR+007NXDi8W4fHI9+LECOv4d8epd+8DDMsG8LNGyBVCNVsU7i2v1Mt3u56i03kTT
         3BXTbSzLF3qGQjgVXmKOo8+I9RjpFZRG4eCFwokwTU/fRpiSR+uTRv38zS1WUfrvRWmC
         hkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3iSQhVFpKMqFqZyHZlgqPHguexRTyWsI+YUXdOMe9r5aXLVvSmzDos0jZrDvJyggBGwEIKw1rfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdzhYcucnhVD3YwvMuddQPhGrwQgmRAyaPTlWzuP+2xAHOeKY
	6xVCCM1iYVn4vYliLgO6zooeUAEYrSSzHy415EKQNI0rH77t3icBxlefWNutfSFDwkAmrakqHhA
	0g6w0+xNJS7vK84kEZLduyIGwQCngnpQhg3wuf4Om8QqpKmq+/H5qxFLpC3gOPEm4FKgmlw==
X-Gm-Gg: AZuq6aIsoyEuu+TrgE3qAg2ThYPYu5FY176oPQAmA3/ki7mWrSLhIYW6F1AYsnknQzM
	WoLYu2rFhmuk5WSRb2Fv9Nj33DgOBtF+5DpB9srUUNj4M06iCwt3fHdQqKHCQ18JMxf3jgYfPch
	Z2CtIFzE2HGqPaPDC6hi+ULG2zOI+XGH0RfMBNQSaowYti1Qnbx3sGjvPNQtFpXR/fLMbO7GOtC
	HIOcr3nLgTgiQKK3uTXLm1Z2+phN0SgddpRHfPS89t6lpNpnfH4PvuvrzWZpH3W3m1cGtBjSP4P
	dB/RZI7+uWZI+XxKt3EbcrA9M/jnDiwUYzdBVAN7guxMjzKQ2eA0P6p/OS7YHhzRakzNLuXamDB
	qEaJtpqCQTFnoydTwQOKSd7dS7beAVfZVM7M5OxYRoLi1H2E11/olrPAR4hl7PIH2Ghtu4qs+kY
	0gXOfhA5P1ftcR2goaAw1gBmA=
X-Received: by 2002:a05:620a:2a16:b0:8c6:a848:71fd with SMTP id af79cd13be357-8ca2f846e6dmr193270785a.27.1770166797772;
        Tue, 03 Feb 2026 16:59:57 -0800 (PST)
X-Received: by 2002:a05:620a:2a16:b0:8c6:a848:71fd with SMTP id af79cd13be357-8ca2f846e6dmr193268885a.27.1770166797264;
        Tue, 03 Feb 2026 16:59:57 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e386ff563sm253405e87.1.2026.02.03.16.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 16:59:55 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Feb 2026 02:59:49 +0200
Subject: [PATCH v3 1/7] dt-bindings: clock: qcom,sm8250-videocc: account
 for the MX domain
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-iris-venus-fix-sm8250-v3-1-70fa68e57f96@oss.qualcomm.com>
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
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4671;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NfLzmE5xWwA42fboOATaUS3ihgAtr6cr7dapV1J0XF4=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ2bTLHbTWX0xkz0MAq1qTj17rigUl56auSrF+LXQr02ex
 98rxjzpZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEmCdzMMznzZ/y6cahMtnC
 pxv6m3i+JOfUOx2Yy+TJoZ8V/ir3aXqF14d5154KX9a33F3As2mRNPdLH/mtYSV8Wml8TBYyOxq
 VJr2/cszuNLf8PJ2PPNNM2eVPf428KMV5X/rg7ocmyrcUGvSSH2060NTL81+X0yVHOjm/butOw2
 KJiPcvJzJ7LTDrfhP8IP/Qp1Qz94PvWxZcWfFvfrm5S39Nm6Ku1i/OvGCHRWcNrnpW9efen2QRU
 d2RwDm7W5Kh6O8D190fWl6ePyacZy1voPBO/I9+y8T/65U3TNbLn6jZmBe9J8nj1oFVz79MWtj0
 a70Pt6mnocZTPp79WxxLM/RqvzUKrJ86TbhoueUruaDJAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: h2uTJE--M2N2HfJd0NAG79RnO3wS2zEg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAwNCBTYWx0ZWRfX8kxGVe43iEGD
 aPYBFpwEDnbhN70z6bCPzLnQQ75xu859E3LGLK61LqQI4RbSecWumsievpH7KSPoLDlTLHIRY8S
 xNMU9WwrwBkCe0rBVXUXSL+vmG0sJBd8aD8UISOPFH+wNO/sg6a9sC8Nzi/jAbbUSaNKEc9BfQg
 XaZrRjjcYUJw5MFY8wie/Kqrlks0nVi26Pdry54N0u179J1udipB5fevQqiCT0HvH3pwHfgxOO+
 6Ghpmk9i+HFrrcvZ0DkEYZQ/WA2dnWr/oqxDg2TUk1CuKmf4UtxrWLZ3LX5pyZI6QLC4PoVbrgU
 xZYBkqsYFeb759Zzvlq/meTxqmJnc/tNFi2auNOQOBkpfwclI2OUOFQNdTV0p7DtGNZlcFx5dL6
 bCSqr3/zQZXd404dyyoaD3LclVRMvpAiF0vL3TwC3xMWaB5qqsuVUcTuoay/NxWKe1fndNAPAG2
 9e1DoDqFK5LIhjBnRDQ==
X-Authority-Analysis: v=2.4 cv=TZmbdBQh c=1 sm=1 tr=0 ts=69829a0f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=YnufBIW6yfzn90QHPNQA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: h2uTJE--M2N2HfJd0NAG79RnO3wS2zEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040004
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
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42021-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,ab00000:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,quicinc.com:email,devicetree.org:url];
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
X-Rspamd-Queue-Id: 52F5BE02CD
X-Rspamd-Action: no action

To configure the video PLLs and enable the video GDSCs on SM8250,
platform, the MX rail must be ON along with MMCX. Split the bindings
file in order to provide separate file utilizing MMCX and MX power
domains.

Fixes: dafb992a95e1 ("dt-bindings: clock: add SM8250 QCOM video clock bindings")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/clock/qcom,sm8250-videocc.yaml        | 85 ++++++++++++++++++++++
 .../devicetree/bindings/clock/qcom,videocc.yaml    | 20 -----
 2 files changed, 85 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.yaml
new file mode 100644
index 000000000000..341d3cbb7cbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8250-videocc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Video Clock & Reset Controller
+
+maintainers:
+  - Taniya Das <quic_tdas@quicinc.com>
+
+description: |
+  Qualcomm video clock control module provides the clocks, resets and power
+  domains on Qualcomm SoCs.
+
+  See also::
+    include/dt-bindings/clock/qcom,videocc-sm8250.h
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - qcom,sm8250-videocc
+
+  clocks:
+    items:
+      - description: AHB
+      - description: Board XO source
+      - description: Board active XO source
+
+  clock-names:
+    items:
+      - const: iface
+      - const: bi_tcxo
+      - const: bi_tcxo_ao
+
+  power-domains:
+    items:
+      - description:
+          A phandle and PM domain specifier for the MMCX power domain.
+      - description:
+          A phandle and PM domain specifier for the MX power domain.
+
+  required-opps:
+    items:
+      - description:
+          A phandle to an OPP node describing required MMCX performance point.
+      - description:
+          A phandle to an OPP node describing required MX performance point.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#power-domain-cells'
+  - power-domains
+  - required-opps
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    clock-controller@ab00000 {
+      compatible = "qcom,sm8250-videocc";
+      reg = <0x0ab00000 0x10000>;
+      clocks = <&gcc_gcc_video_ahb_clk>,
+               <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>;
+      clock-names = "iface",
+                    "bi_tcxo",
+                    "bi_tcxo_ao";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>,
+                      <&rpmhpd RPMHPD_MX>;
+      required-opps = <&rpmhpd_opp_low_svs>,
+                      <&rpmhpd_opp_low_svs>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index f4ff9acef9d5..8676c7e22b4c 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -19,7 +19,6 @@ description: |
     include/dt-bindings/clock/qcom,videocc-sc7280.h
     include/dt-bindings/clock/qcom,videocc-sdm845.h
     include/dt-bindings/clock/qcom,videocc-sm8150.h
-    include/dt-bindings/clock/qcom,videocc-sm8250.h
 
 properties:
   compatible:
@@ -30,7 +29,6 @@ properties:
           - qcom,sdm845-videocc
           - qcom,sm6350-videocc
           - qcom,sm8150-videocc
-          - qcom,sm8250-videocc
       - items:
           - const: qcom,sc8180x-videocc
           - const: qcom,sm8150-videocc
@@ -128,24 +126,6 @@ allOf:
             - const: iface
             - const: bi_tcxo
 
-  - if:
-      properties:
-        compatible:
-          enum:
-            - qcom,sm8250-videocc
-    then:
-      properties:
-        clocks:
-          items:
-            - description: AHB
-            - description: Board XO source
-            - description: Board active XO source
-        clock-names:
-          items:
-            - const: iface
-            - const: bi_tcxo
-            - const: bi_tcxo_ao
-
 unevaluatedProperties: false
 
 examples:

-- 
2.47.3


