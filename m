Return-Path: <linux-pm+bounces-42305-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMSyFLQ5iWmW4gQAu9opvQ
	(envelope-from <linux-pm+bounces-42305-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 02:34:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC3B10AE14
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 02:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 759CC302BDF0
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 01:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17E2D5A13;
	Mon,  9 Feb 2026 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S7Uli7I2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OzG3Fzvj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537702D3A69
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770600765; cv=none; b=PA3jk5hkuELhpuNnycUYXAxcD8DnwsGgcRrX6P3/9yKMDlH5qzLVnf8DMcuhjvnghtWrkzOSpiyRywzqiw+LNKSicd56/ZNApqZRSiTPQhL0BqfHT6WZObcxSBelOVgoZfo9pjbhi3l8huS6uZuuNhqIXImZHInzTy8cI3YngR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770600765; c=relaxed/simple;
	bh=AguPyjryJFtRx2eaJbYNMbx1txjYcA3Blb6q3wboAz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+OgLpYV2PBVYoSlIr1HbHgY+BJ/oGPMrK2dp/R4LkJyfLoJjZfp7uWqmHY7Gm5uJ+Fxaa1vCVGJmHPdZoIT8nqNf852eejqvh4NLN13oDd3ZXMVdzpXvcnQZX9rRscUzU+4ls9GW+lDe7E86qlywUhNpocMWNX4BL+44dr3zGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S7Uli7I2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OzG3Fzvj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618MF7sN2968270
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 01:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+rRlQKJisATzVZPJyVOcJXS8qbgH74hMR0xOPMwnDPw=; b=S7Uli7I2MnVM6IDl
	R9gSScAmQwZQxBYikujVR6fv+vr1VUmkoiTmujEu9nWROFhS0JI/p2vOmhuh3Mms
	RN2WWRgIsbjomptrDrm5M/ympN3Dz/lID1m9/p+qEQ2PdYR7ze/lw+IVwR9MiGsA
	0PPQ50KfXZKumZHwSb3qQbEH2mcrze2S23t5T7hUdys67TUjIXcKsdnudw7Zp7++
	J1jNsHO4DurhkZQ91CFU9EPIMFTjgn0SgQDbr8Fv1wqiY3rKgwwf/hU2M5Z54Gen
	mGqVeUPPRfezqV+jHTIhc/FWeTXqOUgAlP0DVOeFeX6k2G09Ka2XlAkZy7Ecb65Q
	KmE+zg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c6g659juk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 01:32:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c538971a16so1062976385a.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 17:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770600764; x=1771205564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rRlQKJisATzVZPJyVOcJXS8qbgH74hMR0xOPMwnDPw=;
        b=OzG3FzvjoabiJG7I8ZzpyZ+dK2nhE+85B67hM9CM+rz65ckW4+KX1eMhP5IVzjj9MA
         Vru5Gvwm3umzTGBbmgx1npooO3vvWWbHGcIV4yPcj2wqO43jEb9FAJsSXXW0nct6U94H
         fom/aosvDfVWug5YqviPtiWT1EMPLW294aqnHvkXJvWhAyslgG/3Zb2HgAb6DbWTHtJl
         1rdyQRlxlgrY4V1dRmS9ktx9LS8GnB0qCHE4/XB0tmKbwEBTGPO5lL8oL2zr0gdGsahp
         ryrYW7XpY7KX3tcNmFn1RcTvbZVSvDqugJfj0Syj7U5hAu/soEqaWjSmygs+Ccesco2c
         swLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770600764; x=1771205564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+rRlQKJisATzVZPJyVOcJXS8qbgH74hMR0xOPMwnDPw=;
        b=b0t5EhJxhr6KpywLzXm+hJl43DQW/XRII19Y913QcFEKfONf8OiJbz87DIMARXRL0J
         he3p46w3up8SKCVuEUEjjkFa+g3cqGJGBdaxy3FXlehTioO4B8X0/2ZzusRY9IQqDJVB
         2wjBFZGg9/dBi4F2L4hvJEDL9FsrMV6erg66JJ8WFSqBIew5p9Geg7/Z9vyRw2562QBn
         1hdF1jHGiZM+g1mmZGOcybqUFVgunKfBIR0/cYd/alir80b8wbW3ulHCsoo7Z0bs8jTN
         SPa+H2A5Phgj4W5Y89jr9IqmhPRBKLGPdfRd7tHV/UPs0eVvM+5evZhPMo8Gagu/C6gy
         zoLg==
X-Forwarded-Encrypted: i=1; AJvYcCV4cPFHTp+tZmf3IyggqgQb88aISMgXTYmm+9ZKwU9dfs090OO2TbDUURGGyi2X55MAoTzEjGOkAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPm4PGXfY8ch9rlh99oC2cdXrKRVRYxX1oRPNpWsQKgkNg8fT3
	yxhN9fJ3CJtodnEkUIe6spDhVuhlMbH3yGiYVmrHP7hzBzFeklV3s81cY/4LafP1c+gbB4PDntD
	1s/aYRFu20k9ARFsOWeSMI5ZIeCXMUA8yMUJqXlK1OHUgCeAzeto96GCqB78bMA==
X-Gm-Gg: AZuq6aK4nsUAfndu4o8ba8Rq6Eg24a/7EdEa2aGI07oFGdsnDSljYbd9/0PqvEqt80B
	4FZ7Dc4LLht6GHkOVy06FhOwaP6DTuvG9g0ZBmjo4BYFxjYNQCOZfM5xLKg7pn7p/Ued3S3Pk8Q
	RF64reGBQ23hvaokeLwlE/ocPsPXkqd64lXocm6vPwDTziyLgAMU0a80od7sI/SbTtdej316RXU
	Wo6GwZdAnCC8BufhadTWhMeZ3RRqs008d/in8mF8IZYF5StB8uVfQ1TvMy01J5hy5w2xSW0M9sC
	ya6TXv3HJd+LJY2598xYJwCNOC1ZbCiInv54K/T/F6jFP1Z/zUKQXPcs5U+hbQtHoTKHkVZgX/p
	xOVGE3UdrC9jtUoqeOlIRIUcAkZiwaPq5LKrhuQM1vM3hWlFiHVXU4vgkifRs4sAj3wFjZSDSt4
	dlgs1PbC59NyIRvzOG4aP8g6o=
X-Received: by 2002:a05:620a:45ab:b0:8c6:d398:4a76 with SMTP id af79cd13be357-8caefccac74mr1222188485a.2.1770600763828;
        Sun, 08 Feb 2026 17:32:43 -0800 (PST)
X-Received: by 2002:a05:620a:45ab:b0:8c6:d398:4a76 with SMTP id af79cd13be357-8caefccac74mr1222185585a.2.1770600763392;
        Sun, 08 Feb 2026 17:32:43 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b623668asm21688601fa.3.2026.02.08.17.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 17:32:41 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 09 Feb 2026 03:32:20 +0200
Subject: [PATCH v5 5/5] arm64: dts: qcom: sm8250: correct frequencies in
 the Iris OPP table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-iris-venus-fix-sm8250-v5-5-0a22365d3585@oss.qualcomm.com>
References: <20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com>
In-Reply-To: <20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AguPyjryJFtRx2eaJbYNMbx1txjYcA3Blb6q3wboAz4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpiTkmJsL4kleC5vw4uvTcTGmVWfWCZLGjjZJAm
 eOUhGQfU3+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaYk5JgAKCRCLPIo+Aiko
 1XZpB/0RO0lLZwrCkx22/CU5SlJtM65S4vT7oHOjMXUyOjBg8+OI//S9ks5ykJuxJS0C/AlZkhT
 4f5z98h26mP7WtTcbQaBn25g6jI8V0YRwHdITbRCsKR7Z9KLvXpcfVNxhCUADKlBrNAnq18jxsw
 EFbc1B0xK3dy2UqpV/6TaCMzpNjXrPl5+DUxjim3c9Nek4h+59d3sWXWQIQMH1hDL+VP2/077NN
 d++1fXxwLxqpc6p0XhJnpAvqgNYJdOC0acn6F+8QJ4ucAwWBMHp6fHpBxJueQwntQCcPA4eQqYJ
 T+sMens7DH2nCftZZygSnWlt2DjRfDkRh30c24HODBAjBM7V
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=GqNPO01C c=1 sm=1 tr=0 ts=6989393c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=EQKuo8RqpatckOKiKW0A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 6rtKWBvjpGON9s_JQuq3uglDXJGxwTaz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAxMSBTYWx0ZWRfX4kTdoRrZ+eKd
 uCYjaWzVS5MUhhi9/nrUIJo8ld7o0ViA57GWG4upyYbwdWVbl/FwYIjvMVpqsQM5TpyGBLneaFM
 m0GNZlml4aVP44DYhHVhJ3sYgbD1jCl0Frz7RfBhiGcJTPkOkle/PeOHqCfPqfq+I5tYk8E6UeV
 4WRcydQB3gx8SysKwQdVxKscuMNXFwAnXz2bjlAMAzzcsAR1LSSEXp+QQlPRAmGyq8inNca5Bc2
 qT3SajUDl/npvlV6Ohyadrtl12evnYg+6geKQam2VeUxlNF4JKX/1Ml15QPUx5Bi3IT+AHWBSVD
 T/9QK+xR5jivm2Ex83vqySZ8lCytxGdesQdBfM1uvJ4ox64NZybvZYDC49Y/BJgToqQeAvSIs66
 z+IVldmsBt2SyL7uUBZZZVgzfrLW+di8RcRwlNTFf7rFUnWi5piZt/427HNOiriEOJhqQeH+HhR
 /MZPN2JaH0tjc+0C4xg==
X-Proofpoint-GUID: 6rtKWBvjpGON9s_JQuq3uglDXJGxwTaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090011
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
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42305-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,aa00000:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BBC3B10AE14
X-Rspamd-Action: no action

The OPP table for the Iris core is wrong, it copies the VDD table from
the downstream kernel, but that table is written for the
video_cc_mvs0_clk_src, while the upstream uses video_cc_mvs0_clk for OPP
rate setting (which is clk_src divided by 3). Specify correct
frequencies in the OPP table.

Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a1ab8c3c27e6..a80defcb29ed 100644
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


