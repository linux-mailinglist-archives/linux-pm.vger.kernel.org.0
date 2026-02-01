Return-Path: <linux-pm+bounces-41857-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPF3MK8vf2k8lQIAu9opvQ
	(envelope-from <linux-pm+bounces-41857-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:49:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A428C58F1
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1280F300F9F5
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230763271F9;
	Sun,  1 Feb 2026 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QbF2A/6f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ztm74V7N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F64324B10
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942956; cv=none; b=MrQNxqUWyNhsyBKGDJKY6PWRRAgjzwKIUQF4ettavR8I/R2kn/fsLCNeJYT0klpWBOJiNwVOvUqRnOu7U4D0PB+Lnv0BlG1OHP+ihyatlKNw7xETy1uimGKFZd3ZDHKvcIxFkXtvpRMgHEWHjFTK+zWj3w8Z7ZgYKia2JsZrxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942956; c=relaxed/simple;
	bh=ta8NS9oLfaTP8ODHsdO9/5QO4jY2iNkc7qAcFD41Las=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BScNEaIA6jLsImgrcrhZFq5zECf5GUUQM/acFJHHbSkjQyeI6BjOkPr1xQLNqdV2OvVqko+MBVJ9/du6S1MbV/tzTvL1JEjM498k5EeA4ewFImTvM+T0MSS2MCz5VY32C7Ge7Gvq8794Iys0wVMzfXfu1Rvq+jBfk4BAC8eXBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QbF2A/6f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ztm74V7N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6117Rnac3511664
	for <linux-pm@vger.kernel.org>; Sun, 1 Feb 2026 10:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sSr9bu/cvAJde0xdxCLrIb
	mwiExX74AhA+duZZk4kuM=; b=QbF2A/6frbye/5MEIOMs1oqhu2tHw9mrY/gs9R
	LhfQU0aIl4aEJP72+9J2aKSF8YI/v9lhlOWrk55MR5P34HEH38GiaDplLeXtcH7F
	LxSFI5R8c7NgihNlroQmGAwIphOBLRDng24uqr/mt/VZVlRGNRatfx97KnqX++Gn
	KsEp0zu3lZyJWcVUvxWHF1zBccUIIuPZDeYDy/9t0CEwF6rWlVaW81E2M/eKDMBn
	wUhjK2OTmmRrn3irVPOxyHZMxfahvTk65Vpfm4ukyZ19UHIqA9Jy2qdsIk/aN4Nm
	1PZzJhLqztNZnz3XkVxM4GXZF/DwgJzYT+PLxGCffG0jTRWA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1as4tfk1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 10:49:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6b4058909so952816685a.3
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769942952; x=1770547752; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSr9bu/cvAJde0xdxCLrIbmwiExX74AhA+duZZk4kuM=;
        b=Ztm74V7NM5KMKmFX3q+3wRrHsRG2Dq5vK2EDuxnY0/PgBTarDNIxPYXcWDn5dBFA5D
         linyJt9r6kVv/HGkfVlRijGblh2M0NMYR6Rl4dJdJbByFkLRnoGQ3xEJcBDV0XjWiVfg
         kQk7t5G8bPAGQSL/Xz+LAaKQ2tQ9dz+9XTGHzAY9otDVAWnIJOO+sKI4WfKklcgBmCxs
         D+6odnikzqJkk/nzr78j2ut+DcibWmqctbGBL3uOIftFeHVJmjRwKd+az0M1oEDVqU9i
         eRAxdDdStmGZmUBHUfqUDyx8F5NV2B5MuZbG4DrjdpINjWgiX3DQh3H6qVkXq63sa/ZR
         JEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942952; x=1770547752;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSr9bu/cvAJde0xdxCLrIbmwiExX74AhA+duZZk4kuM=;
        b=v7u/uCbDbrr0nrcu+fLqReEJROQGBFAq7rwKk/yx3DRD/hg5rvotNOIuWLpvCQJ7qd
         karTdReZ/frCHwI187Zvg46M9UxVOUMVCVxjUXMPTYM8nw26GWla7EMeNbc117u/ChIC
         9FBpQ0kG7CTfnkCKp9K5O6dxhGOr1w/iT4yJrhGcmnfzEIvGH0LRfSfxilm7Fk7HNkAA
         muSmmDkjucXgyNqWXFM1BF7dpN1aZ4Nlvl1TkjSi/4rcBMqRfDyt3+b8tGEVVjl//7go
         ADLw94lAJYi3LifPXW3OQhsdChPDw3BqXwbmfDgrlAjGWIyNm4jRAcGuJdOM5BxuhfCY
         qeWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXybK8ybXzbVptaiNkCcc7x1rEjG6pXLk6eHdbpnqvizhR2Vr02ELyb7KPJLfb2OoYPuL2rinJHHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbPaIUUqas+rIzEFSQuTF+6WwM8pz29vL2uMPZwaNHtcXNhCi
	o+uKzSjQf5yqJ2kOdfptQj2Qg5WWGG3WeyELN4zpT9+gmx5Xe7AGx/ehtwNO/q9f28M/ogBnCZa
	tZLbgpqyOqqUJrqLE7AL0dkSK5aauKyRpVvBzCyoQyM5Y1GKlsQ7OGOYNPNyK+A==
X-Gm-Gg: AZuq6aLZ/hjwKBYkD9HmVeHRQFYQTnFDxg0XuvraQsofConpjX13nrBtoezN3lcIT83
	0SdoOWhzI1C7/DvIYzfc55AoBFyDUFwQNkp0XvaSuVKrx7wX51yYAM6yzlTo1Dn4dWt87XBQkre
	xfPlL+OrTDM9JkpxASVvngT6ezQaviJBC3gnJkyQEscYpOZ/4lWQOKyp8mGJkHiXJb4oBGM4lpZ
	npUXpGrtL/9gNZ/YPh1PYS+f0A15HOkt7RT6hCW8ctKUfdTphSyctRyeKyb+Rz4aiPhTSZORIdb
	IluR9GvT/2mow45yKDgNdyjWNKpB8zBOwWwXk57mpos01sYmxws7TwsaBEoKC79ScPwFop6sh/u
	rTrlpodKd/7IgmEBCr0ooT2GGraVTHamwIoU+1b/4MZwL+K6HPDIsy0DmdxprlPyaxgVpZOkISu
	/9I/wGiNpT6PYXIz+9TEWFtJA=
X-Received: by 2002:a05:620a:a118:b0:8c9:f8e5:9f12 with SMTP id af79cd13be357-8c9f8e59fd5mr614959985a.57.1769942952517;
        Sun, 01 Feb 2026 02:49:12 -0800 (PST)
X-Received: by 2002:a05:620a:a118:b0:8c9:f8e5:9f12 with SMTP id af79cd13be357-8c9f8e59fd5mr614956785a.57.1769942952040;
        Sun, 01 Feb 2026 02:49:12 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7a8csm2835006e87.77.2026.02.01.02.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:49:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/8] media: qcom: iris/venus: fix power domain handling
 on SM8250
