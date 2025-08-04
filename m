Return-Path: <linux-pm+bounces-31850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9A5B19B75
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 08:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5617E3B1FF8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38D222DFB1;
	Mon,  4 Aug 2025 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivYrg4Nx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8F227B95
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288227; cv=none; b=kVLOecMlSqBDnyEmJ5gFePvcgkA/+a6oYVWqFo397GtDdDk+4olAShHB3u9FoxSg09QMtQye9PqdVIIm3QVn/Z2rnIXeUbNMspPOSsKPTC9skGTJxRuILhdUcMxLHWH3lUrEBfY1tng071yrHefd2Y1aQShWBcDA0FlnXOGsPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288227; c=relaxed/simple;
	bh=eMgZLpYqsrpOYSyhN56WZXWGJLFAvTwwAGp1XIsrIP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8jAPsA6OfJLcbL+e9ihE5irs5gFzXbPOraa/z1WUce1SPUBhgOiUNxQFc2YhXuRCqy7vjfz2Ttj6s9rp3Y1nJW7wMFYjTvfNL5PIDKTtGJ3AsTo98vEG3tVRlR7HUm+a4Vx0g3cUQxfgcA091BMNRVXBvtiBTlg9KEDjl3HJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ivYrg4Nx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NmhOQ032122
	for <linux-pm@vger.kernel.org>; Mon, 4 Aug 2025 06:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iAHnqwL0yHem+mv+4tLl/cNCAGcUR4yxE51
	d9JO/2jw=; b=ivYrg4NxISrmRz/IrrTX7ypIm5WthPveyLFfTFHReGoXg7fvoRz
	2r0l6hAoyXjISER3O54JF+xtz0m4GbY9d9RU/845FAB+pobOU6DvmsJwtt5PFy3d
	8k0VH5TSlItBMXwQEhMss5E3+XQuM2RzP6TNtGwas1fLSA/PyfGtWS5cxt0GBNfn
	lT6ftKg+E3V76Fe7KtomdoP3KFOW3PLnIBr2dGnydiWkRVqsSW+vGVCys0QlPVjE
	+6CtHgpWCnjV2RgWOLwBgUKpAzjmbZWlsb6S3oBV1XS3DM2O0ShLpAYRjGHBO5ax
	FNxbTpWY/1aox0GMvjQqPcOBputFTPHnlbA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489arwknur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 06:17:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2405fdb7c15so58697245ad.0
        for <linux-pm@vger.kernel.org>; Sun, 03 Aug 2025 23:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754288224; x=1754893024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAHnqwL0yHem+mv+4tLl/cNCAGcUR4yxE51d9JO/2jw=;
        b=gFaI4EqA9LAIsBgkvbXR08jTHVankOGJC74BuGbYcB+7tw/0zfgo7khlZQth6G2Txl
         VCz9bAGaOM+TNoLjIF8SVRzGf4n9lVVohkX8UFpDYgeKJ63uhWFqZF4uUt7KGNHgSzwz
         veRxjJSblFNteajNT+CfqHVoKfplp5chHlw+ThuEPQp1pHBx9L8ofPKaSE1DdMaik0Pd
         uALMPaDN094DCVfUpseryQ1pbzpqzY0aBga7s5L6te1x5R+ZTsiDZo+yUGAO1jQDnWMU
         7myp3gnMCr3Se4aOyz7R9BoaK1+TwPEbAJunefICvih55bBCqr/a1zzaKuecBZBVM5Sz
         nacQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvgczrhKLad8uJRTH5D7jQ8dZ5t4SKVVYdcgCpYC/BLyowK1SCd41/FIARS/ga+pa2hZ0w7eaT3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9/IT2eQedOGzRN4r2pyPgRSBB0B41D24qgY1N37JWPVveLV7
	+yz4CwsK8tL6uI1BPyli0KBba0bL7sByNWipV7Gd3I0X5CDRA5bKQmH9vJAsMYeWYUFGGr46ucc
	zl/TTbQkapy+PK/K0XHaCGNldkXEkHpyBmU+XjSNAKHeBvxsXWMlhBdzZQRV75Q==
