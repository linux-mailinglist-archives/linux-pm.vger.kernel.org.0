Return-Path: <linux-pm+bounces-37606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738F9C3F215
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 10:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA214188DF59
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628302E974A;
	Fri,  7 Nov 2025 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nGZKBUQ7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ohejp7i/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C72BDC00
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507366; cv=none; b=ZXcRb+sh7piBevffJKXf8r8PQJcmPKvfP8l7iBkMIM4f2Tdp+H9laAL8Xp/MHyDhpBSmqfu1PVWqXffxAEQf6qDCPn0lcAXxd08zc0lQ2odyMlSdUR5CelGrJo5QsCtfzoed4xlastZaYTwWDcRoo0WDEIPEnwgyPtFzlylxggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507366; c=relaxed/simple;
	bh=jSV3owYQwj8TXloQjhelaoFvE/YIUYBtRwJXKyKGEz4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J1b44KUqHQNNg9yMcbvwqYTO2EEUHjHTv8awNQ6+KYQD+UDpQcqu1I5EoGgFR6RDWT5hG7NZOnb8vFgPmLbkRgmrO8rvMybtpigTR20G2gQMpUQHTKP382ztMeoIeg4Buw1yFwMxCUiGs6NscVhE7wfrC34QGH6yL3bfYT4+01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nGZKBUQ7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ohejp7i/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A77MKPB629503
	for <linux-pm@vger.kernel.org>; Fri, 7 Nov 2025 09:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rml7sFCwBBhy1fUJ2Eq4Ln
	8RTDwSlPBGiG+lQMBBTlY=; b=nGZKBUQ7OyvMdtzI9a9YlbKQ+KAZ8N5xJLhHIb
	Q6OZM/e5SMTcs/oosKqnaixAETo7ce0jxklqK3vPoY99sR/8wfXVpmFmay7MH0QG
	0BzDtaKHPCGXb1aXfado5jZgHyVVyzYSc4qR7ZT+Ndd3YAsEmhoZm17GySuLEsji
	gdrM+lSdYy1pJY1OID3EIZgSnF+S20YjSA+hU8J5vLWIYVpRqVx8jCGSkgwAV86f
	Kb23I3zrIUm0MaLsYIwJkd65/I9fHJoENUCVL9lAsHkQmnkg+uRRoZGjeuAvCg5R
	3auhKtf4QDO4DLfWpsp6UxZnvI74bCdy+wBCl18SW33sWjgg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9223222e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 09:22:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-294df925293so7325585ad.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 01:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762507362; x=1763112162; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rml7sFCwBBhy1fUJ2Eq4Ln8RTDwSlPBGiG+lQMBBTlY=;
        b=Ohejp7i/Uv3Xvner5DfV+efEde/7JrsDzKwRQPUMCvjzUVN0WnvWkhsmBp/QBjdAw4
         P2Ax9xfGGJoKKnxRhnAjdUA1s2DpN7PPlZI0mVsveaSyIl7y5M0rhh9p14T+IF0iE0RQ
         /qhkyuQvl89+m6ki33YTWJlhmDySmaP9xeApj2JLu33pF27hHs6bGRPu3jLylT3wqDxb
         1PhR4wzv/eIcSuok6zPl89dMg0u4jBzCGQs19kVWd98fl/1wIcx+fZop/iOf9bS1q8b6
         /n/9eXCsfdB+MKcOwfTQD3rOiAAxkY9xIuRRDVxluHnjiZHM2JSCj7NiY/z/h1xXD+6q
         NAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507362; x=1763112162;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rml7sFCwBBhy1fUJ2Eq4Ln8RTDwSlPBGiG+lQMBBTlY=;
        b=q9rYgi+IGElcDdgS0pZhCrv197w+Mn2x9Faox2kH7oP5/LtgDxN8DbzoQckyI3wTfV
         mTyTCT6jiNjzE2RhlAAEPkOzBskrlu5agUDcPZij6lDT0Tw/IEWrOlOhmTs0qRKO1ssh
         8mPi5Owjc4Gu83H6ersLdGMEhD1wyK3Fdn60GpNK4e40ZIQ7nQo7l+Sx13MgZdHQD+Gq
         KJpa8LAr90Ps103gxKSRdnKAHe/+rQkmF99Me/RKU5qfxxznlz6wg85GZ0NgSOuFCKzW
         3qbAcJjPdTU5lYjgci97bQw+J8PaWQ8PVjK8WnHA/g7HWWNsmq/I4zv37VKjurBfxED1
         S5Pw==
