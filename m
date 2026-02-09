Return-Path: <linux-pm+bounces-42300-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKHaFjI5iWmW4gQAu9opvQ
	(envelope-from <linux-pm+bounces-42300-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 02:32:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647B10AD20
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 02:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 634A33003D12
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 01:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FA258ED4;
	Mon,  9 Feb 2026 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nemKrVX5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XfWeNlul"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922DF24BBEB
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770600748; cv=none; b=LIcEnvriiK18IOw6PW72CHtufHhkSt1px90e0RSy7EQxhU7YmsHFAfXSJqMgxQzPGz/V7QihpRWJMMuFy1y4Iu4IvB73WRyc5ZZAmIUF2jZTua6T1hp1JjoUAy52/YntyxvSAS8KDMh94x4Ed2sfhZYxbvUjW5+lWJDZsWoDmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770600748; c=relaxed/simple;
	bh=67IDexaWLg3vptMF3hQy2WAlwLpBGtXoefLsLMJT6KA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bky0viFh1BtOPjOyddZ8BidATJ2CH5je93uaht413N3zCXczqUpIyiUspsTwJ5pOhZQUBH9zsu5B2z80s2/yGJ7ODHzOsYa21PKeVCoD97V/+I8aObLH+VuZQlQlGZ7003nqxHF9ZMbAIFgPrSbuIz7gYN172FkRpISF+sdZNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nemKrVX5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XfWeNlul; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618NeC3j1918109
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 01:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=roifxvws8lDY40roD45/Sk
	OpLLr/pMVs8PIIWTGwrVg=; b=nemKrVX5idGxZwhu7nxrFpmCi4kbcKWcxxt+0d
	yUjze8BGTDWRPW+096jbViCXAhkWwbIKv+oFG74GcpWEM4P2ciFThRKy/yR7Jzsx
	MqILJ27qPNS0ud6AsOMPC7i5J99N8OsHiSi4fwkZgLyyab1hHRwdSqu4ZI6h1H1V
	IxgcXGK7wXnoUo+mK6Z4pDKwS7LpRIyqLfx6JzuWQ1k9eGyQmZS91hz1HFQz5PmO
	c5t9m0PhXoVKxEKUmIiRHi/LJZML3QlOVB54qb/rKgG6vYgSNBDE09bh9NCA/zbN
	u2NyonUBtiqgC6QFYYqN09NZjZZR4SP9Mi43syTGbfaL63CA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xj1b6v4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 01:32:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70a08daf3so1036759085a.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 17:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770600746; x=1771205546; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=roifxvws8lDY40roD45/SkOpLLr/pMVs8PIIWTGwrVg=;
        b=XfWeNlulV+TFzJTcDFKgP/6Yp3VSKwMKmmaP5J4nAovz/CJYxE02s1c38W5vZCHrfx
         RBWJrmwAevm1LC3IAO3KPeQiC30ptg1AKohbUrOp8YThUMLWj/RTljsU0Ye/7ju/KeOY
         XxQoa7cak7gB5QPUPX18kE2hoChn61nfF7bXE4CormV5jvJzmILdJPS8vrEfDq5LGMS6
         vMf8FeL9CIKy6/vWmSFjy95qrHyZVaBrvgPiU0wEPLdCYXZPfyUTlPr2yN88ZmgYn7xx
         N7hyCU6RBbF5okbud3MsNZ+jVpCIPu3QMyVwnRVoWQgQkrJFFbBCpCI+UAfhAHz8qE1o
         x1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770600746; x=1771205546;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roifxvws8lDY40roD45/SkOpLLr/pMVs8PIIWTGwrVg=;
        b=nxUbx3jhnHfsg4jIumc2+HnivqclqYSlrpF/CHa8fu4d6lqhnpFHcrmxcOtWgjKWau
         3w1fOy5jGukwsXDO75+AW9jJcYOQCxc9uE5uwGzTTs3HxuGsw8ICrULc8WWvQrAb/hvP
         UlP73ff/PIN6fBaFCQGBPOIvwhChigBTROjtFllLldYmfR5sfkGtI1yi89Oem0+WI/1x
         FlbtDZKgw+GD6FgiAfqt9r0qtSZhaq3Nh4TiIk7HGZm3yrD1UjqC24/Mi5aIwXZJ6FhT
         C1ahlvnQdMaYIzlgv8q01DMAM3otfpJcosrTYo3xQIp6LKOq6Sdxxkqli3nkyx38p+eS
         RyoA==
X-Forwarded-Encrypted: i=1; AJvYcCX7vU4uywltMKXYgJif6gHdE0/TDThXnk9VaNN10DHh/9ZJn0OpdqzlYqzbdwSOntGdc8JhsNxmww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9/pgGRcIiAnx+JZJtBKJOs2E+jBno0WVd0ckzzxD/JoaOzgk
	a4BL8umgVN+ypZY5N9QSgH89xxXbgguW2FTW1Q3aaHS+x3RIAFqo+7A3sWUDgyfpF+bXLvpy2GX
	3M+pydRcSEvId05EyhaTqsbJcrIv/5Ew60VUKpdTA/xoVmiPYqOpRFRGbB2FzpQ==
X-Gm-Gg: AZuq6aJMIEalHAm205RmgGsGtDB+Fwx+Bo3QZtfhR/74lB2efT9aFa5ntRq0LUipbVH
	xtA3i/OEJ4sMnEQBC7kCRFM5KocBIs1W4DoLLeG82hqAHdkXHK7PoKhbWo8ODA6IF67cL2Ux0sI
	4oiRdML1HkntTwClw9UlzpjNWZoW/GoXDBGKPI5YPlthMGxZ6iPBZ9mrWi0zQ4QF4j30up2VX/G
	eV9Z7c1w59DZIaem16Rai5MAix7ruBeISIqrY5Lh/tIVQa6wqhDzqSj/jPpINrgumKxmp445k2J
	UcMpkCekblHQEK1MoBuBtHn/ns6XSD+fYtRBAyrRicifvJZjW6GZpWSGkUeYRzanLtR8b7bmSfo
	8DQSTAM1bbSINJxf2XTnmhzZrPyKMox/vQ8WTHDQvuR/d+jAcRzK+C1eYVdQcAtprX2MUmJWHwD
	hkfjlAcNFJEWi5dhFu2JNPo68=
X-Received: by 2002:a05:620a:46a7:b0:8c9:fb65:7f0d with SMTP id af79cd13be357-8caf058543dmr1408591785a.28.1770600746518;
        Sun, 08 Feb 2026 17:32:26 -0800 (PST)
X-Received: by 2002:a05:620a:46a7:b0:8c9:fb65:7f0d with SMTP id af79cd13be357-8caf058543dmr1408589285a.28.1770600746057;
        Sun, 08 Feb 2026 17:32:26 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b623668asm21688601fa.3.2026.02.08.17.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 17:32:24 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 0/5] media: qcom: iris/venus: fix power domain handling
 on SM8250
