Return-Path: <linux-pm+bounces-42294-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cILLMtUiiWkK3AQAu9opvQ
	(envelope-from <linux-pm+bounces-42294-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 00:57:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E010AAEB
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 00:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B3EE302EE85
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 23:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CD8385ECB;
	Sun,  8 Feb 2026 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IlKsEjMH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QgIhEodk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FBD38734D
	for <linux-pm@vger.kernel.org>; Sun,  8 Feb 2026 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770594946; cv=none; b=WJnr9uQCggy/5Tm6oPWq4vy7d+vvcdFGGtsAkBAu5yJkHSz0zr+iLaIZKvnyme4YWqJ21k/H1nP3WEG5LFRSGrIEYHm2NraZ6yzE+RUC2OgQh1SZocQl3ZLnZfSNv5/HseXJI0qrLROqo1weR0xtJ2QgRat7IjxOllZfHkMdpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770594946; c=relaxed/simple;
	bh=h25ZBfASMsW19qNVMheDiw3xoIbeq4Li9u2pU4b/Roc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PhEguCasXpJ71foI8yzCXYKZiPAWBhhhU/yzn4tMct6zIaFDKBgFPVoLGwih0o+8noQglKW3tjqLBCDxZ2wu/IWUQUXVE9sTwUwNWmNT7A7dpNCTuCGmtcRLKJBAj81MqOfcdLnfr4G83XPnR+cjGEj6FQSnfAN9toqgXus2Q0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IlKsEjMH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QgIhEodk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618MftSu1807303
	for <linux-pm@vger.kernel.org>; Sun, 8 Feb 2026 23:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TOV6wa0NpJIqPIMLpFjeBC8CWBIElaVmu+G/psZIY1w=; b=IlKsEjMHZe9TJnKV
	S/sV/hA6xIXf3avXaTZlanrU4cksr6iG2fvUpF7zhRqzNaYZq+m82Dp0brIt/wEW
	A+tDZV4Fbr0EEkLjqBMl8PQ8+KVuwWohm61LgKeBACmnn8HK81SREPWVJDDuPeDl
	uReUh2qIg0n3h8/92gTlqX6FsF6X0vHaZ95KPZvJLXemciaNRfKXK6rvdUKqDPtH
	A0zpUJS5rnu8+d3NI8QaR5Pxg7Z51QckhVAaFfRemRIAWH5eNNYmzL0zcdfJkYhk
	8fgMFtWnVtDSiJprHmpnQXJlsNon3OgTN6NGMOpk1w6mF8hG0sn2vGlqfSsqwWlg
	FLodOQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xj1b2g0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 23:55:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a289856eso1449748285a.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 15:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770594944; x=1771199744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOV6wa0NpJIqPIMLpFjeBC8CWBIElaVmu+G/psZIY1w=;
        b=QgIhEodkhfaJBO1i2fcPDvO+5BcK+M+wTdOKSSnhsDE4lC8Ezp8CbWSzkhHfgBi9rQ
         SiVkvDS9VKlG/51mSNq8b2EEWvL2X6nW9eivXxvC5xTnBRNpBswLYn66+YY6SVLOssVB
         /B07JYNMN2D6ZUC5D2VUwOyoOXOFQyTSHvSFDKQpSb2+AgpkDVfnRKEletQhUX7TB81D
         8p5g+FatKHCzyqMeNNm4IT7MUoq0lYBrGl2zx5xXBXxLDHZ2koo9mBdVWpsZ7Efp2W8Z
         ELbH0iIlDOo7vNnYcKxY6HNedapUZJEhzSG2bx+Rh9n2RIIX9wVrCN96GXyLuM8qchF0
         8ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770594944; x=1771199744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TOV6wa0NpJIqPIMLpFjeBC8CWBIElaVmu+G/psZIY1w=;
        b=L+ItRbwOjCmhkna+FaPfdE5i22tFzBaMtmj8KcaBGWh10+TZTK0EpQKpBGx+/IvD50
         9Z5yt5USi4W/rh+URHBjQS6dGx/SV6mEcmiOzCqlrEJBDbMR4YKoqv3i7pjFcR9t+0b6
         R8WsvWESnHQfFA507M5rKLYnWlF5ogdpoO/CPmw0VxSAKNq70fM0HCWjirDoNvTgLPu3
         Rirz0rJ1BZ2YFUAgiSTXjmKlP07O2aJd/ChVXijV5uQSJ5vF/q/LHJEugTunfGwPMDgw
         mT4ERPuNPIrR6gmjeABfp/OS+6fyocMUoK/wqcAijV49sYWIeiYmgC1SLsidTxCmSVH/
         av8g==
X-Forwarded-Encrypted: i=1; AJvYcCUeMKzWql1YRQWMtK+1LA1fs/J5w8dOlg9NY7apoIYXwVRH/QDY3QPNm+j4Khge85kv22tE5vdTxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5lNh/In9niOwKCDM30ZbT0eC0bRiUWXXMKtmepEOPD3YQoMD9
	8G0clCVsnqap1PFfuVDHi2LChzx5XN4RYzu1baI0MRwUDW8HjQ6sabxRTEztwIg3zcnZnds1Uth
	0+LGnm5yhXghqfpApTPGHc8nVzHYSPvceXGVCPAjN3Zbcgvxz7s50yDvWFSgkig==
X-Gm-Gg: AZuq6aKWtTuOsr5tjGQmJUDvYPK5SWiLKQ6AM6HjfRCC3aOFhN94NZZ5QD3E7tDJGiz
	nS5M9WuraVzXf/draMWz1z8y3VX2uF/oLQzDDQub6lbbvgiwEwrOHuofr7hKiIN+8m79nLNz/k3
	PzO8LwXJRJ3By9+1+iXpES37RbBX8coD0x6B8P24GNSzULJxSWZyg2m5gdNNLD5fbq3Wl5/O23o
	BAvdd8mF8HwdNWndMO1Kk1btEH9fVOHU4Cpv4yqwCUYl9ATLTzU1agBJRtYqgXIN1N/wEt++mZU
	jIjtCmKqQUCHCJngTuup4pjbcAorTW8ylIAgD90x9iwizbBFnzR82WIQ/eLwNOYyvhPPHRSxPHr
	H8Wk6nl61Uixd29xlG45Nhw4tsdDGluZ2WZ3wfwdSV7m+56ppPIVU/xrCTbehfHy7xxeu03ZtrG
	RRbMcPJSz8bRZLJ8gdMfz7+vc=
X-Received: by 2002:a05:620a:2683:b0:8c9:ea68:3bb with SMTP id af79cd13be357-8ca40c67048mr1555270485a.41.1770594944384;
        Sun, 08 Feb 2026 15:55:44 -0800 (PST)
X-Received: by 2002:a05:620a:2683:b0:8c9:ea68:3bb with SMTP id af79cd13be357-8ca40c67048mr1555268585a.41.1770594943878;
        Sun, 08 Feb 2026 15:55:43 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6ee4sm2188074e87.4.2026.02.08.15.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:55:43 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 09 Feb 2026 01:55:37 +0200
Subject: [PATCH v4 3/5] media: venus: scale MMCX power domain on SM8250
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-iris-venus-fix-sm8250-v4-3-9662a0471d82@oss.qualcomm.com>
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
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4385;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=h25ZBfASMsW19qNVMheDiw3xoIbeq4Li9u2pU4b/Roc=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ2anUtWO7fe2uv3j3X5K/v497qXyYZGaz0sCpEqfmWRG/
 HMvuhfYyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJyMWz/1N2e7E5ocfn3tkf
 4eYil4qyDgfNDU/VskuI36XRPzcy4vaEz0yxRsvfdd4OW+xtnlr667KdXbTP2+tntAxbXokZt/x
 q/3ODZZ/EB5a0AL87z+VDmJh0z2RY5Gc5q0p6Lp3WKf3MvDzuUams8qnk1VeLLmdkPdu2LTvdZr
 ldaIny4386k7cnXjU/zxZ6JTTx5+GOB35FUVM7A/a81fIV9Pm853Fej/KWm2W/AvtbupIKfms8X
 vHx/4ZfEs2/91bkd4ta5bkr3XMJ3c42KfTpe5utN5irlyXrB2tp/H+zlM+9wP7g11Q+n7hfexfw
 CJ5b7nA6g53Db7J55M5+5s87Zs7IiF2Ym5xjL1jSPPcFAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: TiEX4v2w9T0GO5GVsreJAKUMVOLgfpCU
X-Proofpoint-ORIG-GUID: TiEX4v2w9T0GO5GVsreJAKUMVOLgfpCU
X-Authority-Analysis: v=2.4 cv=F/tat6hN c=1 sm=1 tr=0 ts=69892281 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=xbrBj4A6o8sUajtV048A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDIwNiBTYWx0ZWRfX+CWVe/f0Df1N
 kgzqKo/G1K9fOB4cqbooqmVg0vfvib9Fn+3NLizR7PJeZuReNlWXn7NdonOcuDN92SulzaKRlRB
 cGLYY2ICTYECAIhiK8dR0L8W+99Q9XdBkkSzsbmWXTJpeZ+zzgCYXuRssaJzq9UFY319OGASvRz
 /9C36Bg9Ky2HrT4qrQcQAJnqHnEj1ud3sMfbntw8TU2IFOGxHh7oj/ph1Yt0v6mYY8kz+TPioGV
 m1IL+hK4IkSL3OSsevGnS1Uf1B4AvIqnfCIllN9b/s9vER87RWZqqTcLNHF5i51H49g74N3RghM
 55XVH4aSv7uRo78vmKnjtiiFE4LE3+kc5TDJIP84udfIXuFd5mJvhaoZrteGHxHjOu4wqlGtnXm
 cEwa325yZ9WBliP8s1Rr20wag9uPpQ8sl/UqmjR7aiMa9dvnLwomxsn1oX2w/b9LnL2IPsyu+3J
 1mXmxQK8xMqvP2FsJkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602080206
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
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42294-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_PROHIBIT(0.00)[0.0.0.90:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E0E010AAEB
X-Rspamd-Action: no action

On SM8250 most of the video clocks are powered by the MMCX domain, while
the PLL is powered on by the MX domain. Extend the driver to support
scaling both power domains, while keeping compatibility with the
existing DTs, which define only the MX domain.

Fixes: 0aeabfa29a9c ("media: venus: core: add sm8250 DT compatible and resource data")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
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