X-Gm-Message-State: AOJu0Ywie121M6t0zxidChvopbynCVjH59gJ2sLxJ75ZL0yzygszpV4k
	Y0QaMTCZnyVrIKhVmNR7W/qM8b0qdNUIDyU9NgsAv8P3YmU5mnqkMSlcL1g0na9t1i0bbHovW/r
	wdAZf56mxfs0DWIQNrktvXVkvvjgOl6xCuVFP9uIrzYguKnTtF9rfc5Cneqvy6Q==
X-Gm-Gg: ASbGncsr58bDDiGDg83LSpzlE+Kurb6OthxI7OgRiuepURok9uIlnPDzm9FdpuJDHm9
	u1GyBYcDcXCAPPb31xQKpbOPFhqpOx0lfMmsX4NTs4FUxrbQZxKZoLuEtHvtsNPabVT1lLx7g3O
	FeVuT/vR58ngXol+FclGw7jrqHvZL+zYYzpi0bASM9MNjUp4JdgPfQX8481/GiFwhGw6+5B2xxW
	fpFTqv5iYcmfzocVjht8Z8NVcd/F8F08J9OepTtkNLpHx6W/m4c3IHyBux+DnEIqkc49QffXavE
	3yKXQka/t1Kyg53xMkx2e+6mrYLB7KefcRmQwf4yBB7HoCqwcwVBXKDcf+ZS3hOcFzgMTB2T18A
	fey1k9uh431YpuIp3FIPpCQAosiJf4+ykQw==
X-Received: by 2002:a17:903:2f4b:b0:283:c950:a76f with SMTP id d9443c01a7336-297c0478211mr29591905ad.43.1762507362322;
        Fri, 07 Nov 2025 01:22:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl0iokWVjZuHX3hyllOhwgGfaE3YHg+Yespi4a4AkspVo1v3zvF1j7QcmzRfMeYhZP8G3anw==
X-Received: by 2002:a17:903:2f4b:b0:283:c950:a76f with SMTP id d9443c01a7336-297c0478211mr29591525ad.43.1762507361775;
        Fri, 07 Nov 2025 01:22:41 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c747d1sm53241585ad.63.2025.11.07.01.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:22:41 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v5 0/2] PCI: Add support for PCIe WAKE# interrupt
Date: Fri, 07 Nov 2025 14:52:23 +0530
Message-Id: <20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE+6DWkC/x3MTQqAIBBA4avErBM0FKKrRITZVENQNvYH4t2Tl
 t/ivQgBmTBAU0RgvCnQvmWYsgC32G1GQWM2VLIySkktHrsi8dGHy/udTzEZ7fRgraqdgVx5xon
 e/9h2KX2G6qj0YQAAAA==
X-Change-ID: 20251104-wakeirq_support-f54c4baa18c5
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762507357; l=4617;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=jSV3owYQwj8TXloQjhelaoFvE/YIUYBtRwJXKyKGEz4=;
 b=BII+R3YrkoZan5Xaz3Hzsqqsf61ZQif4/ElY7e1gILB9Bv9xo0hUShekcT+lUcSG1SFm1uGdo
 kNvccKt0i85CxTUkzinLIlzf3Pao28s5Wm3Xmi7hou3+3Y1/O9dq83h
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA3NSBTYWx0ZWRfX6ZBLRXyLaVQB
 6Ffm0Pdpt22v3NvObZXkqgiuHeYNebYoprfCMrC108u0lvFBD/z6LJ7D+apMw7DA3bukq0BysPE
 D9jmCkqbLYfQ352noA3D0/y39SJ0xE4yiYiYUmEUjv9GeU2CSlYR1SsNnSwkDbcupm6Nc77qkv8
 wYkLgUYcUl+yQghyQathpLMtQZU8lH3iCX/Z17qA+Bxxy2tRHvoQ85Luuvy+BET0sls7gNF+mAl
 BnqkcbDMdDsgha2FowlknVgVEL1OQBd6hHhyVufBa8NvknvdmdwqL6MkGQF0If3pWduyzFvMW+v
 cBH9GNuzEXTrg/JSgZeHdYL2g+a786J0vjYYOlJHoJJIxX5KKAeKcGBKHNvhL2U3kPR17lS4kd1
 NLjixQd4Vhc53/m1a94lXncT7QgLhQ==
