Return-Path: <linux-pm+bounces-39886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35858CDA107
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69B9530AFDF1
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D83A347FF4;
	Tue, 23 Dec 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="djir0/sr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VoVh02mm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F7D347FEE
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509737; cv=none; b=vCKQKNZyGZkH2xa/7R7v3o3qNfJqjP4a6MpHrWrervu20QcET25piFhgSAvcp/y64SQfP0fYymncaCOkCLIbGwU0FMsbFqbGEICRTFM8je0fKpUO9MJ+5P/oAAWfRvlcQbNr0kduSwEE+5xhOvG3YiNj1mnKdcBCiTHHzJ0OeUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509737; c=relaxed/simple;
	bh=0rsUdCdVzH+igD6u68w9uIiPh6ggbgRgiwDr1wBAjm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VxrtbtXxi8u88MFc+dtJdTIr260tdForqK/nObjLxpg/Gi4uKEndeyUnY2fhoT8OKp7z5y2ZsuWxSQo8XwoHFwSlvxqzso9FCsadUi5zd2H8iSqoNtb4cwEHUmwNLk4FRqwQnIYFIxxq0pAoqnDcnlTj2r3D8Skuv3T3gtI+Oo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=djir0/sr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VoVh02mm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNFHcaX4045106
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kWKchhYmME2TIdgWLH1Giry57SQALMGVaYfhAJiBNzg=; b=djir0/srkYtHhMZy
	PbTFSV+M1L/GEqN6mMAh6j6dyBY4DcYdLwvhpoyjz2zIm/D0K4l+2FI2NRcMvWHV
	h2miwNwtXuRIvxXly/jgJOaErGWQKvluSOHwapE+Q+DgaOACx26Tx6LVrCpz2IPw
	sxu5eK0GlZ2e4xj6vZSOzsa2kevbimgd4pJTzO+WIYwiR9ScRfTR31Mdpq3vByn6
	iE9bNzg5B8rP/bZbxbu5DqbtqpoTBDiYRr9vetkqyKb2dKIjLoWYUBV8Hp3izTaf
	6kfCsKIl+zdYj6QRC8McdtwE91DJmhLMXr2J/sQwpmrkLWhtTu+6y8aIzXrueGzc
	VWSwDg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7cuhbedg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0b7eb0a56so136830655ad.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 09:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766509734; x=1767114534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWKchhYmME2TIdgWLH1Giry57SQALMGVaYfhAJiBNzg=;
        b=VoVh02mmq6JcwyJgv2TKuuwgGEyNPdzTgnwqQbeqhO0voHHBhcP0+S9Io+sDO1kjKz
         Pj3+sONdZPJv6FMH9PBRp7aXNSykEAZXtXKvHAH/MXyx8LeIuOINa0rfyY0Ei8PgNPgT
         S74lz66mRb3RH9ApmbDPjjjjLYBIEaS9AuNXVVY2qA1NCl7I7zOO9r30jNMkuyBTPhWv
         rnqo8ya8SPY3c+qADXK0WW5NYnCCqTAmV0GAW/pxdNP88GK00YIPnXR4dbtyRX3MiKE8
         XePEPVZpKV2nOQ2S95c9578wpEaWfBANa+3cSE3p1GMaXGlSah/C3N6QmEhMohoYapTk
         d+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509734; x=1767114534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kWKchhYmME2TIdgWLH1Giry57SQALMGVaYfhAJiBNzg=;
        b=lagGfyqIZRaLTncB78+GMI304yHppO02GtIJFdzM++WZ2ciMHKD+EMrSp2BfGI7qRB
         n2zPgg85Pg98D5f5m9isTT0H1cESFuYjAr4BCjPjJNyE5fGCsY8bLCCS9xI5aGZO7KU9
         fBr6BpHUhfF3vMKX9VYxrmVhmn8klB5XyKXpybo4n1iih8ssiYE9oDEP53BhvbRFmowP
         RQd3SIVVXrMXmUYUhAimFk16YpYPGZtmcfPe2KvyrQ1ifrvLAEA+DOs2Q3Yf4STsY5FS
         n7wAi+N8yuBLLF5C4IGtjH1+4UtQ/MK6O5TMpU/ow/SMoPMgvqk0VSWUsiESvWc1o9yf
         TVUg==
X-Forwarded-Encrypted: i=1; AJvYcCXeQUPqO16sn8oPCs3udNmMk8Q8vaJtIRR/ooYigVg/VOC4ELrFQvcfGCcUsm37Jog7MhNWPs0YIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbdZZU6MJWNkHG324W2igzPyEOT+wcORlwQtkBXYDhzvM4I8Qj
	b43JcFbb2wpuar2t53ZgSKNMD7bYGc1m5D6aS2huywPAYmX+UexBsjP06aJEsFyJajJ3Gqef9At
	/q2cFu2gNIvzQqa2ZvSuEylLsO49CyYzQg0FAMict8JXEnJYXikvwvjkfWt9uqA==