X-Gm-Gg: ASbGncsWzdxHpP4WKoV1JlCZHV+Bmy/6JXmL4OOJhDOCexW+XIezpITPTH8J99RZ1bG
	vDWDFHFhDGaXLfcnYBv847lnQLwUNR2sUKjw7wy1h3HVjsm9BD/+B7h9aQhw4jHrvVq4LZGy+vc
	7wGjC63gnWTTvabEaGXUlWcY3LNa9a+K4bhJaSg48tSNyQDdHsyytruH9AfwzOMCqd+ppBTirRo
	dZEpCaRURs3O018huBhNclx5uqaGFisxa7g8D02Mk3OdFZbJSfJVExgb9ai6djIu9yzDTCagfW5
	nAmW+2Y7HgtWR7h7VKIqBSHXEoPECRHhPoY2Pitwziw1/kHKYv1zH3mfycj3inC2XOfdZFY2Xpi
	IXbs=
X-Received: by 2002:a17:902:c94b:b0:242:460e:4ab8 with SMTP id d9443c01a7336-2424704c466mr116862475ad.46.1754288223554;
        Sun, 03 Aug 2025 23:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwDfmm0C9LYhQxt+pKGPY5NUnAnjrRTEjtgxOftkxmDC2olfkZxAdQ9Xd00d821Hb/WvJUbg==
X-Received: by 2002:a17:902:c94b:b0:242:460e:4ab8 with SMTP id d9443c01a7336-2424704c466mr116862235ad.46.1754288223102;
        Sun, 03 Aug 2025 23:17:03 -0700 (PDT)
Received: from a3fd830d25f9.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976f08sm99786785ad.103.2025.08.03.23.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:17:02 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH V2 0/2] Add OSM L3 provider support on QCS615 SoC
Date: Mon,  4 Aug 2025 06:15:34 +0000
Message-ID: <20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzMSBTYWx0ZWRfX9Em2kGUIdF+Z
 bEzPcc+h+ie14TMGmwOhdnl+WrB+IIvz+o0dmLuKwzh+d9MbAwEoaGUPMeuR0JveJZu8XKzppb+
 3XDQDm3l3v7KJPMLz4UHw4RN/jCPX7DtTFWSqkAOxXXn28FdcoGWny4iz2gsYE0+x9IWsafXDPh
 iQ0qXeUKyzE4g4PJyaDAIUFMT5WA+FmXRVSONO52E9EPCa10V+Sha1uloadI7VRviPOrj1uMsZW
 +T7diVs/UPSilvnDFOTbdZKVHE6/bFFpPXlYZca3LfJTmcu3VigpLmscnhCkmM+5F+KvvxoKBLR
 sv+rhCfmuwYlVR3YU+tzaI/23/RuvzAodhbUwTmrkNLj9YHYFHW7nDZBILt6GVm1TEbHFieD4r2
 rB5MTHy0VSmX3Y5/MPKo2O4Jv/M4aYW33kJQuNM6jXMY7wGQhSubb1oek2F/u95iCHLjlyZU
X-Authority-Analysis: v=2.4 cv=We8Ma1hX c=1 sm=1 tr=0 ts=68905060 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VdEDuztqGucW-MqrkSEA:9 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: blTT0ClljfcRlrgKqhDh6lvuz_T6stKc
X-Proofpoint-ORIG-GUID: blTT0ClljfcRlrgKqhDh6lvuz_T6stKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=900 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040031

Add Operation State Manager (OSM) L3 scaling support on QCS615 SoC.
This series has functional dependency on [1].

[1] https://lore.kernel.org/all/20250702-qcs615-mm-cpu-dt-v4-v5-3-df24896cbb26@quicinc.com/

Changes since v1:
  - Updated dependency on cpufreq patch [Imran].
  - Updated SoB sequence [Dmitry].
  - Link to v1: https://lore.kernel.org/all/20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com/

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: Add OSM L3 compatible for QCS615 SoC
  arm64: dts: qcom: qcs615: Add OSM l3 interconnect provider node and
    CPU OPP tables to scale DDR/L3

 .../bindings/interconnect/qcom,osm-l3.yaml    |   5 +
 arch/arm64/boot/dts/qcom/sm6150.dtsi          | 148 ++++++++++++++++++
 2 files changed, 153 insertions(+)

-- 
2.43.0


