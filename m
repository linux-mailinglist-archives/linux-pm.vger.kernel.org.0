Return-Path: <linux-pm+bounces-43596-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JNTNt93qGnpugAAu9opvQ
	(envelope-from <linux-pm+bounces-43596-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:20:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 790D02062DA
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F27C631FF8F4
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D643E3D81;
	Wed,  4 Mar 2026 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Da9I29IV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c2xediIL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103F3E123C
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647452; cv=none; b=mweiyXkq4kbw26qs9OGiLbnTcnAC/IMB9JNHeT+GpXNbffkB9XOI5DqlrG7ObN/UqMa2lAn8fBv36Z8SGFuepsGgN/bOMouzZff7MXLadfW3E96fP9YqoI0KnKnUoZG5Yk91jjwLde0lkItaIjUtNYOjMD3kRQmIUTXekPWC/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647452; c=relaxed/simple;
	bh=yBVN4FEHADdTSQ++LEmhmTEyByZ3pz1DEJtf2+BqO1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5hvJWajHZp5KBgIqyMSYKW2sqeEh/YxJoJE1A1MjvIB3nwhTbarAtdi/UNzSCXrLq+SlyWO2MhlI/9nVWRfpTke/L12rSXEKm6noH7FQ72zjZWl6EpvTSsyXzz3o65F89XtwPecwzwVS3a9deFHFcgXKLmLmK0lqNZ04RFmZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Da9I29IV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c2xediIL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624HHg543838944
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 18:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=; b=Da9I29IVMwGbl9Ea
	c72WmDPOX5rt5CF0pF7Ff1EjoIZ/RQpe64bonHHhQxHdNQx4ThPTmq/Xx8Wi5DjI
	KOQXKwbU/zqDIn/38cd1q8wOH8y4BXd4xTrdBbUrnpb55XHTrYfdFZcfaN+K7LLO
	L6ShCmfOASQeQh3/Kn2fZRVsnSq11UOOuGhOZXOP9+D9E7nHZ7ApV1dagKXA010a
	Vv4j+MV9m9sTQRbP4aU2HzO2wqO0TICpddRZ5oDruTm60HgT2fdgnko9uROAaSIF
	U/dgSDQU4ZKesjhP43MSM+lKVyO+us1TWWRzxy5xENAQn+x5qp5NOrqO9cMrVCDc
	Wyvqmg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0m04rg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 18:04:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354490889b6so24387619a91.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772647449; x=1773252249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=;
        b=c2xediILSvnAdd0GcM9ISUl2p5iVmQxeTBHGiNiftBfrXiJqEm0hEE3uCbNfvNPZnh
         4LGr0FEuTTgW+Hkfccxl+X2t6dU7iu4xd9o0pWsp4D4LgVk5ULZcma1xlvn+kdL5Uav7
         oFrw3Z15AUzuGBTj+nPMlsi06MqUwDL8qBENWhY+hizJrYcVW3Xm1ROlRInBpQwuHFvE
         aGscM31tOY3CuZJx6qpm1w3f8SdGoMqxbxTSQjUw2gTOy/CGBMjcKb39c9MJWHjNMnOX
         avhnsBoQ2teNAKcFDZJvSuT1e0YTa4mCY2ohVzsozhHSSMNXxqe6bLzDuROLC+SuUk5T
         JsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647449; x=1773252249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=;
        b=WFF8XHefwEcFtvaUXaxwWVhhDTf8DVSblCtMPIYb4JDzypvRf6RK4rVIIR/rI2hHSb
         hbHx8HtEZwWPp5jt5yXIPtc5/PTEh36dIBJnkfFDDbGVsmjFPyMnnnk4mtKcuwqyPQA7
         nROhOaEFXx6hc7D72r2/VgOE2Y2U/C8MhanPiF+7hHPI5n4cA4idEnmHn1EAjz98sElq
         Rq4XLKgq/GkcP2mM9kHO0v/djINvi5NCLPycYNJb/NbFg780/lv1DqszbVStaSbuD+kS
         bWSISWm0V2GIxBMuXuJXapB4RDFXhUNfANhszxW2Sox2lTDf6zvwljDhRb2BBPUohDED
         vbhw==
X-Forwarded-Encrypted: i=1; AJvYcCWlYZj6wX3umoijpaysloD1rtQoG2cimiTWJnEDLS6RrV+fwHruF50suXpqQwUixzO4FlIDOSylVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7v7RVtG81+E7P1vXTpLxK8NG81aiHNFP/HxMx7M7CKfag+bQO
	LHLJM6kc8UxNTCfOenkXOPeeD3HMdEJD1i+Ww2aIHqtu+y2l6MexUJ+PAGAVlCwXtRlSKLt74pg
	oDEBevOORtVLczV8si3dh/wYya0UObdjW1NVBqmVj/ijyYBd8I8fXZagOLt07vpYn8tBcKg==
X-Gm-Gg: ATEYQzz4xfRfr+IG1x9LY4UFjw/3L62TvEzvixHFckgeFhgbIkLWv6DXp5hLXO+PqeR
	+WKlPlDX6eXW8Sk1vKdDYv6M7Fz5W7bPz1C4jtG0k+u8ZA02jJAOmOnZz1YnreRhRpYyBQt6fpK
	UuTbenkFSNroCpmXfHVEp2nDzJ3OlHQUs2/KSqA/VE63r82XkXFz9acjJmZCfQjHQFvhMBJpMu6
	TIeqdbVBLs2NcbSAjz+Ef3kxmNOChI0Hs/9jlysLX/Rd2e/oJn8B4vfEeu3POCxWrYq2SwPq+A0
	RS4FAl/KWmIat5owE6wuxDsQaCnuGYJqpK2/XLSfhDGJcvjzCdcp31Gj8rlIKa60cb6Ak0Coccs
	Ezp8Y58Qd8ZYE2513jQK1/xIeuIArjw6PgvnbTAAItw5h6On272AcV5HJUA==
X-Received: by 2002:a17:90a:d604:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-359a6a661c2mr2569416a91.23.1772647449527;
        Wed, 04 Mar 2026 10:04:09 -0800 (PST)
X-Received: by 2002:a17:90a:d604:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-359a6a661c2mr2569368a91.23.1772647449023;
        Wed, 04 Mar 2026 10:04:09 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8f22062sm1080606a91.1.2026.03.04.10.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:04:08 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 23:33:05 +0530
Subject: [PATCH v20 05/10] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-arm-psci-system_reset2-vendor-reboots-v20-5-cf7d346b8372@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772647398; l=2477;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=yBVN4FEHADdTSQ++LEmhmTEyByZ3pz1DEJtf2+BqO1w=;
 b=OZx6ByiWkGv3E+6If5hWQp0cKX8PXq1wNtaOeIuzjnr5JeFhAImHn/a0+xFkU8UG/ps5TFj2n
 9Jc3aA3+ZH0BjMvyvVjj4Darm9xBnR8dtDsVx+MXkx4rc34mEfbRabt
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=e6wLiKp/ c=1 sm=1 tr=0 ts=69a8741a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Z1E3qa2j_4PWJv3PNLYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 84weRdbNmB0aZmyY208gXDdgJVn3EF7Z
X-Proofpoint-GUID: 84weRdbNmB0aZmyY208gXDdgJVn3EF7Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE0NyBTYWx0ZWRfX5iMXushFrKsE
 ZQXPkF6e9u5nQr9qX2BoDoqJEQ/YvJStWi1vNPEONtBi3JoB7xkD74qO1HAlcQ13ndb8dSgis3v
 sJCdhNksJ6LqTzqd0NowgWeynRaFCmwYEtJlJtRKmP5yI+LWE2TX8Dvipq7mS9kIClSqTljPIpE
 Gl+dYmE2DrFa185348nZen4IvTcaMrl04hwYNKcjwvIww53/M7GH7LOGynUJTI/Y0JzkIT8ziHc
 lxUFi57C8kckVdEFWEwF8wKHIGOP117AsSDGzAUwmSm+Bhd1I70EJNw9IA4y0kVX2qCtNzuxmSw
 tWH/UnbCSpXRxJh0q38mUadO5Le7Y1w7qieVK3cZ8LGZc6wMqQruTTNKuUCIm6pO0EjfBEr3F3G
 eYfqoxshz7uMP+rMIWnT08R9G+xQty/osF5IWg2r25ldEPSqGRcEISAJ7ZRS3SJo9bHH4CuFLUD
 wtWKZ9jFi1i3Ik4watA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040147
X-Rspamd-Queue-Id: 790D02062DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43596-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,arndb.de,arm.com,rock-chips.com,gmail.com,linaro.org,ettus.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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