Date: Sun, 01 Feb 2026 12:48:57 +0200
Message-Id: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJkvf2kC/4WNSw6CQBBEr0J6bZP5wACuvIdhgdhIJ8LotEw0h
 Ls7cgE3lbyqVNUKQoFJ4JitECiysJ8TmEMG/djNN0K+JgajjFPaauTAgpHmRXDgN8pUm1Lh0Ni
 aTENV0VSQuo9AKd13z23ikeXlw2e/ifrn/luMGhVenC2JnDN10Z+8SP5cunvvpylPAu22bV+jf
 e8hwQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ta8NS9oLfaTP8ODHsdO9/5QO4jY2iNkc7qAcFD41Las=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpfy+jlt0mSi2KPEsBGqa6ClC6PcPT+B67GwYO1
 wWuT4waXwmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaX8vowAKCRCLPIo+Aiko
 1eFnCACziPVJklWNltdISmgIRH3q5XAItPzT2VXBl8DaYbb5huQfI5fT43X8u7E5A632IhVhynb
 CGLkYgIcR4SHoei2mDjEsb59DGs5fAsU9QKRTiOvlO8lqBNMXEwdDjzb8DyoxOD+fRZwBnUZ6kD
 MagYGn2fLl3RDpwchtpou+Pu0XikhQL1aD2/iO5+UhQZFRgOMFIZV845JfLTdnn/lFQbuL2km6B
 8my66GckklxpOov2ry0ebAziqgHbETCv0iY3jdTYzqb35Rus8rCFAAbA7ZPU9V+BIJ2TxhNdST/
 1/DiDcPQERfq1djrrD7Cp9pTjG+i5cIE1ltnibf6tZRg5fG+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: CbTjxT8yfjDrY0Lnt0nrfOJyk9QhM6MT
