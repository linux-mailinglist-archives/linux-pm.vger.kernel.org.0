Return-Path: <linux-pm+bounces-42291-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFXkJYEiiWn/2wQAu9opvQ
	(envelope-from <linux-pm+bounces-42291-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 00:55:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95B10AA29
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 00:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A82213008215
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171D3859E7;
	Sun,  8 Feb 2026 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpB+IgQQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aYSysiOt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57D43859DD
	for <linux-pm@vger.kernel.org>; Sun,  8 Feb 2026 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770594943; cv=none; b=MHWB+Pat0NwkhB51pq7GtHCWWo0T25n4KvVpVpVwCad6c8y6S+GPAdoEBp9OvG2lfhBCxqYHgWQ0nNqkKL9HUBn73Z2klvRMgTURRrtaRZyvh4DU0x6cBl0KvjkAO5w8UN0BrxBC83FCNOmrUjyPaxWvU1dfhy0bsipI3AICXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770594943; c=relaxed/simple;
	bh=QHhMVC8Ba5BOMF+mfpbI2ACbKzjNYug4cucxI+TmuSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GbIuubXIYDfdBEnG1TZVR2lCdyrEL/yccvjsOo0io2j0tXh8rSP0U5wDQrMMr99PojIWGZWU7sHLr1d7T0Dg6oJBHcb3Dd8zH4Illeebq1sQs4Vd6TGaWZBUtmFgeAPVHaPVariZCNzAjqwRE6XctXAcJ/88xehSRuZQobylxng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XpB+IgQQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aYSysiOt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618ITxiF1927738
	for <linux-pm@vger.kernel.org>; Sun, 8 Feb 2026 23:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WWrIAGbD+swm1Y8eE8Ndqc
	BisV5nldwTY2Z/dAcM4aY=; b=XpB+IgQQCZTHrwCL/2TI3CL74zFK5LNM2vVMjV
	WPQb0R9Ji2YrmvTFEQTiCLXOVAuvtxBUuPxa1s3+VxOCj3/NSnI8X7OfnIge1Tvu
	FjGTASuKeUP8oitdWFATbC4G2mwx8awXWY+ZyFqf/xQaw06EAsqL4880aT1mGsU/
	qAf7QXK9SNdPBig5HwqSTmGMy2OAebU/ftJrxqwzS2hGGOiOb9R3QNOcIj5zwDPG
	gQ+gtudoq5I2Pny9ALTsSxjOn9dqANzvyJXFHaNBQT3D8vNNMwD4rSd6oXimnvdT
	FGJp58G9NPL82WwYbPb/X9+Fs7KZHAXnkTxtNJdFMnGD1Krg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xb534h1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 23:55:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70ab7f67fso1118847285a.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 15:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770594941; x=1771199741; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWrIAGbD+swm1Y8eE8NdqcBisV5nldwTY2Z/dAcM4aY=;
        b=aYSysiOthVXhgu7fE1lvlGcdaWI8hC77RvAlx6Gm3OfbCJNmZWHtV0iUhx4oUcWlhx
         w4cHNNxHaGtL7xnN3B28vbB3WzSUA4wGv7iSLvha+B23UlBoC9goyGdn6XLDI+FzjbkI
         IwcdmFQbQ0+XRARcI+9zjVobbmSW2BieOHOJLXZvv/L78eZ6BwDXqpTIRGGADNzylHCt
         X65TrxKfROgf9b/wH4xNulmnB9VbGC7l2xEES9yMDq6evFd+gWI0Lc4eQIYuOsz9NXTJ
         qvMntbWi9BfxqcbaUSzekde5KDOyY12uZDPyk43uJvMQNc5+TjzM1ts5FByD0TonfDwJ
         CEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770594941; x=1771199741;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWrIAGbD+swm1Y8eE8NdqcBisV5nldwTY2Z/dAcM4aY=;
        b=mLn9ZOY9JTObV8Tb4gXraUwp9df6ggb5B0e00pyGGfpcehZuh/LuMfCvAYWSY9N/qJ
         WDm+X2jtBP91B3z5qDXkZJK68qKDpcvrU6DHMVdbd8Z5/03nMCJON8JoNDY4IrMEQvKh
         21VZitUQD5uIsqqc49JcI0NDEUpWyorVCkBPKhzUkXJgOPi7ie5JySz2OakiY6Fa2L2k
         //51Twi8WgpDMvZcg5ByFt5mZI/3dbGKLLcP4CpQByLeMaDPTwOW+CzuW7QwMlBpqhqz
         HoDMqghfyWE1/8O9Xv15L82+ha2BhFAXcPpWOCLboXaetNshA5A17hiTvvgNdeATl2i+
         xA6A==
X-Forwarded-Encrypted: i=1; AJvYcCU9HGYbLsO9ezXeYr9YKJqf+ixIwc+W/T83eHeSyEv6IQ09egUSHE99YG63mH1qyNoYXndBR07IEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNYbOT3+ywv+4Do05lWOAO8p3dOghjFGbcSu3SGqGVhs3U6ZC
	fAD094avvEJs8Yy7OvKNKFyz2SEoflG0zaOUyJLt5ir9xTh9PE7pw8zFT3WQ0IAxXSTn22B65x3
	fHinGnpUEE/B2UBdn3CMJGyWSfRYt5eNcP+PeM5vnwV6XQgCsLw7QEzX6i/kUUg==
X-Gm-Gg: AZuq6aI6uCc/AGxVTpFsUpVCws4GOtOry+sWxlFnYDlTOwtyw6IY9ItNhp9vhiZav37
	KjuNLt+isNJdtFGOGkW5HeDq3tJM6G1IsnpxQez1k8H/q6ifiQua1TsUW1fVnhMAF3gZSuVQ3ng
	T2ONCF759rAHo5EFIpvhRBzuUoN/4Lxq8ttgvGI13ITT3hmpCYiSBflcii0e4R7tU0nFGQALWRt
	JynKdgLeo3XAcMRKjiwv2KP7odtH61ZBCBZF+q2/I9RUhSV41V5IddGqEQIgMzowEgAYkLUAeYU
	LUCpk8yqkRpNvnT7sCLamWVZDniVk3nb7ppQbLxNu+Y2yLw+9H3OLS2WUCWww5A5rT7xgrrcE2T
	NFgtj6sRvd8CtIE21TffuirwuthpErplGwfWhVKjqG28yzGhc771bVYU5DgitUfGtqh5LRq7het
	E733122gxboo715C5q6wUpze8=
X-Received: by 2002:a05:620a:4728:b0:8b2:ef2d:f74b with SMTP id af79cd13be357-8caef7e772amr1312215485a.29.1770594941095;
        Sun, 08 Feb 2026 15:55:41 -0800 (PST)
X-Received: by 2002:a05:620a:4728:b0:8b2:ef2d:f74b with SMTP id af79cd13be357-8caef7e772amr1312212285a.29.1770594940463;
        Sun, 08 Feb 2026 15:55:40 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6ee4sm2188074e87.4.2026.02.08.15.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:55:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 0/5] media: qcom: iris/venus: fix power domain handling
 on SM8250
