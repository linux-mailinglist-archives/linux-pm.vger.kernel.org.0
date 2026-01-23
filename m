Return-Path: <linux-pm+bounces-41380-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJGaCsCsc2nOxwAAu9opvQ
	(envelope-from <linux-pm+bounces-41380-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 18:15:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA8578DF9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 18:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44C60302262C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ED43090D5;
	Fri, 23 Jan 2026 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7smWXYh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vh88lI2T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83330C34E
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188390; cv=none; b=qjYzR6NbJizl+7S1MOVpSZ7WnHARIaYSkaa9r/XU/eYEBalQqM5PrfNc5DvEzzMPGOVL6Ji4eao+Ab7/Wn1LP/3nzP8z01V0A3BKGt28OaaDF94cVloojM/feD4wjghmkyH5WqW82KC0y49oaW/+E17BH9/trRSo4yBpnyl/p2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188390; c=relaxed/simple;
	bh=2Z6xwhKJk/Agr/Tfu+uZyoFFVZqx8Bbb+H//Pozkx0k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A1ZhvOWGmd6K82Y/2mFNhcWS8ccjnOnwm/Du01spyfNWaboZhxQ7PVEHnUHHUhQyx/v9HsA3CGiZ89qmW9pN217lZTPWcKPtlfWxtXJtzX+a1z3+a4ImaHxm4sCSCEHl9uO1Bqd0hJHsHYXjPBqJB61nJTiOmPsnGzTNpqMeGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L7smWXYh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vh88lI2T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N9dcQA722389
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ra5z7RK+ckZlI54IIzTkyl
	AtFlnUN13RpB+yLrim14U=; b=L7smWXYhklNSX6Uyfo7p04dCDlDokgv0TYtTSW
	Fa89VFxtpWoDrB6iLkH798WDB0dqjNX4jQr6Ql+mEJgfKF2m3+PufwuCSRMT3CCk
	1pI6gEOyWxpVBcLLKfH9tbDuK0WaD6cqe0a+yHQrFJQIkGonMjqODVA9hFc/moFe
	9rI3LRJqR88/vJ+pt3E+EYUCqt7O5p0RmhaQfA0up2i+ruu3zYtaB+HVFSK0nhai
	DicmMU4MB57v2p1R6nMpEHewmw1uEhIZoJ5JQb+rog5/KxdlXzKH+9BtCg0LL6bb
	z7zp9am0C+9HV13CXcOnF7JjwFyjerJrplluySXp68TP6T+Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv069jx3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:13:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6187bdadcdso1393396a12.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 09:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769188387; x=1769793187; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ra5z7RK+ckZlI54IIzTkylAtFlnUN13RpB+yLrim14U=;
        b=Vh88lI2TKVziZjWIJCk7AwVbkUlRN/hg2L11veYIlj3oc0zPFQE0NqL1QrHaQjWTIf
         lNNjwIZDw9eRNwXhAGvA0Ta32w3AU4PgJeS3qNK7WfRkVMuRSr0l5xYb8ImoZcm0ZTXC
         E5pNh1OA52iodMHv9Qq+oIGe5C3g5l/PcA0kc8NGh8ikO7hqU3X2Z1nOJLC3wWnyqONX
         QEQa3PepKLpc4JNawYnFbDle141jhCM8G4lWxEQ8X3j0RP1DFy9cdbM6LISGpmoJ3svk
         mubqad00WGaJuFDpqBZevCi/QB2CeryPxvyZ0bHBN0p1B7hCFWQSqhr2/GOesweoKavs
         m4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769188387; x=1769793187;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra5z7RK+ckZlI54IIzTkylAtFlnUN13RpB+yLrim14U=;
        b=Z0jX4Cn5B6qfalPDwDLl6/zrnQ6cVZ3+T9iM9Bl/2jTKhBVKD/6XpxysEa08vHkuLW
         opi9rwEc8FFCn5MnQmfervrPlrqcJtp/4IkriUZt7VCsip5+3f6XQQxiKq5dTrBYr08Q
         DKY0rQ2Y8mzBs0baXVEUkpWwRjZQMH2QBgYJbnR25QKMbr9FRg3+ORVkDQVWb3+6ehkz
         MtwbdNZAI7zoushvrpmAQQ2DkN4aKu0+uqkwygug8aQK99bXjViF3TQwZbtVaHnW/SgB
         Fr9U2M41kuTN0XBo+xSSErJwQgjx2tb3jPIelxJjlwXUuMlqL40q38yjND+95jLtnWML
         Rs/w==
X-Forwarded-Encrypted: i=1; AJvYcCVI87CC6n1ZL9BnTL207XiF47foOebzwTkTK/nHXdmyTaPWjnkYl40cG8/ctBEc8W8NcJ6hhXKohw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3KKdxSPZyIr3WYA64sFWZ6YBjYDIIZi1znDkmEJGpMg+7wR0
	/oX7nChT2fW0OUp2R1CpFEo5/pDoOuUJZCwHl2ZmplnC57oYiGa/uIpu0Ecez2T52rm9Fn2PtK1
	Ch8tpeA/iHLFxQy8kQ7SSNuEZejSKyjsaA25i+BWbbPpt7N7UaRHG4WDlCQn5BQ==
X-Gm-Gg: AZuq6aLbhLsZHpxsHnN+XNLR5W0Te0VPcI2gJ1yqR11km7i0G20uU7JUhfcOXdNmCu+
	O3mLoR+Fk7Qc8yWCE6iIVorhpBatOdRrRHtXhvHSEdZKSxjvA/Fzb65b/V2dTK9UyVzslx4askP
	0jVwVGu/iw4qYjiXC5vYLNC8gHMz7mHzOjFEVqpw7B1k/4J1ObDvyp35Y3LyqRPAlWgQVOOu5CL
	2hqu3kGBKPMVjKImIva8/dvYEdbJYisc9O5oIAOILAPgXit7pZkvvxqwAdsE/ngmMyQhCA4/yB/
	WHOPytiCU0X7J8tMU+iZyHTDszFOnXpXaBAf4HDWGRnQQHt4/l5ZejPoQheQgW0IXm/HFdl2djM
	WEMeTVTSWsJOrWyhHeYTs12frgpH2FhJA
X-Received: by 2002:a05:6a21:6da9:b0:35d:b5a1:a61d with SMTP id adf61e73a8af0-38e6f713dc2mr4242086637.26.1769188386731;
        Fri, 23 Jan 2026 09:13:06 -0800 (PST)
X-Received: by 2002:a05:6a21:6da9:b0:35d:b5a1:a61d with SMTP id adf61e73a8af0-38e6f713dc2mr4242051637.26.1769188386227;
        Fri, 23 Jan 2026 09:13:06 -0800 (PST)
Received: from [169.254.0.6] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536ef9ddb9sm1191358a91.3.2026.01.23.09.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:13:05 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH 0/2] Add interconnect support for Qualcomm Mahua SoC
Date: Fri, 23 Jan 2026 17:12:34 +0000
Message-Id: <20260123-mahua_icc-v1-0-bc82cb087f1e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAKsc2kC/03M0QrCIBTG8VcZ5zqHkzTXVe8RI07O8kDO0ibF8
 N2zQdDNgf/h47dAspFsgn2zQLSZEoWpRrdpwDicrpbRWBsEF4p3gjOPbsYTGcN2isttr5TW/Ax
 1f4/2Qq/VOg61HaVniO+VzuL7/Sndn5IF4wyVHA1KlKbXh5BS+5jxZoL3bT0wlFI+mxQKsqkAA
 AA=
