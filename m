Return-Path: <linux-pm+bounces-30546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9838AFFDCE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC0F167591
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3372829B8E2;
	Thu, 10 Jul 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ni2uPbDR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAA295510
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139040; cv=none; b=FikI/dRz8Gs5cb9GlYhmpNHY2fPlY58dwWGmsht5HN+WINH8V+L9zRUbeDZGPCJwiI55MpL7WT47UTr6999kX//fEcFs6uO4RfgAEqRq0wUdHfU0xYQXivUlIC5ELE1182LwNCjQDH4i3aWSdrOqbFepQnQfhN8JageJ01hvMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139040; c=relaxed/simple;
	bh=khn8GMlrTtxNNR634wsCseHe/a7/+U/2qtnSEpHb+ZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0TM7owA+zLac37uS9ifFd/vFnSwl4xRHAW+IvZJnVnzGKalQBhVhkAXgm/3aFykcnxBh4y6VXFDZ9vBU4QpvcBn5bq5+JDu1pD+y19x7gEwBeUBHYoIbjskiRmCJF29OAPl/Xmyh7pq5JyWZN+KVfPcv2EA1oJrHMMxCvpWIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ni2uPbDR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9GXWk016786
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bm688pDoN1t58GLFHGhBI++/OTcmZdbP8x57uiG6loQ=; b=ni2uPbDRJeSqMnI1
	f5s4NXc92iTmeb4IiqlqTefRpdkV3ssbPXnkVqXkAAld3lrVzQD1hX4klx2Ooj8f
	89z5aHK6uVOdc3rE0936FhwbP75pr+yoDnkQdLYtqtjf4Sar4xpk3loikBcq+FMK
	Cjch2UovUfMG/CMATQlqe6GOo0ToMf/kqj++zc3uQ9+bzXtydsNwW5n4FVoD+5Bq
	fMfP7H12VkLkSD+aKEin91RVxLZIxvtZJiQJhrbRpFyboJbPSLnEmtbxNQRf+A5C
	+IESMd4WSO4/mANV5+oUz50rfb1+fMNHA+wdy+B2XuxNBwCqx4L1RpgEaUTPS/Q8
	vnPlQQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbnvbd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23824a9bc29so12668735ad.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 02:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139035; x=1752743835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bm688pDoN1t58GLFHGhBI++/OTcmZdbP8x57uiG6loQ=;
        b=I4/X5aGbhD/xvu7uo8fmAA6uUzZo6DPfZ1dpLmXKwY3lvcXUtC5cZwlsG83ev2CK5F
         /eRZRMlev0oCKBbX9r42kMkohyzpJ2D7wLXEKU5RIbLYlyntS8CXtxOYnwamH6xpMiDW
         nm0MFL6bpdgR9tbxVETcLL4WiUzwQWWTgc/D0hKkyXjj6pjznXPobClxTdJZ0zR28Rll
         0SuHQ8J0NZcYwPE5CPneaXE43HxzQveUC+hcjNu3jyAFH/GuDRwhU7rzXIU3IECukijN
         RbIUOuiTxmoYAVusuwP22DLZHY7Aixg0yEAvcWEKTiBuR/wIP3UW6xzDAyvTUOEiawvF
         COeA==
X-Forwarded-Encrypted: i=1; AJvYcCUgHi8IUUNJWBCp6/J+WO+ifHwnmOtK15IIB5z2x1TxqUMNFNfTGxZf1LLDBTp0wr7eL0SS3XX9Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvL6zcozi1jtDdWBaCqjQia6EpztCZhGTPf4vQzFbdFd4HK03
	5+fw/xDX3ccMPk6rRbV+53F3qGyjwfEKkV4rK6X9w/pVAZsDWwxEuvRYKnohzjvh4ka0SqYLMsl
	DPJOAZT5EmE6066hPNULJzsT9+/lWHEfridqqyS38QZT8ppxa0m/k+CqZAK8O2Q==
X-Gm-Gg: ASbGncuBeegUYyHu58prrwfIAOjbv4b6GN12ptqGGJNO/KVc3BPjoE5ZTRTYTpF3nBE
	RGw0dY14HGZLLJRMent/jWv4pFLRZPgIpGngnPIweEZDPCCTtZFRcsH3fF7uVT4nOU2GUpcmjrY
	H9HNcMwhePy79is+GELiT4FeuP9DW8peP0I6gxr2WQffFcEqp1mISxRDMNeGEKqM7CButqGNC4K
	cVdmCklYoTcT9fx8mpOGkr070GavdsyD9pgHLxgTtU25dvkenUx0VeDhLLRWCmcGbsl/GMrnGwf
	+LSd/028k1lu6dqO4ofE17V4nRcry2A/74UNvp9lT6oaPvGTTnGTmWWJURk=
