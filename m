Return-Path: <linux-pm+bounces-42493-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGPPI9ZHjGkHkgAAu9opvQ
	(envelope-from <linux-pm+bounces-42493-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 10:11:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4793E122940
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 10:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1EF4302DE23
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 09:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6435354AE2;
	Wed, 11 Feb 2026 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6sdTWNo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hsmbItn0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5F354AD8
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801097; cv=none; b=gN33XFo4+4xcuZR8CoxTTscc1zMuI+QcOh/MeHbcgAKBU2cgOHbytTcLvOsSDs//U1NsZZnghjX2K2ty5FqQwJe7v8LXJLTmeT6KiXL7DPFRt56j+Hrftw52dX4+4blOlCrcBZLWX6bq+LwspOVcp43l33nsUJnu4+Yu8x2OCxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801097; c=relaxed/simple;
	bh=GJWZ7Rm8qTVnP2D3HIa4cLF9KS+n3zEPlp3pqdzKCIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tL+9UylGByHHwr0Pi8exvj9f2WBiZdKWg23KelUnJpqF/AEznirxdR44iK2sLjaC5WPP8dnEgjzSnX660w5uj06h/Nmbs/JErscvo94z9cCFU9lwiBqrsd5kHWHCi65tv0bYigdkucFCar8N6aLK6Yga6Wp8XSg4WQlhGoXQypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6sdTWNo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hsmbItn0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B2JPfU4127429
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 09:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=utjvZ4xDb24hS6m7SLahOnCAlh/uD8yBWYB
	XPpBlbcQ=; b=B6sdTWNo1fQpU9gnFnV4044QpXC4Je4oFUvdYDzdwcDdQRHlElM
	TUG4LOCO8jb2l34ktGmNN+UP77Po26ktow5KD/ivv+3sqywbIUMoaDUF04+w2hW2
	LRMM/Iog8V+J6lGW++vH2KcIJrCPKlvvYLFE0LPcugNqj25lxkUUkBTHnl10gNav
	94KP4ZJr5zq6djPQqQYy8hPD0sxW+JI56K6NqY/TGV8G2ruBxbkGpqx4WUBvBCqB
	KxYKipXPTVcL6SZbFmUBhdRiVCQSvYwQROM9iF18d4DJHONWLDFIAIK86/TYG/y3
	6E8XpolTpdxjZQ9flKVFsJCPzGKGJDkGTEA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8gvm136h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 09:11:34 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c56848e6f53so4214262a12.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 01:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770801094; x=1771405894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utjvZ4xDb24hS6m7SLahOnCAlh/uD8yBWYBXPpBlbcQ=;
        b=hsmbItn0XqwHwKQ2pzbrl2hRtz3wo8C+7jyMe3N80E4fagLWkD+5Y9ZWnwiFnY9jbY
         F+txxV6lrGpPOtqmUFE7EEhFWKealJxpkZifBi6JANNxHacpEAERGV9+e/+OcWQESgiU
         pFSTdR6WF+G4vgRidWMjX5r37GjjIvVF36Y4lOR63av5qVUgtxnhKsD0gMOO4SeTXAF4
         UN4u3Mv1AhF1BxIPdA45FCfVnKoo4eRG98/GspsTQf8MkUNTxvRXvtAWu/wMwKYpFry1
         IdkjOcoWhV/jgjUeYxDqfDRdqm5sglt7C33r36E/9S2/mdZ3JbJTTru9v3B865LWMygH
         BWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770801094; x=1771405894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utjvZ4xDb24hS6m7SLahOnCAlh/uD8yBWYBXPpBlbcQ=;
        b=WqSJt9o+lvdfVzE0/xGnuIDM8txWsEfp9yF6drXc6NdgO5c7qMGKLpuwpaAg+LkPEA
         8UWWXLlZZe7ZeviRy3ps5B4Ur1szQSxa4ukh1JQb/sSq8F5rKuYFmnNXp6d46PkO2E1v
         ZjU+Lb1Op6lYEZZt3Pv1MrOlFKZcdjfRCyQ/iVsL0NANOs3YNF3kJ6GL38wmxCTw5Oei
         8mVmbp162JtzGPTmBmQRUSfLkOMvZ1zIqoPbALPsM09ZXMe+MZHMfjxxtUfM/lUP1Lmb
         /yhXjgqn23gTsRhvIjmSCHQf7VTy7zYAC1GqKsJGZ+QfQ+2sCk3BPOBxLU99s5Dv0UD/
         iw4g==
X-Forwarded-Encrypted: i=1; AJvYcCWBpKatVhE+sRdv9/biRDupnPILF3E/WwsOPsgKBHDuVFn37GXMbYNL7J9E1Rq3/CMcnWDM/GpWnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWeAUJ5mXQrsWddhlUYQitpj30cymVtwG085L8PORHVAr4cU4R
	l1bLXfUisVqi8R7POZDEe3uk+2QGLOnox30r7/EkUcSy3Gz7daqGwyKqVfS5HzGi3NhUVERS8UF
	v6zszm0xt3jY1uhWx62lklo334xOcyYLeShTPxSA33TSlUhNnEhuqXt0xOP5lGQ==
X-Gm-Gg: AZuq6aIsahs1VBahXjkXBHY+/+VfT101DF9KaZgKR0UQLZs1xK59ydyEmFWoqdbhNf+
	vcY8cYZZzEPDhfMpBCE71AmVLXUCBHNfyxcpNOjUgCwntiTW7bploM5L5a14UZ4L/RBJjToY6fT
	il+HFE00g0I1R4Xb6JeJWZV7a0A7VM7vkegz+DxUOlfhttH/RU42FySDR3VXoaQF0/gVqjFfc7/
	qM2AgvXazcLfcNpPIu0aUYguFZcI9vnLUI5+umCYcZUPahz0rkudjEUnmUyoSGmdV7cjgdJaHNQ
	Y5r27yL3rP1FXVV/uf5xApQT+u3mYunX8rL043mbFV/w1ji2FmRRG+9KwlyiWzWP17AenAq6RoK
	CoWbdzaooLmDaoSkL7zqNWSFcrGS9PLnPZUz84iGGaI9RkqvP1OZ6ck8=
X-Received: by 2002:a05:6a21:339e:b0:341:9db0:61f1 with SMTP id adf61e73a8af0-39432252f26mr1508374637.16.1770801094137;
        Wed, 11 Feb 2026 01:11:34 -0800 (PST)
X-Received: by 2002:a05:6a21:339e:b0:341:9db0:61f1 with SMTP id adf61e73a8af0-39432252f26mr1508345637.16.1770801093671;
        Wed, 11 Feb 2026 01:11:33 -0800 (PST)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e1981512bsm1521481a12.31.2026.02.11.01.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 01:11:33 -0800 (PST)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Enable QoS configuration on QCS615
Date: Wed, 11 Feb 2026 14:41:09 +0530
Message-ID: <20260211091112.3285626-1-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ctiWUl4i c=1 sm=1 tr=0 ts=698c47c6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=fIl7fISSXmXrEScvsbQA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA3NCBTYWx0ZWRfX44yb8OPHREoa
 3gYLKxOEORX3nQSYM3vkdG5ooSpcGLDHhSvyoogsgjmNIdb4EFWXki65BDomJdj2/g8/zHy2fri
 9m1Nay97j/JUabriRg74kpqTtImgPbRlktITRuDdAarWfuVe3oW8PPt/z8CO6nJNspU8fFIDrlK
 OnJkEdrY8oRxJYWowmH42QDLBxfepKiuY5QYWMh7/6yfo3RXZceLfi01ftmuh9YLjDCW5zPhZhI
 X+fUpnvidnjtMvOLPylQIcpzPtMc8UYSljIb/nOqGWxXgnX0qdXMViqUYDJHBdjHqLDwRh/J8/+
 T0VaY1D5VdR33b9Dvq4yfCroWw95r9RHK2FLTqYxuJqo/Mqk/dCGtKyLZXsp9YUbTizLCsexLmo
 cg4n6FFgfJtgkFnjrDKFl+APWFaJ0mGGKya4YvBie7PiQzWqHgE0PNYljGzT+E4Ik9tWnRnSXxa
 O9D7q3EeZBoK01gLrWg==
X-Proofpoint-GUID: MNH9gLILEfebzTuhp_X4_opb2IJOdlxH
X-Proofpoint-ORIG-GUID: MNH9gLILEfebzTuhp_X4_opb2IJOdlxH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-42493-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4793E122940
X-Rspamd-Action: no action

This series enables QoS configuration for QNOC type device which
can be found on QCS615 platform. It enables QoS configuration
for master ports with predefined priority and urgency forwarding.
This helps in prioritizing the traffic originating from different
interconnect masters at NOC (Network On Chip). 
The system may function normally without this feature. However,
enabling QoS helps optimize latency and bandwidth across subsystems
like CPU, GPU, and multimedia engines, which becomes important in
high-throughput scenarios. This is a feature aimed at performance
enhancement to improve system performance under concurrent workloads.

Changes in v2:
 - Added the IPA clock to Aggre1 NoC bindings to accurately describe
   all QoS related clock dependencies.
 - Updated the Aggre1 NoC node in device tree to include the IPA clock.

Odelu Kukatla (3):
  dt-bindings: interconnect: qcom,qcs615-rpmh: add clocks property to
    enable QoS
  interconnect: qcom: qcs615: enable QoS configuration
  arm64: dts: qcom: talos: Add clocks for QoS configuration

 .../interconnect/qcom,qcs615-rpmh.yaml        |  46 ++++
 arch/arm64/boot/dts/qcom/talos.dtsi           |   4 +
 drivers/interconnect/qcom/qcs615.c            | 247 ++++++++++++++++++
 3 files changed, 297 insertions(+)

-- 
2.43.0