Date: Mon, 09 Feb 2026 01:55:34 +0200
Message-Id: <20260209-iris-venus-fix-sm8250-v4-0-9662a0471d82@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHciiWkC/4XQQW7DIBAF0KtYrDspBowhq96j6oI4Q4NU2w2DU
 aood+84WbSLWt0gffi8keYqCHNCEvvmKjLWRGmeOJinRgynML0jpCNnoaSystUtpJwIKk4LQUw
 XoNGpTkL02qHy2BvfC/77mZFf7+7rG+dTojLnr/uY2q63/4m1BQkHqztEa5Uzw8tMtDsv4WOYx
 3HHh1jhqn4wJTcxxZiNRh651g3Ob2D6N2a2MM1YL2OwDrs+evsHdnvsION54ZWWxyLEIRDCWkp
 l30x4Kc9joIKZ+7dv6veefooBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2267;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QHhMVC8Ba5BOMF+mfpbI2ACbKzjNYug4cucxI+TmuSM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ2anUtVde48/n0W25PT6hJ57pR5mo/s8svDBIdPAxDcnj
 sRb2RzsZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBE2PPY/2fFBU+SuP3+iLpw
 hY3/jH2GJ4UnCJn1vDm/dOmWXdeMLDLLM+ZySW794mEozThVdedsG4eK9Gob97/5L3/NruxU/xe
 4sTyhcvo9pYvFW/X5n/sE7XP91HghuPTZ43l7XjNeVvFcclHr3HcXU6HOwGsuHmWVkxeu4NCVur
 5XvlJnXWJecWlUwul5iux9l06t8YuxbDVI9zAr9951OMRpT1qWQZNLolAxs1PmTV21Cfc3hVxjL
 H98wuRJ+Blv5r3/dmZE75uXvPtzsfeHLjcZ3qfMFQduegc7Lql8UXrs5fmHiq+9Aj/338qKC+kt
 2b9JTzSwPuC+dFy81Xr+3MhDL2S8KhO35/PyCP68tSsOAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=QMBlhwLL c=1 sm=1 tr=0 ts=6989227e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=cvYA71F9yvrgsMZaK7wA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: tYyc-SNRihjU1MiOlzowtdgx3O89I3W1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDIwNiBTYWx0ZWRfX5RrIyIO0Bi9d
 bWcIxdam38mtI9WSf4stoW8sYIdocTlUHcvL7jfWpMjjZUyxA6cJOMVC+unc26cKxvPxtSLTxbb
 XQRqflRgG1obqxSxn0vXCdGJJTAXChH6jzD5y0zy4MspodnQ4onVki+EghDuCQSFs/GjFlQCfEl
 kKUseq2mEUlI8M4MiuVuNX2T7A7/BQJFTio3JbK4Ld5MRu70Jb3AZc/m2XH0jzw+JOGdaemHmf6
 rgYK0xUkTdqP2F0hFqePJEAEj7IyF7PVu9sndb5G+jWx6GlEpbZP+COWKF9Z2MBXQzsOr9dLX06
 pm0Gv8at5VhC7l0izU5nZR4HaELz719dYFzn0DFWXxtQ/c05P5c5reJvoEnMfMr/ZEvuEMgDr9x
 peU8Sf7KONYEzOJ5jT6lbPU4fIL4eyZW1VsHq/vm86WStA1yeTV+vOsBS2gmybStZVft30au/K9
 T+7rJSA1Oygs0x9cF7g==
X-Proofpoint-ORIG-GUID: tYyc-SNRihjU1MiOlzowtdgx3O89I3W1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602080206
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
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42291-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EF95B10AA29
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

 .../bindings/media/qcom,sm8250-venus.yaml          | 15 ++++++---
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 36 +++++++++++++---------
 .../media/platform/qcom/iris/iris_platform_gen1.c  |  2 +-
 drivers/media/platform/qcom/iris/iris_probe.c      |  7 +++++
 drivers/media/platform/qcom/venus/core.c           |  7 ++++-
 drivers/media/platform/qcom/venus/core.h           |  1 +
 drivers/media/platform/qcom/venus/pm_helpers.c     |  8 ++++-
 7 files changed, 54 insertions(+), 22 deletions(-)
---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260131-iris-venus-fix-sm8250-f938e29e7497

Best regards,
-- 
With best wishes
Dmitry


