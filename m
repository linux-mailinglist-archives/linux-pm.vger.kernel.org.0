Return-Path: <linux-pm+bounces-41619-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFDmIfItemnd3gEAu9opvQ
	(envelope-from <linux-pm+bounces-41619-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:40:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F2CA42DF
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA1E930159D8
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4622DE71D;
	Wed, 28 Jan 2026 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pm1I/HQV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Utuq9YgC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53AD2D9797
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614670; cv=none; b=SthX1bOCqafw7m+2tV3J6FaE+xlT+fDyQ0AwWb0rKDrMJOKmnJnEtJKz1vIvZlyHpVLbOlXUojo+StA4jsmd1uEa+jV55EUK3RUME9JXdaRewSyx9XKl1xeUBj4Y+2el2iQaDCR9igGjdVyUFo5POcii1fHSc0OCrYlURIlL2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614670; c=relaxed/simple;
	bh=ayAnJWhqvxVqxUb3jotL1noUt0bxhrC/p43Y0YGiw+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2yqNA7s0UBtoWkRj6Vsws5E4ZrbN0dCMk4EfDfPoPSTo8ts2GhVURy5X0k8Abj53vaDt47cxLGfKwzxZVDrp93hv1qXdlZstZUF9yg4bN39FCcaNagiwYppe0Mlctww1vpAElU6Ege/F76RzGRApWU2wA1NXMFxC25inreIZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pm1I/HQV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Utuq9YgC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S92Sd43907647
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 15:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1SfBbA3M/smVtChdaDHyBs1QmfwqjTWGvIAucfFrNwQ=; b=pm1I/HQViuD+1Wjj
	US583gRwrpmFHWWZUcIpkChN3JuLgy4e4rdaGCl8H1E9Di0n0On1bdWymUzrfpcs
	35N2dDqOY9HsaBDt+2TH1gjCc6PMTx+LDNeZpGIVbc07qzgv2bpvuuPsxk5olQyD
	9Eyv9AV2rsSlzjBax/Ffr+Twv2ing1ML/DG67qqaWrVU3ynLoVEkjnbwdQB/TqHS
	9eH5ELKPhi7mp36OcuOvZsBJKW3pOO4sztt3cJ6ZeRGrw2qA7hOUXPNghzdeMpfK
	BsJWMUpUnKrFF+s6yBJ3LhSsiPbCTU+Yd1vk3rS1/oyHubMJDnojdLTsmNJVEDI4
	pgptqg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by0g0cg4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 15:37:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0bb1192cbso58332025ad.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 07:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769614667; x=1770219467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SfBbA3M/smVtChdaDHyBs1QmfwqjTWGvIAucfFrNwQ=;
        b=Utuq9YgCF879zM/zcNoTsRxDRmX9ioUO6qfLUvNVJkk/5q4GgK8QQGbpEhX9xz/e28
         Uj4vSRXsycpHzKUX2LFMTiOuQKNGxp1MZY1b4sb153hf3c7z3azr6HzEIVsdz4QJ58OA
         vY42bGPf9moC9qljUmvB6QGj0x3XjuZeGIwHn/d1U4tLzGd+JLK54c2JjOujxx8meSZs
         6KJyqgBNwAs+c0b6aofftOwoq+kQjMgRAPyQIcBMYmgDZl7QwDP74nHBYAwAgWAXkxoa
         rjgBc53fAqrzR3zsDK/5mEkGlJCr2HRA9+rHqNmqxjbrQWsURghXw5NjEdN6o4NfpI/t
         pgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769614667; x=1770219467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1SfBbA3M/smVtChdaDHyBs1QmfwqjTWGvIAucfFrNwQ=;
        b=B2o3w8Iq7opb9NU3VUBs2YqFqlMJZos7+J8kPjaZIvVRi8lvZclqRpLM5M47wMFEHd
         82j6THViRH8VrVie2BkRfPOsl0RgpLqIu/npvGna25V2Jczcjf6bIaT5mK7MivtsuT3l
         pE6kfV/Tva9VKibETJbwvpc5U/KX2poUorMfvUV3wFNGIQkGkjhvcAuZXvNM7PdFkQiP
         3V8cRjsvKBHQhNXe/uj/FrybtnIZdiliR3Q6r1UayLnMWCR+giKEW5luljP6uP84NEyL
         AuZiIh18ov4ZpIB77T60+PBosZCRFPi1kQ180GKBhV+WW7LRdCh65BcDEDux8CFlbQsA
         L/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuD9gpP0hhzzdtFFC5/382FxuIBlvcEbm8MiRJGMhuuDnayjqdaJ2YkAvxEf35NAYOv5SbEP6EAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzzz1gOaQCtDELMVHErpep5rFPO2YjaxkcrCWii8vH9W/73crB
	E61oyasZMjDwnhf7isM+Q8mClR1yM+l/NFVeTTHZsT+syFvrfaFKJ7yVpSXWwEf0JF76A1A5qIN
	1hEhNCJF49t/0qASkqDP3zZI9KrEhjF/SXOtiusWFjuaRSLm/eElN/me7+uhUaA==
X-Gm-Gg: AZuq6aI2RkHuW2IMJvnudhF4aiQYI05QQL1zPxfnQM1zCbWfVuyzhijMW9GyZ05qWIk
	tF3z21Br429k+QaYDfy6gDbVVhYD6iAw0ayfGiwiJSZVy8V6WFrQNokw4LwU7qClcpO3D6TYWkc
	roAGGTdanlUOrFF5pKDyzVxZiBGQniC2rzsQPjXuFz5fjm7zEC5KnrlIHE9XplEHcGQ9FDJ2eNF
	dq/M/Au7sWkvkcP8b/5H07OcUOZpH5E6pjiPuQ1CyyNr+s89YA8tPQFppAk3EgyyFU7ytf+UKiB
	8F7/GCx65WLWjSuiCPpopBw74UKPL4ngGnvVUPOj+K92TbuFOsWFXmhyKrM1TP9jTdYzyiHbi7a
	G0uS/rO9BrjiBfl3Za36yB3I7u5i8VD+l8gmthg==
X-Received: by 2002:a17:903:183:b0:2a0:bb0a:a5dd with SMTP id d9443c01a7336-2a870e1521cmr59413335ad.57.1769614666352;
        Wed, 28 Jan 2026 07:37:46 -0800 (PST)
X-Received: by 2002:a17:903:183:b0:2a0:bb0a:a5dd with SMTP id d9443c01a7336-2a870e1521cmr59412945ad.57.1769614665732;
        Wed, 28 Jan 2026 07:37:45 -0800 (PST)
Received: from [192.168.1.102] ([120.60.55.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3ee98fsm26371725ad.9.2026.01.28.07.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:37:45 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 21:07:16 +0530
Subject: [PATCH v7 2/2] PCI/pwrctrl: Create pwrctrl device if the graph
 port is found
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-pci-m2-v7-2-9b3a5fe3d244@oss.qualcomm.com>
References: <20260128-pci-m2-v7-0-9b3a5fe3d244@oss.qualcomm.com>
In-Reply-To: <20260128-pci-m2-v7-0-9b3a5fe3d244@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ayAnJWhqvxVqxUb3jotL1noUt0bxhrC/p43Y0YGiw+k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpei01CRkwyRyAd55pohnc7Yxy6JiGTO0PVOqkm
 WPeunI7yGSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaXotNQAKCRBVnxHm/pHO
 9WDuCACcvTLvfMeR/n6MQQCFzYUGzhc5g0cX7wrTE95npc4sFrWjI0wQKvBG0GHgVWJiXlx9dsj
 677q6U/bW9rLCeZulg+DGSW32sg1kLyB68QpFoDAfEjwGFtDHdsJ2TP+v4fLmcfI1GtOYPwQOLM
 96Sj5bs8fyDEWXabaFadqIE/N2sXOkfxVxQxkxiRXovHCJ9BnqEd0kWC5xbZnnR09Ft9Nv6vxKy
 UpUaWQ876MCJXP6+q0e2tyDGPxMT2j3aJU5iQKiFi692tk6jO9IC85Z1qjg3BmCbYqxBL5V4kPO
 DH88TCj5/aoM/cwvGRPqWTQO5/PBzH1leSk9oTvlkaKnlWpC
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-ORIG-GUID: Odkcb49n4kbbF6BnrObjFVhOcVLaM2fZ
X-Proofpoint-GUID: Odkcb49n4kbbF6BnrObjFVhOcVLaM2fZ
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=697a2d4b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=F3mjE3T3/ow0zpRzCzjSvA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=0pvPJS888BSDkZzuOKoA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyOCBTYWx0ZWRfX1L4iyrRvGRXH
 hxcCX5BfPhmJ1Kj/Uw9xZg7GuDESsryLDR2/51WZq+M4YQJUphWThzvkZ8zE+hSuvdAuDjg5A2u
 df+o+3X8rm3yRbqWAF8WuD588ckxmDWo04jhW+gAanC1m24JA5i+rkTM2hWFW+ek+xPPYVTIoXf
 D3igVDI/Hmw1iF64CZzk/B9FnMNtCituhpnkuhkAZmpsbNO1sEDlGT7tg59R3zFGQBrWpRaWhO/
 kfiA1M2sdqLrC7GHMY2Du76vBzK2xRpopyhRAdc+WDy2FNuvV0lvxVKgqK5gnmJYS1rk3Q0fNmd
 gJDJBUaOov2bSbZvJQckl9xv7pRMPF0NBe7eAvCQhZ15nR39ScNYcp26vWT4OedwOhMCrosii1e
 RwSWrhNRhi7rbyafqM5g3gtO9DmxQqkAM9GxK4co760mjcoIBXMAktfNxiUqTe98d6eGV966XmK
 GI5jq0bvRs3nv4of6gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280128
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41619-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 61F2CA42DF
X-Rspamd-Action: no action

The devicetree node of the PCIe Root Port/Slot could have the graph port
to link the PCIe M.2 connector node. Since the M.2 connectors are modelled
as Power Sequencing devices, they need to be controlled by the pwrctrl
driver as like the Root Port/Slot supplies.

Hence, create the pwrctrl device if the graph port is found in the node.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 1b91375738a0..6f7dea6746e0 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci-pwrctrl.h>
@@ -295,10 +296,10 @@ static int pci_pwrctrl_create_device(struct device_node *np,
 
 	/*
 	 * Check whether the pwrctrl device really needs to be created or not.
-	 * This is decided based on at least one of the power supplies being
-	 * defined in the devicetree node of the device.
+	 * This is decided based on at least one of the power supplies defined
+	 * in the devicetree node of the device or the graph property.
 	 */
-	if (!of_pci_supply_present(np)) {
+	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
 		dev_dbg(parent, "Skipping OF node: %s\n", np->name);
 		return 0;
 	}

-- 
2.51.0


