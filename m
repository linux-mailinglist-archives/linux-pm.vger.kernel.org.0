Return-Path: <linux-pm+bounces-43293-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB5ALm2PoWlMuQQAu9opvQ
	(envelope-from <linux-pm+bounces-43293-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 13:34:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B511B7268
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 13:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49D8C30C268B
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 12:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822C03F0764;
	Fri, 27 Feb 2026 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dWX2TrUi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RHrLsvXH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF173D6693
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195603; cv=none; b=rNH5mtHpV9zHUts12JBHhAhjD3YtcWOPKtbwacXJOaa2wLAGKFt7PwBsUnwQ74YkN0CZjhYx3aHLXts1UTmGx8AGrSqhcww9Rl2oWKbX9ftHIGZv5cg24rzyMQ1UfHy/V80i4HqCG3HyRo2iOYe25cZrn8CYTLKSBrlicnmnwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195603; c=relaxed/simple;
	bh=39fpgAQ/1XGNSHnsjo05dL5nmsSHjrP2F+2HQZqeihQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CoKM1TZx4fVZzVN9T18JtmN2HPAjlTKyS6uExCpR3rd6uT8vhPSN6hd95XP41Jyr5P8TCHpq/CZI3xO8TjVD8xypQikuhB6ucI6avP3pD56fNc0Z0TEMIZx0HKyC30lyivqm3SsYZmH5xiQUZo8f9uqHHvRLTZ/aI2GZZMwFIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dWX2TrUi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RHrLsvXH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RA0nRY235868
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 12:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HJ/wYTd2RQrpKzUtQ/x5Qs
	tLvSES7v32+woTFtscrdQ=; b=dWX2TrUiC5UkFHNPQ1dGfmA3MloEC/pFQmw2Xi
	CUbqC3Yy6w/X0WXiRCoZupNdkFFVnSOLdHMu5E0LOhxdSb0Qnuu/lbm9xDXRnj8d
	JD4vKWoT8mOmAwm5dGPBVVBdfC8dimHHvoHXPMS//UJgNaSeAi/Kh3d2SHVxEkuK
	QnsXfzHYIgifkGwbxdy8KK5glg0ltrzRBHX2Lf8oNKUkuSG274J6on3SnIBzxdik
	RklXRO1ojXGI7ZeheehAbzLfd0u+arWKhwCgJuqLaL6tU56XmJkc+mM82z7Nehl2
	f0qGnIdiTzBvhPN6P5jf8ctajkB0l218Sqt2qUkB1Da6Zgig==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjx1xth53-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 12:33:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2addb9ba334so20564765ad.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 04:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772195600; x=1772800400; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJ/wYTd2RQrpKzUtQ/x5QstLvSES7v32+woTFtscrdQ=;
        b=RHrLsvXHDpnqW/MY9K+ECsuYdddXfn+SyHnGX27EjsLTS8Ld53uqdHYnOEASwrR4Rq
         L+XzuVi+n2swCAY4OuMBLHVaa2MNl4bYm4cXGlziPmgiIk0tQwH9Bz4Fhv5qW5PMLlsW
         nGBQ/+sygsTBwR8dkoBY0tsSqzmMMscM3umUmcGe0BqHkClngWRbBkMgkED2TXm1Wg1c
         xiagBzupbQxsrCWT4IhqYP0kCzNHcRcm4XyQHMSFPqVWJDeiKeb/x18Mf64dt5rlFX8i
         DJHyZIk8R55YJxLbd6KiDADkxYyT7vrZcm/uSa03iEixZPdYNup32DTL+y+CLsQBJ/uZ
         Gq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772195600; x=1772800400;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJ/wYTd2RQrpKzUtQ/x5QstLvSES7v32+woTFtscrdQ=;
        b=hIEBBIBzKwecDcZgUYlj5rZSVBNMubgmW0hXrqy3/tenrlpML9gEJgAngiS550q0pa
         8no/tNWSo/TDfN835Bq2TWmD0UixiVeLXj+P8AtMSA91jM+sX46OuoN4kjNXzlF8z2ww
         bam3cC9od1/FEIz4wD+XHSEe2JbWKNFgGOEYDTCJ0I43qzKlbi6joKB8Fnt2awRcv+ME
         zhTsGUTsoIgZEyUb8r0lDVn7V8rjOXQ2kDW++4KYb6Ydc4WuczdJD5ydFPQq8Awqch5T
         SCN0vnnREMeHNciJerMRQYmy3PlASkN+mP4Afj4LaSFZBDb3Htl2LDByzdGOH4WrynXm
         EWWw==
X-Gm-Message-State: AOJu0YxRi/ujdpGeVztwc18RLKF3W8TKzeyi8+Tcb/CkKYFE8Ypa0Fcf
	vIxtZYVgidyl389q/6NaDeBEx8iFwBMqdUlOeBkNhPg9ViOPu7tZP5fRTD8l8uC+dRspAONIMuM
	vH1PcusoAbJrDzB8YAiOmxw9JMAtwK3lKoA6XQQwHQFJGeDlD1k+J9LCNBWIk
X-Gm-Gg: ATEYQzz6rOIDfgbk00W2GuxDOnB2bimg0Qs8528V+Q4/BxG/yDjFQ3ZJC3ijAtExfhC
	wim+6MWovhZ4sFqLzJnjHBmUjHuyfuYTiJwEr5POSrJOWA9NrDG40DtmlpULseeBsXf4aD6IGGf
	+EvszuOw6P3mGfJdF69yauvNLqWyqT/2qUzOgLUX+BVed1uNXlvP4XBaTbtUzaog3IuhrvdEmN3
	0jimmGNftXem+lbZhURneCfUzNArC84id0fX8VTAI+rSuZ2XJ96TJHXqk9BbsOUGvIUb1gSCWaE
	/iv9qsYo1ei2y4CQeOQBKKJsBKq2Ouzsb/SolKUo8EMQQ03OARb98geinH4hSC6O5uDopNP6lBr
	dRJvo0J3tufez2d3Y/PIA+48fzaeKG7++II7/Zd9okyb2WLgoXi4=
X-Received: by 2002:a05:6a21:7a8d:b0:38d:ee4a:e82f with SMTP id adf61e73a8af0-395c3b4389bmr2741983637.63.1772195600470;
        Fri, 27 Feb 2026 04:33:20 -0800 (PST)
X-Received: by 2002:a05:6a21:7a8d:b0:38d:ee4a:e82f with SMTP id adf61e73a8af0-395c3b4389bmr2741955637.63.1772195599753;
        Fri, 27 Feb 2026 04:33:19 -0800 (PST)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593ddd103asm5005008a91.14.2026.02.27.04.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 04:33:19 -0800 (PST)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: [PATCH v3 0/2] monaco: Add PMM8654AU PON support
Date: Fri, 27 Feb 2026 18:02:27 +0530
Message-Id: <20260227-b4-add_pwrkey_and_resin-v3-0-61c5bb2cdda9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANuOoWkC/22NzQ6CMBCEX8X0bEktP1pPvochpLCLbJQWu4oSw
 rtbiUcvk3yTzDezYAyELI6bWQQcicm7COl2I5rOugtKgshCK10orQtZZ9ICVMMrXHGqrIMqIJO
 TulEZHCBP2xxEXA8BW3qv5nMZuSN++DCtR+Pu2/6cyvwXjloq2ZosWve1sSY9eebk/rS3xvd9E
 kOUy7J8AJcdElzCAAAA
X-Change-ID: 20260226-b4-add_pwrkey_and_resin-2c04d8d53f5d
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772195595; l=1369;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=39fpgAQ/1XGNSHnsjo05dL5nmsSHjrP2F+2HQZqeihQ=;
 b=aNXFDL/ZfugrF1P2Xb+lN04r10OfC+ESG2faoTtZKM/7JpWxQ+pLVGImIdU2b0r4MKSAhg41e
 GTNDrpxb8HmDCeeIBo7pWmjeJFkhEYgRb0KF519UIRMIya4BnCoMvVq
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-ORIG-GUID: 6W4w0krDq8G8zDw0Vinecw4YPtipt0pn
X-Authority-Analysis: v=2.4 cv=Vtouwu2n c=1 sm=1 tr=0 ts=69a18f11 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hkPachF6C7OTRM8muywA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDExMCBTYWx0ZWRfX0r977WNiS0q6
 Wt0bMHrD/mdF1QApZ6X2k/taJvY3h5XOZRYt+20QouqCM3UK46J5NyNLIMhq3w4hBgLWQl+cKsh
 70AOXc6WlpqAkg+EQgn8msI39i0gKdJkHjEs8rm1qo12UEstUk7/vCUrrFDEIPnffsoMqSBmPBY
 0Ydt+pAdZoyQgqtiOE6KqLOZiTIfpFHiYmhBaIdfJ8smSryY0Vo67k79un5tr8ATdnMemP3k7/P
 n038jknu66yDCsaEcAapc7zPiNRCHsllhbnzw/M6OV7DRmx+oENP6Xjp6DQuuRlLRYseofmSRSi
 uP8ABCE2GbhgFh0AlF9jfTUbLG9v01DakfIQ0pMpvILifJ2F2R0Odt7GFb9cRmISGtUBPHUxSgo
 wV3XNSJJsKPj+rtNkn0ZuxKi4p2c7/FvIml1s2FNJyU3WF8xDGcsEgG6W8qreILeNmhSTZbcAlP
 nTUFJgJWVXkt6d8scsg==
X-Proofpoint-GUID: 6W4w0krDq8G8zDw0Vinecw4YPtipt0pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270110
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
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-43293-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rakesh.kota@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 34B511B7268
X-Rspamd-Action: no action

This patch series updates the PON power and reset dt-bindings and
device tree to add support for PON power and reset keys on the 
Monaco platform.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v3:
 - Drop the dt-bindings of PMM8654AU qcom,pm8941-pwrkey as this
   patch was picked - https://lore.kernel.org/all/20260209-add_pwrkey_and_resin-v2-2-f944d87b9a93@oss.qualcomm.com
 - Update Commit message and disable the resin as suggested by Konrad Dybcio
 - Link to v2: https://lore.kernel.org/r/20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com 

Changes in v2:
 - Introduces PMM8654AU compatible strings as suggested by Konrad Dybcio.
 - Link to v1: https://lore.kernel.org/all/20260122-add_pwrkey_and_resin-v1-1-a9fe87537816@oss.qualcomm.com

---
Rakesh Kota (2):
      dt-bindings: power: reset: qcom-pon: Add new compatible PMM8654AU
      arm64: dts: qcom: monaco-pmics: Add PON power key and reset inputs

 .../devicetree/bindings/power/reset/qcom,pon.yaml    | 16 ++++++++++------
 arch/arm64/boot/dts/qcom/monaco-pmics.dtsi           | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)
---
base-commit: 877552aa875839314afad7154b5a561889e87ea9
change-id: 20260226-b4-add_pwrkey_and_resin-2c04d8d53f5d

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>


