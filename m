Return-Path: <linux-pm+bounces-43404-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JuNLPORpWmREAYAu9opvQ
	(envelope-from <linux-pm+bounces-43404-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:34:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8F41D9DC9
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 868D7308F093
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 13:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A28334681;
	Mon,  2 Mar 2026 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TTeUUmqh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C4+LLwaA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB0379EDA
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458182; cv=none; b=nt56QHWb1Izn2SgM0rdVQOyPYaj6s8VBRCFqq/tHis2MbWqkug8rdpo3pEiq6QV67ZmYbhBC4POkt96j+snW33Xp33itJQXDzuAG3o5iza/cEZVpd+nUoy5pWGYdffaM6kMdjPhlGZx3Rly7GBoqvvY4BvyKUMbj1qGvj8YZDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458182; c=relaxed/simple;
	bh=meXGgSvTGfMBUarg91iFcG54F1AZhuNxBdfaz030MnE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ikr9sBIKy1hraOEv8JMYAP/shqVchLD0yG+7pRdXvgQocWPWXAHHGJ/+G3kWgUbggxYWAHSWlmngMFPEvhMH5V/DnqOt1xCpIdyY6HplcmTyDoWlxFYlgg8TteiBzfLcgMui81jvO57IL7aLFxwjPQPmWVIjBBEccGfGq9HJ+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TTeUUmqh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C4+LLwaA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229JZGJ3742057
	for <linux-pm@vger.kernel.org>; Mon, 2 Mar 2026 13:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NrR8wBkc/3f/fInQc1117c
	YD1EoAhKrKGP3OxuRfbMc=; b=TTeUUmqhm5TJVfWz1zFZauz2jbAmLp3tWp/4/E
	iAP8IlZT+2UQj+x8+sVwzSE3APtgnIU16e4oXjlzN6ddfvb26z5vJZJmaRjWnlV0
	fR8sFTA/sH6Ulu3m3NSX+h2cJcbRAcHiagyiNieIuhalgLdHEEiDg1D+R0sedU2j
	cNa5a0fm0p/Bg2hGR3tEd8q/WSI8gaqLKHryFcP3NKHzInwOjYSkpadS7EQ8deKB
	wPcIf4BQxAIMPS1u2dlN8eDv43DP96XpLuUGL7RajPUgrDFmMpGgliPgsZRjFQRp
	+IaZpH1MpahkHMHDAFQeC6y9/auGb6QRyk4RMR3aOW8UNlLw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7trgtaw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 13:29:39 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89a0249d51aso18288406d6.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 05:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772458178; x=1773062978; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NrR8wBkc/3f/fInQc1117cYD1EoAhKrKGP3OxuRfbMc=;
        b=C4+LLwaA2whLdKWSvo8W8igk/W2AqyqwNk0+35essva0j0LpiK6ZROdLW14yDxBlWm
         BSK2qBfuN1K9W2pS4U6ZGKMqqfdoZ1leLk0jRa8pOOCouvExhTSmB9vK5brPgzZHirUz
         LFVeFINiIEdRGOjjS1mkoZT2d9Fa9cv67+ywtcG2h2sEohmXgPX02K9JNG0W7xYjCIXH
         H7YM91oi/Ur0rsmkaEzOlz7o7fYZREL/uDFc1AFMYoT7OOAE5imH5prtY8IQwEAAE+ET
         K/A3J2EjnksImocs8YInjmGqE/AlkvMihvdaTl/uIRhdlL8NVXTT5IY91RWkuk+eGon3
         0weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458178; x=1773062978;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrR8wBkc/3f/fInQc1117cYD1EoAhKrKGP3OxuRfbMc=;
        b=r9aty78Xk8nmGdU6CkHh7LsHX5MGnxbVUPX/O+gQiQ+trOvpflfhZSkDVHPNjJ+L7e
         yIAxzrWaoHGYNtyILeZNthyLBiYPmpvU0oo5P449XuQlaeWD6d83nVk3F/LvZPGWnFu4
         nVMYbYcD4O3SvzNadckVYPo419gf/6G+OR/2smnTHQ+jkHdcyxt31oMLjctCjAoyE+/o
         rdRpu/BHiD7vfB8MU34Mo0WAs5rZA5xwzLm00bM5MgF8XXh20agd1HkCN/8eno5Xccxi
         Z3OzvzhTAzx9EqO/Ss097PwNVgolj5i5s51jnPkoMNZaPoO8EK8PEACQnDfZP3Wn9sPO
         tIMg==
X-Forwarded-Encrypted: i=1; AJvYcCVBC25mtPK7VBoCXKaXYpNKCFphlAKP3hjBSQXdLtaSpAD7S8KwSoWpZcqZv94N/kw72YbTvTHm3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWpH1Us9jepPVBUIfiFufsKDfee89NohpwHbZn5kNCu4loKgIp
	r/qSU+PrAWEDyrgA7gJVvBqw9bZTuL69C4oXkZhdFouZu6ysW8wpTD0oxindeH5G/4G3e0LCE7V
	16JYBJBe11QiQAEZ+uigK56NIVTWIggJRH8ZITRSjV7jXsZ9Px28I2WWlCMArCISHK1w3dA==
X-Gm-Gg: ATEYQzwedVbnnHtBa9xwce+nAzpNjsFI1caYhj0noMvaDaie48CHN0KsJfGgl8rLmlH
	I4IqPFjpWQ4yp5qjx9bNgd8L6lXX67ZTJe6A0lua9vrp6pizsT/2ekano+dEfu9tjJShNhqI3eH
	OaPKfFJkpwvJb/GcGp2MohpWyMywigbQvZBG3otajsJpH0wtMRvH2pdvLnsZjOxzN/psrtpXQx+
	eIPERfEwlBLAwV/Xbln+lWdctL3kmECFRze4S0nVV/Pr3nAzyk5bKqYukH9pHykPMN3l7apOv9/
	y7Uij78altaZkBH5jz6FcubjhEHrpLPi0ZGJnHLbPeYlF53OXcckdkcrEAQ9qFz3EYixU2pLA0Q
	I3QDM0cWzBjsZ8nhAS1yAxZwPyWN3fg==
X-Received: by 2002:a05:620a:3187:b0:8cb:b062:c2ec with SMTP id af79cd13be357-8cbc8d8678cmr1557392485a.29.1772458178310;
        Mon, 02 Mar 2026 05:29:38 -0800 (PST)
X-Received: by 2002:a05:620a:3187:b0:8cb:b062:c2ec with SMTP id af79cd13be357-8cbc8d8678cmr1557386385a.29.1772458177578;
        Mon, 02 Mar 2026 05:29:37 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf894sm133471575e9.16.2026.03.02.05.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:29:36 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v4 0/2] pmdomain: qcom: Add support for Eliza SoC
