Return-Path: <linux-pm+bounces-35161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22228B91755
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 15:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA4A3BDF78
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7D130E848;
	Mon, 22 Sep 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDd//0gJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26430F538
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548489; cv=none; b=rSj89LY9dQJ6blvajZl7pCWXQFYsdyHbv1qCYGTDLy5UAPcx211eGMyO3FRgtXy7gwzeXCc1khh0tOAChsDpb3vQJttdlX4lE0z9oJegAp+ykwOgbwEde5c+UITgWXzDJX+ayarYh6SESjP3BU6QMDxDhLtlLaY/qxPeGJJJCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548489; c=relaxed/simple;
	bh=R3BNXlzor3OWM1UHW0bocrQrgSVBuB1WLn0clYEcPVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IsKomaqFYOXByvmBbJorJPUDC2QEOJfQVHCRo45CQn+nFkzMrdgzLkI4GU5UO5dcM0OcIDMZxfkzaJy1Y6Rbc4N+K/hjCrblDBmXTdK/0DY6Ccc/oyynCCY6QGeUqK5CLA5216cMap9DxWz/KeSp/PAB6X6lbZBE6+5uyp7l0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDd//0gJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7p4Td005685
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=; b=dDd//0gJ0/kkvliw
	mQcChpU452MYo9eFEYDB4MkQikrDUyije6EDRTXHpDzBryE6UemVVLWWHC6Zk/Ik
	aoFcDATml5Tnkf8OaRMkOLnvowbPSNqnxSmvIpPRJxX1yrew29jXlRmTK2hUy3r8
	A6wslEqZmER6TqBxsw/5U3eccEWNotIyqkEE0SFUAUcqqVuPkaBqiL346YnTF1z8
	zUwPIbQkFkK+KkemjwD9NX935aYLW77H5j7PDyZfw3WFDTLIVtsNkxmt9aUc0Ydb
	EHtM1m6xiraiXtM5uHUqQVj+hi3sQniKfPfIJdcNCIkEM4smVUikYu/jJZoltGwr
	OofuhQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b2e112s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:41:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24456ebed7bso54335665ad.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 06:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548486; x=1759153286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=;
        b=odRRHeviUnjzGuETVjby6g4cQCE4Bp/djrFzpGMp73Zdp7jbwxlbdUohbeh9676V08
         xZsu3JE1xrwUmovxmZLxC1W9jcHXYV1zTkxmDYR+u+hqSQ/WL3eySNunRWAX3F3r9qAr
         Am+aEdjh5OxCs2cDJhvW6VVsRp9YXfQAlVjmT9AX4fCUefBZz0RbqVHCgNOkLjI5v3lC
         QzDOVfBTt/aGoymDFP7ju2k7TL84VsVVlrKdub1EFRbFPiOccLtaay1PYcEQLyMhhVlP
         KZxyYR0khNQp6v2br6aVuiby5QTi+Q7lfT8IvoyqO9aQ8Cgqzaa3QtkTgHLaoWzRh8S0
         jXhg==
X-Forwarded-Encrypted: i=1; AJvYcCUkMNRt9uJjNVXUloYY/bF8VJ0QqZ/L9YKxp6EagzEyu3sM0ze8KewqyYHhVMPkKvA4OXihUK62OA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wEb+izgMZPxQsDkZKAs0nTy0zj5P3rLW3oTcK6WoHuGY97On
	U0rl/vpuG0Pq7FtRh9e7rOhpEbBj1ieDkxeAC8v5IzD2FxRlvRP+JJUpVv/hkY6+eRZ53kNVMB4
	w419iyXn4IfcbMDS8NPYvansKI+k5s5vx+1Wgy5dC7hwUjN4/LBfSjUWfIpdJHg==
X-Gm-Gg: ASbGncsUCRZu8TUbDjJPGPkxxY16iJqyM8KeJvWROjINNTOiS+l8vxJqaGm/ete/hPD
	TXGQ35awL7UlNzJUPkjCWYpCDnYnL+gfAVx2lgFFeJJ0fp2xfZbJ9TbiINpB7qulruUE+cvbpVR
	2M6VYW1Wbe014sOKkUMmkbEM08I2nlxuiw7omceEgkXW8rRr9U5yAnW7PNfsCN4jqiVjjIIo42F
	MS5HP8YXsDowAvEUliwQDi3uW1wPHeKpwsOll4b7AO3tuTQy6wQpgXsIVoLnNaRZkHarMefFf/o
	SnkOZiF4Mfu0ADJcbRVUmMlusX1asJuHOykdlkrqMTAqPBt22p4bL3vzsuyib3qQQ3Uqlfsc065
	w
X-Received: by 2002:a17:903:18e:b0:26e:7ac9:9d3 with SMTP id d9443c01a7336-26e7ac90c41mr134693555ad.18.1758548486349;
        Mon, 22 Sep 2025 06:41:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECJWJDojyXBjsBbEa7hEjwrxc9WYv0/zCgrWii3r2CuVqCDvWfZmFkwNzUJptObbkGXcARkQ==
X-Received: by 2002:a17:903:18e:b0:26e:7ac9:9d3 with SMTP id d9443c01a7336-26e7ac90c41mr134693005ad.18.1758548485876;
        Mon, 22 Sep 2025 06:41:25 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:41:25 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:16 +0530
Subject: [PATCH v15 06/14] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-6-7ce3a08878f1@oss.qualcomm.com>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=2577;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=SmkKRQQh3S8Gtdgd1oOIc80Ljvpw2jelYZ428aYXpJY=;
 b=vLj0922EjIbkbMbR+tqY47qh1UHzIiJOZnJu5uAsC3pDrEZ1BMq1hZ/Sen1hgB2OFsr79Qcsn
 2BVNWRyGH7vC6AoW944ox7b2Qjq1qN+eQL7hQ/x1SwnmHchfyFmBDQD
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA3NiBTYWx0ZWRfXy+HvIeJVwdYj
 yd3c2P83x9DLO2ZMDy0hn0MNBnZC5mQbceAghckX4IgqWbtk6cUofP23mwjjKGU5CT/IyyaBtfh
 geaVNk+8DikRkbZW4Atb/0CrzBsc8N/5QfZjfxB0/5fJAufuvHouu2Hq5XnkrEOvwdyJJF3z1dR
 o58C9/oQ0doEZ9CrN81ONo9ZsV3qqkfUusDLGcP8F+ftRF3S6PC0UjzePeeY80HZKf5vR1jzcBn
 BOW8c//eyP55nWkKkKF4IpLomRqJv2Gkd1VfLOwbFZwXxXeOEJ2r69RxQYg0FF0LxBcWygx7GFJ
 1vXktqfJExz63XB8yAMrcl2k1r2yZrCleETKa+mfW6oZB7M06Jol9BtgSUaI9uFDuWCPAb6zP5M
 VXorRufi
X-Proofpoint-ORIG-GUID: vQ8RXAK4aBNQHYXuSOUY2YZ6RxO-Dfnr
X-Authority-Analysis: v=2.4 cv=HM7DFptv c=1 sm=1 tr=0 ts=68d15207 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=UInjrUrXc7y1C1sAkbYA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: vQ8RXAK4aBNQHYXuSOUY2YZ6RxO-Dfnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220076

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


