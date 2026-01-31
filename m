Return-Path: <linux-pm+bounces-41840-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE8SOFI9fmkvWgIAu9opvQ
	(envelope-from <linux-pm+bounces-41840-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:35:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159EAC3477
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CFA730131E3
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68235A93B;
	Sat, 31 Jan 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U53w10HJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZuRx+XNA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952735D5ED
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880843; cv=none; b=RfIzYod+N8kz1BypJn5tbOUeq0YoP+Ts/q3HmDaVDFYjJJbNHcnJCt7YeAaDH+JrxtDjhDr7ImNzk1FeJUdMl5mM/vCm3hzE/fD0aMPFHfbNb9oVdXex7rXCa268+7ZCzw2yjTgTV66mbkP6q+I3UKVl85Spu363VwaucRK3xV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880843; c=relaxed/simple;
	bh=9/cOYTOdE7RIJlq5XPHu/65ov7FyGwGpdJ1dgFh6bSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tm8zImmKqMxH6Wiwixy7Q0ogZLM/c2OFyYlGX5yqGQVdsIn/4R3ZX6vS/BZt6gPvULJWaXvk/8UVgQX7QXX7RwUK38bvzkNkavFgIxT1LkAgNcTVk5s7HYVKGfCYHFVzpAtwDuGRedly4T7LvXvS9EvLd4XJl+6amVRk0lSd8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U53w10HJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZuRx+XNA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4Tmvq446805
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3n5ypMdwtQxYQvKmZ+905ulr73tGxrA7J3ngVV5Xb6E=; b=U53w10HJn0ap51BN
	oYSO2LVlsnNiDI8xQroxmAMNGh88VvBbTnitvnpCEQDuKmQkmIXZSs9YLEZ96qvS
	mzlBcrGmV5QAu/0Gy+mZQM17v84TOrrJ/iedyK64KNOT3LO1G0G42Id2SZO8LrEx
	o6vjO5urO5/yDhOPswJBDk/VfjgMZTSbWpXm8Qm03CiaouTjEYq/iUtmh+xeNIEO
	hzCR04/OqZeOc/JoBp2DIUjiTxIGKsvsgC9JoVAx45o45QbEDAUoF4vtpoLTq3Al
	XbCVZaAraLhRtOARH5n4TCYR+i2wLFIEP4E0zhIagh9B4LquN7d3WW/jcvpHuiwd
	SyWBsQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1arrs7f3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:33:59 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5662bf5094cso9869636e0c.1
        for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 09:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769880839; x=1770485639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3n5ypMdwtQxYQvKmZ+905ulr73tGxrA7J3ngVV5Xb6E=;
        b=ZuRx+XNA+wc3lJvoA0RZv+bIjr6HWkg1YMPoRlB3HYsM2+IizqZXgTbzA2SrGdOjVP
         3OvDkgSaoSDBh7UbyeAtqoWy2Ipw+gRlACKOCBDs2ySb3+v6UzNPY0Mh3mVFBwn7x+oW
         FPPGJIGFvKrecJf6GS5zzlGdxOxss9bboMo5R9SoOqjwBlkxMurAjmIpR4aEtsC5HJ4O
         t4q5Tc+SgwJNQZofY2xgDZqzfKSUc6ecr6TmOOZ5tNPcOzvINOwtNYgifCM7lceiJ2qM
         w4PcJF/JKchWv+rFlOugzJPc0Dg8fO4ZrPAqzpmCCjqEC6iiPMpkKpcfixG8Qd4AoQyR
         oBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769880839; x=1770485639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3n5ypMdwtQxYQvKmZ+905ulr73tGxrA7J3ngVV5Xb6E=;
        b=w9mJmniYdiNM8oLhjbK8LizuBnM5dGUB4raCSrfoShRl/OEG/5Rvf1nhlm/L1XEarh
         iJDZylgBF7L2cO05/noBtjjHuJVIz5gtq07wOWeZLSP5MqSDhlGtuwy1CHLqi3WDReBm
         fAFbP5LZqWQV22Kxv/agxN1AiLY4WPP3OiUYL8e3rO+2rMIwp1sP8edqy8aYT0onAwGr
         M6N5a5KMWs8cpdzfrg4wryfVWkqWK5NoEiQs8DhJV6ZAk0f07vDQ1lRVjp4IM3/DDfZE
         rhbiDbGLqbSRbj9PFsl3qWMQIQOwzitRSQznTHhWpw4FvDwr5dAnLQjWX+JFGcpmDQFr
         lTPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw7lEquRLkXuMIW1jJfhAVNaAAZsg+hkyDrpTiXUvM4nixHfJO1OnLlpJu/eZZDIAIh4h8NjDfiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgcS6qTmjGqw20494R95iEHMhaeKfnFB4JAoxkhAkMcx2qOv8
	azkbA1uDh3sopTs7wk0pvl5L547e3ZaOq0DH8JizOUEfo0kI5+6WGKEa+NQ+xSzzjvJ9GAMTjoU
	aIM8rnq/hhm3tAr6wl5+NPh9/B8yWQx8arCB/XaaWZcqKDLsXTNyQD3M9LvVbCQ==
X-Gm-Gg: AZuq6aJ5L1B00wPQUWsp/XvimKGQVuon1b+Iw5ga8tZbQ5V+I4d3QurP1E9ctSwfFO3
	1puhDIEnSvstn2Y6bPMWG3dxEwLaET0+Lpr8veM1GDXua2QalxU73pU1HsQIqzaXkCd8H1bJQy9
	4geABqeMdaCGlUr+tRcc1DJ3Eu9NhEsnZrou27iMpqmBtTuKVC3w1CdQqvQHiTpdQM6c/BGHDAq
	ftJX2SvyQT6siBGq8fIhzjJPP+/NGBSKLov0lmZCQWb8MXd4oR6u840RqcbzZu/SATFmxqO4n5x
	INjaDHG5Kat8Qt2w2p3l6KYiyE8HBkyqTsIY418w7wnSXAFVUV//D0j38UDkgQV3ad/K90+rHmw
	DtFXtyM683HzDQqva9QjQPvuUd4ly2u5eziELynTacWASe9Sr6q8LNaXZu+JjH3tdSy2PpgAgPd
	FEJzy4JLYPOJk1HDqg2W5nil4=
X-Received: by 2002:a05:6102:ccd:b0:5f5:48df:b869 with SMTP id ada2fe7eead31-5f8e26c2444mr1857638137.44.1769880838968;
        Sat, 31 Jan 2026 09:33:58 -0800 (PST)
X-Received: by 2002:a05:6102:ccd:b0:5f5:48df:b869 with SMTP id ada2fe7eead31-5f8e26c2444mr1857615137.44.1769880838539;
        Sat, 31 Jan 2026 09:33:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074886f0sm2443236e87.24.2026.01.31.09.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 09:33:57 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 31 Jan 2026 19:33:47 +0200
Subject: [PATCH 5/8] media: venus: scale MMCX power domain on SM8250
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260131-iris-venus-fix-sm8250-v1-5-b635ee66284c@oss.qualcomm.com>
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
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4260;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9/cOYTOdE7RIJlq5XPHu/65ov7FyGwGpdJ1dgFh6bSY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpfjz/BD8pqx26XsbNArIa4fLQSwDBziV8y8ukE
 0TrKqAxIHeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaX48/wAKCRCLPIo+Aiko
 1XgDB/0Wbp4nrmWOeyy3n2ksxKixvBuJvvs0lgRn18HvEgw8IbKSGfJqoYahL89JH4QfZP4YAmM
 EVNoXX7/8wEY376RN4S2xmtZiko6afZ8tN8nXE3MUcchgXAkf+YMfDpRrOklBiUCbKOY7gbkzBQ
 aODKHMb+NHL79os9wPYakBaEANHQ+uaqoBMmrmH1nqxkWrxXfhGM8drfNpVpynmj+90ZbLtLfPO
 4BZFjuaWX52NMKcGaaZsdZPJNW1/2IjRTqY5PBQNwhJA3rTdfBAz17wHjnoEVdJQRhPoKHqZiOC
 73FRdTtSWAUcTMtL/iHbrq6g81+sI3AesBrqiB+J+kgy4fVB
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: kb5Bd_Gfs0Cq35ZqmJ7s3MmdC5vTxmiy
X-Authority-Analysis: v=2.4 cv=FNYWBuos c=1 sm=1 tr=0 ts=697e3d07 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xbrBj4A6o8sUajtV048A:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE0NyBTYWx0ZWRfXyhi12goITnJ9
 h9hp41y7ustMiOnCDN6/Dexe9jdnBOd0qHdUKUAdGGMbiH4T8bz4Qoq1u+tLCYu5+Mv25gJP3nN
 S3KpZce8np9LCFU1/d12dQUmEJWJW5UklrUHm8ocsMfuFd6VCNmXT9YsMPk7xMCOzrTziIOG02Y
 G15CzWyMkLhZHSJV5087MIry6bMfb/h4AqjqrSI3jfIkrmM0c7exEsGVtI8iIn0VqQJTL6o0zbU
 hb+BVq0UlBID6PZboN3N1psaUBQgMQGXacju0G621fy/Zz+NaxWKxvlNCE0oWFPp169hv0W5DIZ
 xkDF4C5rE3jjHfxjST/Ob9oqHnvELU8ARlcXXiagy13Guh/O9xL+1q78Xeo65YpWKAM79Jd27Bm
 gYmnql0xpyo8tnpl25nSrtZYFLe7nqcWEvCs7Zv0Ws9hPEaMcF+QejAsu2ptKZKk6sgtjIRyeqn
 Jh94LBDZ0bjPFAjvoQg==
X-Proofpoint-GUID: kb5Bd_Gfs0Cq35ZqmJ7s3MmdC5vTxmiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601310147
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
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41840-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_PROHIBIT(0.00)[0.0.0.90:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 159EAC3477
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


