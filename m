Return-Path: <linux-pm+bounces-43597-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPQWEfd4qGnpugAAu9opvQ
	(envelope-from <linux-pm+bounces-43597-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:24:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D8620645B
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38B1230CEFEB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0663E3DA8;
	Wed,  4 Mar 2026 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pbsZk+aG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hM+h8wpL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D643E3DA2
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647460; cv=none; b=PBrwFeVhrt1UqPmvVAlUkHahbJLKFE+FzTQPyKprvgX9zboN88+ZpzFtDg3P9JJ7/aSDfyThrm+NazSHTpFsk2cgGMlKu96buOrPCqXP/bE3dwx6B6VXc0S47bmvNk3gOH2o+yD/Q+QTL6LlPy4znFzioo8sQZpaiVam4/u8JHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647460; c=relaxed/simple;
	bh=NM7cOAWz/hLiiDI5r8UMeAd4BHN3hlmXiVPhRwzC72M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SkJMXBWLFm63Ft8n/hz9TeM16QTN6+6suf0zZfKlLvDfOA5tCv4GX22DlxDUn4Q3DFmk8/6DSd5hIG+CTfYPSpeb1Yo+mSoKtYHNgPVphXLleyaFLbgo9CPaT0/t4ImteLpWx+BiPP2V8Mdor653kzNB0KqAoK1ZrmcyHE1G6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pbsZk+aG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hM+h8wpL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624HTFSQ1706225
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 18:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W1QU/6KPKUgk2iLlcEujLmkn3VsstnPbt073tBLoZVE=; b=pbsZk+aGi+gxjrK8
	N4J/vjUUTN0UbYZSe0fEU1RbFFflmLGkdHwSb1M7elIS6NbkactzNhBX5OAeeBME
	yC3at+uSxCUnGP7KiDs3O8JWoYOxRy4prmbJdDJ/wkzXaz3+Ubmcym0M4dqQ8o6G
	N5YDL57moKLePiG6SwkDE8ncuUIvqGWD2JjaZc67gHYAU29MOXfYhhLzIMXZL6N5
	oq8oF8qWtyt6SIkqeLm5orqzzwMncQVwErpUss0Y7fFvN+l6u89rjiFq7fRKEtlr
	mUjr6HWv4VKGeTILHnfOVTTltbGZ8h/TRkA4g/O5GSiHfR7L5Yv+T2xwiASX8ver
	1LTVrw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp3tvmpt9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 18:04:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35641c14663so7425771a91.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772647458; x=1773252258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1QU/6KPKUgk2iLlcEujLmkn3VsstnPbt073tBLoZVE=;
        b=hM+h8wpLK4/dFwEMG1cWAlyr1XbNHfiOnmGVdHv/0Hiv6oDBUJbN701jdZtxMPI0Vq
         Di2pvlL+iPK97m02QdfBaDYbjdxf4f/6L+HAhMe+eBVCXxBfxH7O3BNxX2AoPsewdwzp
         qECR2LHqv1F1QTPlmikLkOmE7n+QxvVRpnQaB/pVEKk39qpS0aIrD9nBRhVdaOsobozs
         OkLCaHNe1v+g1KU30E4Ur+YySc6xWbSJw7u4yxbNTIwxxgzAJNWKBqPSXwPVDCO7MMkT
         GZEJHfk80bVAYbfeoMxJj3OUx+0l6P6V1uKQZmmFbYc0AORNdEb/F/JBMcYUVwbCX83y
         xLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647458; x=1773252258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W1QU/6KPKUgk2iLlcEujLmkn3VsstnPbt073tBLoZVE=;
        b=C2cFD85bzcRGcmbos2nmu895ucbJ8BdlyxbB9aMaXiC4IMqBuxq6YobjnXf4dTECma
         RMLzsQlLGCDbYSpGxh6A4Qq0u1qBQoTE86bI+4TS91lws5V69zV7OC2wLAHUh6SPYMwm
         8tLNvx8fTiNB2z24gvayJ0fVty7PkML19IRHmDDCR6mAzY+d4CZ2kF5fssJQjZaMDBM+
         lbc5vXRCEfrCzb6tZPEqrWdk5uHITo9m+zbiXkBOPfqJfR0iIoGU7uSMmuXsHq3hRYmK
         n9/9cwBvyymrv8PXlLcOp7WstSW9FNYKrkD479IBJFB/JrkQnuzAAtr7S+zDO9LTKdCk
         LoFw==
X-Forwarded-Encrypted: i=1; AJvYcCXnBbI0svdcC1viUlkhgG56QrgL8XO422Rh+f5aYqSWbcAao4z+509ru4YDJRSJBX+TDax+WIA1Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCCP3pp4iUE6MYifNKu7LWolBMS2JYZF6E1xmSgvHhmXEQWj3
	EKCc8PYwaAafBNKTiAsQqU8Nf2wcqcuThzuwkmSVszwkMZce9TAiwgPkOuC0NjdwL3gJOsnNU6r
	DWUlVefILILWFK6fpEBeq09+bA5qn8opT8HNaoSHmHZn2uI9EVmVaIKWUMJWle04TJ1ZKpg==
X-Gm-Gg: ATEYQzyfaKvpFBkPaZdrsQU1ToN7uhvIoF6WDlVyCoQPWFU3jgEA5r5u0bw4dPmYh1V
	0Oc9R9+4HtTq7xCFlbdHJ+iGxZMuXuYyB+zYnIt/qgRUJqnhsh7zx1xjA5QBt4EMeR3MUhHDRYr
	meh3KB5nRz8tdV00xNfy/bWTs2C2MDBa0sCgkuPbJxrM621WerkycFEnj+N3qxKur2AkSJXUdCm
	kk7F+E3+wUu3H1SugHNQFcljl/hoMFcZMFCaEwmOh2W1wlPhoOLoycT4UqxytI+ccgmF+1sHXLL
	tES6P9Z5L01jBZwo9i85zRlLNQPJ4IKaamEm1qYLTahX4nIaormCTtfQJrY1LHoPJQtnKgFE26E
	jR0QD14BMUeQt6a75qAoQhhx8uVpRoSnQx6soBcSHXthB6cmAZapJBaJL1Q==
X-Received: by 2002:a17:90b:1344:b0:359:8e59:16e6 with SMTP id 98e67ed59e1d1-359a6a9f792mr2009639a91.32.1772647457874;
        Wed, 04 Mar 2026 10:04:17 -0800 (PST)
X-Received: by 2002:a17:90b:1344:b0:359:8e59:16e6 with SMTP id 98e67ed59e1d1-359a6a9f792mr2009614a91.32.1772647457338;
        Wed, 04 Mar 2026 10:04:17 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8f22062sm1080606a91.1.2026.03.04.10.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:04:17 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 23:33:06 +0530
Subject: [PATCH v20 06/10] power: reset: Add psci-reboot-mode driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-arm-psci-system_reset2-vendor-reboots-v20-6-cf7d346b8372@oss.qualcomm.com>
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
In-Reply-To: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772647398; l=6255;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=NM7cOAWz/hLiiDI5r8UMeAd4BHN3hlmXiVPhRwzC72M=;
 b=oD6nxBX3PrcdFEYrXB/z/9OA6OCArQKPjMUTNPBsYMzHjGuI+CLe3jdhs2EGceNA0PTw/Idg5
 kR63U0YmZh+BKfLFEJY5xadmMaMt1JIpKkR+gmqSqWPlNhp3uylysAu
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE0NyBTYWx0ZWRfXxgw3ZX/3sQT8
 dUSFr9+bQAch5IazivNgsBKEtqw8TWlGmCSfeH1gx+ak6OEFo+W74YtDonVowe9cYQU+4dLrwkI
 Cc+XAjyJstWYgSKJqVVp+I/jxv89jpnjkBcSiYkmq2DW1ciJxmX8CjWl8JVwEmoauMXpn2Omcvh
 qZWljP+dqdMLyzCP/kfWfAHZGZ16VrqTV3GbYOWk7CFZgwB1dKqMefFSlkmM/Xphnm+antklHEx
 5Xw6bajQ76HkMaQz7XfAA9C7xcbP9GxEb5O+X8RnVcQ8mWyeC96mwchGOMnUKRZaNEf1Vv4Etkh
 rfDKwwDd1jBZjzQwnCKRGbbVt7R5QlqvgRrFDa8QVsRrtOARinz7OQJ7UWRco8y8xh4g6+RtZD7
 yqwHPqbFIluj4iv8qtW9bVsN2Tz54zpgXWVsl8UT0787KgRx3K3+lPDRfeOKx1p9C4E7id/0rvY
 um8m33VoC46x5SZaDEg==
X-Authority-Analysis: v=2.4 cv=VYv6/Vp9 c=1 sm=1 tr=0 ts=69a87422 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=wQXJ-QnpPWzAIZmQQd0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: c-nke2RvNuV53CY8ISEFtLY6iwDyJWgJ
X-Proofpoint-ORIG-GUID: c-nke2RvNuV53CY8ISEFtLY6iwDyJWgJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040147
X-Rspamd-Queue-Id: 47D8620645B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43597-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,arndb.de,arm.com,rock-chips.com,gmail.com,linaro.org,ettus.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivendra.pratap@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

PSCI supports different types of resets like COLD reset, ARCH WARM
reset, vendor-specific resets. Currently there is no common driver that
handles all supported psci resets at one place. Additionally, there is
no common mechanism to issue the supported psci resets from userspace.

Add a PSCI reboot mode driver and define two types of PSCI resets in the
driver as reboot-modes: predefined resets controlled by Linux
reboot_mode and customizable resets defined by SoC vendors in their
device tree under the psci:reboot-mode node.

Register the driver with the reboot-mode framework to interface these
resets to userspace. When userspace initiates a supported command, pass
the reset arguments to the PSCI driver to enable command-based reset.

This change allows userspace to issue supported PSCI reset commands
using the standard reboot system calls while enabling SoC vendors to
define their specific resets for PSCI.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/Kconfig            |  10 +++
 drivers/power/reset/Makefile           |   1 +
 drivers/power/reset/psci-reboot-mode.c | 119 +++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f6c1bcbb57deff3568d6b1b326454add3b3bbf06..529d6c7d3555601f7b7e6199acd29838030fcef2 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -348,6 +348,16 @@ config NVMEM_REBOOT_MODE
 	  then the bootloader can read it and take different
 	  action according to the mode.
 
+config PSCI_REBOOT_MODE
+	bool "PSCI reboot mode driver"
+	depends on OF && ARM_PSCI_FW
+	select REBOOT_MODE
+	help
+	  Say y here will enable PSCI reboot mode driver. This gets
+          the PSCI reboot mode arguments and passes them to psci
+	  driver. psci driver uses these arguments for issuing
+	  device reset into different boot states.
+
 config POWER_MLXBF
 	tristate "Mellanox BlueField power handling driver"
 	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0e4ae6f6b5c55729cf60846d47e6fe0fec24f3cc..49774b42cdf61fd57a5b70f286c65c9d66bbc0cb 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -40,4 +40,5 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
+obj-$(CONFIG_PSCI_REBOOT_MODE) += psci-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
diff --git a/drivers/power/reset/psci-reboot-mode.c b/drivers/power/reset/psci-reboot-mode.c
new file mode 100644
index 0000000000000000000000000000000000000000..86bef195228b0924704c2936b99f6801c14ff1b1
--- /dev/null
+++ b/drivers/power/reset/psci-reboot-mode.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/device/faux.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/psci.h>
+#include <linux/reboot.h>
+#include <linux/reboot-mode.h>
+#include <linux/types.h>
+
+/*
+ * Predefined reboot-modes are defined as per the values
+ * of enum reboot_mode defined in the kernel: reboot.c.
+ */
+static struct mode_info psci_resets[] = {
+	{ .mode = "warm", .magic = REBOOT_WARM},
+	{ .mode = "soft", .magic = REBOOT_SOFT},
+	{ .mode = "cold", .magic = REBOOT_COLD},
+};
+
+static void psci_reboot_mode_set_predefined_modes(struct reboot_mode_driver *reboot)
+{
+	INIT_LIST_HEAD(&reboot->predefined_modes);
+	for (u32 i = 0; i < ARRAY_SIZE(psci_resets); i++) {
+		/* Prepare the magic with arg1 as 0 and arg2 as per pre-defined mode */
+		psci_resets[i].magic = REBOOT_MODE_MAGIC(0, psci_resets[i].magic);
+		INIT_LIST_HEAD(&psci_resets[i].list);
+		list_add_tail(&psci_resets[i].list, &reboot->predefined_modes);
+	}
+}
+
+/*
+ * arg1 is reset_type(Low 32 bit of magic).
+ * arg2 is cookie(High 32 bit of magic).
+ * If reset_type is 0, cookie will be used to decide the reset command.
+ */
+static int psci_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
+{
+	u32 reset_type = REBOOT_MODE_ARG1(magic);
+	u32 cookie = REBOOT_MODE_ARG2(magic);
+
+	if (reset_type == 0) {
+		if (cookie == REBOOT_WARM || cookie == REBOOT_SOFT)
+			psci_set_reset_cmd(true, 0, 0);
+		else
+			psci_set_reset_cmd(false, 0, 0);
+	} else {
+		psci_set_reset_cmd(true, reset_type, cookie);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int psci_reboot_mode_register_device(struct faux_device *fdev)
+{
+	struct reboot_mode_driver *reboot;
+	int ret;
+
+	reboot = devm_kzalloc(&fdev->dev, sizeof(*reboot), GFP_KERNEL);
+	if (!reboot)
+		return -ENOMEM;
+
+	psci_reboot_mode_set_predefined_modes(reboot);
+	reboot->write = psci_reboot_mode_write;
+	reboot->dev = &fdev->dev;
+
+	ret = devm_reboot_mode_register(&fdev->dev, reboot);
+	if (ret) {
+		dev_err_probe(&fdev->dev, ret, "devm_reboot_mode_register failed %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init psci_reboot_mode_init(void)
+{
+	struct device_node *psci_np;
+	struct faux_device *fdev;
+	struct device_node *np;
+	int ret;
+
+	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
+	if (!psci_np)
+		return -ENODEV;
+	/*
+	 * Look for reboot-mode in the psci node. Even if the reboot-mode
+	 * node is not defined in psci, continue to register with the
+	 * reboot-mode driver and let the dev.ofnode be set as NULL.
+	 */
+	np = of_find_node_by_name(psci_np, "reboot-mode");
+
+	fdev = faux_device_create("psci-reboot-mode", NULL, NULL);
+	if (!fdev) {
+		ret = -ENODEV;
+		goto error;
+	}
+
+	device_set_node(&fdev->dev, of_fwnode_handle(np));
+	ret = psci_reboot_mode_register_device(fdev);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	of_node_put(np);
+	if (fdev) {
+		device_set_node(&fdev->dev, NULL);
+		faux_device_destroy(fdev);
+	}
+
+	return ret;
+}
+device_initcall(psci_reboot_mode_init);

-- 
2.34.1