Date: Mon, 09 Feb 2026 03:32:15 +0200
Message-Id: <20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB85iWkC/4XRS27DIBAG4KtYrEvK25BV71F1Qexxg1TbCYNRq
 ih37zhZNIta3SD9MHwjhitDyAmQ7Zsry1ATpnmiYF8a1h3j9Ak89ZSZEsoJqSVPOSGvMC3Ih3T
 hOHplBR+C9qACtCa0jO6eMtDp3X3/oHxMWOb8fW9T5br7n1glF/zgtAVwTnnTvc2Iu/MSv7p5H
 He0sBWu6hdTYhNThLnBiJ7KbOfDBqafMbOFacJaMUTnwbZDcBuYecbCFmYIC/TCKEwre6/+wG6
 PgWY4L/Q/5TFVdogIfC1KZd9McCmvY8QCmepvP94qJ+HXAQAA
X-Change-ID: 20260131-iris-venus-fix-sm8250-f938e29e7497
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2425;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=67IDexaWLg3vptMF3hQy2WAlwLpBGtXoefLsLMJT6KA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpiTklUbnaPvibNxrgi+8RGWZgRaa1HIpje/c7S
 mOQzxfHDwCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaYk5JQAKCRCLPIo+Aiko
 1RXFB/sFWiDDzpfu8SYQBb6v+UxGfY+7B8kI8+EAFLMkmkX2CGk4h5d52FKtglS2oGrnPOWPj1J
 Y1v4WEt5ylPYJhHFGePTJvqr0U9K9Hi+Dm/FcfyV7I3CZzfoGd53F7TyN0nv5I9JYgHeIF418+I
 BfQewWLrAAlRH5OlL9YlbEGUpo0FhBdARjtF95UkP50NtbicxuaGRO28Lk9AxFFcDYEFnjJmpli
 jGtDWaTYWn2fId+g1PQUTqWjMyQnxKB+DlADNZR/oB57uNxnBxGA+2UszNRiaH1MUKxMpfWOJNr
 gLM9yDFHpJthiKFEG1pZ9gTHwZT61vg5HBZmd8/TIIBExiao
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: -tghen8g3WgjU8ixqZSE8haGG8lUWVtG
X-Proofpoint-ORIG-GUID: -tghen8g3WgjU8ixqZSE8haGG8lUWVtG
X-Authority-Analysis: v=2.4 cv=F/tat6hN c=1 sm=1 tr=0 ts=6989392b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=cvYA71F9yvrgsMZaK7wA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAxMSBTYWx0ZWRfX0sXAGeNH13q+
 8HE/igbuLpGYgkltUwzB0jvEC5MwK4SP0HJ3fFhNEYjx6fmnScSX8jtNxw1F990f+i5uUShk6eo
 lklcTXHE4i2KXcQ/2jsNNVu7JWyMvz1Vs3PDugJcIv5IUqupMfhFpeIiF1DKIz+ytWHqYMLlDE4
 k19RkTk5u9Nnz40rhGNRNhy2oBYTKAOU51L0LBUmlCo+VmmbnpspI8LpJ3qbLtJmTSgeUV8RkVb
 +32DZVnT2Zk58b2OqSPAE3lQH9wK0wTBsfnnG1wIQZlseaFEoROx4s1I+AMwEonrXc/79z4CKDm
 n0QXU3hyOID5/Pp4Zisur5tMPC4E1KKcFZ3e/QySRrA1/uuP2I/WGyxMOWQhoseKsygFVwWg7QZ
 WgP0dnNJHUm4WFeW+jBh0p1Y+1G3AwubaOkkbObbAfDdTJQYZKVo20UhW1UbTX6t2xcxT/dmWL+
 Ay8flK4QhW8QnblLnuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090011
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
	TAGGED_FROM(0.00)[bounces-42300-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4647B10AD20
X-Rspamd-Action: no action

As pointed out by Konrad during the review of SM8350 / SC8280XP
patchset, Iris aka Venus description has several flows. It doesn't scale
MMCX, the frequencies in the OPP table are wrong, etc.

Let's correct the Iris/Venus enablement for SM8250 (unfortunately also
stopping it from being overclocked).

