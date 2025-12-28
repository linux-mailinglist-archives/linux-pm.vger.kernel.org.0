Return-Path: <linux-pm+bounces-39983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E21CE5342
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B14523042FD9
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48E223DDF;
	Sun, 28 Dec 2025 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EBCfNwAL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D5L5Zo4+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076D2236E0
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766941307; cv=none; b=F8iyrgSPk69FdZBhr+vZ5TSWW+KkHFc2KB/k15L5L/lgzD0hekmnk3ETM5VODOJQj/vWP0drdib2OkyVXZwgr+i8W82xfG87IbwcoGVub6i4N0zE9IQtkmrA33XyfLE3+4YzBwk5derdMVuDzpMa8d41Kyrnr9dWYMZjqK6+K/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766941307; c=relaxed/simple;
	bh=Z2MQcMtEDf0+MlOwlvmKClr02SMu0Uf8mDR8S4+Fr7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4LVvm7TjdPhzIwb2U51DwHu3UZr8racYgR7JxNt0OAlin1WFfeiBEmyu/JRXHPNmVKZT9Mz/Lpo0v1eo2w7ssPThHm6KSyLneM0bJu94T5Ye5TTxumKslrYbxkD809Pjq9G0xX1OSLHYfD3yqB8q7DiF4pCLawnsV+gVCXDoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EBCfNwAL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D5L5Zo4+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSAP3rd2628256
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lO8KnnWgHSsJ7X+4A3/uEMMgQDJP+dBeFTvM/NCdCwo=; b=EBCfNwAL1rIz7Xy/
	pWfGXlmTLOUFPyQcR8bJLxG+fgXSqsKD115M235Jy3/RRcFB5X6TFJ7V8az3NSbj
	JZFrlgckN4b3lI2zVeBr0tUwvzoPxw+rl0ibxavd2PowzflTsAoWJKXcH1yMOnFr
	+R4X+LzgOqTXrmry2TfWvRpd6dSrt9yavMQkrj2/EPNV5LXEywj232TNz8RiVUl0
	KGKNCOh8c7qoR3Rimpg1ryHg0GOcX94ISJBhR+gh5B2W0PCUWWOU8BPdba/nRcVa
	Bqd7CD5FfAlsMZZU03tXv3oO9mizdx4QKMf+ysBqDum8ifw94RDyT4sVXtFqGhOX
	rxhV4w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7hsaf3e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:01:43 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7c240728e2aso18152016b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766941303; x=1767546103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lO8KnnWgHSsJ7X+4A3/uEMMgQDJP+dBeFTvM/NCdCwo=;
        b=D5L5Zo4+hRAQWQuVfEqUml2iEipbYMBrtTBMgIa9A7o/z2ExWBUWvy75Z5n2/bDbgE
         7nZUaMw34mAYNrgtJ8x25nIEBLKW55hj6WWfR/UWTpep8o9e/XS23UMEgJoh53cp8kbY
         DpSmfwSZ1e73nYVVo9umdAuWNsNFCMK87fnqGrHL4WMk2LdCgOY6kWllcMmZd470PUuT
         5bDyMDnGEL2UoDZ87yO/rW4xx661a+fXy5ZRREGDchea5JaaCjB7lPq3wDejFzlVOnqn
         itSsPjlIAjhvc0JPH6NdMO9OiEWvREccjnpLY1RusChZ5xaaTizcdJrhXHowxGB2uV8C
         uHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766941303; x=1767546103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lO8KnnWgHSsJ7X+4A3/uEMMgQDJP+dBeFTvM/NCdCwo=;
        b=TpRglsJbrJwOLOIBunCl4bA6vXHaXaGoCvk39ovJCHj6r/x0196gdMULGspb7BOtNa
         Pg1XWH5zb/F5PkZfzQzRzG42wwiLZBfzGnYQcDjXEDUjCPogn6POdNClZm4jOgXrsLQ1
         tCEHHhE0rZJy16dAAy/aLsENx0i5sp+WX9WhQj/0O6RSSAARN5ztCFp2zxFHAg1aYLPF
         /Sx4Ws2MQSL7qb0pYVhKJwwOtcc+8VPeqe7CYMeWOhDT+LnITdQcWj5+Anu+Rt3hxhX5
         MY4mKnfOIQuJwXJ5CYwsQ4HQIiJlDudBM1G7FVRsaAQoSH5ABvjADEp5D6q/U/BPvQT4
         74YA==
X-Forwarded-Encrypted: i=1; AJvYcCWnXmAxXT5ArU+vfMIZ2LfiYtE4XGgJCSnuAoa2fXqHkGSeLLqQMyJR6dFyg/MLXjJKGrmJjOpVxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/vfSIrehAtXXIazTTq/dhTMj0c3edDLF6XFTWOlJOlkC0q20I
	+d7d5Hcn1iBH10+hCGS2ULEtgLJ320uculTJ8TTbEjLP1hRRSmtPGmjscmbg2JxtJkmXIIdH+fW
	N4UGsBeBMIH+0yVJkMc2AE+1hH0e6yCUWZNsA7+lKUUeqeONbgd9b74th3IjYzQ==
