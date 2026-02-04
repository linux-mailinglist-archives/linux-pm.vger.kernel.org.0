Return-Path: <linux-pm+bounces-42027-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFBQFYeagmkzWwMAu9opvQ
	(envelope-from <linux-pm+bounces-42027-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:01:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3ECE0345
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF4B5305E4C5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C866277C86;
	Wed,  4 Feb 2026 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="enkmmN9y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BOGEHVOH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00F2773F0
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166813; cv=none; b=sQmJrJ03taiE6i7DdwUbxsa2Gzf83/89wpKIdKqHym2uP9BosxWNOirV6p+WllkB2aH1DeOhkf3xNltyg5anlgGA+FD8of11/9TvTKTAVtiAnYEeHEhbcdpHCnn1+Aqe+30IZd2tuxrQdIdObiFOSN4TuCfURAtaizQJW/cVpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166813; c=relaxed/simple;
	bh=8EnJ0bNvZO1OIHx736H60u2YBV791x2faUG9T+o3uLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDvBIIaOm5IRXNKViOn4aNyOPFA/4Aqw3LM19dAR6FLKI0Cpypf5+UmwYbwa/x1wQJFNVzGWr1/cyW8RHS1c4ke5AOUnlH0C5n9mksZMTFhs3a4XxVXyAJQOB93YapizjPGJ/ZZwN7d6lFD+o27okhF7QA2nNlTbfbhJ9iv+fYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=enkmmN9y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BOGEHVOH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613ImKBv2732643
	for <linux-pm@vger.kernel.org>; Wed, 4 Feb 2026 01:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tG//vnsGJ9u3ZjenYg9OjE6HUkUp7WbTGJkGw8lCw8U=; b=enkmmN9yzMVBKQcJ
	mLMVFnuw0/K+TnmzCeTFKIGHLT1YYes3sUna3qhzcFQuNGEOLLfYpPb0IzFxQVtu
	vOJCjy4JcH30HPhTGiD9nbXAQ64W66m3Hek2keNxuFmHlW0qh/XZV49qy3iri90M
	7OMh0fK1nIm4yIz6h7t8sNOtrigz05R6VL0ek9nHThPsfKIsum6IYjaTs9ZOzxtS
	oTiJznu1eiVpC46YkmDUBQEpLRXNwR2VqjQS+smUWZGFyQpKcNe2/yfElL6GNGHw
	y+4hzes1u6ln5gb28HFe1BWFrm0Ajoy1LA+Sdj1BaSCqkpk6nKNEkOmg9hTurIRW
	aWCsTw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3exjjs6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 01:00:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a87029b6so1883827685a.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 17:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770166810; x=1770771610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tG//vnsGJ9u3ZjenYg9OjE6HUkUp7WbTGJkGw8lCw8U=;
        b=BOGEHVOHJSvd72caaY0FCpHnoOfpd8VxqndqqrJIW5HgKg61eE1pVvq3IDRu1QCmG8
         fC51ef3+KVyKOoeGKmt8IwYzFRU9sTSKCtFg1lp7vVdMCbzBuNTul1WlK75KUlJoMrdf
         hLsnoq8fnf2BNIJYWpKVQJM06txpkphuchs/ROCiJ+xFYuQF3A1nJPYryV56eOCV5HD2
         yCi1x7F9MZn1xGs6dGAGbCpZtG1yg5MkejqqISSgbxrZFbmCERqbrMhkWEQMdOP/LD3j
         1Tdi5Vaji4uxvWAHSkBpf+dYEMtjhCbNdfw6uofSwldJaKoKVoOnEHXZTalbJd5G558V
         AJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166810; x=1770771610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tG//vnsGJ9u3ZjenYg9OjE6HUkUp7WbTGJkGw8lCw8U=;
        b=ihURquB5CPWDKCsOoq14c8gNvItYLaUJByiNgxNIftXjP1E5jFMEn3Jbij4fQ7Nior
         tpbPvSJFiEEw8B9B87K9mp9kK2gMbakqCESJZZ2ywqYRLoW6OYwxigzPZnyY7IhG3rl8
         9iXDPTzRDrQbbiVRrBKsSDX5wzdhvBu7iXKXpZoPXZpOSt6sMmPj6U3AtBgmFQj4RQyR
         7dBitmFvN1VAOLTYYFaqlCETTZ0WgGH/JXtHwGvnU/Jt9XVaT8HxH/ntY0VsLBT9loWd
         0W2VcGFDbMSgT+G0SB24ir8mkJnWNw8OOrclwHp6h2x70mBhcdZeaYXgLWcgvs3cv/Kc
         bi5A==
X-Forwarded-Encrypted: i=1; AJvYcCUHwG35ayyCyDivgKB47aldXCpP3Tqzwm+Gq3k9o98ZK5Eq/taai5ZiotN+Q6rLUKy0B3rAKT8kQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPCLM0Ft8LFsAaDCMNiEohc5wAHkmgOYYl3v1YE15CTSP24OEz
	BRBXuNXrYcIWMFtP+TV1mi8KBKNOuueKtCfn88CGUGMadiM9m9x9eapEt/IPXNWhDnFJybQyodz
	NWpr6nYQlVEuA/pTVpegTCTfZbS/MmOr5SVelo9Mtxsg+iINVrvuPs7G7rNF+dA==
X-Gm-Gg: AZuq6aKQQdf9kgVXAqzbXFXFlaUqJagW3IJ8+vrtqlK0CF4o6iZlpx8Kt7hWPkarbnn
	JhKjQ0KrPReZZJ941JbBIwZebnKQYEZYK6jtEiVg9aaoKLv3FO7eUqQEhx7LjptOenJwwYkXVBJ
	fXfeGR3zj9p31F9pqZP8mZauVJQOa39Kk+xaWPbCj2/u79EKhrbCidYwSDtqsIWzcTjAIn57wSE
	s1ph/ZhFpc4sCch50l3lZeFUsu31LYzdLbj+/mDJAiwofOQsR52gtK7Mw49y8PSv9Lq723r/Nmc
	mNXpVTvU5/yS/VrJL9+uGOrJ8yd8nsbrdnEbcJ6eN5gHik8RuFEgOLm0f0+KwCZuUpb8ts9a2Ac
	ZFgUW23Lo6W3eeB1JnEXoFqf7Uj1wGvN+HPHv/Ml4dDfCLlFCtuF6oVjoTUa3lFl84pLYLOTFnj
	dIxB3JVTTOkis3n/qVho+Zr0c=
X-Received: by 2002:a05:620a:410e:b0:85c:bb2:ad8c with SMTP id af79cd13be357-8ca2f9fdc94mr179571385a.74.1770166809592;
        Tue, 03 Feb 2026 17:00:09 -0800 (PST)
X-Received: by 2002:a05:620a:410e:b0:85c:bb2:ad8c with SMTP id af79cd13be357-8ca2f9fdc94mr179567785a.74.1770166809158;
        Tue, 03 Feb 2026 17:00:09 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e386ff563sm253405e87.1.2026.02.03.17.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 17:00:07 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Feb 2026 02:59:55 +0200
Subject: [PATCH v3 7/7] arm64: dts: qcom: sm8250: correct frequencies in
 the Iris OPP table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-iris-venus-fix-sm8250-v3-7-70fa68e57f96@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8EnJ0bNvZO1OIHx736H60u2YBV791x2faUG9T+o3uLI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpgpoId6bfGK1Psp59FHAP6PnmwWqSLQ5SEt2yW
 htFcc2Tq3qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaYKaCAAKCRCLPIo+Aiko
 1UiFB/oDaRdvUDPZg7ko9e7OmOCi9UUKpwmTqmzOHuDa9KsWA9FLEAG2i+LEcWcScskUQK/s+EP
 uXAIir63bGwy12lDiOKzmR+0pjnHYpgskeQJE9hYETEdL3fRrw6D0ro+6+xbb186qN6vgGBmG+0
 YirYOery37T1PxL9WRFQZji3HWdqRd6vnm5t/j8i1ZF0BihhB1+dMIc32KStJJqil/XRU0qiY+z
 im1cYmuqsNE1D7lbvij11sVYjOlq6Ck+de2nDLU9RxQaoQUJfBizsCwYDpgJs8b1t1/pM0UpiP/
 uewEL+rxzzlI2GvwDXqX3fS2HfErPehku3QINcEqRIMN2AAW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=W8c1lBWk c=1 sm=1 tr=0 ts=69829a1a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=EQKuo8RqpatckOKiKW0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Ll36fxlHbgslMHmBGVy7wFL9bLGad4jw
X-Proofpoint-ORIG-GUID: Ll36fxlHbgslMHmBGVy7wFL9bLGad4jw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAwNCBTYWx0ZWRfXx+Ypw73P6Xas
 jf776cV82Tp0KpJol4K6p4LcXd/hwdTv77ufeKa/oelG1y1TZPOXvzw4FPzAUYrd3CwN3ppuPh8
 tb5jv6VA6OGLYs2kqjzHTJBj3oFWAmHJf6nYQCbZZ+wFq+AJOnA8aZxH84DS6Gp6yXou6cOSZqT
 mmeGG5XrTZ6b/IQMeerycyUYStpTPNhnEDaoawvCQZskVSBNmH3E7GYukF1YXkoQUv1fWMMes4C
 2goyEvSFMnSpOUjsNWEgTP9eJ9hEr1KUNkpigMCeX4z+dD33ybmYGgtj+nQpzRMducVVGPAiurA
 9JhnTMqThsFEid11zj3Do5jm5BwmPucS82DopBalbwnI+6eYgpc6slCC+8V5mAK4tjbGhgYnTmd
 4QIH0J0XuF63AzR1Y8sauE4mjHV9ic59LMwtVUi0SQ2ng/0kNZPXXxhhbS2wj1bPX5ZGHoyvi6t
 BX5m5aEyrRf1Tn2k0ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42027-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,aa00000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EE3ECE0345
X-Rspamd-Action: no action

The OPP table for the Iris core is wrong, it copies the VDD table from
the downstream kernel, but that table is written for the
video_cc_mvs0_clk_src, while the upstream uses video_cc_mvs0_clk for OPP
rate setting (which is clk_src divided by 3). Specify correct
frequencies in the OPP table.

Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index d8be5c1add1b..7d11f1a28546 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4350,26 +4350,26 @@ venus: video-codec@aa00000 {
 			venus_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				opp-720000000 {
-					opp-hz = /bits/ 64 <720000000>;
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
 					required-opps = <&rpmhpd_opp_svs>,
 							<&rpmhpd_opp_low_svs>;
 				};
 
-				opp-1014000000 {
-					opp-hz = /bits/ 64 <1014000000>;
+				opp-338000000 {
+					opp-hz = /bits/ 64 <338000000>;
 					required-opps = <&rpmhpd_opp_svs>,
 							<&rpmhpd_opp_svs>;
 				};
 
-				opp-1098000000 {
-					opp-hz = /bits/ 64 <1098000000>;
+				opp-366000000 {
+					opp-hz = /bits/ 64 <366000000>;
 					required-opps = <&rpmhpd_opp_svs_l1>,
 							<&rpmhpd_opp_svs_l1>;
 				};
 
-				opp-1332000000 {
-					opp-hz = /bits/ 64 <1332000000>;
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000>;
 					required-opps = <&rpmhpd_opp_svs_l1>,
 							<&rpmhpd_opp_nom>;
 				};

-- 
2.47.3


