Return-Path: <linux-pm+bounces-41880-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMTNKRpNgGlQ6AIAu9opvQ
	(envelope-from <linux-pm+bounces-41880-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 08:07:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 043FBC90EF
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 08:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF763002B6D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 07:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207AE30C629;
	Mon,  2 Feb 2026 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kB3JeT3p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R36TLnnq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A588630E0D4
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015989; cv=none; b=TbbATCK14cxc0J0acBWW/Ql9GoxvyA3QU2Rm5wV2twu7BSdUPBKd63QMDbkqpfNFaeQ/KAaSys48aQY+INIx+mY8REHJxzENeKzjUBkhj/PrPV6XQjRhDlLaUUoRgil6/TJ7ji2HhjcBlx/uj5Vdm3lG4loqpIynxa4Jo9lHQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015989; c=relaxed/simple;
	bh=xiCHT/wFzjlKiC/fOA41wNa3HTCrPxnBhSVnSBKv400=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mElI/5aEoGUQXo/u/81ErhR4H9djk4BJmBQD1uq7uMvn7qskvAzkesZ+IEffEV9AZiCEzmvFMQzj2ryf0sVBa2fEpcLUneQWLlF5UPeS3jtgML8IP/lHyOBQK71cSQ+105yg9NJTgSyn021xH4OQ9bKEYLi4sl6tAeTIX+RTMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kB3JeT3p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R36TLnnq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 611MnQll689487
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 07:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5pTsG5jQcf50c4t/exdRGNh0EFMedHBavW+
	4U70mX50=; b=kB3JeT3pi8GN7duI6YpXYMDXYg17q2oO4ubYAEtpzsJzAL9zQyg
	8d1zPGCJlyWXsWH2cJJlroEBUDN9SFrKBt+QCKDvWh+bnpTTH4J5K1fEi8w5Qu/b
	QeYZ3296qb+4wxjAt9KnMjkTfHmtIg87prjg1Iu1kkTHY/p8I1ItEZRlx2InXXh7
	xW5A6K4Ix0jlxArEDdhx5BDEmga4Q9a7mlZfu0q4k4Ng2poavLN55To4G+6caXvc
	eCp7dwckEKtYRdm5GaS57u1XeZlEf+IbMkmCD/4bNHxgsQq5GOfII23A1s1+ZcSG
	PnTnyuGDRbo5YmXlQDjK4O5iNeNPKcBxXlw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1avx49c2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 07:06:26 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so3802551b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 23:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770015985; x=1770620785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pTsG5jQcf50c4t/exdRGNh0EFMedHBavW+4U70mX50=;
        b=R36TLnnqHZBI7HAktg8tp4G/vmaDd08YiC4grFzL04sQK+kYWfXcBwgyuwqOf9Ue1k
         AP4M0ilDT4m7y3UO8RdoY1j3BL6GGb8TM8t5FdxJBQSiD6TyfHSuO/x/uqL6n1ugAK9D
         E0G7peWYxk0tEANFPUqE11N+CDHDSI3TTfArGYbmKr5cheZhyoBWuRbuHN9JBnpzujT7
         gr9xYgQMYpj693x21DlA6LDPCdlIMZisJ8oSo/39uqwUDirP1jxY4TGwBS6fLA3B7n/r
         NP3Eb5WpZNtDQHOhDlsDkv6F3wEQmtDxotnw38bkfH1iu7NhSSfasebokY57PDgRB86o
         SVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770015985; x=1770620785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pTsG5jQcf50c4t/exdRGNh0EFMedHBavW+4U70mX50=;
        b=ag9Bf/QNTTwVSU36YhsR/jILM3pph9iUjfRctl2WQDRuZzoqEoZKLlDPanjYnonSpm
         7qygHe7J6cSg8Tndh7sl+07l/e0PGUDb294hpEgKZzo9Nns0DgolYmuV0UUcZKiYCWxo
         YXLf71tlsKgI7JtK/vXqP//UKlFsOJhiia0FmeLvcPjk03yELszy/emBOhbR47HGZKSH
         fJUG7Z05DDMZrZHF4HQEXGxS9qDemeS1u5uhz6tuvRnNUif07lrOVpYSGZg9FFcH8PiJ
         BE1LoAmfaHR43LuqMq7Zh2BeINNUyPWmWJl8D0XGntvhc/MFol6CItx+O+E9Ihue5z3l
         7NtA==
X-Forwarded-Encrypted: i=1; AJvYcCWI/qkdMbGjB4uldOivjTF2a0pg4J5QHP/MAl+MqimsuqgHD4Q+plkILGrFAkHgKFb8kcwIw8fRgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2BfiOvRPTab1J1ole2xSy3gaYGGWDwuzaJkqjA7sm3LCgcP+
	KDucvd/KkSGg0a/lXgkS/bj9z3TBCBpawdY5UiX9GKbUepfrgiBIO3F+wR2ee3rhvfIsqWTlsNR
	W/pEl/LJSjd+0vvy2/6Uy6Eh1xnNu4EPPv4nCDpNZQJ9y3EoU3X+ncrXYB9GQ2w==
X-Gm-Gg: AZuq6aJXmq8bYBJSBIqnBzKzeEBuql4Ywa40na0p/HhIxB6WJ9fOGJxqrqo0KhmsQSo
	svBSy8UkJzOUArTKfwTthUYgxW0HhPnX68D3ttRCukYewK9HlqbTE6rZMaT3dvaNhTouYSm5Hxk
	CxKb/gADTYFF+mvApdGjjuZix2zzleKhjntEiS7xRk+ce7xS/tNZDgJqmN7le7rnXg+oICf7nWo
	UCExRXv4D8on4dUdMIsGZpVDzav6+c6+A4BRRKkflNmadQFzS9+SLPCvvDWia0YKVPiVo7mKpz1
	xwG7N9ZxAmx2NmH2hl5sZvB+3yqEzEl7DzEGFDEgWwk3p5jZzu+A3J+QtWIEdgxnC0sQ1sqJ0o6
	xL1h6OKw4btSde6uD7C5uZthQLOeXSbaUnPrXeexTvbU=
X-Received: by 2002:a05:6a00:4c9b:b0:7e8:3fcb:9b05 with SMTP id d2e1a72fcca58-82392118166mr13260150b3a.27.1770015985455;
        Sun, 01 Feb 2026 23:06:25 -0800 (PST)
X-Received: by 2002:a05:6a00:4c9b:b0:7e8:3fcb:9b05 with SMTP id d2e1a72fcca58-82392118166mr13260132b3a.27.1770015984988;
        Sun, 01 Feb 2026 23:06:24 -0800 (PST)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c54fcasm16265727b3a.66.2026.02.01.23.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 23:06:24 -0800 (PST)
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
Subject: [PATCH 0/3] Enable QoS configuration on QCS615
Date: Mon,  2 Feb 2026 12:35:31 +0530
Message-ID: <20260202070534.1281652-1-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C93sSUO4_NqPHUomRki_a0icGfBTcRJ6
X-Proofpoint-GUID: C93sSUO4_NqPHUomRki_a0icGfBTcRJ6
X-Authority-Analysis: v=2.4 cv=P4w3RyAu c=1 sm=1 tr=0 ts=69804cf2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fIl7fISSXmXrEScvsbQA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA2MCBTYWx0ZWRfX8RkggDryn7o3
 9WYINCJuML8DfUuCaa/5AnYweHgUGGedbMNKSZoFDNYOqLqTvz0sI9gRoPvUusSdfH2uX6j2Zbr
 QkC+kontwyoW0SAayZU4x9EoEddRoi0giPzGxOnfdU53ay4Q9f/kltITdh3kIMindCm0qP4+LDY
 xi0nSBrJZzc8VkQg/OI3VO/UPter1aMVPnhyJ46syF5ZYH6ElwNpwjHcik38pHetrr3kqlrfnjr
 2NQc4iYe/J0PgV3P/Yb3qBisX0U994m46iaKp8aZSv/9+sT7xnxBAlOW6HOJepmLBWCC4zfn37J
 N9JqzK0RzgRka+WRyO0MqfN9a6IZFuucRtqB5B9YUki+nRX631wW0zHYLNWIB1874X72Pg02WML
 THOuxwQs1CRC/ywwlVYRhSD/K6HPIj+w0sYrJskRfM7e36hexqkHG8lDJYenOLlmJnMblBriUvs
 cPLgpGm9UxOWT0/n9Iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41880-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 043FBC90EF
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

Odelu Kukatla (3):
  dt-bindings: interconnect: qcom,qcs615-rpmh: add clocks property to
    enable QoS
  interconnect: qcom: qcs615: enable QoS configuration
  arm64: dts: qcom: talos: Add clocks for QoS configuration

 .../interconnect/qcom,qcs615-rpmh.yaml        |  44 ++++
 arch/arm64/boot/dts/qcom/talos.dtsi           |   3 +
 drivers/interconnect/qcom/qcs615.c            | 247 ++++++++++++++++++
 3 files changed, 294 insertions(+)

-- 
2.43.0


