Return-Path: <linux-pm+bounces-39854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35888CD9438
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E64C8300C15C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CA0327BF8;
	Tue, 23 Dec 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOXfdVNv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aKLt0Fgh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE58021FF4C
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493213; cv=none; b=Sn9Bo3BP9qjTL3FnjGD/BKKbjfoUVZrjlyrAdRWSO4ZVL+qXDjRDhOoI1fUT8XEIZ9hJW/i4UHhpJRhIClY5ExmGJJNdwX5OQqRLTGEtT6nrjwC7hoNBK25FrZMckvXIgdLfyCNcr/YW+hCQwymPVara1z5KCgkbE3nBdulZcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493213; c=relaxed/simple;
	bh=f2DblYm4IikIkPOUFgX8XrTdAHk+qkYmAbd1e3uBOgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DwwTKfxwtKb0Kg+Y3dbbNM5t627A+YPrd092iQpYZst4cQ5kZPVWmGl49/A6WRXgph5UAo7EIoGc+s7L15PpScktR8NeINhlt9IIO0JbzuURE/C2yVMDuFAK0cPUMKmo6qsdzivfz4N4YhA12XIzDxx8ewwCQ9QapV1UjNnLgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kOXfdVNv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aKLt0Fgh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN8YcNG2747324
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 12:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iIv6qtwkYZND/FKNsvT6qnTFLyLwW4dABnX
	NrT6027s=; b=kOXfdVNvjDBLuAb35qvoJ2wS+p0z597xUL4WJL5GBA1jSNFxgQz
	9JhK5jIlxGfb2HShGYb6Vo0q+oQt9ptFSbo5Tt46neFFnRkF8RBp/kSdKel3nk2S
	si6w/FQHi7rmqcEWKKQmW8asg9rOhMyjckNU3KvxIU9x0gKWuMFwdzVm8RTkTu+q
	goUOEulUPBPh8CuvlFg/DBIFdlTkQBjDPidiYm0bZ9Q0ySII1/uTf2ipdaFQ2txm
	SmlJI2ij786APVYLWCCWtDb0ARio11tESnxo8uJTZNW8RXLD7/WHN/dK4RDWK+n+
	6IVs3GHtc9vJDcV7CwNjx/obsRU+bFHUBAA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7h5ct2vt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 12:33:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so6314885a91.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766493210; x=1767098010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iIv6qtwkYZND/FKNsvT6qnTFLyLwW4dABnXNrT6027s=;
        b=aKLt0FghpKTKWJJ9KDnQe/Xf7fnQ6OzymBbk4RGqnkCXz9QkmfkNcFG4vQRGfWh0iO
         cPGu2fT4nlYXbSTMtJPpZ+BeiI8cprQXSGtjpF3HorZ8dwqj82KJvbxPxUKcBR3+BRGQ
         CnYwZyn0pw2x94ovitO3oSsds0nWQLBRUprd5tNmfTP9LN/Lqg51YvqWcDqwkfQpzU0W
         s/0dcPklg1shehHgz75M9zMD5FWzBU9s7wZrpwzlu5Y1xrJnmcqvDd/RaWiEFnnfGoBy
         R53QmT3rO8YjK+85iDU8ZebdGqID27gIKWvd9eW52eb5pHKtr3z5OZRtFc+YxZYyajpY
         Z9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766493210; x=1767098010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIv6qtwkYZND/FKNsvT6qnTFLyLwW4dABnXNrT6027s=;
        b=ZQD6guzwlPUVIQSWrsNYXLEaf/Iyc80+HxozWDv+rdO+W+omvslTia6lAMRkr2lxG+
         ebAmrlyGoeykL7TAGmOnZ1lHVO8JMFesylyPKjkqW2SboBt5uc1C4vRAZfCmD94RmUnB
         RDfp6t5s508s4umRPpY4QVDpQiu7iG7po6G8VtPDN0NZUFZo8/TV3nt4OQ/abyZar0Kb
         9toe8158BL/TYL0wmQNfad4aDBgmWKIaCb+HzWaIPFd2So5km72pTysC2BnnxHEQ+HvN
         TfEpK4czts/VE9RBVwDWtRbnKXOhDp3Mu4RFM8vmjeE3gp7lAOKTZ67kj1ZIuWuVC3h5
         IIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLxuyFqxbUMPtX6bN5xNPlY0QII+L11hQ2nElSuGy3qmTJ7LTTLZcPbt5FsBilIEb2IAToMS787A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1KooGIotM6OXi8aa02klgK9ly/KZ8IC8an/VQLM8glRu5v9E
	2iZZGaxmHbRufY8YKdo3gfec7VYrBPDgAL7yxXq0fq10TnVQH8kH2/ExUO2d4bFkdRQgh4906vm
	vdAkRsC4PBw+sqLYXQwto9rLsnrg7+RZh/xyo90bEPnhpACLSnSKX0+oOtHJC3g==