X-Proofpoint-GUID: CbTjxT8yfjDrY0Lnt0nrfOJyk9QhM6MT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDA5NCBTYWx0ZWRfXyeO6oKKad8ow
 43bHQ7Cmy5QB5AgJ0phSkKNiDXyshWVMpXLiCUk7897ryQiB2T5OQWqnhv3oiIkM2Xa5oaUbT1k
 A8UKDwVYebnmbQ5wdxB6heS+IvkPWtP/ZjWy3Z0GyVxXGlWwyqFvxiDKiNIyZXPgBsezrxVArSv
 FiRRTXCH5K+vvIIpf7H/w7AmuDuRQ/jgLjU1mwdiCpnVm1LwX0XubTJRYZddJRRUTeeNo/hnqGf
 HxTiUcRRba5o7xp8BU+TNipDKqG0cRl5JRq7QM2z8lEiMZjbQZQS31LItCcM18WnAVn3E5cfOp1
 L4Ya/yBJfk87mjjepnk2Qtm+BrLtboYmHfUPUTAVQHAjcEliXgl8L6zQDHdQ3omFuSG0fxdphH3
 q/el+/mXAHTDPhCYBRJnpwkrT2OllG9mosbYEZUXt2yapJm3gsEdsdpZNZvd+NV++sUmzN2t+05
 bQBAsSPK0oK4wgEKoew==
X-Authority-Analysis: v=2.4 cv=bIEb4f+Z c=1 sm=1 tr=0 ts=697f2fa9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0RjBngDeADCmygnGHrcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602010094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41857-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 6A428C58F1
X-Rspamd-Action: no action

As pointed out by Konrad during the review of SM8350 / SC8280XP
patchset, Iris aka Venus description has several flows. It doesn't scale
MMCX, the frequencies in the OPP table are wrong, etc.

Let's correct the Iris/Venus enablement for SM8250 (unfortunately also
stopping it from being overclocked).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Fixed example in the new sm8250-videocc schema
- Link to v1: https://lore.kernel.org/r/20260131-iris-venus-fix-sm8250-v1-0-b635ee66284c@oss.qualcomm.com

---
Dmitry Baryshkov (8):
      dt-bindings: clock: qcom,sm8250-videocc: account for the MX domain
      pmdomain: de-constify fields struct dev_pm_domain_attach_data
      media: dt-bindings: qcom,sm8250-venus: sort out power domains
      media: iris: scale MMCX power domain on SM8250
      media: venus: scale MMCX power domain on SM8250
      arm64: dts: qcom: sm8250: add MX power domain to the video CC
      arm64: dts: qcom: sort out Iris power domains
      arm64: dts: qcom: sm8250: correct frequencies in the Iris OPP table

 .../bindings/clock/qcom,sm8250-videocc.yaml        | 85 ++++++++++++++++++++++
 .../devicetree/bindings/clock/qcom,videocc.yaml    | 20 -----
 .../bindings/media/qcom,sm8250-venus.yaml          | 10 +--
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 42 +++++++----
 .../media/platform/qcom/iris/iris_platform_gen1.c  |  2 +-
 drivers/media/platform/qcom/iris/iris_probe.c      |  7 ++
 drivers/media/platform/qcom/venus/core.c           |  7 +-
 drivers/media/platform/qcom/venus/core.h           |  1 +
 drivers/media/platform/qcom/venus/pm_helpers.c     |  8 +-
 include/linux/pm_domain.h                          |  4 +-
 10 files changed, 140 insertions(+), 46 deletions(-)
---
base-commit: 44ef70faf71468e0ae4bdb782a6d43f0614b8ffa
change-id: 20260131-iris-venus-fix-sm8250-f938e29e7497

Best regards,
-- 
With best wishes
Dmitry


