Return-Path: <linux-pm+bounces-37657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F84C425C7
	for <lists+linux-pm@lfdr.de>; Sat, 08 Nov 2025 04:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1DE188C795
	for <lists+linux-pm@lfdr.de>; Sat,  8 Nov 2025 03:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EF42D29A9;
	Sat,  8 Nov 2025 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="crj/lZcs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i8vEI0C2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2E2D0C78
	for <linux-pm@vger.kernel.org>; Sat,  8 Nov 2025 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762572223; cv=none; b=Ei+vn0jP01LaLlEyefwl9B/eeCj7F2/MTQF612TjMUJyF32Y+SKdK2F9c4bArcjuyqqieIBhBDc+ZKLgyB43Rfi106ke5+HnNEIQQiEr9V4uYHf52vHhbfFZZLC5+CPOakJZnoIqZQ8pBJ2YpnShUzQ2Bz670jtYlDMfFhrD998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762572223; c=relaxed/simple;
	bh=Gdnp6jYIXA7d23ypy6BccSCLfEp5aevtpcimBZd6xFk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PrvmST2Pg4/6eB+TEJGOQBxkZAFd1EZ8s03LxGs4nzmoz/hQPxg5XQR0fYY9lgE0xgNXfOBBvqp8jiv/fRir5mp1UjjUn83qr/NwH6Zia4dntcJgfUiSVq0eB+6b34dO7WDac/yBo+TShqqRR5yUCsppnTXnC2BMgbgK2cz0MGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=crj/lZcs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i8vEI0C2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7DPNin3129725
	for <linux-pm@vger.kernel.org>; Sat, 8 Nov 2025 03:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UQD+AnbpjLp+8MO+oABz15
	H+UXUQBW4nkQHQuBpZOGg=; b=crj/lZcsGVYal3MHooyTUyOEgfEaEWcJibZsX3
	C6Ixfk6tXPk8B0cob9sEgpTatFyUgGoPTRBxO2iHDyLjqArwfYDZDczjTUDYkY54
	ja2ya9/K4/WhlrQTFrx1A1SrB79h7dEeTkqDpZprcEOWKmJ9yr9zx5gIy/ixklOG
	1ZwDZ3uzRK898UADGhaab9DE2A3MFOTdxhnWVyzxmtqBCl6KuhKZJ13AI0oq9wG6
	BPWp7WT8Ak1/m3UA32XonZGiRzrw1twFdcfzZ+vXEQzgrV+1evQnnTZ5JC0itIqJ
	AHZFdlV5HXyJmKpjzc300/+YV2UL+38v4pJJ1tHbVcCXyeAA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9hn09u0h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2025 03:23:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29598910dd2so31554675ad.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 19:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762572220; x=1763177020; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQD+AnbpjLp+8MO+oABz15H+UXUQBW4nkQHQuBpZOGg=;
        b=i8vEI0C2cdmbvcJidALaYNLmTVt/75EzafcKWlzH9Z71e+mU8e0mWhGR+F/t1iB+QD
         VfTQhPSeZ2OPPAZg5BpSPAGnt25yJ2IfNoelmb+Vi7RQn3pejV+kwVphbe4Ztf/PywUe
         8+In/y9x/9ZzTGssem/DONoQxZbf1uyO2TJjhzCjMrHZGUdYTPBuMgw3gwCM5lpHFFaJ
         Er4e2C1C/MFwcveCIKK17eeptH35BxEQHR8zpF248JuJj60tI9Tt0pdF6A1rGfm+I9P0
         RC0nxtaHA4QCsDuXZPFFQyTPc2rgsgbV8pV1HdDMeYRnSRpIN1/MviX3RdEk15ShvmB0
         4EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762572220; x=1763177020;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQD+AnbpjLp+8MO+oABz15H+UXUQBW4nkQHQuBpZOGg=;
        b=loJrGY2DK21b4/bAGt3/qHT2/cHm6t4dMtArV1GBWf4yZk/5jtxxVrFBeTZXKyhlN5
         Obetk3htokh4bgZSk6HxAigd0640kGYEnzcFD0t54FFBh+yt6jl02Ophlp4dSp2FZ78/
         CHwfR7wFYuN9TYp0x/bjIWyH9JAYuiHrjEcnFukj+QPZXA1j6lTDvvnwWASvGL8jMTeX
         wQZtkoCw/WMHw9/WDW1MJMM8uODXHizm63szo2abuMrH1PrXyQtMyDvrD1qIUH9GD+L4
         15a7vvNgH7ck8VWoWBOQCPSp03qL0IGMrDeAAr0Vfyq/Vv09SR8Le5ot8CEGy/tYvY4S
         VP/w==