X-Gm-Gg: AY/fxX4hccuiitVdaRFYCh5hBL3rK6UUR9MJSHH2tEyOZpY1iUOl6isPsvD8LFFtUFQ
	DZ/M2DjEoneZa72h2lzGj9o282BLVtifBSVHD9iihU0tFnSF0Sym5u77hTqd59bji1MH5i04s6k
	6o4Kuzxw2bsl29wX1jCE7qJ5GlPl9jxrb4ueHN3f+Rg1boNTbEQDydETazZZUd97wFStJBneqz5
	jtbSe8ml6l//fPAOE0S5LgH+KnqHnUPgE5JmaWeKhMwuq9epwzG2nVMHt64JsxcdiTV0SaprZ0g
	BC2nUWNooWysdBF8neCBm2E3WFFpUwzCpCGpX2YYOS4kzmIrHz+rnNh8TijgLCOrl427tZmMAWv
	iX1j7YHYXNh/tPTOqfxrYYkAKbByh1ipEz7AR9F8=
X-Received: by 2002:a05:6a20:3d8a:b0:35f:27d:2ded with SMTP id adf61e73a8af0-376a7afab9cmr14396110637.25.1766493210227;
        Tue, 23 Dec 2025 04:33:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrHGyedb2Nt685yxOgPioq2kyEt9iYKz++7moPb/2qg70fnbdX4GNWq8699m8Tg1kHPSqq7A==
X-Received: by 2002:a05:6a20:3d8a:b0:35f:27d:2ded with SMTP id adf61e73a8af0-376a7afab9cmr14396070637.25.1766493209702;
        Tue, 23 Dec 2025 04:33:29 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e921b39dfsm12936044a91.8.2025.12.23.04.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:33:29 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        konradybcio@kernel.org, amitk@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH v1 0/8] Add RemoteProc cooling support
Date: Tue, 23 Dec 2025 18:02:19 +0530
Message-Id: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEwMiBTYWx0ZWRfX3j66lRlfQXRe
 5zcL+Zj0FM46OmEmZkxe7k1F1qbUvylilPIJjPf40djBfIin/2MltpqCPKcil2bKoqzqBg6yWc9
 yWOYN/XXjAaBRolcThTKmBIGixtXVE5VENf2D0oR7nuyvHs3rm/t6fdt1gir2fiQTfy4X/Fqfu0
 ZhDWLM358crOO82Yp4t1+3ReYU6cDdyZB2wfL0dUJCaiehQfZSQS64tKalOK+J0s3utWkFc4bQU
 gsg0YnwnJY9BMuWvoVDuJEfvDUDHqolWDK3iWudMrvEqCe1t5O/rtd04l364vsIvPOGlw1Ztwfe
 KnxExsVyvaEvFXZccL8ltGTMbxpdp1qwCqFXEdztYIy2iDVAy/AuMds57re7HTHbNsLq78gqIWY
 vehvDytNRE0OVWSYryMLyPNj7I8AEhDiMR1F19d7N33gSiSuDZPJWHnrzIV+0OXciEOmjOL/FX2
 gmAzQo7vgKK6fE2o2LQ==
