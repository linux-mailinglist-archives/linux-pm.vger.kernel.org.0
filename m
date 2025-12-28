Return-Path: <linux-pm+bounces-39990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA1ACE5433
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAC263040A43
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4651022DF9E;
	Sun, 28 Dec 2025 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OSQIj5bs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RIkAF1xg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A921ABC9
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942475; cv=none; b=LCuKHN1gSu9fhURRu4WE52zSzyJG83VvlTT3SVL/qUVJ12iFZapIz9UJ6c9QeC9fn29G/WdPPbirsZekZ6GpLSnp4erxwKkOOgtPkDzmdyXITWV2VLxAxxt821nEp9Q2+2BZm06qMZPVfQdhkafEOmYWDsrvfhWZnynMCgTaTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942475; c=relaxed/simple;
	bh=yBVN4FEHADdTSQ++LEmhmTEyByZ3pz1DEJtf2+BqO1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QAvpYcrH8YMmd3eDmzWkohLDUvOXJ6VjdZq/qy0o8G+X400Mf6z5J2oPfhaqPuyEpH1SYbgBQThUqNwXUqmz69MFQIEHd/s8cRqsVrpZ5OncGS5bL+1POCjzIbP0QwYt7vlwKGLynHSM2+Z6fhzhXcVndrmc2Dk7E+kj4RJ7flw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OSQIj5bs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RIkAF1xg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSGuiTE676796
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=; b=OSQIj5bsChWqAj48
	ABKxrp+IiSLJdlruUNl+3hQwW/bAb5ORjivIaXpgBMaAL41LvyiQ/0GicdqN7loC
	yqjSCsJJxOY3yBx1Vao1YV7SXAafdX+YNAstJNNdLyxZdORtlthxiVBuqkSWExg4
	TaLYUfpleNBtzPCCRyWlKwxnHAHz8CYdm37K9JDwZQLYO/XK2hDZK+OwMo1JdeLB
	7I61P0f0PMXzB8vvDvagydD2YzsETKA7I2kKcejeISYydD/43fPZ/RFM3/k1Nv/S
	OJIfl0pqrxI5m/q6IM7QBoOklTF6o11u2IMh2b+wWYJWytsmXEtL5dBcvKy+bXwe
	eRUNIw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bavrj0w86-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f177f4d02so195738915ad.2
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766942472; x=1767547272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=;
        b=RIkAF1xgp5JHhn54Hj0g+X9v7uwYIRz39azLvKQ/iw7INzRZZYnN4l4Q8i7ZZtnDpf
         70oUpTz2IdYx8r2BAd/XJCsaEgISn9KwnVqnUsYVhXzGjhiQWpPDynsg1ZyGJ0fuePgc
         6+4PIiA5KO5e++hTRkD37EzqqtXWrTbenB5m1bp4oYu9XJH4vz+cSor+XmSL3CH+gw7r
         k547yzrPKTlG480b+AhhqA22aCRpxxCDB1f3m6t0I6faQecxXX5EYseHa1DsCiA87NOU
         X3EpB1uK6u3BJ/DSY0u8EO8NROHQxoAiGauOUTl88SbTZp203nkchoT04MMgyL6Y47DB
         jZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766942472; x=1767547272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=;
        b=YVfiBOWon2I3nPEDx2Hts6+gjA0IRV2zIYvE5Ig2iyvsjd77pWnyov0tdChxy62GlZ
         DrnYXr6GhXkxdIDsDvkAxvkHJcczNpkXGoW0SBknZgmjT5Egs59RVK0NV/Ik2oSvqAj2
         Swk/M8w3H4oOazL3bVlkox4GjZWDWl8+hzY7G8XyZJh9GUPPLd3Z+so5qpFJlOsmSp9S
         stpunwt29Z5Mxw+JcQmXg3RYNDAZKBTx9je6WKHk9qxzsqP5PIQG9cnv6RsjFe09263s
         0Si49Bl5sstOaPb49c6g2rjWPok3b5j6upsBPwXRxPxuzVd67zkuwY1mpxShPEjVI/rx
         jCzw==
X-Forwarded-Encrypted: i=1; AJvYcCXTGZZ1lDRBB/h4XPOVQceyBsxmADv0SLFliWDelLP8VZbdTOQY3zTQSSE77mKMPbbVAKnEBpNzzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWzlqZUlAyQshw+FmGpNk8zu1wPey1A7ZfPSIwtK4WnHsetuf
	7SANVxPvCExT5xyYwSeCWJQgnfoY5KFTSl8CBlX95wRC+OZrAvAZrGPZYZumHiSKP0fngpiDz2d
	D/TcHYvD3aWj4i+t/z63x5TrcplqKJQVMbSlzLi2eMcoiLWWffrkDtdu+rQtrtg==