The videocc patches (DT, DTS) can be applied during -rc, the rest of the
patches should go for the next -rc1.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v5:
- Fixed maxItemx -> maxItems typo
- Link to v4: https://lore.kernel.org/r/20260209-iris-venus-fix-sm8250-v4-0-9662a0471d82@oss.qualcomm.com

Changes in v4:
- Dropped MX voting by videocc: it's almost-always-on (Krzysztof)
- Restored minItems for the venus device, preserving the ABI (Krzysztof)
- Link to v3: https://lore.kernel.org/r/20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com

Changes in v3:
- Dropped applied patch
- Fixed typos in the commit messages (Dikshita, Konrad)
- Corrected MX OPP levels (Dikshita)
- Switched Konrad from Suggested-by to Reported-by (Konrad)
- Link to v2: https://lore.kernel.org/r/20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com

Changes in v2:
- Fixed example in the new sm8250-videocc schema
- Link to v1: https://lore.kernel.org/r/20260131-iris-venus-fix-sm8250-v1-0-b635ee66284c@oss.qualcomm.com

---
Dmitry Baryshkov (5):
      media: dt-bindings: qcom,sm8250-venus: sort out power domains
      media: iris: scale MMCX power domain on SM8250
      media: venus: scale MMCX power domain on SM8250
      arm64: dts: qcom: sm8250: sort out Iris power domains
      arm64: dts: qcom: sm8250: correct frequencies in the Iris OPP table

 .../bindings/media/qcom,sm8250-venus.yaml          | 11 +++++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 36 +++++++++++++---------
 .../media/platform/qcom/iris/iris_platform_gen1.c  |  2 +-
 drivers/media/platform/qcom/iris/iris_probe.c      |  7 +++++
 drivers/media/platform/qcom/venus/core.c           |  7 ++++-
 drivers/media/platform/qcom/venus/core.h           |  1 +
 drivers/media/platform/qcom/venus/pm_helpers.c     |  8 ++++-
 7 files changed, 52 insertions(+), 20 deletions(-)
---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260131-iris-venus-fix-sm8250-f938e29e7497

Best regards,
-- 
With best wishes
Dmitry