X-Authority-Analysis: v=2.4 cv=Csmys34D c=1 sm=1 tr=0 ts=690dba63 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ikd4Dj_1AAAA:8
 a=s8YR1HE3AAAA:8 a=Ly1ae7BopFzPCSorSWkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: uDEie0MAGXFoeMG2pPaCQnPUcezGnRyL
X-Proofpoint-ORIG-GUID: uDEie0MAGXFoeMG2pPaCQnPUcezGnRyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070075

PCIe WAKE# interrupt is needed for bringing back PCIe device state from
D3cold to D0.

This is pending from long time, there was two attempts done previously to
add WAKE# support[1], [2]. Those series tried to add support for legacy
interrupts along with WAKE#. Legacy interrupts are already available in
the latest kernel and we can ignore them. For the wake IRQ the series is
trying to use interrupts property define in the device tree.

This series is using gpio property instead of interrupts, from
gpio desc driver will allocate the dedicate IRQ.

According to the PCIe specification 6, sec 5.3.3.2, there are two defined
wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
provide a means of signaling the platform to re-establish power and
reference clocks to the components within its domain. Beacon is a hardware
mechanism invisible to software (PCIe r7.0, sec 4.2.7.8.1). Adding WAKE#
support in PCI framework.

According to the PCIe specification, multiple WAKE# signals can exist in
a system. In configurations involving a PCIe switch, each downstream port
(DSP) of the switch may be connected to a separate WAKE# line, allowing
each endpoint to signal WAKE# independently. To support this, the WAKE#
should be described in the device tree node of the endpint/bridge. If all
endpoints share a single WAKE# line, then WAKE# should be defined in the
each node.

To support legacy devicetree in direct attach case, driver will search
in root port node for WAKE# if the driver doesn't find in the endpoint
node.

In pci_device_add(), PCI framework will search for the WAKE# in its node,
If not found, it searches in its upstream port only if upstream port is
root port to support legacy bindings. Once found, register for the wake IRQ
in shared mode, as the WAKE# may be shared among multiple endpoints.

When the IRQ is asserted, the handle_threaded_wake_irq() handler triggers
a pm_runtime_resume(). The PM framework ensures that the parent device is
resumed before the child i.e controller driver which can bring back device
state to D0.

WAKE# is added in dts schema and merged based on this patch.
https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/

[1]: https://lore.kernel.org/all/b2b91240-95fe-145d-502c-d52225497a34@nvidia.com/T/
[2]: https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v5:
- Enable WAKE# irq only when there is wake -gpios defined in its device
  tree node (Bjorn).
- For legacy bindings for direct atach check in root port if we haven't
  find the wake in the endpoint node.
- Instead of hooking wake in driver bound case, do it in the framework
  irrespective of the driver state (Bjorn).
- Link to v4: https://lore.kernel.org/r/20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com

Changes in v4:
- Move wake from portdrv to core framework to endpoint (Bjorn).
- Added support for multiple WAKE# case (Bjorn). But traverse from
  endpoint upstream port to root port till you get WAKE#. And use
  IRQF_SHARED flag for requesting interrupts.
- Link to v3: https://lore.kernel.org/r/20250605-wake_irq_support-v3-0-7ba56dc909a5@oss.qualcomm.com

Changes in v3:
- Update the commit messages, function names etc as suggested by Mani.
- return wake_irq if returns error (Neil).
- Link to v2: https://lore.kernel.org/r/20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com

Changes in v2:
- Move the wake irq teardown after pcie_port_device_remove
  and move of_pci_setup_wake_irq before pcie_link_rcec (Lukas)
- teardown wake irq in shutdown also.
- Link to v1: https://lore.kernel.org/r/20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com

---
Krishna Chaitanya Chundru (2):
      PM: sleep: wakeirq: Add support for custom IRQ flags in dedicated wake IRQ setup
      PCI: Add support for PCIe WAKE# interrupt

 drivers/base/power/wakeirq.c | 43 ++++++++++++++++++++++++++++----
 drivers/pci/of.c             | 58 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h            |  6 +++++
 drivers/pci/probe.c          |  2 ++
 drivers/pci/remove.c         |  1 +
 include/linux/pci.h          |  2 ++
 include/linux/pm_wakeirq.h   |  6 +++++
 7 files changed, 113 insertions(+), 5 deletions(-)
---
base-commit: f04a8f2f1f04a77e65d96f5ee146957522002900
change-id: 20251104-wakeirq_support-f54c4baa18c5

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


