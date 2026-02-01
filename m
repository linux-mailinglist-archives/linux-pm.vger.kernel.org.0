Return-Path: <linux-pm+bounces-41862-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEw4Hkowf2k8lQIAu9opvQ
	(envelope-from <linux-pm+bounces-41862-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:51:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 133A7C5A02
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B067530579E3
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55DB32AAB8;
	Sun,  1 Feb 2026 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OY/+1X4H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fymC9Gll"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E732FA3C
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942963; cv=none; b=M6Z06oH1CKZBOaN8J5r+X/u6g7lIh0cMsG9CNZ8KcIHV1ncZdNAk1ZwT6o4+NJol+HLchqHNU/zHKaJBNMFDgkL61tjzviKcVII10osDLhblGTzCe0D1dL+SMIEj44tYG22BDvykouP25uApTuAPDbHlVjyQ1b4x+5/KUHa5MaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942963; c=relaxed/simple;
	bh=9/cOYTOdE7RIJlq5XPHu/65ov7FyGwGpdJ1dgFh6bSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPcvJK732DK+cpl7OvkJzMvXZQeJi7b/Sg8vkniojPTGuAwtWyzIDGyumoTaHH2Hyx9/8secZmE6w58OA00g3WcwCj1g0o0//ucF+yvh5n+dHV8Kfr2v8+YDmJGKWMOakciuEo9tqI0wim0kw2pU/kKduwn+4pU6THmTa1pVJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OY/+1X4H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fymC9Gll; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6118eWpd026734
	for <linux-pm@vger.kernel.org>; Sun, 1 Feb 2026 10:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3n5ypMdwtQxYQvKmZ+905ulr73tGxrA7J3ngVV5Xb6E=; b=OY/+1X4HNXtplvFj
	hChnB/Kvin5UTQ9dCKbdkkz9RlxW5+Te70RshjCkzFptCqwat0pAIBrq2cjGDZeu
	+OmzPyYzdXIzycew2Eh5jR+Z44YbeJ1LvDicO9Q7SQmbwdHFpYiEnYtFlUiqiVro
	Wb5PKP5bYhuN1camYX90Utc+SeB86ILPsHe69vo/3vBD9QVZYPUyMtuea9/UQCjj
	xJr5oiqQIpT4SPOiBWi1fmxnwdPftm5gBC/4lRjbL7gf/2pnw/KORPspkWSAin3L
	XfoUaVW8F0JfMo20XnMjoAkAmIWY/YefDSrWYhtvXbMHF3JltXFnQv6YP+/YnYmX
	GYuJVA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c23h1g4kx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 10:49:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-502a26ccb20so49532751cf.2
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769942959; x=1770547759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3n5ypMdwtQxYQvKmZ+905ulr73tGxrA7J3ngVV5Xb6E=;
        b=fymC9GllA3N19HDOxYqRFhElKHz8O2USChUkpHMBxkCpP57j1/HZmwb/xoFU+S9weE
         +6sZXyzkJfBywNRcceLdTx7K4OsUZxs8ljRFoKr6Eaw25Ts/IQwbsFJU9DNIF2ubk2Yd
         szzPHF0IYZPFv87pD0tFrHTp1Owml/afiDTwrpgy4CZde8D7CyV1SXdZAvbfHAAW0SaO
         xriyDPFGXk9CRLntoANPZ5qUVOKFXcgxT87/qrdmF7+LhrGNkRY+TgbIpcYdF661yg4A
         PJ8vbG6ImBvapVdixlm9iWUaCL9t44i+OusBZuzgFtjSAuBGwnIVauakiWPCPUxfwsy7
         1Pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942959; x=1770547759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3n5ypMdwtQxYQvKmZ+905ulr73tGxrA7J3ngVV5Xb6E=;
        b=lBU4mJyWMKFclsvzIxqdsLpxaaAF+LlJsJIkBrid246opl+vA487/9028yAZJe5Qxd
         dN/+lGIRLJ6IKax3vvnR60VCZi30Meibe3q2onvFfmSkYV5okCcIPOi3C6vxBe/Mx1aO
         0aTeScB5b7Fw+Wrgb+ikf56BYm2l25+qRqPIyp4vQMJMmoN7SW69Ew9e7jRgqcE7W1al
         FQ5iW4B6i2MPST1ZKlTrg7tfGUzSpPWw8VBWDqxDErdB7LM3FNaeneTyi/X/aktOHdxZ
         ZoDFDeLIpFlDEPcMt7AA6SuFuqzjqksevEVar9mXVX5y11LsFP6MKitFHzqdlWPIXuPv
         wcsw==
X-Forwarded-Encrypted: i=1; AJvYcCWjALJ3wJq8i2em9EukhkVYpChZWUJXE9Dekh946cTX+MS4pYOUBE4eHjmc8wQmXhIdNy4rmKi7yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLs0GxIVvBd5rlL33bRcYqLPYMmMbuVKVqz1VBM5lq1ZHhJovZ
	JRBPGs5WKTs5pdwzVNKRjoZWdgkj3icn0XWnzdRqKmAL+4/9invXawGL7wZ/TXkZG4bm/SpZMDi
	8FD4osn7OiL7PmWzfSG1Ox+zHs3cfgpTg0ApQ5cjdNOPRWqytogoPnWamtFk7ng==
X-Gm-Gg: AZuq6aJJW/h0mW/1d/n1H5/qkI4IRV3NtBKGQaODLN9KuMARhdQ78BbfaJTm1tDZq2J
	GNwa4U2ZciibyxebcESV5mGovLE3I0IDjfXt5xRO71Z/8Cbv6Y2zGZD/609eQFeqkA/DLOZEsDf
	tqKzvjJiE0WOqUFNKt8CabGBeAbb8vauvOUPBiQcVvDiPZ9+hGVJV0SneBJT5GZFyx+OZ7OERid
	bfwC0fpY1giE9wRoYucmjHt4GsUJI7aj0GLqrVq/4buYP9DTbCBazTo7mTLUcWzqWCo+gf2vPnb
	AZwg4etNnysvV3E0cLK/oRBjgRaXszn2WbId6Y2hnnLLwMXJafrHNKfZ58cE82WCb8a4ZXx7ZO2
	K9gKoO2QgIIzS4+StaikDU7BwphsHGg42EeRJacUmtxi53qdJjNtgajETlubve8+Qgw2/kdJxau
	dnZgksTke2hxn9ri5jKJPD3Sk=
X-Received: by 2002:a05:622a:181c:b0:4ee:2984:7d95 with SMTP id d75a77b69052e-505d214b038mr117498701cf.13.1769942959308;
        Sun, 01 Feb 2026 02:49:19 -0800 (PST)
X-Received: by 2002:a05:622a:181c:b0:4ee:2984:7d95 with SMTP id d75a77b69052e-505d214b038mr117498501cf.13.1769942958883;
        Sun, 01 Feb 2026 02:49:18 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7a8csm2835006e87.77.2026.02.01.02.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:49:18 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 01 Feb 2026 12:49:02 +0200
Subject: [PATCH v2 5/8] media: venus: scale MMCX power domain on SM8250
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-iris-venus-fix-sm8250-v2-5-6f40d2605c89@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4260;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9/cOYTOdE7RIJlq5XPHu/65ov7FyGwGpdJ1dgFh6bSY=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ2a9/tKtTVX39ff8a7MvTV8a/DvEuPflJ7mO9PWbTmcHn
 vrx9MDpTkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBMxD2bg6FlwfyHcxd2W29o
 EfCQ8BQuYb/Zbxhc1r/bajpnGW9cT5yoZYora37NTi/9nQsEf/MVzX100Oie1BoFm9PrhVvMn3R
 NK7s8f++xgk/l4SbmP2fEV6zqjq0OvDc9wCZhwfusj1ENHvWl1e+9383b8j/1MY/N83dnKwsvua
 3vWLxJPWZX3Qzdvd7/xJrfv5m97cPFIkbmmTss5rP6aqZGP5xQXRlop3HERvRIbYLKTK+FHYnHp
 s01DwsreJ7AdJDTPE99gtxfw4P5HwwCnhxuPGL/mONSj66NeZlOUsuDlJ8K9cIJSmYyk0+cvcT2
 +i+/MC9bijtf269d4X7GQkdPOXQox19xXdV2/t7L1rgcAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: GKb8nnR3Vjng74CwrU2PsqQ1NNz4DBT9
X-Proofpoint-ORIG-GUID: GKb8nnR3Vjng74CwrU2PsqQ1NNz4DBT9
X-Authority-Analysis: v=2.4 cv=Fu8IPmrq c=1 sm=1 tr=0 ts=697f2fb0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xbrBj4A6o8sUajtV048A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDA5NCBTYWx0ZWRfX+/o1kB7HlV0I
 J42oBwDRwpvILPbyWk3PKMVtQ/vPFIfn7oiRlxCj29Js0Icb84l6TC2b6S9MCbXiCMIrDzOdIcP
 24J+PzMVU3Ejglmux2jELRujTPGIAIuZix4stD5p8Es97xzvqr+43ACgayAW7WkR0RJ3qQgaoBY
 AzLZAOoBZGbjtVQVAlT1WkK2HwxSIaPjXOsShkfo6+3XSTqTzNqHV/GTof8c8KKESgMu73YkGyK
 K6opqtoxe4i+IyNuFmUzliVHjTySOssa185hHIEVf3w5XNNSQVTDfvQqt9pTbespFXLkgf426zP
 ozENnMyJiIM9/WT/Lc6v9Ad6FDe5NmG35EWoGNv8VgnrrT1PXW2Iw3/2NSf2me/f8j1Q9bARjvr
 XmsER0L27K8f80XXOLqEzrKVG9o+A+e5v32nW+2T8LyTjQO8MfEBHvMHcSuNK3XS3aDyC/h4kHY
 Jlfq3TFKL+iLda6YMgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602010094
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
	TAGGED_FROM(0.00)[bounces-41862-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.90:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 133A7C5A02
X-Rspamd-Action: no action

On SM8250 most of the video clocks are powered by the MMCX domain, while
the PLL it powered on by the MX domain. Extend the driver to support
scaling both power domains, while keeping compatibitility with the
existing DTs, which define only the MX domain.

Fixes: 0aeabfa29a9c ("media: venus: core: add sm8250 DT compatible and resource data")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/venus/core.c       | 7 ++++++-
 drivers/media/platform/qcom/venus/core.h       | 1 +
 drivers/media/platform/qcom/venus/pm_helpers.c | 8 +++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 646dae3407b4..cad2df84ce60 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -882,6 +882,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
 	.opp_pmdomain = (const char *[]) { "cx" },
+	.opp_pmdomain_num = 1,
 	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
@@ -933,6 +934,7 @@ static const struct venus_resources sc7180_res = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "cx" },
+	.opp_pmdomain_num = 1,
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -992,7 +994,8 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "mx" },
+	.opp_pmdomain = (const char *[]) { "mx", "mmcx" },
+	.opp_pmdomain_num = 2,
 	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