X-Forwarded-Encrypted: i=1; AJvYcCVGdQpicyfwD9LAY0k/HkEdBDJPLYIkV81h6ARcWPjUFphcKcR9HlxiqVvg1MZujQE1NfgpQvknfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0NkwkOiRjn7xwRP32WlWqvdEqn+/TcrA3ZGuMha/XTfobAiii
	IwbZajwp8rh2CX9ScYODTl1q32D8FTjQuKrqF/3wWswfk4QhLndPoYJNF19Q16pgaVAsDYJLQWn
	b0GeJal81NxhA5wPVmd/TtELFPsYnMX6GpxDHLj5YYw+EunDG6VrWhqbn0RnDKw==
X-Gm-Gg: ASbGnct45lY/wzSTf45vFhG3iBDIMiuLIbcy86xgJHSxuxhJbn/aNcSaeR9tJbO1MJF
	C/mKad2iWaUnf9PhrN9x5MM/T0lbTRumhM0Jb+RPB/dLHUs+31ynVDr3zqXGvIVpt34zaEnCstt
	VTVeok1Bmtm02ylN/OMdLKvIVAl2MVvncVmE+CODrT5IGCFyugBMEZ29/L9JpaBO51ZkSQAvCvP
	9L7pvdEV/R28Xtg3GgXQQ0GLkT8kqwj3s8t5ms5I+73kkqHeAX31sDY5m6K/gwrAGgNydFmhFZ7
	FX9HVk3dvCP+2qEWsZ1efdbtBcTDud3wG7PGLqg2iRV3wolm4vp1rwjEaMLYFNDhpzSyL+3Ctqo
	6WVjFgtOACRfqWqhs+LPrrRimuAFhCjc=
X-Received: by 2002:a17:902:ecc6:b0:295:f1f:65f with SMTP id d9443c01a7336-297e56b8528mr17465055ad.31.1762572220358;
        Fri, 07 Nov 2025 19:23:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8USEyiNCEiXp2OT9EbZJesOy/WV8hNF2yLgYyzUYE/6Zy5ACi2czutGoJg718PBBbBxmkYw==
X-Received: by 2002:a17:902:ecc6:b0:295:f1f:65f with SMTP id d9443c01a7336-297e56b8528mr17464705ad.31.1762572219838;
        Fri, 07 Nov 2025 19:23:39 -0800 (PST)