X-Proofpoint-ORIG-GUID: 4KVnRjs6_h5-tLWeFqZhQwKBKdDi_NNi
X-Authority-Analysis: v=2.4 cv=LeUxKzfi c=1 sm=1 tr=0 ts=694a8c1a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=gDoSkZ6CafnO6Uh0iTMA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4KVnRjs6_h5-tLWeFqZhQwKBKdDi_NNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230102

This series introduces a generic remote proc cooling framework to control 
thermal sensors located on remote subsystem like modem, dsp etc.
Communications with these subsystems occurs through various channels, for example, 
QMI interface for Qualcomm.
 
The Framework provides an abstraction layer between thermal subsytem and vendor
specific remote subsystem. Vendor drivers are expected to implement callback 
and registration mechanisms with cooling framework to control cooling
devices.

This patchset also revives earlier discussions of QMI based TMD cooling
devices discussion posted on below series by Casey: 
https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/

That series introduced Qualcomm QMI-based TMD cooling devices which used
to mitigate thermal conditions across multiple remote subsystems. These 
devices operate based on junction temperature sensors (TSENS) associated 
with thermal zones for each subsystem and registering with remoteproc 
cooling framework for cooling registration.

This patch series has a compilation/runtime dependency on another series [1].

[1] https://lore.kernel.org/linux-devicetree/20250822042316.1762153-1-quic_gkohli@quicinc.com/

Casey Connolly (2):
  remoteproc: qcom: probe all child devices
  thermal: qcom: add qmi-cooling driver

Gaurav Kohli (6):
  thermal: Add Remote Proc cooling driver
  dt-bindings: thermal: Add qcom,qmi-cooling yaml bindings
  arm64: dts: qcom: Enable cdsp qmi tmd devices for lemans
  arm64: dts: qcom: Enable cdsp qmi tmd devices for talos
  arm64: dts: qcom: Enable cdsp qmi tmd devices for kodiak
  arm64: dts: qcom: Enable cdsp qmi tmd devices for monaco

 .../bindings/remoteproc/qcom,pas-common.yaml  |   6 +
 .../bindings/thermal/qcom,qmi-cooling.yaml    |  99 ++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/qcom/kodiak.dtsi          |  36 ++
 arch/arm64/boot/dts/qcom/lemans.dtsi          | 138 ++++-
 arch/arm64/boot/dts/qcom/monaco.dtsi          |  92 ++++
 arch/arm64/boot/dts/qcom/talos.dtsi           |  23 +
 drivers/remoteproc/qcom_q6v5.c                |   4 +
 drivers/remoteproc/qcom_q6v5_mss.c            |   8 -
 drivers/soc/qcom/Kconfig                      |  13 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qmi-cooling.c                | 498 ++++++++++++++++++
 drivers/soc/qcom/qmi-cooling.h                | 428 +++++++++++++++
 drivers/thermal/Kconfig                       |  11 +
 drivers/thermal/Makefile                      |   2 +
 drivers/thermal/qcom/qmi-cooling.h            | 428 +++++++++++++++
 drivers/thermal/remoteproc_cooling.c          | 154 ++++++
 include/linux/remoteproc_cooling.h            |  52 ++
 18 files changed, 1981 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
 create mode 100644 drivers/soc/qcom/qmi-cooling.c
 create mode 100644 drivers/soc/qcom/qmi-cooling.h
 create mode 100644 drivers/thermal/qcom/qmi-cooling.h
 create mode 100644 drivers/thermal/remoteproc_cooling.c
 create mode 100644 include/linux/remoteproc_cooling.h

-- 
2.34.1


