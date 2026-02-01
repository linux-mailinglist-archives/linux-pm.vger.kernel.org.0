Return-Path: <linux-pm+bounces-41861-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG8wNiswf2k8lQIAu9opvQ
	(envelope-from <linux-pm+bounces-41861-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:51:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 378BEC59E5
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A5C30514A1
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B78A331204;
	Sun,  1 Feb 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oN6PtP+2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J/bo8qBw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B832720E
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942962; cv=none; b=YgB2K3lmT6h0Cd5dT4qY4GmPRHV7Ny4ixDf0LtUxJLGoH5ovenKvRJOe+UREerlOnxr1AdX4LF6BbnOUhsyERW4l+2aylM2LpxnPkKmwJTrHaLgfbS59+UoRsqcQ09Dij500QT/5fE9e9iT7YTPsbSabJKQpsO11/WL/wUfDOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942962; c=relaxed/simple;
	bh=6NuffNWnnJdps+Qa/VbgdTchPyycTYPYQqXXf6EKyA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEFPGvari+j0Dje1M67xm7yhJ2ivf4Mjl+59L1upTCQzC+zlrORCYjuhmO2nCglo0TdMJw26T9+kq+FJVimEe7hXvjwBXERrkt7uqIdUwd9M3Y9dpj4XkRDAIaT3uwQrEzNtBxw7Dxy3ZH1RmB52XNkysZ5gWKOnBLuM/E44aTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oN6PtP+2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J/bo8qBw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6117SLUo530602
	for <linux-pm@vger.kernel.org>; Sun, 1 Feb 2026 10:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1XGvQ7yGrJV4bV5rx0wYu9nGDUQZH8c18eThksaF4dU=; b=oN6PtP+2s+U0HXnh
	61bYVgoieOSchIJK+Dn0r4UAAgEck3X2LZ5TZSBzQp2oUc2TRNOwyzaTel0k/Ion
	TJFG1m+9JLiHIcABg1Xd6QSPRohjHflU2dExg99aCNpKCug9nxVu3tgghj4fBOat
	UJwMwrZgBjJs881zDzEl52uQZy8R3w5FP4GellcZ4OVCUijcO+scR/bWPLHuy62i
	UiPGdwfWZkjmvZA7uzJ3T9BPeRLKBMVcufkLB9Ip8MUontFtBr9NV/XtK+dL+btT
	xS/NLnjWHDp5I8IU0cESNCY3A5o94uUjHeSRvaWUJrrxZMrZY2Xzz5uRMOqCN4jR
	0GIO+Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1ard2f4c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 10:49:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5033c483b74so123184361cf.2
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769942958; x=1770547758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XGvQ7yGrJV4bV5rx0wYu9nGDUQZH8c18eThksaF4dU=;
        b=J/bo8qBwSjlAAHDkuPvKrMf80gcpFCKDIqsN4wvgXNdNjz+/u9ApLzyq58v7CIYMh9
         lPh6dho09sH8L+N0JuQdW4RcZIo/bYAPgcS/DP6BOmuoUheToBQxP5d0WzqPgAshJSDl
         50Lg0zOvyJ0Jw/auFjgAfmbBmzJKWrL6JTzVV03ExChW/UwKi+y7Dy+E122z0TEJ0EaU
         07D19gAVQJ/LDdR0k8MKGmPSRE5ujwqlyYPLHCqS53WhRpyG/hhElr5FEzzBAkjT5LgU
         ruheULL7vZl893zx9gDKUSjP+Dk7tnrGOhnkdpZ5IdxzBL+pNjm6xCs1xbUHwYDapXKG
         PiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942958; x=1770547758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1XGvQ7yGrJV4bV5rx0wYu9nGDUQZH8c18eThksaF4dU=;
        b=GR06zZcOEZ1p2bbwNluzmo2Aa1HcH5HlywlL3PVYb65ihA631zvyqQp2AeBRpZSLE1
         Kw8Jowp/T4f2wn9d/N+/f2fJ4ZWCo4g6cfh1o6NVl5RmabrcifoDtkUHa4fOx1TYJ3wr
         X9rkIM0NngmbdBJrvbdOX4lUjQxwKD6pbq42ffcfJ42dpU0QY1de2bA/l/0CVgfhzVyM
         eKjj1ghPtcaBcpDBpy4UcfQ1csohxinHde2ChuK5E5HrVCcVrxXc1LW1zZsKAvD5tCoR
         2LE+RUhLgApsdSzBwPbzDakQRxFPkG9HUA9Z4NvffmpoucQhDxmwOqAwxBVHBSpA6HHm
         TN+A==
X-Forwarded-Encrypted: i=1; AJvYcCVQPa/nFdTMZ3w8YcTqSdW7VDRczdyM+jPd039fSFTZeFNnYVaoA4igEyoY1Uc6aMWPG5B1WQXnEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNeMC5FoFGJTlRsxWkJeCnBREONYw6ZMEioyCAp9MrGGmFGv8D
	5Fgd3KbPjMjqw95D2MiQ3vvN7YhluqtFlJ5ebsTuL2f9YkAJi5gIwab1BFsiedpHxhfzKnM1F47
	eGg4nyxZt/JXsxtK0PivNrWuOFpcUEX8Dd6/sDY8kYfgr7eo9xCJ2By12C2C0BQ==
X-Gm-Gg: AZuq6aLbaSw6VYJtqaNXJen4mnze2dRuVXgC7WijnrmMODL41p6mezYsf/ryMYG0mng
	zsjO9EfBa0SwMDOfnh0AelYIc2AuRW2wGQSw7Hz3YrKtFPHr7CYYzTTDtk9rbQbaNI5HRwUP0qn
	hw5fEOz3IJF1gUc4eYF1ZIlm63J/MpusrqG5B4tgdNIm1KklAb4d7BRzZ8J/URkW5D6SHfgv9te
	EyDdNPCH7EnDgkoK5aYLwgEZm4RNj3knwLNIo7uz7YdVQTmNVV+grMk1cgGx3fwHsPiy6sExpo+
	CZQbkvRhf2JbwpHgfwC88p4KbCGe/h7zYPs4JVIox9Z/IqEYa8WDcjT3Q1ukUXQvbLa+cONgatR
	qA8cdhy5vkyPrHUeNsuxDPPoXLLnwntOHTa6mPWrXamjYFAQqCPdfifq9+0m8Cpjh1D+uzVfTqE
	ldK1kvbfPm8DL0cRjfmXKzcrw=
X-Received: by 2002:a05:620a:bcb:b0:8c9:e98a:d9f7 with SMTP id af79cd13be357-8c9eb26f7bfmr1045806285a.25.1769942958124;
        Sun, 01 Feb 2026 02:49:18 -0800 (PST)
X-Received: by 2002:a05:620a:bcb:b0:8c9:e98a:d9f7 with SMTP id af79cd13be357-8c9eb26f7bfmr1045803785a.25.1769942957675;
        Sun, 01 Feb 2026 02:49:17 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7a8csm2835006e87.77.2026.02.01.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:49:16 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 01 Feb 2026 12:49:01 +0200
Subject: [PATCH v2 4/8] media: iris: scale MMCX power domain on SM8250
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-iris-venus-fix-sm8250-v2-4-6f40d2605c89@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6NuffNWnnJdps+Qa/VbgdTchPyycTYPYQqXXf6EKyA0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpfy+lu9qhcFty2QIzhWPlD4ewtU5ybkSHWwKy5
 57y3sCL5qaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaX8vpQAKCRCLPIo+Aiko
 1c+bB/91FST6j2IqsZG5xQ54l4E42G7wu0q6Sky/D3OqlrU0bL1N3hNLQYQVjuSNRLWLox5TQwq
 3aCRZWc5G9RFYqiVJ/j1wou504OeD0g/4erL5Vb+YsGk2NAvuHf/jweydv0YpEmy51CbZh8isBs
 xUOW/HDKUQAcUCbnK3O85QqfWCeOdPM+NfeVLMAyft+h6EU7lxuyE4+ZDwVOJyBtS2UCdT+IPEi
 XXs3G4g0VaekM4kt4fMoSyIuHSyS1x00p8vxfRXIJO6Z8PyrIMI/Ge00vC772lHXkE3cITue2KO
 Twtw+NOcnloK6RgTrApDm9gIwcqZeL3Bebk+NTbGsJTccpBy
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDA5NCBTYWx0ZWRfXySjZUCCe19gn
 XX9to/zdn0S/64y6nO3tyL8d2CgZmx87GykPhJOCmhsBR2f3NEf2n+Nt9OouFbBNpbrEpRgeBKf
 A9Hffq49+Oh9CjGRSJgDyBCQODujuKjaOssI62enpyA3ixp6rtDfx1bEITBVCiHA/T6yv1mJ31V
 l+9PGhcAA4HnwZuXJGAEdqVZAi+tMNPBG8Ng9jdo8ZsEFWzPF9bXzGrPCHEdS0I7uja0F7xX7ix
 7pwc0phetIQDMgUffT47Mz2sJ6o4XigD7FmzsTbnZDoRFP2xLr2FL1+Fpp7DBPVxvdW+A6cT4m8
 a3bK2n0+beoc4+Z+AyHtZsWIsQTdElcHOfXiNlRaWjMATzLvYzV0axOd7y8A8mbPfkGMpkEWRCy
 flNnzyFmfU8tcFXBVtyuVTGuZNBBBMyY0s7uSDJ2ruin0fvEob/EysnkiakkfuiDxFZQW3kuEeW
 7o15IY3zADB58qTfs9w==
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=697f2fae cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_hdJGhFWpaytJYYtlLsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: cqUSvKvkxMI-AXrAn02ZqRBqqf5_zWbA
X-Proofpoint-GUID: cqUSvKvkxMI-AXrAn02ZqRBqqf5_zWbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
	TAGGED_FROM(0.00)[bounces-41861-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 378BEC59E5
X-Rspamd-Action: no action

On SM8250 most of the video clocks are powered by the MMCX domain, while
the PLL it powered on by the MX domain. Extend the driver to support
scaling both power domains, while keeping compatibitility with the
existing DTs, which define only the MX domain.

Fixes: 79865252acb6 ("media: iris: enable video driver probe of SM8250 SoC")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_platform_gen1.c | 2 +-
 drivers/media/platform/qcom/iris/iris_probe.c         | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen1.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
index df8e6bf9430e..aa71f7f53ee3 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen1.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
@@ -281,7 +281,7 @@ static const struct bw_info sm8250_bw_table_dec[] = {
 
 static const char * const sm8250_pmdomain_table[] = { "venus", "vcodec0" };
 
-static const char * const sm8250_opp_pd_table[] = { "mx" };
+static const char * const sm8250_opp_pd_table[] = { "mx", "mmcx" };
 
 static const struct platform_clk_data sm8250_clk_table[] = {
 	{IRIS_AXI_CLK,  "iface"        },
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 7b612ad37e4f..74ec81e3d622 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -64,6 +64,13 @@ static int iris_init_power_domains(struct iris_core *core)
 		return ret;
 
 	ret =  devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data, &core->opp_pmdomain_tbl);
+	/* backwards compatibility for incomplete ABI SM8250 */
+	if (ret == -ENODEV &&
+	    of_device_is_compatible(core->dev->of_node, "qcom,sm8250-venus")) {
+		iris_opp_pd_data.num_pd_names--;
+		ret = devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data,
+						 &core->opp_pmdomain_tbl);
+	}
 	if (ret < 0)
 		return ret;
 

-- 
2.47.3