X-Received: by 2002:a17:902:cec2:b0:235:1706:1ff6 with SMTP id d9443c01a7336-23de46edf4bmr28705035ad.0.1752139034603;
        Thu, 10 Jul 2025 02:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwquEcV/DEQgNHo5i5rKIMG5wYJOS8HD0ETiQ+J8XjUT4+2RRoWOqCstZDWnrO0s1dBiyXug==
X-Received: by 2002:a17:902:cec2:b0:235:1706:1ff6 with SMTP id d9443c01a7336-23de46edf4bmr28704665ad.0.1752139034147;
        Thu, 10 Jul 2025 02:17:14 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm14837765ad.189.2025.07.10.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:17:13 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:45:46 +0530
Subject: [PATCH v10 04/10] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-arm-psci-system_reset2-vendor-reboots-v10-4-b2d3b882be85@oss.qualcomm.com>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andre Draszik <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752138982; l=2500;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=LJQmaaDtgt8TROVTUTsTmEnpeK2uj+7rigIrzNpy/l4=;
 b=iy9PU4ZJOiTEn2epqZUOkW8+Xr7tjFQnf02iWN5UFpijHHJzDb+DQE9zwiCZcqY66/IiKYTBH
 Qa8lCfgZ15ZBxIImBn1nkijQHRDyoW0jh2GQrhRaXOvI4e1VEJRpOEa
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3OSBTYWx0ZWRfX4hLVnVUAf+1H
 KWGsy8afEv4mostYF5Fh02CPUC59O6DJxEiZFOfwvXQG1w84rvqgsjn5fZF5Z+LPx9/1D9QfAJb
 /iGJyLvOBr/qKLDUYJTL8AQmq4evz6mP2+LMEiFhogVnZW7Y7O5Wlw5rayB4/c6IDfkYRnGAaUv
 KhyrFyrH9eHQsSDZIy5bvKiMzYHPz9YDXR4GjlqpFY3ZB/h3QjGJN4T4aH6e6S0otWRVvOq0vTx
 FoisPS8l+KxarzFpbTEKlbVJVUHSCMCtUX825A5909XycbVQm8+JWdqkjZ/SdlV2/fQpLJv2qix
 FQrBEb/xYhQl7KyA8Bi3PjnzcNPmPQlDra5py+MijDv5i0SBCnRJTQqIj9XuimkKkFqlxlLVCGz
 POaMw9ET6w1HpAcGzvosBu9Kb/mQVLo/N4nSYPeuDKJBD6c/TIo993SdmHXp/hfbVTGGAtLR
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=686f851c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=UInjrUrXc7y1C1sAkbYA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 4cgWBASjje8aktyHep-Ly8SD05HxvqmQ
X-Proofpoint-GUID: 4cgWBASjje8aktyHep-Ly8SD05HxvqmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100079

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 7360a2849b5bd1e4cbadac533c1a7228573288d4..672fc28f69ed7cfed4baf8c2185e0cd7b2024376 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,25 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/cpu/idle-states.yaml
 
+  reset-types:
+    type: object
+    $ref: /schemas/power/reset/reboot-mode.yaml#
+    unevaluatedProperties: false
+    properties:
+      # "mode-normal" is just SYSTEM_RESET
+      mode-normal: false
+    patternProperties:
+      "^mode-.*$":
+        minItems: 2
+        description: |
+          Describes a vendor-specific reset type. The string after "mode-"
+          maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
+
+          Parameters are named mode-xxx = <type[, cookie]>, where xxx
+          is the name of the magic reboot mode, type is the lower 31 bits
+          of the reset_type. Both reset_type and cookie must be specified.
+          The 31st bit (vendor-resets) will be implicitly set by the driver.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
@@ -137,6 +156,15 @@ allOf:
       required:
         - cpu_off
         - cpu_on
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: arm,psci-1.0
+    then:
+      properties:
+        reset-types: false
 
 additionalProperties: false
 
@@ -261,4 +289,17 @@ examples:
         domain-idle-states = <&cluster_ret>, <&cluster_pwrdn>;
       };
     };
+
+  - |+
+
+    // Case 5: SYSTEM_RESET2 vendor resets
+    psci {
+      compatible = "arm,psci-1.0";
+      method = "smc";
+
+      reset-types {
+        mode-edl = <0 0>;
+        mode-bootloader = <1 2>;
+      };
+    };
 ...

-- 
2.34.1