Received: from [192.168.0.104] ([106.219.179.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d83c941esm19942445ad.44.2025.11.07.19.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 19:23:39 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v2 0/4] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Date: Sat, 08 Nov 2025 08:53:18 +0530
Message-Id: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKa3DmkC/zXMQQrCMBCF4auUWZuSSUwtrryHdJHWiR0wTU00K
 KV3Nxa6GfiHx7dAosiU4FwtEClz4jCVUIcKhtFOdxJ8Kw1KKoMotZgHFl6JU6N1o7FvnLVQxnM
 kx58NunalR06vEL+bm/H/3QmzExmFFO2xNw4dkqH2ElKqn2/7GIL3dTnQrev6AzKJJKejAAAA
X-Change-ID: 20251103-pci-m2-7633631b6faa
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3581;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Gdnp6jYIXA7d23ypy6BccSCLfEp5aevtpcimBZd6xFk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpDrexLthZW1QbVwJ+5bGWI3fkrcZNliIDoJvKd
 gUglQuBXF2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQ63sQAKCRBVnxHm/pHO
 9d9QB/9FD3dsNu0uaPnLM0yo7EQwcEweLwyFi/H0JtF4U7Isg2qKBsDzXaybv0pAM/xxclG4Svm
 7xP3Yy8/GxiBj0a6cqq3lOsAVqp0Rj5V6ZcVqLrT5j7+42doHx94jNfe2fkpv1eWfixAV6yMYQb
 3XtTkboarpDsg0xc30ucNgzDxVl9b2FYwQ7l4aP+HUWse5t1TxRn+1fzvCB4g7QUShFIA0WVpwk
 YyG59vG9twBP+N/nuzTSt5Vf1I9iwRJec3DHMNPgT9QM+5HbKbChohzFuSgSKNzEFfsgowud8VN
 XIEaQkMknmT/QPYHykAKaZkC9C6A0LaFipVcUPaYg6S933AH
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyNyBTYWx0ZWRfXxcuJ5L3yjJ8l
 gdD5aZaCNJBU+RHeT6d0+b0QDMljzwM9Ac/YoD00+Ye+V66FocL6UL1G5VcPWLV3uiVM0dwWO81
 mLVIHUftYvQH6nGSDZi6x3wL/SPqwKHZpuRbcLiysGN3/Dtw88n+vsBRr8BjHqafg7LJ4M07Jwi
 TH0HU+3Feh95xn0xurLuMWtFmUnBIiIcPmPc8E9MqKtktoRZWSWmf9vQUlyjjgS0nwRn9vo3LPx
 wVYtsKxVLleAb1hkUFQ+K6XNjFKajHdBYZOOmufO9FZSB4/GuGLSuzTWAr3CgOQWn9tUPXPi/7V
 qkmAE8MYSYWYVHG9nKGAEmYW30JeLxRxkBflOrGWC6rDrqfDj9BqoQzdyg1u2v0ele4ljn08G9j
 bgS2ppAzCW9uRQkQynXjc6ShFEVUIg==
X-Proofpoint-GUID: l08rOSN65rbs4TjG66ErM6MqrB5rLltZ
X-Authority-Analysis: v=2.4 cv=MsJfKmae c=1 sm=1 tr=0 ts=690eb7bd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=qronr9GGDLuyXDLutoyxMA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=3P-LAdjlN1q_Sw6-dOgA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: l08rOSN65rbs4TjG66ErM6MqrB5rLltZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1011 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080027

Hi,

This series is an initial attempt to support the PCIe M.2 connectors in the
kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
in PCs). On the ACPI platforms, power to these connectors are mostly handled by
the firmware/BIOS and the kernel never bothered to directly power manage them as
like other PCIe connectors. But on the devicetree platforms, the kernel needs to
power manage these connectors with the help of the devicetree description. But
so far, there is no proper representation of the M.2 connectors in devicetree
binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
and fixed regulators in devicetree.

So to properly support the M.2 connectors in devicetree platforms, this series
introduces the devicetree binding for Mechanical Key M connector as an example
and also the corresponding pwrseq driver and PCI changes in kernel to driver the
connector.

The Mechanical Key M connector is used to connect SSDs to the host machine over
PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
support for driving the PCIe interface of the connector in the kernel.

Also, the optional interfaces supported by the Key M connectors are not
supported in the driver and left for the future enhancements.

Future work
===========

I'm planning to submit the follow-up series to add support for the Mechanical
Key A connector for connecting the WiFI/BT cards, once some initial review
happens on this series.

Testing
=======

This series, together with the devicetree changes [2] [3] were tested on the
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the NVMe SSD connected
over PCIe.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts?h=v6.18-rc4&id=d09ab685a8f51ba412d37305ea62628a01cbea57
[2] https://github.com/Mani-Sadhasivam/linux/commit/8f1d17c01a0d607a36e19c6d9f7fc877226ba315
[3] https://github.com/Mani-Sadhasivam/linux/commit/0b1f14a18db2a04046ad6af40e94984166c78fbc

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v2:
- Incorporated comments from Bartosz and Frank for pwrseq and dt-binding
  patches, especially adding the pwrseq match() code.
- Link to v1: https://lore.kernel.org/r/20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com

---
Manivannan Sadhasivam (4):
      dt-bindings: connector: Add PCIe M.2 Mechanical Key M connector
      PCI/pwrctrl: Add support for handling PCIe M.2 connectors
      PCI/pwrctrl: Create pwrctrl device if the graph port is found
      power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors

 .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++
 MAINTAINERS                                        |   7 +
 drivers/pci/probe.c                                |   3 +-
 drivers/pci/pwrctrl/Kconfig                        |   1 +
 drivers/pci/pwrctrl/slot.c                         |  35 ++++-
 drivers/power/sequencing/Kconfig                   |   8 +
 drivers/power/sequencing/Makefile                  |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 163 +++++++++++++++++++++
 8 files changed, 334 insertions(+), 6 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251103-pci-m2-7633631b6faa

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