Date: Mon, 02 Mar 2026 15:29:30 +0200
Message-Id: <20260302-eliza-pmdomain-v4-0-e61ae2bac805@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALqQpWkC/3XNQQ6CMBAF0KuQri3ptBXUlfcwLgodpEYoUiAq4
 e62uCFBNpP8zJ83I3HYGnTkFI2kxcE4Y2sf5C4ieanqG1KjfSac8YRxSCg+zEfRptK2UqamWgM
 7AmRaoiT+qGmxMK8ZvFx/2fXZHfMuKKFRGtfZ9j1/HCD0NvEBKKP5HvxWyVQn+mydi5+9euS2q
 mI/SPgx8IXCxUrhXuGiyA4pZinDYkMRS0WuFOGVBEFooVTKFPxRpmn6AuhNuq5RAQAA
X-Change-ID: 20260216-eliza-pmdomain-dd10911bd4e4
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=meXGgSvTGfMBUarg91iFcG54F1AZhuNxBdfaz030MnE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBppZC8cRwcUq7qzrSSOY48JUijRlQuUOj/GYN03
 Pagg/PsPiGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaaWQvAAKCRAbX0TJAJUV
 VmHSD/0ZLwiSY9gwTGrv1Y0LQ1FLtXpXxP8iHR9H3YgGPX++82vl1ub29pGBtW/KJX2w9dAQhaO
 bPJVw1HlaJ4QN3pWRQWcXyJ/54GqJN6Ce7zv3KDRDU6EsuTcZjUiV0KJ2xpzivgEu+IMlAGtbfm
 AqNXCPjnidB0Uy9mbIXcSYgqZJtjuMJXIjLPhSjwGIeYUuX8SAtOLcKXj/P1o/ITCwKFKqdtfrl
 Ebw47fojBHBOsrzC0jp3iWTgq3xsPuU49IeN95h3ExTfXdBmTabniEBaeThry9cbjqgYsnLwWbq
 M+DC+jMKnmCyPriWSIb+jZbdOCBrf1fKSeRW1L9XCPnDr2lMNXmJwK634ibYy3y9da2vd+mXEcZ
 i/Fs2V5oXXf4WCW4+S2W2vMIdHQR05SLOBqNFriK17uzJyKvnpsP7wd/reQHLgA0hrPyVoujiKO
 O08ldGoKQIMRHm86o48l5gwZJHuyjjTbfukOn8gi04ym0yNQ9clLhCPGOnisSIQremKvk+5EFGd
 cmR5wu7iiFIdNbb2eP3HgZqaWpv56ZLLBPHRhNKG21DtZ5uySEqkCuQaZFumPJRZpD+rZ4pRIQT
 1yNFTNSqnX2YYDTKQwWFzUH8xvtiFDnpnjpIo6mgSZwqygXIyayN55DD4JMa5thHKnBzn5OkQ6P
 NHlwFxLpKzxkqxw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExMyBTYWx0ZWRfXyphBxPeldBo1
 Z8q69RuYotpg/RJQHpOTdvSwN3250PfHmbfGaiOpAC7OIAnBujE5z0c70fCxZuz1t0Tr+Xnbzie
 a8gkp+AVtlP/zGuuS/wzTECbLJPtp2OCpwEaj4SR2TTuBdRXncieomKxpgyUKHLrPcFjEttT69P
 CMPCD1tzl66jBDwXSbVC/jSHJ2YPmKOnMJ2lWbwR+ijQWAvxr+U8iAey7FITr2bhjdVCepAoLPp
 AEbSajpdqeo0cDIG3qJNSURNngdd3ksKpfvUTk3+ECWLs8EqfAHD+7yDFuKTnm4MykqTeeK/NTN
 w72STM3v5ZzW4fiIdCn0pT+j4rEBoi3A7Amm3oMcb0SV8+OSa+hqHOTNf99gBAzoyhf+RdHpy06
 FE3kKWr6h+T74N6QxaSStKbFHnxJHJpx3yWJHcOpPgtMPIJXiDKuzWPwI3Asf5N3nJFqZJLsQKo
 60GPDe1gE8pZJsZjFnA==