X-Gm-Gg: AY/fxX5Pi6ECmZzw/U/LrGhmretQnj6fGHs+UAXiVCehnTC0oBpdVBwp4+1fow7e0Ix
	TgF6QI8POTgcBaq5FkdAWedUjMiUqxJnDTwxdONBDwScrC9VHXXbYu1LYeR0YJM2B9QR7ffW1Vi
	WJDCZPgwzTJqxGscM6E9Iql7buYjiAQSTfCkqMr/E2qCJUNochgA2GjcMDHVH21epcLOl860XkK
	xAhat+bBvIz069jYfTmPe7AY/yxEiOaAdB3Lb9zx2xvm8HMDdP4pQ/fXMnHcHFLZ3fghUY2WQxi
	dZMk0RbzBbUdqZrQ1vkKp+RQVVBVs6AtSpI8GFdkW3B9IpPsQ2pvDy9OWABZIt2fL6oK58rbAD+
	/kEqDWCPoMjv+Ag+KjqgGNFKF2dmaDMilJBg=
X-Received: by 2002:a05:6a00:4091:b0:7e8:4398:b365 with SMTP id d2e1a72fcca58-7ff6666fb6dmr26620064b3a.56.1766941302416;
        Sun, 28 Dec 2025 09:01:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVA7a0q7fL5mIleAzOZdrFNeS91W87Ncnq8EVjDEwuLWRFyji36RoXXncfIFII87lTO4ggYw==
X-Received: by 2002:a05:6a00:4091:b0:7e8:4398:b365 with SMTP id d2e1a72fcca58-7ff6666fb6dmr26620031b3a.56.1766941301904;
        Sun, 28 Dec 2025 09:01:41 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:90aa:5191:e297:e185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7ae354easm27053925b3a.16.2025.12.28.09.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:01:41 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:31:04 +0530
Subject: [PATCH v4 4/5] PCI/pwrctrl: Create pwrctrl device if the graph
 port is found
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-pci-m2-v4-4-5684868b0d5f@oss.qualcomm.com>
References: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
In-Reply-To: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Z2MQcMtEDf0+MlOwlvmKClr02SMu0Uf8mDR8S4+Fr7o=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUWJZi+OafIN/4BNYQUHZiDJVSi1SBNpgCKCKH
 DHZemBVgO2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVFiWQAKCRBVnxHm/pHO
 9e6xB/4wMR8YICaDAR48uFLGUJjdWx3H9G6VyXUGvRi3LLh+tfNxRT/71W7P/Iei6fMZOMxUlfM
 Xmi1UoqocqoJRZ+m+4OEJoeDYF/mEcFdGyO/yOBALlk0ftq/74Bg2tm98JQrVRuLytK+B60D9Uw
 niH4+wf8eqf8eEbM2UWIlrMJ/re041H5FZkAn0ez4BC4+26LGVBxyiQfz/g/fK6ugRw5FbG9spe
 W9IngGtihEwM8gJ7GktcJ39ULghQR//YsoOdGxSn6Dy6yow2lu6sa+/DaVwDkjXzF7kCtTzX+p2
 Lgoo+fcQM+lS1olTJWWhWPRprbx8wTOcIa5xetbYBbJ9s5J2
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: ubKeV9yFOdcHEk7V1PY3tw4uctdtu66S
X-Authority-Analysis: v=2.4 cv=O4o0fR9W c=1 sm=1 tr=0 ts=69516277 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0pvPJS888BSDkZzuOKoA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ubKeV9yFOdcHEk7V1PY3tw4uctdtu66S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1NiBTYWx0ZWRfXwCOR855gba0H
 HmI6qp9O0tbR9tK/c1uMtQZh46GvaS1sqevx80EpLvB+HllhGACR50h8+jOOQwPkiim6YLUGgEE
 Rzj18lN4d2bNwf6NyGkCR/xxFCK7OiBH1HWxSqTUqx7S6EtItrCIh6OkTY940XTkrh6dNqMRIGe
 pSTq0ju+eTXZzNWYxin5qOV58DtoIoGxUiCxrVgpqMnDYWVP4SlFeOUwry0pVoWfxRejzVaas5Y
 wtgO1ryKYPkDvj9Fjcy+Sf78xkeXexvmI3HtJkE+5wfLGf75pmjc7WBtLt9oGSVxVb1pvnTaBI5
 NMl7B2jUEiRrdoqyNT+C9IST5Y4yB27O/CHd5RfTrjvk9uL7dHKUR9e6OeGf4F9RNK9QLxq45VA
 IaE4hlXIxBf7j0nS4pltNSxX38dYoTsiKWWZ1BoJAS3k1+gORxRwd8BEyx9yrHIbasAKGBDalhg
 jaOIgljcRX1mvsX9pWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512280156

The devicetree node of the PCIe Root Port/Slot could have the graph port
to link the PCIe M.2 connector node. Since the M.2 connectors are modelled
as Power Sequencing devices, they need to be controlled by the pwrctrl
driver as like the Root Port/Slot supplies.

Hence, create the pwrctrl device if the graph port is found in the node.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..cd7efd20a74a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
+#include <linux/of_graph.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -2585,7 +2586,7 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	 * not. This is decided based on at least one of the power supplies
 	 * being defined in the devicetree node of the device.
 	 */
-	if (!of_pci_supply_present(np)) {
+	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
 		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
 		goto err_put_of_node;
 	}

-- 
2.48.1