@@ -1054,6 +1057,7 @@ static const struct venus_resources sc7280_res = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "cx" },
+	.opp_pmdomain_num = 1,
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
@@ -1102,6 +1106,7 @@ static const struct venus_resources qcm2290_res = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "cx" },
+	.opp_pmdomain_num = 1,
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50_LITE,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index c7acacaa53b8..62ab747291b8 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -85,6 +85,7 @@ struct venus_resources {
 	const char **vcodec_pmdomains;
 	unsigned int vcodec_pmdomains_num;
 	const char **opp_pmdomain;
+	unsigned int opp_pmdomain_num;
 	unsigned int vcodec_num;
 	const char * const resets[VIDC_RESETS_NUM_MAX];
 	unsigned int resets_num;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index f0269524ac70..14a4e8311a64 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -887,7 +887,7 @@ static int vcodec_domains_get(struct venus_core *core)
 	};
 	struct dev_pm_domain_attach_data opp_pd_data = {
 		.pd_names = res->opp_pmdomain,
-		.num_pd_names = 1,
+		.num_pd_names = res->opp_pmdomain_num,
 		.pd_flags = PD_FLAG_DEV_LINK_ON | PD_FLAG_REQUIRED_OPP,
 	};
 
@@ -904,6 +904,12 @@ static int vcodec_domains_get(struct venus_core *core)
 
 	/* Attach the power domain for setting performance state */
 	ret = devm_pm_domain_attach_list(dev, &opp_pd_data, &core->opp_pmdomain);
+	/* backwards compatibility for incomplete ABI SM8250 */
+	if (ret == -ENODEV &&
+	    of_device_is_compatible(dev->of_node, "qcom,sm8250-venus")) {
+		opp_pd_data.num_pd_names--;
+		ret = devm_pm_domain_attach_list(dev, &opp_pd_data, &core->opp_pmdomain);
+	}
 	if (ret < 0)
 		return ret;
 

-- 
2.47.3


