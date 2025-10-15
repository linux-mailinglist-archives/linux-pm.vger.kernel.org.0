Return-Path: <linux-pm+bounces-36115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 854BABDC838
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 06:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39DF34FD3BD
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 04:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F02FF658;
	Wed, 15 Oct 2025 04:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JH2ZtRT8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3762FE591
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503175; cv=none; b=Lmm/shK2Z8J1AV2JfrGClYyrpPCP2sQ6vy560Sw4IqhLKOamBhWAvqDTmmPopWoBmOCo25106/ZK9RwWzjV/0HfyQ+iwyUi3DqDkccPgxVZc1gFq2gLOTZFkRykQRJvmjWyFeBrUot7OkRWqKtnhge7N4jh3MOX+WXv2yMWSLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503175; c=relaxed/simple;
	bh=R3BNXlzor3OWM1UHW0bocrQrgSVBuB1WLn0clYEcPVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dsr1GMZ7qDQDxKb4ffWOrtzkdayfe8p5rhDyTD/aOcPd34rqdOfzWwm3YgBVbp55ZfPCk7c1kQF/vuDXQuHWJKz98sH183BveD3dEVdYXG7XV4oJCT/NvmH7BcWPVmV9yD9SMuT7ToO1ITi+c+MkdWhX6U8Zd3tqJibcMMOPxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JH2ZtRT8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s8FA002566
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=; b=JH2ZtRT8ZNdz9xiq
	AW2vvYos1zoieDf+tY3EZfn3FiZaR949bUCAeSrSS8bmV3tbRtr5fSPLDfngJBJP
	gJtgaMm1cH82nF/CFktTCWL3rXukYTz6rJ70xx5AdtYMEXw55Abe5WCBJlhTQqkD
	KR6lqMC7dhOlnpjBdESbXdzn2Y0QU6K/zBQ/X1vxAnY/mPW6oO6S2JUpTDHDm74r
	tbLzPWUQEZpM2/uukOS9VBtdmky4ENhnNH4l111rGiIca4FwUFkCTjQUAPrfZ9I2
	t/Pvhp0J7XWhu+tm5RHMvLWzWJ6Z8oxsBj0GR1VDwgS/Q9qnH9oLWNmliFGjysuE
	j8U75A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd934ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so16412003a91.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 21:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503172; x=1761107972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=;
        b=DDX24rES0LLywy1aSuuYl+ZpHBRJg5Rj4QyQ7jgL8Fq1YFwP4DetyotTQw3lSccgZj
         sAueOvKhyewz+9FmcGaxybbgeAaShwqJjVdcJHM8E/tPSwgm33HiJn0J3u9UIgTKo3+t
         jIQwMlkqDzZne3CBQ6/8OYWIIEx5hCKUK/Uy0xf4jAHv8R1XOV1nQxgbr4j3/sYUtnda
         n+vlOPkFHDAlWmhWoBgTHz+v+bGgVOyKnlnJdN0Zw1xJ0MeTgE7fAPuCwnVuWwJiUd11
         S7vVp2ltijKIEhVcL4Y+VaF8vU3nllKyAGtfdzeol5GcaoignRB5gNoeOkYAOEUFZB9e
         PYMg==
X-Forwarded-Encrypted: i=1; AJvYcCUxnwoevzyHpt++LxzUeimThRJDxaAZjkdzq8sno/yNNEsY6apbdizIuCwZZpoSjqf2jO9koH4D5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMFRBqK5xbXMaUeIPVz/qkIHAm6BTh9j1PiyoSg/4aMnth3ur+
	3VBhDsq3IP4rDtMdmelZTV72Mh3d6aBswAP87WYxhU354aHfD076hmgOfMZ7YkTpoMPV2WNctkT
	9FiY8hgPmOsF3e02XSLfHMBI3QqRTqwHwGhmQugCh2sz+ZwCMmwu09usdE8wxww==