X-Change-ID: 20260120-mahua_icc-76054966880b
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=eLUeTXp1 c=1 sm=1 tr=0 ts=6973ac23 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LGNSbPc2IrT9O9NjG_AA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 1EbOr2KPTh8MmTBn9B6v8BtsKLIYIbr4
X-Proofpoint-ORIG-GUID: 1EbOr2KPTh8MmTBn9B6v8BtsKLIYIbr4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEyOSBTYWx0ZWRfX7wB59H/04yer
 BVovVCN8f2dYfi4KyvYemG+3mOIBhxSY9kMF4Qh4WOO2RMV7z5ETaeyvMUIFlJRetMKZ3slSCKw
 aRBMH1RU/QYz/7NQ+adgb0xfXhxjfYP9SON9XHUCgtYWkfN8jaEsUtGZTEHEUteYgYRtc3R6pT0
 4KJgNHDyGGKQcnEc6orKJ5lhhKz7LtfhHOEPVE9zxSd9CT5APY57+F9vS03utqhCReEEYa3WNxw
 rRmEMhDWa1mrqz6H+jR1/jzlZJmViHsReBhvxvxt32/SMCJPCpyNNVVtkg4X9un+qlOzUXUOB/3
 0nXqddWJS0i9LSFmgci2toe0b18b8xIDfOQt/2ZWocoD+a1OhAnFaOwEZgtxJA5k69CndHlEZYF
 /TcKS0qy5JPdAIv0jZJG1vx2i4JZiDlKCGmiOOARWdTJKCnO72Bkh6bFbpqJCmnLqGD4hATASQU
 A9qFJBi3JKZk6ZnVLHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41380-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[raviteja.laggyshetty@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7FA8578DF9
X-Rspamd-Action: no action

Mahua is a derivative of the Glymur SoC and shares a significant 
portion of its interconnect topology with Glymur. As such, this 
series extends the existing Glymur interconnect driver to support 
Mahua, reusing common definitions where possible and adding 
SoC-specific configurations where necessary.

Device tree changes aren't part of this series and will be posted
separately.

---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Mahua SoC
      interconnect: qcom: glymur: Add Mahua SoC support

 .../bindings/interconnect/qcom,glymur-rpmh.yaml    | 132 ++++++++++++++----
 drivers/interconnect/qcom/glymur.c                 | 153 ++++++++++++++++++++-
 2 files changed, 261 insertions(+), 24 deletions(-)
---
base-commit: 6cd6c12031130a349a098dbeb19d8c3070d2dfbe
change-id: 20260120-mahua_icc-76054966880b

Best regards,
-- 
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