X-Gm-Gg: AY/fxX5GT2XncA55o9+38AovqXh+xSbRqi/Qyf4dZ8Pwiu1tAmz6pMvcyu2U2v7z7Sq
	E45jOg3mGTLdpphqyuPH4u1kK+dSgsaRHaJN3DdFNopaENOsnrneFwuaA92sUVrgIzRSkTsahaP
	SJ8rVMB65op/8rad61AHsFOgICRf8ByPNm9upvMr/ZoHCQ+EK1GdeEC6363fH5pMLvMuYANSefz
	xNSlBZtSnzFi0UHOxnZN3EED+1PVL+fehKkNa9jxZgrxnD30opls11U63GUi4kDoNnadG/xD1hh
	iH6ipnVRkl0DXUsOLVPVYG7lATNZoZPAs9y39bsuYjpFsMtjSbAcgNi+j5mRwL2SxT2UCSUfiY1
	DodJvGpgqY5P6x0Cz8YGEz4wlFNCfhi0A24uWR7nlAEEWqA==
X-Received: by 2002:a17:903:1b6c:b0:2a0:be7d:6501 with SMTP id d9443c01a7336-2a2f2329b6cmr254838435ad.27.1766942472316;
        Sun, 28 Dec 2025 09:21:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJf2zEoW26feSF7xfX0vkApu3sXD9MA9CPAaRfd1rQL7BloGMJh2vU3CewAUPDXyVkr6gtEQ==
X-Received: by 2002:a17:903:1b6c:b0:2a0:be7d:6501 with SMTP id d9443c01a7336-2a2f2329b6cmr254838215ad.27.1766942471808;
        Sun, 28 Dec 2025 09:21:11 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776ebsm255743965ad.99.2025.12.28.09.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:21:11 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:50:23 +0530
Subject: [PATCH v19 05/10] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-arm-psci-system_reset2-vendor-reboots-v19-5-ebb956053098@oss.qualcomm.com>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
In-Reply-To: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766942426; l=2477;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=yBVN4FEHADdTSQ++LEmhmTEyByZ3pz1DEJtf2+BqO1w=;
 b=/mSBXPgpKpEpXY4spqPm2N227p+KGOphi1atXCWYlPsvNtAR59MP91OzPkYBYlTbvVwzmKfp2
 FwPhzDmbHllAzgtvHSoDBk7867mFBkgQkUlz14ZEPDiDZQqD995MelJ
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: 9oG7zJJQ9nj5gK4ugZI-YAFJ4lvW5RuE
X-Proofpoint-GUID: 9oG7zJJQ9nj5gK4ugZI-YAFJ4lvW5RuE
X-Authority-Analysis: v=2.4 cv=coiWUl4i c=1 sm=1 tr=0 ts=69516709 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Z1E3qa2j_4PWJv3PNLYA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OSBTYWx0ZWRfX1r+qNvkoY9NM
 ZSrq7wNpKCdIkX3IBOEQAOSSM4MvGrQFBnV8GSqfL/qwwectKxu0mECIzRrD906XXdnEsHbInWw
 EV2rbTPLFrfuep9vEltUF/4MTZnscBEMna2I6/1DrWAP9lRFOvjKE6AGIf0IO/Nh2HZqgfI9nEu
 hxuRSj8zFWGgjedAJ5GerM4B6OY1Ou6gIRc5syXcbvyUDPDogZrI7jfT89yFnhSfyTzAL31kpLH
 5jcg0fByp9jMeoEuGEM9h7DZM/g4zduWPjWsbepIa57uu/51a5BUyy+kXZzaQjNhY3Da95Zyw8x
 ALmAYJEu93nGz/BQV7dwXG/BfF4BuYKtYIb57SMelXm6eoGdcOhDDmJVA2rrqe4/2fJLUqfbc8b
 FT2OGIj8+78BJbOGocrFR/wlsvGBB/aZTVGD3MdhBEhK1fEmUeYHFVKa0EcOwWj2yJ9TN2nty5w
 b5M2FfO5z4N79zGfwiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280159

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 6e2e0c551841111fbb0aa8c0951dca411b94035c..5fdcbf331ea5620363638feb6f8105427a87c00f 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,26 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/cpu/idle-states.yaml
 
+  reboot-mode:
+    type: object
+    $ref: /schemas/power/reset/reboot-mode.yaml#
+    unevaluatedProperties: false
+    properties:
+      # "mode-normal" is just SYSTEM_RESET
+      mode-normal: false
+    patternProperties:
+      "^mode-.*$":
+        minItems: 1
+        maxItems: 2
+        description: |
+          Describes a vendor-specific reset type. The string after "mode-"
+          maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
+
+          Parameters are named mode-xxx = <type[, cookie]>, where xxx is the
+          name of the magic reboot mode, type corresponds to the reset_type
+          and the values should be provided as per the PSCI SYSTEM_RESET2
+          specs. The cookie value is optional and defaulted to zero.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
@@ -137,6 +157,15 @@ allOf:
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
+        reboot-mode: false
 
 additionalProperties: false
 
@@ -260,4 +289,17 @@ examples:
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
+      reboot-mode {
+        mode-edl = <0x80000000 1>;
+        mode-bootloader = <0x80010001 2>;
+      };
+    };
 ...

-- 
2.34.1