X-Gm-Gg: ASbGncvKQwu5n/kcEqKtGOSUN3VA073zOYp6ionzIhBtCo0ck4obVG5hw8EOk/ssMH6
	kQKk2BckIDTPuvptvVwIdqCywjA0upzAHQOg85WvcwCdh3lCRKYem36DzvVPhGC+Vyscfm26MkK
	j9ajuPrx2JnbfFJv3byHfLN7gDcbwKyDhk/HSeqYUu7th17ivctuMth6CLfQHJ7pwHTW7EyZNXM
	A5yGoR5DDJoZHeA+lLJQQqknIE4kmmnj+xjQbGBmdOQcJ3SitVaZdtDNt7vEBNHr6eRCjSQzF5l
	UD4+M8Dfb4U6fCg3x1zdp5bl9I/sE9Ei+BQ+7SQ3RjW5rUp8Ch0dAQMrdyniQRzH56NEWqh0MXt
	i
X-Received: by 2002:a17:90b:3890:b0:338:3156:fc44 with SMTP id 98e67ed59e1d1-33b513758bbmr37056535a91.18.1760503172023;
        Tue, 14 Oct 2025 21:39:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGvgRTzb7knqpzNaPhY0yhlNG4N72VqZ7xUOrGAMsJmJgROcSWjkXAQgsIq6bZw5DGhL979w==
X-Received: by 2002:a17:90b:3890:b0:338:3156:fc44 with SMTP id 98e67ed59e1d1-33b513758bbmr37056487a91.18.1760503171499;
        Tue, 14 Oct 2025 21:39:31 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:39:31 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:21 +0530
Subject: [PATCH v16 06/14] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-6-b98aedaa23ee@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=2577;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=SmkKRQQh3S8Gtdgd1oOIc80Ljvpw2jelYZ428aYXpJY=;
 b=xFWNl2F0ikA8PPaXC182saCjtRr1XUwFnvtiVQhNheBP+zjdeXpRqUdgNHkvYcVkRoh0+o1OY
 5Hbgz914qE4Dyp3XBaHoDUpnGA8R0G/mmiGUlTxticmhUydrCTYhxBU
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: OzjRbvRdrNYnP1OCww9Ehx_A2dNSJgSR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX3DrDVioowERV
 S1ijOuEEHKAhRlSOHbA4sGNN9ASwWy3bUmH7yy8gIHDJ4647ksAlA8vz1+d1qheMBqK7HGaenCt
 Tyhkr61gF01kRUF01NJuuoaYsqe6MLhEaZLPsSCzGflZ/ySht8QMFIKPW0hpYai36pUcwTHIJWm
 6x/TOyWWcOdkQ5NzTKohaW5dgQGp/cpoCzUIIhnQJpQPc/YM5yw6OBPCFKbb7QfT30BAassw7pM
 skxGaXD0CO0ErUHbOsJ/xENC1gjR/tBmohodRpi5dFTdI6+K8hIpsTWLEsOlJyGh1SGkHdSWyZP
 ahka/6Xm8RD53yzKLBayT2KmBqPpGZh340RVzy2MKu4cOTsalNQwzWlYUTbFRqykIMTCC3l7/ti
 hUcfZRXZnyXFVPlO7hS/vLihydgCEg==
X-Proofpoint-GUID: OzjRbvRdrNYnP1OCww9Ehx_A2dNSJgSR
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ef2585 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=UInjrUrXc7y1C1sAkbYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 7360a2849b5bd1e4cbadac533c1a7228573288d4..eca38f8747d320e8371c1dc37cee2287d71821c4 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,27 @@ properties:
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
+          Parameters are named mode-xxx = <type[, cookie]>, where xxx
+          is the name of the magic reboot mode, type is the lower 31 bits
+          of the reset_type, and, optionally, the cookie value. If the cookie
+          is not provided, it is defaulted to zero.
+          The 31st bit (vendor-resets) will be implicitly set by the driver.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
@@ -137,6 +158,15 @@ allOf:
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
 
@@ -261,4 +291,17 @@ examples:
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
+        mode-edl = <0>;
+        mode-bootloader = <1 2>;
+      };
+    };
 ...

-- 
2.34.1