X-Gm-Gg: AY/fxX47TJL9WaBy4Mx/ZXlGFEmUWhDPay2pIZgnxxwExkmQH5ThHikVoivmBl4ojtq
	s+hAj93mQ8z4trZgf0/vl/l7NH2zwzX2fB5jo5FcQGmUU7YQxWIo0jiYTm7VQG7/zQb42vE59PX
	hddF06GXmSOrXlbSugFwmzizERKCiIAJ8Qk6PtBAwTWhFkLRRv1yZRs6EFwMGhpatUungZrKjwC
	nDDW2PyUBQxdPYpvg1TPXUgsr2FUSrLfqLsF/I7imqXayb/j0ChSbz6D0U7MfXMZE/UfEnJR9wq
	8E8c4WKES2OCP38cUo/fc86b7hW8H84o+sPHQ4RGT+dKlykfuWBPjAAeXia7O4vP8LJ/pSauZqM
	3cj8C7oZtS0eUf6Q40wPrbzhOztejWttPItbmYFWahcDiAQ==
X-Received: by 2002:a17:902:d547:b0:2a2:acc5:7a42 with SMTP id d9443c01a7336-2a2f2833082mr153875935ad.48.1766509734587;
        Tue, 23 Dec 2025 09:08:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3BOO29YtCZeSocm5bw4OEe5WRvx83A2dEk1ULNixXLH3yXehKh2ztNeHGe61KoH5qcRQlmw==
X-Received: by 2002:a17:902:d547:b0:2a2:acc5:7a42 with SMTP id d9443c01a7336-2a2f2833082mr153875355ad.48.1766509734023;
        Tue, 23 Dec 2025 09:08:54 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d863sm130019325ad.80.2025.12.23.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:08:53 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 22:37:41 +0530
Subject: [PATCH v18 10/10] arm64: dts: qcom: talos: Add psci reboot-modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-arm-psci-system_reset2-vendor-reboots-v18-10-32fa9e76efc3@oss.qualcomm.com>
References: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
In-Reply-To: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766509672; l=1101;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=0rsUdCdVzH+igD6u68w9uIiPh6ggbgRgiwDr1wBAjm4=;
 b=M6t2WQm+DfzWeVcmizN6fQJnXCGH5hGQ4Q/0xf5/jF/Oal8bkHcXh2BlAuR++9oa67NuXqXLn
 M2qwoeEe7ByDSYZkJJ/S7BvqYMDmGpBhjYqKOV+vY7OoleP0iESUs+z
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: 5b6JMvZ3KYmOCRm3BiJFp0smq_nr8f8s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE0MiBTYWx0ZWRfX0CzbLYFGAt9L
 WwTykyKZXZGDF5KegmGyjDNJjcAWrpBO3PPwD44zdamtYxQs0pX6EemQ+J+gtQmVtWeLfBdqMXX
 V7X2DqH/Ee6iTjSOjgTZPeJiqYyAtWpy2uaek5D2MornuCj9SMjmD/OLC7JJuuhNpwt8aqK4dTm
 X6GQcxaja1vaKiefG+C/qwnqr+jBSooPXbOM8bh70ki5JDIG8+Ylrd4yBTBKZwRiJCwsXClS0rh
 NTfguO8xedbS2v9jDW5MG2ATF/f4+wzNLOmBXDKCUK2kL54NHSeYBKufPmHq3yRJbet40dweh9Y
 tjFGIVQqfhHVlJNFTiGrhMwDbTawAz1Ba6sz95aupSeFJDWiqnOHBv4zeUnxDVWk4cMIjVNmaCl
 LXe3JX7zrVU+12wWPFCwG2i4O3+oKoCx04n0+TPGNrYoB3/KywvWbTuStKQ5DsvOtL2rqdOWItO
 IAIBNO47a1il1GQf4EA==
X-Proofpoint-GUID: 5b6JMvZ3KYmOCRm3BiJFp0smq_nr8f8s
X-Authority-Analysis: v=2.4 cv=NZDrFmD4 c=1 sm=1 tr=0 ts=694acca7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=4cuBwC7xTQKafrdxVH8A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230142

Add PSCI SYSTEM_RESET2 reboot-modes for talos based boards, for use by
the psci_reboot_mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Signed-off-by: Song Xue <quic_songxue@quicinc.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 95d26e3136229f9015d49e2be22f6b28f1e842f4..11a2cfa209065776a8ae61c6e661c09bb871c400 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -613,6 +613,11 @@ cluster_pd: power-domain-cluster {
 					      &cluster_sleep_1
 					      &cluster_sleep_2>;
 		};
+
+		reboot-mode {
+			mode-bootloader = <0x80010001 0x2>;
+			mode-edl = <0x80000000 0x1>;
+		};
 	};
 
 	reserved-memory {

-- 
2.34.1