X-Authority-Analysis: v=2.4 cv=TNhIilla c=1 sm=1 tr=0 ts=69a590c3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=w5gbrMkz2gkyNj4IujcA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: _2RDI3dTR0PhQSWv8_WgQgOsCe60TJ-7
X-Proofpoint-GUID: _2RDI3dTR0PhQSWv8_WgQgOsCe60TJ-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020113
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-43404-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,msgid.link:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2D8F41D9DC9
X-Rspamd-Action: no action

Document the SoC specific compatible in the devicetree bindings
and add the driver support for this SoC.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Changes in v4:
- Dropped the GMXC and NXP2, as suggested by Kornad.
- Link to v3: https://patch.msgid.link/20260224-eliza-pmdomain-v3-0-6e13d3aa70a1@oss.qualcomm.com

Changes in v3:
- Picked up Dmitry's R-b tag for the driver patch.
- Re-worded the commit messages with better explanations.
- Dropped the MMCX and MXC entries as they are not described
  in downstream and not used. Consensus reached off-list.
- Link to v2: https://patch.msgid.link/20260223-eliza-pmdomain-v2-0-23fb87eb70ef@oss.qualcomm.com

Changes in v2:
- Changed the MMCX and MMCX_AO to the PDs with CX parent.
- Picked up Krzysztof's R-b tag for the bindings.
- Picked up Konrad's and Taniya's R-b tags for the driver patch.
- Link to v1: https://patch.msgid.link/20260216-eliza-pmdomain-v1-0-c51260a47d6d@oss.qualcomm.com

---
Abel Vesa (2):
      dt-bindings: power: qcom,rpmpd: document the Eliza RPMh Power Domains
      pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml        |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                       | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260216-eliza-pmdomain-dd10911bd4e4

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


